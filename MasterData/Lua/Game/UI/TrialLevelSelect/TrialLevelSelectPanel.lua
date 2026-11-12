local TrialLevelSelectPanel = class("TrialLevelSelectPanel", BasePanel)
TrialLevelSelectPanel._tbDefine = {
  {
    sPrefabPath = "Play_TrialLevelSelect/TrialLevelSelectPanel.prefab",
    sCtrlName = "Game.UI.TrialLevelSelect.TrialLevelSelectCtrl"
  }
}

function TrialLevelSelectPanel:Awake()
end

function TrialLevelSelectPanel:OnEnable()
end

function TrialLevelSelectPanel:OnDisable()
end

function TrialLevelSelectPanel:OnDestroy()
end

return TrialLevelSelectPanel
