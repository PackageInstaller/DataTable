_class("BuffLogicChangeSkillFinalByGreyHPPercent", BuffLogicBase)
BuffLogicChangeSkillFinalByGreyHPPercent = BuffLogicChangeSkillFinalByGreyHPPercent

function BuffLogicChangeSkillFinalByGreyHPPercent:Constructor(buffInstance, logicParam)
  self._paramA = logicParam.paramA
  self._paramB = logicParam.paramB
  self._paramC = logicParam.paramC
  self._effectList = logicParam.effectList
  self._entity = buffInstance._entity
end

function BuffLogicChangeSkillFinalByGreyHPPercent:DoLogic(notify)
  local sourceEntity = self:GetEntity()
  local cAttributes = sourceEntity:Attributes()
  local maxHP = cAttributes:CalcMaxHp()
  local cBuff = sourceEntity:BuffComponent()
  local greyValue = cBuff:GetGreyHPValue(true)
  local promoteRate = greyValue / (maxHP * self._paramA + self._paramB) * self._paramC
  if promoteRate == 0 then
    return
  end
  for _, paramType in ipairs(self._effectList) do
    self._buffLogicService:ChangeSkillFinalParam(self._entity, self:GetBuffSeq(), paramType, promoteRate)
  end
end

_class("BuffLogicRemoveSkillFinalByGreyHPPercent", BuffLogicBase)
BuffLogicRemoveSkillFinalByGreyHPPercent = BuffLogicRemoveSkillFinalByGreyHPPercent

function BuffLogicRemoveSkillFinalByGreyHPPercent:Constructor(buffInstance, logicParam)
  self._entity = buffInstance._entity
  self._effectList = logicParam.effectList
end

function BuffLogicRemoveSkillFinalByGreyHPPercent:DoLogic()
  for _, paramType in ipairs(self._effectList) do
    self._buffLogicService:RemoveSkillFinalParam(self._entity, self:GetBuffSeq(), paramType)
  end
end
