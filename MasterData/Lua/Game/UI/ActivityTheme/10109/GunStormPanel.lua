local BasePanel = require("GameCore.UI.BasePanel")
local GunStormPanel = class("GunStormPanel", BasePanel)
GunStormPanel._sUIResRootPath = "UI_Activity/"
GunStormPanel._tbDefine = {
  {
    sPrefabPath = "10109/GunStormPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.10109.GunStormCtrl"
  }
}

function GunStormPanel:Awake()
end

function GunStormPanel:OnEnable()
end

function GunStormPanel:OnDisable()
end

function GunStormPanel:OnDestroy()
end

function GunStormPanel:OnRelease()
end

return GunStormPanel
