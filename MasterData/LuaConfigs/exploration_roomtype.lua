local __rt_1 = {
  1.0,
  1.0,
  1.0
}
local __rt_2 = {
  0.149,
  0.949,
  0.251
}
local __rt_3 = {
  0.3059,
  0.7255,
  0.902
}
local __rt_4 = {
  0.902,
  0.4824,
  0.3059
}
local __rt_5 = {
  0.7922,
  0.902,
  0.3059
}
local exploration_roomtype = {
  {
    color = {
      0.9137,
      0.5569,
      0.0431
    },
    icon = "ICON_Room_boss",
    id = 1,
    priority = 2,
    progress_show_Icon = true,
    real_logic = 1,
    title = 399082
  },
  {
    id = 2,
    priority = 11,
    real_logic = 0,
    title = 108362
  },
  {
    color = __rt_1,
    icon = "ICON_Room_enemy",
    id = 3,
    priority = 9,
    real_logic = 1,
    title = 165461
  },
  {
    color = {
      0.9059,
      0.7804,
      0.3451
    },
    icon = "ICON_Room_item",
    id = 4,
    priority = 4,
    real_logic = 4,
    title = 248668
  },
  {
    color = __rt_3,
    icon = "ICON_Room_store",
    id = 5,
    priority = 8,
    real_logic = 3,
    title = 386204
  },
  {
    color = {
      0.9725,
      0.4118,
      0.8627
    },
    icon = "ICON_Room_elite",
    id = 6,
    priority = 6,
    progress_show_Icon = true,
    real_logic = 1,
    title = 155560
  },
  {
    color = {
      0.6078,
      0.2196,
      0.8902
    },
    icon = "ICON_Room_challenge",
    id = 7,
    priority = 7,
    real_logic = 1,
    title = 4302
  },
  {
    color = __rt_4,
    icon = "ICON_Room_event",
    id = 8,
    title = 276001
  },
  {
    color = __rt_5,
    icon = "ICON_Room_recoveIry",
    id = 9,
    priority = 3,
    progress_show_Icon = true
  },
  {
    color = {
      0.2392,
      0.7059,
      0.6588
    },
    icon = "ICON_Room_chip",
    id = 10,
    priority = 10,
    real_logic = 2,
    title = 346090
  },
  {
    color = {
      0.8,
      0.3373,
      0.2745
    },
    icon = "ICON_Room_spevent",
    id = 11,
    title = 193455
  },
  {
    color = __rt_3,
    icon = "ICON_Room_assist",
    id = 12,
    title = 5100
  },
  {
    color = __rt_5,
    icon = "ICON_Room_recoveIry",
    id = 13,
    priority = 3,
    progress_show_Icon = true
  },
  {
    color = __rt_4,
    icon = "ICON_Room_story",
    id = 14,
    priority = 10,
    real_logic = 6,
    title = 236566
  },
  {
    color = {
      0.502,
      0.2314,
      0.6902
    },
    icon = "ICON_Room_construction",
    id = 15,
    title = 781
  },
  {
    color = {
      0.2353,
      0.6314,
      1.0
    },
    icon = "ICON_Room_GreenAssist",
    id = 16,
    title = 144798
  },
  {
    color = {
      0.9529,
      0.6078,
      0.6627
    },
    icon = "ICON_Room_spbattle",
    id = 17,
    priority = 6,
    progress_show_Icon = true,
    real_logic = 1,
    title = 322115
  },
  {
    color = {
      0.8235,
      0.5804,
      0.9725
    },
    icon = "ICON_Room_curse",
    id = 18,
    priority = 3,
    title = 427478
  },
  {
    color = {
      1.0,
      0.8118,
      0.4078
    },
    icon = "ICON_Room_market",
    id = 19,
    priority = 3,
    title = 377898
  },
  [0] = {
    color = __rt_1,
    icon = "ICON_Room_start",
    priority = 1,
    real_logic = 0,
    title = 407683
  },
  [100] = {
    id = 100,
    priority = 100,
    real_logic = 0,
    title = 217277
  }
}
local __default_values = {
  color = __rt_2,
  icon = "ICON_Room_empty",
  id = 0,
  priority = 5,
  progress_show_Icon = false,
  real_logic = 5,
  title = 482816
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(exploration_roomtype) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(exploration_roomtype, {__index = __rawdata})
return exploration_roomtype
