_class("BuffLogicAddLayerShield", BuffLogicBase)
BuffLogicAddLayerShield = BuffLogicAddLayerShield

function BuffLogicAddLayerShield:Constructor(buffInstance, logicParam)
  self._layer = logicParam.layer
end

function BuffLogicAddLayerShield:DoLogic(notify)
  self._buffLogicService:AddLayerShield(self._buffInstance, self._entity, self._layer)
  local newLayer = self._buffInstance:GetLayerCount()
  Log.debug("Logic_AddLayerShield ", "entityID=", self._entity:GetID(), " layerCount=", newLayer)
  local buffResult = BuffResultAddLayer:New(newLayer)
  return buffResult
end

function BuffLogicAddLayerShield:DoOverlap(logicParam)
  return self:DoLogic()
end

_class("BuffLogicRemoveLayerShield", BuffLogicBase)
BuffLogicRemoveLayerShield = BuffLogicRemoveLayerShield

function BuffLogicRemoveLayerShield:Constructor(_, logicParam)
  self._layer = logicParam.layer
  self._dontUnload = logicParam.dontUnload
end

function BuffLogicRemoveLayerShield:DoLogic()
  local maxLayer = self._buffInstance:GetLayerCount()
  local subLayer = self._layer
  if not self._layer then
    local currentLayer = self._buffInstance:GetLayerCount()
    subLayer = currentLayer
  end
  if maxLayer < subLayer then
    subLayer = maxLayer
  end
  subLayer = subLayer * -1
  local layer = self._buffInstance:AddLayerCount(subLayer)
  if layer == 0 and not self._dontUnload then
    self._buffInstance:Unload(NTBuffUnload:New())
  end
  Log.debug("Logic_RemoveLayerShield ", "entityID=", self._entity:GetID(), " layerCount=", layer)
  local buffResult = BuffResultAddLayer:New(layer)
  return buffResult
end

function BuffLogicRemoveLayerShield:DoOverlap()
end
