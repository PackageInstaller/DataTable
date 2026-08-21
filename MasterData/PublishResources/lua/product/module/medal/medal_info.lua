local MedalErrorType = {
  E_MEDAL_ERROR_TYPE_SUCCESS = 0,
  E_MEDAL_ERROR_TYPE_FAILURE = 1,
  E_MEDAL_LOAD_ERROR = 2,
  E_MEDAL_SAVE_ERROR = 3,
  E_MEDAL_ERROR_UNLOCK = 4,
  E_MEDAL_ERROR_ITEM_ID = 5,
  E_MEDAL_ERROR_NOT_FINISH = 6,
  E_MEDAL_ERROR_ITEM_EXIST = 7,
  E_MEDAL_ERROR_MEDAL_COUNT_BREAK_LIMIT = 8
}
_enum("MedalErrorType", MedalErrorType)
local RewardStatus = {
  E_MEDAL_REWARD_FUNCTION_LOCK = 0,
  E_MEDAL_REWARD_LOCK = 1,
  E_MEDAL_REWARD_CAN_RECV = 2,
  E_MEDAL_REWARD_RECVED = 3
}
_enum("RewardStatus", RewardStatus)
_class("medal_position", Object)
medal_position = medal_position

function medal_position:Constructor()
  self.x = 0
  self.y = 0
  self.z = 0
  self.w = 0
  self.h = 0
  self.quatx = 0
  self.quaty = 0
  self.quatz = 0
  self.quatw = 0
end

medal_position._proto = {
  [1] = {"x", "float"},
  [2] = {"y", "float"},
  [3] = {"z", "float"},
  [4] = {"w", "float"},
  [5] = {"h", "float"},
  [6] = {"quatx", "float"},
  [7] = {"quaty", "float"},
  [8] = {"quatz", "float"},
  [9] = {"quatw", "float"}
}
_class("medal_placement_info", Object)
medal_placement_info = medal_placement_info

function medal_placement_info:Constructor()
  self.board_back_id = 0
  self.medal_on_board = {}
end

medal_placement_info._proto = {
  [1] = {
    "board_back_id",
    "int"
  },
  [2] = {
    "medal_on_board",
    "map<int,medal_position>"
  }
}
_class("client_medal", Object)
client_medal = client_medal

function client_medal:Constructor()
  self.medal_id = 0
  self.medal_type = 0
  self.status = 0
  self.cur_progress = 0
  self.total_progress = 0
  self.condition_type = 0
end

client_medal._proto = {
  [1] = {"medal_id", "int"},
  [2] = {"medal_type", "int"},
  [3] = {"status", "int"},
  [4] = {
    "cur_progress",
    "int"
  },
  [5] = {
    "total_progress",
    "int"
  },
  [6] = {
    "condition_type",
    "int"
  }
}
_class("client_medal_sys_info", Object)
client_medal_sys_info = client_medal_sys_info

function client_medal_sys_info:Constructor()
  self.client_medal_info = {}
  self.client_medal_board_info = {}
  self.medal_board = medal_placement_info:New()
end

client_medal_sys_info._proto = {
  [1] = {
    "client_medal_info",
    "list<client_medal>"
  },
  [2] = {
    "client_medal_board_info",
    "list<client_medal>"
  },
  [3] = {
    "medal_board",
    "medal_placement_info"
  }
}
_class("all_medal_data", Object)
all_medal_data = all_medal_data

function all_medal_data:Constructor()
  self.data = {}
  self.medal_board = medal_placement_info:New()
end

all_medal_data._proto = {
  [1] = {
    "data",
    "list<client_medal>"
  },
  [2] = {
    "medal_board",
    "medal_placement_info"
  }
}
