local __rt_1 = {4}
local __rt_2 = {1008}
local __rt_3 = {1}
local __rt_4 = {3}
local __rt_5 = {5}
local __rt_6 = {7}
local __rt_7 = {10}
local training = {
  {
    {pre_para2 = __rt_3},
    {
      pre_para2 = __rt_4,
      training_para = 2,
      type_id = 2
    },
    {
      pre_para2 = __rt_5,
      training_para = 3,
      type_id = 3
    },
    {
      pre_para2 = __rt_6,
      training_para = 4,
      type_id = 4
    },
    {training_para = 5, type_id = 5}
  },
  {
    {pre_para2 = __rt_3, training_para = 10},
    {
      pre_para2 = __rt_4,
      training_para = 15,
      type_id = 2
    },
    {
      pre_para2 = __rt_5,
      training_para = 20,
      type_id = 3
    },
    {
      pre_para2 = __rt_6,
      training_para = 25,
      type_id = 4
    },
    {training_para = 30, type_id = 5}
  },
  {
    {pre_para2 = __rt_3, training_para = 100},
    {
      pre_para2 = {2},
      training_para = 200,
      type_id = 2
    },
    {
      pre_para2 = __rt_4,
      training_para = 300,
      type_id = 3
    },
    {
      pre_para2 = __rt_1,
      training_para = 400,
      type_id = 4
    },
    {
      pre_para2 = __rt_5,
      training_para = 500,
      type_id = 5
    },
    {
      pre_para2 = {6},
      training_para = 600,
      type_id = 6
    },
    {
      pre_para2 = __rt_6,
      training_para = 700,
      type_id = 7
    },
    {
      pre_para2 = {8},
      training_para = 800,
      type_id = 8
    },
    {
      pre_para2 = {9},
      training_para = 900,
      type_id = 9
    },
    {training_para = 1000, type_id = 10}
  }
}
local __default_values = {
  pre_condition = __rt_1,
  pre_para1 = __rt_2,
  pre_para2 = __rt_7,
  training_para = 1,
  type_id = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(training) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(training, {__index = __rawdata})
return training
