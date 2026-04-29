require("base_ins_r")
_class("PlayModifyAntiAttackParamInstruction", BaseInstruction)
PlayModifyAntiAttackParamInstruction = PlayModifyAntiAttackParamInstruction

function PlayModifyAntiAttackParamInstruction:Constructor(paramList)
end

function PlayModifyAntiAttackParamInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateAntiActiveSkill, casterEntity:GetID())
end
