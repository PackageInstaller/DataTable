local key = {
  ID = 1,
  uiName = 2,
  widgetName = 3,
  type = 4,
  atlasName = 5,
  spriteName = 6,
  imageColor = 7,
  rawImageName = 8,
  textStrId = 9,
  textColor = 10,
  outlineColor = 11,
  active = 12
}
local common = {
  "RawImage",
  "n45bp_buy_head1"
}
local config = {
  [5115] = {
    5115,
    "UIBattlePassCN1GiftBoard_mainImg",
    "_advanced",
    common[1],
    nil,
    nil,
    nil,
    common[2]
  },
  [6102] = {
    6102,
    "UIBattlePassCN1BuyGiftResultController",
    "_bgIcon_Elite",
    common[1],
    nil,
    nil,
    nil,
    common[2]
  },
  [6304] = {
    6304,
    "UIBattlePassCN1PreviewController",
    "_rawCard",
    common[1],
    nil,
    nil,
    nil,
    "n45_bp_yl_card"
  }
}
return config, "ID", key
