local key = {
  LineID = 1,
  ComponentID = 2,
  TeamOrder = 3,
  TeamName = 4,
  TeamIcon = 5,
  TeamHeadIcon = 6
}
local common = {
  "n30_wt_ld_head001",
  "n30_wt_ld_head01"
}
local config = {
  {
    1,
    109301805,
    "str_n30_entrust_team_order1",
    "str_n30_entrust_team1",
    common[1],
    common[2]
  },
  {
    2,
    109301805,
    "str_n30_entrust_team_order2",
    "str_n30_entrust_team2",
    common[1],
    common[2]
  },
  {
    3,
    109301805,
    "str_n30_entrust_team_order3",
    "str_n30_entrust_team3",
    "n30_wt_ld_head002",
    "n30_wt_ld_head02"
  }
}
return config, "LineID", key
