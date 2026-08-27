local activity_card_normal_round = {
  {
    {hope_value = 1150, is_turns = false},
    {
      hope_value = 1150,
      is_turns = false,
      round_id = 2
    },
    {
      hope_value = 1240,
      is_turns = false,
      round_id = 3
    },
    {is_turns = false, round_id = 4},
    {is_turns = false, round_id = 5},
    {is_turns = false, round_id = 6},
    {
      hope_value = 1330,
      is_turns = false,
      round_id = 7
    },
    {is_turns = false, round_id = 8},
    {hope_value = 1330, round_id = 9},
    {hope_value = 1330, round_id = 10},
    {is_turns = false, round_id = 11},
    {is_turns = false, round_id = 12},
    {round_id = 13},
    {hope_value = 1360, round_id = 14},
    {hope_value = 1360, round_id = 15},
    {hope_value = 1360, round_id = 16}
  },
  {
    {
      hope_value = 400,
      id = 2,
      is_turns = false
    },
    {
      hope_value = 440,
      id = 2,
      is_turns = false,
      round_id = 2
    },
    {
      hope_value = 500,
      id = 2,
      is_turns = false,
      round_id = 3
    },
    {
      hope_value = 600,
      id = 2,
      is_turns = false,
      round_id = 4
    },
    {
      hope_value = 600,
      id = 2,
      is_turns = false,
      round_id = 5
    },
    {
      hope_value = 650,
      icon_id = 1,
      id = 2,
      is_turns = false,
      round_id = 6
    },
    {
      hope_value = 700,
      id = 2,
      is_turns = false,
      round_id = 7
    },
    {
      hope_value = 700,
      id = 2,
      is_turns = false,
      round_id = 8
    },
    {
      hope_value = 700,
      icon_id = 2,
      id = 2,
      round_id = 9
    },
    {
      hope_value = 700,
      id = 2,
      is_turns = false,
      round_id = 10
    },
    {
      hope_value = 700,
      id = 2,
      round_id = 11
    },
    {
      hope_value = 750,
      icon_id = 1,
      id = 2,
      round_id = 12
    },
    {
      hope_value = 750,
      id = 2,
      round_id = 13
    },
    {
      hope_value = 800,
      id = 2,
      round_id = 14
    },
    {
      hope_value = 800,
      id = 2,
      round_id = 15
    },
    {
      hope_value = 850,
      id = 2,
      round_id = 16
    }
  },
  {
    {
      hope_value = 800,
      id = 3,
      is_turns = false
    },
    {
      hope_value = 880,
      id = 3,
      is_turns = false,
      round_id = 2
    },
    {
      hope_value = 1000,
      id = 3,
      round_id = 3
    },
    {
      hope_value = 1000,
      id = 3,
      round_id = 4
    },
    {
      hope_value = 1100,
      id = 3,
      round_id = 5
    },
    {
      hope_value = 1100,
      id = 3,
      round_id = 6
    },
    {
      hope_value = 1200,
      icon_id = 2,
      id = 3,
      round_id = 7
    },
    {
      hope_value = 1200,
      id = 3,
      round_id = 8
    },
    {
      hope_value = 1400,
      id = 3,
      round_id = 9
    },
    {
      hope_value = 1400,
      icon_id = 1,
      id = 3,
      round_id = 10
    }
  },
  {
    {
      hope_value = 800,
      id = 4,
      is_turns = false
    },
    {
      hope_value = 880,
      id = 4,
      is_turns = false,
      round_id = 2
    },
    {
      hope_value = 1000,
      id = 4,
      round_id = 3
    },
    {
      hope_value = 1000,
      id = 4,
      round_id = 4
    },
    {
      hope_value = 1100,
      id = 4,
      round_id = 5
    },
    {
      hope_value = 1100,
      id = 4,
      round_id = 6
    },
    {
      hope_value = 1200,
      icon_id = 2,
      id = 4,
      round_id = 7
    },
    {
      hope_value = 1200,
      id = 4,
      round_id = 8
    },
    {
      hope_value = 1400,
      id = 4,
      round_id = 9
    },
    {
      hope_value = 1400,
      icon_id = 1,
      id = 4,
      round_id = 10
    }
  },
  {
    {
      hope_value = 800,
      id = 5,
      is_turns = false
    },
    {
      hope_value = 880,
      id = 5,
      is_turns = false,
      round_id = 2
    },
    {
      hope_value = 1000,
      id = 5,
      round_id = 3
    },
    {
      hope_value = 1000,
      id = 5,
      round_id = 4
    },
    {
      hope_value = 1100,
      id = 5,
      round_id = 5
    },
    {
      hope_value = 1100,
      id = 5,
      round_id = 6
    },
    {
      hope_value = 1200,
      icon_id = 2,
      id = 5,
      round_id = 7
    },
    {
      hope_value = 1200,
      id = 5,
      round_id = 8
    },
    {
      hope_value = 1400,
      id = 5,
      round_id = 9
    },
    {
      hope_value = 1400,
      icon_id = 1,
      id = 5,
      round_id = 10
    }
  }
}
local __default_values = {
  hope_value = 1300,
  icon_id = 0,
  id = 1,
  is_turns = true,
  round_id = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_card_normal_round) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {
  __basemetatable = base,
  actTurnIdDicList = {
    {
      9,
      10,
      13,
      14,
      15,
      16
    },
    {
      9,
      11,
      12,
      13,
      14,
      15,
      16
    },
    {
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10
    },
    {
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10
    },
    {
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10
    }
  }
}
setmetatable(activity_card_normal_round, {__index = __rawdata})
return activity_card_normal_round
