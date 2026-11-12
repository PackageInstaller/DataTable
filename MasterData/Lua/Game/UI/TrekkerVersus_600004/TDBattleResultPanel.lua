local TDBattleResultPanel = class("TDBattleResultPanel", BasePanel)
TDBattleResultPanel._bAddToBackHistory = false
TDBattleResultPanel._tbDefine = {
  {
    sPrefabPath = "BattleResult/TravelerDuelBattleResultPanel.prefab",
    sCtrlName = "Game.UI.TrekkerVersus_600004.TDBattleResultCtrl"
  }
}

function TDBattleResultPanel:Awake()
end

function TDBattleResultPanel:OnEnable()
end

function TDBattleResultPanel:OnDisable()
end

function TDBattleResultPanel:OnDestroy()
end

return TDBattleResultPanel
