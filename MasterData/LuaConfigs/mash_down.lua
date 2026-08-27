local mash_down = {
  {}
}
local __default_values = {
  id = 1,
  score_per_ball = {
    1,
    2,
    4,
    8,
    16,
    32,
    64,
    128,
    256,
    512,
    1024,
    2048,
    4096,
    8192
  }
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(mash_down) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(mash_down, {__index = __rawdata})
return mash_down
