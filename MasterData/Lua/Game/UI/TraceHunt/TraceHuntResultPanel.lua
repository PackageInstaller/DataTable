local TraceHuntResultPanel = class("TraceHuntResultPanel", BasePanel)
TraceHuntResultPanel._bAddToBackHistory = false
TraceHuntResultPanel._tbDefine = {
  {
    sPrefabPath = "Play_TraceHuntBattle/TraceHuntBattleResultPanel.prefab",
    sCtrlName = "Game.UI.TraceHunt.TraceHuntResultCtrl"
  }
}

function TraceHuntResultPanel:Awake()
end

function TraceHuntResultPanel:OnEnable()
end

function TraceHuntResultPanel:OnDisable()
end

function TraceHuntResultPanel:OnDestroy()
end

return TraceHuntResultPanel
