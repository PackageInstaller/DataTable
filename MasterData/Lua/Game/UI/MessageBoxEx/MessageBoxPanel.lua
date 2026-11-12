local MessageBoxPanel = class("MessageBoxPanel", BasePanel)
MessageBoxPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
MessageBoxPanel._bAddToBackHistory = false
MessageBoxPanel._tbDefine = {
  {
    sPrefabPath = "MessageBoxEx/MessageBoxPanel.prefab",
    sCtrlName = "Game.UI.MessageBoxEx.MessageBoxCtrl"
  }
}

function MessageBoxPanel:SetTop(goCanvas)
end

function MessageBoxPanel:Awake()
  self.bBlur = true
  self.trUIRoot = GameObject.Find("---- UI TOP ----").transform
end

function MessageBoxPanel:OnEnable()
end

function MessageBoxPanel:OnDisable()
end

function MessageBoxPanel:OnDestroy()
end

return MessageBoxPanel
