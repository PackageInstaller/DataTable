local TowerDefensePanel = class("TowerDefensePanel", BasePanel)
TowerDefensePanel._bIsMainPanel = true
TowerDefensePanel._sSortingLayerName = AllEnum.SortingLayerName.UI
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
TowerDefensePanel._tbDefine = {
  {
    sPrefabPath = "Play_TowerDefence/TowerDefensePanel.prefab",
    sCtrlName = "Game.UI.TowerDefense.TowerDefenseCtrl"
  },
  {
    sPrefabPath = "Battle/AdventureMainUI/BattlePopupTips.prefab",
    sCtrlName = "Game.UI.Battle.BattlePopupTipsCtrl"
  }
}

function TowerDefensePanel:Awake()
  GamepadUIManager.EnterAdventure(true)
  GamepadUIManager.EnableGamepadUI("TowerDefense", {}, nil, true)
end

function TowerDefensePanel:OnEnable()
end

function TowerDefensePanel:OnAfterEnter()
end

function TowerDefensePanel:OnDisable()
end

function TowerDefensePanel:OnDestroy()
  GamepadUIManager.DisableGamepadUI("TowerDefense")
  GamepadUIManager.QuitAdventure()
end

function TowerDefensePanel:OnRelease()
end

return TowerDefensePanel
