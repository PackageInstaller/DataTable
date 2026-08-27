local activity_winter_challenge_score = {
  {title = 435694},
  {
    id = 2,
    intro = 428405,
    title = 82378,
    unit_score = 7
  },
  {
    id = 3,
    intro = 339419,
    unit_score = 3
  }
}
local __default_values = {
  id = 1,
  intro = 280646,
  title = 379567,
  unit_score = 100
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_winter_challenge_score) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_winter_challenge_score, {__index = __rawdata})
return activity_winter_challenge_score
