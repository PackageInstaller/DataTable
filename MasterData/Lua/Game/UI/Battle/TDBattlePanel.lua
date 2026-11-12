local TDBattlePanel = class("TDBattlePanel", BasePanel)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
TDBattlePanel.OpenMinMap = true
TDBattlePanel._bAddToBackHistory = false
TDBattlePanel._tbDefine = {
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
    sPrefabPath = "Battle/AdventureMainUI/BattlePopupTips.prefab",
    sCtrlName = "Game.UI.Battle.BattlePopupTipsCtrl"
  },
  {
    sPrefabPath = "TDRoomInfo/TDRoomInfo.prefab",
    sCtrlName = "Game.UI.TravelerDuelRoomInfo.TDRoomInfoCtrl"
  },
  {
    sPrefabPath = "Battle/SkillHintIndicators.prefab",
    sCtrlName = "Game.UI.Battle.SkillHintIndicator.HintIndicators"
  },
  {
    sPrefabPath = "Battle/CommonBattlePausePanel.prefab",
    sCtrlName = "Game.UI.TravelerDuelRoomInfo.TDPauseCtrl"
  },
  {
    sPrefabPath = "Battle/SubSkillDisplay.prefab",
    sCtrlName = "Game.UI.Battle.SubSkillDisplay.SubSkillDisplayCtrl"
  },
  {
    sPrefabPath = "Battle/EnergyBattleUI.prefab",
    sCtrlName = "Game.UI.Battle.TDBatttle.EnergyBattleCtrl"
  }
}

function TDBattlePanel:Awake()
  GamepadUIManager.EnterAdventure()
  GamepadUIManager.EnableGamepadUI("BattleMenu", {})
  self.BattleType = GameEnum.worldLevelType.TravelerDuel
end

function TDBattlePanel:OnEnable()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    local mapLevel = ConfigTable.GetData("TravelerDuelBossLevel", self._tbParam[2])
    if mapLevel then
      local FloorId = mapLevel.FloorId
      local floorData = ConfigTable.GetData("TravelerDuelFloor", FloorId)
      if floorData and floorData.IntroCutscene ~= "" then
        EventManager.Hit(EventId.BattleDashboardVisible, false)
      end
    end
    EventManager.Hit(EventId.OpenPanel, PanelId.Hud)
    EventManager.Hit(EventId.ClosePanel, PanelId.MainlineFormation)
    EventManager.Hit(EventId.ClosePanel, PanelId.RegionBossFormation)
  end
  
  cs_coroutine.start(wait)
end

function TDBattlePanel:OnAfterEnter()
  EventManager.Hit(EventId.SubSkillDisplayInit, self._tbParam[1])
end

function TDBattlePanel:OnDisable()
  GamepadUIManager.DisableGamepadUI("BattleMenu")
  GamepadUIManager.QuitAdventure()
end

return TDBattlePanel
