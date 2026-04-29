_class("BuffLogicSetMonsterAbsorbByLayer", BuffLogicBase)
BuffLogicSetMonsterAbsorbByLayer = BuffLogicSetMonsterAbsorbByLayer

function BuffLogicSetMonsterAbsorbByLayer:Constructor(buffInstance, logicParam)
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._oneLayerAddMulValue = logicParam.oneLayerAddMulValue or 0
  self._oneLayerAddValue = logicParam.oneLayerAddValue or 0
  self._mulBaseValue = logicParam.mulBaseValue or false
  self._buffInstance._effectList = logicParam.effectList or {}
end

function BuffLogicSetMonsterAbsorbByLayer:DoLogic()
  local e = self._buffInstance:Entity()
  local curMarkLayer = self._buffLogicService:GetBuffLayer(e, self._layerType)
  local change = 0
  if self._oneLayerAddMulValue ~= 0 then
    change = self._oneLayerAddMulValue * curMarkLayer
  end
  if self._oneLayerAddValue ~= 0 then
    change = math.floor(self._oneLayerAddValue * curMarkLayer)
  end
  for k, paramType in ipairs(self._buffInstance._effectList) do
    local effChangeValue = change
    if self._mulBaseValue then
      local baseValue = self._buffLogicService:GetMonsterSkillAbsorbBaseValue(self._entity, paramType)
      if baseValue then
        effChangeValue = baseValue * effChangeValue
      end
    end
    self._buffLogicService:ChangeMonsterSkillAbsorb(self._entity, self:GetBuffSeq(), paramType, effChangeValue)
  end
end

_class("BuffLogicRemoveMonsterAbsorbByLayer", BuffLogicBase)
BuffLogicRemoveMonsterAbsorbByLayer = BuffLogicRemoveMonsterAbsorbByLayer

function BuffLogicRemoveMonsterAbsorbByLayer:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveMonsterAbsorbByLayer:DoLogic()
  local e = self._buffInstance:Entity()
  for k, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:RemoveMonsterSkillAbsorb(self._entity, self:GetBuffSeq(), paramType)
  end
end
