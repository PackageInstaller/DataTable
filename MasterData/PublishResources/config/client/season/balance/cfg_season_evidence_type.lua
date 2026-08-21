local key = {
  ID = 1,
  Name = 2,
  Img = 3,
  Pos = 4,
  Size = 5,
  Rot = 6
}
local common = {
  {196, 142}
}
local config = {
  {
    1,
    "str_season_s2_evidence_type_1",
    "exp_s2_tp_image03",
    {2, -4},
    common[1],
    80
  },
  {
    2,
    "str_season_s2_evidence_type_2",
    "exp_s2_tp_image04",
    {-2, -7},
    common[1],
    8
  },
  {
    3,
    "str_season_s2_evidence_type_3",
    "exp_s2_tp_image01",
    {7, 0},
    {174, 126},
    -35
  }
}
return config, "ID", key
