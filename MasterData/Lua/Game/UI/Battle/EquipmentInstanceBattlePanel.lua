local EquipmentInstanceBattlePanel = class("EquipmentInstanceBattlePanel", BasePanel)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
EquipmentInstanceBattlePanel.OpenMinMap = true
EquipmentInstanceBattlePanel._bAddToBackHistory = false
EquipmentInstanceBattlePanel._tbDefine = {
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
    sPrefabPath = "EquipmentInstanceBattlePanel/EquipmentInstanceInfo.prefab",
    sCtrlName = "Game.UI.EquipmentInstanceRoomInfo.EquipmentInstanceRoomInfoCtrl"
  },
  {
    sPrefabPath = "Battle/SkillHintIndicators.prefab",
    sCtrlName = "Game.UI.Battle.SkillHintIndicator.HintIndicators"
  },
  {
    sPrefabPath = "Battle/CommonBattlePausePanel.prefab",
    sCtrlName = "Game.UI.EquipmentInstanceRoomInfo.EquipmentInstancePauseCtrl"
  },
  {
    sPrefabPath = "Battle/SubSkillDisplay.prefab",
    sCtrlName = "Game.UI.Battle.SubSkillDisplay.SubSkillDisplayCtrl"
  }
}

function EquipmentInstanceBattlePanel:Awake()
  GamepadUIManager.EnterAdventure()
  GamepadUIManager.EnableGamepadUI("BattleMenu", {})
  self.BattleType = GameEnum.worldLevelType.EquipmentInstance
end

function EquipmentInstanceBattlePanel:OnEnable()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    EventManager.Hit(EventId.OpenPanel, PanelId.Hud)
    EventManager.Hit(EventId.ClosePanel, PanelId.MainlineFormation)
    EventManager.Hit(EventId.ClosePanel, PanelId.RegionBossFormation)
  end
  
  cs_coroutine.start(wait)
end

function EquipmentInstanceBattlePanel:OnAfterEnter()
  EventManager.Hit(EventId.SubSkillDisplayInit, self._tbParam[1])
end

function EquipmentInstanceBattlePanel:OnDisable()
  GamepadUIManager.DisableGamepadUI("BattleMenu")
  GamepadUIManager.QuitAdventure()
end

return EquipmentInstanceBattlePanel
