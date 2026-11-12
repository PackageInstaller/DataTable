local NormalFloor = {}

function NormalFloor:Init()
  self.touchPortal = false
end

function NormalFloor:OnRoguelikeEnter(PlayerRoguelikeData)
  PlayerRoguelikeData:SetActorEffects()
  PlayerRoguelikeData:SetActorAttribute(false)
  PlayerRoguelikeData:ResetBoxCount()
  PlayerRoguelikeData:ResetPerkEffect()
end

function NormalFloor:OnTouchPortal(PlayerRoguelikeData)
  if self.touchPortal then
    return
  end
  self.touchPortal = true
  PlayerRoguelikeData:CacheCharAttr()
  PlayerRoguelikeData:SendSettleReq()
end

function NormalFloor:SettleCallback(PlayerRoguelikeData)
  PlayerRoguelikeData:FloorEnd()
end

function NormalFloor:OnAbandon(PlayerRoguelikeData, bFailed)
  PlayerRoguelikeData:AbandonRoguelike(bFailed)
end

return NormalFloor
