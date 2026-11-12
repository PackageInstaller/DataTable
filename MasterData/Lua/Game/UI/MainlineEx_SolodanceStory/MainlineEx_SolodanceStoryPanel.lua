local BasePanel = require("GameCore.UI.BasePanel")
local MainlineEx_SolodanceStoryPanel = class("MainlineEx_SolodanceStoryPanel", BasePanel)
MainlineEx_SolodanceStoryPanel._tbDefine = {
  {
    sPrefabPath = "MainlineEx_SolodanceStory/SolodanceStoryPanel.prefab",
    sCtrlName = "Game.UI.MainlineEx_SolodanceStory.MainlineEx_SolodanceStoryCtrl"
  }
}

function MainlineEx_SolodanceStoryPanel:Awake()
end

function MainlineEx_SolodanceStoryPanel:OnEnable()
end

function MainlineEx_SolodanceStoryPanel:OnDisable()
end

function MainlineEx_SolodanceStoryPanel:OnDestroy()
end

function MainlineEx_SolodanceStoryPanel:OnRelease()
end

return MainlineEx_SolodanceStoryPanel
