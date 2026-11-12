local BasePanel = require("GameCore.UI.BasePanel")
local ChristmasStoryPanel = class("ChristmasStoryPanel", BasePanel)
ChristmasStoryPanel._tbDefine = {
  {
    sPrefabPath = "ActivityStoryReview/20101/ChristmasStoryPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.20101.Story.ChristmasStoryCtrl"
  },
  {
    sPrefabPath = "ActivityStoryReview/ActivityStoryReceivePanel.prefab",
    sCtrlName = "Game.UI.ActivityStoryReview.ActivityStoryReceiveCtrl"
  }
}

function ChristmasStoryPanel:Awake()
  if self._tbParam[2] ~= true then
    self._tbDefine = {
      self._tbDefine[1]
    }
  end
end

function ChristmasStoryPanel:OnEnable()
end

function ChristmasStoryPanel:OnDisable()
end

function ChristmasStoryPanel:OnDestroy()
end

function ChristmasStoryPanel:OnRelease()
end

return ChristmasStoryPanel
