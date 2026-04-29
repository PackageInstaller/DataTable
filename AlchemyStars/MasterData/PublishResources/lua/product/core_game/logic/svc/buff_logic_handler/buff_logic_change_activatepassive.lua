_class("BuffLogicChangeActivatePassive", BuffLogicBase)
BuffLogicChangeActivatePassive = BuffLogicChangeActivatePassive

function BuffLogicChangeActivatePassive:Constructor(buffInstance, logicParam)
  self._light = logicParam.light == 1
  self._forceInit = logicParam.forceInit
  self._forceInitType = logicParam.forceInitType or 1
end

function BuffLogicChangeActivatePassive:DoLogic(notify)
  local e = self._buffInstance:Entity()
  local buffResult = BuffResultChangeActivatePassive:New(self._light, self._forceInit, self._forceInitType)
  if notify and notify:GetNotifyType() == NotifyType.NotifyLayerChange then
    local layer = notify:GetLayer()
    buffResult:SetLayer(layer)
    buffResult:SetLayerName(notify:GetLayerName())
  end
  return buffResult
end
