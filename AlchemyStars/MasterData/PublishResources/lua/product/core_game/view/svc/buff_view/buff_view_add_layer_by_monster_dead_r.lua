_class("BuffViewAddLayerByMonsterDead", BuffViewBase)
BuffViewAddLayerByMonsterDead = BuffViewAddLayerByMonsterDead

function BuffViewAddLayerByMonsterDead:PlayView(TT)
  local result = self:GetBuffResult()
  local curMarkLayer = result:GetLayer()
  local dontDisplay = result:GetDonotDisplay()
  self._viewInstance:SetLayerCount(TT, curMarkLayer)
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
  if dontDisplay then
    return
  end
  if self._entity:HasPetPstID() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SetAccumulateNum, self._entity:PetPstID():GetPstID(), curMarkLayer)
  end
end
