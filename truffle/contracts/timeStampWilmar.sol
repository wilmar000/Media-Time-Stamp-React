pragma solidity ^0.6.2;

contract TimeStamp {
    struct Record{
        uint hash;
        address owner;
        string description;
        string link;
        uint date;
        bool valid;
    }

    mapping(address => mapping(uint => Record)) userRecords;

    address manager = msg.sender;
    
    function saveRecord(uint _hash, string memory _description, string memory _link) public {
        require(!userRecords[msg.sender][_hash].valid == true, "this record alredy exist or it is invalid");
        userRecords[msg.sender][_hash] = Record(_hash, msg.sender, _description, _link, block.timestamp, true);
    } 
    
    function getRecordByUser(address _owner, uint _hash) public view returns (uint, address, string memory, string memory, uint, bool) {
    return(
    userRecords[_owner][_hash].hash,
    userRecords[_owner][_hash].owner,
    userRecords[_owner][_hash].description,
    userRecords[_owner][_hash].link,
    userRecords[_owner][_hash].date,
    userRecords[_owner][_hash].valid);
    }
    
    function modifyRecordByManager(address _pastOwner, address _newOwner, uint _hash, string memory _description, string memory _link, bool _valid) public {
        require(msg.sender == manager);
        userRecords[_pastOwner][_hash] = userRecords[_newOwner][_hash];
        userRecords[_newOwner][_hash] = Record(_hash, _newOwner, _description, _link, block.timestamp, _valid);
    } 
    }
