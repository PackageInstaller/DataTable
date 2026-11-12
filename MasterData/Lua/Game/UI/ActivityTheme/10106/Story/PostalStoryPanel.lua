local BasePanel = require("GameCore.UI.BasePanel")
local PostalStoryPanel = class("PostalStoryPanel", BasePanel)
PostalStoryPanel._tbDefine = {
  {
    sPrefabPath = "ActivityStoryReview/10106/PostalStoryPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.10106.Story.PostalStoryCtrl"
  },
  {
    sPrefabPath = "ActivityStoryReview/ActivityStoryReceivePanel.prefab",
    sCtrlName = "Game.UI.ActivityStoryReview.ActivityStoryReceiveCtrl"
  }
}

function PostalStoryPanel:Awake()
  if self._tbParam[2] ~= true then
    self._tbDefine = {
      self._tbDefine[1]
    }
  end
end

function PostalStoryPanel:OnEnable()
end

function PostalStoryPanel:OnDisable()
end

function PostalStoryPanel:OnDestroy()
end

function PostalStoryPanel:OnRelease()
end

return PostalStoryPanel
