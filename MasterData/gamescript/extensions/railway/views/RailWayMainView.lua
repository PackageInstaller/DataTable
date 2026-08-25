local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local AddClipToPlay = AnimatorUtils.AddClipToPlay
local SeasonGameplayType = CommonDefine.SeasonGameplayType
local RailWayStageGroupTid = DT.GetOriginalConstant("RailWayStageGroupTid")
local RailWayMainView, Super = NewClass("RailWayMainView", BaseView)
RailWayMainView.uiResCls = UI_Dungeous_Panel_RailWayResource

function RailWayMainView:ctor()
  Super.ctor(self)
  self:_InitViewData()
end

function RailWayMainView:OnEnterView()
  self.uiAnimController = self.ui.uiNode:GetComponent(T_UIAnimationController)
  self:_RefreshView()
  ResonanceDataUtils.ReqResonanceData(CommonDefine.ResonanceGroupRailway)
  RailWayController.Instance:ReqOnOpenRailWay()
  local isPlayEnterAnim = true
  self:_PlayBgSwitchAnim(isPlayEnterAnim)
  self:_RefreshRankTime()
  self._timer = self:BindTimer(1, -1, function()
    self:_RefreshRankTime()
  end)
end

function RailWayMainView:OnExitView()
  Super.OnExitView(self)
  if self._timer then
    self:StopTimer(self._timer)
    self._timer = nil
  end
end

function RailWayMainView:RegisterEvents()
  self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Rank, System.fn(self, self._OnClickRank))
  self:AddButtonClickListener(self.ui.Btn_Record, System.fn(self, self._OnClickRecord))
  self:AddButtonClickListener(self.ui.Btn_Reward, System.fn(self, self._OnClickReward))
  self:AddButtonClickListener(self.ui.Btn_Resonance, System.fn(self, self._OnClickResonance))
  self:AddButtonClickListener(self.ui.Btn_Challenge, System.fn(self, self._OnClickChallenge))
  self:AddButtonClickListener(self.ui.Btn_Question, System.fn(self, self._OnClickQuestion))
  self:AddButtonClickListener(self.ui.Btn_Question_Normal, System.fn(self, self._OnClickNormalQuestion))
  self:AddButtonClickListener(self.ui.Btn_Question_Hard, System.fn(self, self._OnClickHardQuestion))
  self:AddButtonClickListener(self.ui.Btn_Question_Madness, System.fn(self, self._OnClickMadnessQuestion))
  self:AddZ1ToggleValueChangedListener(self.ui.Toggle_Normal, System.fn(self, self._OnToggleNomalValueChanged))
  self:AddZ1ToggleValueChangedListener(self.ui.Toggle_Hard, System.fn(self, self._OnToggleHardValueChanged))
  self:AddZ1ToggleValueChangedListener(self.ui.Toggle_Madness, System.fn(self, self._OnToggleMadnessValueChanged))
  self:BindEvent(EventMgr.Instance.OnCareerLevelDataChanged, System.fn(self, self._OnCareerLevelDataChanged))
  self:BindEvent(EventMgr.Instance.TaskInfoUpdated, System.fn(self, self._OnTaskInfoUpdated))
  self:BindEvent(EventMgr.Instance.OnRailWayDataChanged, System.fn(self, self._OnRailWayDataChanged))
end

function RailWayMainView:_OnRailWayDataChanged()
  self:_InitDefaultToggle()
  self:_RefreshBtnState()
  self:_RefreshToggleState()
end

function RailWayMainView:_OnCareerLevelDataChanged()
  self:_RefreshCareerLevelProgress()
end

function RailWayMainView:_OnTaskInfoUpdated(taskData)
  local taskType = TaskCfgUtils.GetCfgField("TaskType", taskData.tid)
  if taskType ~= cd.TaskType.TaskType_RailWay then
    return
  end
  self:_RefreshTaskProgress()
end

function RailWayMainView:_OnClickRank()
  RailWayController.Instance:OpenRankView()
end

function RailWayMainView:_OnClickRecord()
  RailWayController.Instance:OpenTaskView()
end

function RailWayMainView:_OnClickReward()
  RailWayController.Instance:OpenCareerLevelView()
end

function RailWayMainView:_OnClickResonance()
  local resonanceGroupId = ResonanceDataUtils.GetReonanceGroupIdByStageGroupId(RailWayStageGroupTid)
  UIManager.Instance:Reopen(Urls.ResonanceMainPanel, {resonanceGroupId = resonanceGroupId, stageGroupTid = RailWayStageGroupTid})
end

function RailWayMainView:_OnClickChallenge()
  if self:_IsAnyRailWayPlaying() and not self:_IsSelectRailWayPlaying() then
    Alert.Show("RailWayHaveSaveStage")
    return
  end
  local railWayMO = RailWayModel.Instance:GetRailWayMOByDifficult(self._selectDifficult)
  local stageTid = railWayMO:GetStageTid()
  
  local function challengeFunc()
    WorldStageManager.Instance:CheckOpen(stageTid, function()
      StageExitPanelManager.Instance:PushWhenRailwayExit(stageTid)
    end, {})
  end
  
  local function recoverFunc()
    StageExitPanelManager.Instance:Clear()
    StageExitPanelManager.Instance:PushStackJump()
    ProtoManager.Instance:ReqServer("GameRequest", "OnWorldRecover", function(data, errcode)
      Logger.Proto("OnWorldRecover: data =", table.tostring(data), table.tostring(errcode))
    end, function()
      UIManager.Instance:Reopen(Urls.MainPanel)
    end, stageTid)
  end
  
  if not self:_IsSelectRailWayPlaying() then
    challengeFunc()
  else
    local stageCfg = StageCfgUtils.GetCfg(stageTid)
    local savedSeasonId = RailWayModel.Instance:GetCurSeasonId()
    local isSeasonSwitched = RailWayDataUtils.IsSeasonSwitched(savedSeasonId)
    local alertKey = isSeasonSwitched and "RailWayContinueSaveStageSeasonSwitchTips" or "RailWayContinueSaveStage"
    local tipsTypeDesc = TipsTypeCfgUtils.GetCfgField("Desc", alertKey)
    local showDesc = LT.Textf(tipsTypeDesc, LT.Text(stageCfg.Name), RailWayModel.Instance:GetCurStage(), RailWayModel.Instance:GetCurBattleNodeIdx(), RailWayModel.Instance:GetCurScore())
    Alert.Show(alertKey, nil, recoverFunc, nil, showDesc)
  end
end

function RailWayMainView:_OnClickQuestion()
  UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text("RailWayRulesTitle"), LT.Text(TaskDataUtils.GetTimeReplaceLanguageKey("RailWayRulesContentV2")))
end

function RailWayMainView:_OnClickNormalQuestion()
  UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text("RuleTipsTitle"), LT.Text("RailWayStageDifficultyBuffContent1"))
end

function RailWayMainView:_OnClickHardQuestion()
  UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text("RuleTipsTitle"), LT.Text("RailWayStageDifficultyBuffContent2"))
end

function RailWayMainView:_OnClickMadnessQuestion()
  UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text("RuleTipsTitle"), LT.Text(TaskDataUtils.GetTimeReplaceLanguageKey("RailWayStageDifficultyBuffContent3V2")))
end

function RailWayMainView:_OnToggleNomalValueChanged(isOn)
  if not isOn then
    return
  end
  self:_SetSelectDifficult(RailWayDefine.RailWayDifficult.Normal)
end

function RailWayMainView:_OnToggleHardValueChanged(isOn)
  if not isOn then
    return
  end
  self:_SetSelectDifficult(RailWayDefine.RailWayDifficult.Hard)
end

function RailWayMainView:_OnToggleMadnessValueChanged(isOn)
  if not isOn then
    return
  end
  self:_SetSelectDifficult(RailWayDefine.RailWayDifficult.Madness)
end

function RailWayMainView:_InitViewData()
  self._selectDifficult = RailWayDefine.RailWayDifficult.Normal
  self._lastSelectDifficult = RailWayDefine.RailWayDifficult.Normal
end

function RailWayMainView:_SetSelectDifficult(difficult)
  self._lastSelectDifficult = self._selectDifficult
  self._selectDifficult = difficult
  self:_PlayBgSwitchAnim()
  self:_RefreshBtnState()
end

function RailWayMainView:_IsAnyRailWayPlaying()
  return 0 ~= RailWayModel.Instance:GetCurStageTid()
end

function RailWayMainView:_IsSelectRailWayPlaying()
  local railWayMO = RailWayModel.Instance:GetRailWayMOByDifficult(self._selectDifficult)
  local stageTid = railWayMO:GetStageTid()
  do return RailWayModel.Instance.IsRailWayPlaying, RailWayModel.Instance end
  return RailWayModel.Instance.IsRailWayPlaying, RailWayModel.Instance, stageTid
end

function RailWayMainView:_RefreshView()
  self:_RefreshSeasonInfo()
  self:_RefreshBtnState()
  self:_RefreshToggleState()
  self:_RefreshTaskProgress()
  self:_RefreshCareerLevelProgress()
  self:_RefreshResonanceProgress()
end

function RailWayMainView:_RefreshSeasonInfo()
  local seasonId = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.ConsciousnessRailway)
  if not seasonId or 0 == seasonId then
    self:SetText(self.ui.Text_Season, "")
    self.binder:SetText(self.ui.Text_Rank_Time, "")
    self.binder:SetActive(self.ui.Icon_Time, false)
    return
  end
  self:_RefreshRankTime()
end

function RailWayMainView:_InitDefaultToggle()
  if not self:_IsAnyRailWayPlaying() then
    self:SetZ1Toggle(self.ui.Toggle_Normal, true)
    return
  end
  for key, difficult in pairs(RailWayDefine.RailWayDifficult) do
    local railWayMO = RailWayModel.Instance:GetRailWayMOByDifficult(difficult)
    local toggle = self.ui["Toggle_" .. key]
    if toggle and RailWayModel.Instance:IsRailWayPlaying(railWayMO:GetStageTid()) then
      self:SetZ1Toggle(toggle, true)
    end
  end
end

function RailWayMainView:_PlayBgSwitchAnim(isPlayEnterAnim)
  if self._lastSelectDifficult == self._selectDifficult then
    return
  end
  local clipsToPlay = ""
  if isPlayEnterAnim then
    clipsToPlay = AddClipToPlay(clipsToPlay, "UI_Dungeous_Panel_RailWay_Open")
  end
  if self._lastSelectDifficult == RailWayDefine.RailWayDifficult.Hard then
    clipsToPlay = AddClipToPlay(clipsToPlay, "UI_Chapter_Panel_Spur_Difficulty_Close")
  elseif self._lastSelectDifficult == RailWayDefine.RailWayDifficult.Madness then
    clipsToPlay = AddClipToPlay(clipsToPlay, "UI_Chapter_Panel_Spur_Nightmare_Close")
  end
  if self._selectDifficult == RailWayDefine.RailWayDifficult.Hard then
    clipsToPlay = AddClipToPlay(clipsToPlay, "UI_Chapter_Panel_Spur_Difficulty_Open")
  elseif self._selectDifficult == RailWayDefine.RailWayDifficult.Madness then
    clipsToPlay = AddClipToPlay(clipsToPlay, "UI_Chapter_Panel_Spur_Nightmare_Open")
  end
  if #clipsToPlay > 0 then
    self.uiAnimController:StopPlayableGraph()
    self.uiAnimController:PlayMultiState(clipsToPlay, function()
    end)
  end
end

function RailWayMainView:_RefreshBtnState()
  if not self:_IsAnyRailWayPlaying() then
    self:SetButtonText(self.ui.Btn_Challenge, LT.Text("DailyChallengeEnterButton"))
    self:SetButtonState(self.ui.Btn_Challenge, CommonDefine.BtnType.High)
    return
  end
  if self:_IsSelectRailWayPlaying() then
    self:SetButtonText(self.ui.Btn_Challenge, LT.Text("ContinueChanllengeBtnTxt"))
    self:SetButtonState(self.ui.Btn_Challenge, CommonDefine.BtnType.High)
  else
    self:SetButtonText(self.ui.Btn_Challenge, LT.Text("DailyChallengeEnterButton"))
    self:SetButtonState(self.ui.Btn_Challenge, CommonDefine.BtnType.Unclickable)
  end
end

function RailWayMainView:_RefreshToggleState()
  self:_RefreshDifficultToggleState("Normal")
  self:_RefreshDifficultToggleState("Hard")
  self:_RefreshDifficultToggleState("Madness")
end

function RailWayMainView:_RefreshDifficultToggleState(difficult)
  local railWayMO = RailWayModel.Instance:GetRailWayMOByDifficult(RailWayDefine.RailWayDifficult[difficult])
  local historyMaxProgress = RailWayModel.Instance:GetDifficultyMaxScore(RailWayDefine.RailWayDifficult[difficult])
  local maxProgress = railWayMO:GetMaxProgress()
  self:SetText(self.ui["Text_" .. difficult .. "_RecLv"], string.format("%s：%s", LT.Text("Formation_RecommendLevel"), railWayMO:GetRecommendLevel()))
  self:SetText(self.ui["Text_" .. difficult .. "_Progress"], string.format("%s<color=#4d4c4c><size=24>/%s</size></color>", historyMaxProgress, maxProgress))
  self:SetText(self.ui["Text_" .. difficult .. "_ProgressTitle"], LT.Textf("RailWayMaxProgress"))
  self:SetImageFillAmount(self.ui["Image_" .. difficult .. "_Slider"], historyMaxProgress / maxProgress)
  self:SetActive(self.ui["Group_" .. difficult .. "_CurProgress"], RailWayModel.Instance:IsRailWayPlaying(railWayMO:GetStageTid()))
  self:SetText(self.ui["Text_" .. difficult .. "_CurProgress"], LT.Textf("RailWayCurProgress", RailWayModel.Instance:GetCurScore()))
end

function RailWayMainView:_RefreshTaskProgress()
  local targetFormat = "<color=#ffffff><size=36>%s</size></color>/%s"
  local taskList = TaskDataUtils.GetTaskListByType(cd.TaskType.TaskType_RailWay, true)
  local totalCount = #taskList or 0
  local completeCount = 0
  for _, taskData in ipairs(taskList or {}) do
    if taskData.state == CommonDefine.TaskState.Done then
      completeCount = completeCount + 1
    end
  end
  self.binder:SetText(self.ui.Text_Record_Progress, string.format(targetFormat, completeCount, totalCount))
  self:AddViewComponentOnce(self.ui.Red_Record, UICompRedDot, CommonDefine.RedDotType.Dot, nil, function()
    if RedPointDataUtils.IsRailWayTaskCanReceive() then
      return RedPointDataUtils.RedAttrType.Red
    end
    return false
  end)
end

function RailWayMainView:_RefreshCareerLevelProgress()
  local targetFormat = "<color=#ffffff><size=36>%s</size></color>/%s"
  local level, maxLevel = CareerLevelModel.Instance:GetCareerLevelProgress(CareerLevelDefine.CareerLevelType.RailWay)
  self.binder:SetText(self.ui.Text_Experience_Value, string.format(targetFormat, level, maxLevel))
  self:AddViewComponentOnce(self.ui.Red_Reward, UICompRedDot, CommonDefine.RedDotType.Dot, nil, function()
    if RedPointDataUtils.IsShowCareerLevelReward(CareerLevelDefine.CareerLevelType.RailWay) then
      return RedPointDataUtils.RedAttrType.Red
    end
    return false
  end)
end

function RailWayMainView:_RefreshResonanceProgress()
  local resonanceGroupId = ResonanceDataUtils.GetReonanceGroupIdByStageGroupId(RailWayStageGroupTid)
  self.binder:BindToText(self.ui.Text_Resonance_Progress, function()
    local curLevel = ResonanceDataUtils.GetResonanceGroupTotalLevel(resonanceGroupId)
    local totalLevel = ResonanceDataUtils.GetResonanceGroupMaxLevel(resonanceGroupId)
    do return string.format, "%s/%s", curLevel end
    return string.format, "%s/%s", curLevel, totalLevel
  end)
  self:AddViewComponentOnce(self.ui.Red_Resonance, UICompRedDot, CommonDefine.RedDotType.Dot, nil, function()
    do return RedPointDataUtils.IsMainStageResonanceShow end
    return RedPointDataUtils.IsMainStageResonanceShow, resonanceGroupId
  end)
end

function RailWayMainView:_RefreshRankTime()
  local seasonId = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.ConsciousnessRailway)
  if not seasonId or 0 == seasonId then
    self.binder:SetText(self.ui.Text_Rank_Time, "")
    self.binder:SetActive(self.ui.Icon_Time, false)
    return
  end
  self.binder:SetText(self.ui.Text_Rank_Time, SeasonRotationCfgUtils.GetLeftTimeTextColored(seasonId, SeasonGameplayType.ConsciousnessRailway))
  self.binder:SetActive(self.ui.Icon_Time, true)
  self.binder:SetImage(self.ui.Icon_Time, SeasonRotationCfgUtils.GetLeftTimeHourglassIcon(seasonId, SeasonGameplayType.ConsciousnessRailway))
end

return RailWayMainView
