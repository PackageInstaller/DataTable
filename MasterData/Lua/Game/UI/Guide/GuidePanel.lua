local GuidePanel = class("GuidePanel", BasePanel)
GuidePanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
GuidePanel._bAddToBackHistory = false
GuidePanel._tbDefine = {
  {
    sPrefabPath = "Guide/GuidePanel.prefab",
    sCtrlName = "Game.UI.Guide.GuideCtrl"
  }
}

function GuidePanel:Awake()
end

function GuidePanel:OnEnable()
end

function GuidePanel:OnDisable()
end

function GuidePanel:OnDestroy()
end

return GuidePanel
