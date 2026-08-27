local activity_card_quality = {
  {
    color_num = {
      154,
      154,
      154
    }
  },
  {
    color_num = {
      117,
      185,
      93
    },
    id = 2
  },
  {id = 3},
  {
    color_num = {
      194,
      85,
      179
    },
    id = 4
  },
  {
    color_num = {
      255,
      132,
      0
    },
    id = 5
  }
}
local __default_values = {
  color_num = {
    0,
    151,
    220
  },
  id = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_card_quality) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_card_quality, {__index = __rawdata})
return activity_card_quality
