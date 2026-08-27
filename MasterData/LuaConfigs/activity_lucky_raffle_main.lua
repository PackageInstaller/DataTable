local activity_lucky_raffle_main = {
  {}
}
local __default_values = {
  activity_id = 1,
  activity_name = 189154,
  activity_text = 100944,
  rank_id = 34
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_lucky_raffle_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_lucky_raffle_main, {__index = __rawdata})
return activity_lucky_raffle_main
