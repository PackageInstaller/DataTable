_class("BuffLogicSetNormalUseSkillTarget", BuffLogicBase)
BuffLogicSetNormalUseSkillTarget = BuffLogicSetNormalUseSkillTarget

function BuffLogicSetNormalUseSkillTarget:Constructor(buffInstance, logicParam)
end

function BuffLogicSetNormalUseSkillTarget:DoLogic(notify)
  local e = self._buffInstance:Entity()
  local buffComponent = e:BuffComponent()
  buffComponent:SetBuffValue("NormalAttackUseSkillTarget", 1)
end

_class("BuffLogicResetNormalUseSkillTarget", BuffLogicBase)
BuffLogicResetNormalUseSkillTarget = BuffLogicResetNormalUseSkillTarget

function BuffLogicResetNormalUseSkillTarget:Constructor(buffInstance, logicParam)
end

function BuffLogicResetNormalUseSkillTarget:DoLogic(notify)
  local e = self._buffInstance:Entity()
  local buffComponent = e:BuffComponent()
  buffComponent:SetBuffValue("NormalAttackUseSkillTarget", nil)
end
