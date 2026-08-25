local MapAndBattleSettingGroup, Super = System.NewComponent("MapAndBattleSettingGroup")

function MapAndBattleSettingGroup:ctor(uiNode, stageId, stageGroupId, isInWorldStage)
  Super.ctor(self)
  self.stageId = stageId
  self.stageGroupId = stageGroupId or 0
  self.ui = UI_Common_BattleAndMapSet_BgResource(uiNode)
  self.settingVisible = Vue.ref(false)
  self.isInWorldStage = isInWorldStage
end

function MapAndBattleSettingGroup:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    if self.settingVisible.value then
      self.settingVisible.value = false
    end
  end)
  binder:BindToVisible(self.ui.uiNode, function()
    return self.settingVisible.value
  end)
  binder:BindToVisible(self.ui.Btn_Survey_Evaluation, System.fn(self, self.IsShowSurveyEvaluation))
  binder:BindToVisible(self.ui.Btn_Tutorial, System.fn(self, self.IsShowTutorial))
  binder:BindToVisible(self.ui.Btn_Achievement_Reward, System.fn(self, self.IsShowAchievementReward))
  binder:BindZ1Button(self.ui.Btn_Survey_Evaluation, System.fn(self, self.OnBtnStageThreeStar), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "MainLines_ThreeStarConditionTips"
  end)
  binder:BindZ1Button(self.ui.Btn_Achievement_Reward, System.fn(self, self.OnBtnAchievementReward), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "AchievementRewards"
  end)
  binder:BindZ1Button(self.ui.Btn_Tutorial, System.fn(self, self.OnBtnTutorial), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "TutorialTitle"
  end)
  binder:BindZ1Button(self.ui.Btn_ReStart_Battle, System.fn(self, self.OnRestartBattle), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "FightAgain"
  end)
  binder:BindToVisible(self.ui.Btn_ReStart_Battle, function()
    if bg.isReplay then
      return false
    end
    return not self.isInWorldStage
  end)
  binder:BindZ1Button(self.ui.Btn_Exit_Survey, System.fn(self, self.OnExitSurvey), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "ExitInvestigation"
  end)
  binder:BindZ1Button(self.ui.Btn_Setting, System.fn(self, self.OnBtnSetting), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "setUp"
  end)
  self.ui.Btn_Setting:SetActive(not bg.isReplay)
  self:_OnBindDailyRuleBtn()
  self:_OnBindSaveAndExitBtn()
end

function MapAndBattleSettingGroup:IsShowSurveyEvaluation()
  if self.isInWorldStage then
    return false
  end
  if bg.isReplay then
    return false
  end
  if 0 == self.stageId then
    return false
  end
  local config = DT.Stage[self.stageId]
  return config.PerfectCondition and table.next(config.PerfectCondition) ~= nil
end

function MapAndBattleSettingGroup:IsShowTutorial()
  if bg.isReplay then
    return false
  end
  local _, unlock = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Tutorial, 0)
  return unlock
end

function MapAndBattleSettingGroup:IsShowAchievementReward()
  if self.isInWorldStage then
    return false
  end
  if bg.isReplay then
    return false
  end
  if 0 == self.stageId then
    return false
  end
  local awakerTid = FreeTrialController.Instance:GetAwakerByStageId(self.stageId)
  local isAwakerTrialStage = awakerTid and awakerTid > 0
  if isAwakerTrialStage then
    return false
  end
  local config = DT.Stage[self.stageId]
  return config.LevelAchieve ~= nil
end

function MapAndBattleSettingGroup:OnRestartBattle()
  Alert.Show(20109, nil, function()
    BattleBackTrackUtils.RestartBattle()
  end)
  self.settingVisible.value = false
  GuideManager.Instance:ClearBattleTriggeredGuideList()
end

function MapAndBattleSettingGroup:OnExitSurvey()
  if bg.isReplay and bg.replayPlayer then
    bg.replayPlayer:Stop()
    return
  end
  if self.isExiting then
    Logger.Warn("地图副本正在退出中，不要重复退出")
  else
    local stageId = WorldStageManager.Instance:GetCurStageId()
    local tipsId = 20039
    local leastCost = 0
    local desc
    if stageId then
      local stageCfg = DT.Stage[stageId]
      leastCost = stageCfg and stageCfg.WithdrawDeductsStamina or 0
    end
    if 0 ~= leastCost then
      tipsId = 20040
      desc = LT.Textf(DT.TipsType[tipsId].Desc, leastCost)
    end
    Alert.SetMaskClickClose(true)
    Alert.Show(tipsId, nil, function()
      WorldStageManager.Instance:ReqExit(self.stageGroupId, function()
        self.isExiting = true
      end)
    end, nil, desc)
  end
  self.settingVisible.value = false
end

function MapAndBattleSettingGroup:OnBtnStageThreeStar()
  if 0 == self.stageId then
    return
  end
  local stageData = MainCopyDataUtils.GetStageData(self.stageId)
  if stageData then
    UIManager.Instance:Reopen(Urls.StageStarDetailPanel, {
      stageTid = self.stageId,
      star = stageData.star
    })
  else
    UIManager.Instance:Reopen(Urls.StageStarDetailPanel, {
      stageTid = self.stageId,
      star = 0
    })
  end
  self.settingVisible.value = false
end

function MapAndBattleSettingGroup:OnBtnAchievementReward()
  if 0 == self.stageId then
    return
  end
  local cfg = DT.Stage[self.stageId]
  if cfg.LevelAchieve then
    UIManager.Instance:Reopen(Urls.MainCopyAchievePanel, cfg.LevelAchieve, self.stageId, true)
    self.settingVisible.value = false
  end
end

function MapAndBattleSettingGroup:OnBtnTutorial()
  TutorialDataUtils.OpenTutorialMainPanel(nil, true)
  self.settingVisible.value = false
end

function MapAndBattleSettingGroup:OnBtnSetting()
  UIManager.Instance:Reopen(Urls.SettingMainPanel)
  self.settingVisible.value = false
end

function MapAndBattleSettingGroup:_OnBindDailyRuleBtn()
  local binder = self.binder
  binder:BindZ1Button(self.ui.Btn_Daily_Rule, function()
    if 0 == self.stageGroupId then
      return
    end
    TaskDataUtils.ShowDailyChallengeRulePanel(self.stageGroupId)
    self.settingVisible.value = false
  end, function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "DailyChallengeRules"
  end)
  binder:BindToVisible(self.ui.Btn_Daily_Rule, function()
    if bg.isReplay then
      return false
    end
    if 0 == self.stageGroupId then
      return false
    end
    local stageGroupCfg = DT.StageGroup[self.stageGroupId]
    return stageGroupCfg.Type == CommonDefine.StageGroupType.DailyChallenge and stageGroupCfg.IntegralTerm
  end)
end

function MapAndBattleSettingGroup:_OnBindSaveAndExitBtn()
  local binder = self.binder
  binder:BindZ1Button(self.ui.Btn_SaveAndExit, function()
    if bg.isReplay and bg.replayPlayer then
      bg.replayPlayer:Stop()
      return
    end
    if self.isExiting then
      Logger.Warn("地图副本正在退出中，不要重复退出")
    else
      local stageId = WorldStageManager.Instance:GetCurStageId()
      local tipsId = self.isInWorldStage and "RailWaySaveAndExitTips" or "RailWaySaveAndExitInBattleTips"
      local leastCost = 0
      local desc
      if stageId then
        local stageCfg = DT.Stage[stageId]
        leastCost = stageCfg and stageCfg.WithdrawDeductsStamina or 0
      end
      if 0 ~= leastCost then
        tipsId = 20040
        desc = LT.Textf(DT.TipsType[tipsId].Desc, leastCost)
      end
      Alert.SetMaskClickClose(true)
      Alert.Show(tipsId, nil, function()
        WorldStageManager.Instance:ReqSaveAndExit(self.stageGroupId, function()
          self.isExiting = true
        end)
      end, nil, desc)
    end
    self.settingVisible.value = false
  end, function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "RailWaySaveAndExit"
  end)
  binder:BindToVisible(self.ui.Btn_SaveAndExit, function()
    if bg.isReplay then
      return false
    end
    if 0 == self.stageGroupId then
      return false
    end
    local stageGroupCfg = DT.StageGroup[self.stageGroupId]
    return stageGroupCfg.Type == CommonDefine.StageGroupType.RailWay
  end)
end

function MapAndBattleSettingGroup:SwitchVisible()
  self.settingVisible.value = not self.settingVisible.value
  if self.settingVisible.value == true then
    AudioManager.Instance:PostSoundEvent("Play_UI_Exp_SettingMenu_On")
  else
    AudioManager.Instance:PostSoundEvent("Play_UI_Exp_SettingMenu_Off")
  end
end

return MapAndBattleSettingGroup
