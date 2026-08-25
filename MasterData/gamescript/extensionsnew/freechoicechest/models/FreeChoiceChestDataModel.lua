local FreeChoiceChestDataModel, Super = NewClass("FreeChoiceChestDataModel", BaseModel)

function FreeChoiceChestDataModel:OnInit()
  self:OnReset()
end

function FreeChoiceChestDataModel:OnReset()
  self._chestItemTid = nil
  self._isAwakerChest = nil
  self._isWeaponChest = nil
  self._itemInfos = {}
  self._currSelectedIdx = 1
end

function FreeChoiceChestDataModel:SetChestItemTid(chestItemTid)
  self._chestItemTid = chestItemTid
  self._itemInfos = {}
  self:_BuildItemInfos()
end

function FreeChoiceChestDataModel:SetCurrSelectedIdx(idx)
  self._currSelectedIdx = idx
  self:LocalNotify(NotifyId.OnFreeChoiceChestSelectionChanged)
end

function FreeChoiceChestDataModel:GetChestItemTid()
  return self._chestItemTid
end

function FreeChoiceChestDataModel:GetCurrSelectedIdx()
  return self._currSelectedIdx
end

function FreeChoiceChestDataModel:GetItemInfos()
  return self._itemInfos
end

function FreeChoiceChestDataModel:GetCurrSelectedItemInfo()
  return self._itemInfos[self._currSelectedIdx]
end

function FreeChoiceChestDataModel:GetItemInfoByIndex(idx)
  return self._itemInfos[idx]
end

function FreeChoiceChestDataModel:IsAwakerChest()
  return self._isAwakerChest
end

function FreeChoiceChestDataModel:IsWeaponChest()
  return self._isWeaponChest
end

function FreeChoiceChestDataModel:_BuildItemInfos()
  local chestItemCfg = DT.Item[self._chestItemTid]
  local dropId = chestItemCfg.SpParam[1]
  self._isAwakerChest = chestItemCfg.SubType == CommonDefine.ItemSubType.AwakerChest
  self._isWeaponChest = chestItemCfg.SubType == CommonDefine.ItemSubType.WeaponChest
  if self._isAwakerChest then
    self._itemInfos = self:_CreateItemInfo(dropId, function(dropItemCfg)
      local awakerTid = dropItemCfg.SpParam[1]
      do return AwakerDataUtils.HasOwnedAwaker end
      return AwakerDataUtils.HasOwnedAwaker, awakerTid
    end, function(itemCfg, dropIdx)
      do return self._CreateAwakerInfo, self, itemCfg end
      return self._CreateAwakerInfo, self, itemCfg, dropIdx
    end)
    self:_SortAwakerItemInfos()
  elseif self._isWeaponChest then
    self._itemInfos = self:_CreateItemInfo(dropId, function(dropItemCfg)
      do return ItemDataUtils.GetItemByTid end
      return ItemDataUtils.GetItemByTid, dropItemCfg.ID
    end, function(itemCfg, dropIdx)
      do return self._CreateWeaponInfo, self, itemCfg end
      return self._CreateWeaponInfo, self, itemCfg, dropIdx
    end)
    self:_SortWeaponItemInfos()
  else
    self._itemInfos = self:_CreateChipInfo(dropId)
  end
  self._currSelectedIdx = 1
end

function FreeChoiceChestDataModel:_CreateItemInfo(dropId, isAlreadyOwn, createItemInfo)
  local itemInfos = {}
  local dropCfg = DT.Drop[dropId]
  local now = TimeUtils.GetServerTime()
  for idx, drop in ipairs(dropCfg.data_list) do
    local dropItemCfg = DT.Item[drop.DropItem]
    if dropItemCfg.StartDropDate and now < dropItemCfg.StartDropDate then
    else
      table.insert(itemInfos, createItemInfo(dropItemCfg, idx))
    end
  end
  return itemInfos
end

function FreeChoiceChestDataModel:_CreateAwakerInfo(itemCfg, dropIdx)
  local awakerTid = itemCfg.SpParam[1]
  local awakerCfg = DT.AwakerConfig[awakerTid]
  local schoolCfg = DT.SchoolConfig[awakerCfg.School]
  local qualityCfg = DT.ItemQuality[awakerCfg.Quality]
  local alreadyOwned = false
  local maxPotency = false
  alreadyOwned = AwakerDataUtils.HasOwnedAwaker(awakerTid)
  if alreadyOwned then
    local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
    local potencyIdx = AwakerDataUtils.GetAwakerPotencyIndex(awakerTid, awakerData.potency)
    local numFragments = ItemDataUtils.GetItemNum(awakerCfg.AwakerSpecialItem)
    local costNumList = DT.GetOriginalConstant("AwakerPotencyUpgradeConsumeNum")
    maxPotency = potencyIdx + numFragments >= #costNumList
  end
  return {
    awakerTid = awakerTid,
    tid = itemCfg.ID,
    itemType = itemCfg.Type,
    name = LT.Text(awakerCfg.Name),
    icon = AwakerDataUtils.GetFullHeadIcon(awakerTid),
    quality = qualityCfg.AwakerWeaponSelectQualityColor,
    schoolIcon = schoolCfg.Icon,
    alreadyOwned = alreadyOwned,
    maxPotency = maxPotency,
    dropIdx = dropIdx
  }
end

function FreeChoiceChestDataModel:_CreateWeaponInfo(itemCfg, dropIdx)
  local qualityCfg = DT.ItemQuality[itemCfg.Quality]
  return {
    tid = itemCfg.ID,
    itemType = itemCfg.Type,
    name = LT.Text(itemCfg.Name),
    icon = itemCfg.SpIcon,
    quality = qualityCfg.AwakerWeaponSelectQualityColor,
    alreadyOwned = ItemDataUtils.GetItemByTid(itemCfg.ID) ~= nil,
    dropIdx = dropIdx
  }
end

function FreeChoiceChestDataModel:_CreateChipInfo(dropId)
  local useAwakerChipList = ItemDataUtils.GetUseAwakerChipList(dropId)
  local chipInfoData = {}
  for _, chip in ipairs(useAwakerChipList) do
    local itemCfg = DT.Item[chip.tid]
    local isAwakerChip = itemCfg.SubType == CommonDefine.ItemSubType.AwakerChip
    local chipData = {
      alreadyOwned = isAwakerChip and AwakerDataUtils.HasOwnedAwaker(itemCfg.SpParam[1]) or false,
      schoolIcon = isAwakerChip and AwakerDataUtils.GetAwakerSchoolIcon(itemCfg.SpParam[1]) or "",
      maxPotency = isAwakerChip and ItemDataUtils.IsAwakerChipOverFlow(chip.tid) or false,
      SubType = itemCfg.SubType,
      awakerTid = isAwakerChip and itemCfg.SpParam[1] or nil,
      tid = chip.tid,
      icon = isAwakerChip and AwakerDataUtils.GetAwakerDefaultBust(itemCfg.SpParam[1]) or itemCfg.Icon,
      name = LT.Text(itemCfg.Name),
      quality = DT.ItemQuality[itemCfg.Quality].AwakerWeaponSelectQualityColor
    }
    table.insert(chipInfoData, chipData)
  end
  return chipInfoData
end

function FreeChoiceChestDataModel:_SortAwakerItemInfos()
  table.sort(self._itemInfos, function(a, b)
    if not a.alreadyOwned and b.alreadyOwned then
      return true
    end
    if a.alreadyOwned and not b.alreadyOwned then
      return false
    end
    if not a.maxPotency and b.maxPotency then
      return true
    end
    if a.maxPotency and not b.maxPotency then
      return false
    end
    return a.dropIdx < b.dropIdx
  end)
end

function FreeChoiceChestDataModel:_SortWeaponItemInfos()
  table.sort(self._itemInfos, function(a, b)
    if not a.alreadyOwned and b.alreadyOwned then
      return true
    end
    if a.alreadyOwned and not b.alreadyOwned then
      return false
    end
    local aIsMaxPotency = MainShopDataUtils.IsMaxPotencyByItemId(a.tid) and 1 or 0
    local bIsMaxPotency = MainShopDataUtils.IsMaxPotencyByItemId(b.tid) and 1 or 0
    if aIsMaxPotency ~= bIsMaxPotency then
      return aIsMaxPotency < bIsMaxPotency
    end
    return a.dropIdx < b.dropIdx
  end)
end

return FreeChoiceChestDataModel
