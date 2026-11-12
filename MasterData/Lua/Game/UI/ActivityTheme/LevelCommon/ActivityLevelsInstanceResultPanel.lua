local ActivityLevelsInstanceResultPanel = class("ActivityLevelsInstanceResultPanel", BasePanel)
ActivityLevelsInstanceResultPanel._bAddToBackHistory = false
ActivityLevelsInstanceResultPanel._tbDefine = {
  {
    sPrefabPath = "BattleResult/BattleResultPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.LevelCommon.ActivityLevelsInstanceResultCtrl"
  }
}

function ActivityLevelsInstanceResultPanel:Awake()
end

function ActivityLevelsInstanceResultPanel:OnEnable()
end

function ActivityLevelsInstanceResultPanel:OnDisable()
end

function ActivityLevelsInstanceResultPanel:OnDestroy()
end

return ActivityLevelsInstanceResultPanel
