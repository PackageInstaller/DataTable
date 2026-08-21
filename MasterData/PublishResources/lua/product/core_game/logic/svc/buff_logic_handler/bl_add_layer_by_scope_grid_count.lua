require("buff_logic_base")
_class("BuffLogicAddLayerByScopeGridCount", BuffLogicBase)
BuffLogicAddLayerByScopeGridCount = BuffLogicAddLayerByScopeGridCount

function BuffLogicAddLayerByScopeGridCount:Constructor(buffInstance, logicParam)
  self._gridType = logicParam.gridType
  self._perGridCount = logicParam.perGridCount
  self._perLayerCount = logicParam.perLayerCount
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._buffInstance._buffLayerName = self._buffInstance._buffsvc:GetBuffLayerName(self._layerType)
  self._dontDisplay = logicParam.dontDisplay
end

function BuffLogicAddLayerByScopeGridCount:DoLogic(notify)
  if notify:GetNotifyType() ~= NotifyType.ActiveSkillAttackStart then
    return
  end
  local e = self._buffInstance:Entity()
  local boardSvc = self._world:GetService("BoardLogic")
  local scopeResult = notify:GetScopeResult()
  local scopeRange = scopeResult:GetAttackRange()
  local gridCount = 0
  for i, pos in ipairs(scopeRange) do
    if boardSvc:GetPieceType(pos) == self._gridType then
      gridCount = gridCount + 1
    end
  end
  local layerAdd = 0
  while gridCount >= self._perGridCount do
    gridCount = gridCount - self._perGridCount
    layerAdd = layerAdd + self._perLayerCount
  end
  local svc = self._world:GetService("BuffLogic")
  local curMarkLayer, buffinst = svc:AddBuffLayer(e, self._layerType, layerAdd)
  local buffResult = BuffResultAddLayer:New(curMarkLayer, self._dontDisplay)
  local layerName = svc:GetBuffLayerName(self._layerType)
  local totalLayerCount = svc:GetBuffTotalLayer(self._entity, layerName)
  buffResult:SetBuffSeq(buffinst:BuffSeq())
  buffResult:SetTotalLayer(totalLayerCount)
  return buffResult
end
