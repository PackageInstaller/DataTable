local key = {
  ID = 1,
  architecture_id = 2,
  Level = 3,
  LivableValue = 4,
  SkinIcon = 5,
  SkinName = 6,
  Des = 7,
  UseCondition = 8,
  UnLockCondition = 9
}
local common = {
  "str_homeland_skin_use_condition",
  "str_homeland_skin_unlock_des"
}
local config = {
  [5351001] = {
    5351001,
    5251001,
    1,
    0,
    "icon_item_5351001",
    "str_item_5351001",
    "str_item_intro_5351001",
    common[1],
    common[2]
  },
  [5352001] = {
    5352001,
    5252001,
    1,
    0,
    "icon_item_5352001",
    "str_item_5352001",
    "str_item_intro_5352001",
    common[1],
    common[2]
  },
  [5352002] = {
    5352002,
    5252001,
    7,
    0,
    "icon_item_5352002",
    "str_item_5352002",
    "str_item_intro_5352002",
    common[1],
    common[2]
  },
  [5352003] = {
    5352003,
    5252001,
    10,
    0,
    "icon_item_5352003",
    "str_item_5352003",
    "str_item_intro_5352003",
    common[1],
    common[2]
  },
  [5353001] = {
    5353001,
    5253001,
    1,
    0,
    "icon_item_5353001",
    "str_item_5353001",
    "str_item_intro_5353001",
    common[1],
    common[2]
  },
  [5353002] = {
    5353002,
    5253001,
    5,
    0,
    "icon_item_5353002",
    "str_item_5353002",
    "str_item_intro_5353002",
    common[1],
    common[2]
  },
  [5353003] = {
    5353003,
    5253001,
    8,
    0,
    "icon_item_5353003",
    "str_item_5353003",
    "str_item_intro_5353003",
    common[1],
    common[2]
  },
  [5354001] = {
    5354001,
    5254001,
    1,
    0,
    "icon_item_5354001",
    "str_item_5354001",
    "str_item_intro_5354001",
    common[1],
    common[2]
  },
  [5354002] = {
    5354002,
    5254001,
    6,
    0,
    "icon_item_5354002",
    "str_item_5354002",
    "str_item_intro_5354002",
    common[1],
    common[2]
  },
  [5354003] = {
    5354003,
    5254001,
    9,
    0,
    "icon_item_5354003",
    "str_item_5354003",
    "str_item_intro_5354003",
    common[1],
    common[2]
  },
  [5355001] = {
    5355001,
    5255001,
    1,
    0,
    "icon_item_5355001",
    "str_item_5355001",
    "str_item_intro_5355001",
    common[1],
    common[2]
  }
}
return config, "ID", key
