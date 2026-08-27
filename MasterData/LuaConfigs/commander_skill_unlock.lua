local __rt_1 = {3}
local __rt_2 = {}
local __rt_3 = {1102}
local __rt_4 = {1105}
local __rt_5 = {1109}
local __rt_6 = {3101}
local __rt_7 = {2103}
local __rt_8 = {2107}
local __rt_9 = {2111}
local commander_skill_unlock = {
  {
    {
      place = 1,
      pre_para1 = {100101}
    },
    {
      id = 2,
      place = 1,
      pre_para1 = __rt_3,
      skill_id = 5012
    },
    {
      id = 3,
      place = 1,
      pre_para1 = __rt_3,
      skill_id = 5013
    },
    {
      id = 4,
      pre_para1 = __rt_3,
      skill_id = 5021
    },
    {
      id = 5,
      pre_para1 = __rt_4,
      skill_id = 5022
    },
    {
      id = 6,
      pre_para1 = __rt_4,
      skill_id = 5023
    },
    {
      id = 7,
      place = 3,
      pre_para1 = {100104},
      skill_id = 5031
    },
    {
      id = 8,
      place = 3,
      pre_para1 = __rt_5,
      skill_id = 5032
    },
    {
      id = 9,
      place = 3,
      pre_para1 = __rt_5,
      skill_id = 5033
    },
    [21] = {
      fairy_skill = true,
      id = 21,
      place = 3,
      skill_id = 8203
    },
    [22] = {
      fairy_skill = true,
      id = 22,
      skill_id = 8204
    },
    [23] = {
      fairy_skill = true,
      id = 23,
      place = 3,
      skill_id = 8205
    }
  },
  {
    [10] = {
      commander_id = 2,
      id = 10,
      place = 1,
      pre_para1 = __rt_7,
      skill_id = 5111
    },
    [11] = {
      commander_id = 2,
      id = 11,
      place = 1,
      pre_para1 = __rt_8,
      skill_id = 5112
    },
    [12] = {
      commander_id = 2,
      id = 12,
      place = 1,
      pre_para1 = __rt_8,
      skill_id = 5113
    },
    [13] = {
      commander_id = 2,
      id = 13,
      pre_para1 = __rt_7,
      skill_id = 5141
    },
    [14] = {
      commander_id = 2,
      id = 14,
      pre_para1 = __rt_9,
      skill_id = 5142
    },
    [15] = {
      commander_id = 2,
      id = 15,
      pre_para1 = __rt_9,
      skill_id = 5143
    },
    [16] = {
      commander_id = 2,
      id = 16,
      place = 3,
      pre_para1 = __rt_7,
      skill_id = 5131
    },
    [17] = {
      commander_id = 2,
      id = 17,
      place = 3,
      skill_id = 5132
    },
    [18] = {
      commander_id = 2,
      id = 18,
      place = 3,
      skill_id = 5133
    },
    [19] = {
      commander_id = 2,
      fairy_skill = true,
      id = 19,
      place = 1,
      skill_id = 8201
    },
    [20] = {
      commander_id = 2,
      fairy_skill = true,
      id = 20,
      skill_id = 8202
    }
  }
}
local __default_values = {
  commander_id = 1,
  fairy_skill = false,
  id = 1,
  place = 2,
  pre_condition = __rt_1,
  pre_para1 = __rt_6,
  pre_para2 = __rt_2,
  skill_id = 5011
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(commander_skill_unlock) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {
  __basemetatable = base,
  cstSkillId2cstId = {
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    1,
    1,
    1
  },
  overloadSkillIdDic = {
    {
      {2, 3},
      {5, 6},
      {8, 9}
    },
    {
      {11, 12},
      {14, 15},
      {17, 18}
    }
  },
  realSkillId2CSTSIdDic = {
    [5011] = 1,
    [5012] = 2,
    [5013] = 3,
    [5021] = 4,
    [5022] = 5,
    [5023] = 6,
    [5031] = 7,
    [5032] = 8,
    [5033] = 9,
    [5111] = 10,
    [5112] = 11,
    [5113] = 12,
    [5131] = 16,
    [5132] = 17,
    [5133] = 18,
    [5141] = 13,
    [5142] = 14,
    [5143] = 15,
    [8201] = 19,
    [8202] = 20,
    [8203] = 21,
    [8204] = 22,
    [8205] = 23
  },
  slotDefaultSkillIdDic = {
    {
      1,
      4,
      7
    },
    {
      10,
      13,
      16
    }
  }
}
setmetatable(commander_skill_unlock, {__index = __rawdata})
return commander_skill_unlock
