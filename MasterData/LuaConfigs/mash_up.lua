local __rt_1 = {
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
  1024
}
local mash_up = {
  {},
  {
    id = 2,
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
      2048
    }
  },
  {id = 3},
  {id = 4}
}
local __default_values = {id = 1, score_per_ball = __rt_1}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(mash_up) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(mash_up, {__index = __rawdata})
return mash_up
