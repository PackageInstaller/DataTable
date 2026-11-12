local BasePanel = require("GameCore.UI.BasePanel")
local SoldierPartnerTipsPanel = class("SoldierPartnerTipsPanel", BasePanel)
SoldierPartnerTipsPanel._bIsMainPanel = false
SoldierPartnerTipsPanel._sSortingLayerName = AllEnum.SortingLayerName.UI
SoldierPartnerTipsPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
SoldierPartnerTipsPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/Tips/SoldierPartnerTipsPanel.prefab",
    sCtrlName = "Game.UI.Soldier.PartnerTipsPanel.SoldierPartnerTipsCtrl"
  }
}

function SoldierPartnerTipsPanel:Awake()
end

function SoldierPartnerTipsPanel:OnEnable()
end

function SoldierPartnerTipsPanel:OnAfterEnter()
end

function SoldierPartnerTipsPanel:OnDisable()
end

function SoldierPartnerTipsPanel:OnDestroy()
end

function SoldierPartnerTipsPanel:OnRelease()
end

return SoldierPartnerTipsPanel
