local ActivityChallengePanel, Super = System.NewClass("ActivityChallengePanel", UIBasePanel)
ActivityChallengePanel.uiResCls = UI_Event_Panel_ChallengeResource

function ActivityChallengePanel:ctor(stageGroupId, activityTid, gotoStageId, extraData)
  Super.ctor(self)
  self.featureId = ""
  self.activityTid = activityTid
  self.activityType = ActivityDataUtils.GetType(self.activityTid)
  self.stageGroupId = stageGroupId
  self.gotoStageId = gotoStageId
  self.extraData = extraData or {}
end

function ActivityChallengePanel:OnBind(binder)
  self.binder = binder
  local model = binder:createModel(CommonStageModel, self.stageGroupId, self.featureId)
  self.model = model
  binder:BindToText(self.ui.Text_C_Title, function()
    do return model.GetTitle end
    return model.GetTitle, model
  end)
  binder:SetImageSync(self.ui.Image_Bg, self:_GetImageBg())
  self:BindInitRelic()
  self:BindStageRelicList()
  self:BindResonanceGroup(self.resonanceGroupId)
  self:JumpToStage(self.gotoStageId)
  binder:BindToCircularListView(self.ui.ScrollView_TaskCon, System.fn(self, self.GetCfgStageList), function(childBinder, item, index)
    self:BindStageTab(childBinder, item, index)
  end)
  binder:BindToRaw(function(childBinder, stageId, _)
    self:BindStageInfo(childBinder, stageId)
    self:BindRequireSchool(stageId)
  end, function()
    return model.selectedStageId
  end)
  self:BindCoinList()
  self.closeBtn = binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    self:Close()
  end))
  self:_BindMonsterLeader()
  self.binder:BindEvent(EventMgr.Instance.UpdateActivityDupInfo, System.fn(self, self.UpdateSelect))
  binder:BindToVisible(self.ui.UI_Common_Melt_Disaster, System.fn(self, self._IsInitialStateTipsVisible))
  binder:BindComponent(StageInitialStateBtnItem(self.ui.UI_Common_Melt_Disaster, function()
    return self.model.selectedStageId
  end, System.fn(self, self._OnClickInitStateClick)))
  binder:BindToText(self.ui.Text_Suppress, function()
    local nameSuppress = LT.Text(StageInitialStateModel.Instance:GetStageInitStateText(self.model.selectedStageId))
    do return LT.Textf, "DisasterReliefKuroshioEntryNameFormat", (LT.Text("DisasterReliefKuroshio")) end
    return LT.Textf, "DisasterReliefKuroshioEntryNameFormat", LT.Text("DisasterReliefKuroshio"), nameSuppress
  end)
  binder:BindToRaw(function(_, _, _)
    self:SetProgress()
  end, function()
    do return self.GetProgress end
    return self.GetProgress, self
  end)
  self:BindChallengeCount()
  self:BindReplayRecordBtn(binder)
end

function ActivityChallengePanel:BindReplayRecordBtn(binder)
  self.ui.Btn_Replay:SetActive(true)
  binder:BindButtonClick(self.ui.Btn_Replay, function()
    local stageTid = self.model.selectedStageId
    CopyRecordsController.Instance:OpenCopyRecordsView(stageTid)
  end)
end

function ActivityChallengePanel:BindChallengeCount()
  if not self.ui.Text_ChallengeCount then
    return
  end
  self.binder:BindToText(self.ui.Text_ChallengeCount, function()
    local winCount, limitCount = CopyDataUtils.GetStageGroupDailyWinCount(self.stageGroupId)
    if 0 ~= limitCount then
      local countText = string.format("%d/%d", winCount, limitCount)
      if limitCount <= winCount then
        do return LT.Textf, "DeepSeaInvasionDefensiveActiviityTips8", string.color(countText, "#FF0000") end
        return LT.Textf, "DeepSeaInvasionDefensiveActiviityTips8", string.color(countText, "#FF0000")
      else
        do return LT.Textf, "DeepSeaInvasionDefensiveActiviityTips8" end
        return LT.Textf, "DeepSeaInvasionDefensiveActiviityTips8", countText, string.color(countText, "#FF0000")
      end
    end
  end)
  self.binder:BindToTextColorOld(self.ui.Text_ChallengeCount, function()
    if self:IsMaxChallengeCount() then
      do return ColorUtils.GetColorHexCode, "UXWarning" end
      return ColorUtils.GetColorHexCode, "UXWarning", cd.ColorType.Dark
    end
  end)
end

function ActivityChallengePanel:IsMaxChallengeCount()
  local winCount, limitCount = CopyDataUtils.GetStageGroupDailyWinCount(self.stageGroupId)
  return 0 ~= limitCount and limitCount <= winCount
end

function ActivityChallengePanel:_HasSelectedMissionRewards()
  local rewards = self.model and self.model.selectedRewards
  return nil ~= rewards and #rewards > 0
end

function ActivityChallengePanel:_IsInitialStateTipsVisible()
  local stageTid = self.model.selectedStageId
  do return StageInitialStateModel.Instance.ExistsInitialState, StageInitialStateModel.Instance end
  return StageInitialStateModel.Instance.ExistsInitialState, StageInitialStateModel.Instance, stageTid
end

function ActivityChallengePanel:GetProgress()
  if not self.extraData.taskId then
    return
  end
  local taskData = self.extraData.taskId and TaskDataUtils.GetTaskData(self.extraData.taskId)
  local curCount = taskData and taskData.count or 0
  local totalCount = 0
  local taskCfg = TaskDataUtils.GetTaskConfigByTid(self.extraData.taskId)
  if taskCfg and taskCfg.CompleteCondPara and taskCfg.CompleteCondPara[1] then
    totalCount = taskCfg.CompleteCondPara[1]
  end
  return totalCount - curCount, totalCount
end

function ActivityChallengePanel:SetProgress()
  local curCount, totalCount = self:GetProgress()
  if not curCount or not totalCount then
    self.binder:SetActive(self.ui.Group_RemainNum, false)
    return
  end
  self.binder:SetActive(self.ui.Group_RemainNum, true)
  self.binder:SetText(self.ui.Text_CurNum, curCount)
  self.binder:SetText(self.ui.Text_TotalNum, "/" .. totalCount)
end

function ActivityChallengePanel:_OnClickInitStateClick()
  local stageTid = self.model.selectedStageId
  UIManager.Instance:Reopen(Urls.StageInitialStateDetailView, stageTid)
end

function ActivityChallengePanel:GetCfgStageList()
  do return CopyDataUtils.GetCfgStageList end
  return CopyDataUtils.GetCfgStageList, self.stageGroupId
end

function ActivityChallengePanel:GetCfgStageByIndex(index)
  local stageCfgList = self:GetCfgStageList()
  return stageCfgList[index]
end

function ActivityChallengePanel:GetCfgStageIndexByStageId(stageId)
  if not stageId then
    return
  end
  for index, stageCfg in ipairs(self:GetCfgStageList()) do
    if stageCfg.ID == stageId then
      return index
    end
  end
end

function ActivityChallengePanel:JumpToStage(gotoStageId)
  local model = self.model
  if gotoStageId then
    self.model:SetSelectedStageId(gotoStageId)
  end
  self:SetRendered(false)
  local isGoToIndex = true
  self.binder:BindToRaw(function(_, index)
    if isGoToIndex and index then
      isGoToIndex = false
      self.binder:BindTimer(0.01, 0, nil, function()
        self.binder:CircularScrollTo(self.ui.ScrollView_TaskCon, index)
        self.binder:BindTimer(0.05, 0, nil, function()
          self:SetRendered(true)
        end)
      end)
    end
  end, function()
    do return self.GetCfgStageIndexByStageId, self end
    return self.GetCfgStageIndexByStageId, self, model.selectedStageId
  end)
end

function ActivityChallengePanel:BindStageTab(childBinder, item, index)
  local model = self.model
  local stageCfg = self:GetCfgStageByIndex(index)
  if not stageCfg then
    return
  end
  local stageId = stageCfg.ID
  local itemUI = UI_Event_Challenge_ItemResource(item)
  childBinder:BindToText(itemUI.Text_Desc, function()
    do return model.GetStageName, model end
    return model.GetStageName, model, stageId
  end)
  childBinder:BindZ1Button(itemUI.uiNode, function()
    model:SetSelectedStageId(stageId)
  end)
  childBinder:BindToVisible(itemUI.Image_Select, function()
    return stageId == model.selectedStageId
  end)
  childBinder:BindToRaw(function(targetChildBinder)
    local isOpened = CopyDataUtils.CheckStageIsInOpenTime(stageId)
    local isUnlocked = CopyDataUtils.GetStageUnlockedByUnlockCondition(stageId, self.activityTid)
    itemUI.Image_Mask:SetActive(not isOpened or not isUnlocked)
    local timerId
    if isOpened and isUnlocked then
      targetChildBinder:SetText(itemUI.Text_Tip, model:RecommendLvCall(stageCfg.StageLevel))
    elseif isOpened and not isUnlocked then
      local taskTid = stageCfg.UnlockCondition[1]
      targetChildBinder:SetText(itemUI.Text_Tip, LT.Textf("StageCopyUnlockDescFomat", TaskDataUtils.GetConfigByField("Desc", taskTid) or ""))
    else
      local _leftTime = CopyDataUtils.GetStageOpenCountDown(stageId)
      targetChildBinder:SetText(itemUI.Text_Tip, TimeUtils.UnlockedCountDownFormat(_leftTime))
      timerId = targetChildBinder:BindTimer(1, -1, function()
        local leftTime = CopyDataUtils.GetStageOpenCountDown(stageId)
        if leftTime <= 0 then
          targetChildBinder:StopTimer(timerId)
          timerId = nil
          targetChildBinder:SetText(itemUI.Text_Tip, model:RecommendLvCall(stageCfg.StageLevel))
          return
        end
        targetChildBinder:SetText(itemUI.Text_Tip, TimeUtils.UnlockedCountDownFormat(leftTime))
      end)
    end
    targetChildBinder:onDestroy(function()
      if timerId then
        targetChildBinder:StopTimer(timerId)
        timerId = nil
      end
    end)
  end, function()
    do return CopyDataUtils.CheckStageIsInOpenTime end
    return CopyDataUtils.CheckStageIsInOpenTime, stageId
  end)
  childBinder:BindToVisible(itemUI.Image_Finish, function()
    local _ = self.model.stageInfoVer
    local stageInfo = CopyDataUtils.GetStageInfo(self.stageGroupId)
    if not stageInfo or not stageInfo.curPassStageTid then
      return false
    end
    return stageInfo.curPassStageTid == stageId
  end)
  childBinder:BindToVisible(itemUI.Image_Madness, function()
    return stageCfg.DailyChallengeMadnessDifficulty and 1 == stageCfg.DailyChallengeMadnessDifficulty or false
  end)
end

function ActivityChallengePanel:BindStageInfo(childBinder, stageId)
  local isNeedBind = nil ~= stageId
  if not isNeedBind then
    return
  end
  childBinder:BindComponent(CopyChapterVueComp(self.ui.UI_Common_Btn_StageChapter, stageId))
  local model = self.model
  childBinder:SetText(self.ui.Text_Title, model:GetSelectedStageName())
  childBinder:SetText(self.ui.Text_Desc, model:GetSelectedStageDesc())
  StrUtils.SetPreferredHeight(self.ui.Text_Desc)
  childBinder:SetText(self.ui.Text_Cost, model:GetSelectedCost())
  childBinder:SetActive(self.ui.Text_Cost, (model:GetSelectedCost() or 0) > 0)
  childBinder:SetText(self.ui.Text_Consume, model:GetSelectedSecondModeCost())
  childBinder:BindToImage(self.ui.Image_Item, function()
    do return model.GetCostIcon end
    return model.GetCostIcon, model
  end, false)
  childBinder:BindToImage(self.ui.Image_Consume, function()
    do return model.GetCostIcon end
    return model.GetCostIcon, model
  end, false)
  childBinder:BindZ1Button(self.ui.Btn_Challenge, System.fn(self, self.OnBtnChallenge), function()
    if not CopyDataUtils.CheckStageIsInOpenTime(model.selectedStageId) or not CopyDataUtils.GetStageUnlockedByUnlockCondition(model.selectedStageId, self.activityTid) then
      return CommonDefine.BtnType.Unclickable
    end
    local winCount, limitCount = CopyDataUtils.GetStageGroupDailyWinCount(self.stageGroupId)
    if 0 ~= limitCount and winCount and limitCount and limitCount <= winCount then
      return CommonDefine.BtnType.Unclickable
    end
    do return model.GetChallengeBtnState end
    return model.GetChallengeBtnState, model
  end, function()
    do return LT.Text end
    return LT.Text, "DailyCopy_Start"
  end)
  local isDoubleFight = self.model:GetIsDoubleFight()
  self.ui.Btn_Double:SetActive(isDoubleFight)
  childBinder:BindZ1Button(self.ui.Btn_Double, System.fn(self, self.OnBtnDouble), function()
    do return model.GetChallengeBtnState end
    return model.GetChallengeBtnState, model
  end)
  local isShowSweep = self.model:GetIsShowSweep()
  self.layoutGroup = self.ui.Group_Btn:GetComponent(typeof(CS.UnityEngine.UI.HorizontalLayoutGroup))
  self.ui.Btn_Sweep:SetActive(isShowSweep)
  if isDoubleFight and isShowSweep then
    self.layoutGroup.spacing = 10
    self.ui.Group_Challenge_State.transform.localScale = CS.UnityEngine.Vector3(0.9, 0.9, 0.9)
    self.ui.Group_Double_State.transform.localScale = CS.UnityEngine.Vector3(0.9, 0.9, 0.9)
    self.ui.Group_Sweep_State.transform.localScale = CS.UnityEngine.Vector3(0.9, 0.9, 0.9)
  else
    self.layoutGroup.spacing = 56
    self.ui.Group_Challenge_State.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
    self.ui.Group_Double_State.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
    self.ui.Group_Sweep_State.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
  end
  childBinder:BindZ1Button(self.ui.Btn_Sweep, System.fn(self, self.OnBtnSweep), function()
    return self.model:GetIsCanSweep(self.activityTid) and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable
  end, function()
    do return LT.Text end
    return LT.Text, "CopySweepBtnText"
  end)
  if self.model:GetIsCanSweep(self.activityTid) then
    self.ui.Btn_Sweep.transform:SetAsLastSibling()
  else
    self.ui.Btn_Sweep.transform:SetAsFirstSibling()
  end
  childBinder:BindToVisible(self.ui.Image_RewardTitle, System.fn(self, self._HasSelectedMissionRewards))
  childBinder:BindToVisible(self.ui.ScrollView_RewardCon, System.fn(self, self._HasSelectedMissionRewards))
  childBinder:BindToCircularListView(self.ui.ScrollView_RewardCon, function()
    return model.selectedRewards
  end, function(itemBinder, item, index)
    local itemInfo = model.selectedRewards[index]
    local itemCount
    itemCount = itemInfo.num
    local itemAwardTypeDescMap = CommonDefine.ItemAwardType2TagMap()
    local hasTag = itemInfo.type and itemInfo.type ~= CommonDefine.ItemAwardType.Normal
    local itemData = {
      itemTid = itemInfo.tid,
      itemCount = itemCount,
      isGot = itemInfo.isGot == true,
      extraDesc = hasTag and itemAwardTypeDescMap[itemInfo.type] or nil,
      extraDescBgType = hasTag and CommonDefine.CommonIconExtraDescBgType.Blue or nil
    }
    itemBinder:BindComponent(CommonIconItemType2(item, itemData))
  end)
  childBinder:BindToRaw(function(_, hasRelic)
    if hasRelic then
      local sizeDelta = self.ui.ScrollView_Desc.transform.sizeDelta
      sizeDelta.y = hasRelic and 142 or 162
      self.ui.ScrollView_Desc.transform.sizeDelta = sizeDelta
    end
  end, function()
    local targetStageTid = self.model.selectedStageId or 0
    local stageCfg = DT.Stage[targetStageTid]
    return stageCfg and stageCfg.InitRelic or false
  end)
end

function ActivityChallengePanel:BindRequireSchool(stageId)
  local schoolLimits = CopyDataUtils.GetAwakerRequirementMap(stageId)
  if not schoolLimits or not table.next(schoolLimits) then
    self.binder:SetActive(self.ui.Group_Career, false)
    return
  end
  self.binder:SetActive(self.ui.Text_Cost, false)
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

function ActivityChallengePanel:OnBtnChallenge()
  local model = self.model
  if not model:CheckCanChallengeAndShowTips() then
    return
  end
  if self:IsMaxChallengeCount() then
    Alert.Show(20170)
    return
  end
  local curCount = self:GetProgress()
  if curCount and curCount <= 0 then
    local stageGroupCfg = CopyDataUtils.GetStageGroupConfig(self.stageGroupId)
    if stageGroupCfg and stageGroupCfg.Type == CommonDefine.StageGroupType.OceanBoss then
      Alert.ShowStr(LT.Text("DeepSeaInvasionDefensiveActiviityTips14"))
      return
    end
    Alert.ShowStr(LT.Text("AlertBossKilled"))
    return
  end
  local selectedStageId = model.selectedStageId
  if not CopyDataUtils.CheckStageIsInOpenTime(selectedStageId) then
    local leftTime = CopyDataUtils.GetStageOpenCountDown(selectedStageId)
    Alert.ShowStr(TimeUtils.UnlockedCountDownFormat(leftTime))
    return
  end
  local stageCfg = model:GetStageCfg(selectedStageId)
  if not CopyDataUtils.GetStageUnlockedByUnlockCondition(selectedStageId, self.activityTid) then
    Alert.ShowStr(LT.Textf("StageCopyUnlockDescFomat", TaskDataUtils.GetConfigByField("Desc", stageCfg.UnlockCondition[1])) or "")
    return
  end
  local cost = model:GetSelectedCost()
  if not model:CheckTicketCostItemEnough(cost) then
    return
  end
  WorldStageManager.Instance:CheckOpen(selectedStageId, function()
    StageExitPanelManager.Instance:PushWhenActivityChallengeExit(selectedStageId)
  end, model:GetTalents())
end

function ActivityChallengePanel:OnBtnDouble()
  local model = self.model
  if not model:CheckCanChallengeAndShowTips() then
    return
  end
  local cost = model:GetSelectedSecondModeCost()
  if not model:CheckTicketCostItemEnough(cost) then
    return
  end
  local selectedStageId = model.selectedStageId
  WorldStageManager.Instance:CheckOpen(selectedStageId, function()
    StageExitPanelManager.Instance:PushWhenActivityChallengeExit(selectedStageId)
  end, model:GetTalents(), nil, {
    specialMode = CommonDefine.StageSpecialMode.SecondMode
  })
end

function ActivityChallengePanel:OnBtnSweep()
  local model = self.model
  CopyDataUtils.OpenSweepPanel(model.selectedStageId, self.activityTid)
end

function ActivityChallengePanel:UpdateSelect()
  self.model:UpdateSelectedRewards()
end

function ActivityChallengePanel:_BindMonsterLeader()
  self.binder:BindToRaw(function(childBinder, stageTid)
    local monsterList = CopyDataUtils.GetStageMonsterBossTidList(stageTid)
    local existedBoss = #monsterList > 0
    self.ui.Image_Leader:SetActive(existedBoss)
    self.ui.ScrollView_Leader:SetActive(existedBoss)
    if existedBoss then
      self:_RefreshMonsterLeadersView(monsterList, childBinder)
    end
    self:BindMonsterTip(stageTid)
  end, function()
    return self.model.selectedStageId
  end)
  self.binder:BindToRaw(function(childBinder, monsterTid)
    if 0 == monsterTid then
      self.ui.Btn_Mask:SetActive(false)
      self.ui.UI_Chapter_Popup_Blame_Tip:SetActive(false)
      return
    end
    self.ui.Btn_Mask:SetActive(true)
    self.ui.UI_Chapter_Popup_Blame_Tip:SetActive(true)
  end, function()
    return self.model.currMonsterTid
  end)
  self.binder:BindButtonClick(self.ui.Btn_Mask, function()
    self.model:SetMonsterTid(0)
  end)
end

function ActivityChallengePanel:_RefreshMonsterLeadersView(monsterList, childBinder)
  local cnt = #monsterList
  local transform = self.ui.LeaderViewContent.transform
  local childCount = transform.childCount
  while cnt > childCount do
    Instantiate(transform:GetChild(0).gameObject, transform)
    childCount = childCount + 1
  end
  local stageTid = self.model.selectedStageId
  for i = 1, cnt do
    local go = transform:GetChild(i - 1).gameObject
    go:SetActive(true)
    local monsterTid = monsterList[i]
    
    local function OnMonsterItemClick()
      self.model:SetMonsterTid(monsterTid)
      if self.monsterTipItem then
        self.monsterTipItem:SetMonsterTid(monsterTid)
      end
    end
    
    local function IsSelectFunc()
      return monsterTid == self.model.currMonsterTid
    end
    
    local monsterItem = childBinder:BindUIBehavior(go, stageTid, monsterTid, OnMonsterItemClick)
    childBinder:BindToVisible(monsterItem.ui.Image_Select, IsSelectFunc)
  end
  for i = cnt + 1, childCount do
    local go = transform:GetChild(i - 1).gameObject
    go:SetActive(false)
  end
end

function ActivityChallengePanel:BindMonsterTip(stageTid)
  self:_UnbindMonsterItem()
  self.monsterTipItem = self.binder:BindComponent(MainCopyMonsterDetailItem(self.ui.UI_Chapter_Popup_Blame_Tip, stageTid, self.model.currMonsterTid))
end

function ActivityChallengePanel:_UnbindMonsterItem()
  if self.monsterTipItem then
    self.monsterTipItem:OnUnbind()
    self.monsterTipItem = nil
  end
end

function ActivityChallengePanel:OnUnbind()
  self:_UnbindMonsterItem()
  Super.OnUnbind(self)
end

function ActivityChallengePanel:BindResonanceGroup()
  self.binder:BindToVisible(self.ui.Btn_Resonance, function()
    return self.model:GetTalentGroup() ~= nil
  end)
  if not self.model:GetTalentGroup() then
    return
  end
  self.binder:BindComponent(ResonanceGroupComp(self.model:GetTalentGroup(), self.ui.Btn_Resonance, nil, self.ui.Text_Progress, self.ui.Red_Resonance, self.activityTid, self, true))
end

function ActivityChallengePanel:BindCoinList()
  if self.activityType == ActivityDefine.ActivityType.TwoAndAHalfAnniversaryRAIDActiviity then
    self.binder:SetActive(self.ui.UI_Common_Item_Coin_Group, false)
    return
  end
  local currencyListKey = string.format("ChallengeCurrencies_%s", self.activityType)
  local coinList = DT.GetOriginalConstant(currencyListKey)
  coinList = coinList or DT.GetOriginalConstant("EnergyItemTid", {})
  if self.activityType == ActivityDefine.ActivityType.TwoAnniversaryWorldBossActivity then
    coinList = {}
  end
  self.binder:BindComponent(CommonCurrencyGroupItem(self.ui.UI_Common_Item_Coin_Group, coinList))
end

function ActivityChallengePanel:BindInitRelic()
  self.binder:BindToVisible(self.ui.Creation, function()
    local stageId = self.model.selectedStageId or 0
    local stageCfg = DT.Stage[stageId]
    return stageCfg and stageCfg.InitRelic
  end)
  self.binder:BindToRaw(function(cbinder, relicList)
    local itemCount = self.ui.Item_Creation.transform.childCount
    for i = 1, itemCount do
      local tid = relicList[i]
      local childgo = self.ui.Item_Creation.transform:GetChild(i - 1).gameObject
      childgo:SetActive(nil ~= tid)
      if tid then
        local itemData = {
          tid = tid,
          onClick = function()
            self:ShowRelicTips(tid, childgo)
          end,
          isRelic = true,
          hideGroupDown = true,
          hideBg = true
        }
        cbinder:SetIcon(MaterialIconType.CommonIcon_Obsolete, childgo, itemData)
      end
    end
  end, function()
    local stageId = self.model.selectedStageId or 0
    local stageCfg = DT.Stage[stageId]
    return stageCfg and stageCfg.InitRelic or {}
  end)
end

function ActivityChallengePanel:ShowRelicTips(tid, relicGo)
  local tipRoot = UIManager.GetTipPopRoot()
  local item = self.binder:BindNewComponent(tipRoot, RelicClickTips, UI_Common_Popup_Tips_6Resource, nil, Vue.ref({relicTid = tid}), {
    stageId = self.stageId
  })
  item:SetItemPos2(relicGo.transform.position)
end

function ActivityChallengePanel:BindStageRelicList()
  self.binder:BindToVisible(self.ui.Btn_Creation, function()
    local stageId = self.model.selectedStageId or 0
    return not CopyDataUtils.IsOneBattleStage(stageId)
  end)
  self.binder:BindButtonClick(self.ui.Btn_Creation, function()
    if self.model.selectedStageId then
      UIManager.Instance:Reopen(Urls.MainCopyRelicGroupPanel, self.model.selectedStageId)
    end
  end)
end

function ActivityChallengePanel:_GetImageBg()
  local stageGroupConfig = CopyDataUtils.GetStageGroupConfig(self.stageGroupId)
  if not stageGroupConfig or not stageGroupConfig.Backgrand then
    Logger.Error("当前关卡组未配置背景图资源路径！！")
  end
  return stageGroupConfig and stageGroupConfig.Backgrand
end

return ActivityChallengePanel
