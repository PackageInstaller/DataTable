local story_condition_text = {
  {condition_text = 507032},
  [3] = {id = 3},
  [7] = {condition_text = 67362, id = 7}
}
local __default_values = {condition_text = 385423, id = 1}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(story_condition_text) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(story_condition_text, {__index = __rawdata})
return story_condition_text
