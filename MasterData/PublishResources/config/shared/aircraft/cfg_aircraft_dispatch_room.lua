local key = {
  ID = 1,
  DispatchMax = 2,
  OneSpeed = 3,
  TeamMax = 4,
  CCRCfgId = 5,
  MaxTaskStar = 6,
  RefreshTaskId = 7,
  UpgradeRefreshTaskDes = 8,
  DegradeRefreshTaskDes = 9
}
local config = {
  [7110001] = {
    7110001,
    5,
    32400,
    2,
    635010,
    5,
    1,
    "str_dispatch_room_level_up_refreshtask_tips1",
    "str_dispatch_room_level_down_refreshtask_tips1"
  },
  [7110002] = {
    7110002,
    6,
    32400,
    3,
    635020,
    5,
    2,
    "str_dispatch_room_level_up_refreshtask_tips2",
    "str_dispatch_room_level_down_refreshtask_tips2"
  },
  [7110003] = {
    7110003,
    7,
    32400,
    3,
    635030,
    5,
    3,
    "str_dispatch_room_level_up_refreshtask_tips3",
    "str_dispatch_room_level_down_refreshtask_tips3"
  },
  [7110004] = {
    7110004,
    8,
    32400,
    4,
    635040,
    6,
    4,
    "str_dispatch_room_level_up_refreshtask_tips4",
    "str_dispatch_room_level_down_refreshtask_tips4"
  },
  [7110005] = {
    7110005,
    9,
    32400,
    4,
    635050,
    6,
    5,
    "str_dispatch_room_level_up_refreshtask_tips5",
    "str_dispatch_room_level_down_refreshtask_tips5"
  }
}
return config, "ID", key
