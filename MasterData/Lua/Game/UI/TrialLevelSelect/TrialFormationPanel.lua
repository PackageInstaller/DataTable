local TrialFormationPanel = class("TrialFormationPanel", BasePanel)
TrialFormationPanel._tbDefine = {
  {
    sPrefabPath = "Play_TrialLevelSelect/TrialFormationScenePanel.prefab",
    sCtrlName = "Game.UI.TrialLevelSelect.TrialFormationCtrl"
  }
}

function TrialFormationPanel:Awake()
end

function TrialFormationPanel:OnEnable(bPlayFadeIn)
end

function TrialFormationPanel:OnDisable()
end

function TrialFormationPanel:OnDestroy()
end

return TrialFormationPanel
