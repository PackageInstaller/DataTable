local ActivityPermanentRailWayComp, Super = System.NewClass("ActivityPermanentRailWayComp", ActivityPermanentBaseComp)
local SeasonGameplayType = CommonDefine.SeasonGameplayType

function ActivityPermanentRailWayComp:ctor(uiNode, activityTid)
  Super.ctor(self, uiNode, UI_Events_Panel_RailWayResource, activityTid)
end

function ActivityPermanentRailWayComp:OnBind(binder)
  Super.OnBind(self, binder)
  binder:BindZ1Button(self.ui.Btn_Challenge, System.fn(self, self._OnClickChallenge))
  binder:BindZ1Button(self.ui.Btn_Rank, System.fn(self, self._OnClickRank))
  binder:BindNewComponent(self.ui.uiNode, ActivityPermanantRewardComp, UI_Events_Panel_PermanentActivityResource, self._activityTid)
  binder:BindEvent(EventMgr.Instance.OnCareerLevelDataChanged, System.fn(self, self._OnCareerLevelDataChanged))
  binder:BindEvent(EventMgr.Instance.TaskInfoUpdated, System.fn(self, self._OnTaskInfoUpdated))
  self:_RefreshRedDot()
  self:_BindResonanceProgress()
  self:_RefreshSeasonInfo()
  self._timer = binder:BindTimer(1, -1, function()
    self:_RefreshSeasonInfo()
  end)
end

function ActivityPermanentRailWayComp:_RefreshSeasonInfo()
  local seasonId = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.ConsciousnessRailway)
  if not seasonId or 0 == seasonId then
    self.binder:SetActive(self.ui.Icon_Time, false)
    self.binder:SetActive(self.ui.Text_Time, false)
    self.binder:SetText(self.ui.Text_Season, "")
    self.binder:SetText(self.ui.Text_Time, "")
    return
  end
  self.binder:SetActive(self.ui.Text_Time, false)
  self.binder:SetText(self.ui.Text_Rank_Time, SeasonRotationCfgUtils.GetLeftTimeTextColored(seasonId, SeasonGameplayType.ConsciousnessRailway))
  self.binder:SetActive(self.ui.Icon_Time, true)
  self.binder:SetImage(self.ui.Icon_Time, SeasonRotationCfgUtils.GetLeftTimeHourglassIcon(seasonId, SeasonGameplayType.ConsciousnessRailway))
end

function ActivityPermanentRailWayComp:_BindResonanceProgress()
  if not self.ui.Btn_Resonance then
    return
  end
  self.binder:BindComponent(ResonanceGroupComp(CommonDefine.ResonanceGroupRailway, self.ui.Btn_Resonance, self.ui.Text_ResonanceProgress, self.ui.Text_TotalProgress, self.ui.Red_Resonance, self.activityTid, self))
end

function ActivityPermanentRailWayComp:_OnCareerLevelDataChanged()
  self:_RefreshRedDot()
end

function ActivityPermanentRailWayComp:_OnTaskInfoUpdated(taskData)
  local taskType = TaskCfgUtils.GetCfgField("TaskType", taskData.tid)
  if taskType == cd.TaskType.TaskType_RailWay then
    self:_RefreshRedDot()
    return
  end
  local seasonId = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.ConsciousnessRailway)
  if seasonId and 0 ~= seasonId then
    local seasonTaskTid = SeasonRotationCfgUtils.GetSeasonTaskId(seasonId, SeasonGameplayType.ConsciousnessRailway)
    if seasonTaskTid and 0 ~= seasonTaskTid and taskData.tid == seasonTaskTid then
      self:_RefreshRedDot()
    end
  end
end

function ActivityPermanentRailWayComp:_RefreshRedDot()
  self.binder:BindComponent(UICompRedDotNewVue(self.ui.NewTag_Challenge, RedDotDefine.DynamicRedDotID.RailWayEntryWithoutSeasonReward))
end

function ActivityPermanentRailWayComp:_OnClickChallenge()
  RailWayController.Instance:OpenRailWayMainView()
end

function ActivityPermanentRailWayComp:_OnClickRank()
  RailWayController.Instance:OpenRankView()
end

function ActivityPermanentRailWayComp:GetOpenAnim()
  return "UI_Events_Panel_RailWay_Open"
end

function ActivityPermanentRailWayComp:GetCloseAnim()
  return "UI_Events_Panel_RailWay_Close"
end

function ActivityPermanentRailWayComp:OnUnbind()
  Super.OnUnbind(self)
  if self._timer then
    self.binder:StopTimer(self._timer)
    self._timer = nil
  end
end

return ActivityPermanentRailWayComp
