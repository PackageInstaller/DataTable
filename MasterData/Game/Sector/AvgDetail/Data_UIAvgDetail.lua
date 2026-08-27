local Data_UIAvgDetail = class("Data_UIAvgDetail")

function Data_UIAvgDetail:SetAvgDetailAvgId(avgId)
  self._avgId = avgId
  self._avgCfg = ConfigData.story_avg[avgId]
end

function Data_UIAvgDetail:SetAvgDetailBannerTexPath(bannerTexPath)
  self._bannerTexPath = bannerTexPath
end

function Data_UIAvgDetail:SetAvgDetailExtraCondition(isUnlock, lockDes)
  self._extraLockConditionList = self._extraLockConditionList or {}
  table.insert(self._extraLockConditionList, {lockReason = lockDes, unlock = isUnlock})
end

function Data_UIAvgDetail:SetAvgDetailExtraReward(rewardDic)
  self._extraReward = rewardDic
end

function Data_UIAvgDetail:SetAvgDetailExTitle(str)
  self._exTitle = str
end

function Data_UIAvgDetail:SetAvgDetailCloseBgOpen(flag)
  self._closeBgOpen = flag
end

function Data_UIAvgDetail:SetAvgDetailCloseCallback(callback)
  self._closeCallback = callback
end

function Data_UIAvgDetail:SetAvgDetailOpenTweenBeginCallback(callback)
  self._openBeginTweenCallback = callback
end

function Data_UIAvgDetail:SetAvgDetailCloseTweenBeginCallback(callback)
  self._closeBeginTweenCallback = callback
end

function Data_UIAvgDetail:SetAvgDetailExtraPlayedState(flag)
  self._extraPlayed = flag
end

function Data_UIAvgDetail:SetAvgDetailRewardShowState(flag)
  self._rewardShowState = flag
end

function Data_UIAvgDetail:GetAvgDetailAvgId()
  return self._avgId
end

function Data_UIAvgDetail:GetAvgDetailAvgCfg()
  return self._avgCfg
end

function Data_UIAvgDetail:GetAvgDetailAvgBannerTexPath()
  return self._bannerTexPath
end

function Data_UIAvgDetail:GetAvgDetailExtraCondition()
  return self._extraLockConditionList
end

function Data_UIAvgDetail:GetAvgDetailCloseBgOpen()
  return self._closeBgOpen
end

function Data_UIAvgDetail:GetAvgDetailExTitle()
  return self._exTitle
end

function Data_UIAvgDetail:GetAvgDetailCloseCallback()
  return self._closeCallback
end

function Data_UIAvgDetail:GetAvgDetailExtraReward()
  return self._extraReward
end

function Data_UIAvgDetail:GetAvgDetailOpenTweenBeginCallback()
  return self._openBeginTweenCallback
end

function Data_UIAvgDetail:GetAvgDetailCloseTweenBeginCallback()
  return self._closeBeginTweenCallback
end

function Data_UIAvgDetail:GetAvgDetailPlayed()
  if self._extraPlayed ~= nil then
    return self._extraPlayed
  end
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  return avgPlayCtrl:IsAvgPlayed(self._avgId)
end

function Data_UIAvgDetail:GetAvgDetailRewardShowState()
  if self._rewardShowState == nil then
    return true
  end
  return self._rewardShowState
end

return Data_UIAvgDetail
