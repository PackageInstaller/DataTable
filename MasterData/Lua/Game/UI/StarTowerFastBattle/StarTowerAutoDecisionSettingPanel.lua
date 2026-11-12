local StarTowerAutoDecisionSettingPanel = class("StarTowerAutoDecisionSettingPanel", BasePanel)
StarTowerAutoDecisionSettingPanel._bIsMainPanel = false
StarTowerAutoDecisionSettingPanel._tbDefine = {
  {
    sPrefabPath = "StarTowerFastBattle/StarTowerAutoBattlePanel.prefab",
    sCtrlName = "Game.UI.StarTowerFastBattle.StarTowerAutoDecisionSettingCtrl"
  }
}

function StarTowerAutoDecisionSettingPanel:Awake()
end

function StarTowerAutoDecisionSettingPanel:OnEnable()
end

function StarTowerAutoDecisionSettingPanel:OnDisable()
end

function StarTowerAutoDecisionSettingPanel:OnDestroy()
end

return StarTowerAutoDecisionSettingPanel
