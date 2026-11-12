local ActivityLevelsBattlePanel = class("ActivityLevelsBattlePanel", BasePanel)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
ActivityLevelsBattlePanel._sUIResRootPath = ""
ActivityLevelsBattlePanel.OpenMinMap = true
ActivityLevelsBattlePanel._bAddToBackHistory = false
ActivityLevelsBattlePanel._tbDefine = {
  {
    sPrefabPath = "UI/RoguelikeItemTip/RoguelikeItemTipPanel.prefab",
    sCtrlName = "Game.UI.RoguelikeItemTips.RoguelikeItemTipsCtrl"
  },
  {
    sPrefabPath = "UI/Battle/BattleDashboard.prefab",
    sCtrlName = "Game.UI.Battle.BattleDashboardCtrl"
  },
  {
    sPrefabPath = "UI/Battle/MainBattleMenu.prefab",
    sCtrlName = "Game.UI.Battle.MainBattleMenuCtrl"
  },
  {
    sPrefabPath = "UI/Battle/AdventureMainUI/AdventureMainUI.prefab",
    sCtrlName = "Game.UI.Battle.MainBattleCtrl"
  },
  {
    sPrefabPath = "UI/Battle/AdventureMainUI/BattlePopupTips.prefab",
    sCtrlName = "Game.UI.Battle.BattlePopupTipsCtrl"
  },
  {
    sPrefabPath = "UI/ActivityLevelCommon/ActivityLevelsInstanceInfo.prefab",
    sCtrlName = "Game.UI.ActivityTheme.LevelCommon.ActivityLevelsInstanceRoomInfo"
  },
  {
    sPrefabPath = "UI/Battle/SkillHintIndicators.prefab",
    sCtrlName = "Game.UI.Battle.SkillHintIndicator.HintIndicators"
  },
  {
    sPrefabPath = "UI/Battle/CommonBattlePausePanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.LevelCommon.ActivityLevelsInstancePauseCtrl"
  },
  {
    sPrefabPath = "UI/Battle/SubSkillDisplay.prefab",
    sCtrlName = "Game.UI.Battle.SubSkillDisplay.SubSkillDisplayCtrl"
  }
}

function ActivityLevelsBattlePanel:Awake()
  GamepadUIManager.EnterAdventure()
  GamepadUIManager.EnableGamepadUI("BattleMenu", {})
  self.BattleType = GameEnum.worldLevelType.ActivityLevels
end

function ActivityLevelsBattlePanel:OnEnable()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    EventManager.Hit(EventId.OpenPanel, PanelId.Hud)
    EventManager.Hit(EventId.ClosePanel, PanelId.MainlineFormation)
    EventManager.Hit(EventId.ClosePanel, PanelId.RegionBossFormation)
  end
  
  cs_coroutine.start(wait)
end

function ActivityLevelsBattlePanel:OnAfterEnter()
  EventManager.Hit(EventId.SubSkillDisplayInit, self._tbParam[1])
end

function ActivityLevelsBattlePanel:OnDisable()
  GamepadUIManager.DisableGamepadUI("BattleMenu")
  GamepadUIManager.QuitAdventure()
end

return ActivityLevelsBattlePanel
