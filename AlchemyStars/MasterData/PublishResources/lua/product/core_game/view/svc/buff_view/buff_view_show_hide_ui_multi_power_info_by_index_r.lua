_class("BuffViewShowHideUiMultiPowerInfoByIndex", BuffViewBase)
BuffViewShowHideUiMultiPowerInfoByIndex = BuffViewShowHideUiMultiPowerInfoByIndex

function BuffViewShowHideUiMultiPowerInfoByIndex:PlayView(TT)
  local pstId = self._buffResult:GetPetPstID()
  local uiIndex = self._buffResult:GetUiIndex()
  local bShow = self._buffResult:GetIsShow()
  GameGlobal:EventDispatcher():Dispatch(GameEventType.ShowHideUiMultiPowerInfoByIndex, pstId, uiIndex, bShow)
end
