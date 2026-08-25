local ItemType = CommonDefine.ItemType
local ItemSubType = CommonDefine.ItemSubType
local tableInsert = table.insert
local MAX_LOCK_STAGE_JUMP_NUM = 3
local ItemDetailsModel = NewClass("ItemDetailsModel", BaseModel)

function ItemDetailsModel:OnInit()
  self:OnReset()
end

function ItemDetailsModel:OnReset()
  self._chosenUid = 0
  self._itemDataMap = nil
  self._chosenTid = 0
end

function ItemDetailsModel:ResetData()
  self._chosenUid = 0
  self._itemDataMap = nil
  self._chosenTid = 0
end

function ItemDetailsModel:SetChosenItemUid(uid)
  if not uid then
    Logger.Error("Error parameter: nil")
    return
  end
  self._chosenUid = uid
  self:LocalNotify(NotifyId.OnItemDetailsDataChanged)
end

function ItemDetailsModel:SetChosenItemTid(tid)
  if not tid then
    Logger.Error("Error parameter: nil")
    return
  end
  self._chosenTid = tid
end

function ItemDetailsModel:SetItemDataMap(list)
  if not list or table.next(list) == nil then
    self._itemDataMap = nil
    return
  end
  self._itemDataMap = {}
  for _, itemData in pairs(list) do
    self._itemDataMap[itemData.uid] = itemData
  end
end

function ItemDetailsModel:GetChosenUid()
  return self._chosenUid
end

function ItemDetailsModel:GetDataByUid(uid)
  if not uid then
    return nil
  end
  if self._itemDataMap then
    return self._itemDataMap[uid]
  end
  do return ItemDataUtils.GetItemByUid end
  return ItemDataUtils.GetItemByUid, uid
end

function ItemDetailsModel:GetChosenItemData()
  local chosenUid = self._chosenUid
  if not chosenUid or 0 == chosenUid then
    return nil
  end
  do return self.GetDataByUid, self end
  return self.GetDataByUid, self, chosenUid
end

function ItemDetailsModel:GetItemType()
  local chosenItemData = self:GetChosenItemData()
  if not chosenItemData then
    return nil
  end
  local tid = chosenItemData.tid
  local config = ItemDataUtils.GetItemConfig(tid)
  if not config then
    Logger.Info("找不到配置:", tid)
    return nil
  end
  return config.Type
end

function ItemDetailsModel:GetItemSubType()
  local chosenItemData = self:GetChosenItemData()
  if not chosenItemData then
    return nil
  end
  local tid = chosenItemData.tid
  local config = ItemDataUtils.GetItemConfig(tid)
  if not config then
    Logger.Info("找不到配置:", tid)
    return nil
  end
  return config.SubType
end

function ItemDetailsModel:GetItemName()
  local chosenItemData = self:GetChosenItemData()
  if not chosenItemData then
    return ""
  end
  do return ItemDataUtils.GetItemName end
  return ItemDataUtils.GetItemName, chosenItemData.tid
end

function ItemDetailsModel:IsPreviewData()
  return self._itemDataMap ~= nil
end

function ItemDetailsModel:GetItemIcon()
  local chosenItemData = self:GetChosenItemData()
  if not chosenItemData then
    return ""
  end
  do return ItemDataUtils.GetIcon end
  return ItemDataUtils.GetIcon, chosenItemData.tid
end

function ItemDetailsModel:GetItemGets()
  local rst = {}
  local chosenItemData = self:GetChosenItemData()
  if not chosenItemData then
    return rst
  end
  local stageJumpGroup = {}
  local getsId2ItemIdMap = {}
  local itemGetsGroup = ItemDataUtils.GetItemGets(chosenItemData.tid)
  local itemGetsSortWeightMap = {}
  for idx, tid in ipairs(table.deepclone(itemGetsGroup)) do
    itemGetsSortWeightMap[tid] = idx
    getsId2ItemIdMap[tid] = chosenItemData.tid
    local cfg = DT.ItemGets[tid]
    if cfg.JumpFunc ~= CommonDefine.JumpFuncType.Stage then
      tableInsert(rst, tid)
    else
      tableInsert(stageJumpGroup, tid)
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
    tableInsert(rst, stageJumpGroup[firstLockIdx])
  else
    firstLockIdx = #stageJumpGroup + 1
  end
  for i = 1, MAX_LOCK_STAGE_JUMP_NUM do
    if firstLockIdx - i > 0 then
      tableInsert(rst, stageJumpGroup[firstLockIdx - i])
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

function ItemDetailsModel:GetItemLocked()
  local chosenItemData = self:GetChosenItemData()
  if not chosenItemData then
    return false
  end
  return chosenItemData.locked
end

function ItemDetailsModel:GetItemSubTypeName()
  local chosenItemData = self:GetChosenItemData()
  if not chosenItemData then
    return ""
  end
  do return ItemDataUtils.GetItemSubTypeName end
  return ItemDataUtils.GetItemSubTypeName, chosenItemData.tid
end

function ItemDetailsModel:GetBackTrackItemExpiredTime()
  local chosenItemData = self:GetChosenItemData()
  if chosenItemData then
    local cfg = DT.Item[chosenItemData.tid]
    if cfg.SubType == ItemSubType.BackTrack then
      do return end
      return BackTrackDataUtils.GetEndTime, ItemSubType.BackTrack
    end
  end
  return nil
end

function ItemDetailsModel:GetItemStory()
  local chosenItemData = self:GetChosenItemData()
  if not chosenItemData then
    return ""
  end
  do return ItemDataUtils.GetItemStory end
  return ItemDataUtils.GetItemStory, chosenItemData.tid
end

function ItemDetailsModel:GetItemLevel()
  local chosenItemData = self:GetChosenItemData()
  if not chosenItemData then
    return 0
  end
  local itemType = self:GetItemType()
  if itemType ~= ItemType.Weapon and itemType ~= ItemType.Trinket then
    return 0
  end
  if chosenItemData.level then
    return chosenItemData.level
  end
  if itemType == ItemType.Weapon then
    return 1
  end
  return 0
end

function ItemDetailsModel:GetWeaponDescList()
  local descList = {}
  local chosenItemData = self:GetChosenItemData()
  if not chosenItemData then
    return descList
  end
  local itemType = self:GetItemType()
  if itemType ~= ItemType.Weapon then
    return descList
  end
  local tid = chosenItemData.tid
  local level = self:GetItemLevel()
  local desc1 = SkillUtils.GetWeaponStateDesc(tid, level)
  if "" ~= desc1 then
    tableInsert(descList, desc1)
  end
  return descList
end

return ItemDetailsModel
