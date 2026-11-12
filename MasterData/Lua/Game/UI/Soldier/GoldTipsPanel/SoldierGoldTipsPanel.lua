local BasePanel = require("GameCore.UI.BasePanel")
local SoldierGoldTipsPanel = class("SoldierGoldTipsPanel", BasePanel)
SoldierGoldTipsPanel._bIsMainPanel = false
SoldierGoldTipsPanel._sSortingLayerName = AllEnum.SortingLayerName.UI
SoldierGoldTipsPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/Tips/SoldierGoldTipsPanel.prefab",
    sCtrlName = "Game.UI.Soldier.GoldTipsPanel.SoldierGoldTipsCtrl"
  }
}

function SoldierGoldTipsPanel:Awake()
end

function SoldierGoldTipsPanel:OnEnable()
end

function SoldierGoldTipsPanel:OnAfterEnter()
end

function SoldierGoldTipsPanel:OnDisable()
end

function SoldierGoldTipsPanel:OnDestroy()
end

function SoldierGoldTipsPanel:OnRelease()
end

return SoldierGoldTipsPanel
