_class("BuffLogicChangeAttackSkill", BuffLogicBase)
BuffLogicChangeAttackSkill = BuffLogicChangeAttackSkill

function BuffLogicChangeAttackSkill:Constructor(buffInstance, logicParam)
  self._attackSkillId = logicParam.attackSkillId
  self._attackSkillCount = logicParam.attackSkillCount
  self._directReplace = logicParam.directReplace or 0
  self._excludeOriPos = logicParam.excludeOriPos or 0
  self._useAttackPosAsCenter = logicParam.useAttackPosAsCenter or 0
  self._onlyReplaceNormalSkillInXScope = logicParam.onlyReplaceNormalSkillInXScope
end

function BuffLogicChangeAttackSkill:DoLogic(notify)
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("ChangeNormalSkillID", self._attackSkillId)
  if self._attackSkillCount then
    e:BuffComponent():SetBuffValue("ChangeNormalSkillCount", self._attackSkillCount)
  end
  e:BuffComponent():SetBuffValue("NormalSkillDirectReplace", self._directReplace)
  if self._excludeOriPos then
    e:BuffComponent():SetBuffValue("ChangeNormalSkillExcludeOriPos", self._excludeOriPos)
  end
  if self._useAttackPosAsCenter then
    e:BuffComponent():SetBuffValue("ChangeNormalSkillUseAttackPosAsCenter", self._useAttackPosAsCenter)
  end
  if self._onlyReplaceNormalSkillInXScope then
    e:BuffComponent():SetBuffValue("OnlyReplaceNormalSkillInXScope", self._onlyReplaceNormalSkillInXScope)
  end
  local trapCasterID = 0
  if notify and notify:GetNotifyType() == NotifyType.TrapSkillStart then
    trapCasterID = notify:GetNotifyEntity():GetID()
  end
  local buffResult = BuffResultChangeAttackSkill:New(trapCasterID)
  return buffResult
end

_class("BuffLogicUndoChangeAttackSkill", BuffLogicBase)
BuffLogicUndoChangeAttackSkill = BuffLogicUndoChangeAttackSkill

function BuffLogicUndoChangeAttackSkill:Constructor(buffInstance, logicParam)
end

function BuffLogicUndoChangeAttackSkill:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("ChangeNormalSkillID", nil)
  e:BuffComponent():SetBuffValue("ChangeNormalSkillCount", 0)
  e:BuffComponent():SetBuffValue("NormalSkillDirectReplace", 0)
  e:BuffComponent():SetBuffValue("ChangeNormalSkillExcludeOriPos", 0)
  e:BuffComponent():SetBuffValue("ChangeNormalSkillUseAttackPosAsCenter", 0)
  e:BuffComponent():SetBuffValue("OnlyReplaceNormalSkillInXScope", nil)
end
