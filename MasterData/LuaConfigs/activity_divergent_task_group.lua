local activity_divergent_task_group = {
  [9900] = {},
  [9901] = {task_id = 9901, task_rank = 2},
  [9902] = {task_id = 9902, task_rank = 3},
  [9903] = {task_id = 9903},
  [9904] = {task_id = 9904, task_rank = 2},
  [9905] = {task_id = 9905},
  [9906] = {task_id = 9906, task_rank = 2},
  [9907] = {task_id = 9907, task_rank = 3},
  [9908] = {task_id = 9908},
  [9909] = {task_id = 9909, task_rank = 2},
  [9910] = {task_id = 9910, task_rank = 3},
  [9911] = {task_id = 9911, task_rank = 3},
  [9912] = {task_id = 9912},
  [9913] = {task_id = 9913},
  [9914] = {task_id = 9914},
  [9915] = {task_id = 9915, task_rank = 2},
  [9916] = {task_id = 9916, task_rank = 3},
  [9917] = {task_id = 9917},
  [9918] = {task_id = 9918, task_rank = 2},
  [9919] = {task_id = 9919, task_rank = 3},
  [9920] = {task_id = 9920},
  [9921] = {task_id = 9921, task_type = 3},
  [9922] = {
    task_id = 9922,
    task_rank = 2,
    task_type = 3
  },
  [9923] = {
    task_id = 9923,
    task_rank = 3,
    task_type = 3
  },
  [9924] = {task_id = 9924, task_type = 3},
  [9925] = {
    task_id = 9925,
    task_rank = 2,
    task_type = 3
  },
  [9926] = {
    task_id = 9926,
    task_rank = 3,
    task_type = 3
  },
  [9927] = {task_id = 9927, task_type = 3},
  [9928] = {
    task_id = 9928,
    task_rank = 2,
    task_type = 3
  },
  [9929] = {
    task_id = 9929,
    task_rank = 3,
    task_type = 3
  },
  [9930] = {task_id = 9930, task_type = 3},
  [9931] = {task_id = 9931, task_type = 3},
  [9932] = {task_id = 9932, task_type = 3},
  [9933] = {task_id = 9933, task_type = 3},
  [9934] = {task_id = 9934, task_type = 3},
  [9935] = {task_id = 9935, task_type = 3},
  [9936] = {
    task_id = 9936,
    task_rank = 2,
    task_type = 3
  },
  [9937] = {
    task_id = 9937,
    task_rank = 2,
    task_type = 3
  },
  [9938] = {
    task_id = 9938,
    task_rank = 2,
    task_type = 3
  },
  [9939] = {
    task_id = 9939,
    task_rank = 2,
    task_type = 3
  },
  [9940] = {
    task_id = 9940,
    task_rank = 2,
    task_type = 3
  },
  [9941] = {task_id = 9941, task_type = 1}
}
local __default_values = {
  task_id = 9900,
  task_rank = 1,
  task_type = 2
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_divergent_task_group) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_divergent_task_group, {__index = __rawdata})
return activity_divergent_task_group
