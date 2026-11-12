local DiscPreviewPanel = class("DiscPreviewPanel", BasePanel)
DiscPreviewPanel._bIsMainPanel = false
DiscPreviewPanel._tbDefine = {
  {
    sPrefabPath = "DiscSkill/DiscPreviewPanel.prefab",
    sCtrlName = "Game.UI.DiscSkill.DiscPreviewCtrl"
  }
}

function DiscPreviewPanel:Awake()
end

function DiscPreviewPanel:OnEnable()
end

function DiscPreviewPanel:OnDisable()
end

function DiscPreviewPanel:OnDestroy()
end

return DiscPreviewPanel
