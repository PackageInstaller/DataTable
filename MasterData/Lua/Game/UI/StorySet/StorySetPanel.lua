local StorySetPanel = class("StorySetPanel", BasePanel)
StorySetPanel._tbDefine = {
  {
    sPrefabPath = "Play_StorySet/StorySetPanel.prefab",
    sCtrlName = "Game.UI.StorySet.StorySetCtrl"
  }
}

function StorySetPanel:Awake()
end

function StorySetPanel:OnEnable()
end

function StorySetPanel:OnAfterEnter()
end

function StorySetPanel:OnDisable()
end

function StorySetPanel:OnDestroy()
end

function StorySetPanel:OnRelease()
end

return StorySetPanel
