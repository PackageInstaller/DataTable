_class("BuffLogicAddReflexiveDamageLayer", BuffLogicBase)
BuffLogicAddReflexiveDamageLayer = BuffLogicAddReflexiveDamageLayer

function BuffLogicAddReflexiveDamageLayer:Constructor(buffInstance, logicParam)
  self._addValue = logicParam.addValue
  self._maxLayer = logicParam.maxLayer
  self._notifyType = logicParam.notifyType
end

function BuffLogicAddReflexiveDamageLayer:DoLogic(notify)
  local notifyType = notify:GetNotifyType()
  local isMatch = false
  if self._notifyType then
    for _, v in ipairs(self._notifyType) do
      if v == notifyType then
        isMatch = true
        break
      end
    end
  else
    isMatch = true
  end
  if not isMatch then
    return
  end
  local buffCom = self._entity:BuffComponent()
  local layerKey = "ReflexiveDamageLayer"
  local layer = 0
  layer = buffCom:GetBuffValue(layerKey) or 0
  if layer >= self._maxLayer then
    return
  end
  layer = layer + 1
  buffCom:SetBuffValue(layerKey, layer)
  local res = BuffResultLayer:New(layer)
  return res
end
