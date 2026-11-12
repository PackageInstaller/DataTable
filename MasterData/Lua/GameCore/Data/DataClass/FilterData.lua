local FilterData = class("FilterData")
local LocalData = require("GameCore.Data.LocalData")

function FilterData:ctor()
end

function FilterData:Init()
  self.tbCacheFilter = {}
  self.tbFilter = {}
  for fKey, v in pairs(AllEnum.ChooseOptionCfg) do
    self.tbFilter[fKey] = {}
    for sKey, _ in pairs(v.items) do
      self.tbFilter[fKey][sKey] = false
    end
  end
  self.nFormationCharSrotType = AllEnum.SortType.Level
  self.bFormationCharOrder = false
  self.nFormationDiscSrotType = AllEnum.SortType.Level
  self.bFormationDiscOrder = false
  self.nDormCharSrotType = AllEnum.SortType.Rarity
  self.bDormCharOrder = true
  self.tbCacheOptionData = {}
end

function FilterData:Reset(tbOption)
  if tbOption == nil then
    return
  end
  self.tbCacheFilter = {}
  for fKey, _ in pairs(self.tbFilter) do
    if table.indexof(tbOption, fKey) > 0 then
      for sKey, _ in pairs(self.tbFilter[fKey]) do
        self.tbFilter[fKey][sKey] = false
      end
    end
  end
end

function FilterData:IsDirty(optionType)
  if optionType == AllEnum.OptionType.Char then
    local dirty = self:_IsDirty(AllEnum.ChooseOption.Char_Element)
    dirty = dirty or self:_IsDirty(AllEnum.ChooseOption.Char_Rarity)
    dirty = dirty or self:_IsDirty(AllEnum.ChooseOption.Char_PowerStyle)
    dirty = dirty or self:_IsDirty(AllEnum.ChooseOption.Char_TacticalStyle)
    dirty = dirty or self:_IsDirty(AllEnum.ChooseOption.Char_AffiliatedForces)
    return dirty
  elseif optionType == AllEnum.OptionType.Disc then
    local dirty = self:_IsDirty(AllEnum.ChooseOption.Star_Element)
    dirty = dirty or self:_IsDirty(AllEnum.ChooseOption.Star_Rarity)
    dirty = dirty or self:_IsDirty(AllEnum.ChooseOption.Star_Note)
    dirty = dirty or self:_IsDirty(AllEnum.ChooseOption.Star_Tag)
    return dirty
  elseif optionType == AllEnum.OptionType.Equipment then
    local dirty = self:_IsDirty(AllEnum.ChooseOption.Equip_Rarity)
    dirty = dirty or self:_IsDirty(AllEnum.ChooseOption.Equip_Type)
    dirty = dirty or self:_IsDirty(AllEnum.ChooseOption.Equip_Theme_Circle)
    dirty = dirty or self:_IsDirty(AllEnum.ChooseOption.Equip_Theme_Square)
    dirty = dirty or self:_IsDirty(AllEnum.ChooseOption.Equip_Theme_Pentagon)
    dirty = dirty or self:_IsDirty(AllEnum.ChooseOption.Equip_PowerStyle)
    dirty = dirty or self:_IsDirty(AllEnum.ChooseOption.Equip_TacticalStyle)
    dirty = dirty or self:_IsDirty(AllEnum.ChooseOption.Equip_AffiliatedForces)
    dirty = dirty or self:_IsDirty(AllEnum.ChooseOption.Equip_Match)
    return dirty
  end
  return false
end

function FilterData:IsDirtyByOption(tbOption)
  for _, fKey in ipairs(tbOption) do
    for _, result in pairs(self.tbFilter[fKey]) do
      if result == true then
        return true
      end
    end
  end
  return false
end

function FilterData:_IsDirty(fKey)
  for _, result in pairs(self.tbFilter[fKey]) do
    if result == true then
      return true
    end
  end
  return false
end

function FilterData:CheckFilterByChar(charId)
  local charData = ConfigTable.GetData_Character(charId)
  local mapCharDescCfg = ConfigTable.GetData("CharacterDes", charId)
  local isFilter = true
  if mapCharDescCfg == nil or charData == nil then
    return isFilter
  end
  isFilter = self:_GetFilterByKey(AllEnum.ChooseOption.Char_Element, charData.EET)
  isFilter = isFilter and self:_GetFilterByKey(AllEnum.ChooseOption.Char_Rarity, charData.Grade)
  isFilter = isFilter and self:_GetFilterByKey(AllEnum.ChooseOption.Char_PowerStyle, charData.Class)
  isFilter = isFilter and self:_GetFilterByKey(AllEnum.ChooseOption.Char_TacticalStyle, mapCharDescCfg.Tag[2])
  isFilter = isFilter and self:_GetFilterByKey(AllEnum.ChooseOption.Char_AffiliatedForces, mapCharDescCfg.Tag[3])
  return isFilter
end

function FilterData:CheckFilterByCharAndOption(charId, tbOption)
  local charData = ConfigTable.GetData_Character(charId)
  local mapCharDescCfg = ConfigTable.GetData("CharacterDes", charId)
  local isFilter = true
  if mapCharDescCfg == nil or charData == nil then
    return isFilter
  end
  if table.indexof(tbOption, AllEnum.ChooseOption.Char_Element) > 0 then
    isFilter = self:_GetFilterByKey(AllEnum.ChooseOption.Char_Element, charData.EET)
  end
  if 0 < table.indexof(tbOption, AllEnum.ChooseOption.Char_Rarity) and isFilter then
    isFilter = self:_GetFilterByKey(AllEnum.ChooseOption.Char_Rarity, charData.Grade)
  end
  if 0 < table.indexof(tbOption, AllEnum.ChooseOption.Char_PowerStyle) and isFilter then
    isFilter = self:_GetFilterByKey(AllEnum.ChooseOption.Char_PowerStyle, charData.Class)
  end
  if 0 < table.indexof(tbOption, AllEnum.ChooseOption.Char_TacticalStyle) and isFilter then
    isFilter = self:_GetFilterByKey(AllEnum.ChooseOption.Char_TacticalStyle, mapCharDescCfg.Tag[2])
  end
  if 0 < table.indexof(tbOption, AllEnum.ChooseOption.Char_AffiliatedForces) and isFilter then
    isFilter = self:_GetFilterByKey(AllEnum.ChooseOption.Char_AffiliatedForces, mapCharDescCfg.Tag[3])
  end
  return isFilter
end

function FilterData:CheckFilterByDisc(discId)
  local discCfg = ConfigTable.GetData("Disc", discId)
  local discData = PlayerData.Disc:GetDiscById(discId)
  local isFilter = true
  isFilter = self:_GetFilterByKey(AllEnum.ChooseOption.Star_Element, discData.nEET)
  isFilter = isFilter and self:_GetFilterByKey(AllEnum.ChooseOption.Star_Rarity, discData.nRarity)
  local isFilter2 = true
  local A = {}
  for _, noteId in ipairs(discData.tbShowNote or {}) do
    A[noteId] = true
  end
  for sKey, v in pairs(self.tbFilter[AllEnum.ChooseOption.Star_Note]) do
    if v == true and A[sKey] == nil then
      isFilter2 = false
    end
  end
  isFilter = isFilter and isFilter2
  local isFilter3 = true
  local B = {}
  for _, tagId in pairs(discData.tbTag or {}) do
    B[tagId] = true
  end
  for sKey, v in pairs(self.tbFilter[AllEnum.ChooseOption.Star_Tag]) do
    if v == true and B[sKey] == nil then
      isFilter3 = false
    end
  end
  isFilter = isFilter and isFilter3
  return isFilter
end

function FilterData:CheckFilerByEquip(equipId, nCharId)
  local equipmentData = PlayerData.Equipment:GetEquipmentById(equipId)
  local isFilter = true
  local nEquipType = equipmentData:GetType()
  isFilter = isFilter and self:_GetFilterByKey(AllEnum.ChooseOption.Equip_Rarity, equipmentData:GetRarity())
  isFilter = isFilter and self:_GetFilterByKey(AllEnum.ChooseOption.Equip_Type, nEquipType)
  local tbBaseAttrDescId = equipmentData:GetBaseAttrDescId()
  local tbSelectAttr = {}
  local tbCurAttr = {}
  if nEquipType == GameEnum.equipmentType.Square then
    tbCurAttr = self.tbFilter[AllEnum.ChooseOption.Equip_Theme_Square]
  elseif nEquipType == GameEnum.equipmentType.Circle then
    tbCurAttr = self.tbFilter[AllEnum.ChooseOption.Equip_Theme_Circle]
  elseif nEquipType == GameEnum.equipmentType.Pentagon then
    tbCurAttr = self.tbFilter[AllEnum.ChooseOption.Equip_Theme_Pentagon]
  end
  for nKey, v in pairs(tbCurAttr) do
    if v then
      tbSelectAttr[nKey] = 1
    end
  end
  local bAttr = true
  if next(tbSelectAttr) ~= nil then
    bAttr = false
    for _, id in ipairs(tbBaseAttrDescId) do
      if tbSelectAttr[id] ~= nil then
        bAttr = true
        break
      end
    end
    isFilter = isFilter and bAttr
  end
  local tbTag = equipmentData:GetTag()
  local tbSelectTag = {}
  for nKey, v in pairs(self.tbFilter[AllEnum.ChooseOption.Equip_PowerStyle]) do
    if v then
      tbSelectTag[nKey] = 1
    end
  end
  local bTag = true
  if next(tbSelectTag) ~= nil then
    bTag = false
    for _, tag in ipairs(tbTag) do
      if tbSelectTag[tag] ~= nil then
        bTag = true
        break
      end
    end
    isFilter = isFilter and bTag
  end
  tbSelectTag = {}
  for nKey, v in pairs(self.tbFilter[AllEnum.ChooseOption.Equip_TacticalStyle]) do
    if v then
      tbSelectTag[nKey] = 1
    end
  end
  if next(tbSelectTag) ~= nil then
    bTag = false
    for _, tag in ipairs(tbTag) do
      if tbSelectTag[tag] ~= nil then
        bTag = true
        break
      end
    end
    isFilter = isFilter and bTag
  end
  tbSelectTag = {}
  for nKey, v in pairs(self.tbFilter[AllEnum.ChooseOption.Equip_AffiliatedForces]) do
    if v then
      tbSelectTag[nKey] = 1
    end
  end
  if next(tbSelectTag) ~= nil then
    bTag = false
    for _, tag in ipairs(tbTag) do
      if tbSelectTag[tag] ~= nil then
        bTag = true
        break
      end
    end
    isFilter = isFilter and bTag
  end
  if nCharId ~= nil then
    local nMatchCount = equipmentData:GetTagMatchCount(nCharId)
    isFilter = isFilter and self:_GetFilterByKey(AllEnum.ChooseOption.Equip_Match, nMatchCount)
  end
  return isFilter
end

function FilterData:_GetFilterByKey(fKey, sKey)
  local isAllFalse = false
  for optionKey, _ in pairs(self.tbFilter[fKey]) do
    isAllFalse = isAllFalse or self.tbFilter[fKey][optionKey]
  end
  if not isAllFalse then
    return true
  end
  return self.tbFilter[fKey][sKey]
end

function FilterData:GetFilterByKey(fKey, sKey)
  return self.tbFilter[fKey][sKey]
end

function FilterData:CacheFilterByOption(tbOption)
  self.tbCacheOptionData = {}
  for fKey, v in ipairs(self.tbFilter) do
    if table.indexof(tbOption, fKey) > 0 then
      self.tbCacheOptionData[fKey] = clone(v)
    end
  end
end

function FilterData:ResetCacheFilter()
  for fKey, v in pairs(self.tbCacheOptionData) do
    self.tbFilter[fKey] = v
  end
  self.tbCacheOptionData = {}
end

function FilterData:SetCacheFilterByKey(fKey, sKey, flag)
  if self.tbCacheFilter[fKey] == nil then
    self.tbCacheFilter[fKey] = {}
  end
  self.tbCacheFilter[fKey][sKey] = flag
end

function FilterData:SyncFilterByCache()
  for fKey, v in pairs(self.tbCacheFilter) do
    for sKey, vv in pairs(v) do
      self.tbFilter[fKey][sKey] = vv
    end
  end
end

function FilterData:GetCacheFilterByKey(fKey, sKey)
  if nil ~= self.tbCacheFilter[fKey] and nil ~= self.tbCacheFilter[fKey][sKey] then
    return self.tbCacheFilter[fKey][sKey], true
  end
  return self:GetFilterByKey(fKey, sKey), false
end

function FilterData:GetCacheFilter(fKey)
  if nil ~= self.tbCacheFilter[fKey] then
    return self.tbCacheFilter[fKey]
  end
end

function FilterData:CacheCharSort(nType, bOrder)
  self.nFormationCharSrotType = nType
  self.bFormationCharOrder = bOrder
  LocalData.SetPlayerLocalData("FormationCharSrotType", self.nFormationCharSrotType)
  LocalData.SetPlayerLocalData("FormationCharOrder", self.bFormationCharOrder)
end

function FilterData:CacheDiscSort(nType, bOrder)
  self.nFormationDiscSrotType = nType
  self.bFormationDiscOrder = bOrder
  LocalData.SetPlayerLocalData("FormationDiscSrotType", self.nFormationDiscSrotType)
  LocalData.SetPlayerLocalData("FormationDiscOrder", self.bFormationDiscOrder)
end

function FilterData:CacheDormSort(nType, bOrder)
  self.nDormCharSrotType = nType
  self.bDormCharOrder = bOrder
  LocalData.SetPlayerLocalData("DormCharSrotType", self.nDormCharSrotType)
  LocalData.SetPlayerLocalData("DormCharOrder", self.bDormCharOrder)
end

function FilterData:InitSortData()
  self.nFormationCharSrotType = AllEnum.SortType.Level
  self.bFormationCharOrder = false
  self.nFormationDiscSrotType = AllEnum.SortType.Level
  self.bFormationDiscOrder = false
  self.nDormCharSrotType = AllEnum.SortType.Rarity
  self.bDormCharOrder = true
  self.nFormationCharSrotType = LocalData.GetPlayerLocalData("FormationCharSrotType") or AllEnum.SortType.Level
  self.bFormationCharOrder = LocalData.GetPlayerLocalData("FormationCharOrder") or false
  self.nFormationDiscSrotType = LocalData.GetPlayerLocalData("FormationDiscSrotType") or AllEnum.SortType.Level
  self.bFormationDiscOrder = LocalData.GetPlayerLocalData("FormationDiscOrder") or false
  self.nDormCharSrotType = LocalData.GetPlayerLocalData("DormCharSrotType") or AllEnum.SortType.Rarity
  self.bDormCharOrder = LocalData.GetPlayerLocalData("DormCharOrder") or true
end

return FilterData
