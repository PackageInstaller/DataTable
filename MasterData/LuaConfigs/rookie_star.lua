local __rt_1 = {
  [2] = {1001}
}
local __rt_2 = {12}
local __rt_3 = {-1}
local rookie_star = {
  {
    {
      pre_para2 = {1681110413}
    },
    {
      id = 2,
      init_tasks = {
        102100,
        102101,
        102102,
        102103,
        102104,
        102105
      },
      phase = {
        {
          name = 53077,
          para = -1,
          task = 102100,
          type = 1
        },
        {
          name = 382594,
          para = 1,
          task = 102200,
          type = 1
        },
        {
          name = 187823,
          para = 2,
          task = 102300,
          type = 1
        },
        {
          name = 517340,
          para = 3,
          task = 102400,
          type = 1
        },
        {
          name = 322569,
          para = 4,
          task = 102500,
          type = 1
        },
        {
          name = 127798,
          para = 5,
          task = 102600,
          type = 1
        },
        {
          name = 457315,
          para = 6,
          task = 102700,
          type = 1
        },
        {
          name = 262544,
          para = 7,
          task = 102800,
          type = 1
        },
        {
          name = 67773,
          para = 8,
          task = 102900,
          type = 1
        },
        {
          name = 62431,
          para = 9,
          task = 103000,
          type = 1
        }
      },
      pre_para1 = {1681110414}
    }
  }
}
local __default_values = {
  act_id = 1,
  bg_path = "",
  enter_path = "",
  extra_para = __rt_1,
  id = 1,
  init_tasks = {
    100100,
    100101,
    100102,
    100103,
    100104,
    100105
  },
  name = 487929,
  phase = {
    {
      name = 53077,
      para = -1,
      task = 100100,
      type = 1
    },
    {
      name = 382594,
      para = 1,
      task = 100200,
      type = 1
    },
    {
      name = 187823,
      para = 2,
      task = 100300,
      type = 1
    },
    {
      name = 517340,
      para = 3,
      task = 100400,
      type = 1
    },
    {
      name = 322569,
      para = 4,
      task = 100500,
      type = 1
    },
    {
      name = 127798,
      para = 5,
      task = 100600,
      type = 1
    },
    {
      name = 457315,
      para = 6,
      task = 100700,
      type = 1
    },
    {
      name = 262544,
      para = 7,
      task = 100800,
      type = 1
    },
    {
      name = 67773,
      para = 8,
      task = 100900,
      type = 1
    },
    {
      name = 62431,
      para = 9,
      task = 101000,
      type = 1
    }
  },
  pre_condition = __rt_2,
  pre_para1 = __rt_3,
  pre_para2 = __rt_3
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(rookie_star) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(rookie_star, {__index = __rawdata})
return rookie_star
