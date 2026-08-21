require("skill_effect_result_base")
_class("SkillEffectResult_RandAttackData", Object)
SkillEffectResult_RandAttackData = SkillEffectResult_RandAttackData

function SkillEffectResult_RandAttackData:Constructor(entityDefenter, damageInfo, index)
  self.m_entityDefenter = entityDefenter
  self.m_damageData = damageInfo
  self._index = index
end

_class("SkillEffectResult_RandAttack", SkillEffectResultBase)
SkillEffectResult_RandAttack = SkillEffectResult_RandAttack

function SkillEffectResult_RandAttack:Constructor(nTimes, listDefender, listDeath, listDeathPos, listAlive)
  self.m_nAttackTimes = nTimes
  self.m_listDefender = listDefender
  self.m_listDeath = listDeath
  self.m_listAlive = listAlive
  self.m_listDeathPos = listDeathPos
end

function SkillEffectResult_RandAttack:GetEffectType()
  return SkillEffectType.RandAttack
end

function SkillEffectResult_RandAttack:GetAttackTimes()
  return self.m_nAttackTimes
end

function SkillEffectResult_RandAttack:GetListDefenderCount()
  return table.count(self.m_listDefender)
end

function SkillEffectResult_RandAttack:GetListAliveCount()
  return table.count(self.m_listAlive)
end

function SkillEffectResult_RandAttack:GetListDeadCount()
  return table.count(self.m_listDeath)
end

function SkillEffectResult_RandAttack:GetListDefender()
  return self.m_listDefender
end

function SkillEffectResult_RandAttack:GetDefenderData(nIndex)
  return self.m_listDefender[nIndex]
end

function SkillEffectResult_RandAttack:GetListDeath()
  return self.m_listDeath
end

function SkillEffectResult_RandAttack:GetListDeathPos()
  return self.m_listDeathPos
end
