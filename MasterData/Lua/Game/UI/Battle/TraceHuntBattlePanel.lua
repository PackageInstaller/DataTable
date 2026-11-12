local TraceHuntBattlePanel = class("TraceHuntBattlePanel", BasePanel)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
TraceHuntBattlePanel.OpenMinMap = true
TraceHuntBattlePanel._bAddToBackHistory = false
TraceHuntBattlePanel._tbDefine = {
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
    sPrefabPath = "Battle/AdventureMainUI/BattlePopupTips.prefab",
    sCtrlName = "Game.UI.Battle.BattlePopupTipsCtrl"
  },
  {
    sPrefabPath = "Play_TraceHuntBattle/TraceHuntLevelInfo.prefab",
    sCtrlName = "Game.UI.TraceHunt.TraceHuntLevelInfoCtrl"
  },
  {
    sPrefabPath = "Battle/SkillHintIndicators.prefab",
    sCtrlName = "Game.UI.Battle.SkillHintIndicator.HintIndicators"
  },
  {
    sPrefabPath = "Play_TraceHuntBattle/TraceHuntPausePanel.prefab",
    sCtrlName = "Game.UI.TraceHunt.TraceHuntPauseCtrl"
  },
  {
    sPrefabPath = "Battle/SubSkillDisplay.prefab",
    sCtrlName = "Game.UI.Battle.SubSkillDisplay.SubSkillDisplayCtrl"
  }
}

function TraceHuntBattlePanel:Awake()
  GamepadUIManager.EnterAdventure()
  GamepadUIManager.EnableGamepadUI("BattleMenu", {})
  self.BattleType = GameEnum.worldLevelType.TraceHunt
end

function TraceHuntBattlePanel:OnEnable()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    EventManager.Hit(EventId.OpenPanel, PanelId.Hud)
    EventManager.Hit(EventId.ClosePanel, PanelId.MainlineFormation)
    EventManager.Hit(EventId.ClosePanel, PanelId.RegionBossFormation)
  end
  
  cs_coroutine.start(wait)
end

function TraceHuntBattlePanel:OnAfterEnter()
  EventManager.Hit(EventId.SubSkillDisplayInit, self._tbParam[1])
end

function TraceHuntBattlePanel:OnDisable()
  GamepadUIManager.DisableGamepadUI("BattleMenu")
  GamepadUIManager.QuitAdventure()
end

return TraceHuntBattlePanel
