local milestone_mile_color = {
  {
    class_color = {
      143,
      144,
      149
    },
    color = {
      117,
      128,
      163,
      38
    },
    stage = "E"
  },
  {
    class_color = {
      142,
      157,
      207
    },
    id = 2,
    stage = "D"
  },
  {
    class_color = {
      84,
      116,
      222
    },
    color = {
      84,
      116,
      222,
      76
    },
    id = 3,
    stage = "C"
  },
  {
    class_color = {
      41,
      90,
      255
    },
    color = {
      41,
      90,
      255,
      102
    },
    id = 4,
    stage = "B"
  },
  {
    color = {
      11,
      67,
      255,
      138
    },
    id = 5
  }
}
local __default_values = {
  class_color = {
    11,
    67,
    255
  },
  color = {
    101,
    123,
    198,
    51
  },
  id = 1,
  stage = "A"
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(milestone_mile_color) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, maxStageId = 5}
setmetatable(milestone_mile_color, {__index = __rawdata})
return milestone_mile_color
