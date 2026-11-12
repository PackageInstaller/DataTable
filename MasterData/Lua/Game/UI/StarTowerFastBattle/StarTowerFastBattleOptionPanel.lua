local StarTowerFastBattleOptionPanel = class("StarTowerFastBattleOptionPanel", BasePanel)
StarTowerFastBattleOptionPanel._bIsMainPanel = false
StarTowerFastBattleOptionPanel._tbDefine = {
  {
    sPrefabPath = "StarTowerFastBattle/StarTowerFastBattleOptionPanel.prefab",
    sCtrlName = "Game.UI.StarTowerFastBattle.StarTowerFastBattleOptionCtrl"
  }
}

function StarTowerFastBattleOptionPanel:Awake()
  local tbParams = self:GetPanelParam()
  if type(tbParams) == "table" then
    self.bShop = tbParams[1]
    self.bMachine = tbParams[2]
    self.nMachineCount = tbParams[3]
    self.nCoinCount = tbParams[4]
    self.closeCallback = tbParams[5]
    self.nDiscount = tbParams[6]
    self.bFirstFree = tbParams[7]
    self.bLastFloor = tbParams[8]
    self.bAutoDisplay = tbParams[9] == true
  end
end

function StarTowerFastBattleOptionPanel:OnEnable()
end

function StarTowerFastBattleOptionPanel:OnDisable()
end

function StarTowerFastBattleOptionPanel:OnDestroy()
end

return StarTowerFastBattleOptionPanel
