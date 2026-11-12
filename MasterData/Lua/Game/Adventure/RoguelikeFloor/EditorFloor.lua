local TimerManager = require("GameCore.Timer.TimerManager")
local EditorFloor = {}

function EditorFloor:Init()
end

function EditorFloor:OnRoguelikeEnter(PlayerRoguelikeData)
  PlayerRoguelikeData:SetActorEffects()
  PlayerRoguelikeData:SetActorAttribute()
end

function EditorFloor:OnTouchPortal(PlayerRoguelikeData)
  PlayerRoguelikeData:CacheCharAttr()
  PlayerRoguelikeData:FloorEndEditor()
end

function EditorFloor:SettleCallback(PlayerRoguelikeData)
end

function EditorFloor:OnBossDied(PlayerRoguelikeData)
  safe_call_cs_func(CS.AdventureModuleHelper.Lua2CSharp_RoguelikeOpenTeleporter)
end

function EditorFloor:OnAbandon(PlayerRoguelikeData)
  PlayerRoguelikeData:FloorEndEditor()
end

return EditorFloor
