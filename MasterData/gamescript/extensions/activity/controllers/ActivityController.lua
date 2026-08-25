local ActivityController = NewClass("ActivityController", BaseController)

function ActivityController:OnInit()
end

function ActivityController:OnReset()
end

function ActivityController:OpenActivityStageGroupPanel(activityData, resonanceGroupId)
  local activityTid = activityData.activityTid
  local tipsId = ActivityCfgUtils.GetBestExperienceTipsId(activityTid)
  local viewData = {
    activityTid = activityTid,
    finishTime = activityData.finishTime,
    endTime = activityData.endTime,
    resonanceGroupId = resonanceGroupId
  }
  
  local function OpenTargetView()
    UIManager.Instance:Reopen(Urls.ActivityStageGroupPanel, viewData)
  end
  
  if not tipsId then
    OpenTargetView()
    return
  end
  local isCloseBestPrompt = ClientDataUtils.GetClientSubData(cd.ClientSubKey.CloseBestPromptToday)
  if 1 == isCloseBestPrompt then
    OpenTargetView()
    return
  end
  viewData = {
    tipsTypeTid = tipsId,
    stageTidList = ActivityCfgUtils.GetCfgField("BestExperienceCondition", activityTid),
    confirmFunc = OpenTargetView
  }
  UIManager.Instance:Reopen(Urls.BestExpeirenceMsgView, viewData)
end

function ActivityController:OpenActivityWorldBossStagePanel(activityTid, resonanceGroupId, stageGroupList)
  local viewData = {
    activityTid = activityTid,
    resonanceGroupId = resonanceGroupId,
    stageGroupList = stageGroupList
  }
  UIManager.Instance:Reopen(Urls.ActivityWorldBossStagePanel, viewData)
end

function ActivityController:OpenActivityRaidStagePanel(activityTid, resonanceGroupId, stageGroupList)
  local activityData = ActivityDataUtils.GetActivityData(activityTid)
  local viewData = {
    activityTid = activityTid,
    resonanceGroupId = resonanceGroupId,
    stageGroupList = stageGroupList,
    finishTime = activityData and activityData.finishTime,
    endTime = activityData and activityData.endTime
  }
  UIManager.Instance:Reopen(Urls.ActivityRaidStagePanel, viewData)
end

function ActivityController:OpenActivityPermanentsPanel()
  UIManager.Instance:Reopen(Urls.ActivityPermanentsPanel)
end

return ActivityController
