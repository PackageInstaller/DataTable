local StarTowerTokenBuyPanel = class("StarTowerTokenBuyPanel", BasePanel)
StarTowerTokenBuyPanel._bIsMainPanel = false
StarTowerTokenBuyPanel._tbDefine = {
  {
    sPrefabPath = "StarTowerFastBattle/StarTowerTokenBuyPanel.prefab",
    sCtrlName = "Game.UI.StarTowerFastBattle.StarTowerTokenBuyCtrl"
  }
}

function StarTowerTokenBuyPanel:Awake()
  self.nPanelType = self._tbParam[1] or AllEnum.TokenBuyPanelType.Main
  self.mapItemData = self._tbParam[2]
  self.bBlur = self._tbParam[3]
  self.nMaxToken = ConfigTable.GetConfigNumber("TowerVitaEnergyMax")
  self.callback = self._tbParam[4]
end

function StarTowerTokenBuyPanel:JumpToRecharge()
  if ConfigTable.GetConfigNumber("IsShowComBtn") ~= 1 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    return
  end
  if self.callback ~= nil then
    self.callback()
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.StarTowerTokenBuyPanel)
  EventManager.Hit(EventId.ClosePanel, PanelId.StarTowerAutoDecisionSettingPanel)
  
  local function func_OpenRecharge()
    EventManager.Hit(EventId.OpenPanel, PanelId.Mall, AllEnum.MallToggle.Gem)
  end
  
  if PanelManager.GetCurPanelId() == PanelId.StarTowerFastBattle then
    EventManager.Hit("StarTowerFastBattleLeaveForRecharge", func_OpenRecharge)
  else
    func_OpenRecharge()
  end
end

return StarTowerTokenBuyPanel
