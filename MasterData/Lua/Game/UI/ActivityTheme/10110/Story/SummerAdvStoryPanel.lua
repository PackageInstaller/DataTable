local BasePanel = require("GameCore.UI.BasePanel")
local SummerAdvStoryPanel = class("SummerAdvStoryPanel", BasePanel)
SummerAdvStoryPanel._tbDefine = {
  {
    sPrefabPath = "ActivityStoryReview/10110/SummerAdvStoryPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.10110.Story.SummerAdvStoryCtrl"
  },
  {
    sPrefabPath = "ActivityStoryReview/ActivityStoryReceivePanel.prefab",
    sCtrlName = "Game.UI.ActivityStoryReview.ActivityStoryReceiveCtrl"
  }
}

function SummerAdvStoryPanel:Awake()
  if self._tbParam[2] ~= true then
    self._tbDefine = {
      self._tbDefine[1]
    }
  end
end

function SummerAdvStoryPanel:OnEnable()
end

function SummerAdvStoryPanel:OnDisable()
end

function SummerAdvStoryPanel:OnDestroy()
end

function SummerAdvStoryPanel:OnRelease()
end

return SummerAdvStoryPanel
