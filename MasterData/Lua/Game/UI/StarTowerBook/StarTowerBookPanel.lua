local StarTowerBookPanel = class("StarTowerBookPanel", BasePanel)
StarTowerBookPanel._tbDefine = {
  {
    sPrefabPath = "StarTowerBook/StarTowerBookPanel.prefab",
    sCtrlName = "Game.UI.StarTowerBook.StarTowerBookCtrl"
  }
}

function StarTowerBookPanel:Awake()
  self.nPanelType = 0
end

function StarTowerBookPanel:OnEnable()
end

function StarTowerBookPanel:OnAfterEnter()
end

function StarTowerBookPanel:OnDisable()
end

function StarTowerBookPanel:OnDestroy()
end

function StarTowerBookPanel:OnRelease()
end

return StarTowerBookPanel
