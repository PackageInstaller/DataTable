local BasePanel = require("GameCore.UI.BasePanel")
local DispatchPanel = class("DispatchPanel", BasePanel)
DispatchPanel._tbDefine = {
  {
    sPrefabPath = "Dispatch/DispatchPanel.prefab",
    sCtrlName = "Game.UI.Dispatch.DispatchCtrl"
  }
}

function DispatchPanel:Awake()
end

function DispatchPanel:OnEnable()
end

function DispatchPanel:OnDisable()
end

function DispatchPanel:OnDestroy()
end

function DispatchPanel:OnRelease()
end

return DispatchPanel
