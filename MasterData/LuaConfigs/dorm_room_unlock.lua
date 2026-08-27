local __rt_1 = {}
local __rt_2 = {3}
local __rt_3 = {36, 3}
local dorm_room_unlock = {
  {
    {},
    {room_id = 2},
    {
      room_id = 3,
      unlock_logic = 1,
      unlock_para1 = 2108
    },
    {
      room_id = 4,
      unlock_logic = 1,
      unlock_para1 = 2114
    },
    {
      room_id = 5,
      unlock_logic = 1,
      unlock_para1 = 3102
    },
    {
      room_id = 6,
      unlock_logic = 1,
      unlock_para1 = 3108
    },
    {
      room_id = 7,
      unlock_logic = 1,
      unlock_para1 = 4102
    }
  },
  {
    {house = 2}
  },
  [4] = {
    {house = 4}
  },
  [5] = {
    {house = 5}
  },
  [6] = {
    {house = 6}
  },
  [7] = {
    {
      house = 7,
      pre_condition = __rt_2,
      pre_para1 = {5102}
    },
    {
      house = 7,
      pre_condition = __rt_2,
      pre_para1 = {6102},
      room_id = 2
    },
    {
      house = 7,
      pre_condition = __rt_3,
      pre_para1 = {7, 110013102},
      room_id = 3
    },
    {
      house = 7,
      pre_condition = __rt_3,
      pre_para1 = {8, 130031102},
      room_id = 4
    },
    {
      house = 7,
      pre_condition = __rt_3,
      pre_para1 = {9, 140021102},
      room_id = 5
    },
    {
      house = 7,
      pre_condition = __rt_3,
      pre_para1 = {10, 250021102},
      room_id = 6
    },
    {
      house = 7,
      pre_condition = __rt_3,
      pre_para1 = {10, 250021110},
      room_id = 7
    }
  }
}
local __default_values = {
  house = 1,
  pre_condition = __rt_1,
  pre_para1 = __rt_1,
  pre_para2 = __rt_1,
  room_id = 1,
  unlock_logic = 0,
  unlock_para1 = 0
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(dorm_room_unlock) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(dorm_room_unlock, {__index = __rawdata})
return dorm_room_unlock
