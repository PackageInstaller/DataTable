local CommonDef = require("cs_share.common_define")
local Cfg = {}
local nameToIdCfg = {
  battle_item = ShareRes.create("battle.battle_item_name_to_id"),
  item = ShareRes.create("item.item_name_to_id")
}
Cfg.MAX_CAPACITY = {
  [8] = 100,
  [9] = 100
}
Cfg.CURRENCY = {
  [1] = nameToIdCfg.battle_item["特异币"],
  [2] = nameToIdCfg.battle_item["生命符文经验"],
  [3] = nameToIdCfg.battle_item["物攻符文经验"],
  [4] = nameToIdCfg.battle_item["魔攻符文经验"],
  [5] = nameToIdCfg.battle_item["防御符文经验"]
}
Cfg.SHOW_CURRENCY = {
  [1] = nameToIdCfg.battle_item["特异币"]
}
Cfg.RUNE_EXP = {
  [1] = nameToIdCfg.battle_item["生命符文经验"],
  [2] = nameToIdCfg.battle_item["物攻符文经验"],
  [3] = nameToIdCfg.battle_item["魔攻符文经验"],
  [4] = nameToIdCfg.battle_item["防御符文经验"]
}
Cfg.Type = {
  ITEM = 1,
  COLLECT = 2,
  STORY = 3
}
Cfg.BagType = {ITEM = 8, COLLECT = 9}
Cfg.CollectType = {
  COMMON = CommonDef.BATTLE_COLLECTION_TYPE.NORMAL,
  SUIT = CommonDef.BATTLE_COLLECTION_TYPE.SUIT,
  EQUIP = CommonDef.BATTLE_COLLECTION_TYPE.WEAPON
}
Cfg.EquipSrc = {Hero = 1, Bag = 2}
Cfg.CONSUMABLES = "consumable"
Cfg.ITEM_TYPE = {CURRENCY = "currency", CONSUMABLES = "consumable"}
Cfg.Weapon_Part = {
  [1] = Util.format_str("攻击"),
  [2] = Util.format_str("防御"),
  [3] = Util.format_str("神秘")
}
Cfg.Quality_Color = {
  [1] = Util.get_unity_color_by_hex(tonumber("62AAD3", 16)),
  [2] = Util.get_unity_color_by_hex(tonumber("62AAD3", 16)),
  [3] = Util.get_unity_color_by_hex(tonumber("62AAD3", 16)),
  [4] = Util.get_unity_color_by_hex(tonumber("A942D1", 16)),
  [5] = Util.get_unity_color_by_hex(tonumber("F79934", 16))
}
Cfg.Quality_Color_New = {
  [1] = Util.get_unity_color_by_hex(tonumber("678CD6", 16)),
  [2] = Util.get_unity_color_by_hex(tonumber("678CD6", 16)),
  [3] = Util.get_unity_color_by_hex(tonumber("678CD6", 16)),
  [4] = Util.get_unity_color_by_hex(tonumber("9366D9", 16)),
  [5] = Util.get_unity_color_by_hex(tonumber("D9A24E", 16))
}
Cfg.Quality_Img = {
  [1] = "UICommon/Common_pzk_01",
  [2] = "UICommon/Common_pzk_02",
  [3] = "UICommon/Common_pzk_02",
  [4] = "UICommon/Common_pzk_03",
  [5] = "UICommon/Common_pzk_04"
}
Cfg.ATTR_ITEM_TYPE = {Type = 4, SubType = 1}
Cfg.CONSUMABLES_ITEM_TYPE = {Type = 2, SubType = 1}
Cfg.INIT_BOX_LAYOUT = {LEFT = 1, RIGHT = 2}
Cfg.TIPS_SOURCE = {
  BAG = 1,
  SHOP = 2,
  INIT_BOX = 3,
  OTHER = 10
}
Cfg.BAG_SOURCE = {NONE = 1, SHOP = 2}
Cfg.EQUIP_TYPE = {ATTACK = 1, DEFEND = 2}
Cfg.ITEM_BUFF_TYPE = {
  BATTLE_ADD_MONEY = 1,
  ENHANCE_ATTR_MAGIC = 2,
  RECYCLE_ADD_MONEY = 3,
  JOB_ATTR_ALIGNMENT = 4,
  ITEM_STOCK = 5
}
Cfg.USE_ITEM_TYPE = {
  [2] = {1},
  [3] = {2},
  [8] = {1, 2},
  [9] = {
    1,
    2,
    3,
    4,
    5,
    6
  }
}
Cfg.BATTLE_ITEM_TYPE = {
  RUNE = 10,
  ORNAMENTS = 11,
  MAIN_COLLECTION = 12
}
return Cfg
