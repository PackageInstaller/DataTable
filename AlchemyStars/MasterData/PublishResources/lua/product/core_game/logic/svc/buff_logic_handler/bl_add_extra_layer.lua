_class("BuffLogicAddExtraLayer", BuffLogicBase)
BuffLogicAddExtraLayer = BuffLogicAddExtraLayer

function BuffLogicAddExtraLayer:Constructor(buffInstance, logicParam)
  self._extraProb = logicParam.extraProb * 100
  self._extraRate = logicParam.extraRate
  self._fullProb = logicParam.fullProb * 100
  self._fullVal = logicParam.fullVal
end

function BuffLogicAddExtraLayer:DoLogic(notify)
  local lsvcRandom = self._world:GetService("RandomLogic")
  local addedLayer = notify:GetChangeLayer()
  local entity = notify:GetNotifyEntity()
  local finalExtraLayer = 0
  local doublingRandom = lsvcRandom:LogicRand(1, 100)
  if doublingRandom <= self._extraProb then
    finalExtraLayer = self._extraRate * addedLayer
  end
  local isSetInsteadOfAdd = false
  local fullRandom = lsvcRandom:LogicRand(1, 100)
  if fullRandom <= self._fullProb then
    finalExtraLayer = self._fullVal
    isSetInsteadOfAdd = true
  end
  if 0 < finalExtraLayer then
    local lsvcBuff = self._buffLogicService
    local layerType = notify:GetLayerType()
    local oldBuffLayer = lsvcBuff:GetBuffLayer(entity, layerType)
    local finalLayer, instance
    if isSetInsteadOfAdd then
      finalLayer, instance = lsvcBuff:SetBuffLayer(entity, layerType, finalExtraLayer)
    else
      finalLayer, instance = lsvcBuff:AddBuffLayer(entity, layerType, finalExtraLayer)
    end
    if not instance then
      return
    end
    local buffSeq = instance:BuffSeq()
    local result = BuffResultAddExtraLayer:New(entity, layerType, finalExtraLayer, finalLayer, buffSeq, oldBuffLayer)
    result.__oldFinalLayer = oldBuffLayer
    result:SaveNotifyData(notify)
    return result
  end
end
