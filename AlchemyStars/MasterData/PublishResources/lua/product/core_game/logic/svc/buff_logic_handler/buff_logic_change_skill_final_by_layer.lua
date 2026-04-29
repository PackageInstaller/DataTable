_class("BuffLogicChangeSkillFinalByLayer", BuffLogicBase)
BuffLogicChangeSkillFinalByLayer = BuffLogicChangeSkillFinalByLayer

function BuffLogicChangeSkillFinalByLayer:Constructor(buffInstance, logicParam)
  self._buffInstance._effectList = logicParam.effectList
  self._oneLayerValue = logicParam.oneLayerValue or 0
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._calcLayerMax = logicParam.calcLayerMax or 0
  self._useTeamLayer = logicParam.useTeamLayer or 0
  self._baseValue = logicParam.baseValue
end

function BuffLogicChangeSkillFinalByLayer:DoLogic()
  local svc = self._world:GetService("BuffLogic")
  local layerEntity = self._entity
  if self._useTeamLayer == 1 then
    layerEntity = self._world:Player():GetCurrentTeamEntity()
  end
  local layer = svc:GetBuffLayer(layerEntity, self._layerType)
  if self._calcLayerMax > 0 and layer > self._calcLayerMax then
    layer = self._calcLayerMax
  end
  local changeValue = 0
  changeValue = self._oneLayerValue * layer
  if self._baseValue then
    changeValue = changeValue + self._baseValue - 1
  end
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:ChangeSkillFinalParam(self._entity, self:GetBuffSeq(), paramType, changeValue)
  end
end

_class("BuffLogicRemoveSkillFinalByLayer", BuffLogicBase)
BuffLogicRemoveSkillFinalByLayer = BuffLogicRemoveSkillFinalByLayer

function BuffLogicRemoveSkillFinalByLayer:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveSkillFinalByLayer:DoLogic()
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:RemoveSkillFinalParam(self._entity, self:GetBuffSeq(), paramType)
  end
end
