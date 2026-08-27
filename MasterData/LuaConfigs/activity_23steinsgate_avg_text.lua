local activity_23steinsgate_avg_text = {
  {},
  {
    digit = 203774,
    id = 2,
    text = 60386
  },
  {digit = 155204, id = 3},
  {
    digit = 32050,
    id = 4,
    text = 500640
  },
  {id = 5, text = 94299},
  {
    digit = 222717,
    id = 6,
    text = 94299
  },
  {id = 7, text = 354355},
  {id = 8, text = 274616},
  {id = 9, text = 50507},
  {id = 10, text = 50507},
  {digit = 222319, id = 11},
  {id = 12, text = 516517},
  {
    digit = 253618,
    id = 13,
    text = 218251
  },
  {
    digit = 444658,
    id = 14,
    text = 516517
  },
  {
    digit = 157775,
    id = 15,
    text = 94299
  },
  {id = 16}
}
local __default_values = {
  digit = "",
  id = 1,
  text = 463582
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_23steinsgate_avg_text) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_23steinsgate_avg_text, {__index = __rawdata})
return activity_23steinsgate_avg_text
