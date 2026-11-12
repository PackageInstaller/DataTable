local BasePanel = require("GameCore.UI.BasePanel")
local MainlineExPanel = class("MainlineExPanel", BasePanel)
MainlineExPanel._tbDefine = {
  {
    sPrefabPath = "MainlineEx/MainlineExPanel.prefab",
    sCtrlName = "Game.UI.MainlineEx.MainlineExCtrl"
  }
}

function MainlineExPanel:Awake()
end

function MainlineExPanel:OnEnable()
end

function MainlineExPanel:OnDisable()
end

function MainlineExPanel:OnDestroy()
end

function MainlineExPanel:OnRelease()
end

return MainlineExPanel
