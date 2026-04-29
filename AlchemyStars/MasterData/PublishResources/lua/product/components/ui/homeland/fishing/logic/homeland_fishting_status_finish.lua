_class("HomelandFishingStatusFinish", HomelandFishingStatus)
HomelandFishingStatusFinish = HomelandFishingStatusFinish

function HomelandFishingStatusFinish:OnEnter()
  self:SetFishRodStatus(false)
  self:SwitchStatus(FishgingStatus.Throw)
end

function HomelandFishingStatusFinish:OnExit()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SetInteractPointUIStatus, true)
end

function HomelandFishingStatusFinish:FishingStatus()
  return FishgingStatus.Finish
end

function HomelandFishingStatusFinish:OnDestroy()
end
