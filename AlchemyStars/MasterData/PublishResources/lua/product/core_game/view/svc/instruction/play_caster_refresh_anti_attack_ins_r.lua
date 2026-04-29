require("base_ins_r")
_class("PlayCasterRefreshAntiAttackInstruction", BaseInstruction)
PlayCasterRefreshAntiAttackInstruction = PlayCasterRefreshAntiAttackInstruction

function PlayCasterRefreshAntiAttackInstruction:Constructor(paramList)
end

function PlayCasterRefreshAntiAttackInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateAntiActiveSkill, casterEntity:GetID())
end
