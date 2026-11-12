local BasePanel = require("GameCore.UI.BasePanel")
local SwimThemeStoryPanel = class("SwimThemeStoryPanel", BasePanel)
SwimThemeStoryPanel._tbDefine = {
  {
    sPrefabPath = "ActivityStoryReview/Swim/SwimThemeStoryPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.Swim.Story.SwimThemeStoryCtrl"
  },
  {
    sPrefabPath = "ActivityStoryReview/ActivityStoryReceivePanel.prefab",
    sCtrlName = "Game.UI.ActivityStoryReview.ActivityStoryReceiveCtrl"
  }
}

function SwimThemeStoryPanel:Awake()
  if self._tbParam[2] ~= true then
    self._tbDefine = {
      self._tbDefine[1]
    }
  end
end

function SwimThemeStoryPanel:OnEnable()
end

function SwimThemeStoryPanel:OnDisable()
end

function SwimThemeStoryPanel:OnDestroy()
end

function SwimThemeStoryPanel:OnRelease()
end

return SwimThemeStoryPanel
