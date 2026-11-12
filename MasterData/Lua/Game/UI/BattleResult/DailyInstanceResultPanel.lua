local DailyInstanceResultPanel = class("DailyInstanceResultPanel", BasePanel)
DailyInstanceResultPanel._bAddToBackHistory = false
DailyInstanceResultPanel._tbDefine = {
  {
    sPrefabPath = "BattleResult/BattleResultPanel.prefab",
    sCtrlName = "Game.UI.BattleResult.DailyInstanceResultCtrl"
  }
}

function DailyInstanceResultPanel:Awake()
end

function DailyInstanceResultPanel:OnEnable()
end

function DailyInstanceResultPanel:OnDisable()
end

function DailyInstanceResultPanel:OnDestroy()
end

return DailyInstanceResultPanel
