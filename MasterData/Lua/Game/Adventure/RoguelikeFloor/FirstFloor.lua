local FirstFloor = {}

function FirstFloor:Init()
  self._bStart = true
  self.touchPortal = false
end

function FirstFloor:OnRoguelikeEnter(PlayerRoguelikeData)
  PlayerRoguelikeData:SetActorEffects()
  PlayerRoguelikeData:SetActorAttribute(true)
  PlayerRoguelikeData:ResetBoxCount()
end

function FirstFloor:OnTouchPortal(PlayerRoguelikeData)
  if self.touchPortal then
    return
  end
  self.touchPortal = true
  PlayerRoguelikeData:CacheCharAttr()
  PlayerRoguelikeData:SendSettleReq()
end

function FirstFloor:SettleCallback(PlayerRoguelikeData)
  PlayerRoguelikeData:FloorEnd()
end

function FirstFloor:OnAbandon(PlayerRoguelikeData, bFailed)
  PlayerRoguelikeData:AbandonRoguelike(bFailed)
end

return FirstFloor
