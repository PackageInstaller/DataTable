local reinforce_collect_collect_reward = {
  {condition = 5, name = 334404},
  {
    condition = 50,
    id = 2,
    name = 524200,
    story_id = 59001202
  },
  {
    condition = 90,
    id = 3,
    name = 329429,
    story_id = 59001203
  },
  {id = 4, story_id = 59001204},
  {
    condition = 190,
    id = 5,
    name = 366583,
    story_id = 59001205
  },
  {
    condition = 240,
    id = 6,
    name = 171812,
    story_id = 59001206
  },
  {
    condition = 290,
    id = 7,
    name = 501329,
    story_id = 59001207
  }
}
local __default_values = {
  condition = 140,
  id = 1,
  name = 134658,
  story_id = 59001201
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(reinforce_collect_collect_reward) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(reinforce_collect_collect_reward, {__index = __rawdata})
return reinforce_collect_collect_reward
