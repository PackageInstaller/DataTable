local BasePanel = require("GameCore.UI.BasePanel")
local StoryChapterPanel = class("StoryChapterPanel", BasePanel)
StoryChapterPanel._tbDefine = {
  {
    sPrefabPath = "MainlineEx/StoryChapterPanel.prefab",
    sCtrlName = "Game.UI.MainlineEx.StoryChapterCtrl"
  }
}

function StoryChapterPanel:Awake()
end

function StoryChapterPanel:OnEnable()
end

function StoryChapterPanel:OnAfterEnter()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" and tbParam[2] == true then
    EventManager.Hit(EventId.ClosePanel, PanelId.MainlineEx)
  end
end

function StoryChapterPanel:OnDisable()
end

function StoryChapterPanel:OnDestroy()
end

function StoryChapterPanel:OnRelease()
end

return StoryChapterPanel
