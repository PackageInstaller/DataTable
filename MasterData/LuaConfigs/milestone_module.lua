local milestone_module = {
  {name = 218655, name_eng = "Dolls"},
  {
    icon = "Milestone_Icon2",
    id = 2,
    item_id = 17,
    name = 177986
  },
  {
    icon = "Milestone_Icon3",
    id = 3,
    item_id = 18,
    name = 67476,
    name_eng = "Collection"
  },
  {
    icon = "Milestone_Icon4",
    id = 4,
    item_id = 19,
    name_eng = "Journal"
  },
  {
    icon = "Milestone_Icon5",
    id = 5,
    item_id = 20,
    name = 203663,
    name_eng = "Record"
  },
  {
    icon = "Milestone_Icon6",
    id = 6,
    item_id = 21,
    name = 181190,
    name_eng = "Spirit"
  }
}
local __default_values = {
  icon = "Milestone_Icon1",
  id = 1,
  item_id = 16,
  name = 135640,
  name_eng = "Arma"
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(milestone_module) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, maxModuleId = 6}
setmetatable(milestone_module, {__index = __rawdata})
return milestone_module
