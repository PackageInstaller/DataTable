local SoldierCharTipsPanel = class("SoldierCharTipsPanel", BasePanel)
SoldierCharTipsPanel._bIsMainPanel = false
SoldierCharTipsPanel._bAddToBackHistory = false
SoldierCharTipsPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
SoldierCharTipsPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/Tips/SoldierCharCardTipsPanel.prefab",
    sCtrlName = "Game.UI.Soldier.CharacterTips.SoldierCharTipsCtrl"
  }
}

function SoldierCharTipsPanel:Awake()
end

function SoldierCharTipsPanel:OnEnable()
end

function SoldierCharTipsPanel:OnAfterEnter()
end

function SoldierCharTipsPanel:OnDisable()
end

function SoldierCharTipsPanel:OnDestroy()
end

function SoldierCharTipsPanel:OnRelease()
end

return SoldierCharTipsPanel
