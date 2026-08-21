local key = {
  ID = 1,
  ComponentID = 2,
  CostItemID = 3,
  InitItem = 4
}
local common = {
  {
    {3000028, 1}
  }
}
local config = {
  {
    1,
    120505401,
    3000027
  },
  {
    2,
    120705401,
    3000028,
    common[1]
  },
  {
    3,
    506005401,
    7000714
  },
  {
    4,
    888805401,
    3000028,
    common[1]
  }
}
return config, "ID", key
