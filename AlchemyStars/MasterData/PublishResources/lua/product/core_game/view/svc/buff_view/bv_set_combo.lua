_class("BuffViewSetCombo", BuffViewBase)
BuffViewSetCombo = BuffViewSetCombo

function BuffViewSetCombo:PlayView(TT)
  local result = self._buffResult
  local renderBattleSvc = self._world:GetService("RenderBattle")
  local curComboNum = renderBattleSvc:GetComboNum()
  curComboNum = curComboNum + result:GetChangeValue()
  renderBattleSvc:SetComboNum(curComboNum)
  Log.info("SetComboNum = ", curComboNum, " ChangeValue=", result:GetChangeValue(), " result:GetPos() ", result:GetPos())
  GameGlobal.EventDispatcher():Dispatch(GameEventType.DisplayCombo, curComboNum)
end

function BuffViewSetCombo:IsNotifyMatch(notify)
  local result = self._buffResult
  if notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveEnd and result:GetPos() == notify:GetPos() then
    return true
  end
  return false
end
