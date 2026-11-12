local BasePanel = require("GameCore.UI.BasePanel")
local WinterNightStoryPanel = class("WinterNightStoryPanel", BasePanel)
WinterNightStoryPanel._tbDefine = {
  {
    sPrefabPath = "ActivityStoryReview/10105/WinterNightStoryPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.10105.Story.WinterNightStoryCtrl"
  },
  {
    sPrefabPath = "ActivityStoryReview/ActivityStoryReceivePanel.prefab",
    sCtrlName = "Game.UI.ActivityStoryReview.ActivityStoryReceiveCtrl"
  }
}

function WinterNightStoryPanel:Awake()
  if self._tbParam[2] ~= true then
    self._tbDefine = {
      self._tbDefine[1]
    }
  end
end

function WinterNightStoryPanel:OnEnable()
end

function WinterNightStoryPanel:OnDisable()
end

function WinterNightStoryPanel:OnDestroy()
end

function WinterNightStoryPanel:OnRelease()
end

return WinterNightStoryPanel
