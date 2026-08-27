local oasis_building_dorm_visit_list = {
  {lits_des = 435927},
  {
    empty_des = 50886,
    id = 2,
    lits_des = 306588
  },
  {
    empty_des = 279129,
    id = 3,
    list_num = 50
  }
}
local __default_values = {
  empty_des = 180357,
  id = 1,
  list_num = 10,
  lits_des = 17699
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(oasis_building_dorm_visit_list) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(oasis_building_dorm_visit_list, {__index = __rawdata})
return oasis_building_dorm_visit_list
