local key = {
  ID = 1,
  Name = 2,
  StageIndexTitle = 3,
  FullName = 4,
  Des = 5,
  StoryList = 6
}
local common = {
  "str_n14_mission_sidename_1"
}
local config = {
  {
    1,
    common[1],
    "str_n14_1_Index",
    common[1],
    "str_n13_1_desc_long",
    {
      {50210001, 1}
    }
  }
}
return config, "ID", key
