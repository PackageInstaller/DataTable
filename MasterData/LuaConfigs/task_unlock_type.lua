local task_unlock_type = {
  {
    icon = "TaskUnlockStage",
    type = 489544
  },
  {id = 2}
}
local __default_values = {
  icon = "ICON_Item_3122",
  id = 1,
  type = 353138
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(task_unlock_type) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(task_unlock_type, {__index = __rawdata})
return task_unlock_type
