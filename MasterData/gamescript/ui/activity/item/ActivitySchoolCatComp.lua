local ActivitySchoolCatComp, Super = System.NewClass("ActivitySchoolCatComp", ActivityAwakerTopicComp)
local UIAnimationController = CS.Z1Client.UIAnimationController

function ActivitySchoolCatComp:ctor(res, activityTid, model, params)
  self.activityTid = activityTid
  self.model = model
  self.activityData = self.model:GetActivityDataClient(activityTid)
  self.activityConfig = ActivityDataUtils.GetConfig(activityTid)
  self.activtyDefine = ActivityDefine.ActivityCompClsInfo[self.activityConfig.ActivityType]
  self.resonanceGroupId = self.activtyDefine.resonanceGroup
  self.ui = self.activtyDefine.resPath(res)
  self.hasFinishedActivity = ActivityManager.Instance:IsActivityFinishedByTid(self.activityTid)
  self.audioPlay = true
  if params then
    self.audioPlay = params.audioPlay
  end
end

function ActivitySchoolCatComp:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self:_BindActivityTimer()
  self:_SetActivityPlot()
  self:BindBtnChallenge()
  self.binder:BindTimer(1, 0, nil, function()
    StrUtils.SetPreferredHeight(self.ui.Text_Desc, 100)
  end)
  self:BindKillCount()
end

function ActivitySchoolCatComp:BindKillCount()
  self.binder:BindToRaw(function(cbinder, totalCount)
    if totalCount > 0 then
      cbinder:SetText(self.ui.Text_C_Tip, LT.Textf("ServerWideKilledMonstersCount", totalCount))
    end
  end, function()
    local stageGroupTypeId = self.activityConfig.ActivityPara1[1]
    local stageGroupList = CopyDataUtils.GetStageGroupIdList(stageGroupTypeId)
    local totalCount = 0
    for i, stageGroupId in ipairs(stageGroupList) do
      local killCountKey = "StageGroupWinCount_" .. stageGroupId
      totalCount = totalCount + (PlayerDataUtils.GetGlobalBaseStatsData(killCountKey) or 0)
    end
    return totalCount
  end)
end

function ActivitySchoolCatComp:BindBtnChallenge()
  if self.hasFinishedActivity then
    self.ui.Btn_Challenge:SetActive(false)
    return
  end
  local stageGroupTypeId = self.activityConfig.ActivityPara1[1]
  local stageGroupList = CopyDataUtils.GetStageGroupIdList(stageGroupTypeId)
  self:BindNewStageGroupRed(stageGroupList)
end

function ActivitySchoolCatComp:OnUnbind()
  Super.OnUnbind(self)
end

return ActivitySchoolCatComp
