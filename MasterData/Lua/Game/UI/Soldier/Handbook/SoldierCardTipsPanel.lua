local SoldierCardTipsPanel = class("SoldierCardTipsPanel", BasePanel)
SoldierCardTipsPanel._bIsMainPanel = false
SoldierCardTipsPanel._sSortingLayerName = AllEnum.SortingLayerName.UI
SoldierCardTipsPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/Tips/SoldierCardTipsPanel.prefab",
    sCtrlName = "Game.UI.Soldier.Handbook.SoldierCardTipsCtrl"
  }
}

function SoldierCardTipsPanel:Awake()
end

function SoldierCardTipsPanel:OnEnable()
end

function SoldierCardTipsPanel:OnAfterEnter()
end

function SoldierCardTipsPanel:OnDisable()
end

function SoldierCardTipsPanel:OnDestroy()
end

function SoldierCardTipsPanel:OnRelease()
end

return SoldierCardTipsPanel
