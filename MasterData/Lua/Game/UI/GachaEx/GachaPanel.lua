local GachaPanel = class("GachaPanel", BasePanel)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
GachaPanel._tbDefine = {
  {
    sPrefabPath = "GachaEx/GachaPanel.prefab",
    sCtrlName = "Game.UI.GachaEx.GachaCtrl"
  }
}

function GachaPanel:Awake()
end

function GachaPanel:OnEnable()
  Actor2DManager.ForceUseL2D(true)
end

function GachaPanel:OnDisable()
  Actor2DManager.ForceUseL2D(false)
end

function GachaPanel:OnDestroy()
end

function GachaPanel:OnRelease()
end

return GachaPanel
