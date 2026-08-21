local key = {
  ID = 1,
  UIController = 2,
  UIType = 3
}
local common = {
  "str_quest_base_type_side",
  "str_quest_base_type_growth",
  "str_quest_base_type_achieve"
}
local config = {
  {
    1,
    "UIDiscovery",
    1
  },
  {
    2,
    "UIResEntryController",
    2
  },
  {
    3,
    common[1],
    3
  },
  {
    4,
    common[2],
    4
  },
  {
    5,
    common[3],
    5
  },
  {
    6,
    common[1],
    6
  },
  {
    7,
    common[2],
    7
  },
  {
    8,
    common[3],
    8
  }
}
return config, "ID", key
