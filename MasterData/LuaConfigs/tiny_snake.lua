local __rt_1 = {
  400045,
  1504,
  1202
}
local __rt_2 = {
  1,
  15,
  500
}
local tiny_snake = {
  {},
  {id = 2, rank_id = 37}
}
local __default_values = {
  id = 1,
  join_reward_ids = __rt_1,
  join_reward_nums = __rt_2,
  join_score = 10,
  rank_id = 21,
  snake_guide_id = 28
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(tiny_snake) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(tiny_snake, {__index = __rawdata})
return tiny_snake
