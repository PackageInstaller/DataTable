local achievement = {
  {english_name = "CAREER", name = 446849},
  {
    english_name = "NEURSOUL",
    name = 264498,
    task_type = 602,
    type = 2
  },
  {
    english_name = "EXPLORATION",
    task_type = 603,
    type = 3
  },
  {
    name = 328900,
    task_type = 604,
    type = 4
  },
  {
    english_name = "CONSTRUCTION",
    name = 315560,
    task_type = 605,
    type = 5
  }
}
local __default_values = {
  english_name = "ALGORITHM",
  name = 224855,
  task_type = 601,
  type = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(achievement) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(achievement, {__index = __rawdata})
return achievement
