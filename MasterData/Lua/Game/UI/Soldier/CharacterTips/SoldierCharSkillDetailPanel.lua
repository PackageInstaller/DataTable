local SoldierCharSkillDetailPanel = class("SoldierCharSkillDetailPanel", BasePanel)
SoldierCharSkillDetailPanel._bIsMainPanel = false
SoldierCharSkillDetailPanel._bAddToBackHistory = false
SoldierCharSkillDetailPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
SoldierCharSkillDetailPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/Tips/SoldierCharSkillDetailPanel.prefab",
    sCtrlName = "Game.UI.Soldier.CharacterTips.SoldierCharSkillDetailCtrl"
  }
}

function SoldierCharSkillDetailPanel:Awake()
end

function SoldierCharSkillDetailPanel:OnEnable()
end

function SoldierCharSkillDetailPanel:OnAfterEnter()
end

function SoldierCharSkillDetailPanel:OnDisable()
end

function SoldierCharSkillDetailPanel:OnDestroy()
end

function SoldierCharSkillDetailPanel:OnRelease()
end

return SoldierCharSkillDetailPanel
