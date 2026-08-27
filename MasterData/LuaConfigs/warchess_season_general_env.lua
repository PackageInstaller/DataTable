local __rt_1 = {1}
local __rt_2 = {}
local __rt_3 = {28}
local __rt_4 = {22002}
local __rt_5 = {2}
local __rt_6 = {3}
local __rt_7 = {4}
local __rt_8 = {
  5,
  6,
  7,
  8
}
local __rt_9 = {
  1,
  2,
  3,
  4
}
local warchess_season_general_env = {
  {
    difficulty_id = __rt_1,
    general_env_des = 144517,
    general_env_des2 = 283350,
    general_env_name = 503642
  },
  {
    difficulty_id = {
      2,
      3,
      4,
      5
    },
    general_env_des = 378369,
    general_env_des2 = 65265,
    general_env_icon = "ICON_xy_WCDG_SB1",
    general_env_name = 419741,
    id = 2,
    pre1_condition = __rt_3,
    pre1_para1 = __rt_4,
    pre1_para2 = __rt_1,
    preConditions = {
      {
        __rt_3,
        __rt_4,
        __rt_1
      }
    },
    preConditionsNum = 1
  },
  {
    difficulty_id = {
      6,
      7,
      8,
      9
    },
    general_env_des = 378369,
    general_env_des2 = 443319,
    general_env_icon = "ICON_xy_57",
    general_env_name = 311327,
    id = 3,
    pre1_condition = __rt_3,
    pre1_para1 = __rt_4,
    pre1_para2 = __rt_5,
    pre2_condition = __rt_3,
    pre2_para1 = __rt_4,
    pre2_para2 = __rt_6,
    pre3_condition = __rt_3,
    pre3_para1 = __rt_4,
    pre3_para2 = __rt_7,
    preConditions = {
      {
        __rt_3,
        __rt_4,
        __rt_5
      },
      {
        __rt_3,
        __rt_4,
        __rt_6
      },
      {
        __rt_3,
        __rt_4,
        __rt_7
      }
    },
    preConditionsNum = 3,
    pre_desc = 184539
  },
  {
    difficulty_id = __rt_8,
    general_env_des = 384335,
    id = 4,
    rank_id = 27
  },
  {
    general_env_des2 = 317621,
    general_env_name = 271848,
    id = 5,
    rank_id = 26
  },
  {
    general_env_des = 479105,
    general_env_des2 = 163091,
    general_env_name = 462920,
    id = 6,
    rank_id = 30
  },
  {
    difficulty_id = __rt_8,
    general_env_des = 436101,
    general_env_des2 = 279492,
    general_env_name = 10048,
    id = 7,
    rank_id = 31
  },
  {
    difficulty_id = {
      9,
      10,
      11,
      12
    },
    general_env_des = 222940,
    general_env_des2 = 513575,
    general_env_name = 154124,
    id = 8,
    rank_id = 32
  },
  {
    env_task = {
      7868,
      7869,
      7870
    },
    general_env_des = 379665,
    general_env_des2 = 499602,
    general_env_name = 488475,
    id = 9,
    rank_id = 71
  },
  {
    difficulty_id = __rt_8,
    general_env_des = 384335,
    id = 10,
    rank_id = 74
  },
  {
    general_env_des2 = 317621,
    general_env_name = 271848,
    id = 11,
    rank_id = 73
  }
}
local __default_values = {
  difficulty_id = __rt_9,
  env_task = __rt_2,
  general_env_des = 237390,
  general_env_des2 = 185648,
  general_env_icon = "ICON_xy_JNH_23",
  general_env_name = 207212,
  id = 1,
  pre1_condition = __rt_2,
  pre1_para1 = __rt_2,
  pre1_para2 = __rt_2,
  pre2_condition = __rt_2,
  pre2_para1 = __rt_2,
  pre2_para2 = __rt_2,
  pre3_condition = __rt_2,
  pre3_para1 = __rt_2,
  pre3_para2 = __rt_2,
  preConditions = __rt_2,
  preConditionsNum = 0,
  pre_desc = "",
  rank_id = 0
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(warchess_season_general_env) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  taskEnvDic = {
    [7868] = 9,
    [7869] = 9,
    [7870] = 9
  }
}
setmetatable(warchess_season_general_env, {__index = __rawdata})
return warchess_season_general_env
