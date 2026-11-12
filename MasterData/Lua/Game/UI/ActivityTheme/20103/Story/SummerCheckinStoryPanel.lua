local BasePanel = require("GameCore.UI.BasePanel")
local SummerCheckinStoryPanel = class("SummerCheckinStoryPanel", BasePanel)
SummerCheckinStoryPanel._tbDefine = {
  {
    sPrefabPath = "ActivityStoryReview/20103/SummerCheckinStoryPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.20103.Story.SummerCheckinStoryCtrl"
  },
  {
    sPrefabPath = "ActivityStoryReview/ActivityStoryReceivePanel.prefab",
    sCtrlName = "Game.UI.ActivityStoryReview.ActivityStoryReceiveCtrl"
  }
}

function SummerCheckinStoryPanel:Awake()
  if self._tbParam[2] ~= true then
    self._tbDefine = {
      self._tbDefine[1]
    }
  end
end

function SummerCheckinStoryPanel:OnEnable()
end

function SummerCheckinStoryPanel:OnDisable()
end

function SummerCheckinStoryPanel:OnDestroy()
end

function SummerCheckinStoryPanel:OnRelease()
end

return SummerCheckinStoryPanel
