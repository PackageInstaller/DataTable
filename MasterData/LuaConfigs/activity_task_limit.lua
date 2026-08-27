local __rt_1 = {}
local __rt_2 = {
  65,
  72,
  101
}
local activity_task_limit = {
  [30001] = {
    description = 261066,
    taskTypeDic = {
      [801] = true
    }
  },
  [30002] = {
    activity_id = 30002,
    description = 261066,
    taskTypeDic = {
      [804] = true
    }
  },
  [30003] = {
    activity_id = 30003,
    img_hero_path = "LimitTaskHero2",
    taskTypeDic = {
      [808] = true
    },
    theme_color = {
      166,
      59,
      51
    }
  },
  [30004] = {
    activity_id = 30004,
    img_hero_path = "LimitTaskHero3",
    taskTypeDic = {
      [809] = true
    },
    theme_color = {
      63,
      49,
      40
    }
  },
  [30005] = {
    activity_id = 30005,
    img_hero_path = "LimitTaskHero4",
    theme_color = {
      58,
      44,
      34
    }
  },
  [30006] = {
    activity_id = 30006,
    img_hero_path = "LimitTaskHero5",
    taskTypeDic = {
      [1961] = true
    },
    theme_color = {
      54,
      62,
      106
    }
  },
  [30007] = {
    activity_id = 30007,
    description = 93333,
    extra_jump_name = 485056,
    img_hero_path = "LimitTaskMask6",
    jumpArgs = {1039},
    jumpId = 105,
    taskTypeDic = {
      [1962] = true
    },
    theme_color = {
      54,
      61,
      33
    }
  },
  [30008] = {
    activity_id = 30008,
    img_hero_path = "LimitTaskHero7",
    taskTypeDic = {
      [1963] = true
    },
    theme_color = {
      6,
      36,
      47
    }
  }
}
local __default_values = {
  activity_id = 30001,
  bg_path = "LimitTaskBG1",
  description = 395766,
  extra_jump_name = "",
  img_hero_path = "LimitTaskHero1",
  jumpArgs = __rt_1,
  jumpId = 0,
  taskTypeDic = {
    [1960] = true
  },
  theme_color = __rt_2
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_task_limit) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_task_limit, {__index = __rawdata})
return activity_task_limit
