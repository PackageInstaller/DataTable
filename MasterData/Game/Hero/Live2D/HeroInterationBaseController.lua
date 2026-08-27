local HeroInterationBaseController = class("HeroInterationBaseController")

function HeroInterationBaseController:PlayHeroEnterHomeAnimation(loginType)
end

function HeroInterationBaseController:PlayLoginAnimation(loginType, dontCheckTime)
end

function HeroInterationBaseController:SetInterationOpenRayCast(flag)
end

function HeroInterationBaseController:SetInterationCVOver(flag)
end

function HeroInterationBaseController:SetInterationOpenWait(flag)
end

function HeroInterationBaseController:ResetInterationWaitTime()
end

function HeroInterationBaseController:RestartBodyAnimation()
end

function HeroInterationBaseController:CheckGlobalPlayTimeInterval(currentHeroId, dontCheckTime)
  local lastCvInfo = PlayerDataCenter.cacheSaveData:GetLastHeroInterationCVInfo()
  local currentTime = CS.UnityEngine.Time.time
  local timeInterval = ConfigData.game_config.l2dGlobalWaitTimeInterval
  if lastCvInfo ~= nil and not dontCheckTime and lastCvInfo.lastVoiceHeroId == currentHeroId and lastCvInfo.lastVoiceTIme ~= nil and timeInterval > currentTime - lastCvInfo.lastVoiceTIme then
    return false
  end
  return true
end

function HeroInterationBaseController:IsPlayLoginAnimationOnAutoShowOver(loginType)
  return true
end

function HeroInterationBaseController:Delete()
end

return HeroInterationBaseController
