require("base_ins_r")
_class("PlayTeamTurnToDirByCenterPosArrayInstruction", BaseInstruction)
PlayTeamTurnToDirByCenterPosArrayInstruction = PlayTeamTurnToDirByCenterPosArrayInstruction

function PlayTeamTurnToDirByCenterPosArrayInstruction:Constructor(paramList)
end

function PlayTeamTurnToDirByCenterPosArrayInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local centerPosArray = scopeResult:GetCenterPos()
  if #centerPosArray ~= 2 then
    local skillID = skillEffectResultContainer:GetSkillID()
    Log.error("Team cant turn to center pos, castID=", casterEntity:GetID(), ", skillID=", skillID)
    return
  end
  local dir = centerPosArray[2] - centerPosArray[1]
  local world = casterEntity:GetOwnerWorld()
  local teamEntity = world:Player():GetCurrentTeamEntity()
  teamEntity:SetDirection(dir)
end
