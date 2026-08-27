local act_general_repeat_dg = {
  [45001] = {
    [49001] = {
      drop_show = {
        [1087] = {max = 45, min = 35}
      },
      level_des = 225120,
      level_name = 473670
    },
    [49002] = {
      dungeon_id = 49002,
      level_des = 466248,
      level_name = 73282,
      level_num = "TR-2",
      pre_desc = 143963
    },
    [49003] = {
      drop_show = {
        [1087] = {max = 155, min = 130}
      },
      dungeon_id = 49003,
      level_des = 519557,
      level_name = 517902,
      level_num = "TR-3",
      pre_desc = 273935
    },
    [49004] = {
      drop_show = {
        [1087] = {max = 220, min = 180}
      },
      dungeon_id = 49004,
      level_des = 167818,
      level_num = "TR-4",
      pre_desc = 517427
    },
    [49005] = {
      drop_show = {
        [1087] = {max = 280, min = 240}
      },
      dungeon_id = 49005,
      level_name = 33576,
      level_num = "TR-5",
      pre_desc = 414893
    }
  }
}
local __default_values = {
  act_id = 45001,
  drop_show = {
    [1087] = {max = 100, min = 80}
  },
  dungeon_id = 49001,
  level_des = 110721,
  level_icon = "SStageBoss",
  level_name = 169196,
  level_name_en = "Training",
  level_num = "TR-1",
  level_pic = "steinsgate23_tr",
  pre_desc = ""
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(act_general_repeat_dg) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {
  __basemetatable = base,
  level_list_dic = {
    [45001] = {
      49001,
      49002,
      49003,
      49004,
      49005
    }
  }
}
setmetatable(act_general_repeat_dg, {__index = __rawdata})
return act_general_repeat_dg
