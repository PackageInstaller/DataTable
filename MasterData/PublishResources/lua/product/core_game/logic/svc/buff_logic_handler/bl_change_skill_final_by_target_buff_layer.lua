_class("BuffLogicChangeSkillFinalByTargetBuffLayer", BuffLogicBase)
BuffLogicChangeSkillFinalByTargetBuffLayer = BuffLogicChangeSkillFinalByTargetBuffLayer

function BuffLogicChangeSkillFinalByTargetBuffLayer:Constructor(buffInstance, logicParam)
  self._buffInstance._effectList = logicParam.effectList
  self._buffID = logicParam.buffID
  self._minValue = logicParam.minValue or 0
  self._oneLayerValue = logicParam.oneLayerValue or 0
end

function BuffLogicChangeSkillFinalByTargetBuffLayer:DoLogic(notify)
  local casterEntity = self._buffInstance:Entity()
  local defenderEntity = notify:GetDefenderEntity()
  if not defenderEntity then
    return
  end
  local buffComponent = defenderEntity:BuffComponent()
  if not buffComponent then
    return
  end
  local buffInstance = buffComponent:GetBuffById(self._buffID)
  if not buffInstance then
    return
  end
  local layer = buffInstance:GetLayerCount()
  local changeValue = 0
  changeValue = self._minValue + self._oneLayerValue * layer
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:ChangeSkillFinalParam(casterEntity, self:GetBuffSeq(), paramType, changeValue)
  end
end

_class("BuffLogicRemoveSkillFinalByTargetBuffLayer", BuffLogicBase)
BuffLogicRemoveSkillFinalByTargetBuffLayer = BuffLogicRemoveSkillFinalByTargetBuffLayer

function BuffLogicRemoveSkillFinalByTargetBuffLayer:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveSkillFinalByTargetBuffLayer:DoLogic()
  local casterEntity = self._buffInstance:Entity()
  if not casterEntity then
    return
  end
  for _, paramType in pairs(self._buffInstance._effectList) do
    self._buffLogicService:RemoveSkillFinalParam(casterEntity, self:GetBuffSeq(), paramType)
  end
  return true
end
