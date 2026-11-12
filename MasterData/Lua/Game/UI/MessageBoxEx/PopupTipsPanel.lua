local PopupTipsPanel = class("PopupTipsPanel", BasePanel)
PopupTipsPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
PopupTipsPanel._bAddToBackHistory = false
PopupTipsPanel._tbDefine = {
  {
    sPrefabPath = "PopupTips/PopupTipsPanel.prefab",
    sCtrlName = "Game.UI.MessageBoxEx.PopupTipsCtrl"
  }
}

function PopupTipsPanel:Awake()
end

function PopupTipsPanel:OnEnable()
end

function PopupTipsPanel:OnDisable()
end

function PopupTipsPanel:OnDestroy()
end

return PopupTipsPanel
