L_SortFilterConst = {}
L_SortFilterConst.FilterType = {
  Quality = 1,
  Element = 2,
  Nations = 3,
  Profession = 4,
  Species = 5,
  Food = 7,
  Suit = 8,
  LevelStatus = 9,
  EquipStatus = 10,
  All = 11,
  MoveType = 12,
  QiBoGrade = 13,
  QiBoBoxMode = 14,
  QiBoSpecial = 15,
  LockedStatus = 16,
  EquipQuality = 17,
  MainElement = 18,
  CollectProcess = 20,
  BookTag = 21,
  ItemRarity = 22,
  SpiritionRarity = 23,
  ExchangeProductType = 29,
  Gene = 31,
  QiBoQuality = 32,
  QiBoSpecialType = 33,
  BattleTag = 34
}

local function generateFilterTypeKeyName()
  L_SortFilterConst.FilterTypeKeyName = {}
  for k, v in pairs(L_SortFilterConst.FilterType) do
    L_SortFilterConst.FilterTypeKeyName[v] = string.format("Filter_%s", k)
  end
end

generateFilterTypeKeyName()
L_SortFilterConst.FilterId = {
  MaxLevel = 1,
  NotMaxLevel = 2,
  IsEquipped = 3,
  IsNotEquipped = 4,
  All = 5,
  MoveTypeRun = 6,
  MoveTypeFly = 7,
  MoveTypeSwim = 8,
  MoveTypeDive = 9,
  QiBoBoxMode = 10,
  PetSpeical = 11,
  PetNormal = 12,
  Locked = 13,
  UnLocked = 14,
  collected = 15,
  collecting = 16,
  unCollect = 17
}
L_SortFilterConst.SortOrFilter = {Sort = 1, Filter = 2}
L_SortFilterConst.SortFilterStyle = {
  Button = 1,
  Bar = 2,
  Dropdown = 3
}
L_SortFilterConst.SortType = {
  EquipBattleInfo = 1,
  Level = 2,
  Quality = 3,
  ConfigId = 4,
  ServerId = 5,
  EquipSetId = 6,
  BatchIndex = 7,
  Star = 8,
  Satiety = 9,
  MountSpeed = 10,
  MountMaxSpeed = 11,
  MountRouletteSlotId = 12,
  IsInMountRoulette = 13,
  isEquipped = 14,
  DisplayPos = 15,
  Rank = 16,
  IsUnlock = 17,
  QiBoGrade = 18,
  CurEditPosIndex = 19,
  MountGamePlayStatus = 20,
  isEquippedBySelf = 21,
  Element = 22,
  isSouleEssenceEquipped = 47,
  HomeExchangePriceChangeRate = 48
}

local function generateSortTypeKeyName()
  L_SortFilterConst.SortTypeKeyName = {}
  for k, v in pairs(L_SortFilterConst.SortType) do
    L_SortFilterConst.SortTypeKeyName[v] = string.format("Sort_%s", k)
  end
end

generateSortTypeKeyName()
