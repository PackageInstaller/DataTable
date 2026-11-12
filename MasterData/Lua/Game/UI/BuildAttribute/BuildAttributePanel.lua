local BuildAttributePanel = class("BuildAttributePanel", BasePanel)
BuildAttributePanel._bIsMainPanel = false
BuildAttributePanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
BuildAttributePanel._tbDefine = {
  {
    sPrefabPath = "BuildAttribute/BuildAttributePanel.prefab",
    sCtrlName = "Game.UI.BuildAttribute.BuildAttributeCtrl"
  }
}

function BuildAttributePanel:Awake()
end

function BuildAttributePanel:OnEnable()
end

function BuildAttributePanel:OnDisable()
end

function BuildAttributePanel:OnDestroy()
end

return BuildAttributePanel
