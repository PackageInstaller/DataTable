local BasePanel = require("GameCore.UI.BasePanel")
local SoldierCharAttriTipsPanel = class("SoldierCharAttriTipsPanel", BasePanel)
SoldierCharAttriTipsPanel._bIsMainPanel = false
SoldierCharAttriTipsPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
SoldierCharAttriTipsPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/Tips/SoldierCharAttriTipsPanel.prefab",
    sCtrlName = "Game.UI.Soldier.CharacterAttriTips.SoldierCharAttriTipsCtrl"
  }
}

function SoldierCharAttriTipsPanel:Awake()
end

function SoldierCharAttriTipsPanel:OnEnable()
end

function SoldierCharAttriTipsPanel:OnAfterEnter()
end

function SoldierCharAttriTipsPanel:OnDisable()
end

function SoldierCharAttriTipsPanel:OnDestroy()
end

function SoldierCharAttriTipsPanel:OnRelease()
end

return SoldierCharAttriTipsPanel
