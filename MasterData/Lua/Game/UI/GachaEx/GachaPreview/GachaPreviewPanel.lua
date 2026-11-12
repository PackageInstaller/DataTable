local GachaPreviewPanel = class("GachaPreviewPanel", BasePanel)
GachaPreviewPanel._bIsMainPanel = false
GachaPreviewPanel._tbDefine = {
  {
    sPrefabPath = "GachaEx/GachaCharInfoPanel.prefab",
    sCtrlName = "Game.UI.GachaEx.GachaPreview.GachaPreviewCtrl"
  }
}

function GachaPreviewPanel:Awake()
end

function GachaPreviewPanel:OnEnable()
end

function GachaPreviewPanel:OnDisable()
end

function GachaPreviewPanel:OnDestroy()
end

function GachaPreviewPanel:OnRelease()
end

return GachaPreviewPanel
