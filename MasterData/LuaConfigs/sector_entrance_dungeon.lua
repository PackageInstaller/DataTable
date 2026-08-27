local sector_entrance_dungeon = {
  {
    Image = "Dungeon_Image_FragmentSearch",
    icon = "Dungeon_Icon_FragmentSearch",
    name_cn = 18753,
    name_en = "-  F  R  A  G  M  E  N  T    S  E  A  R  C  H -",
    order = 3,
    privilege_id = 1,
    system_id = 102
  },
  {
    Image = "Dungeon_Image_ ResourceCollection",
    icon = "Dungeon_Icon_ResourceCollection",
    id = 2,
    name_cn = 131260,
    name_en = "-  R  E  S  O  U  R  C  E    C  O  L  L  E  C  T  I  O  N  -",
    order = 5,
    privilege_id = 3
  },
  {
    id = 3,
    order = 4,
    privilege_id = 2,
    system_id = 103
  },
  {
    Image = "Dungeon_Image_VulnerabilityCheck",
    icon = "Dungeon_Icon_VulnerabilityCheck",
    id = 4,
    name_cn = 504645,
    name_en = "-  V  U  L  N  E  R  A  B  I  L  I  T  Y    C  H  E  C  K  -",
    system_id = 201
  },
  {
    Image = "Dungeon_Image_FaultProtocol",
    icon = "Dungeon_Icon_FaultProtocol",
    id = 5,
    name_cn = 82634,
    name_en = "-  E  X  C  E  P  T  I  O  N    P  R  O  T  O  C  O  L  -",
    order = 2,
    system_id = 301
  }
}
local __default_values = {
  Image = "Dungeon_Image_ AlgorithmCollection",
  icon = "Dungeon_Icon_AlgorithmCollection",
  id = 1,
  name_cn = 105999,
  name_en = "-  A  L  G  O  R  I  T  H  M    C  O  L  L  E  C  T  I  O  N  -",
  order = 1,
  privilege_id = 0,
  system_id = 101
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(sector_entrance_dungeon) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  id_sort_list = {
    4,
    5,
    1,
    3,
    2
  }
}
setmetatable(sector_entrance_dungeon, {__index = __rawdata})
return sector_entrance_dungeon
