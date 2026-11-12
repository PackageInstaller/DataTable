local BasePanel = require("GameCore.UI.BasePanel")
local ViewfinderStoryPanel = class("ViewfinderStoryPanel", BasePanel)
ViewfinderStoryPanel._tbDefine = {
  {
    sPrefabPath = "ActivityStoryReview/10107/ViewfinderStoryPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.10107.Story.ViewfinderStoryCtrl"
  },
  {
    sPrefabPath = "ActivityStoryReview/ActivityStoryReceivePanel.prefab",
    sCtrlName = "Game.UI.ActivityStoryReview.ActivityStoryReceiveCtrl"
  }
}

function ViewfinderStoryPanel:Awake()
  if self._tbParam[2] ~= true then
    self._tbDefine = {
      self._tbDefine[1]
    }
  end
end

function ViewfinderStoryPanel:OnEnable()
end

function ViewfinderStoryPanel:OnDisable()
end

function ViewfinderStoryPanel:OnDestroy()
end

function ViewfinderStoryPanel:OnRelease()
end

return ViewfinderStoryPanel
