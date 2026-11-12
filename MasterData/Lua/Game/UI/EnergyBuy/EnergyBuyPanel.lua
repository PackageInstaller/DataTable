local EnergyBuyPanel = class("EnergyBuyPanel", BasePanel)
EnergyBuyPanel._bIsMainPanel = false
EnergyBuyPanel._tbDefine = {
  {
    sPrefabPath = "EnergyBuy/EnergyBuyPanel.prefab",
    sCtrlName = "Game.UI.EnergyBuy.EnergyBuyCtrl"
  }
}

function EnergyBuyPanel:Awake()
  self.nPanelType = self._tbParam[1] or AllEnum.EnergyPanelType.Main
  self.mapItemData = self._tbParam[2]
  self.bBlur = self._tbParam[3]
  self.nMaxEnergy = ConfigTable.GetConfigNumber("EnergyObtainLimit")
  self.callback = self._tbParam[4]
end

return EnergyBuyPanel
