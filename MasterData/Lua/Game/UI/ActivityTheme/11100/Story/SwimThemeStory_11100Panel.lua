local BasePanel = require("GameCore.UI.BasePanel")
local SwimThemeStory_11100Panel = class("SwimThemeStory_11100Panel", BasePanel)
SwimThemeStory_11100Panel._tbDefine = {
  {
    sPrefabPath = "ActivityStoryReview/11100/SwimThemeStoryPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.11100.Story.SwimThemeStory_11100Ctrl"
  },
  {
    sPrefabPath = "ActivityStoryReview/ActivityStoryReceivePanel.prefab",
    sCtrlName = "Game.UI.ActivityStoryReview.ActivityStoryReceiveCtrl"
  }
}

function SwimThemeStory_11100Panel:Awake()
  if self._tbParam[2] ~= true then
    self._tbDefine = {
      self._tbDefine[1]
    }
  end
end

function SwimThemeStory_11100Panel:OnEnable()
end

function SwimThemeStory_11100Panel:OnDisable()
end

function SwimThemeStory_11100Panel:OnDestroy()
end

function SwimThemeStory_11100Panel:OnRelease()
end

return SwimThemeStory_11100Panel
