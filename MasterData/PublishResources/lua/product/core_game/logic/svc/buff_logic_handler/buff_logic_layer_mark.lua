require("buff_logic_base")
_class("BuffLogicLayerMark", BuffLogicBase)
BuffLogicLayerMark = BuffLogicLayerMark

function BuffLogicLayerMark:Constructor(buffInstance, logicParam)
  self._maxLayer = logicParam.maxLayer or 0
  self._layer = logicParam.layer
  self._layerName = logicParam.layerName or self._buffInstance:GetBuffLayerName()
end

function BuffLogicLayerMark:DoLogic(notify)
  local ctx = self._buffInstance:Context()
  local casterEntity = ctx.casterEntity
  local casterEntityID = 0
  if casterEntity then
    casterEntityID = casterEntity:GetID()
  end
  local curMarkLayer = self._buffInstance:AddLayerCount(self._layer)
  self._buffComponent:SetBuffValue(self._layerName, curMarkLayer)
  local res = BuffResultLayerMark:New(curMarkLayer, casterEntityID)
  return res
end

function BuffLogicLayerMark:DoOverlap(logicParam, context)
  local casterEntity = context.casterEntity
  local casterEntityID = 0
  if casterEntity then
    casterEntityID = casterEntity:GetID()
  end
  local curMarkLayer = self._buffInstance:AddLayerCount(self._layer)
  self._buffComponent:SetBuffValue(self._layerName, curMarkLayer)
  local res = BuffResultLayerMark:New(curMarkLayer, casterEntityID)
  return res
end

_class("BuffLogicRemoveLayerMark", BuffLogicBase)
BuffLogicRemoveLayerMark = BuffLogicRemoveLayerMark

function BuffLogicRemoveLayerMark:Constructor(buffInstance, logicParam)
  self._layerName = logicParam.layerName or self._buffInstance:GetBuffLayerName()
end

function BuffLogicRemoveLayerMark:DoLogic(notify)
  self._buffComponent:SetBuffValue(self._layerName, 0)
  self._buffInstance:SetLayerCount(0)
  local res = BuffResultLayerMark:New(0)
  return res
end
