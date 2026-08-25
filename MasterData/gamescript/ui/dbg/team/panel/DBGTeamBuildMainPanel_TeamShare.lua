local DBGTeamBuildMainPanel = _ENV.DBGTeamBuildMainPanel
local WEAPON_COUNT = 2
local ASSIST_SLOT = 4

function DBGTeamBuildMainPanel:BindCopyAndShare()
  self.binder:SetActive(self.ui.Btn_Paste, true)
  self.binder:SetActive(self.ui.Btn_Copy, true)
  self.binder:BindButtonClick(self.ui.Btn_Copy, System.fn(self, self.OnBtnCopyTeam))
  self.binder:BindButtonClick(self.ui.Btn_Paste, System.fn(self, self.OnBtnPasteTeam))
end

function DBGTeamBuildMainPanel:OnBtnCopyTeam()
  local stageId = self.model.stageId
  if stageId and TeamAssignDataUtils.GetStageSpecialTeamId(stageId) then
    Alert.Show("PVETeamShareCodeSpecialTeamAssignTips")
    return
  end
  local shareContent = self:GetTeamShareContentByTeamIdx(self.model.curTeamIndex)
  if shareContent then
    StrUtils.CopyToClipboard(shareContent)
    Alert.ShowStr(LT.Text("PVETeamShareCodeCopyTips"))
  end
end

function DBGTeamBuildMainPanel:OnBtnPasteTeam()
  local stageId = self.model.stageId
  if stageId and TeamAssignDataUtils.GetStageSpecialTeamId(stageId) then
    Alert.Show("PVETeamShareCodeSpecialTeamAssignTips")
    return
  end
  local teamShareCode = StrUtils.PasteFromClipboard()
  local _, teamInfo = xpcall(function()
    do return DBGTeamDataUtils.GetTeamFromShareCode end
    return DBGTeamDataUtils.GetTeamFromShareCode, teamShareCode
  end, function(err)
    print("--------------GetTeamFromShareCode", err)
    Alert.Show("PVETeamShareCodeError")
    return
  end)
  if not teamInfo then
    Alert.Show("PVETeamShareCodeError")
    return
  end
  local isValid = DBGTeamDataUtils.ValidateShareTeamInfo(teamInfo)
  if not isValid then
    Alert.Show("PVETeamShareCodeError")
    return
  end
  Alert.Show("PVETeamShareCodeSaveTips", nil, function()
    self:PutSharedTeam(teamInfo)
  end)
end

function DBGTeamBuildMainPanel:PutSharedTeam(teamInfo)
  local awakerTids = teamInfo.awakerTids
  for i, awakerTid in ipairs(awakerTids) do
    if not AwakerDataUtils.HasOwnedAwaker(awakerTid) then
      awakerTids[i] = 0
    end
  end
  self.model:SetTeamAwakerTids(awakerTids, false, false)
  local weaponTids = teamInfo.weaponTids
  local usedWeaponUids = {}
  for slotIndex, weaponList in ipairs(weaponTids) do
    local weaponUids = {}
    local w1, w2 = table.unpack(weaponList)
    local maxLevelW1 = ItemDataUtils.GetMaxLevelItemOfTid(w1, usedWeaponUids)
    local maxLevelW2 = ItemDataUtils.GetMaxLevelItemOfTid(w2, usedWeaponUids)
    local quality1, quality2 = ItemDataUtils.GetQuality(w1), ItemDataUtils.GetQuality(w2)
    if quality1 == cd.CommonQuality.Orange and quality2 == cd.CommonQuality.Orange and maxLevelW1 and maxLevelW2 and maxLevelW1.level ~= cd.MaxWeaponLevel and maxLevelW2.level ~= cd.MaxWeaponLevel then
      maxLevelW1 = maxLevelW1.level > maxLevelW2.level and maxLevelW1 or maxLevelW2
      maxLevelW2 = nil
    end
    weaponUids[1] = maxLevelW1 and maxLevelW1.uid or 0
    weaponUids[2] = maxLevelW2 and maxLevelW2.uid or 0
    usedWeaponUids[weaponUids[1]] = true
    usedWeaponUids[weaponUids[2]] = true
    local _, isUnlockSecond = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.SecondaryWeapon, 0)
    if not isUnlockSecond then
      weaponUids[2] = 0
    end
    self.model:SetWeaponsGroupWithTeamSlot(weaponUids, slotIndex)
  end
  local trinketTids, trinketMainAttrs = teamInfo.trinketTids, teamInfo.trinketMainAttrs
  local usedTrinketUids = {}
  for slotIndex, tids in ipairs(trinketTids) do
    local mainAttrIds = trinketMainAttrs[slotIndex] or {}
    local trinketUids = {}
    for i = 1, cd.TeamTrinketCount do
      local tid, mainAttrId = tids[i], mainAttrIds[i] or 0
      if 0 == tid then
        trinketUids[i] = 0
      else
        local trinket = AwakerTrinketDataUtils.GetTrinketOfMainAttrId(tid, mainAttrId, true, usedTrinketUids)
        trinketUids[i] = trinket and trinket.uid or 0
        if trinket and trinket.uid then
          usedTrinketUids[trinket.uid] = true
        end
      end
    end
    self.model:SetTrinketsGroupWithTeamSlot(trinketUids, slotIndex)
  end
  local keeperSkill = teamInfo.keeperSkill or 0
  if 0 ~= keeperSkill and ItemDataUtils.GetBagItemNum(keeperSkill) > 0 then
    self.model:SetKeeperSkill(keeperSkill)
  end
  self.model:SaveTeamToServer(nil, true)
end

function DBGTeamBuildMainPanel:GetTeamShareContentByTeamIdx(teamIdx)
  local teamDatas = DBGTeamDataUtils.GetDBGTeams(self.model.teamType)
  local teamData = teamDatas and teamDatas[teamIdx]
  if teamData then
    do return self.GetTeamShareContent, self end
    return self.GetTeamShareContent, self, teamData
  else
    Logger.Warn("没有编队数据" .. teamIdx)
  end
end

function DBGTeamBuildMainPanel:GetTeamDataShareCode(teamData)
  local awakerTids = teamData.awakerTids
  local assitItems = self.model:GetAssistItem() or {}
  local assistAwaker = self.model:GetAssistAwaker()
  local weaponTidList = {}
  for index, awakerTid in ipairs(teamData.awakerTids) do
    local awakerWeaponTids = {}
    weaponTidList[index] = awakerWeaponTids
    for weaponSlot = 1, WEAPON_COUNT do
      local teamAwakerData = teamData.awakers[awakerTid] or {}
      if assistAwaker and index == ASSIST_SLOT then
        teamAwakerData = assistAwaker
      end
      local weapon = teamAwakerData.weaponSlots and teamAwakerData.weaponSlots[weaponSlot]
      if weapon and weapon.weaponUid and 0 ~= weapon.weaponUid then
        local weaponData = assitItems[weapon.weaponUid] or ItemDataUtils.GetItemByUid(weapon.weaponUid)
        awakerWeaponTids[weaponSlot] = weaponData and weaponData.tid
      end
    end
  end
  local trinketTidList, trinketMainAttrList = {}, {}
  for index, awakerTid in ipairs(teamData.awakerTids) do
    local awakerTrinketTids = {}
    local awakerTrinketMainAttrs = {}
    trinketTidList[index] = awakerTrinketTids
    trinketMainAttrList[index] = awakerTrinketMainAttrs
    local teamAwakerData = teamData.awakers[awakerTid] or {}
    if assistAwaker and index == ASSIST_SLOT then
      teamAwakerData = assistAwaker
    end
    local trinketUids = teamAwakerData.trinket and teamAwakerData.trinket.trinkets
    if not trinketUids and index == ASSIST_SLOT and assistAwaker then
      trinketUids = assistAwaker.trinkets
    end
    trinketUids = trinketUids or {}
    for i = 1, CommonDefine.MaxEquipTrinketsNum do
      local uid = trinketUids[i]
      if uid and AwakerDataUtils.IsTrinketBoundByAnyAwaker(uid) then
        uid = nil
      end
      local trinket = uid and assitItems[uid] or ItemDataUtils.GetItemByUid(uid)
      awakerTrinketTids[i] = trinket and trinket.tid
      local mainAttr = AwakerTrinketDataUtils.GetMainAttr(uid, assitItems)
      awakerTrinketMainAttrs[i] = mainAttr and mainAttr.attrId
    end
  end
  local keeperSkill = teamData.keeperSkill
  do return DBGTeamDataUtils.GetTeamShareCode, awakerTids, weaponTidList, trinketTidList, trinketMainAttrList end
  return DBGTeamDataUtils.GetTeamShareCode, awakerTids, weaponTidList, trinketTidList, trinketMainAttrList, keeperSkill, {}, assistAwaker, {}, 1, CommonDefine.MaxEquipTrinketsNum, 1, nil, nil, ItemDataUtils.GetItemByUid(uid), AwakerTrinketDataUtils.GetMainAttr(uid, assitItems), mainAttr and mainAttr.attrId, assitItems
end

function DBGTeamBuildMainPanel:GetTeamShareContent(teamData)
  local shareContent = LT.Text("PVETeamShareCode")
  local replaceMap = {}
  local shareCode = self:GetTeamDataShareCode(teamData)
  replaceMap[0] = shareCode
  replaceMap[1] = PlayerDataUtils.GetName()
  replaceMap[2] = PlayerDataUtils.GetPlayerUid()
  replaceMap[3] = LT.Text(teamData.name)
  replaceMap[4] = teamData.keeperSkill and ItemDataUtils.GetItemName(teamData.keeperSkill)
  local awakerIndex, awakerIndexGap = 10, 20
  local assitItems = self.model:GetAssistItem() or {}
  local assistAwaker = self.model:GetAssistAwaker()
  for slotIndex, awakerTid in ipairs(teamData.awakerTids) do
    local startIndex = awakerIndex + (slotIndex - 1) * awakerIndexGap
    awakerTid = slotIndex == ASSIST_SLOT and assistAwaker and assistAwaker.tid or awakerTid
    if awakerTid and 0 ~= awakerTid then
      local teamAwakerData = teamData.awakers[awakerTid]
      local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
      if slotIndex == CommonDefine.TeamAssistPos and assistAwaker then
        awakerData = assistAwaker
        teamAwakerData = assistAwaker
      end
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
        print("---------------talents", table.tostring(awakerData.talents))
        for talentTid, talentData in pairs(awakerData.talents or {}) do
          local talentCfg = DT.AwakerTalent[talentTid] or {}
          local firstLevelData = talentCfg.data_list and talentCfg.data_list[1] or {}
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
        for i = 1, WEAPON_COUNT do
          local weapon = teamAwakerData.weaponSlots[i]
          if weapon and weapon.weaponUid and 0 ~= weapon.weaponUid then
            local weaponData = assitItems[weapon.weaponUid] or ItemDataUtils.GetItemByUid(weapon.weaponUid)
            local weaponName = ItemDataUtils.GetItemName(weaponData.tid)
            local lv = weaponData.level
            print("-----------------weapon data", weaponData.tid, ItemDataUtils.GetItemName(weaponData.tid), table.tostring(weaponData))
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
        print("---------------suitList", table.tostring(suitList))
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
