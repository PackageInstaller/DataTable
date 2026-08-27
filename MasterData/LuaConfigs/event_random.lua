local __rt_1 = {
  0,
  1,
  2
}
local __rt_2 = {
  1,
  1,
  1
}
local __rt_3 = {
  "1001_10",
  "1001_100",
  "1001_1000"
}
local event_random = {
  {
    judge_profession = 4,
    jump_target = {
      0,
      0,
      0
    },
    name = 368099,
    para2 = {
      343938,
      343938,
      343938
    }
  },
  {
    id = 2,
    judge_num = 3,
    judge_profession = 3,
    judge_result = {
      0,
      1,
      2,
      3
    },
    logic = {
      1,
      1,
      1,
      1
    },
    para1 = {
      "5004_1",
      "5004_1",
      "5004_2",
      "5004_2"
    }
  },
  {
    id = 3,
    jump_target = {
      36,
      37,
      37
    },
    name = 247585,
    para2 = {
      456619,
      456619,
      456619
    }
  }
}
local __default_values = {
  id = 1,
  judge_num = 2,
  judge_profession = 2,
  judge_result = __rt_1,
  jump_target = {
    0,
    0,
    0,
    0
  },
  logic = __rt_2,
  name = 173328,
  para1 = __rt_3,
  para2 = {
    113062,
    113062,
    113062,
    113062,
    ""
  }
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(event_random) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(event_random, {__index = __rawdata})
return event_random
