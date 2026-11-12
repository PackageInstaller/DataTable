local BasePanel = require("GameCore.UI.BasePanel")
local GunStormStoryPanel = class("GunStormStoryPanel", BasePanel)
GunStormStoryPanel._tbDefine = {
  {
    sPrefabPath = "ActivityStoryReview/10109/GunStormStoryPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.10109.Story.GunStormStoryCtrl"
  },
  {
    sPrefabPath = "ActivityStoryReview/ActivityStoryReceivePanel.prefab",
    sCtrlName = "Game.UI.ActivityStoryReview.ActivityStoryReceiveCtrl"
  }
}

function GunStormStoryPanel:Awake()
  if self._tbParam[2] ~= true then
    self._tbDefine = {
      self._tbDefine[1]
    }
  end
end

function GunStormStoryPanel:OnEnable()
end

function GunStormStoryPanel:OnDisable()
end

function GunStormStoryPanel:OnDestroy()
end

function GunStormStoryPanel:OnRelease()
end

return GunStormStoryPanel
