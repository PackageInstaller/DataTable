local ActivityUiUtils = {}

function ActivityUiUtils.RefreshActivityCountDown(binder, textNode, activityData)
  local finishTime, endTime = activityData.finishTime, activityData.endTime
  local now = TimeUtils.GetFixedTimestamp(TimeUtils.GetServerTime())
  local finishTimeCountdown = (finishTime or 0) - now
  local timeText = ""
  if finishTimeCountdown > 0 then
    timeText = TimeUtils.ActivityCountDownFormat(finishTimeCountdown)
  else
    local activityType = ActivityCfgUtils.GetCfgField("ActivityType", activityData.tid)
    local endTimeCountdown = (endTime or 0) - now
    if endTimeCountdown >= 0 then
      if activityType == ActivityDefine.ActivityType.TwoAnniversaryWorldBossActivity then
        timeText = TimeUtils.ActivityCountDownFormat(endTimeCountdown)
      elseif finishTime and finishTime > 0 then
        timeText = TimeUtils.ActivityExchangeCountDownFormat(endTimeCountdown)
      else
        timeText = TimeUtils.ActivityCountDownFormat(endTimeCountdown)
      end
    elseif activityType == ActivityDefine.ActivityType.TwoAnniversaryWorldBossActivity then
      binder:SetActive(textNode, false)
    else
      timeText = LT.Text("ActivityTimeExpired")
    end
  end
  binder:SetText(textNode, timeText)
end

return ActivityUiUtils
