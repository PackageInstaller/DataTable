_class("BuffViewShowPetPowerOverdraw", BuffViewBase)
BuffViewShowPetPowerOverdraw = BuffViewShowPetPowerOverdraw

function BuffViewShowPetPowerOverdraw:PlayView(TT)
  local petPstID = self._entity:PetPstID():GetPstID()
  local ready = self._buffResult:GetReady()
  local overdraw = self._buffResult:GetOverdraw()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PetPowerOverdrawChange, petPstID, {ready = ready, overdraw = overdraw})
end
