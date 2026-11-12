local TrialBattlePanel = class("TrialBattlePanel", BasePanel)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
TrialBattlePanel.OpenMinMap = true
TrialBattlePanel._bAddToBackHistory = false
TrialBattlePanel._tbDefine = {
  {
    sPrefabPath = "RoguelikeItemTip/RoguelikeItemTipPanel.prefab",
    sCtrlName = "Game.UI.RoguelikeItemTips.RoguelikeItemTipsCtrl"
  },
  {
    sPrefabPath = "Battle/BattleDashboard.prefab",
    sCtrlName = "Game.UI.Battle.BattleDashboardCtrl"
  },
  {
    sPrefabPath = "Play_TrialBattle/TrialMenu.prefab",
    sCtrlName = "Game.UI.TrialBattle.TrialMenuCtrl"
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
    sPrefabPath = "Play_TrialBattle/TrialInfo.prefab",
    sCtrlName = "Game.UI.TrialBattle.TrialInfoCtrl"
  },
  {
    sPrefabPath = "Battle/SkillHintIndicators.prefab",
    sCtrlName = "Game.UI.Battle.SkillHintIndicator.HintIndicators"
  },
  {
    sPrefabPath = "FixedRoguelikeEx/FRIndicators.prefab",
    sCtrlName = "Game.UI.FixedRoguelikeEx.FRIndicators"
  },
  {
    sPrefabPath = "Play_TrialBattle/TrialPausePanel.prefab",
    sCtrlName = "Game.UI.TrialBattle.TrialPauseCtrl"
  },
  {
    sPrefabPath = "Battle/SubSkillDisplay.prefab",
    sCtrlName = "Game.UI.Battle.SubSkillDisplay.SubSkillDisplayCtrl"
  }
}

function TrialBattlePanel:Awake()
  GamepadUIManager.EnterAdventure()
  GamepadUIManager.EnableGamepadUI("BattleMenu", {})
  self.BattleType = GameEnum.worldLevelType.Dynamic
  self.DynamicType = GameEnum.dynamicLevelType.Trial
  self.tbTeam = self._tbParam[1]
  self.tbDisc = self._tbParam[2]
  self.mapCharData = self._tbParam[3]
  self.mapDiscData = self._tbParam[4]
  self.mapPotentialAddLevel = self._tbParam[5]
end

function TrialBattlePanel:OnEnable()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    EventManager.Hit(EventId.OpenPanel, PanelId.Hud)
    EventManager.Hit(EventId.ClosePanel, PanelId.MainlineFormation)
    EventManager.Hit(EventId.ClosePanel, PanelId.RegionBossFormation)
    EventManager.Hit(EventId.ClosePanel, PanelId.TrialFormation)
    EventManager.Hit(EventId.ClosePanel, PanelId.TrialSkinFormationScenePanel)
  end
  
  cs_coroutine.start(wait)
end

function TrialBattlePanel:OnAfterEnter()
  EventManager.Hit(EventId.SubSkillDisplayInit, self._tbParam[1])
end

function TrialBattlePanel:OnDisable()
  GamepadUIManager.DisableGamepadUI("BattleMenu")
  GamepadUIManager.QuitAdventure()
end

return TrialBattlePanel
