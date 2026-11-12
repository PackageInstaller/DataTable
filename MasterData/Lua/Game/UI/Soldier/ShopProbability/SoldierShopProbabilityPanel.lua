local SoldierShopProbabilityPanel = class("SoldierShopProbabilityPanel", BasePanel)
SoldierShopProbabilityPanel._bIsMainPanel = false
SoldierShopProbabilityPanel._sSortingLayerName = AllEnum.SortingLayerName.UI
SoldierShopProbabilityPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/Level/SoldierShopProbabilityPanel.prefab",
    sCtrlName = "Game.UI.Soldier.ShopProbability.SoldierShopProbabilityCtrl"
  }
}

function SoldierShopProbabilityPanel:Awake()
end

function SoldierShopProbabilityPanel:OnEnable()
end

function SoldierShopProbabilityPanel:OnAfterEnter()
end

function SoldierShopProbabilityPanel:OnDisable()
end

function SoldierShopProbabilityPanel:OnDestroy()
end

function SoldierShopProbabilityPanel:OnRelease()
end

return SoldierShopProbabilityPanel
