local TrialResultPanel = class("TrialResultPanel", BasePanel)
TrialResultPanel._bAddToBackHistory = false
TrialResultPanel._tbDefine = {
  {
    sPrefabPath = "Play_TrialBattle/TrialResultPanel.prefab",
    sCtrlName = "Game.UI.TrialBattle.TrialResultCtrl"
  }
}

function TrialResultPanel:Awake()
end

function TrialResultPanel:OnEnable()
end

function TrialResultPanel:OnDisable()
end

function TrialResultPanel:OnDestroy()
end

return TrialResultPanel
