local BasePanel = require("GameCore.UI.BasePanel")
local ExchangeCodePanel = class("ExchangeCodePanel", BasePanel)
ExchangeCodePanel._bIsMainPanel = false
ExchangeCodePanel._sSortingLayerName = AllEnum.SortingLayerName.UI
ExchangeCodePanel._tbDefine = {
  {
    sPrefabPath = "ExchangeCode/ExchangeCodePanel.prefab",
    sCtrlName = "Game.UI.ExchangeCode.ExchangeCodeCtrl"
  }
}

function ExchangeCodePanel:Awake()
end

function ExchangeCodePanel:OnEnable()
end

function ExchangeCodePanel:OnDisable()
end

function ExchangeCodePanel:OnDestroy()
end

function ExchangeCodePanel:OnRelease()
end

return ExchangeCodePanel
