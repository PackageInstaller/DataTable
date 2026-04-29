require("base_ins_r")
_class("PlayFormerLeaderMaterialAnimInstruction", BaseInstruction)
PlayFormerLeaderMaterialAnimInstruction = PlayFormerLeaderMaterialAnimInstruction

function PlayFormerLeaderMaterialAnimInstruction:Constructor(paramList)
  self._animName = paramList.animName
end

function PlayFormerLeaderMaterialAnimInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local caster = casterEntity
  if caster:HasSuperEntity() then
    caster = caster:GetSuperEntity()
  end
  if not caster:HasPet() then
    return
  end
  local eFormerTeamLeader = self:_GetFormerTeamLeaderFromSkillResult(caster, phaseContext)
  if not eFormerTeamLeader then
    return
  end
  eFormerTeamLeader:PlayMaterialAnim(self._animName)
end

function PlayFormerLeaderMaterialAnimInstruction:_GetFormerTeamLeaderFromSkillResult(casterEntity, phaseContext)
  local eTeam = casterEntity:Pet():GetOwnerTeamEntity()
  local routineComponent = casterEntity:SkillRoutine():GetResultContainer()
  local formerTeamLeaderPstID
  local changePetTeamOrderResult = routineComponent:GetEffectResultByArray(SkillEffectType.ChangePetTeamOrder)
  if changePetTeamOrderResult then
    formerTeamLeaderPstID = changePetTeamOrderResult:GetOldTeamOrder()[1]
  end
  local swapPetTeamOrderResult = routineComponent:GetEffectResultByArray(SkillEffectType.SwapPetTeamOrder)
  if swapPetTeamOrderResult then
    formerTeamLeaderPstID = swapPetTeamOrderResult:GetOldTeamOrder()[1]
  end
  local ePet = eTeam:Team():GetPetEntityByPetPstID(formerTeamLeaderPstID)
  return ePet
end
