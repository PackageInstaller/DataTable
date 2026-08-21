require("base_ins_r")
_class("PlayFormerLeaderVisibleInstruction", BaseInstruction)
PlayFormerLeaderVisibleInstruction = PlayFormerLeaderVisibleInstruction

function PlayFormerLeaderVisibleInstruction:Constructor(paramList)
  self._visible = tonumber(paramList.visible) == 1
end

function PlayFormerLeaderVisibleInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local caster = casterEntity
  if caster:HasSuperEntity() then
    caster = caster:GetSuperEntity()
  end
  if not caster:HasPet() then
    return
  end
  local eFormerTeamLeader = self:_GetFormerTeamLeaderFromSkillResult(caster, phaseContext)
  if not eFormerTeamLeader then
    local teamEntity = caster:Pet():GetOwnerTeamEntity()
    local petEntities = teamEntity:Team():GetTeamPetEntities()
    for _, e in ipairs(petEntities) do
      e:SetViewVisible(false)
    end
    return
  end
  eFormerTeamLeader:SetViewVisible(self._visible)
end

function PlayFormerLeaderVisibleInstruction:_GetFormerTeamLeaderFromSkillResult(casterEntity, phaseContext)
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
