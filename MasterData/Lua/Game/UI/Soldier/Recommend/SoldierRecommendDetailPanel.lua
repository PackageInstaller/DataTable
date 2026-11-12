local SoldierRecommendDetailPanel = class("SoldierRecommendDetailPanel", BasePanel)
SoldierRecommendDetailPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/SoldierRecommendDetailPanel.prefab",
    sCtrlName = "Game.UI.Soldier.Recommend.SoldierRecommendDetailCtrl"
  }
}

function SoldierRecommendDetailPanel:Awake()
end

function SoldierRecommendDetailPanel:OnEnable()
end

function SoldierRecommendDetailPanel:OnAfterEnter()
end

function SoldierRecommendDetailPanel:OnDisable()
end

function SoldierRecommendDetailPanel:OnDestroy()
end

function SoldierRecommendDetailPanel:OnRelease()
end

return SoldierRecommendDetailPanel
