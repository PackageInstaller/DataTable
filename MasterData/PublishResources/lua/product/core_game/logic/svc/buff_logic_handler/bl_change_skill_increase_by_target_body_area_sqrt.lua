_class("BuffLogicChangeSkillIncreaseByTargetBodyAreaSqrt", BuffLogicBase)
BuffLogicChangeSkillIncreaseByTargetBodyAreaSqrt = BuffLogicChangeSkillIncreaseByTargetBodyAreaSqrt

function BuffLogicChangeSkillIncreaseByTargetBodyAreaSqrt:Constructor(buffInstance, logicParam)
  self._buffInstance._effectList = logicParam.effectList
end

function BuffLogicChangeSkillIncreaseByTargetBodyAreaSqrt:DoLogic(notify)
  if not notify.GetDefenderEntity then
    return
  end
  local defenderEntity = notify:GetDefenderEntity()
  local defenderPos = defenderEntity:GetGridPosition()
  local bodyAreaCmpt = defenderEntity:BodyArea()
  if not bodyAreaCmpt then
    return
  end
  local areaCount = bodyAreaCmpt:GetAreaCount()
  local changeValue = math.sqrt(areaCount)
  local tmpVal = changeValue * 10
  local f = math.floor(tmpVal)
  if f == tmpVal then
    tmpVal = f
  else
    tmpVal = math.floor(tmpVal + 0.5)
  end
  changeValue = tmpVal / 10
  changeValue = changeValue - 1
  if changeValue < 0 then
    changeValue = 0
  end
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:ChangeSkillIncrease(self._entity, self:GetBuffSeq(), paramType, changeValue)
  end
end

_class("BuffLogicRemoveSkillIncreaseByTargetBodyAreaSqrt", BuffLogicBase)
BuffLogicRemoveSkillIncreaseByTargetBodyAreaSqrt = BuffLogicRemoveSkillIncreaseByTargetBodyAreaSqrt

function BuffLogicRemoveSkillIncreaseByTargetBodyAreaSqrt:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveSkillIncreaseByTargetBodyAreaSqrt:DoLogic()
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:RemoveSkillIncrease(self._entity, self:GetBuffSeq(), paramType)
  end
end
