local InfinityTowerSelectTowerPanel = class("InfinityTowerSelectTowerPanel", BasePanel)
InfinityTowerSelectTowerPanel._tbDefine = {
  {
    sPrefabPath = "InfinityTower/InfinityTowerSelectT.prefab",
    sCtrlName = "Game.UI.InfinityTower.InfinityTowerSelectTowerCtrl"
  }
}

function InfinityTowerSelectTowerPanel:Awake()
  self.openTowerId = nil
  local tbParam = self:GetPanelParam()
  if tbParam[1] then
    self.openTowerId = tbParam[1]
  end
end

function InfinityTowerSelectTowerPanel:OnEnable()
end

function InfinityTowerSelectTowerPanel:OnDisable()
end

function InfinityTowerSelectTowerPanel:OnDestroy()
end

function InfinityTowerSelectTowerPanel:OnRelease()
end

return InfinityTowerSelectTowerPanel
