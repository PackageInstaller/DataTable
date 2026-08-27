local __rt_1 = {3}
local __rt_2 = {2106}
local __rt_3 = {}
local __rt_4 = {2115}
local overclock = {
  {
    {
      consumeNum = 10,
      describe = 93193,
      id = 1,
      name = 2098
    }
  },
  {
    {
      buffid = 6009,
      consumeNum = 30,
      describe = 293392,
      id = 2,
      name = 258996
    }
  },
  {
    {
      buffid = 8005,
      describe = 352092,
      id = 3,
      name = 383303
    }
  },
  {
    {
      buffid = 102,
      consumeNum = 40,
      pre_para1 = __rt_4
    },
    {
      buffid = 103,
      consumeNum = 50,
      describe = 245986,
      level = 2,
      pre_para1 = __rt_4
    }
  },
  {
    {
      buffid = 111,
      describe = 16176,
      id = 5,
      name = 388284,
      pre_para1 = {3108}
    }
  },
  {
    {
      buffid = 20006,
      consumeNum = 80,
      describe = 157212,
      id = 6,
      name = 91553,
      pre_para1 = {4101}
    }
  }
}
local __default_values = {
  buffid = 100,
  consumeId = 1,
  consumeNum = 20,
  describe = 156573,
  icon = "",
  id = 4,
  level = 1,
  name = 288393,
  pre_condition = __rt_1,
  pre_para1 = __rt_2,
  pre_para2 = __rt_3
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(overclock) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(overclock, {__index = __rawdata})
return overclock
