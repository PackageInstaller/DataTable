local __rt_1 = {}
local __rt_2 = {28}
local __rt_3 = {22002}
local __rt_4 = {1}
local __rt_5 = {
  {
    __rt_2,
    __rt_3,
    __rt_4
  }
}
local __rt_6 = {4}
local __rt_7 = {
  __rt_2,
  __rt_3,
  __rt_6
}
local __rt_8 = {2}
local __rt_9 = {3}
local __rt_10 = {
  {
    __rt_2,
    __rt_3,
    __rt_8
  },
  {
    __rt_2,
    __rt_3,
    __rt_9
  },
  __rt_7
}
local __rt_11 = {8}
local activity_hallowmas_stage_info = {
  {
    {
      difficulty_name = 356375,
      forecast_des = 316638,
      id = 1,
      pre1_condition = __rt_1,
      pre1_para1 = __rt_1
    },
    {
      combat = 25000,
      difficulty_color = 1,
      difficulty_id = 2,
      difficulty_name = 460008,
      difficulty_name_en = "NORMAL MODE",
      forecast_des = 327113,
      id = 1,
      pre1_condition = __rt_1,
      pre1_para1 = __rt_1,
      season_id = 2
    },
    {
      combat = 40000,
      difficulty_color = 2,
      difficulty_id = 3,
      difficulty_name = 121451,
      difficulty_name_en = "HARD MODE",
      forecast_des = 46874,
      id = 1,
      pre1_condition = __rt_1,
      pre1_para1 = __rt_1,
      season_id = 3
    },
    {
      combat = 55000,
      difficulty_color = 3,
      difficulty_id = 4,
      difficulty_name = 258337,
      difficulty_name_en = "EXTREME MODE",
      forecast_des = 496061,
      id = 1,
      pre1_condition = __rt_1,
      pre1_para1 = __rt_1,
      season_id = 4
    }
  },
  {
    {
      difficulty_name = 329796,
      difficulty_name_en = "TUTORIAL MODE",
      floor_id = 5,
      forecast_des = 440660,
      pre1_condition = __rt_1,
      pre1_para1 = __rt_1,
      season_id = 5
    },
    {
      difficulty_id = 2,
      difficulty_name = 248204,
      floor_id = 8,
      forecast_des = 468467,
      pre1_para2 = __rt_4,
      preConditions = __rt_5,
      preConditionsNum = 1,
      season_id = 6
    },
    {
      combat = 25000,
      difficulty_color = 1,
      difficulty_id = 3,
      difficulty_name_en = "NORMAL MODE",
      forecast_des = 176204,
      pre1_para2 = __rt_4,
      preConditions = __rt_5,
      preConditionsNum = 1,
      season_id = 7
    },
    {
      combat = 45000,
      difficulty_color = 2,
      difficulty_id = 4,
      difficulty_name = 360027,
      difficulty_name_en = "HARD MODE",
      forecast_des = 159063,
      pre1_para2 = __rt_4,
      preConditions = __rt_5,
      preConditionsNum = 1,
      season_id = 8
    },
    {
      combat = 60000,
      difficulty_color = 3,
      difficulty_id = 5,
      difficulty_name = 94840,
      difficulty_name_en = "EXTREME MODE",
      pre1_para2 = __rt_6,
      preConditions = {__rt_7},
      preConditionsNum = 1,
      season_id = 9
    },
    {
      difficulty_id = 6,
      difficulty_name = 248204,
      floor_id = 8,
      forecast_des = 468467,
      pre1_para2 = __rt_8,
      pre2_condition = __rt_2,
      pre2_para1 = __rt_3,
      pre2_para2 = __rt_9,
      pre3_condition = __rt_2,
      pre3_para1 = __rt_3,
      pre3_para2 = __rt_6,
      preConditions = __rt_10,
      preConditionsNum = 3,
      season_id = 10
    },
    {
      combat = 25000,
      difficulty_color = 1,
      difficulty_id = 7,
      difficulty_name_en = "NORMAL MODE",
      forecast_des = 176204,
      pre1_para2 = __rt_8,
      pre2_condition = __rt_2,
      pre2_para1 = __rt_3,
      pre2_para2 = __rt_9,
      pre3_condition = __rt_2,
      pre3_para1 = __rt_3,
      pre3_para2 = __rt_6,
      preConditions = __rt_10,
      preConditionsNum = 3,
      season_id = 11
    },
    {
      combat = 45000,
      difficulty_color = 2,
      difficulty_id = 8,
      difficulty_name = 360027,
      difficulty_name_en = "HARD MODE",
      forecast_des = 159063,
      pre1_para2 = __rt_8,
      pre2_condition = __rt_2,
      pre2_para1 = __rt_3,
      pre2_para2 = __rt_9,
      pre3_condition = __rt_2,
      pre3_para1 = __rt_3,
      pre3_para2 = __rt_6,
      preConditions = __rt_10,
      preConditionsNum = 3,
      season_id = 12
    },
    {
      combat = 60000,
      difficulty_color = 3,
      difficulty_id = 9,
      difficulty_name = 94840,
      difficulty_name_en = "EXTREME MODE",
      pre1_para2 = __rt_11,
      preConditions = {
        {
          __rt_2,
          __rt_3,
          __rt_11
        }
      },
      preConditionsNum = 1,
      season_id = 13
    }
  }
}
local __default_values = {
  combat = 8000,
  difficulty_color = 0,
  difficulty_id = 1,
  difficulty_name = 215360,
  difficulty_name_en = "EASY MODE",
  floor_id = 12,
  forecast_des = 103405,
  id = 2,
  pre1_condition = __rt_2,
  pre1_para1 = __rt_3,
  pre1_para2 = __rt_1,
  pre2_condition = __rt_1,
  pre2_para1 = __rt_1,
  pre2_para2 = __rt_1,
  pre3_condition = __rt_1,
  pre3_para1 = __rt_1,
  pre3_para2 = __rt_1,
  preConditions = __rt_1,
  preConditionsNum = 0,
  season_id = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_hallowmas_stage_info) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_hallowmas_stage_info, {__index = __rawdata})
return activity_hallowmas_stage_info
