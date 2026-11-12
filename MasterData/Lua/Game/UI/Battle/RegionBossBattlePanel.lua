local RegionBossBattlePanel = class("RegionBossBattlePanel", BasePanel)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
RegionBossBattlePanel.OpenMinMap = true
RegionBossBattlePanel._bAddToBackHistory = false
RegionBossBattlePanel._tbDefine = {
  {
    sPrefabPath = "Battle/BattleDashboard.prefab",
    sCtrlName = "Game.UI.Battle.BattleDashboardCtrl"
  },
  {
    sPrefabPath = "Battle/MainBattleMenu.prefab",
    sCtrlName = "Game.UI.Battle.MainBattleMenuCtrl"
  },
  {
    sPrefabPath = "Battle/AdventureMainUI/AdventureMainUI.prefab",
    sCtrlName = "Game.UI.Battle.MainBattleCtrl"
  },
  {
    sPrefabPath = "RegionBossTimeEx/RegionBossTime.prefab",
    sCtrlName = "Game.UI.RegionBossTimeEx.RegionBossTimeCtrl"
  },
  {
    sPrefabPath = "Battle/CommonMonsterWarning.prefab",
    sCtrlName = "Game.UI.Battle.CommonMonsterWarningCtrl"
  },
  {
    sPrefabPath = "Battle/AdventureMainUI/BattlePopupTips.prefab",
    sCtrlName = "Game.UI.Battle.BattlePopupTipsCtrl"
  },
  {
    sPrefabPath = "Battle/SkillHintIndicators.prefab",
    sCtrlName = "Game.UI.Battle.SkillHintIndicator.HintIndicators"
  },
  {
    sPrefabPath = "Battle/CommonBattlePausePanel.prefab",
    sCtrlName = "Game.UI.RegionBossTimeEx.RegionBossPauseCtrl"
  },
  {
    sPrefabPath = "Battle/SubSkillDisplay.prefab",
    sCtrlName = "Game.UI.Battle.SubSkillDisplay.SubSkillDisplayCtrl"
  }
}

function RegionBossBattlePanel:Awake()
  GamepadUIManager.EnterAdventure()
  GamepadUIManager.EnableGamepadUI("BattleMenu", {})
  self.BattleType = GameEnum.worldLevelType.RegionBoss
end

function RegionBossBattlePanel:OnEnable()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    EventManager.Hit(EventId.OpenPanel, PanelId.Hud)
    EventManager.Hit(EventId.ClosePanel, PanelId.MainlineFormation)
    EventManager.Hit(EventId.ClosePanel, PanelId.RegionBossFormation)
  end
  
  cs_coroutine.start(wait)
end

function RegionBossBattlePanel:OnAfterEnter()
  EventManager.Hit(EventId.SubSkillDisplayInit, self._tbParam[1])
end

function RegionBossBattlePanel:OnDisable()
  GamepadUIManager.DisableGamepadUI("BattleMenu")
  GamepadUIManager.QuitAdventure()
end

return RegionBossBattlePanel
