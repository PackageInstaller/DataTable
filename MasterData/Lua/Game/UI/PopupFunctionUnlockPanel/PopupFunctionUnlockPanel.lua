local PopupFunctionUnlockPanel = class("PopupFunctionUnlockPanel", BasePanel)
PopupFunctionUnlockPanel._bIsMainPanel = false
PopupFunctionUnlockPanel._bAddToBackHistory = false
PopupFunctionUnlockPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
PopupFunctionUnlockPanel._tbDefine = {
  {
    sPrefabPath = "PopupFunctionUnlock/PopupFunctionUnlockPanel.prefab",
    sCtrlName = "Game.UI.PopupFunctionUnlockPanel.PopupFunctionUnlockCtrl"
  }
}

function PopupFunctionUnlockPanel:Awake()
end

function PopupFunctionUnlockPanel:OnEnable()
end

function PopupFunctionUnlockPanel:OnDisable()
end

function PopupFunctionUnlockPanel:OnDestroy()
end

function PopupFunctionUnlockPanel:OnRelease()
end

return PopupFunctionUnlockPanel
