require("base_ins_r")
_class("PlayUIEffectInstruction", BaseInstruction)
PlayUIEffectInstruction = PlayUIEffectInstruction

function PlayUIEffectInstruction:Constructor(paramList)
  self._prefabName = paramList.effectName
  self._duaration = paramList.duaration
end

function PlayUIEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  world:EventDispatcher():Dispatch(GameEventType.PlayBattleUIEffect, self._prefabName, self._duaration)
end
