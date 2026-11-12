local SoldierCharSkillPreviewPanel = class("SoldierCharSkillPreviewPanel", BasePanel)
SoldierCharSkillPreviewPanel._bIsMainPanel = false
SoldierCharSkillPreviewPanel._bAddToBackHistory = false
SoldierCharSkillPreviewPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
SoldierCharSkillPreviewPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/Tips/SoldierCharSkillPreviewPanel.prefab",
    sCtrlName = "Game.UI.Soldier.CharacterTips.SoldierCharSkillPreviewCtrl"
  }
}

function SoldierCharSkillPreviewPanel:Awake()
end

function SoldierCharSkillPreviewPanel:OnEnable()
end

function SoldierCharSkillPreviewPanel:OnAfterEnter()
end

function SoldierCharSkillPreviewPanel:OnDisable()
end

function SoldierCharSkillPreviewPanel:OnDestroy()
end

function SoldierCharSkillPreviewPanel:OnRelease()
end

return SoldierCharSkillPreviewPanel
