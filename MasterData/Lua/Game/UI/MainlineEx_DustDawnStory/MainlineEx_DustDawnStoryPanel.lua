local BasePanel = require("GameCore.UI.BasePanel")
local MainlineEx_DustDawnStoryPanel = class("MainlineEx_DustDawnStoryPanel", BasePanel)
MainlineEx_DustDawnStoryPanel._tbDefine = {
  {
    sPrefabPath = "MainlineEx_DustDawnStory/DustDawnStoryPanel.prefab",
    sCtrlName = "Game.UI.MainlineEx_DustDawnStory.MainlineEx_DustDawnStoryCtrl"
  }
}

function MainlineEx_DustDawnStoryPanel:Awake()
end

function MainlineEx_DustDawnStoryPanel:OnEnable()
end

function MainlineEx_DustDawnStoryPanel:OnDisable()
end

function MainlineEx_DustDawnStoryPanel:OnDestroy()
end

function MainlineEx_DustDawnStoryPanel:OnRelease()
end

return MainlineEx_DustDawnStoryPanel
