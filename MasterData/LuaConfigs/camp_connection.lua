local camp_connection = {
  {
    [3] = {
      event_buff_id = 1004,
      icon = "camp_1_2",
      name = 77587,
      text = 371635
    },
    [4] = {
      cool_down_param = 1,
      cool_down_type = 3,
      event_buff_id = 1003,
      fetters_num = 4,
      is_active = 2,
      name = 245320,
      text = 425582
    },
    [5] = {
      cool_down_param = 5,
      cool_down_type = 3,
      fetters_num = 5,
      icon = "camp_1_3",
      is_active = 2,
      is_show_active = 1,
      name = 337483,
      text = 462267
    }
  },
  {
    [3] = {
      event_buff_id = 1001,
      icon = "camp_2_1",
      name = 22012,
      text = 86809
    },
    [4] = {
      event_buff_id = 1002,
      fetters_num = 4,
      icon = "camp_2_2",
      text = 284035
    },
    [5] = {
      cool_down_param = 1,
      cool_down_type = 1,
      event_buff_id = 1011,
      fetters_num = 5,
      icon = "camp_2_3",
      is_active = 1,
      is_show_active = 1,
      name = 379552,
      text = 373313
    }
  },
  {
    [3] = {
      event_buff_id = 1005,
      icon = "camp_3_1",
      name = 411317,
      text = 311975
    },
    [4] = {
      event_buff_id = 1006,
      fetters_num = 4,
      icon = "camp_3_2",
      name = 350219,
      text = 509201
    },
    [5] = {
      cool_down_param = 1,
      cool_down_type = 2,
      event_buff_id = 1013,
      fetters_num = 5,
      icon = "camp_3_3",
      is_active = 3,
      is_show_active = 1,
      name = 25061
    }
  },
  {
    [3] = {
      event_buff_id = 1007,
      icon = "camp_4_1",
      name = 126400,
      text = 54016
    },
    [4] = {
      event_buff_id = 1008,
      fetters_num = 4,
      icon = "camp_4_2",
      name = 433910,
      text = 62863
    },
    [5] = {
      cool_down_param = 1,
      cool_down_type = 2,
      fetters_num = 5,
      icon = "camp_4_3",
      is_active = 4,
      is_show_active = 1,
      name = 401651,
      text = 419015
    }
  },
  {
    [3] = {
      event_buff_id = 1009,
      icon = "camp_5_1",
      name = 196236,
      text = 408800
    },
    [4] = {
      event_buff_id = 1010,
      fetters_num = 4,
      icon = "camp_5_2",
      name = 347244,
      text = 214029
    },
    [5] = {
      cool_down_param = 1,
      cool_down_type = 1,
      event_buff_id = 1012,
      fetters_num = 5,
      icon = "camp_5_3",
      is_active = 5,
      is_show_active = 1,
      name = 283477,
      text = 430947
    }
  }
}
local __default_values = {
  cool_down_param = 0,
  cool_down_type = 0,
  event_buff_id = 0,
  fetters_num = 3,
  icon = "camp_1_1",
  is_active = 0,
  is_show_active = 0,
  name = 11137,
  text = 130500
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(camp_connection) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {
  __basemetatable = base,
  fetterList = {
    {
      3,
      4,
      5
    },
    {
      3,
      4,
      5
    },
    {
      3,
      4,
      5
    },
    {
      3,
      4,
      5
    },
    {
      3,
      4,
      5
    }
  },
  maxFetterDic = {
    5,
    5,
    5,
    5,
    5
  }
}
setmetatable(camp_connection, {__index = __rawdata})
return camp_connection
