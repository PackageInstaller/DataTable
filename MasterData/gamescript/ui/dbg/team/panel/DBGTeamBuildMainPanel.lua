local AutoAdaptionText = require("GameScript.Managers.UI.Components.AutoAdaptionText")
local tableInsert = table.insert
local typeof = _ENV.typeof
local TeamAssign = CommonDefine.TeamAssign
local eStageTeamMode = TeamAssign.eStageTeamMode
local AddClipToPlay = AnimatorUtils.AddClipToPlay
local UIAnimationController = CS.Z1Client.UIAnimationController
local TeamStageTipUtils = _G.TeamStageTipUtils
local DBGTeamBuildMainPanel, Super = System.NewClass("DBGTeamBuildMainPanel", UIBasePanel)
DBGTeamBuildMainPanel.uiResCls = UI_Team_Panel_MainResource

function DBGTeamBuildMainPanel:ctor(data)
  Super.ctor(self)
  self.data = data
  self.awakerAttrFlag = Vue.ref(0)
  self.teamListComp = {}
  self.bonusCardDes = Vue.ref(nil)
end

function DBGTeamBuildMainPanel:OnBind(binder)
  Logger.ReportApusInfo("DBGTeam EnterView")
  self.binder = binder
  self.model = binder:createModel(DBGTeamBuildModel, self.data)
  self.toggleContentRT = self.ui.Content:GetComponent(typeof(CS.UnityEngine.RectTransform))
  self:_OnBindLimitAwakerGroup(binder)
  if DataCenter.dbgTeamData.clearForbiddenAwakers then
    local tids = {
      0,
      0,
      0,
      0
    }
    for idx, tid in ipairs(self.model.teamAwakerTids) do
      if not self.model:IsForbidden(tid) then
        tids[idx] = tid
      end
    end
    self.model:SetTeamAwakerTids(tids)
    DataCenter.dbgTeamData.clearForbiddenAwakers = false
  end
  self:InitAnimation()
  self:OnBindPageAnim(binder)
  self:OnBindBtns(binder)
  binder:BindComponent(DBGTeamRecommendLevel(self.ui.uiNode, self.model))
  binder:BindComponent(DBGTeamRecommendSchool(self.ui.uiNode, self.model))
  self:OnBindRevivalCoin(binder)
  self:OnBindSchool(binder)
  self:OnBindAssistGroup(binder)
  self:OnBindFightingAwakers(binder)
  self:OnBindManageEntry(binder)
  self:OnBindForbidTipAndNormalTip()
  self:OnBindIllustrateTips(binder)
  self:OnBindTeamCopyAndShare(binder)
  binder:BindToVisible(self.ui.Text_C_Hint, function()
    do return self.model.IsLimitAwakers end
    return self.model.IsLimitAwakers, self.model
  end)
  binder:BindToRaw(function(_, tip)
    self.binder:SetText(self.ui.Text_C_Hint, tip)
    AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_C_Hint)
  end, function()
    return self.model:IsAbyssChallenge() and "AbyssAwakerLimitTips" or "AwakerUseTimesLimitTips"
  end)
  binder:BindToText(self.ui.Text_Title, function()
    local rst = LT.Text("TeamTitleText")
    if self.model.stageCfg then
      local stageGroupConfig = DT.StageGroup[self.model.stageCfg and self.model.stageCfg.BelongGroup or 0]
      if stageGroupConfig and LT.Text(stageGroupConfig.TypeText) then
        rst = stageGroupConfig and LT.Text(stageGroupConfig.TypeText)
      end
    end
    return rst
  end)
  binder:BindToRaw(function(childBinder, content, _)
    CS.Framework.UIUtilTool.RefreshLayout(self.ui.Group_Layout)
    childBinder:SetText(self.ui.Text_Label, content)
  end, function()
    return self.model.curTeamName or ""
  end)
  binder:BindToVisible(self.ui.Image_Recommend_1, function()
    return self.model.teamMode ~= eStageTeamMode.Preview
  end)
  binder:BindToVisible(self.ui.Image_Backslash, function()
    return self.model.teamType == CommonDefine.TeamType.Normal
  end)
  binder:BindToVisible(self.ui.Group_Toggle, function()
    do return TeamAssignDataUtils.IsTeamPanelShowGroupToggle end
    return TeamAssignDataUtils.IsTeamPanelShowGroupToggle, self.data.teamMode
  end)
  binder:BindToRaw(function(childBinder, nVal, oVal)
    if nil == oVal then
      return
    end
    if nVal then
      self:PlayAnim("UI_Team_Popup_Awaker_List_open")
      childBinder:BindComponent(require("UI.Dbg.Team.Item.DBGTeamChooseAwakerGroupItem")(self.ui.UI_Team_Popup_Awaker_List, self.model, self.model.BuildTeamType.QuickBuild))
    else
      self:PlayAnim("UI_Team_Popup_Awaker_List_close")
    end
  end, function()
    return self.model.isShowQuickBuildPanel
  end)
  self.TeamListView = self:CreateTableview(self.ui.TeamView, function()
    if not self.model.allTeamList then
      return 0
    end
    return #self.model.allTeamList
  end, function(view, idx)
    local cell = self:DequeueCell(view, self.ui.Btn_Team)
    local oldComp = self.teamListComp[cell.gameObject]
    if oldComp and oldComp.binder then
      oldComp.binder:teardown()
    end
    local comp = self.binder:BindComponent(DBGTeamListIndexItem(cell.gameObject, idx, self.model))
    self.teamListComp[cell.gameObject] = comp
    return cell
  end)
  self.binder:BindToRaw(function(_, newValue, oldValue)
    if oldValue then
      function self.TeamListView.reloadFinishCallback()
        self.TeamListView:MoveCellToCenter(newValue)
      end
    end
    self.TeamListView:ReloadData()
  end, function()
    return #self.model.allTeamList
  end)
  
  function self.TeamListView.reloadFinishCallback()
    if #self.model.allTeamList > 0 and self.model.curTeamIndex and self.model.curTeamIndex > 0 then
      self.TeamListView:MoveCellToCenter(self.model.curTeamIndex - 1)
    end
  end
  
  if self.model.teamMode ~= eStageTeamMode.Special then
    self.model:SetDefaultTeamIndex(0)
  end
  self:BindKeeperSkill(binder)
  self:BindButtonChangeName(binder)
  self:BindTeamAttrButton(binder)
  self:BindSomeAwakerAttrs(binder)
  self:_RefreshActivityBonusCard()
  self:_RefreshActivityMadnessChallengeTips()
  GlobalDispatcher:AddListener(NotifyId.OnAssistAwakerChanged, self._RefreshActivityBonusCard, self)
  GlobalDispatcher:AddListener(NotifyId.OnAwakerPotentiaUpgrade, self._RefreshActivityBonusCard, self)
  GlobalDispatcher:AddListener(NotifyId.OnTeamCacheRefreshed, self._OnTeamCacheRefreshed, self)
end

function DBGTeamBuildMainPanel:_OnTeamCacheRefreshed(teamType)
  self.model:SyncTrinketsFromTeamCache(teamType)
end

function DBGTeamBuildMainPanel:_RefreshActivityBonusCard()
  local isCrazy = self.model.stageCfg.DailyChallengeMadnessDifficulty and 1 == self.model.stageCfg.DailyChallengeMadnessDifficulty or false
  local stageGroupTid = self.model.stageCfg and self.model.stageCfg.BelongGroup or 0
  local assistAwaker = self.model:GetAssistAwaker()
  local assistItems = self.model:GetAssistItem()
  local bonusRate = BonusCardModel.Instance:GetBonusRateByStageGroupTid(stageGroupTid, assistAwaker, assistItems)
  if isCrazy or not bonusRate then
    return
  end
  local rateText = bonusRate .. "%%"
  local tipsText = BonusCardModel.Instance:GetBonusShortTips(stageGroupTid, rateText)
  self.bonusCardDes.value = tipsText
end

function DBGTeamBuildMainPanel:_RefreshActivityMadnessChallengeTips()
  local isCrazy = self.model.stageCfg.DailyChallengeMadnessDifficulty and 1 == self.model.stageCfg.DailyChallengeMadnessDifficulty or false
  if not isCrazy then
    self.ui.Text_Madness:SetActive(false)
    return
  end
  if not ActivityManager.Instance:IsActivityStageGroup(self.model.stageCfg.BelongGroup) then
    self.ui.Text_Madness:SetActive(false)
    return
  end
  self.binder:SetText(self.ui.Text_Madness, LT.Text("ActivityStageMadnessChallengeTips"))
  self.ui.Text_Madness:SetActive(true)
end

function DBGTeamBuildMainPanel:BindKeeperSkill(binder)
  self.ui.Btn_Skill:SetActive(true)
  binder:BindToRaw(function(cBinder)
    local keeperSkillItem = self.model:GetDisplayKeeperSkillItem()
    local curSkillId = KeeperSkillUtils.GetSkillIdByItem(keeperSkillItem)
    local skillCfg = curSkillId and DT.Skill[curSkillId] or nil
    local isKeeperSkillEmpty = nil == skillCfg
    local isDisableKeepSkill = self.model:IsDisableKeepSkill()
    local isKeeperSkillFighted = self.model:GetKeeperSkillFightedStageGroupId() or self.model:IsBanTid(keeperSkillItem)
    local showLockState, showEmptyState, showNorState, showBanState
    
    local function SetBtnState()
      self.ui.Group_Lock:SetActive(showLockState)
      self.ui.Group_Empty:SetActive(showEmptyState)
      self.ui.Group_Nor:SetActive(showNorState)
      self.ui.Group_Ban:SetActive(showBanState)
    end
    
    if isDisableKeepSkill then
      showLockState = isDisableKeepSkill
    elseif isKeeperSkillEmpty then
      showEmptyState = isKeeperSkillEmpty
    else
      showNorState = true
      showBanState = isKeeperSkillFighted
    end
    SetBtnState()
    local skillName = isKeeperSkillEmpty and "" or BattleSkillUtils.GetSkillName(skillCfg, 0, 0)
    cBinder:SetText(self.ui.Text_Introduce, skillName)
    cBinder:BindButtonClick(self.ui.Btn_Skill, function()
      if TeamAssignDataUtils.GetStageSpecialKeeperSkill(self.model.stageId) then
        Alert.Show(20234)
        return
      end
      if self.model.teamMode == eStageTeamMode.Preview then
        ItemDataUtils.ShowItemDetailTips(cBinder, self.ui.Btn_Skill, nil, keeperSkillItem)
        return
      end
      if isDisableKeepSkill then
        return
      end
      if self.model:GetUniqueSkillItem() then
        Alert.ShowStr(LT.Text("KeeperSkillCannotChange"))
        return
      end
      local keeperSkillController = KeeperSkillController.Instance
      keeperSkillController:OpenKeeperSkillView(self.model)
    end)
    cBinder:BindToImage(self.ui.Keeper_Skill_Icon, function()
      do return KeeperSkillUtils.GetSkillIcon end
      return KeeperSkillUtils.GetSkillIcon, keeperSkillItem
    end)
  end, function()
    do return self.model.GetDisplayKeeperSkillItem end
    return self.model.GetDisplayKeeperSkillItem, self.model
  end)
  binder:BindComponent(require("UI.Common.RedDotComponent")(self.ui.RedDot_KeeperSkill, CommonDefine.RedDotType.TextNew, function()
    do return end
    return RedPointDataUtils.GetKeeperRedPoint, nil
  end))
  binder:BindToVisible(self.ui.RedDot_KeeperSkill, function()
    return self.model.teamMode ~= eStageTeamMode.Preview
  end)
end

function DBGTeamBuildMainPanel:BindButtonChangeName(binder)
  binder:BindToRaw(function(childBinder, show, _)
    self.ui.Button:SetActive(show)
    self.ui.Text_Label:SetActive(show)
  end, function()
    return self.data.teamMode == eStageTeamMode.Normal
  end)
  binder:BindButtonClick(self.ui.Button, function()
    UIManager.Instance:Reopen(Urls.DBGTeamRenamePanel, self.model, self.model.curTeamIndex)
  end)
end

function DBGTeamBuildMainPanel:BindTeamAttrButton(binder)
  self.ui.UI_Btn_TeamInfo:SetActive(eStageTeamMode.Special ~= self.data.teamMode)
  binder:BindZ1Button(self.ui.UI_Btn_TeamInfo, function()
    self.ui.Group_Popup:SetActive(true)
  end)
  binder:BindButtonClick(self.ui.Button_PopupClose, function()
    self.ui.Group_Popup:SetActive(false)
  end)
  local comp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_C_Tips2)
  if comp then
    comp:SetBtn(self.ui.UI_Btn_TeamInfo)
  end
end

function DBGTeamBuildMainPanel:BindSomeAwakerAttrs(binder)
  binder:BindToRaw(function(childBinder, _, _)
    self:UpdateTeamAttr(childBinder)
  end, function()
    return self.awakerAttrFlag.value
  end)
end

function DBGTeamBuildMainPanel:UpdateTeamAttr(childBinder)
  self:_CalEquipAttrsFromTeamModel()
  self:_CalBindBonusAttrTids()
  local ui_teamAttrInfo = UI_Team_Panel_Main_Popup_TeamResource(self.ui.UI_Team_Panel_Main_Popup_Team)
  ui_teamAttrInfo.UI_Team_Panel_Main_item1:SetActive(false)
  local attrs = {}
  local awakerList = table.clone(self.model.teamAwakerTids)
  local assistAwakerId = self.model:GetAssistAwakerId()
  if 0 ~= assistAwakerId then
    awakerList[self.model.MaxBattleNum] = assistAwakerId
  end
  local assistAwaker = self.model:GetAssistAwaker()
  
  local function GetTeamAwakerAttrsFunc(attrName)
    if attrName == bc.RoleProperty.occupation_master then
      local value = AwakerDataUtils.GetTeamAwakerAttrs(awakerList, attrName, assistAwaker)
      local finial_per = AwakerDataUtils.GetTeamAwakerAttrs(awakerList, "occupation_master_final_per", assistAwaker)
      do return math.ceil end
      return math.ceil, value * (1 + (finial_per or 0) / 100), assistAwaker
    end
    do return AwakerDataUtils.GetTeamAwakerAttrs, awakerList, attrName end
    return AwakerDataUtils.GetTeamAwakerAttrs, awakerList, attrName, assistAwaker, assistAwaker
  end
  
  attrs[bc.RoleProperty.occupation_master] = GetTeamAwakerAttrsFunc(bc.RoleProperty.occupation_master)
  attrs[bc.RoleProperty.blackcoin_upgrade_per] = GetTeamAwakerAttrsFunc(bc.RoleProperty.blackcoin_upgrade_per)
  attrs[bc.RoleProperty.basic_damage_per] = GetTeamAwakerAttrsFunc(bc.RoleProperty.basic_damage_per)
  attrs[bc.RoleProperty.death_resist] = GetTeamAwakerAttrsFunc(bc.RoleProperty.death_resist)
  local playerLevel = math.max(PlayerDataUtils.GetLevel(), self.model:GetStageAjustPlayerLevel() or 0)
  local awakerLevelDict = {}
  for _, awakerTid in pairs(awakerList) do
    awakerLevelDict[awakerTid] = math.max(AwakerDataUtils.GetAwakerLevel(awakerTid) or 1, self.model:GetStageAjustAwakerLevel() or 1)
  end
  attrs[bc.RoleProperty.AccountLvBattleCurve] = AttrUtils.GetAwakersAccountLvBattleCurve(awakerList, awakerLevelDict, playerLevel)
  local datalist = AwakerDataUtils.Process2ShowAttrs(attrs)
  self.tempObj = self.tempObj or {}
  for index, data in ipairs(datalist) do
    local itemData = {
      clientAttr = data,
      resourceCls = UI_Team_Panel_Main_item1Resource
    }
    self:_ApplyEquipsAttr(itemData)
    self:_ApplyBindBonusColor(itemData)
    local uiNode = CS.UnityEngine.GameObject.Instantiate(ui_teamAttrInfo.UI_Team_Panel_Main_item1, self.ui.UI_Team_Panel_Main_Popup_Team.transform)
    table.insert(self.tempObj, uiNode)
    uiNode:SetActive(true)
    childBinder:BindComponent(AwakerAttrItem(uiNode, itemData))
    childBinder:onDestroy(function()
      if self.tempObj then
        for _, obj in ipairs(self.tempObj) do
          CS.UnityEngine.GameObject.Destroy(obj)
        end
      end
      self.tempObj = {}
    end)
  end
end

function DBGTeamBuildMainPanel:_ApplyEquipsAttr(itemData)
  local attrId = itemData.clientAttr.tid
  if not (self.equipsAttrs and self.equipsAttrs[attrId]) or 0 == self.equipsAttrs[attrId] then
    return
  end
  itemData.clientAttr.count = (itemData.clientAttr.count or 0) + self.equipsAttrs[attrId]
end

function DBGTeamBuildMainPanel:_CalEquipAttrsFromTeamModel()
  self.equipsAttrs = {}
  if not self.model then
    return
  end
  AwakerTrinketExtModel.Instance:CalTrinketAttrsFromTeamModel(self.model, self.equipsAttrs)
  TeamWeaponModel.Instance:CalWeaponAttrsFromTeamModel(self.model, self.equipsAttrs)
end

function DBGTeamBuildMainPanel:_CalBindBonusAttrTids()
  self.bindBonusAttrTids = {}
  if not self.model then
    return
  end
  local maxNum = CommonDefine.TeamAssign.MaxBattleNum
  for slotIndex = 1, maxNum do
    local contributions = AwakerTrinketExtModel.Instance:CollectSlotBindContributions(self.model, slotIndex)
    for attrId in pairs(contributions) do
      self.bindBonusAttrTids[attrId] = true
    end
  end
end

function DBGTeamBuildMainPanel:_ApplyBindBonusColor(itemData)
  local clientAttr = itemData.clientAttr
  local attrId = clientAttr and clientAttr.tid
  if not (attrId and self.bindBonusAttrTids) or not self.bindBonusAttrTids[attrId] then
    return
  end
  local attrType = DT.ActorAttrType[attrId]
  if not attrType then
    return
  end
  local textCount = AwakerTrinketDataUtils.GetAttrFmtStringByValue(clientAttr.count, clientAttr.isPercent)
  itemData.showAttr = {
    textCount = AwakerTrinketDataUtils.GetBindBonusAttrText(textCount),
    imageIcon = attrType.Icon,
    textName = LT.Text(attrType.Text)
  }
end

function DBGTeamBuildMainPanel:OnCareerClick()
  UIManager.Instance:Reopen(Urls.DBGTeamCareerPanel, self.model.careerEffectList)
end

function DBGTeamBuildMainPanel:Challenge()
  if self.model:IsForceAssistStage() and not self.model:GetAssistAwaker() then
    Alert.ShowStr(LT.Text("AlertForceAssist"))
    return
  end
  local keeperSkillFightedStageGroupId = self.model:GetKeeperSkillFightedStageGroupId()
  if keeperSkillFightedStageGroupId and CopyDataUtils.GetStageGroupConfig(keeperSkillFightedStageGroupId) then
    local keeperSkillItem = self.model:GetDisplayKeeperSkillItem()
    local curSkillId = KeeperSkillUtils.GetSkillIdByItem(keeperSkillItem)
    local skillName = BattleSkillUtils.GetSkillName(DT.Skill[curSkillId], 0, 0)
    local stageGroupName = LT.Text(DT.StageGroup[keeperSkillFightedStageGroupId].Name)
    local desc = DT.TipsType[10739].Desc
    Alert.ShowStr(LT.Textf(desc, skillName, stageGroupName))
    return
  end
  local keeperSkillItem = self.model:GetDisplayKeeperSkillItem()
  if not self.model:IsDisableKeepSkill() and 0 == keeperSkillItem then
    Alert.Show(10832)
    return
  end
  if self.model:IsBanTid(keeperSkillItem) then
    Alert.Show(10850)
    return
  end
  if self.model:CheckCurWeaponGroupIsFighted() then
    Alert.Show(10833)
    return
  end
  local schoolList = self.model:GetTeamSchoolList()
  if #schoolList > 2 then
    Alert.Show("SchoolConflictTips")
    return
  end
  local unmetSchoolId, unmetNum = self.model:GetUnmetSchoolLimit()
  if unmetSchoolId then
    local schoolCfg = DT.SchoolConfig[unmetSchoolId]
    local tipsId = 10758
    local desc = LT.Textf(DT.TipsType[tipsId].Desc, unmetNum, LT.Text(schoolCfg.Name))
    Alert.ShowStr(desc)
    return
  end
  if self:HaveForbiddenAwaker() then
    Alert.Show(10830)
    return
  end
  if self.model.fightAwakerNum < self.model.MaxBattleNum then
    local desc = LT.Textf(DT.TipsType[10522].Desc, self.model.MaxBattleNum)
    Alert.SetMaskClickClose(true)
    Alert.Show(10522, nil, nil, nil, desc)
    return
  end
  local needFightAwakerTid = TeamAssignDataUtils.GetIsOwnedAwakerTid(self.model.stageCfg.SpecialTeamIndex)
  if needFightAwakerTid and not table.contains(self.model.teamAwakerTids, needFightAwakerTid) then
    Alert.ShowStr(LT.Textf("TeamNeedFightAwakerTips", LT.Text(AwakerDataUtils.GetAwakerName(needFightAwakerTid))))
    return
  end
  AudioManager.Instance:PostSoundEvent("TEAM_START_FIGHT")
  if self.data.sweepModel then
    self:OnCloseActively()
    return
  end
  local awakerList = {}
  for _, awakerTid in pairs(self.model.teamAwakerTids) do
    tableInsert(awakerList, awakerTid)
  end
  local awakerNames = self:_GetAwakersEquippedWithUselessWeapon(awakerList)
  if #awakerNames > 0 and self.model:IsAbyssChallenge() then
    Alert.Show(10831)
    return
  end
  local banUnitNames = self.model:GetBanUnitNamesByStageType()
  if #banUnitNames > 0 then
    local tipsKey = 10757
    local desc = LT.Textf(DT.TipsType[tipsKey].Desc, table.concat(banUnitNames, ","))
    Alert.Show(tipsKey, nil, nil, nil, desc)
    return
  end
  local awakerDataList = {}
  for idx, awakerTid in ipairs(awakerList) do
    if idx == self.model.MaxBattleNum and self.model:GetAssistUid() ~= nil then
      table.insert(awakerDataList, self.model:GetAssistAwaker())
    else
      table.insert(awakerDataList, AwakerDataUtils.GetAwakerData(awakerTid))
    end
  end
  if #awakerNames > 0 then
    local tipsKey = 10742
    local desc = LT.Textf(DT.TipsType[tipsKey].Desc, table.concat(awakerNames, ","))
    Alert.Show(tipsKey, nil, function()
      if self:_TryRemindInvalidTrinkets(awakerDataList, System.bind(self.ShowTeamBuildDesc, self, awakerList)) then
        return
      end
      self:ShowTeamBuildDesc(awakerList)
    end, nil, desc, nil, true)
  else
    if self:_TryRemindInvalidTrinkets(awakerDataList, System.bind(self.ShowTeamBuildDesc, self, awakerList)) then
      return
    end
    self:ShowTeamBuildDesc(awakerList)
  end
end

function DBGTeamBuildMainPanel:_CreateTrinketDatas()
  local rst = {}
  for teamIdx, trinketUids in pairs(self.model.teamTrinketGroups) do
    if not rst[teamIdx] then
      rst[teamIdx] = {}
    end
    if teamIdx == self.model.MaxBattleNum and self.model:GetAssistUid() ~= nil then
      local assistTrinketUids = self.model:GetAssistAwaker().trinkets
      local assistItems = self.model:GetAssistItem()
      for slot, trinketUid in pairs(assistTrinketUids) do
        local trinketData = assistItems[trinketUid]
        rst[teamIdx][slot] = trinketData or nil
      end
    else
      for slot, trinketUid in pairs(trinketUids) do
        local trinketData = ItemDataUtils.GetItemByUid(trinketUid)
        rst[teamIdx][slot] = trinketData
      end
    end
  end
  return rst
end

function DBGTeamBuildMainPanel:_TryRemindInvalidTrinkets(awakerList, confirmCb, cancelCb)
  local awakerNames = AwakerTrinketDataUtils.GetInvalidTrinketAwakerNames(awakerList, self:_CreateTrinketDatas())
  if awakerNames and #awakerNames > 0 then
    local tipsDesc = LT.Textf(DT.TipsType[10799].Desc, table.concat(awakerNames, ","))
    Alert.Show(10799, cancelCb, confirmCb, nil, tipsDesc, nil, true)
    return true
  end
  return false
end

function DBGTeamBuildMainPanel:_GetAwakersEquippedWithUselessWeapon(awakerList)
  local awakerNames = {}
  local equippedWeapons = {}
  for i, checkAwakerId in ipairs(awakerList) do
    local hasUselessWeapon = false
    
    local function updateEquippedWeaponsFunc(weaponItem)
      if weaponItem then
        if equippedWeapons[weaponItem.tid] then
          hasUselessWeapon = true
        else
          equippedWeapons[weaponItem.tid] = true
        end
      end
      return hasUselessWeapon
    end
    
    if i == self.model.MaxBattleNum and self.model:GetAssistUid() ~= nil then
      local awakerData = self.model:GetAssistAwaker()
      local itemsMap = self.model:GetAssistItem()
      checkAwakerId = awakerData.tid
      for _, slotType in ipairs(CommonDefine.WeaponSlotGroup) do
        local slotData = AwakerDataUtils.GetWeaponSlotDataWithType(awakerData, slotType)
        if slotData.weaponUid > 0 then
          local weaponItem = itemsMap[slotData.weaponUid]
          updateEquippedWeaponsFunc(weaponItem)
        end
      end
    elseif self.model.teamWeaponGroups then
      for _, weaponUid in ipairs(self.model.teamWeaponGroups[i] or {}) do
        if weaponUid and 0 ~= weaponUid then
          local weaponItem = ItemDataUtils.GetItemByUid(weaponUid)
          updateEquippedWeaponsFunc(weaponItem)
        end
      end
    end
    if hasUselessWeapon then
      local awakerName = AwakerDataUtils.GetAwakerName(checkAwakerId)
      if "" ~= awakerName then
        table.insert(awakerNames, awakerName)
      end
    end
  end
  return awakerNames
end

function DBGTeamBuildMainPanel:OnBindPageAnim(binder)
  binder:BindToRaw(function(_, nVal, oVal)
    if nVal == CommonDefine.DBGTeamBuildPage.Main and oVal and oVal == CommonDefine.DBGTeamBuildPage.SingleChoose then
      binder:SetCanvasGroup(self.ui.Text_Disable, 1)
      binder:SetCanvasGroup(self.ui.Text_Rule, 1)
      self:PlayAnim("UI_Team_Panel_Main_open_02", function()
        binder:SetCanvasGroup(self.ui.Text_Disable, 1)
        binder:SetCanvasGroup(self.ui.Text_Rule, 1)
      end)
    end
    if nVal == CommonDefine.DBGTeamBuildPage.SingleChoose and oVal == CommonDefine.DBGTeamBuildPage.Main then
      self:PlayAnim("UI_Team_Panel_Main_close")
    end
  end, function()
    return self.model.page
  end)
end

function DBGTeamBuildMainPanel:OnBindBtns(binder)
  self.closeBtn = binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    self:OnCloseActively()
  end))
  binder:BindButtonClick(self.ui.Btn_Page_Turn, System.fn(self, self.ShowTeamListPanel))
  binder:BindToVisible(self.ui.Btn_Challenge, function()
    do return table.next end
    return table.next, self.model.stageCfg
  end)
  binder:BindZ1Button(self.ui.Btn_Challenge, System.fn(self, self.Challenge), function()
    if self:CanStartChallenge() then
      return CommonDefine.BtnType.High
    else
      return CommonDefine.BtnType.Unclickable
    end
  end, function()
    if self.data.sweepModel then
      do return LT.Text end
      return LT.Text, "Formation_Fast_Sure_Btn"
    end
    do return LT.Text end
    return LT.Text, "Formation_EnterCopy_Btn"
  end, nil, nil, nil)
  binder:BindZ1Button(self.ui.Btn_Fast, System.fn(self, self.QuickBuildTeam), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "Formation_Fast_Btn"
  end, nil, nil, nil)
  binder:BindToVisible(self.ui.Btn_Fast, function()
    return self.model.teamMode ~= eStageTeamMode.Preview
  end)
  binder:BindTimer(0.3, 0, nil, function()
    local go = GuidePanelUtils.GetNodeGo("UI_Team_Panel_Main(Clone).Group_Team.Awaker_1.Image_Weapon_1")
    NewbieGuideManager.Instance:RegisterNewbieGo("GuideGo_AwakerWeapon1", go, Urls.DBGTeamBuildMainPanel)
  end)
end

function DBGTeamBuildMainPanel:OnBindRevivalCoin(binder)
  local stageCfg = DT.Stage[self.model.stageId]
  if not (stageCfg and stageCfg.RevivalAllowed) or 1 == stageCfg.RevivalAllowed then
    local coinId = DT.GetConstant("RevivalItemId")
    if coinId then
      self.ui.Coin_1:SetActive(true)
      binder:BindComponent(require("UI.Common.CoinInfoComponent")(self.ui.Coin_1, coinId, nil))
    else
      self.ui.Coin_1:SetActive(false)
    end
  else
    self.ui.Coin_1:SetActive(false)
  end
end

function DBGTeamBuildMainPanel:_GetTeamStageTipContext()
  do return TeamStageTipUtils.GetTeamBuildContext, self.model end
  return TeamStageTipUtils.GetTeamBuildContext, self.model, function()
    return self.bonusCardDes.value
  end
end

function DBGTeamBuildMainPanel:OnBindIllustrateTips(binder)
  TeamStageTipUtils.BindIllustrateButton(binder, self.ui.Challenge_Award, function()
    do return self._GetTeamStageTipContext end
    return self._GetTeamStageTipContext, self
  end, true)
end

function DBGTeamBuildMainPanel:OnBindForbidTipAndNormalTip()
  TeamStageTipUtils.BindDisableAndNormalTip(self.binder, self.ui.Text_Disable, self.ui.Text_Rule, function()
    do return self._GetTeamStageTipContext end
    return self._GetTeamStageTipContext, self
  end)
end

function DBGTeamBuildMainPanel:OnBindTeamCopyAndShare()
  require("GameScript.UI.Dbg.Team.Panel.DBGTeamBuildMainPanel_TeamShare")
  self:BindCopyAndShare()
end

function DBGTeamBuildMainPanel:ShowForceAssistStage(isForce)
  if isForce then
    self.binder:SetActive(self.ui.Text_Disable, true)
    self.binder:SetText(self.ui.Text_Disable, LT.Text("ForceAssistTeam"))
  end
end

function DBGTeamBuildMainPanel:OnBindSchool(binder)
  local effectMap = {
    [CommonDefine.AwakerSchool.Aequor] = "Icon/Career/Icon_Career2_Hundun_Glow.png",
    [CommonDefine.AwakerSchool.Caro] = "Icon/Career/Icon_Career2_Xuerou_glow.png",
    [CommonDefine.AwakerSchool.Dimension] = "Icon/Career/Icon_Career2_Chaowei_Glow.png",
    [CommonDefine.AwakerSchool.NewAequor] = "Icon/Career/Icon_Career2_Shenhai_Glow.png"
  }
  binder:BindButtonClick(self.ui.Button_Career, System.fn(self, self.OnCareerClick))
  binder:BindToRaw(function(cbinder, enabledSchoolList)
    if table.next(enabledSchoolList) then
      local function setCall()
        local icon, glowIcon
        
        cbinder:SetActive(self.ui.Icon_Actived_School, true)
        local school1, school2 = table.unpack(enabledSchoolList)
        if school1 and school2 then
          local key = school1 * school2
          icon = cd.SchoolIconMix[key]
        else
          local schoolCfg = DT.SchoolConfig[school1]
          icon = schoolCfg and schoolCfg.IconGlow
          glowIcon = effectMap[school1]
        end
        if self.triPlayActiveEffect then
          self.triPlayActiveEffect = false
          self:PlayAnim("UI_Team_Panel_Main_Icon_Actived_School")
        end
        cbinder:SetText(self.ui.Text_Career_Actived, LT.Text("School_Activate"))
        cbinder:SetImage(self.ui.Icon_Actived_School, icon)
        cbinder:SetImage(self.ui.Icon_Actived_School_Glow, glowIcon)
      end
      
      if self.triPlayActiveEffect then
        cbinder:SetActive(self.ui.Icon_Actived_School, false)
        FrameWaiter.OnNextFrame(setCall, 5)
      else
        setCall()
      end
    else
      cbinder:SetActive(self.ui.Icon_Actived_School, true)
      cbinder:SetText(self.ui.Text_Career_Actived, LT.Text("Team_Occupation_Tips"))
      cbinder:SetImage(self.ui.Icon_Actived_School, DT.GetConstant("School_None_Icon"))
    end
  end, function()
    do return self.model.GetEnabledSchoolList end
    return self.model.GetEnabledSchoolList, self.model
  end)
  self.binder:BindToTextColor(self.ui.Text_Career_Actived, function()
    local enabledSchools = self.model:GetEnabledSchoolList()
    return #enabledSchools > 0 and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark
  end)
  binder:BindEvent(EventMgr.Instance.OnClickFightAwakerItem, function(direction)
    self.triPlayActiveEffect = true
  end)
  binder:BindEvent(EventMgr.Instance.AwakerAttrChangeEvent, System.fn(self, self.AwakerAttrChange))
  binder:BindEvent(EventMgr.Instance.WeaponRefined, System.fn(self, self._RefreshWhenWeaponRefine))
end

function DBGTeamBuildMainPanel:_RefreshWhenWeaponRefine()
  self.model:SetTeamWeaponsGroup(table.deepclone(self.model.teamWeaponGroups))
  self:_RefreshActivityBonusCard()
end

function DBGTeamBuildMainPanel:OnBindAssistGroup(binder)
  binder:BindToVisible(self.ui.UI_Common_Btn_Help, function()
    do return self.model.IsAssistStage end
    return self.model.IsAssistStage, self.model
  end)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Help, System.fn(self, self.AssistBattle), function()
    if self.model:IsAbyssChallenge() and 0 == self.model:GetCanAssistCount() then
      return CommonDefine.BtnType.Normal
    end
    if self.model:GetAssistUid() then
      return CommonDefine.BtnType.Unclickable
    else
      return CommonDefine.BtnType.High
    end
  end)
  if self.model:IsAbyssChallenge() then
    binder:SetActive(self.ui.Text_Base, true)
    binder:SetActive(self.ui.UI_Common_Btn_Question, true)
    binder:BindToText(self.ui.Text_Base, function()
      return "/" .. DT.GetConstant("AbyssChallengeAwakerSupportTimes")
    end)
    binder:BindToText(self.ui.Text_Remaining, function()
      do return self.model.GetCanAssistCount end
      return self.model.GetCanAssistCount, self.model
    end)
    binder:BindZ1Button(self.ui.UI_Common_Btn_Question, function()
      UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text("AbyssChallengeAwakerAssistRuleTitle"), LT.Text("AbyssChallengeAwakerAssistRule"))
    end)
  else
    binder:SetActive(self.ui.Text_Base, false)
    binder:SetActive(self.ui.UI_Common_Btn_Question, false)
  end
end

function DBGTeamBuildMainPanel:AwakerAttrChange(eventName, eventValue)
  self.awakerAttrFlag.value = self.awakerAttrFlag.value + 1
end

function DBGTeamBuildMainPanel:_OnBindLimitAwakerGroup(binder)
  local schoolLimits = CopyDataUtils.GetAwakerRequirementMap(self.model.stageId)
  if not schoolLimits or not table.next(schoolLimits) then
    self.binder:SetActive(self.ui.Group_Career, false)
    return
  end
  self.binder:SetActive(self.ui.Group_Career, true)
  self.binder:SetText(self.ui.Text_Career, "TeamSchoolRequired")
  local index = 0
  for schoolId, num in pairs(schoolLimits) do
    index = index + 1
    local littleSchoolIcon = CopyDataUtils.GetSchoolIconLittle(schoolId)
    self.binder:SetImage(self.ui["Image_CareerIcon" .. index], littleSchoolIcon)
    self.binder:SetText(self.ui["Text_CareerNum" .. index], ItemNumUtils.GetStr(num))
  end
  self.binder:SetActive(self.ui.Image_CareerIcon1, index >= 1)
  self.binder:SetActive(self.ui.Text_CareerNum1, index >= 1)
  self.binder:SetActive(self.ui.Image_CareerIcon2, index >= 2)
  self.binder:SetActive(self.ui.Text_CareerNum2, index >= 2)
end

function DBGTeamBuildMainPanel:NeedCheckFightScore()
  if self.model:IsDailyChallenge() then
    Logger.Debug("#日常挑战本，不需要检查战力")
    return false
  end
  return true
end

function DBGTeamBuildMainPanel:CalcFightScoreLevel()
  local recommendScore = self.model.recommendFighting
  local recommandLevel
  local finalRecommandScore = recommendScore * tonumber(DT.GetConstant("CopyScoreNoticeLimit"))
  local scoreFormulaVal = (self.model.totalFighting - finalRecommandScore) / finalRecommandScore
  if scoreFormulaVal >= 0 then
    recommandLevel = 0
  elseif scoreFormulaVal >= -0.15 and scoreFormulaVal < 0 then
    recommandLevel = 1
  elseif scoreFormulaVal >= -0.3 and scoreFormulaVal < -0.15 then
    recommandLevel = 2
  else
    recommandLevel = 3
  end
  Logger.Debug("#战力提示等级为：", recommandLevel, self.model.totalFighting, finalRecommandScore, scoreFormulaVal)
  return recommandLevel
end

function DBGTeamBuildMainPanel:IsRecommandSchool(schoolTid)
  if not schoolTid or not self.model.recommandSchoolTids then
    return false
  end
  for _, tid in pairs(self.model.recommandSchoolTids) do
    if tid == schoolTid then
      return true
    end
  end
  return false
end

function DBGTeamBuildMainPanel:ShowTeamBuildDesc(awakerList)
  local function MatchCall()
    local buildDesc = self:GetTeamBuildDesc()
    
    if "" == buildDesc or self.IsSettingOpen(CommonDefine.SettingUniqueName.TeamImbalanceConfirm) == false then
      self:_PopStageGroupChallengeTips(awakerList)
    else
      Alert.SetMaskClickClose(true)
      Alert.Show(20057, function()
      end, function()
        self:_PopStageGroupChallengeTips(awakerList)
      end, DT.TipsType[20057].Title, string.format([[
%s
%s]], DT.TipsType[20057].Desc, buildDesc))
    end
  end
  
  if not self.model:HasRealFightAwaker() then
    MatchCall()
  else
    local teamMaxLv = DT.GetConstant("AwakerMaxLv")
    local teamRecommandLevel = self.model:GetStageLevel() or 0
    local playerRecommandLevel = self.model:GetStageLevel() or 0
    local playerLv = math.max(PlayerDataUtils.GetLevel(), self.model:GetStageAjustPlayerLevel() or 0)
    local teamAvergerLevel = self.model:GetTeamAvergerLevel()
    teamRecommandLevel = teamMaxLv < teamRecommandLevel and teamMaxLv or teamRecommandLevel
    local scoreInfoTipsKey = 0
    local desc = 0
    local cancelCall
    if playerRecommandLevel > playerLv and teamRecommandLevel > teamAvergerLevel then
      scoreInfoTipsKey = 10741
      desc = LT.Textf(DT.TipsType[scoreInfoTipsKey].Desc, teamAvergerLevel, playerLv, teamRecommandLevel)
    elseif teamRecommandLevel > teamAvergerLevel then
      scoreInfoTipsKey = 10618
      desc = LT.Textf(DT.TipsType[scoreInfoTipsKey].Desc, teamAvergerLevel, teamRecommandLevel)
      
      function cancelCall()
        local awakerTid = self.model:GetFirstValidAwakerTid()
        FuncJumpManager:JumpToAwakerLevel(awakerTid)
      end
    elseif playerRecommandLevel > playerLv then
      scoreInfoTipsKey = 10740
      desc = LT.Textf(DT.TipsType[scoreInfoTipsKey].Desc, playerLv, playerRecommandLevel)
    end
    if 0 ~= scoreInfoTipsKey then
      Alert.SetMaskClickClose(true)
      Alert.Show(scoreInfoTipsKey, cancelCall, MatchCall, nil, desc, nil, true)
    else
      MatchCall()
    end
  end
end

function DBGTeamBuildMainPanel:GetTeamBuildDesc()
  local descList = {
    SUP = LT.Text("TeamTypeTips_Auxiliary"),
    DPS = LT.Text("TeamTypeTips_Atk"),
    T = LT.Text("TeamTypeTips_Def")
  }
  for _, tid in pairs(self.model.teamAwakerTids) do
    local awakerCfg = DT.AwakerConfig[tid]
    if awakerCfg then
      descList[awakerCfg.Type] = nil
    end
  end
  local returnDesc = ""
  for _, desc in pairs(descList) do
    if desc then
      returnDesc = returnDesc .. string.format("%s\n", desc)
    end
  end
  return returnDesc
end

function DBGTeamBuildMainPanel:IsCanSkipPlot()
  local list = DT.GetOriginalConstant("RepeatedChallengeAllowSkipPlot")
  for _, stageType in ipairs(list) do
    if self.model.stageGroupType == stageType then
      local stageId = self.model.stageId
      local stageCfg = DT.Stage[stageId]
      local stageGroupId = stageCfg.BelongGroup
      local stageData = CopyDataUtils.GetAllTypeStageData(stageGroupId, stageId)
      if stageData.winTimes > 0 then
        return true
      end
    end
  end
  return false
end

function DBGTeamBuildMainPanel:_PopStageGroupChallengeTips()
  if self.model:IsAbyssChallenge() then
    Alert.Show(20123, nil, function()
      self:_RawChallenge()
    end)
    return
  end
  self:_RawChallenge()
end

function DBGTeamBuildMainPanel:RecordDailyChallengeStageId()
  if self.model.stageGroupType ~= CommonDefine.StageGroupType.DailyChallenge then
    return
  end
  local saveKey = CommonDefine.LocalSaveKey.DailyChallengeLastId
  MobileFileDataManager.Instance:SetPlayerFileValue(saveKey, self.model.stageId, true)
end

function DBGTeamBuildMainPanel:_RawChallenge(awakerList)
  Logger.Debug("#正式发起挑战！", table.tostring(awakerList))
  
  local function enterDup()
    if self.data and self.data.challengeFunc then
      self.model:SetIsStartChallenge(true)
      Logger.ReportApusInfo("DBGTeam SaveTeamToServer _RawChallenge ")
      self.model:SaveTeamToServer(nil)
      local assistAwakerId = self.model:GetAssistAwakerId()
      local assistPlayerUid = self.model:GetAssistUid()
      self:RecordDailyChallengeStageId()
      local sendTeamIdx = self.model:GetTeamSvrIdx()
      local awakerEquipData = table.deepclone(self.model:CreateAwakerEquipData())
      self.data.challengeFunc(sendTeamIdx, self.model:GetRealFightAwakerIdMap(), assistAwakerId, assistPlayerUid, awakerEquipData)
      if self.model.stageCfg.AutoSkipStory == cd.StageSkipStory.SkipAfterFirstTime then
        ClientDataUtils.SetData(cd.ClientDataMainKey.StageEntered, self.model.stageId, 1)
      else
        self:ClearStaleStageEnteredClientData()
      end
    end
  end
  
  local isFirstReward = CopyDataUtils.IsFirstRewardDraw(self.model.stageId)
  if isFirstReward and self.model.stageCfg.AutoSkipStory == cd.StageSkipStory.WinToSkip then
    AvgStoryManager.Instance:SetSkipPlot(self.model.stageId)
    enterDup()
  elseif self.model.stageCfg.AutoSkipStory == cd.StageSkipStory.SkipAfterFirstTime then
    local stageEntered = ClientDataUtils.GetData(cd.ClientDataMainKey.StageEntered, self.model.stageId)
    if stageEntered then
      AvgStoryManager.Instance:SetSkipPlot(self.model.stageId)
    end
    enterDup()
  elseif self:IsCanSkipPlot() then
    local data = {}
    
    function data.cancelFunc()
      AvgStoryManager.Instance:SetSkipPlot(self.model.stageId)
      enterDup()
    end
    
    function data.confirmFunc()
      AvgStoryManager.Instance:ClearSkipPlot()
      enterDup()
    end
    
    function data.leftBtnTypeFunc()
      return CommonDefine.BtnType.High
    end
    
    Alert.ShowEx(20101, data)
  else
    enterDup()
  end
end

function DBGTeamBuildMainPanel:ClearStaleStageEnteredClientData()
  local subTable = ClientDataUtils.GetSubTable(cd.ClientDataMainKey.StageEntered)
  if not subTable or next(subTable) == nil then
    return
  end
  local toRemove = {}
  for subKey in pairs(subTable) do
    if "" == subKey then
    else
      local stageId = tonumber(subKey)
      local stageCfg = stageId and DT.Stage[stageId]
      if not stageCfg or stageCfg.AutoSkipStory ~= cd.StageSkipStory.SkipAfterFirstTime then
        tableInsert(toRemove, subKey)
      end
    end
  end
  if #toRemove > 0 then
    ClientDataUtils.DelSubKeys(cd.ClientDataMainKey.StageEntered, toRemove, true)
  end
end

function DBGTeamBuildMainPanel:QuickBuildTeam()
  self.model:SetSingleChooseSpecialAwakerMode(false)
  self.model:EnableQuickBuildPanel(true)
  self.model:SetPage(CommonDefine.DBGTeamBuildPage.QuickChoose)
  self.model:SetShowAwakerInSertAnim(true)
  NewbieGuideManager.Instance:RegisterNewbiePanel("GuidePanel_QuickTeamBuild", self, Urls.DBGTeamBuildMainPanel)
end

function DBGTeamBuildMainPanel:ShowTeamListPanel()
  if eStageTeamMode.Special == self.data.teamMode then
    return
  end
  local lastTeamList = table.clone(self.model:GetTeamDataByIdx(self.model.curTeamIndex).awakerTidList)
  if self.model.fightAwakerNum == self.model.MaxBattleNum or 0 == self.model.fightAwakerNum then
    self.model:UpdateAwakerTeamInfoWithCurData(self.model.curTeamIndex)
  end
  
  local function saveFunc()
    UIManager.Instance:Reopen(Urls.DBGTeamListAwakerPanel, self.model)
    if self.model.fightAwakerNum ~= self.model.MaxBattleNum and 0 ~= self.model.fightAwakerNum then
      self.model:SetTeamAwakerTids(lastTeamList)
    end
  end
  
  Logger.ReportApusInfo("DBGTeam SaveTeamToServer ShowTeamListPanel ")
  self.model:SaveTeamToServer(saveFunc)
end

function DBGTeamBuildMainPanel:CanStartChallenge()
  if self.model:IsForceAssistStage() and not self.model:GetAssistAwaker() then
    return false
  end
  if self.model:GetKeeperSkillFightedStageGroupId() then
    return false
  end
  if self.model:CheckCurWeaponGroupIsFighted() then
    return false
  end
  if not self.model:IsDisableKeepSkill() and 0 == self.model:GetDisplayKeeperSkillItem() then
    return false
  end
  if self.model.fightAwakerNum < self.model.MaxBattleNum or self:HaveForbiddenAwaker() then
    return false
  end
  local schoolList = self.model:GetTeamSchoolList()
  if #schoolList > 2 then
    return false
  end
  if not self.model:IsTeamMeetSchoolLimit() then
    return false
  end
  local needFightAwakerTid = TeamAssignDataUtils.GetIsOwnedAwakerTid(self.model.stageCfg.SpecialTeamIndex)
  if needFightAwakerTid and not table.contains(self.model.teamAwakerTids, needFightAwakerTid) then
    return false
  end
  local awakerNames = self:_GetAwakersEquippedWithUselessWeapon(self.model.teamAwakerTids)
  if #awakerNames > 0 and self.model:IsAbyssChallenge() then
    return false
  end
  if self.model:IsBanUnitByStageType() then
    return false
  end
  return true
end

function DBGTeamBuildMainPanel:HaveForbiddenAwaker()
  for idx, tid in pairs(self.model.teamAwakerTids) do
    if self.model:IsAbyssChallenge() and idx == self.model.MaxBattleNum and self.model:GetAssistUid() ~= nil then
      return table.contains(self.model:GetFightedAssistAwakerTids(), tid)
    elseif 0 ~= tid and self.model:IsForbidden(tid) then
      return true
    end
  end
  return false
end

function DBGTeamBuildMainPanel:InitAnimation()
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
end

function DBGTeamBuildMainPanel:PlayAnim(clipsString, func)
  local clipsToPlay = ""
  Logger.Debug("DBGTeamBuildMainPanel PlayAnim: ", clipsString)
  self.uiAnimController:PlayMultiState(AddClipToPlay(clipsToPlay, clipsString), func)
end

function DBGTeamBuildMainPanel:OnBindFightingAwakers(binder)
  local maxNum = CommonDefine.TeamAssign.MaxBattleNum
  for nSlot = 1, maxNum do
    local gameObj = self.ui["Awaker_" .. nSlot]
    self.binder:BindComponent(DBGTeamFightAwakerItem(gameObj, nSlot, self.model))
  end
end

function DBGTeamBuildMainPanel:OnBindManageEntry(binder)
  binder:BindToVisible(self.ui.Btn_Page_Turn, function()
    do return self.model.CheckIsNormalTeam end
    return self.model.CheckIsNormalTeam, self.model
  end)
  binder:BindButtonClick(self.ui.Btn_Page_Turn, function()
    UIManager.Instance:Reopen(Urls.DBGTeamManagePanel, self.model)
  end)
end

function DBGTeamBuildMainPanel:OnBindSpecialTeamTips(binder)
end

function DBGTeamBuildMainPanel.IsSettingOpen(settingUniqueName)
  do return SettingManager.Instance.GetBoolSettingData, SettingManager.Instance end
  return SettingManager.Instance.GetBoolSettingData, SettingManager.Instance, settingUniqueName
end

function DBGTeamBuildMainPanel:AssistBattle()
  if self.model:IsAbyssChallenge() and 0 == self.model:GetCanAssistCount() then
    Alert.Show(10743)
    return
  end
  if self.model:GetAssistUid() then
    self.model:SetAssistData(nil)
  else
    SocialDataUtils.OpenBattleAssistPanel(self.model)
  end
end

function DBGTeamBuildMainPanel:OnUnbind()
  GlobalDispatcher:RemoveListener(NotifyId.OnAssistAwakerChanged, self._RefreshActivityBonusCard, self)
  GlobalDispatcher:RemoveListener(NotifyId.OnAwakerPotentiaUpgrade, self._RefreshActivityBonusCard, self)
  GlobalDispatcher:RemoveListener(NotifyId.OnTeamCacheRefreshed, self._OnTeamCacheRefreshed, self)
  ItemDataUtils.CloseHandleMockDataLock(Urls.DBGTeamBuildMainPanel)
  AwakerDataUtils.CloseHandleMockDataLock(Urls.DBGTeamBuildMainPanel)
  AwakerDataUtils.ResetMockAwakerMap()
  ItemDataUtils.ResetMockItemData()
end

function DBGTeamBuildMainPanel:OnCloseActively()
  if self.data.sweepModel then
    local sendIdx = 0
    if self.model.teamType == CommonDefine.TeamType.Normal then
      sendIdx = self.model.curTeamIndex
    end
    local awakerList = {}
    for _, awakerTid in pairs(self.model.teamAwakerTids) do
      tableInsert(awakerList, awakerTid)
    end
    self.data.sweepModel:SetTeamId(sendIdx)
    self.data.sweepModel:SetShowAwakerGroup(awakerList)
  end
  Logger.ReportApusInfo("DBGTeam SaveTeamToServer OnCloseActively ")
  self.model:SaveTeamToServer(System.fn(self, self.Close))
end

function DBGTeamBuildMainPanel:Close()
  Logger.ReportApusInfo("DBGTeam ExitView")
  Super.Close(self)
end

return DBGTeamBuildMainPanel
