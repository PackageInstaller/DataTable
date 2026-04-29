_class("BuffLogicChangeSkillIncreaseByLayerMark", BuffLogicBase)
BuffLogicChangeSkillIncreaseByLayerMark = BuffLogicChangeSkillIncreaseByLayerMark

function BuffLogicChangeSkillIncreaseByLayerMark:Constructor(buffInstance, logicParam)
  self._buffInstance._effectList = logicParam.effectList
  self._minValue = logicParam.minValue or 0
  self._oneLayerValue = logicParam.oneLayerValue or 0
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._useLayerCountRatio = logicParam.useLayerCountRatio or 0
  self._maxLayerCount = logicParam.maxLayerCount or 100
  self._multiValue = logicParam.multiValue or 1
  self._ratioPower = logicParam.ratioPower or 1
end

function BuffLogicChangeSkillIncreaseByLayerMark:DoLogic()
  local casterEntity = self._entity
  local changeValue = 0
  local svc = self._world:GetService("BuffLogic")
  local curMarkLayer = svc:GetBuffLayer(self._entity, self._layerType)
  if self._useLayerCountRatio == 1 then
    changeValue = self._multiValue * (curMarkLayer / self._maxLayerCount) ^ self._ratioPower
  else
    changeValue = self._minValue + self._oneLayerValue * curMarkLayer
  end
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:ChangeSkillIncrease(casterEntity, self:GetBuffSeq(), paramType, changeValue)
  end
end

_class("BuffLogicRemoveSkillIncreaseByLayerMask", BuffLogicBase)
BuffLogicRemoveSkillIncreaseByLayerMask = BuffLogicRemoveSkillIncreaseByLayerMask

function BuffLogicRemoveSkillIncreaseByLayerMask:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveSkillIncreaseByLayerMask:DoLogic()
  local casterEntity = self._entity
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:RemoveSkillIncrease(casterEntity, self:GetBuffSeq(), paramType)
  end
end
