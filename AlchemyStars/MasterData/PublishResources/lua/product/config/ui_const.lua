local UIConst = {
  TurnTipsOutTick = 200,
  TurnTipsInTick = 200,
  TurnTipsStayTick = 500,
  UIDiscoveryUnlockShowTime = 2000,
  ConnectorString = "-",
  BranchMissionIndexPrefix = "S",
  IsShieldPay = false,
  End = 99999
}
_enum("UIConst", UIConst)
UIEnum = {}

function UIEnum.ItemColorFrame(color)
  if not UIEnum._itemColorFrame then
    UIEnum._itemColorFrame = {
      [ItemColor.ItemColor_White] = "spirit_shengji_se1",
      [ItemColor.ItemColor_Green] = "spirit_shengji_se2",
      [ItemColor.ItemColor_Blue] = "spirit_shengji_se3",
      [ItemColor.ItemColor_Purple] = "spirit_shengji_se4",
      [ItemColor.ItemColor_Yellow] = "spirit_shengji_se5",
      [ItemColor.ItemColor_Golden] = "spirit_shengji_se6"
    }
  end
  return UIEnum._itemColorFrame[color] or ""
end

local UIItemRandomType = {
  Guding = 1,
  DaGaiLv = 2,
  YiBanGaiLv = 3,
  XiaoGaiLv = 4,
  JiXiaoGaiLv = 5,
  TeBieDiaoLuo = 6
}
_enum("UIItemRandomType", UIItemRandomType)

function UIEnum.ItemRandomStr(randomType)
  if not randomType then
    return ""
  end
  if not UIEnum._itemRandomTypeStr then
    UIEnum._itemRandomTypeStr = {
      [UIItemRandomType.Guding] = StringTable.Get("str_item_guding"),
      [UIItemRandomType.DaGaiLv] = StringTable.Get("str_item_dagailv"),
      [UIItemRandomType.YiBanGaiLv] = StringTable.Get("str_item_yibangailv"),
      [UIItemRandomType.XiaoGaiLv] = StringTable.Get("str_item_xiaogailv"),
      [UIItemRandomType.JiXiaoGaiLv] = StringTable.Get("str_item_jixiaogailv"),
      [UIItemRandomType.TeBieDiaoLuo] = StringTable.Get("str_battle_special_drop")
    }
  end
  return UIEnum._itemRandomTypeStr[randomType] or ""
end

PetAwakeSpriteName = {
  [1] = {
    [0] = "spirit_juexing1_big0",
    [1] = "spirit_juexing1_big1"
  },
  [2] = {
    [0] = "spirit_juexing2_big0",
    [1] = "spirit_juexing2_big1",
    [2] = "spirit_juexing2_big2"
  },
  [3] = {
    [0] = "spirit_juexing3_big0",
    [1] = "spirit_juexing3_big1",
    [2] = "spirit_juexing3_big2",
    [3] = "spirit_juexing3_big3"
  }
}
PetAwakeSpriteGlowName = {
  [2] = {
    [1] = "spirit_juexing_icon6",
    [2] = "spirit_juexing_icon7"
  },
  [3] = {
    [1] = "spirit_juexing_icon6",
    [2] = "spirit_juexing_icon7",
    [3] = "spirit_juexing_icon8"
  }
}
