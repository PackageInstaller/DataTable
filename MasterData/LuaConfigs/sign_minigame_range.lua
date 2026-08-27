local sign_minigame_range = {
  {
    hot = {200, 499}
  },
  {
    hot = {500, 999},
    id = 2,
    text_id = {
      4,
      5,
      6
    }
  },
  {
    id = 3,
    text_id = {
      7,
      8,
      9
    }
  }
}
local __default_values = {
  hot = {1000, 5000},
  id = 1,
  text_id = {
    1,
    2,
    3
  }
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(sign_minigame_range) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(sign_minigame_range, {__index = __rawdata})
return sign_minigame_range
