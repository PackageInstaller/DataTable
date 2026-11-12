local BossFloor = {}

function BossFloor:Init()
  self.touchPortal = false
end

function BossFloor:OnRoguelikeEnter(PlayerRoguelikeData)
  PlayerRoguelikeData:SetActorEffects()
  PlayerRoguelikeData:ResetBoxCount()
  PlayerRoguelikeData:ResetPerkEffect()
  PlayerRoguelikeData:SetActorAttribute(false)
end

function BossFloor:OnTouchPortal(PlayerRoguelikeData)
  if self.touchPortal then
    return
  end
  self.touchPortal = true
  PlayerRoguelikeData:CacheCharAttr()
  PlayerRoguelikeData:SendSettleReq()
end

function BossFloor:SettleCallback(PlayerRoguelikeData)
  PlayerRoguelikeData:FloorEnd()
end

function BossFloor:OnBossDied(PlayerRoguelikeData)
  PlayerRoguelikeData:SyncKillBoss()
  safe_call_cs_func(CS.AdventureModuleHelper.Lua2CSharp_RoguelikeOpenTeleporter)
end

function BossFloor:OnAbandon(PlayerRoguelikeData, bFailed)
  PlayerRoguelikeData:AbandonRoguelike(bFailed)
end

return BossFloor
