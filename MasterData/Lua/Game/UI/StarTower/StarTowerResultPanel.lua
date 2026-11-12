local StarTowerResultPanel = class("StarTowerResultPanel", BasePanel)
StarTowerResultPanel._bAddToBackHistory = false
StarTowerResultPanel._tbDefine = {
  {
    sPrefabPath = "StarTower/StarTowerResultPanel.prefab",
    sCtrlName = "Game.UI.StarTower.StarTowerResultCtrl"
  }
}

function StarTowerResultPanel:Awake()
end

function StarTowerResultPanel:OnEnable()
end

function StarTowerResultPanel:OnDisable()
end

function StarTowerResultPanel:OnDestroy()
end

return StarTowerResultPanel
