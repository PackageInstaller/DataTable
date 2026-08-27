local __rt_1 = {6003, 1002}
local __rt_2 = {2, 50}
local __rt_3 = {
  5,
  10000,
  1
}
local activity_treasurehunt_treasure_detail = {
  {
    {
      lobby_pos = {-2.02, 2.89},
      obj_id = 8
    },
    {
      lobby_pos = {-3.23, 4.15},
      obj_id = 9,
      rewardIds = {
        5007,
        1003,
        8260
      },
      rewardNums = __rt_3,
      sequence = 2
    },
    {
      lobby_pos = {0.38, 2.69},
      rewardIds = {
        3001,
        8103,
        1503
      },
      rewardNums = {
        1,
        5,
        250
      },
      sequence = 3
    },
    {
      lobby_pos = {-1.14, 4.15},
      obj_id = 11,
      rewardIds = {
        8251,
        6001,
        8260
      },
      rewardNums = {
        2,
        10,
        1
      },
      sequence = 4
    },
    {
      lobby_pos = {0.76, -1.33},
      obj_id = 12,
      rewardIds = {6003, 1504},
      rewardNums = {6, 5},
      sequence = 5
    },
    {
      lobby_pos = {-4.21, 5.84},
      obj_id = 13,
      rewardIds = {
        8223,
        1003,
        8260
      },
      rewardNums = __rt_3,
      sequence = 6
    },
    {
      lobby_pos = {-5.42, 2.25},
      obj_id = 14,
      rewardIds = {
        8251,
        1504,
        1920
      },
      rewardNums = {
        6,
        5,
        500
      },
      sequence = 7
    },
    {
      lobby_pos = {-7.36, 3.26},
      obj_id = 15,
      rewardIds = {
        1920,
        8223,
        8260
      },
      rewardNums = {
        2500,
        5,
        1
      },
      sequence = 8
    },
    {
      lobby_pos = {3.08, 3.13},
      obj_id = 16,
      rewardIds = {
        1502,
        1501,
        8260
      },
      rewardNums = {
        5,
        2000,
        1
      },
      sequence = 9
    },
    {
      lobby_pos = {6.33, -0.05},
      obj_id = 17,
      rewardIds = {
        1002,
        1504,
        1503
      },
      rewardNums = {
        150,
        5,
        250
      },
      sequence = 10
    },
    {
      obj_id = 18,
      rewardIds = {8251, 8103},
      rewardNums = {2, 5},
      sequence = 11
    },
    {
      lobby_pos = {4.18, 0.05},
      obj_id = 19,
      sequence = 12
    },
    {
      lobby_pos = {-8.7, 0.07},
      obj_id = 20,
      rewardIds = {3001, 6001},
      rewardNums = {1, 10},
      sequence = 13
    },
    {
      is_jackpot = true,
      lobby_pos = {-11.86, 0.79},
      obj_id = 21,
      rewardIds = {
        600106,
        610106,
        620022
      },
      rewardNums = {
        1,
        1,
        1
      },
      sequence = 14
    }
  }
}
local __default_values = {
  activity_id = 1,
  is_jackpot = false,
  lobby_pos = {-0.15, 5.84},
  obj_id = 10,
  rewardIds = __rt_1,
  rewardNums = __rt_2,
  sequence = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_treasurehunt_treasure_detail) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {
  __basemetatable = base,
  lobbyObj2Id = {
    {
      [8] = 1,
      [9] = 2,
      [10] = 3,
      [11] = 4,
      [12] = 5,
      [13] = 6,
      [14] = 7,
      [15] = 8,
      [16] = 9,
      [17] = 10,
      [18] = 11,
      [19] = 12,
      [20] = 13,
      [21] = 14
    }
  }
}
setmetatable(activity_treasurehunt_treasure_detail, {__index = __rawdata})
return activity_treasurehunt_treasure_detail
