local FilterPopupPanel = class("FilterPopupPanel", BasePanel)
FilterPopupPanel._bIsMainPanel = false
FilterPopupPanel._tbDefine = {
  {
    sPrefabPath = "Filter/FilterPopupPanel.prefab",
    sCtrlName = "Game.UI.Filter.FilterPopupCtrl"
  }
}

function FilterPopupPanel:Awake()
end

function FilterPopupPanel:OnEnable()
end

function FilterPopupPanel:OnDisable()
end

function FilterPopupPanel:OnDestroy()
end

return FilterPopupPanel
