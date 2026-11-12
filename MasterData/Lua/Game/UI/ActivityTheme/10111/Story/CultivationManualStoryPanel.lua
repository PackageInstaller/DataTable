local BasePanel = require("GameCore.UI.BasePanel")
local CultivationManualStoryPanel = class("CultivationManualStoryPanel", BasePanel)
CultivationManualStoryPanel._tbDefine = {
  {
    sPrefabPath = "ActivityStoryReview/10111/CultivationManualStoryPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.10111.Story.CultivationManualStoryCtrl"
  },
  {
    sPrefabPath = "ActivityStoryReview/ActivityStoryReceivePanel.prefab",
    sCtrlName = "Game.UI.ActivityStoryReview.ActivityStoryReceiveCtrl"
  }
}

function CultivationManualStoryPanel:Awake()
  if self._tbParam[2] ~= true then
    self._tbDefine = {
      self._tbDefine[1]
    }
  end
end

function CultivationManualStoryPanel:OnEnable()
end

function CultivationManualStoryPanel:OnDisable()
end

function CultivationManualStoryPanel:OnDestroy()
end

function CultivationManualStoryPanel:OnRelease()
end

return CultivationManualStoryPanel
