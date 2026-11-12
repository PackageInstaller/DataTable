local PrologueAdventurePanel = class("PrologueAdventurePanel", BasePanel)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
PrologueAdventurePanel.OpenMinMap = true
PrologueAdventurePanel._bAddToBackHistory = false
PrologueAdventurePanel._tbDefine = {
  {
    sPrefabPath = "RoguelikeItemTip/RoguelikeItemTipPanel.prefab",
    sCtrlName = "Game.UI.RoguelikeItemTips.RoguelikeItemTipsCtrl"
  },
  {
    sPrefabPath = "Battle/BattleDashboard.prefab",
    sCtrlName = "Game.UI.Battle.BattleDashboardCtrl"
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
    sPrefabPath = "Battle/SkillHintIndicators.prefab",
    sCtrlName = "Game.UI.Battle.SkillHintIndicator.HintIndicators"
  },
  {
    sPrefabPath = "Battle/SubSkillDisplay.prefab",
    sCtrlName = "Game.UI.Battle.SubSkillDisplay.SubSkillDisplayCtrl"
  }
}

function PrologueAdventurePanel:Awake()
  GamepadUIManager.EnterAdventure()
  GamepadUIManager.EnableGamepadUI("BattleMenu", {})
  self.BattleType = GameEnum.worldLevelType.PrologueBattleLevel
end

function PrologueAdventurePanel:OnEnable()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    EventManager.Hit(EventId.ClosePanel, PanelId.MainlineFormation)
    EventManager.Hit(EventId.ClosePanel, PanelId.RegionBossFormation)
  end
  
  cs_coroutine.start(wait)
end

function PrologueAdventurePanel:OnAfterEnter()
  EventManager.Hit(EventId.SubSkillDisplayInit, self._tbParam[1])
end

function PrologueAdventurePanel:OnDisable()
  GamepadUIManager.DisableGamepadUI("BattleMenu")
  GamepadUIManager.QuitAdventure()
end

return PrologueAdventurePanel
