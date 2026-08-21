local key = {
  ID = 1,
  ConditionStr = 2,
  LevelConditionStr = 3,
  DropName = 4,
  DropIconImg = 5,
  DropIconAtlas = 6,
  GrowEffect = 7,
  PathEffect = 8
}
local common = {
  "str_battle_alchemy_collect"
}
local config = {
  {
    1,
    "str_battle_drop_collect",
    nil,
    nil,
    nil,
    nil,
    "UIEff_CollectDropInfo_Glow.prefab",
    "UIEff_CollectDropInfo_Trail.prefab"
  },
  {
    2,
    common[1],
    common[1],
    "str_item_3000013",
    "cn20_jn_di02",
    "UICN20N49.spriteatlas"
  }
}
return config, "ID", key
