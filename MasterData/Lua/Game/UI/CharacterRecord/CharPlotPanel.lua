local BasePanel = require("GameCore.UI.BasePanel")
local CharPlotPanel = class("CharPlotPanel", BasePanel)
CharPlotPanel._bIsMainPanel = false
CharPlotPanel._tbDefine = {
  {
    sPrefabPath = "CharacterInfoEx/CharPlotPanel.prefab",
    sCtrlName = "Game.UI.CharacterRecord.CharPlotCtrl"
  }
}

function CharPlotPanel:Awake()
end

function CharPlotPanel:OnEnable()
end

function CharPlotPanel:OnDisable()
end

function CharPlotPanel:OnDestroy()
end

function CharPlotPanel:OnRelease()
end

return CharPlotPanel
