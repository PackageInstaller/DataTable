_class("BuffViewAddLayerByScopeTargetCount", BuffViewBase)
BuffViewAddLayerByScopeTargetCount = BuffViewAddLayerByScopeTargetCount

function BuffViewAddLayerByScopeTargetCount:PlayView(TT)
  local result = self._buffResult
  local curMarkLayer = result:GetLayer()
  self._viewInstance:SetLayerCount(TT, curMarkLayer)
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
  if result:GetDonotDisplay() then
    return
  end
  if self._entity:HasPetPstID() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SetAccumulateNum, self._entity:PetPstID():GetPstID(), curMarkLayer)
  end
end

function BuffViewAddLayerByScopeTargetCount:IsNotifyMatch(notify)
  local notifyType = notify:GetNotifyType()
  if notifyType == NotifyType.TrapDead or notifyType == NotifyType.TrapShow then
    local entity = notify:GetNotifyEntity()
    local notifyEntityID
    if entity then
      notifyEntityID = entity:GetID()
    end
    local resEntityID = self._buffResult:GetNotifyEntityID()
    if notifyEntityID and resEntityID then
      return notifyEntityID == resEntityID
    else
      return false
    end
  end
  return true
end
