local activity_blackhole_tag = {
  {tag_des = 337369},
  {id = 2, tag_des = 230481},
  {id = 3, tag_des = 9013},
  {id = 4, tag_des = 53739},
  {id = 5, tag_des = 501452},
  {id = 6, tag_des = 438126},
  {id = 7},
  {id = 8, tag_des = 383560}
}
local __default_values = {id = 1, tag_des = 180243}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_blackhole_tag) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_blackhole_tag, {__index = __rawdata})
return activity_blackhole_tag
