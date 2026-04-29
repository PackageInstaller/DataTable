_class("BuffLogicChangePetAndTeamActiveSkill", BuffLogicBase)
BuffLogicChangePetAndTeamActiveSkill = BuffLogicChangePetAndTeamActiveSkill

function BuffLogicChangePetAndTeamActiveSkill:Constructor(buffInstance, logicParam)
  self._skillID = logicParam.skillID
end

function BuffLogicChangePetAndTeamActiveSkill:DoLogic()
  local skillInfoComponent = self._entity:SkillInfo()
  skillInfoComponent:SetActiveSkillID(self._skillID)
  local teamEntity = self._entity:Pet():GetOwnerTeamEntity()
  local activeSkillCmpt = teamEntity:ActiveSkill()
  activeSkillCmpt:SetActiveSkillID(self._skillID, self._entity:GetID())
  local petPstID = self._entity:PetPstID():GetPstID()
  local buffResult = BuffResultChangePetAndTeamActiveSkill:New(petPstID, self._skillID)
  return buffResult
end
