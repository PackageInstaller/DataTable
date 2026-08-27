local activity_general_jump = {
  [24003] = {
    {
      activity_id = 24003,
      close_time = 1691049599,
      jumpArgs = {701},
      jump_id = 105,
      jump_res = "MusicFes23/UI_MusicFes23LotteryBG"
    }
  },
  [33001] = {
    {
      jumpArgs = {1201},
      jump_res = "Carnival23/UI_Carnival23BpBG"
    },
    {
      id = 2,
      jumpArgs = {0, 6},
      jump_id = 108
    }
  },
  [33002] = {
    {
      activity_id = 33002,
      close_time = 1716451199,
      jumpArgs = {0, 12},
      jump_id = 108
    }
  },
  [33003] = {
    {
      activity_id = 33003,
      close_time = 1695283199,
      jumpArgs = {1202},
      jump_res = "Summer23/UI_Summer23BpBG"
    },
    {
      activity_id = 33003,
      close_time = 1695283199,
      id = 2,
      jumpArgs = {109},
      jump_id = 108,
      jump_res = "Summer23/UI_Summer23LotteryBG"
    }
  },
  [33004] = {
    {
      activity_id = 33004,
      close_time = 1721289599,
      jumpArgs = {163},
      jump_id = 108,
      jump_res = "Summer23/UI_Summer23LotteryBG"
    }
  },
  [33005] = {
    {
      activity_id = 33005,
      close_time = 1726127999,
      jumpArgs = {171},
      jump_id = 108,
      jump_res = "Summer24/UI_Summer24LotteryBG"
    },
    {
      activity_id = 33005,
      close_time = 1726732799,
      id = 2,
      jumpArgs = {58001},
      jump_res = "Summer24/UI_DeliveryActJumpBG"
    }
  },
  [40001] = {
    {
      activity_id = 40001,
      close_time = 1698307199,
      jumpArgs = {1203},
      jump_res = "Anniversary23/UI_Anniversary23BpBG"
    },
    {
      activity_id = 40001,
      close_time = 1696492799,
      id = 2,
      jumpArgs = {41001},
      jump_res = "Anniversary23/UI_Anniversary23FlipCardBG"
    }
  },
  [40002] = {
    {
      activity_id = 40002,
      close_time = 1709798399,
      jumpArgs = {1204},
      jump_res = "Winter24/UI_Winter24BpBG",
      open_time = 1706774400
    },
    {
      activity_id = 40002,
      close_time = 1709193599,
      id = 2,
      jumpArgs = {51001},
      jump_res = "Winter24/UI_Winter24ActJumpBG"
    }
  },
  [45001] = {
    {
      activity_id = 45001,
      close_time = 1706169599,
      jumpArgs = {0, 9},
      jump_id = 108,
      jump_res = "SteinsGate/UI_SteinsGate23LotteryKurisu"
    },
    {
      activity_id = 45001,
      close_time = 1706169599,
      id = 2,
      jump_id = 108,
      jump_res = "SteinsGate/UI_SteinsGate23LotteryMayuri"
    }
  },
  [51001] = {
    {
      activity_id = 51001,
      close_time = 1709798399,
      jumpArgs = {40002},
      jump_res = "Spring24/UI_Spring24ActJumpBG"
    },
    {
      activity_id = 51001,
      close_time = 1709193599,
      id = 2,
      jumpArgs = {44003},
      jump_res = "Spring24/UI_Spring24GiftBG"
    }
  },
  [56001] = {
    {
      activity_id = 56001,
      close_time = 1719475199,
      jumpArgs = {1205},
      jump_res = "Carnival24/UI_Carnival24BpBG",
      open_time = 1716451200
    },
    {
      activity_id = 56001,
      close_time = 1718870399,
      id = 2,
      jumpArgs = {0, 13},
      jump_id = 108,
      jump_res = "Carnival24/UI_Carnival24LotteryBG"
    }
  },
  [59001] = {
    {
      activity_id = 59001,
      close_time = 1729151999,
      jumpArgs = {1206},
      jump_res = "Anniversary24/UI_Anniversary24BpBG"
    },
    {
      activity_id = 59001,
      close_time = 1728547199,
      id = 2,
      jumpArgs = {0, 15},
      jump_id = 108,
      jump_res = "Anniversary24/UI_Anniversary24LotteryBG"
    }
  }
}
local __default_values = {
  activity_id = 33001,
  close_time = 1690531199,
  id = 1,
  jumpArgs = {0, 10},
  jump_id = 109,
  jump_res = "Carnival23/UI_Carnival23LotteryBG",
  open_time = -1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_general_jump) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_general_jump, {__index = __rawdata})
return activity_general_jump
