local TraceHuntLevelPanel = class("TraceHuntLevelPanel", BasePanel)
TraceHuntLevelPanel._bIsMainPanel = false
TraceHuntLevelPanel._tbDefine = {
  {
    sPrefabPath = "Play_TraceHuntLevelSelect/TraceHuntLevelPanel.prefab",
    sCtrlName = "Game.UI.TraceHunt.TraceHuntLevelCtrl"
  }
}

function TraceHuntLevelPanel:Awake()
end

function TraceHuntLevelPanel:OnEnable()
end

function TraceHuntLevelPanel:OnDisable()
end

function TraceHuntLevelPanel:OnDestroy()
end

return TraceHuntLevelPanel
