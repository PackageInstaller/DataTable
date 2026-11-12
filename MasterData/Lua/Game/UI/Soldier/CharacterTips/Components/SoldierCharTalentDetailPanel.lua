local BasePanel = require("GameCore.UI.BasePanel")
local SoldierCharTalentDetailPanel = class("SoldierCharTalentDetailPanel", BasePanel)
SoldierCharTalentDetailPanel._bIsMainPanel = false
SoldierCharTalentDetailPanel._bAddToBackHistory = false
SoldierCharTalentDetailPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
SoldierCharTalentDetailPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/Tips/CharacterCardTips/SoldierCharPontentialDetailPanel.prefab",
    sCtrlName = "Game.UI.Soldier.CharacterTips.Components.SoldierCharPotentialDetailCtrl"
  }
}

function SoldierCharTalentDetailPanel:Awake()
end

function SoldierCharTalentDetailPanel:OnEnable()
end

function SoldierCharTalentDetailPanel:OnDisable()
end

function SoldierCharTalentDetailPanel:OnDestroy()
end

function SoldierCharTalentDetailPanel:OnRelease()
end

return SoldierCharTalentDetailPanel
