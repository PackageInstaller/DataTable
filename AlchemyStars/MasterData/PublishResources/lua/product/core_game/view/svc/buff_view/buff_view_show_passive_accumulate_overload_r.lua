_class("BuffViewShowPassiveAccumulateOverload", BuffViewBase)
BuffViewShowPassiveAccumulateOverload = BuffViewShowPassiveAccumulateOverload

function BuffViewShowPassiveAccumulateOverload:PlayView(TT)
  local buffResult = self._buffResult
  local isShowOverload = buffResult:IsOverLoadShow()
  local petPstID = self._entity:PetPstID():GetPstID()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowOverloadPassiveAccumulate, petPstID, isShowOverload)
end
