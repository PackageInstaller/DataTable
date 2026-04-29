_class("BuffLogicChangeTrapActiveSkill", BuffLogicBase)
BuffLogicChangeTrapActiveSkill = BuffLogicChangeTrapActiveSkill

function BuffLogicChangeTrapActiveSkill:Constructor(buffInstance, logicParam)
  self._targetSkill = logicParam.targetSkill or 0
  self._changeSkill = logicParam.changeSkill or 0
end

function BuffLogicChangeTrapActiveSkill:DoLogic()
  local trapEntity = self._buffInstance:Entity()
  if not trapEntity then
    return
  end
  local trapCmpt = trapEntity:Trap()
  local activeSkillID = trapCmpt:GetActiveSkillID()
  for i = 1, #activeSkillID do
    local skillID = activeSkillID[i]
    if skillID == self._targetSkill then
      activeSkillID[i] = self._changeSkill
      break
    end
  end
  trapCmpt:SetActiveSkillID(activeSkillID)
end
