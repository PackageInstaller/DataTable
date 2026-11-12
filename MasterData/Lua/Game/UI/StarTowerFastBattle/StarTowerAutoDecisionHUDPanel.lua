local StarTowerAutoDecisionHUDPanel = class("StarTowerAutoDecisionHUDPanel", BasePanel)
StarTowerAutoDecisionHUDPanel._bIsMainPanel = false
StarTowerAutoDecisionHUDPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
StarTowerAutoDecisionHUDPanel._tbDefine = {
  {
    sPrefabPath = "StarTowerFastBattle/StarTowerAutoBattlePopup.prefab",
    sCtrlName = "Game.UI.StarTowerFastBattle.StarTowerAutoDecisionHUDCtrl"
  }
}

function StarTowerAutoDecisionHUDPanel:Awake()
  local tbParam = self:GetPanelParam()
  self.LevelData = tbParam and tbParam[1] or nil
end

function StarTowerAutoDecisionHUDPanel:OnEnable()
end

function StarTowerAutoDecisionHUDPanel:OnDisable()
end

function StarTowerAutoDecisionHUDPanel:OnDestroy()
end

return StarTowerAutoDecisionHUDPanel
