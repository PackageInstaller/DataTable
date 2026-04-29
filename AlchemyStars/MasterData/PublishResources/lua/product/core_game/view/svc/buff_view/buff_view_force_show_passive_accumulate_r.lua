_class("BuffViewForceShowPassiveAccumulate", BuffViewBase)
BuffViewForceShowPassiveAccumulate = BuffViewForceShowPassiveAccumulate

function BuffViewForceShowPassiveAccumulate:PlayView(TT)
  local buffResult = self._buffResult
  local buffLayerList = buffResult:GetBuffLayerList()
  local forceInitType = buffResult:GetForceInitType()
  local maxCount = buffResult:GetMaxLayerCount()
  local petPstID = self._entity:PetPstID():GetPstID()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ForceInitPassiveAccumulate, petPstID, buffLayerList, forceInitType, maxCount)
end
