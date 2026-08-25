local BackTrackSelectModel, Super = NewClass("BackTrackSelectModel", BaseModel)

function BackTrackSelectModel:OnInit()
end

function BackTrackSelectModel:OnReset()
  self._curTab = CommonDefine.BackTrackType.NormalAwaker
  self._itemId = nil
  self._awakerId = nil
  self._weaponUid = nil
  self._weaponTid = nil
  self._cachedAwakerList = nil
  self._cachedWeaponList = nil
  self._listDirty = true
end

function BackTrackSelectModel:SetItemId(itemId)
  self._itemId = itemId
  self._listDirty = true
end

function BackTrackSelectModel:GetItemId()
  return self._itemId
end

function BackTrackSelectModel:GetCurTab()
  return self._curTab
end

function BackTrackSelectModel:SetCurTab(tab)
  if self._curTab ~= tab then
    self._curTab = tab
    self._listDirty = true
  end
end

function BackTrackSelectModel:MarkListDirty()
  self._listDirty = true
end

function BackTrackSelectModel:GetCurAwakerId()
  return self._awakerId
end

function BackTrackSelectModel:SetCurAwakerId(awakerId)
  self._awakerId = awakerId
end

function BackTrackSelectModel:GetCurWeaponUid()
  return self._weaponUid
end

function BackTrackSelectModel:SetCurWeaponUid(uid)
  self._weaponUid = uid
end

function BackTrackSelectModel:GetCurWeaponTid()
  return self._weaponTid
end

function BackTrackSelectModel:SetCurWeaponTid(tid)
  self._weaponTid = tid
end

function BackTrackSelectModel:GetChooseTid()
  if self._curTab == CommonDefine.BackTrackType.NormalAwaker or self._curTab == CommonDefine.BackTrackType.UniqueAwaker then
    do return self.GetCurAwakerId end
    return self.GetCurAwakerId, self
  else
    do return self.GetCurWeaponUid end
    return self.GetCurWeaponUid, self
  end
end

function BackTrackSelectModel:GetAwakerList()
  if self._curTab == CommonDefine.BackTrackType.Weapon then
    return {}
  end
  if not self._listDirty and self._cachedAwakerList then
    return self._cachedAwakerList
  end
  self:_RebuildAwakerList()
  return self._cachedAwakerList
end

function BackTrackSelectModel:_RebuildAwakerList()
  local list = {}
  local normalAwakerList = DT.GetOriginalConstant("BacktrackItemAwakers")
  local freeBackAwakerList = BackTrackDataUtils.GetFreeBackAwakerList()
  local collectNormal = self._curTab == CommonDefine.BackTrackType.NormalAwaker
  local awakerMap = AwakerDataUtils.GetAwakerDataMap()
  for awakerId, awakerData in pairs(awakerMap) do
    if not AwakerDataUtils.HasOwnedAwaker(awakerId) then
    elseif BackTrackDataUtils.IsAwakerOpen(awakerId) then
    elseif table.contains(freeBackAwakerList, awakerId) then
    else
      local isNormalAwaker = table.contains(normalAwakerList, awakerId)
      if collectNormal and isNormalAwaker then
        table.insert(list, awakerData)
      elseif not collectNormal and not isNormalAwaker then
        table.insert(list, awakerData)
      end
    end
  end
  local defaultOrder = CommonDefine.SortOrder.Descend
  table.sort(list, function(a, b)
    local schoolSortA = AwakerDataUtils.GetSchoolSortValue(a.tid)
    local schoolSortB = AwakerDataUtils.GetSchoolSortValue(b.tid)
    if schoolSortA == schoolSortB then
      local potencySortA = a.potencyLevel
      local potencySortB = b.potencyLevel
      if potencySortA == potencySortB then
        local levelSortA = a.level
        local levelSortB = b.level
        if levelSortA == levelSortB then
          local default = 1
          local qualitySortA = AwakerDataUtils.GetQualitySort(a.tid) or default
          local qualitySortB = AwakerDataUtils.GetQualitySort(b.tid) or default
          if qualitySortA == qualitySortB then
            local aSortId = AwakerDataUtils.GetAwakerSortId(a.tid)
            local bSortId = AwakerDataUtils.GetAwakerSortId(b.tid)
            do return AwakerDataUtils.Compare, aSortId, bSortId end
            return AwakerDataUtils.Compare, aSortId, bSortId, CommonDefine.SortOrder.Ascend
          else
            do return AwakerDataUtils.Compare, qualitySortA, qualitySortB end
            return AwakerDataUtils.Compare, qualitySortA, qualitySortB, defaultOrder, bSortId, CommonDefine.SortOrder.Ascend
          end
        else
          do return AwakerDataUtils.Compare, levelSortA, levelSortB end
          return AwakerDataUtils.Compare, levelSortA, levelSortB, defaultOrder, qualitySortA, qualitySortB, defaultOrder, bSortId, CommonDefine.SortOrder.Ascend
        end
      else
        do return AwakerDataUtils.Compare, potencySortA, potencySortB end
        return AwakerDataUtils.Compare, potencySortA, potencySortB, defaultOrder, levelSortB, defaultOrder, qualitySortA, qualitySortB, defaultOrder, bSortId, CommonDefine.SortOrder.Ascend
      end
    else
      do return AwakerDataUtils.Compare, schoolSortA, schoolSortB end
      return AwakerDataUtils.Compare, schoolSortA, schoolSortB, CommonDefine.SortOrder.Ascend, potencySortB, defaultOrder, levelSortB, defaultOrder, qualitySortA, qualitySortB, defaultOrder, bSortId, CommonDefine.SortOrder.Ascend
    end
  end)
  self._cachedAwakerList = list
  self._listDirty = false
end

function BackTrackSelectModel:GetWeaponList()
  if not self._listDirty and self._cachedWeaponList then
    return self._cachedWeaponList
  end
  self:_RebuildWeaponList()
  return self._cachedWeaponList
end

function BackTrackSelectModel:_RebuildWeaponList()
  local list = {}
  local backtrackItemWeaponsList = DT.GetOriginalConstant("BacktrackItemWeapons")
  for _, weaponId in ipairs(backtrackItemWeaponsList) do
    local uidMap = ItemDataUtils.GetItemUidMap(weaponId)
    if uidMap then
      local weaponItem
      for uid, _ in pairs(uidMap) do
        local tempItem = ItemDataUtils.GetItemByUid(uid)
        if nil == weaponItem then
          weaponItem = tempItem
        elseif tempItem.level > weaponItem.level then
          weaponItem = tempItem
        end
      end
      if weaponItem and not BackTrackDataUtils.IsWeaponOpen(weaponId, weaponItem.uid) then
        table.insert(list, weaponItem)
      end
    end
  end
  local defaultOrder = CommonDefine.SortOrder.Descend
  table.sort(list, function(a, b)
    do return AwakerTrinketDataUtils.SortWeaponByPotency, a, b end
    return AwakerTrinketDataUtils.SortWeaponByPotency, a, b, defaultOrder
  end)
  self._cachedWeaponList = list
  self._listDirty = false
end

return BackTrackSelectModel
