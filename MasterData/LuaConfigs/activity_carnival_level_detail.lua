local activity_carnival_level_detail = {
  [33001] = {},
  [33002] = {id = 33002, level_des = 91091},
  [33003] = {id = 33003, level_des = 73909},
  [33011] = {id = 33011},
  [33012] = {id = 33012, level_des = 91091},
  [33013] = {id = 33013, level_des = 73909}
}
local __default_values = {id = 33001, level_des = 199208}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_carnival_level_detail) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_carnival_level_detail, {__index = __rawdata})
return activity_carnival_level_detail
