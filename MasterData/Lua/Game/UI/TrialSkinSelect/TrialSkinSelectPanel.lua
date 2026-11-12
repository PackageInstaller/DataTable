local TrialSkinSelectPanel = class("TrialSkinSelectPanel", BasePanel)
TrialSkinSelectPanel._tbDefine = {
  {
    sPrefabPath = "Play_TrialSkinSelect/TrialSkinSelectPanel.prefab",
    sCtrlName = "Game.UI.TrialSkinSelect.TrialSkinSelectCtrl"
  }
}

function TrialSkinSelectPanel:Awake()
end

function TrialSkinSelectPanel:OnEnable()
end

function TrialSkinSelectPanel:OnDisable()
end

function TrialSkinSelectPanel:OnDestroy()
end

return TrialSkinSelectPanel
