_class("BuffViewShowPowerfullRoundCountUI", BuffViewBase)
BuffViewShowPowerfullRoundCountUI = BuffViewShowPowerfullRoundCountUI

function BuffViewShowPowerfullRoundCountUI:PlayView(TT)
  local bShow = self._buffResult:IsShow()
  local resDic = self._buffResult:GetResDic()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowPowerfullRoundCountUI, self._entity:PetPstID():GetPstID(), bShow, resDic)
end
