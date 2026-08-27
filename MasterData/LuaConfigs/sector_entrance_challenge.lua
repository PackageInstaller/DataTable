local sector_entrance_challenge = {
  {name_cn = 497913},
  {
    Image = "Dungeon_Image_EnvBlackHole",
    icon = "Dungeon_Icon_EnvBlackHole",
    id = 2,
    name_en = "-  X  E  N  O  M  E  N  S  I  O  N    A  B  Y  S  S  -",
    system_id = 511
  }
}
local __default_values = {
  Image = "Dungeon_Image_EnigmaBlackHole",
  icon = "Dungeon_Icon_EnigmaBlackHole",
  id = 1,
  name_cn = 199401,
  name_en = "-  E  N  I  G  M  A    B  L  A  C  K    H  O  L  E  -",
  order = 0,
  system_id = 401
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(sector_entrance_challenge) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  id_sort_list = {1, 2}
}
setmetatable(sector_entrance_challenge, {__index = __rawdata})
return sector_entrance_challenge
