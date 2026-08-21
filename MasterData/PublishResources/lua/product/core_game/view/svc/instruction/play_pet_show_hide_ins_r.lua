require("base_ins_r")
_class("PlayPetShowHideInstruction", BaseInstruction)
PlayPetShowHideInstruction = PlayPetShowHideInstruction

function PlayPetShowHideInstruction:Constructor(paramList)
  self._visible = tonumber(paramList.visible)
  self._forcePlayOnSkillHolder = tonumber(paramList.forcePlayOnSkillHolder) == 1
end

function PlayPetShowHideInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local realCaster = casterEntity
  if casterEntity:HasSuperEntity() and casterEntity:EntityType():IsSkillHolder() and not self._forcePlayOnSkillHolder then
    realCaster = casterEntity:GetSuperEntity()
  end
  if not realCaster:HasPet() then
    return
  end
  local isShow = self._visible == 1
  local eTeam = realCaster:Pet():GetOwnerTeamEntity()
  local cTeam = eTeam:Team()
  local eTeamLeader = cTeam:GetTeamLeaderEntity()
  if eTeamLeader:GetID() == realCaster:GetID() then
    return
  end
  realCaster:SetViewVisible(isShow)
  eTeamLeader:SetViewVisible(not isShow)
end
