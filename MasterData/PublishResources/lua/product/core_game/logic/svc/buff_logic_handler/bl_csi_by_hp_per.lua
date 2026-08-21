_class("BuffLogicChangeSkillIncreaseByHPPercent", BuffLogicBase)
BuffLogicChangeSkillIncreaseByHPPercent = BuffLogicChangeSkillIncreaseByHPPercent
local ChangeSkillIncreaseByHPPercentCalcType = {CurrentHP = 1, LossHP = 2}
_enum("ChangeSkillIncreaseByHPPercentCalcType", ChangeSkillIncreaseByHPPercentCalcType)

function BuffLogicChangeSkillIncreaseByHPPercent:Constructor(buffInstance, logicParam)
  self._buffInstance._effectList = logicParam.effectList
  self._maxSkillIncrease = logicParam.maxSkillIncrease
  self._entity = buffInstance._entity
  self._hpCalcType = logicParam.hpCalcType or ChangeSkillIncreaseByHPPercentCalcType.CurrentHP
end

function BuffLogicChangeSkillIncreaseByHPPercent:DoLogic(notify)
  local e = self._entity
  local battleSvc = self._world:GetService("Battle")
  local curHP, maxHp = battleSvc:GetCasterHP(e)
  local hpPercent
  if self._hpCalcType == ChangeSkillIncreaseByHPPercentCalcType.CurrentHP then
    hpPercent = curHP / maxHp
  elseif self._hpCalcType == ChangeSkillIncreaseByHPPercentCalcType.LossHP then
    hpPercent = 1 - curHP / maxHp
  end
  local changeValue = hpPercent * self._maxSkillIncrease
  for _, paramType in ipairs(self._buffInstance._effectList) do
    if changeValue ~= 0 then
      self._buffLogicService:ChangeSkillIncrease(self._entity, self._buffInstance._buffSeq, paramType, changeValue)
    end
  end
end

_class("BuffLogicRemoveChangeSkillIncreaseByHPPercent", BuffLogicBase)
BuffLogicRemoveChangeSkillIncreaseByHPPercent = BuffLogicRemoveChangeSkillIncreaseByHPPercent

function BuffLogicRemoveChangeSkillIncreaseByHPPercent:Constructor(buffInstance, logicParam)
  self._entity = buffInstance._entity
end

function BuffLogicRemoveChangeSkillIncreaseByHPPercent:DoLogic()
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:RemoveSkillIncrease(self._entity, self._buffInstance:BuffSeq(), paramType)
  end
end
