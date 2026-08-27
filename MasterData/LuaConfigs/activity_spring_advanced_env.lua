local __rt_1 = {
  1,
  2,
  3,
  4
}
local __rt_2 = {}
local __rt_3 = {
  5,
  6,
  7,
  8
}
local __rt_4 = {
  9,
  10,
  11,
  12
}
local __rt_5 = {
  13,
  14,
  15,
  16
}
local __rt_6 = {
  17,
  18,
  19,
  20
}
local __rt_7 = {
  21,
  22,
  23,
  24
}
local activity_spring_advanced_env = {
  {env_des = 94304, env_name = 17537},
  {
    difficulty_des = __rt_3,
    env_des_extra = "+10%",
    env_id = 2,
    need_interact = 1,
    stage_id = {
      240011102,
      240011108,
      240011114,
      240011120
    }
  },
  {
    difficulty_des = __rt_4,
    env_des = 24202,
    env_des_extra = "+20%",
    env_id = 3,
    env_name = 410724,
    need_interact = 3,
    stage_id = {
      240011103,
      240011109,
      240011115,
      240011121
    }
  },
  {
    difficulty_des = __rt_5,
    env_des = 449735,
    env_des_extra = "+30%",
    env_id = 4,
    env_name = 235255,
    need_interact = 6,
    stage_id = {
      240011104,
      240011110,
      240011116,
      240011122
    }
  },
  {
    difficulty_des = __rt_6,
    env_des = 326033,
    env_des_extra = "+40%",
    env_id = 5,
    env_name = 418297,
    need_interact = 10,
    stage_id = {
      240011105,
      240011111,
      240011117,
      240011123
    }
  },
  {
    difficulty_des = __rt_7,
    env_des = 80342,
    env_des_extra = "+50%",
    env_id = 6,
    env_name = 487088,
    need_interact = 15,
    stage_id = {
      240011106,
      240011112,
      240011118,
      240011124
    }
  },
  {
    difficulty_des = {
      25,
      26,
      27,
      28
    },
    env_des = 209637,
    env_id = 7,
    env_name = 487368,
    stage_id = {
      240031101,
      240031107,
      240031113,
      240031119
    }
  },
  {
    difficulty_des = {
      29,
      30,
      31,
      32
    },
    env_des = 182648,
    env_id = 8,
    env_name = 421775,
    stage_id = {
      240031102,
      240031108,
      240031114,
      240031120
    }
  },
  {
    difficulty_des = {
      33,
      34,
      35,
      36
    },
    env_des = 458660,
    env_id = 9,
    env_name = 328143,
    stage_id = {
      240031103,
      240031109,
      240031115,
      240031121
    }
  },
  {
    difficulty_des = {
      37,
      38,
      39,
      40
    },
    env_des = 452703,
    env_id = 10,
    env_name = 335346,
    stage_id = {
      240031104,
      240031110,
      240031116,
      240031122
    }
  },
  {
    env_des = 94304,
    env_id = 11,
    env_name = 17537,
    stage_id = {
      240012101,
      240012107,
      240012113,
      240012119
    }
  },
  {
    difficulty_des = __rt_3,
    env_des_extra = "+10%",
    env_id = 12,
    need_interact = 1,
    stage_id = {
      240012102,
      240012108,
      240012114,
      240012120
    }
  },
  {
    difficulty_des = __rt_4,
    env_des = 24202,
    env_des_extra = "+20%",
    env_id = 13,
    env_name = 410724,
    need_interact = 3,
    stage_id = {
      240012103,
      240012109,
      240012115,
      240012121
    }
  },
  {
    difficulty_des = __rt_5,
    env_des = 449735,
    env_des_extra = "+30%",
    env_id = 14,
    env_name = 235255,
    need_interact = 6,
    stage_id = {
      240012104,
      240012110,
      240012116,
      240012122
    }
  },
  {
    difficulty_des = __rt_6,
    env_des = 326033,
    env_des_extra = "+40%",
    env_id = 15,
    env_name = 418297,
    need_interact = 10,
    stage_id = {
      240012105,
      240012111,
      240012117,
      240012123
    }
  },
  {
    difficulty_des = __rt_7,
    env_des = 80342,
    env_des_extra = "+50%",
    env_id = 16,
    env_name = 487088,
    need_interact = 15,
    stage_id = {
      240012106,
      240012112,
      240012118,
      240012124
    }
  }
}
local __default_values = {
  difficulty_des = __rt_1,
  env_des = 193543,
  env_des_extra = "",
  env_id = 1,
  env_name = 109622,
  need_interact = 0,
  pre_condition = __rt_2,
  pre_para1 = __rt_2,
  pre_para2 = __rt_2,
  stage_id = {
    240011101,
    240011107,
    240011113,
    240011119
  }
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_spring_advanced_env) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  preconditionDic = {}
}
setmetatable(activity_spring_advanced_env, {__index = __rawdata})
return activity_spring_advanced_env
