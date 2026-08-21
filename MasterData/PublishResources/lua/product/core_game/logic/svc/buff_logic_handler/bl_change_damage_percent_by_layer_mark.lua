_class("BuffLogicChangeDamagePercentByLayerMark", BuffLogicBase)
BuffLogicChangeDamagePercentByLayerMark = BuffLogicChangeDamagePercentByLayerMark

function BuffLogicChangeDamagePercentByLayerMark:Constructor(buffInstance, logicParam)
  self._buffInstance._effectList = logicParam.effectList
  self._minValue = logicParam.minValue or 0
  self._oneLayerValue = logicParam.oneLayerValue or 0
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._calcDefenderBuff = logicParam.calcDefenderBuff or 0
end

function BuffLogicChangeDamagePercentByLayerMark:DoLogic(notify)
  local casterEntity = self._entity
  if not casterEntity then
    return
  end
  local calcBuffTargetEntity = self._entity
  if self._calcDefenderBuff == 1 and notify.GetDefenderEntity then
    calcBuffTargetEntity = notify:GetDefenderEntity()
  end
  local changeValue = 0
  local svc = self._world:GetService("BuffLogic")
  local curMarkLayer = svc:GetBuffLayer(calcBuffTargetEntity, self._layerType)
  changeValue = self._minValue + self._oneLayerValue * curMarkLayer
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:ChangeSkillParam(casterEntity, self:GetBuffSeq(), paramType, changeValue)
  end
end

_class("BuffLogicRemoveDamagePercentByLayerMark", BuffLogicBase)
BuffLogicRemoveDamagePercentByLayerMark = BuffLogicRemoveDamagePercentByLayerMark

function BuffLogicRemoveDamagePercentByLayerMark:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveDamagePercentByLayerMark:DoLogic()
  local context = self._buffInstance:Context()
  if not context then
    return
  end
  local casterEntity = context.casterEntity
  if not casterEntity then
    return
  end
  if not self._buffInstance._effectList then
    return
  end
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:RemoveSkillParam(casterEntity, self:GetBuffSeq(), paramType)
  end
  return true
end
