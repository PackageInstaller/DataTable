local TeamWeaponModel = NewClass("TeamWeaponModel", BaseModel)

function TeamWeaponModel:OnInit()
end

local function GetDefaultWeaponedGroup(weaponedGroup)
  local rst = table.deepclone(weaponedGroup)
  if not rst[CommonDefine.WeaponSlotType.Primary] then
    rst[CommonDefine.WeaponSlotType.Primary] = 0
  end
  if not rst[CommonDefine.WeaponSlotType.Secondary] then
    rst[CommonDefine.WeaponSlotType.Secondary] = 0
  end
  return rst
end

function TeamWeaponModel:InitDataByTeamWeaponEquipViewData(data)
  self.teamModel = data.dbgTeamBuildModel
  self.isShowSortTypePanel = false
  self.sortType = CommonDefine.AwakerWeaponSortType.Quality
  self.sortOrder = CommonDefine.SortOrder.Descend
  self.sortTypeList = AwakerTrinketDataUtils.GetWeaponSortDataTable()
  self.curSelectWeaponSlot = data.selectWeaponSlot
  self.curSelectAwakerTid = data.selectAwakerTid
  self.curSelectWeaponUid = data.selectWeaponUid
  self.teamSlot = data.teamSlot
  self.weaponedGroup = GetDefaultWeaponedGroup(data.weaponedGroup or {})
  self.weaponList = {}
  self:UpdateWeaponedGroup()
  self:UpdateWeaponList()
  self:SelectListFirstWeapon(true)
end

function TeamWeaponModel:OnReset()
end

function TeamWeaponModel:CheckEquipMaxLvSSRWeapon()
  for _, slotType in pairs(CommonDefine.WeaponSlotGroup) do
    local weaponUid = self.weaponedGroup[slotType]
    if ItemDataUtils.CheckIsMaxLvSSRWeapon(weaponUid) then
      return true
    end
  end
  return false
end

function TeamWeaponModel:SelectListFirstWeapon(showTips)
  self:SetCurSelectWeaponUid(self.weaponList[1] and self.weaponList[1].uid or 0, showTips)
end

function TeamWeaponModel:SetWeaponedGroup(tbl)
  tbl = table.deepclone(tbl)
  for slot, weaponUid in pairs(tbl) do
    if 0 == weaponUid or not ItemDataUtils.GetItemByUid(weaponUid) then
      tbl[slot] = 0
    end
  end
  self.weaponedGroup = tbl
  self:LocalNotify(NotifyId.OnTeamWeaponSlotChanged, self.weaponedGroup)
end

function TeamWeaponModel:UpdateWeaponedGroup()
  if self.teamModel then
    local rst = table.clone(self.teamModel:GetTeamWeaponGroupBySlot(self.teamSlot))
    for _, slotType in pairs(CommonDefine.WeaponSlotGroup) do
      if not rst[slotType] then
        rst[slotType] = 0
      end
    end
    self:SetWeaponedGroup(rst)
  end
end

function TeamWeaponModel:UpdateWeaponList()
  local list = {}
  local TypeWeapon = CommonDefine.ItemType.Weapon
  for _, v in pairs(DataCenter.itemData.BagItemData) do
    local config = ItemDataUtils.GetItemConfig(v.tid)
    if config.Type == TypeWeapon then
      table.insert(list, v)
    end
  end
  local awakerTid = self.curSelectAwakerTid
  local awaker = AwakerDataUtils.GetAwakerData(awakerTid)
  local unselectedSlot = AwakerDataUtils.GetUnselectedSlotType(self.curSelectWeaponSlot)
  local unselectedSlotData = AwakerDataUtils.GetWeaponSlotDataWithType(awaker, unselectedSlot)
  local unselectedWeaponUid = self.weaponedGroup[unselectedSlot]
  if not unselectedSlotData.unlocked or 0 == unselectedWeaponUid then
    list = AwakerTrinketDataUtils.WeaponSort(list, self.sortType, self.sortOrder)
  else
    list = AwakerTrinketDataUtils.WeaponSortForWeaponChange(list, self.sortType, self.sortOrder, unselectedWeaponUid)
  end
  local canNotWeaponList = {}
  for idx = #list, 1, -1 do
    local itemData = list[idx]
    if self:_CheckWeaponCanNotEquip(itemData.tid, itemData.uid) then
      table.insert(canNotWeaponList, itemData)
      table.remove(list, idx)
    end
  end
  for idx = #canNotWeaponList, 1, -1 do
    table.insert(list, canNotWeaponList[idx])
  end
  local weaponedUid = self.weaponedGroup[self.curSelectWeaponSlot]
  local weaponedItem
  for idx, itemData in ipairs(list) do
    if itemData.uid == weaponedUid then
      weaponedItem = table.remove(list, idx)
      break
    end
  end
  if weaponedItem then
    table.insert(list, 1, weaponedItem)
  end
  self.weaponList = list
end

function TeamWeaponModel:_RetrieveFreeWeapons(tid, results)
  local checkWeaponDatas = {}
  local weaponedUids = self:GetWeaponedUids()
  for _, weapon in ipairs(self.weaponList) do
    if not table.contains(weaponedUids, weapon.uid) then
      table.insert(checkWeaponDatas, weapon)
    end
  end
  local compareWeaponTids = self.teamModel and self.teamModel.teamWeaponTids or {}
  for _, weapon in ipairs(checkWeaponDatas) do
    if weapon.tid == tid and not table.contains(compareWeaponTids, weapon.tid) then
      table.insert(results, weapon)
    end
  end
  return results
end

function TeamWeaponModel:GetWeaponedUids()
  local rst = {}
  if not self.teamModel then
    for _, weaponUid in pairs(self.weaponedGroup) do
      if 0 ~= weaponUid then
        table.insert(rst, weaponUid)
      end
    end
    return rst
  end
  for teamSlot, weaponGroup in pairs(self.teamModel.teamWeaponGroups) do
    for weaponSlot, weaponUid in pairs(weaponGroup) do
      if 0 ~= weaponUid and (teamSlot ~= self.teamSlot or weaponSlot ~= self.curSelectWeaponSlot) then
        table.insert(rst, weaponUid)
      end
    end
  end
  return rst
end

function TeamWeaponModel:_GetFightedWeaponInfo(checkWeaponTid)
  if not self.teamModel then
    return false, "", ""
  end
  local fightedTeamData = self.teamModel:GetFightedStageGroupData()
  for _, fightData in pairs(fightedTeamData) do
    for _, weaponTid in pairs(fightData.weaponTids) do
      if 0 ~= weaponTid and checkWeaponTid == weaponTid then
        local weaponName = LT.Text(DT.Item[weaponTid].Name)
        local stageGroupName = LT.Text(DT.StageGroup[fightData.stageGroupId].Name)
        return true, weaponName, stageGroupName
      end
    end
  end
  return false, "", ""
end

function TeamWeaponModel:GetSelectWeaponTid()
  local itemData = ItemDataUtils.GetItemByUid(self.curSelectWeaponUid)
  return itemData and itemData.tid or 0
end

function TeamWeaponModel:_CheckSSRWeaponForbidden(_, checkWeaponUid)
  local unselectedSlotData, unselectedWeaponUid = self:GetUnselectedSlotInfo(), self:GetUnselectedWeaponUid()
  if not unselectedSlotData.unlocked then
    return false
  end
  if not unselectedWeaponUid or 0 == unselectedWeaponUid then
    return false
  end
  do return AwakerDataUtils.CheckSSRWeaponForbidden, checkWeaponUid end
  return AwakerDataUtils.CheckSSRWeaponForbidden, checkWeaponUid, unselectedWeaponUid
end

function TeamWeaponModel:IsBanTid(weaponTid)
  if self.teamModel then
    do return self.teamModel.IsBanTid, self.teamModel end
    return self.teamModel.IsBanTid, self.teamModel, weaponTid
  end
  return false
end

function TeamWeaponModel:_CheckMainAttrForbidden(_, checkWeaponUid)
  local isCheckForbid = DT.GetConstant("WeaponMainAttrTypeLimit", cd.NumberFalse) == cd.NumberTrue
  if not isCheckForbid then
    return false
  end
  local unselectedSlotData, unselectedWeaponUid = self:GetUnselectedSlotInfo(), self:GetUnselectedWeaponUid()
  if not unselectedSlotData.unlocked or 0 == (unselectedWeaponUid or 0) then
    return false
  end
  local checkWeaponMainAttr = ItemDataUtils.GetWeaponSecondaryAttr(checkWeaponUid)
  local unselectedWeaponMainAttr = ItemDataUtils.GetWeaponSecondaryAttr(unselectedWeaponUid)
  if not checkWeaponMainAttr or not unselectedWeaponMainAttr then
    return false
  end
  if checkWeaponMainAttr.id == unselectedWeaponMainAttr.id then
    return true
  end
end

function TeamWeaponModel:_CheckSameWeaponForbidden(checkWeaponTid)
  local unselectedSlotData, unselectedWeaponUid = self:GetUnselectedSlotInfo(), self:GetUnselectedWeaponUid()
  if not unselectedSlotData.unlocked then
    return false
  end
  if not unselectedWeaponUid or 0 == unselectedWeaponUid then
    return false
  end
  do return AwakerDataUtils.CheckSameWeaponForbidden, checkWeaponTid end
  return AwakerDataUtils.CheckSameWeaponForbidden, checkWeaponTid, unselectedWeaponUid
end

function TeamWeaponModel:GetUnselectedSlotInfo()
  local awaker = AwakerDataUtils.GetAwakerData(self.curSelectAwakerTid)
  local unselectedSlotType = AwakerDataUtils.GetUnselectedSlotType(self.curSelectWeaponSlot)
  local unselectedSlotData = AwakerDataUtils.GetWeaponSlotDataWithType(awaker, unselectedSlotType)
  return unselectedSlotData
end

function TeamWeaponModel:GetUnselectedWeaponUid()
  local unselectedSlotType = AwakerDataUtils.GetUnselectedSlotType(self.curSelectWeaponSlot)
  local unselectedWeaponUid = self.weaponedGroup[unselectedSlotType]
  return unselectedWeaponUid
end

function TeamWeaponModel:_CheckWeaponCanNotEquip(checkWeaponTid, checkWeaponUid)
  return self:_CheckSSRWeaponForbidden(checkWeaponTid, checkWeaponUid) or self:_CheckSameWeaponForbidden(checkWeaponTid, checkWeaponUid) or self:_CheckMainAttrForbidden(checkWeaponTid, checkWeaponUid) or self:_GetFightedWeaponInfo(checkWeaponTid, checkWeaponUid) or self:IsBanTid(checkWeaponTid)
end

function TeamWeaponModel:GetWeaponEffectingTeamSlot(teamSlot, checkWeaponTid)
  if 1 == teamSlot or not self.teamModel then
    return nil
  end
  local weaponGourps = self.teamModel.teamWeaponGroups
  for i = 1, teamSlot - 1 do
    for _, weaponUid in pairs(weaponGourps[i]) do
      if 0 == weaponUid then
        goto lbl_36
      end
      local weaponData = ItemDataUtils.GetItemByUid(weaponUid)
      if not weaponData then
        goto lbl_36
      end
      local weaponTid = weaponData.tid
      if weaponTid == checkWeaponTid then
        return i
      end
    end
    ::lbl_36::
  end
  return nil
end

function TeamWeaponModel:GetWeaponOwnedAwaker(uid)
  if not self.teamModel then
    return 0
  end
  local teamWeaponGroups = self.teamModel.teamWeaponGroups
  for teamSlot, weapons in pairs(teamWeaponGroups) do
    if 0 ~= uid then
      for weaponSlot, weaponUid in pairs(weapons) do
        if weaponUid == uid then
          return self.teamModel:GetTeamAwakerTidBySlot(teamSlot), teamSlot, weaponSlot
        end
      end
    end
  end
  return 0
end

function TeamWeaponModel:SetSelectWeaponSlot(slot)
  if self.curSelectWeaponSlot ~= slot then
    self.curSelectWeaponSlot = slot
    self:SelectListFirstWeapon(true)
    self:LocalNotify(NotifyId.OnTeamWeaponSelectSlotChanged, slot)
    self:LocalNotify(NotifyId.OnTeamWeaponListSortTypeChanged)
  end
end

function TeamWeaponModel:EnableSortTypePanel(enable)
  self.isShowSortTypePanel = enable
end

function TeamWeaponModel:SetCurSelectWeaponUid(uid, showTips)
  if self.curSelectWeaponUid ~= uid then
    self.curSelectWeaponUid = uid
    self:LocalNotify(NotifyId.OnTeamWeaponSelectUidChanged, uid, showTips)
  end
end

function TeamWeaponModel:SetSortOrder(sortOrder)
  if self.sortOrder ~= sortOrder then
    self.sortOrder = sortOrder
    self:UpdateWeaponList()
    self:LocalNotify(NotifyId.OnTeamWeaponListSortTypeChanged)
  end
end

function TeamWeaponModel:SetSortType(sortType)
  if self.sortType ~= sortType then
    self.sortType = sortType
    self:UpdateWeaponList()
    self:LocalNotify(NotifyId.OnTeamWeaponListSortTypeChanged)
  end
end

function TeamWeaponModel:CalWeaponAttrsFromTeamModel(teamModel, equipsAttrs)
  local maxNum = CommonDefine.TeamAssign.MaxBattleNum
  for slotIndex = 1, maxNum do
    equipsAttrs = self:CalWeaponAttrsFromTeamSlot(teamModel, slotIndex, equipsAttrs)
  end
  return equipsAttrs
end

function TeamWeaponModel:CalWeaponAttrsFromTeamSlot(teamModel, slotIndex, equipsAttrs)
  if not teamModel then
    return equipsAttrs
  end
  local assistAwaker = teamModel:GetAssistAwaker()
  local weapons = {}
  if slotIndex == CommonDefine.TeamAssign.MaxBattleNum and assistAwaker then
    local weaponSlots = AwakerDataUtils.GetWeaponSlotData(assistAwaker)
    if not weaponSlots then
      return equipsAttrs
    end
    local assistItems = teamModel:GetAssistItem()
    if not assistItems then
      return equipsAttrs
    end
    for _, weaponSlotData in pairs(weaponSlots) do
      local uid = weaponSlotData and weaponSlotData.weaponUid
      if uid and 0 ~= uid then
        local item = assistItems[uid]
        if item then
          table.insert(weapons, item)
        end
      end
    end
  else
    local tid = teamModel:GetTeamAwakerTidBySlot(slotIndex)
    if not tid or 0 == tid then
      return equipsAttrs
    end
    local weaponSlots = teamModel:GetTeamWeaponGroupBySlot(slotIndex)
    if not weaponSlots then
      return equipsAttrs
    end
    for _, uid in pairs(weaponSlots) do
      local item = ItemDataUtils.GetItemByUid(uid)
      if item then
        table.insert(weapons, item)
      end
    end
  end
  equipsAttrs = equipsAttrs or {}
  for _, itemData in pairs(weapons) do
    if itemData and itemData.attrs then
      for _, attr in pairs(itemData.attrs) do
        local attrId = attr.attrId
        local val = attr.val
        local curVal = equipsAttrs[attrId] or 0
        equipsAttrs[attrId] = curVal + val
      end
    end
  end
  return equipsAttrs
end

return TeamWeaponModel
