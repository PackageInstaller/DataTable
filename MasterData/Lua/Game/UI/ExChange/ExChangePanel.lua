local BasePanel = require("GameCore.UI.BasePanel")
local ExChangePanel = class("ExChangePanel", BasePanel)
ExChangePanel._bIsMainPanel = false
ExChangePanel._tbDefine = {
  {
    sPrefabPath = "ExChange/ExChangePanel.prefab",
    sCtrlName = "Game.UI.ExChange.ExChangeCtrl"
  }
}

function ExChangePanel:Awake()
end

function ExChangePanel:OnEnable()
end

function ExChangePanel:OnDisable()
end

function ExChangePanel:OnDestroy()
end

function ExChangePanel:OnRelease()
end

return ExChangePanel
