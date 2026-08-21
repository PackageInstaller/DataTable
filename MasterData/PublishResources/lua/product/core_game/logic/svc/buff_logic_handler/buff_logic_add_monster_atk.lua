_class("BuffLogicAddMonsterAtk", BuffLogicBase)
BuffLogicAddMonsterAtk = BuffLogicAddMonsterAtk

function BuffLogicAddMonsterAtk:Constructor(buffInstance, logicParam)
  self._atkPercent = logicParam.addValue
  self._entity = buffInstance._entity
  self._buffLogicSvc = buffInstance._world:GetService("BuffLogic")
  self._buffSeq = buffInstance._buffSeq
end

function BuffLogicAddMonsterAtk:DoLogic()
  self._buffLogicSvc:ChangeSkillIncrease(self._entity, self._buffSeq, ModifySkillIncreaseParamType.MonsterDamage, self._atkPercent)
end
