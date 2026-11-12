local TowerDefenseQuestPanel = class("TowerDefenseQuestPanel", BasePanel)
TowerDefenseQuestPanel._sSortingLayerName = AllEnum.SortingLayerName.UI
TowerDefenseQuestPanel._bIsMainPanel = false
TowerDefenseQuestPanel._tbDefine = {
  {
    sPrefabPath = "Play_TowerDefence/TowerDefenseQuest.prefab",
    sCtrlName = "Game.UI.TowerDefense.TowerDefenseQuestCtrl"
  }
}

function TowerDefenseQuestPanel:Awake()
end

function TowerDefenseQuestPanel:OnEnable()
end

function TowerDefenseQuestPanel:OnAfterEnter()
end

function TowerDefenseQuestPanel:OnDisable()
end

function TowerDefenseQuestPanel:OnDestroy()
end

function TowerDefenseQuestPanel:OnRelease()
end

return TowerDefenseQuestPanel
