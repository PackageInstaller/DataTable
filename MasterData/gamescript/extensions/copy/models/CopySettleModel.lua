local CopySettleModel = NewClass("CopySettleModel", BaseModel)
local ChaosSchoolDeathResistVal = DT.GetConstant("ChaosSchoolEffectDeathResistNum")
local MAX_WEAPON_SLOT_NUM = 2
local MAX_TRINKET_SLOT_NUM = 6

function CopySettleModel:OnReset()
end

function CopySettleModel:OnInit()
  self.recordTime = 0
  self.stageTid = 0
  self.keeperSkillTid = 0
  self.teamData = {}
  self._banRecordBtn = false
  self.recordStageData = {}
  self.relicDatas = {}
  self.settleItemDataMap = {}
  self.settleAwakerDatas = {}
  self.settleCardDatas = {}
  self.fakeAwakerDatas = {}
  self._settleAwakerAttrsMap = {}
  self.teamDataShowGroup = {}
  self:Init_teamDataShowGroup()
end

function CopySettleModel:Init_teamDataShowGroup()
  local rst = {}
  for id, _ in pairs(DT.StageData) do
    table.insert(rst, id)
  end
  table.sort(rst, function(a, b)
    local aCfg = DT.StageData[a]
    local bCfg = DT.StageData[b]
    return aCfg.Sort < bCfg.Sort
  end)
  self.teamDataShowGroup = rst
end

function CopySettleModel:UpdateBySvrData(svrData)
  local teamData = svrData.teamData or {}
  local recordStageData = svrData.recordStageData or {}
  local stageId = recordStageData.stageId
  self:Set_teamData(teamData)
  self:Set_keeperSkillTid(teamData.keeperSkill or 0)
  self:Set_settleItemDataMap(teamData.items or {})
  self:Set_settleAwakerDatas(teamData.awakers or {}, stageId)
  local relicDatas = {}
  for _, relicData in ipairs(recordStageData.relics or {}) do
    if relicData.tid ~= DT.GetConstant("RelicKey") then
      table.insert(relicDatas, relicData)
    end
  end
  self:Set_relicDatas(relicDatas)
  print("-------------set stage tid", recordStageData.stageId)
  self:Set_stageTid(recordStageData.stageId or 0)
  self:Set_settleCardDatas(recordStageData.cards or {})
  self:Set_recordTime(recordStageData.recordTime or 0)
  self:Set_recordStageData(recordStageData or {})
  self:Update_settleAwakerAttrsMap()
  GlobalDispatcher:Dispatch(NotifyId.OnGetCopySettleDataBack)
end

function CopySettleModel:Update_settleAwakerAttrsMap()
  local rst = {}
  for _, awakerData in pairs(self:Get_settleAwakerDatas()) do
    local awakerTid = awakerData.tid
    if not rst[awakerTid] then
      rst[awakerTid] = {}
    end
    for attrName, val in pairs(awakerData.attrs or {}) do
      local attrId = AttrUtils.AttrTypeMap[attrName] or 0
      if 0 ~= attrId then
        rst[awakerTid][attrId] = val
      end
    end
    for i = 1, MAX_WEAPON_SLOT_NUM do
      local weaponSlotData = AwakerDataUtils.GetWeaponSlotDataWithType(awakerData, i)
      local weaponUid = weaponSlotData.weaponUid or 0
      local weaponData = self:GetSettleItemData(weaponUid)
      if weaponData then
        for _, attr in pairs(weaponData.attrs or {}) do
          local curVal = rst[awakerTid][attr.attrId] or 0
          rst[awakerTid][attr.attrId] = curVal + attr.val
        end
      end
    end
    local trinketDatas = {}
    for i = 1, MAX_TRINKET_SLOT_NUM do
      local trinketUid = awakerData.trinkets[i] or 0
      local trinketData = self:GetSettleItemData(trinketUid)
      if trinketData then
        table.insert(trinketDatas, trinketData)
      end
    end
    local attrsMap = TrinketModel.Instance:GetTrinketAttrs(trinketDatas)
    for attrId, val in pairs(attrsMap) do
      local curVal = rst[awakerTid][attrId] or 0
      rst[awakerTid][attrId] = curVal + val
    end
    local suitAttrs = TrinketModel.Instance:GetActiveSuitAttrsList(trinketDatas)
    for _, attrData in pairs(suitAttrs) do
      local curVal = rst[awakerTid][attrData.attrId] or 0
      rst[awakerTid][attrData.attrId] = curVal + attrData.val
    end
  end
  self._settleAwakerAttrsMap = rst
end

function CopySettleModel:GetAwakerDataByAwakerTid(awakerTid)
  local awakerDatas = self:Get_settleAwakerDatas()
  for _, awakerData in pairs(awakerDatas) do
    if awakerData.tid == awakerTid then
      return awakerData
    end
  end
  return nil
end

function CopySettleModel:GetSettleItemData(uid)
  local settleItemDataMap = self:Get_settleItemDataMap()
  return settleItemDataMap[uid]
end

function CopySettleModel:GetTeamPropertyByType(attrName)
  local attrId = AttrUtils.AttrTypeMap[attrName]
  local rst = 0
  for _, attrs in pairs(self._settleAwakerAttrsMap) do
    rst = rst + (attrs[attrId] or 0)
  end
  return rst
end

function CopySettleModel:GetTeamShowPropertyByType(attrName)
  local attrVal = self:GetTeamPropertyByType(attrName)
  if attrName == bc.RoleProperty.death_resist and self:CheckHaveChaosTeam() then
    attrVal = attrVal + ChaosSchoolDeathResistVal
  end
  local attrId = AttrUtils.AttrTypeMap[attrName]
  do return self.GetAttrShowStr, self, attrId end
  return self.GetAttrShowStr, self, attrId, attrVal
end

local chaosSchoolId = AwakerDataUtils.GetSchoolIdByNameEn(CommonDefine.SchoolType.Chaos)

function CopySettleModel:CheckHaveChaosTeam()
  for _, awakerData in pairs(self:Get_settleAwakerDatas()) do
    local awakerTid = awakerData.tid
    local schoolTid = AwakerDataUtils.GetAwakerSchool(awakerTid)
    if chaosSchoolId == schoolTid then
      return true
    end
  end
  return false
end

function CopySettleModel:GetAwakerPropertyByType(awakerTid, attrId)
  return self._settleAwakerAttrsMap[awakerTid] and self._settleAwakerAttrsMap[awakerTid][attrId] or 0
end

function CopySettleModel:GetAwakerShowPropertyByType(awakerTid, typeName)
  local attrId = AttrUtils.AttrTypeMap[typeName]
  local attrVal = self:GetAwakerPropertyByType(awakerTid, attrId)
  do return self.GetAttrShowStr, self, attrId end
  return self.GetAttrShowStr, self, attrId, attrVal
end

function CopySettleModel:GetAttrShowStr(attrId, attrVal)
  local attrShowVal = AttrUtils.GetAttrShowVal(math.ceil(attrVal))
  local isPercent = AttrUtils.GetAttrCfgByField("Percentage", attrId)
  return attrShowVal .. (isPercent and "%" or "")
end

function CopySettleModel:GetAwakerEquipedTrinketDatas(awakerData)
  local rst = {}
  local trinketUids = awakerData.trinkets or {}
  for slot = 1, MAX_TRINKET_SLOT_NUM do
    local trinketUid = trinketUids[slot] or 0
    if 0 ~= trinketUid then
      local trinketData = self:GetSettleItemData(trinketUid)
      rst[slot] = trinketData
    end
  end
  return rst
end

function CopySettleModel:GetSpecialTeamTrinketSuit(awakerData)
  local fakeAwakerdata = self:GetSpecialAssignAwakerData(awakerData.specialTeamAssignId, awakerData.tid)
  if fakeAwakerdata then
    return fakeAwakerdata.suitEffectId
  end
end

function CopySettleModel:GetAwakerEquipedWeaponDatas(awakerData)
  local rst = {}
  if not awakerData then
    return rst
  end
  local weaponSlots = awakerData and awakerData.weaponSlots or {}
  for slot, weaponSlotData in pairs(weaponSlots) do
    local weaponUid = weaponSlotData.weaponUid or 0
    if 0 ~= weaponUid then
      local weaponData = self:GetSettleItemData(weaponUid)
      rst[slot] = weaponData
    end
  end
  local fakeAwakerdata = self:GetSpecialAssignAwakerData(awakerData.specialTeamAssignId, awakerData.tid)
  if fakeAwakerdata then
    rst[1] = {
      tid = fakeAwakerdata.weaponTid,
      level = fakeAwakerdata.weaponPotencyLv,
      uid = fakeAwakerdata.weaponTid
    }
    rst[2] = {
      tid = fakeAwakerdata.subWeaponTid,
      level = fakeAwakerdata.subWeaponPotencyLv,
      uid = fakeAwakerdata.subWeaponTid
    }
  end
  return rst
end

function CopySettleModel:GetSpecialAssignAwakerData(specialTeamAssignId, awakerTid)
  if not specialTeamAssignId or 0 == specialTeamAssignId or not awakerTid then
    return
  end
  return self.fakeAwakerDatas[awakerTid]
end

function CopySettleModel:Get_recordStageDataByField(field)
  if not self.recordStageData then
    return nil
  end
  return self.recordStageData[field]
end

function CopySettleModel:GetRecordStageData()
  return self.recordStageData
end

function CopySettleModel:Set_recordStageData(tbl)
  self.recordStageData = tbl
end

function CopySettleModel:Set_stageTid(numVal)
  Logger.Info("-----------------CopySettleModel:Set_stageTid ", numVal, debug.traceback())
  self.stageTid = numVal
end

function CopySettleModel:SetBanRecordBtn(boolVal)
  self._banRecordBtn = boolVal
end

function CopySettleModel:GetBanRecordBtn()
  return self._banRecordBtn
end

function CopySettleModel:Get_stageTid()
  return self.stageTid
end

function CopySettleModel:Get_PlayerLv()
  return self.recordStageData.playerLevel
end

function CopySettleModel:Set_teamData(teamData)
  self.teamData = teamData
end

function CopySettleModel:Set_keeperSkillTid(numVal)
  self.keeperSkillTid = numVal
end

function CopySettleModel:Get_keeperSkillTid()
  return self.keeperSkillTid
end

function CopySettleModel:Set_relicDatas(tbl)
  self.relicDatas = tbl or {}
end

function CopySettleModel:Get_relicDatas()
  return self.relicDatas
end

function CopySettleModel:Set_settleItemDataMap(tbl)
  self.settleItemDataMap = tbl or {}
end

function CopySettleModel:Get_settleItemDataMap()
  return self.settleItemDataMap
end

function CopySettleModel:Set_settleAwakerDatas(tbl, stageId)
  self.settleAwakerDatas = tbl or {}
  local specialTeamAssignId = TeamAssignDataUtils.GetStageSpecialTeamId(stageId)
  if specialTeamAssignId then
    local _, fakeAwakers = TeamAssignDataUtils.GetBattlePosState(specialTeamAssignId)
    self.fakeAwakerDatas = fakeAwakers
  else
    self.fakeAwakerDatas = {}
  end
end

function CopySettleModel:Get_settleAwakerDatas()
  return self.settleAwakerDatas
end

function CopySettleModel:Get_SettleAwakerDatasByIndex(index)
  return self.settleAwakerDatas and self.settleAwakerDatas[index]
end

function CopySettleModel:Set_settleCardDatas(tbl)
  self.settleCardDatas = tbl or {}
end

function CopySettleModel:Get_settleCardDatas()
  return self.settleCardDatas
end

function CopySettleModel:Get_teamDataShowGroup()
  return self.teamDataShowGroup
end

function CopySettleModel:Set_recordTime(numVal)
  self.recordTime = numVal
end

function CopySettleModel:Get_recordTime()
  return self.recordTime
end

function CopySettleModel:Set_tempName(numVal)
  self.tempName = numVal
end

function CopySettleModel:Get_tempName()
  return self.tempName
end

function CopySettleModel:GetTeamDataShareCode()
  local awakerTids = {}
  local awakerDatas = self:Get_settleAwakerDatas()
  for slotIndex, awakerData in ipairs(awakerDatas) do
    awakerTids[slotIndex] = awakerData.tid
  end
  local assitItems = self.settleItemDataMap or {}
  local weaponTidList = {}
  for index, awakerTid in ipairs(awakerTids) do
    local awakerWeaponTids = {}
    weaponTidList[index] = awakerWeaponTids
    local teamAwakerData = awakerDatas[index]
    for weaponSlot = 1, CommonDefine.TeamWeaponCount do
      local weapon = teamAwakerData.weaponSlots and teamAwakerData.weaponSlots[weaponSlot]
      if weapon and weapon.weaponUid and 0 ~= weapon.weaponUid then
        local weaponData = assitItems[weapon.weaponUid] or ItemDataUtils.GetItemByUid(weapon.weaponUid)
        awakerWeaponTids[weaponSlot] = weaponData and weaponData.tid
      end
    end
  end
  local trinketTidList, trinketMainAttrList = {}, {}
  for index, awakerTid in ipairs(awakerTids) do
    local awakerTrinketTids = {}
    local awakerTrinketMainAttrs = {}
    trinketTidList[index] = awakerTrinketTids
    trinketMainAttrList[index] = awakerTrinketMainAttrs
    local teamAwakerData = awakerDatas[index]
    local trinketUids = teamAwakerData.trinket and teamAwakerData.trinket.trinkets
    trinketUids = trinketUids or teamAwakerData.trinkets or {}
    trinketUids = trinketUids or {}
    for i = 1, CommonDefine.MaxEquipTrinketsNum do
      local uid = trinketUids[i]
      local trinket = uid and assitItems[uid] or ItemDataUtils.GetItemByUid(uid)
      awakerTrinketTids[i] = trinket and trinket.tid
      local mainAttr = AwakerTrinketDataUtils.GetMainAttr(uid, assitItems)
      awakerTrinketMainAttrs[i] = mainAttr and mainAttr.attrId
    end
  end
  local keeperSkill = self.teamData.keeperSkill
  do return DBGTeamDataUtils.GetTeamShareCode, awakerTids, weaponTidList, trinketTidList, trinketMainAttrList end
  return DBGTeamDataUtils.GetTeamShareCode, awakerTids, weaponTidList, trinketTidList, trinketMainAttrList, keeperSkill, {}, awakerDatas[index], {}, 1, CommonDefine.MaxEquipTrinketsNum, 1, nil, trinketUids[i], ItemDataUtils.GetItemByUid(uid), AwakerTrinketDataUtils.GetMainAttr(uid, assitItems), mainAttr and mainAttr.attrId, assitItems
end

function CopySettleModel:GetTeamShareContent()
  local shareContent = LT.Text("PVETeamShareCode")
  local replaceMap = {}
  local teamData = self.teamData
  local shareCode = self:GetTeamDataShareCode()
  replaceMap[0] = shareCode
  replaceMap[1] = PlayerDataUtils.GetName()
  replaceMap[2] = PlayerDataUtils.GetPlayerUid()
  replaceMap[3] = teamData.name and LT.Text(teamData.name)
  replaceMap[4] = teamData.keeperSkill and ItemDataUtils.GetItemName(teamData.keeperSkill)
  local awakerIndex, awakerIndexGap = 10, 20
  local assitItems = self.settleItemDataMap or {}
  local assistAwaker
  for slotIndex, awakerData in ipairs(self:Get_settleAwakerDatas()) do
    local awakerTid = awakerData.tid
    local startIndex = awakerIndex + (slotIndex - 1) * awakerIndexGap
    awakerTid = slotIndex == CommonDefine.TeamAssistPos and assistAwaker and assistAwaker.tid or awakerTid
    if awakerTid and 0 ~= awakerTid then
      local teamAwakerData = awakerData
      if not awakerData or not teamAwakerData then
      else
        replaceMap[startIndex] = AwakerDataUtils.GetAwakerName(awakerTid)
        replaceMap[startIndex + 1] = awakerData.potencyLevel
        replaceMap[startIndex + 2] = awakerData.level
        local skills = awakerData.skills or awakerData.slots
        for i = 1, 6 do
          if skills[i] then
            replaceMap[startIndex + 2 + i] = skills[i].level
          end
        end
        replaceMap[startIndex + 9] = 0
        replaceMap[startIndex + 10] = 0
        for talentTid, talentData in pairs(awakerData.talents or {}) do
          local talentCfg = DT.AwakerTalent[talentTid] or {}
          local firstLevelData = talentCfg.data_list[1] or {}
          if string.contains(firstLevelData.TalentName or "", CommonDefine.AwakerTalentName[1]) then
            replaceMap[startIndex + 9] = talentData.lv
          elseif string.contains(firstLevelData.TalentName or "", CommonDefine.AwakerTalentName[2]) then
            replaceMap[startIndex + 10] = talentData.lv
          end
        end
        local weaponReplaceIndex = {
          {11, 12},
          {13, 14}
        }
        for i = 1, CommonDefine.TeamWeaponCount do
          local weapon = teamAwakerData.weaponSlots[i]
          if weapon and weapon.weaponUid and 0 ~= weapon.weaponUid then
            local weaponData = assitItems[weapon.weaponUid] or ItemDataUtils.GetItemByUid(weapon.weaponUid)
            local weaponName = ItemDataUtils.GetItemName(weaponData.tid)
            local lv = weaponData.level
            local indexList = weaponReplaceIndex[i]
            replaceMap[startIndex + indexList[1]] = weaponName
            replaceMap[startIndex + indexList[2]] = lv
          end
        end
        local trinketUids = teamAwakerData.trinket and teamAwakerData.trinket.trinkets
        trinketUids = trinketUids or awakerData.trinkets or {}
        local trinketDatas = {}
        for i = 1, CommonDefine.MaxEquipTrinketsNum do
          local uid = trinketUids[i] or 0
          local trinket = assitItems[uid] or ItemDataUtils.GetItemByUid(uid)
          if trinket then
            trinketDatas[i] = trinket
          end
        end
        local suitList = AwakerTrinketDataUtils.GetActiveSuitEffectDescList(trinketDatas)
        local mergeSuitName = ""
        for i = 1, 2 do
          local suitData = suitList and suitList[i]
          local suitName = suitData and suitData.suitName
          if suitName then
            if "" == mergeSuitName then
              mergeSuitName = suitName
            else
              mergeSuitName = mergeSuitName .. "、" .. suitName
            end
          end
        end
        replaceMap[startIndex + 15] = mergeSuitName
        replaceMap[startIndex + 17] = math.floor(AwakerTrinketDataUtils.GetTrinketsLevelCompletePercent(trinketDatas)) .. "%"
        replaceMap[startIndex + 18] = math.floor(AwakerTrinketDataUtils.GetTrinketsRefineCompletePercent(trinketDatas)) .. "%"
      end
    end
  end
  for i = 0, 100 do
    shareContent = shareContent:replace(string.format("{%s}", i), replaceMap[i] or "-", true)
  end
  print("------------------share content", shareContent, table.tostring(replaceMap))
  return shareContent
end

return CopySettleModel
