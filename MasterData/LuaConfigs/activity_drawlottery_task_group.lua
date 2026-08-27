local __rt_1 = {0}
local __rt_2 = {1, 2}
local activity_drawlottery_task_group = {
  {
    [19401] = {group_id = 2, lottery_type = __rt_1},
    [19402] = {
      correction_num = 20,
      group_id = 2,
      lottery_type = __rt_1,
      stage_id = 2,
      task_id = 19402
    },
    [19403] = {
      correction_num = 40,
      group_id = 2,
      lottery_type = __rt_1,
      stage_id = 3,
      task_id = 19403
    },
    [19404] = {task_id = 19404},
    [19405] = {
      correction_num = 30,
      stage_id = 2,
      task_id = 19405
    },
    [19406] = {
      correction_num = 60,
      stage_id = 3,
      task_id = 19406
    },
    [19407] = {
      correction_num = 90,
      stage_id = 4,
      task_id = 19407
    },
    [19408] = {
      correction_num = 120,
      stage_id = 5,
      task_id = 19408
    },
    [19409] = {
      correction_num = 150,
      stage_id = 6,
      task_id = 19409
    },
    [19410] = {
      correction_num = 180,
      stage_id = 7,
      task_id = 19410
    },
    [19411] = {
      correction_num = 210,
      stage_id = 8,
      task_id = 19411
    },
    [19412] = {
      correction_num = 240,
      stage_id = 9,
      task_id = 19412
    },
    [19413] = {
      correction_num = 260,
      stage_id = 10,
      task_id = 19413
    },
    [19414] = {
      correction_num = 280,
      stage_id = 11,
      task_id = 19414
    },
    [19415] = {
      correction_num = 300,
      stage_id = 12,
      task_id = 19415
    },
    [19416] = {
      correction_num = 310,
      stage_id = 13,
      task_id = 19416
    },
    [19417] = {
      correction_num = 320,
      stage_id = 14,
      task_id = 19417
    },
    [19418] = {
      correction_num = 330,
      stage_id = 15,
      task_id = 19418
    },
    [19419] = {
      correction_num = 340,
      stage_id = 16,
      task_id = 19419
    },
    [19420] = {
      correction_num = 350,
      stage_id = 17,
      task_id = 19420
    }
  },
  {
    [19421] = {
      group_id = 2,
      id = 2,
      lottery_type = __rt_1,
      task_id = 19421
    },
    [19422] = {
      correction_num = 20,
      group_id = 2,
      id = 2,
      lottery_type = __rt_1,
      stage_id = 2,
      task_id = 19422
    },
    [19423] = {
      correction_num = 40,
      group_id = 2,
      id = 2,
      lottery_type = __rt_1,
      stage_id = 3,
      task_id = 19423
    },
    [19424] = {id = 2, task_id = 19424},
    [19425] = {
      correction_num = 30,
      id = 2,
      stage_id = 2,
      task_id = 19425
    },
    [19426] = {
      correction_num = 60,
      id = 2,
      stage_id = 3,
      task_id = 19426
    },
    [19427] = {
      correction_num = 90,
      id = 2,
      stage_id = 4,
      task_id = 19427
    },
    [19428] = {
      correction_num = 120,
      id = 2,
      stage_id = 5,
      task_id = 19428
    },
    [19429] = {
      correction_num = 150,
      id = 2,
      stage_id = 6,
      task_id = 19429
    },
    [19430] = {
      correction_num = 180,
      id = 2,
      stage_id = 7,
      task_id = 19430
    },
    [19431] = {
      correction_num = 210,
      id = 2,
      stage_id = 8,
      task_id = 19431
    },
    [19432] = {
      correction_num = 240,
      id = 2,
      stage_id = 9,
      task_id = 19432
    },
    [19433] = {
      correction_num = 260,
      id = 2,
      stage_id = 10,
      task_id = 19433
    },
    [19434] = {
      correction_num = 280,
      id = 2,
      stage_id = 11,
      task_id = 19434
    },
    [19435] = {
      correction_num = 300,
      id = 2,
      stage_id = 12,
      task_id = 19435
    },
    [19436] = {
      correction_num = 310,
      id = 2,
      stage_id = 13,
      task_id = 19436
    },
    [19437] = {
      correction_num = 320,
      id = 2,
      stage_id = 14,
      task_id = 19437
    },
    [19438] = {
      correction_num = 330,
      id = 2,
      stage_id = 15,
      task_id = 19438
    },
    [19439] = {
      correction_num = 340,
      id = 2,
      stage_id = 16,
      task_id = 19439
    },
    [19440] = {
      correction_num = 350,
      id = 2,
      stage_id = 17,
      task_id = 19440
    }
  }
}
local __default_values = {
  correction_num = 0,
  group_id = 1,
  id = 1,
  lottery_type = __rt_2,
  stage_id = 1,
  task_id = 19401
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_drawlottery_task_group) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {
  __basemetatable = base,
  allGroupCountDic = {2, 2},
  lotteryTypeDic = {
    {
      1,
      1,
      [0] = 2
    },
    {
      1,
      1,
      [0] = 2
    }
  },
  taskGroupDic = {
    {
      {
        19404,
        19405,
        19406,
        19407,
        19408,
        19409,
        19410,
        19411,
        19412,
        19413,
        19414,
        19415,
        19416,
        19417,
        19418,
        19419,
        19420
      },
      {
        19401,
        19402,
        19403
      }
    },
    {
      {
        19424,
        19425,
        19426,
        19427,
        19428,
        19429,
        19430,
        19431,
        19432,
        19433,
        19434,
        19435,
        19436,
        19437,
        19438,
        19439,
        19440
      },
      {
        19421,
        19422,
        19423
      }
    }
  }
}
setmetatable(activity_drawlottery_task_group, {__index = __rawdata})
return activity_drawlottery_task_group
