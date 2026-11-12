local TraceHuntHandBookPanel = class("TraceHuntHandBookPanel", BasePanel)
TraceHuntHandBookPanel._tbDefine = {
  {
    sPrefabPath = "Play_TraceHuntLevelSelect/TraceHuntHandBookPanel.prefab",
    sCtrlName = "Game.UI.TraceHunt.TraceHuntHandBookCtrl"
  }
}

function TraceHuntHandBookPanel:Awake()
end

function TraceHuntHandBookPanel:OnEnable()
end

function TraceHuntHandBookPanel:OnDisable()
end

function TraceHuntHandBookPanel:OnDestroy()
end

return TraceHuntHandBookPanel
