local SkillInstanceBattlePanel = class("SkillInstanceBattlePanel", BasePanel)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
SkillInstanceBattlePanel.OpenMinMap = true
SkillInstanceBattlePanel._bAddToBackHistory = false
SkillInstanceBattlePanel._tbDefine = {
  {
    sPrefabPath = "RoguelikeItemTip/RoguelikeItemTipPanel.prefab",
    sCtrlName = "Game.UI.RoguelikeItemTips.RoguelikeItemTipsCtrl"
  },
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
    sPrefabPath = "GuideProloguel/GuideProloguelPanel.prefab",
    sCtrlName = "Game.UI.GuideProloguel.GuideProloguelCtrl"
  },
  {
    sPrefabPath = "Battle/AdventureMainUI/BattlePopupTips.prefab",
    sCtrlName = "Game.UI.Battle.BattlePopupTipsCtrl"
  },
  {
    sPrefabPath = "SkillInstanceBattlePanel/SkillInstanceInfo.prefab",
    sCtrlName = "Game.UI.SkillInstanceRoomInfo.SkillInstanceRoomInfoCtrl"
  },
  {
    sPrefabPath = "Battle/SkillHintIndicators.prefab",
    sCtrlName = "Game.UI.Battle.SkillHintIndicator.HintIndicators"
  },
  {
    sPrefabPath = "Battle/CommonBattlePausePanel.prefab",
    sCtrlName = "Game.UI.SkillInstanceRoomInfo.SkillInstancePauseCtrl"
  },
  {
    sPrefabPath = "Battle/SubSkillDisplay.prefab",
    sCtrlName = "Game.UI.Battle.SubSkillDisplay.SubSkillDisplayCtrl"
  }
}

function SkillInstanceBattlePanel:Awake()
  GamepadUIManager.EnterAdventure()
  GamepadUIManager.EnableGamepadUI("BattleMenu", {})
  self.BattleType = GameEnum.worldLevelType.SkillInstance
end

function SkillInstanceBattlePanel:OnEnable()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    EventManager.Hit(EventId.OpenPanel, PanelId.Hud)
    EventManager.Hit(EventId.ClosePanel, PanelId.MainlineFormation)
    EventManager.Hit(EventId.ClosePanel, PanelId.RegionBossFormation)
  end
  
  cs_coroutine.start(wait)
end

function SkillInstanceBattlePanel:OnAfterEnter()
  EventManager.Hit(EventId.SubSkillDisplayInit, self._tbParam[1])
end

function SkillInstanceBattlePanel:OnDisable()
  GamepadUIManager.DisableGamepadUI("BattleMenu")
  GamepadUIManager.QuitAdventure()
end

return SkillInstanceBattlePanel
