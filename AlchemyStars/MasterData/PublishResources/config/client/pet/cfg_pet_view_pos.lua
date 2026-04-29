local key = {
  ID = 1,
  CgOffset = 2,
  SpineOffset = 3
}
local common = {
  {0, 0}
}
local config = {
  [1600011] = {
    1600011,
    common[1],
    common[1]
  }
}
return config, "ID", key
