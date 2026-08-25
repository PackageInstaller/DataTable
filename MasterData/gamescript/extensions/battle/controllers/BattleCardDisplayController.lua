local BattleCardDisplayController = NewClass("BattleCardDisplayController", BaseController)

function BattleCardDisplayController:OnInit()
  EventMgr.Instance.ShowBattleCardDisplay:RegisterEvent(System.fn(self, self.OnShowBattleCardDisplay))
  EventMgr.Instance.HideBattleCardDisplay:RegisterEvent(System.fn(self, self.OnHideBattleCardDisplay))
  EventMgr.Instance.CloseBattleCardDisplay:RegisterEvent(System.fn(self, self.OnCloseBattleCardDisplay))
end

function BattleCardDisplayController:OnReset()
end

function BattleCardDisplayController:OnShowBattleCardDisplay(card, battleTouchPos, extraParams)
  if not card then
    return
  end
  local panel = UIManager.Instance:GetWindow(Urls.FuncBattleCardDisplayPanel)
  if panel then
    panel:ShowOrRefresh(card, battleTouchPos, extraParams)
    return
  end
  UIManager.Instance:Reopen(Urls.FuncBattleCardDisplayPanel, card, battleTouchPos, extraParams)
end

function BattleCardDisplayController:OnHideBattleCardDisplay()
  local panel = UIManager.Instance:GetWindow(Urls.FuncBattleCardDisplayPanel)
  if not panel then
    return
  end
  if panel:IsRendering() == false then
    return
  end
  panel:HideForReuse()
end

function BattleCardDisplayController:OnCloseBattleCardDisplay()
  UIManager.Instance:CloseByUrl(Urls.FuncBattleCardDisplayPanel)
end

return BattleCardDisplayController
