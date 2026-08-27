local special_team_stage = {
  [400022125] = {},
  [400022126] = {sector_id = 400022126},
  [400022127] = {sector_id = 400022127}
}
local __default_values = {fmt_id_offset = 0, sector_id = 400022125}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(special_team_stage) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(special_team_stage, {__index = __rawdata})
return special_team_stage
