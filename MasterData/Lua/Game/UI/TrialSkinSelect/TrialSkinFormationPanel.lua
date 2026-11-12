local TrialSkinFormationPanel = class("TrialSkinFormationPanel", BasePanel)
TrialSkinFormationPanel._tbDefine = {
  {
    sPrefabPath = "Play_TrialSkinSelect/TrialSkinFormationScenePanel.prefab",
    sCtrlName = "Game.UI.TrialSkinSelect.TrialSkinFormationCtrl"
  }
}

function TrialSkinFormationPanel:Awake()
end

function TrialSkinFormationPanel:OnEnable(bPlayFadeIn)
end

function TrialSkinFormationPanel:OnDisable()
end

function TrialSkinFormationPanel:OnDestroy()
end

return TrialSkinFormationPanel
