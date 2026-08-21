local DungeonType = {
  DungeonType_Coin = 1,
  DungeonType_Experience = 2,
  DungeonType_AircraftMaterial = 3,
  DungeonType_equip = 4,
  DungeonType_Max = 5
}
_enum("DungeonType", DungeonType)
local DungeonSubType = {
  DungeonSubType_Blue = 1,
  DungeonSubType_Red = 2,
  DungeonSubType_Green = 3,
  DungeonSubType_Yellow = 4
}
_enum("DungeonSubType", DungeonSubType)
local OpenStatus = {
  Dungeon_ReturnError = -2,
  Dungeon_StatusError = -1,
  Dungeon_OpenToday = 1,
  Dungeon_CloseToday = 2,
  Dungeon_EntryLocked = 3
}
_enum("OpenStatus", OpenStatus)
_class("dungeon_all_data", Object)
dungeon_all_data = dungeon_all_data

function dungeon_all_data:Constructor()
  self.pstid = 0
  self.all_instance = {}
  self.open_status = {}
  self.passed_instance = {}
  self.double_res_state = false
end

dungeon_all_data._proto = {
  [1] = {"pstid", "int64"},
  [2] = {
    "all_instance",
    "map<int,list<int>>"
  },
  [3] = {
    "open_status",
    "map<int,int>"
  },
  [4] = {
    "passed_instance",
    "list<int>"
  },
  [5] = {
    "double_res_state",
    "bool"
  }
}
_class("AlreadyReturnedPowerDungeon", Object)
AlreadyReturnedPowerDungeon = AlreadyReturnedPowerDungeon

function AlreadyReturnedPowerDungeon:Constructor()
  self.returned_ids = {}
end

AlreadyReturnedPowerDungeon._proto = {
  [1] = {
    "returned_ids",
    "list<int>"
  }
}
