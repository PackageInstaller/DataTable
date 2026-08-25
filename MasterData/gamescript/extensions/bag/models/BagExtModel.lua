local BagExtModel, Super = NewClass("BagExtModel", BagItemsFilterModel)
local ItemType = CommonDefine.ItemType
local ItemSubType = CommonDefine.ItemSubType
local QualitySortID = CommonDefine.QualitySortID
local MAX_LOCK_STAGE_JUMP_NUM = 3

local function DefaultItemsSort(a, b)
  local aCfg = DT.Item[a.tid]
  local bCfg = DT.Item[b.tid]
  local aQualitySortWeight = QualitySortID[aCfg.Quality]
  local bQualitySortWeight = QualitySortID[bCfg.Quality]
  local aBaseSort = aCfg.BaseSortID
  local bBaseSort = bCfg.BaseSortID
  if aQualitySortWeight == bQualitySortWeight then
    return aBaseSort < bBaseSort
  end
  return aQualitySortWeight > bQualitySortWeight
end

function BagExtModel:OnInit()
  self:OnReset()
end

function BagExtModel:OnReset()
  Super.OnReset(self)
  self.currShowType = ItemType.Weapon
  self.chosenUid = 0
  self.specificOnceRedItemTypeMap = nil
end

function BagExtModel:GetCurChosenUid()
  return self.chosenUid
end

function BagExtModel:SetCurChosenUid(chosenUid)
  if self.chosenUid == chosenUid then
    return
  end
  self.chosenUid = chosenUid
  self:LocalNotify(NotifyId.OnBagItemChoosed, chosenUid)
end

function BagExtModel:GetCurShowType()
  return self.currShowType
end

function BagExtModel:SetCurShowType(currShowType)
  if currShowType == self.currShowType then
    return
  end
  self.currShowType = currShowType
  self:LocalNotify(NotifyId.OnBagItemTabChanged, currShowType)
end

function BagExtModel:GetItemTypeName()
  local itemType = self.currShowType
  local typeNameCn = string.format("Bag%sTitle", itemType)
  do return LT.Text end
  return LT.Text, typeNameCn
end

function BagExtModel:GetEmptyTips()
  local name = self:GetItemTypeName()
  local tips = LT.Textf("BagEmptyTitle", name)
  return tips
end

function BagExtModel:GetEmptySourceTips()
  local sourceTips = string.format("Bag%sEmptyDesc", self.currShowType)
  do return LT.Text end
  return LT.Text, sourceTips
end

function BagExtModel:GetItemPageMaxNum()
  local limitList = DT.GetOriginalConstant("BagCapacity")
  limitList[5] = #KeeperSkillUtils.GetKeeperSkillList()
  if not limitList then
    Logger.Info("找不到容量配置!")
    return {
      999,
      999,
      999,
      999,
      999
    }
  end
  return limitList
end

function BagExtModel:IsCanUse(uid)
  local item = ItemDataUtils.GetItemByUid(uid)
  if not item then
    return
  end
  local cfg = DT.Item[item.tid]
  if cfg.Type == CommonDefine.ItemType.Material then
    if cfg.SubType == CommonDefine.ItemSubType.FastPromotion then
      return true
    end
  elseif cfg.Type == CommonDefine.ItemType.Special then
    return true
  end
end

function BagExtModel:IsLessUseCount(uid)
  local item = ItemDataUtils.GetItemByUid(uid)
  local itemNum = ItemDataUtils.GetItemNum(item.tid)
  local minUseCount = ItemDataUtils.GetMinUseCount(item.tid)
  if itemNum < minUseCount then
    return true
  end
end

function BagExtModel:GetMaxItemNum()
  local currShowType = self.currShowType
  local limitList = self:GetItemPageMaxNum()
  if currShowType == ItemType.Weapon then
    return limitList[1]
  elseif currShowType == ItemType.Trinket then
    return limitList[2]
  elseif currShowType == ItemType.Material then
    return limitList[3]
  elseif currShowType == ItemType.Special then
    return limitList[4]
  elseif currShowType == ItemType.KeeperSkill then
    return limitList[5]
  end
  Logger.Info("意料之外的道具类型分页:", currShowType)
  return 999
end

function BagExtModel:GetCurItemList()
  local itemType = self.currShowType
  if itemType == ItemType.Weapon then
    do return self.GetWeaponItemList end
    return self.GetWeaponItemList, self
  elseif itemType == ItemType.Trinket then
    do return self.GetTrinketItemList end
    return self.GetTrinketItemList, self
  elseif itemType == ItemType.Material then
    do return self.GetMaterialItemList end
    return self.GetMaterialItemList, self
  elseif itemType == ItemType.Special then
    do return self.GetSpecialItemList end
    return self.GetSpecialItemList, self
  elseif itemType == ItemType.KeeperSkill then
    do return self.GetKeeperSkillItemList end
    return self.GetKeeperSkillItemList, self
  end
end

function BagExtModel:HasAnyTrinkets()
  do return self.HasAnyItems, self end
  return self.HasAnyItems, self, ItemType.Trinket
end

function BagExtModel:HasAnyWeapons()
  do return self.HasAnyItems, self end
  return self.HasAnyItems, self, ItemType.Weapon
end

function BagExtModel:HasAnyItems(itemType)
  local itemBagData = DataCenter.itemData.BagItemData
  for _, v in pairs(itemBagData) do
    if not v then
    else
      local config = DT.Item[v.tid]
      if config.Type == itemType then
        return true
      end
    end
  end
  return false
end

function BagExtModel:GetWeaponItemList()
  local itemBagData = DataCenter.itemData.BagItemData
  local list = {}
  local tmp = {}
  for _, v in pairs(itemBagData) do
    if not v then
    else
      local config = DT.Item[v.tid]
      if config and config.Type == ItemType.Weapon then
        table.insert(tmp, v)
      end
    end
  end
  tmp = AwakerTrinketDataUtils.WeaponSort(tmp, self.weaponSortType, self.weaponSortOrder)
  for _, v in ipairs(tmp) do
    local itemData = {
      tid = v.tid,
      uid = v.uid,
      showRedFunc = System.bind(self._GetItemShowRedFunc, self, v.tid, v.uid)
    }
    table.insert(list, itemData)
  end
  return list
end

function BagExtModel:_GetItemShowRedFunc(tid, uid)
  return self:_redFunc1(tid) or self:_redFunc2(uid, tid)
end

function BagExtModel:_redFunc1(tid)
  if not ItemDataUtils.IsSpecificOnceRedItem(tid) then
    return false
  end
  do return RedPointDataUtils.GetRedPointState, RedTypeDefine.RedType.SpecificItemOnceRed end
  return RedPointDataUtils.GetRedPointState, RedTypeDefine.RedType.SpecificItemOnceRed, {tid}, tid
end

function BagExtModel:_redFunc2(uid, tid)
  local isShowRed = false
  if ItemDataUtils.GetItemType(tid) == ItemType.Weapon then
    isShowRed = RedPointDataUtils.IsBackTrackShowRed(uid)
  end
  return isShowRed
end

function BagExtModel:GetAllTrinketDataList()
  local list = {}
  local itemBagData = DataCenter.itemData.BagItemData
  for _, v in pairs(itemBagData) do
    if not v then
    else
      local config = DT.Item[v.tid]
      if config.Type == ItemType.Trinket then
        if not v.completRate then
          local completRate = AwakerTrinketDataUtils.GetTrinketCompletionRateByUid(v.uid)
          v.completRate = completRate
        end
        table.insert(list, v)
      end
    end
  end
  return list
end

function BagExtModel:GetTrinketItemList()
  local list = {}
  local itemBagData = DataCenter.itemData.BagItemData
  for _, v in pairs(itemBagData) do
    if not v then
    else
      local config = DT.Item[v.tid]
      if config.Type ~= ItemType.Trinket or not self:IsFilter(v) then
      elseif not AwakerTrinketDataUtils.IsTrinketVisibleInList(v.uid) then
      else
        local completRate = AwakerTrinketDataUtils.GetTrinketCompletionRateByUid(v.uid)
        local itemData = {
          tid = v.tid,
          uid = v.uid,
          completRate = completRate
        }
        v.completRate = completRate
        table.insert(list, itemData)
      end
    end
  end
  list = AwakerTrinketDataUtils.Sort(list, self.trinketSortType, self.trinketSortOrder, nil, true)
  return list
end

function BagExtModel:GetMaterialItemList()
  local list = {}
  local itemBagData = DataCenter.itemData.BagItemData
  for _, v in pairs(itemBagData) do
    if not v then
    else
      local config = DT.Item[v.tid]
      if config.Type == ItemType.Material then
        local itemData = {
          tid = v.tid,
          uid = v.uid
        }
        table.insert(list, itemData)
      end
    end
  end
  table.sort(list, DefaultItemsSort)
  return list
end

local notInSpecialBagSubTypeGroup = {
  ItemSubType.PlayerAvatar,
  ItemSubType.Emoji,
  ItemSubType.GenderDifference,
  ItemSubType.ExpBonus,
  ItemSubType.AvatarFrame
}

function BagExtModel:GetSpecialItemList()
  local list = {}
  local itemBagData = DataCenter.itemData.BagItemData
  for _, v in pairs(itemBagData) do
    if not v then
    else
      local config = DT.Item[v.tid]
      if config.Type == ItemType.Special and not table.contains(notInSpecialBagSubTypeGroup, config.SubType) then
        local itemData = {
          tid = v.tid,
          uid = v.uid
        }
        table.insert(list, itemData)
      end
    end
  end
  table.sort(list, DefaultItemsSort)
  return list
end

function BagExtModel:GetKeeperSkillItemList()
  local list = {}
  local itemBagData = DataCenter.itemData.BagItemData
  for _, v in pairs(itemBagData) do
    if not v then
    else
      local config = DT.Item[v.tid]
      if config.Type == ItemType.KeeperSkill then
        local itemData = {
          tid = v.tid,
          uid = v.uid
        }
        table.insert(list, itemData)
      end
    end
  end
  table.sort(list, DefaultItemsSort)
  return list
end

function BagExtModel:GetItemGets(itemTid)
  local rst = {}
  if not itemTid or 0 == itemTid then
    return rst
  end
  local stageJumpGroup = {}
  local getsId2ItemIdMap = {}
  local itemGetsGroup = ItemDataUtils.GetItemGets(itemTid)
  local itemGetsSortWeightMap = {}
  for idx, tid in ipairs(table.deepclone(itemGetsGroup)) do
    itemGetsSortWeightMap[tid] = idx
    getsId2ItemIdMap[tid] = itemTid
    local cfg = DT.ItemGets[tid]
    if cfg.JumpFunc ~= CommonDefine.JumpFuncType.Stage then
      table.insert(rst, tid)
    else
      table.insert(stageJumpGroup, tid)
    end
  end
  table.sort(stageJumpGroup, function(a, b)
    local aOrder = DT.ItemGets[a].Order
    local bOrder = DT.ItemGets[b].Order
    return aOrder < bOrder
  end)
  local firstLockIdx = 0
  for idx, tid in pairs(stageJumpGroup) do
    local unlock = FuncJumpManager.Instance:CanJump(tid)
    if not unlock then
      firstLockIdx = idx
      break
    end
  end
  if 0 ~= firstLockIdx then
    table.insert(rst, stageJumpGroup[firstLockIdx])
  else
    firstLockIdx = #stageJumpGroup + 1
  end
  for i = 1, MAX_LOCK_STAGE_JUMP_NUM do
    if firstLockIdx - i > 0 then
      table.insert(rst, stageJumpGroup[firstLockIdx - i])
    end
  end
  table.sort(rst, function(a, b)
    local aUnlock = FuncJumpManager.Instance:CanJump(a, getsId2ItemIdMap[a]) and 1 or 0
    local bUnlock = FuncJumpManager.Instance:CanJump(b, getsId2ItemIdMap[b]) and 1 or 0
    if aUnlock == bUnlock then
      return itemGetsSortWeightMap[a] < itemGetsSortWeightMap[b]
    end
    return aUnlock > bUnlock
  end)
  return rst
end

function BagExtModel:CheckItemTypeRed(itemType)
  if itemType == ItemType.Weapon then
    local itemList = self:GetWeaponItemList()
    for _, item in ipairs(itemList) do
      local red = RedPointDataUtils.IsBackTrackShowRed(item.uid)
      if red then
        return red
      end
    end
  end
  local specificOnceRedItemTypeMap = self:GetSpecificOnceRedItemTypeMap()
  if not specificOnceRedItemTypeMap then
    return false
  end
  local itemList = specificOnceRedItemTypeMap[itemType]
  if not itemList or 0 == #itemList then
    return false
  end
  for _, tid in ipairs(itemList) do
    local red = RedPointDataUtils.GetRedPointState(RedTypeDefine.RedType.SpecificItemOnceRed, {tid})
    if red then
      return red
    end
  end
  return false
end

function BagExtModel:GetSpecificOnceRedItemTypeMap()
  if self.specificOnceRedItemTypeMap then
    return self.specificOnceRedItemTypeMap
  end
  local specificItemList = DT.GetOriginalConstant("BagOnceReddotItemList")
  if not specificItemList or table.next(specificItemList) == nil then
    return {}
  end
  local map = {}
  for _, tid in ipairs(specificItemList) do
    local config = ItemDataUtils.GetItemConfig(tid)
    if not config then
    else
      if not map[config.Type] then
        map[config.Type] = {}
      end
      table.insert(map[config.Type], tid)
    end
  end
  self.specificOnceRedItemTypeMap = map
  return map
end

return BagExtModel
