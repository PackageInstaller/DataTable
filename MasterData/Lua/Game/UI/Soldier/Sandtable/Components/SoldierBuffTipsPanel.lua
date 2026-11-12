local BasePanel = require("GameCore.UI.BasePanel")
local SoldierBuffTipsPanel = class("SoldierBuffTipsPanel", BasePanel)
SoldierBuffTipsPanel._bIsMainPanel = false
SoldierBuffTipsPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/Tips/SoldierBuffTips.prefab",
    sCtrlName = "Game.UI.Soldier.Sandtable.Components.SoldierBuffTipsCtrl"
  }
}

function SoldierBuffTipsPanel:Awake()
end

function SoldierBuffTipsPanel:OnEnable()
end

function SoldierBuffTipsPanel:OnDisable()
end

function SoldierBuffTipsPanel:OnDestroy()
end

function SoldierBuffTipsPanel:OnRelease()
end

return SoldierBuffTipsPanel
