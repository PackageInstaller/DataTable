local BasePanel = require("GameCore.UI.BasePanel")
local LongestDayPanel = class("LongestDayPanel", BasePanel)
LongestDayPanel._sUIResRootPath = "UI_Activity/"
LongestDayPanel._tbDefine = {
  {
    sPrefabPath = "10112/LongestDayPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.10112.LongestDayCtrl"
  }
}

function LongestDayPanel:Awake()
end

function LongestDayPanel:OnEnable()
end

function LongestDayPanel:OnDisable()
end

function LongestDayPanel:OnDestroy()
end

function LongestDayPanel:OnRelease()
end

return LongestDayPanel
