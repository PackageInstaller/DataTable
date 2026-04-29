require("base_ins_r")
_class("PlayUIEffectOutsideInstruction", BaseInstruction)
PlayUIEffectOutsideInstruction = PlayUIEffectOutsideInstruction

function PlayUIEffectOutsideInstruction:Constructor(paramList)
  self._prefabName = paramList.effectName
  self._duaration = tonumber(paramList.duration)
end

function PlayUIEffectOutsideInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  world:EventDispatcher():Dispatch(GameEventType.PlayBattleUIEffectOutside, self._prefabName, self._duaration)
end
