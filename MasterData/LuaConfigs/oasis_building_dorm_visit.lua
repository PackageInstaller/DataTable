local oasis_building_dorm_visit = {
  {}
}
local __default_values = {
  favor_reward_times = 5,
  id = 1,
  is_hide = false,
  like_max_num = 99999
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(oasis_building_dorm_visit) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(oasis_building_dorm_visit, {__index = __rawdata})
return oasis_building_dorm_visit
