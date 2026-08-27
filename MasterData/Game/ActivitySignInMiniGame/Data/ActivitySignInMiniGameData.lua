local ActivitySignInMiniGameData = class("ActivitySignInMiniGameData")

function ActivitySignInMiniGameData:ctor()
end

function ActivitySignInMiniGameData:InitActivityFrameData(activityFrameData)
  self._activityFrameData = activityFrameData
end

function ActivitySignInMiniGameData:InitNetWrorkData(msg)
  self._netWorkSignData = msg
end

function ActivitySignInMiniGameData:GetActID()
  if self._activityFrameData == nil then
    return nil
  end
  return self._activityFrameData.actId
end

function ActivitySignInMiniGameData:GetActivityFrameId()
  if self._activityFrameData == nil then
    return nil
  end
  return self._activityFrameData:GetActivityFrameId()
end

function ActivitySignInMiniGameData:GetNextSignTime()
  if self._netWorkSignData == nil then
    return nil
  end
  return self._netWorkSignData.nextSignTime
end

function ActivitySignInMiniGameData:GetHasSignDayCount()
  if self._netWorkSignData == nil then
    return nil
  end
  return #self._netWorkSignData.sign
end

function ActivitySignInMiniGameData:GetActOpenTime()
  if self._activityFrameData == nil then
    return nil
  end
  return self._activityFrameData.startTime
end

function ActivitySignInMiniGameData:GetActSign()
  if self._netWorkSignData == nil then
    return nil
  end
  return self._netWorkSignData.sign
end

function ActivitySignInMiniGameData:GetActAwardGroup()
  if self._netWorkSignData == nil then
    return nil
  end
  return self._netWorkSignData.awardGroupId
end

function ActivitySignInMiniGameData:GetActivityReddotNode()
  if self._activityFrameData == nil then
    return nil
  end
  return self._activityFrameData:GetActivityReddotNode()
end

function ActivitySignInMiniGameData:SetActivityIscartoonPlayed()
  if self._netWorkSignData == nil then
    return
  end
  self._netWorkSignData.cartoonPlayed = true
end

function ActivitySignInMiniGameData:GetActivityIscartoonPlayed()
  if self._netWorkSignData == nil then
    return false
  end
  return self._netWorkSignData.cartoonPlayed
end

return ActivitySignInMiniGameData
