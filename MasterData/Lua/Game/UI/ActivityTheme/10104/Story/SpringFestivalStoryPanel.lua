local BasePanel = require("GameCore.UI.BasePanel")
local SpringFestivalStoryPanel = class("SpringFestivalStoryPanel", BasePanel)
SpringFestivalStoryPanel._tbDefine = {
  {
    sPrefabPath = "ActivityStoryReview/10104/SpringThemeStoryPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.10104.Story.SpringFestivalStoryCtrl"
  },
  {
    sPrefabPath = "ActivityStoryReview/ActivityStoryReceivePanel.prefab",
    sCtrlName = "Game.UI.ActivityStoryReview.ActivityStoryReceiveCtrl"
  }
}

function SpringFestivalStoryPanel:Awake()
  if self._tbParam[2] ~= true then
    self._tbDefine = {
      self._tbDefine[1]
    }
  end
end

function SpringFestivalStoryPanel:OnEnable()
end

function SpringFestivalStoryPanel:OnDisable()
end

function SpringFestivalStoryPanel:OnDestroy()
end

function SpringFestivalStoryPanel:OnRelease()
end

return SpringFestivalStoryPanel
