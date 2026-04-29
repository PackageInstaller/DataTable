require("buff_logic_base")
_class("BuffLogicMaxMonsterGuardNormalSkill", BuffLogicBase)
BuffLogicMaxMonsterGuardNormalSkill = BuffLogicMaxMonsterGuardNormalSkill

function BuffLogicMaxMonsterGuardNormalSkill:Constructor(_buffIns, logicParam)
  self._maxCount = logicParam.maxCount
end

function BuffLogicMaxMonsterGuardNormalSkill:DoLogic(notify)
  self._buffComponent:SetBuffValue("MaxNormalAtkCount", self._maxCount)
  return self._maxCount
end

_class("BuffLogicRemoveMaxMonsterGuardNormalSkill", BuffLogicBase)
BuffLogicRemoveMaxMonsterGuardNormalSkill = BuffLogicRemoveMaxMonsterGuardNormalSkill

function BuffLogicRemoveMaxMonsterGuardNormalSkill:DoLogic(notify)
  self._buffComponent:SetBuffValue("MaxNormalAtkCount", nil)
end

_class("BuffLogicAddMonsterGuardNormalSkillCount", BuffLogicBase)
BuffLogicAddMonsterGuardNormalSkillCount = BuffLogicAddMonsterGuardNormalSkillCount

function BuffLogicAddMonsterGuardNormalSkillCount:DoLogic(notify)
  local val = self._buffComponent:GetBuffValue("CurrentNormalAtkCount") or 0
  val = val + 1
  self._buffComponent:SetBuffValue("CurrentNormalAtkCount", val)
end

_class("BuffLogicClearMonsterGuardNormalSkillCount", BuffLogicBase)
BuffLogicClearMonsterGuardNormalSkillCount = BuffLogicClearMonsterGuardNormalSkillCount

function BuffLogicClearMonsterGuardNormalSkillCount:DoLogic(notify)
  self._buffComponent:SetBuffValue("CurrentNormalAtkCount", nil)
end
