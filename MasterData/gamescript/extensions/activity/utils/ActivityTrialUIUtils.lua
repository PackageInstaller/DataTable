local ActivityTrialUIUtils = {}

function ActivityTrialUIUtils.RefreshTrialLeftTab(nowTid)
  local compUI = ActivityTrialUIUtils.trialComp
  if not compUI or not compUI.ui then
    return
  end
  compUI.activityTid = nowTid
  compUI:SetTabFacade()
end

function ActivityTrialUIUtils.InitTrialTab(compUI, trialList)
  ActivityTrialUIUtils.trialComp = compUI or ActivityTrialUIUtils.trialComp
  ActivityTrialUIUtils.trialList = trialList or ActivityTrialUIUtils.trialList
end

function ActivityTrialUIUtils.GetActivityHasFinish(activityId)
  local trials = ActivityTrialUIUtils.trialList
  if not trials then
    return false
  end
  local model = ActivityManager.Instance.model
  if not model:IsTrialActivityTid(activityId) then
    local activityData = ActivityDataUtils.GetActivityData(activityId)
    return activityData.hasFinish
  end
  local ret
  for _, activityTid in ipairs(trials) do
    local activityData = ActivityDataUtils.GetActivityData(activityTid)
    ret = activityData.hasFinish
    if not ret then
      return false
    end
  end
  return ret
end

return ActivityTrialUIUtils
