local __rt_1 = {
  38,
  242,
  64
}
local __rt_2 = {
  78,
  185,
  230
}
local __rt_3 = {
  230,
  123,
  78
}
local __rt_4 = {
  202,
  230,
  78
}
local warchess_event_pic = {
  {
    color = {
      233,
      142,
      11
    },
    icon = "ICON_Room_boss",
    title = 399082
  },
  {
    color = __rt_1,
    id = 2,
    title = 108362
  },
  {
    color = {
      255,
      255,
      255
    },
    icon = "ICON_Room_enemy",
    id = 3,
    title = 165461
  },
  {
    color = {
      231,
      199,
      88
    },
    icon = "ICON_Room_item",
    id = 4,
    title = 248668
  },
  {
    color = __rt_2,
    icon = "ICON_Room_store",
    id = 5,
    title = 386204
  },
  {
    color = {
      248,
      105,
      220
    },
    icon = "ICON_Room_elite",
    id = 6,
    title = 155560
  },
  {
    color = {
      155,
      56,
      227
    },
    icon = "ICON_Room_challenge",
    id = 7,
    title = 4302
  },
  {
    icon = "ICON_Room_event",
    id = 8,
    title = 276001
  },
  {
    color = __rt_4,
    icon = "ICON_Room_recoveIry",
    id = 9
  },
  {
    color = {
      61,
      180,
      168
    },
    icon = "ICON_Room_chip",
    id = 10,
    title = 346090
  },
  {
    color = {
      204,
      86,
      70
    },
    icon = "ICON_Room_spevent",
    id = 11,
    title = 193455
  },
  {
    color = __rt_2,
    icon = "ICON_Room_assist",
    id = 12,
    title = 5100
  },
  {
    color = __rt_4,
    icon = "ICON_Room_recoveIry",
    id = 13
  },
  {
    icon = "ICON_Room_story",
    id = 14,
    title = 236566
  },
  {
    color = {
      128,
      59,
      176
    },
    icon = "ICON_Room_construction",
    id = 15,
    title = 781
  },
  {
    color = {
      60,
      161,
      255
    },
    icon = "ICON_Room_GreenAssist",
    id = 16,
    title = 144798
  },
  {
    icon = "ICON_Room_BottleHalloween22",
    id = 17,
    title = 149793
  },
  {
    icon = "ICON_Room_BottleChristmas22",
    id = 18,
    title = 448058
  },
  [100] = {
    color = __rt_1,
    id = 100,
    title = 278851
  }
}
local __default_values = {
  color = __rt_3,
  icon = "ICON_Room_empty",
  id = 1,
  title = 482816
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(warchess_event_pic) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(warchess_event_pic, {__index = __rawdata})
return warchess_event_pic
