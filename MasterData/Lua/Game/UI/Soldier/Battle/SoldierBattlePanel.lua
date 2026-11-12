local SoldierBattlePanel = class("SoldierBattlePanel", BasePanel)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
SoldierBattlePanel.OpenMinMap = true
SoldierBattlePanel._bAddToBackHistory = false
SoldierBattlePanel._tbDefine = {
  {
    sPrefabPath = "Soldier/Battle/SoldierRoomInfo.prefab",
    sCtrlName = "Game.UI.Soldier.Battle.SoldierRoomInfoCtrl"
  },
  {
    sPrefabPath = "Battle/AdventureMainUI/BattlePopupTips.prefab",
    sCtrlName = "Game.UI.Battle.BattlePopupTipsCtrl"
  },
  {
    sPrefabPath = "Soldier/Battle/SoldierPausePanel.prefab",
    sCtrlName = "Game.UI.Soldier.Battle.SoldierPauseCtrl"
  },
  {
    sPrefabPath = "Soldier/Battle/SoldierSubSkillDisplay.prefab",
    sCtrlName = "Game.UI.Soldier.Battle.SoldierSkillDisplayCtrl"
  }
}

function SoldierBattlePanel:Awake()
  self.BattleType = GameEnum.worldLevelType.Dynamic
  self.DynamicType = GameEnum.dynamicLevelType.SoldierChess
  self.trUIRoot = GameObject.Find("---- UI ----").transform
  self.tbChess = self._tbParam[1]
  self.tbPartner = self._tbParam[2]
  self.nTotalTime = self._tbParam[3]
end

function SoldierBattlePanel:OnEnable()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    EventManager.Hit(EventId.OpenPanel, PanelId.Hud, false, false, false, true)
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
  end
  
  cs_coroutine.start(wait)
  EventManager.Hit("RefreshSoldierChessList", self.tbChess)
end

function SoldierBattlePanel:OnAfterEnter()
  EventManager.Hit(EventId.SubSkillDisplayInit, self._tbParam[1])
end

function SoldierBattlePanel:OnDisable()
end

return SoldierBattlePanel
