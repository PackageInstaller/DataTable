local BasePanel = require("GameCore.UI.BasePanel")
local UnchartedMapStoryPanel = class("UnchartedMapStoryPanel", BasePanel)
UnchartedMapStoryPanel._tbDefine = {
  {
    sPrefabPath = "ActivityStoryReview/10113/UnchartedMapStoryPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.10113.Story.UnchartedMapStoryCtrl"
  },
  {
    sPrefabPath = "ActivityStoryReview/ActivityStoryReceivePanel.prefab",
    sCtrlName = "Game.UI.ActivityStoryReview.ActivityStoryReceiveCtrl"
  }
}

function UnchartedMapStoryPanel:Awake()
  if self._tbParam[2] ~= true then
    self._tbDefine = {
      self._tbDefine[1]
    }
  end
end

return UnchartedMapStoryPanel
