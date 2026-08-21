require("buff_logic_base")
_class("BuffLogicChangeTargetDefenceByLayer", BuffLogicBase)
BuffLogicChangeTargetDefenceByLayer = BuffLogicChangeTargetDefenceByLayer

function BuffLogicChangeTargetDefenceByLayer:Constructor(buffInstance, logicParam)
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._oneLayerAddMulValue = logicParam.oneLayerAddMulValue or 0
  self._oneLayerAddValue = logicParam.oneLayerAddValue or 0
  self._checkTargetBuff = logicParam.checkTargetBuff or 0
  self._minMulValue = logicParam.minMulValue
  self._maxMulValue = logicParam.maxMulValue
end

function BuffLogicChangeTargetDefenceByLayer:DoLogic(notify)
  local defenderEntity = notify:GetDefenderEntity()
  if not (defenderEntity and defenderEntity:Attributes()) or defenderEntity:HasDeadMark() then
    return false
  end
  local buffOwner = self._buffInstance:Entity()
  if self._checkTargetBuff == 1 then
    buffOwner = defenderEntity
  end
  if not defenderEntity:MonsterID() then
    return false
  end
  local curMarkLayer = self._buffLogicService:GetBuffLayer(buffOwner, self._layerType) or 0
  if curMarkLayer == 0 then
    return false
  end
  if self._oneLayerAddMulValue ~= 0 then
    local change = self._oneLayerAddMulValue * curMarkLayer
    change = self:_CalcValueLimit(change)
    self._buffLogicService:ChangeBaseDefence(defenderEntity, self:GetBuffSeq(), ModifyBaseDefenceType.DefencePercentage, change)
  end
  if self._oneLayerAddValue ~= 0 then
    local change = math.floor(self._oneLayerAddValue * curMarkLayer)
    change = self:_CalcValueLimit(change)
    self._buffLogicService:ChangeBaseDefence(defenderEntity, self:GetBuffSeq(), ModifyBaseDefenceType.DefenceConstantFix, change)
  end
end

function BuffLogicChangeTargetDefenceByLayer:_CalcValueLimit(value)
  if self._maxMulValue and value > self._maxMulValue then
    value = self._maxMulValue
  end
  if self._minMulValue and value < self._minMulValue then
    value = self._minMulValue
  end
  return value
end

_class("BuffLogicRemoveChangeTargetDefenceByLayer", BuffLogicBase)
BuffLogicRemoveChangeTargetDefenceByLayer = BuffLogicRemoveChangeTargetDefenceByLayer

function BuffLogicRemoveChangeTargetDefenceByLayer:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveChangeTargetDefenceByLayer:DoLogic(notify)
  local defenderEntity = notify:GetDefenderEntity()
  if not (defenderEntity and defenderEntity:Attributes()) or defenderEntity:HasDeadMark() then
    return
  end
  self._buffLogicService:RemoveBaseDefence(defenderEntity, self:GetBuffSeq(), ModifyBaseDefenceType.DefencePercentage)
  self._buffLogicService:RemoveBaseDefence(defenderEntity, self:GetBuffSeq(), ModifyBaseDefenceType.DefenceConstantFix)
end
