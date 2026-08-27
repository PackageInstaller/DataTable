eItemType = {
  Resource = 1,
  GrowUp = 2,
  BattleUse = 3,
  ExplorationUse = 4,
  HeroCard = 5,
  ExplorationBuffer = 6,
  GlobalChip = 7,
  Package = 8,
  LimitRes = 9,
  FactoryRes = 10,
  Arithmetic = 11,
  DormRoom = 12,
  DormFurniture = 13,
  AutoGenerateResource = 14,
  Skin = 15,
  Avatar = 16,
  AvatarFrame = 17,
  BackgroudPlate = 18,
  BattlePassPoint = 19,
  MainBackgroud = 20,
  Title = 23,
  TitleBackground = 24,
  RaffleBox = 25,
  FairyCard = 27,
  ItemTypeMonsterCard = 29
}
eEpEvtChoiceGetNewType = {
  item = 1,
  expBuff = 4,
  chipSwap = 5
}
ItemTypeMax = 29
ConstGlobalItem = {
  EpMoney = 1,
  WCDeployPoint = 12,
  WCMoney = 13,
  RareMoney = 22,
  DmHouseTicket = 908,
  HeroGoLevel20 = 909,
  HeroGoLevel40 = 910,
  HeroGoLevel60 = 911,
  PaidQZ = 1000,
  PaidItem = 1001,
  PaidSubItem = 1002,
  NormalGold = 1003,
  SKey = 1007,
  HeroExp = 1012,
  FairyExp = 1920,
  FairyStarUpItem = 1922,
  FairyRecombineItem = 1923,
  DormCoin = 1018,
  Blitz = 1014,
  BpSkinCoin = 1050,
  BuildBlueprint = 1500,
  SkinTicket = 1020,
  SkinUpTicket = 1068,
  LotteryTicket1 = 3001,
  FairyLotteryTicket = 3002,
  LotteryTicket2 = 3005,
  ADCUnlockItem = 1047,
  WhiteTimeShort = 1033,
  ActivityToken = 1060,
  VowCoin = 1080,
  VowRing = 1081,
  SkinLimit = 1086,
  StaminaLimitTimeSmall = 5012,
  StaminaLimitTimeMedium = 5013,
  StaminaLimitTimeLarge = 5014,
  ResidentBpGift = 8287,
  ProfessorBodyHead = 420002,
  ProfessorGridHead = 420003
}

function ConstGlobalItem.IsQZ(itemId)
  return itemId == ConstGlobalItem.PaidQZ or itemId == ConstGlobalItem.PaidItem
end

eItemQualityType = {
  White = 1,
  Green = 2,
  Blue = 3,
  Purple = 4,
  Orange = 5
}
ItemQualityColor = {
  [eItemQualityType.White] = Color.New(0.603, 0.603, 0.603, 1),
  [eItemQualityType.Green] = Color.New(0.458, 0.725, 0.364, 1),
  [eItemQualityType.Blue] = Color.New(0, 0.592, 0.862, 1),
  [eItemQualityType.Purple] = Color.New(0.76, 0.333, 0.701, 1),
  [eItemQualityType.Orange] = Color.New(1, 0.517, 0, 1)
}
ItemQualitySprite = {
  [eItemQualityType.White] = "ItemQuailty_1",
  [eItemQualityType.Green] = "ItemQuailty_2",
  [eItemQualityType.Blue] = "ItemQuailty_3",
  [eItemQualityType.Purple] = "ItemQuailty_4",
  [eItemQualityType.Orange] = "ItemQuailty_5"
}
ItemQualityColorName = {
  [eItemQualityType.White] = 981,
  [eItemQualityType.Green] = 982,
  [eItemQualityType.Blue] = 983,
  [eItemQualityType.Purple] = 984,
  [eItemQualityType.Orange] = 985
}
ItemEffPatch = {
  [eItemQualityType.White] = "FX/UI_effct/Get/FX_Get-white.prefab",
  [eItemQualityType.Green] = "FX/UI_effct/Get/FX_Get-green.prefab",
  [eItemQualityType.Blue] = "FX/UI_effct/Get/FX_Get-blue.prefab",
  [eItemQualityType.Purple] = "FX/UI_effct/Get/FX_Get-purple.prefab",
  [eItemQualityType.Orange] = "FX/UI_effct/Get/FX_Get-golden.prefab",
  loop = "FX/UI_effct/Get/FX_Get-loop.prefab",
  greetLoop = "FX/UI_effct/UINBaseItem/FX_UINBaseItem_04.prefab",
  greetBlastThenLoop = "FX/UI_effct/UINBaseItem/FX_UINBaseItem_03.prefab"
}
eItemActionType = {
  FixedGiftPackage = 801,
  CurrencyReplace = 1001,
  HeroExp = 2001,
  CommanderSkillExp = 3001,
  HeroCard = 4001,
  HeroCardFrag = 4002,
  BuildingAcc = 5001,
  AthAreaExp = 6001,
  ActExp = 1101,
  ActAcc = 1100,
  QuickBuy = 8001,
  Fairy = 9001
}
eItemTransType = {actMoneyX = 1001, actItemOverFlow = 1002}
eItemAvailableType = {
  NotUse = 0,
  Useable = 1,
  AutoUse = 2
}
ConstWCShowCoin = {
  [ConstGlobalItem.WCDeployPoint] = 1,
  [ConstGlobalItem.WCMoney] = 2
}
eChipDetailPowerType = {
  Add = 1,
  None = 0,
  Subtract = -1
}
eChipLevelToQaulity = {
  [1] = eItemQualityType.Blue,
  [2] = eItemQualityType.Purple,
  [3] = eItemQualityType.Orange
}
eHeroRareToQaulity = {
  [1] = eItemQualityType.Blue,
  [2] = eItemQualityType.Purple,
  [3] = eItemQualityType.Orange
}
local QZ = {1001, 1000}
eItemMergeDic = {
  [1000] = QZ,
  [1001] = QZ
}

function eItemMergeDic.AddItemMergeCfg(itemId, itemIdMergeList)
  eItemMergeDic[itemId] = itemIdMergeList
end

ChipDetailColor = {
  [eItemQualityType.Blue] = {
    normal = Color.New(0.27, 0.392, 0.462, 1),
    light = Color.New(0.309, 0.592, 0.764, 1)
  },
  [eItemQualityType.Purple] = {
    normal = Color.New(0.403, 0.36, 0.541, 1),
    light = Color.New(0.525, 0.411, 0.749, 1)
  },
  [eItemQualityType.Orange] = {
    normal = Color.New(0.403, 0.286, 0.176, 1),
    light = Color.New(0.866, 0.705, 0.2, 1)
  }
}
ChipDetailEffPatch = {
  [eItemQualityType.Blue] = "FX/UI_effct/UINBaseChipDetail/FXP_UINBaseChipDetail-Blue.prefab",
  [eItemQualityType.Purple] = "FX/UI_effct/UINBaseChipDetail/FXP_UINBaseChipDetail-Purple.prefab",
  [eItemQualityType.Orange] = "FX/UI_effct/UINBaseChipDetail/FXP_UINBaseChipDetail-golden.prefab"
}
RainDetailEffPath = "FX/UI_effct/UINBaseChipDetail/FXP_UINBaseChipDetail-rainbow.prefab"
eHeadFrameFxType = {
  None = 0,
  Particle = 1,
  Sequence = 2
}
eLimitTimeItemType = {
  None = 0,
  Fixed = 1,
  Dyn = 2
}
StaminaLimitTimeItemDic = {
  [ConstGlobalItem.StaminaLimitTimeSmall] = true,
  [ConstGlobalItem.StaminaLimitTimeMedium] = true,
  [ConstGlobalItem.StaminaLimitTimeLarge] = true
}
HeroGoLevelItemDic = {
  [ConstGlobalItem.HeroGoLevel20] = true,
  [ConstGlobalItem.HeroGoLevel40] = true,
  [ConstGlobalItem.HeroGoLevel60] = true
}
