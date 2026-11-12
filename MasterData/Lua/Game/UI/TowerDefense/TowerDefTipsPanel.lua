local TowerDefTipsPanel = class("TowerDefTipsPanel", BasePanel)
TowerDefTipsPanel._bIsMainPanel = false
TowerDefTipsPanel._bAddToBackHistory = false
TowerDefTipsPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
TowerDefTipsPanel._tbDefine = {
  {
    sPrefabPath = "Play_TowerDefence/TowerDefTips.prefab",
    sCtrlName = "Game.UI.TowerDefense.TowerDefTipsCtrl"
  }
}

function TowerDefTipsPanel:Awake()
end

function TowerDefTipsPanel:OnEnable()
end

function TowerDefTipsPanel:OnDisable()
end

function TowerDefTipsPanel:OnDestroy()
end

function TowerDefTipsPanel:OnRelease()
end

return TowerDefTipsPanel
