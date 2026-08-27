local __rt_1 = {1}
local __rt_2 = {}
local __rt_3 = {28}
local __rt_4 = {22002}
local __rt_5 = {2}
local __rt_6 = {3}
local __rt_7 = {4}
local activity_hallowmas_general_env = {
  {
    general_env_des = 144517,
    general_env_icon = "ICON_xy_JNH_23",
    general_env_name = 503642,
    pre1_condition = __rt_2,
    pre1_para1 = __rt_2,
    pre1_para2 = __rt_2,
    preConditions = __rt_2
  },
  {
    difficulty_id = {
      2,
      3,
      4,
      5
    },
    env_task = {
      9461,
      9462,
      9463,
      9464,
      9465,
      9466,
      9467,
      9468,
      9469,
      9470,
      9471,
      9472,
      9473,
      9474,
      9475
    },
    general_env_des2 = 65265,
    general_env_icon = "ICON_xy_WCDG_SB1",
    general_env_id = 2,
    general_env_name = 419741,
    preConditionsNum = 1
  },
  {
    difficulty_id = {
      6,
      7,
      8,
      9
    },
    env_task = {
      9476,
      9477,
      9478,
      9479,
      9480,
      9481,
      9482,
      9483,
      9484,
      9485,
      9486,
      9487,
      9488,
      9489,
      9490
    },
    general_env_des2 = 443319,
    general_env_id = 3,
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
  }
}
local __default_values = {
  difficulty_id = __rt_1,
  env_task = {
    9458,
    9459,
    9460
  },
  general_env_des = 378369,
  general_env_des2 = 283350,
  general_env_icon = "ICON_xy_57",
  general_env_id = 1,
  general_env_name = 311327,
  pre1_condition = __rt_3,
  pre1_para1 = __rt_4,
  pre1_para2 = __rt_1,
  pre2_condition = __rt_2,
  pre2_para1 = __rt_2,
  pre2_para2 = __rt_2,
  pre3_condition = __rt_2,
  pre3_para1 = __rt_2,
  pre3_para2 = __rt_2,
  preConditions = {
    {
      __rt_3,
      __rt_4,
      __rt_1
    }
  },
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
for k, v in pairs(activity_hallowmas_general_env) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  taskEnvDic = {
    [9458] = 1,
    [9459] = 1,
    [9460] = 1,
    [9461] = 2,
    [9462] = 2,
    [9463] = 2,
    [9464] = 2,
    [9465] = 2,
    [9466] = 2,
    [9467] = 2,
    [9468] = 2,
    [9469] = 2,
    [9470] = 2,
    [9471] = 2,
    [9472] = 2,
    [9473] = 2,
    [9474] = 2,
    [9475] = 2,
    [9476] = 3,
    [9477] = 3,
    [9478] = 3,
    [9479] = 3,
    [9480] = 3,
    [9481] = 3,
    [9482] = 3,
    [9483] = 3,
    [9484] = 3,
    [9485] = 3,
    [9486] = 3,
    [9487] = 3,
    [9488] = 3,
    [9489] = 3,
    [9490] = 3
  }
}
setmetatable(activity_hallowmas_general_env, {__index = __rawdata})
return activity_hallowmas_general_env
