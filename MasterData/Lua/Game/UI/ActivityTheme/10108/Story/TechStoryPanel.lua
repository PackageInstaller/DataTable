local BasePanel = require("GameCore.UI.BasePanel")
local TechStoryPanel = class("TechStoryPanel", BasePanel)
TechStoryPanel._tbDefine = {
  {
    sPrefabPath = "ActivityStoryReview/10108/TechStoryPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.10108.Story.TechStoryCtrl"
  },
  {
    sPrefabPath = "ActivityStoryReview/ActivityStoryReceivePanel.prefab",
    sCtrlName = "Game.UI.ActivityStoryReview.ActivityStoryReceiveCtrl"
  }
}

function TechStoryPanel:Awake()
  if self._tbParam[2] ~= true then
    self._tbDefine = {
      self._tbDefine[1]
    }
  end
end

function TechStoryPanel:OnEnable()
end

function TechStoryPanel:OnDisable()
end

function TechStoryPanel:OnDestroy()
end

function TechStoryPanel:OnRelease()
end

return TechStoryPanel
