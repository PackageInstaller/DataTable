local TraceHuntPanel = class("TraceHuntPanel", BasePanel)
TraceHuntPanel._tbDefine = {
  {
    sPrefabPath = "Play_TraceHuntLevelSelect/TraceHuntSelectPanel.prefab",
    sCtrlName = "Game.UI.TraceHunt.TraceHuntCtrl"
  }
}

function TraceHuntPanel:Awake()
end

function TraceHuntPanel:OnEnable()
end

function TraceHuntPanel:OnDisable()
end

function TraceHuntPanel:OnDestroy()
end

return TraceHuntPanel
