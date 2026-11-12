local BasePanel = require("GameCore.UI.BasePanel")
local StoryEntrancePanel = class("StoryEntrancePanel", BasePanel)
StoryEntrancePanel._tbDefine = {
  {
    sPrefabPath = "MainlineEx/StoryEntrancePanel.prefab",
    sCtrlName = "Game.UI.MainlineEx.StoryEntranceCtrl"
  }
}

function StoryEntrancePanel:Awake()
end

function StoryEntrancePanel:OnEnable()
end

function StoryEntrancePanel:OnDisable()
end

function StoryEntrancePanel:OnDestroy()
end

function StoryEntrancePanel:OnRelease()
end

return StoryEntrancePanel
