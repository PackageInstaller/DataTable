local TraceHuntHelpPanel = class("TraceHuntHelpPanel", BasePanel)
TraceHuntHelpPanel._tbDefine = {
  {
    sPrefabPath = "Play_TraceHuntLevelSelect/TraceHuntHelpPanel.prefab",
    sCtrlName = "Game.UI.TraceHunt.TraceHuntHelpCtrl"
  }
}

function TraceHuntHelpPanel:Awake()
  self.tbAddCache = {}
end

function TraceHuntHelpPanel:OnEnable()
end

function TraceHuntHelpPanel:OnDisable()
end

function TraceHuntHelpPanel:OnDestroy()
end

return TraceHuntHelpPanel
