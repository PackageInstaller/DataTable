_class("BuffLogicChangeSkillIncreaseWithSan", BuffLogicBase)
BuffLogicChangeSkillIncreaseWithSan = BuffLogicChangeSkillIncreaseWithSan

function BuffLogicChangeSkillIncreaseWithSan:Constructor(buffInstance, logicParam)
  self._maxValue = logicParam.maxValue or 0
  self._changeValue = logicParam.changeValue or 0
  self._baseValue = logicParam.baseValue or 0
  self._buffInstance._effectList = logicParam.effectList
  self._entity = buffInstance._entity
end

function BuffLogicChangeSkillIncreaseWithSan:DoLogic()
  local e = self._buffInstance:Entity()
  local lsvcFeature = self._world:GetService("FeatureLogic")
  local curSan = lsvcFeature:GetSanValue()
  if not curSan or curSan == -1 then
    return
  end
  local changeValue = self._maxValue - math.abs(curSan - self._baseValue) * self._changeValue
  if changeValue < 0 then
    changeValue = 0
  end
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:RemoveSkillIncrease(self._entity, self._buffInstance._buffSeq, paramType)
    if changeValue ~= 0 then
      self._buffLogicService:ChangeSkillIncrease(self._entity, self._buffInstance._buffSeq, paramType, changeValue)
    end
  end
end

_class("BuffLogicRemoveSkillIncreaseWithSan", BuffLogicBase)
BuffLogicRemoveSkillIncreaseWithSan = BuffLogicRemoveSkillIncreaseWithSan

function BuffLogicRemoveSkillIncreaseWithSan:Constructor(buffInstance, logicParam)
  self._entity = buffInstance._entity
end

function BuffLogicRemoveSkillIncreaseWithSan:DoLogic()
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:RemoveSkillIncrease(self._entity, self._buffInstance:BuffSeq(), paramType)
  end
end
