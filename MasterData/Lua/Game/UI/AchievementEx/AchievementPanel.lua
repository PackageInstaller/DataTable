local AchievementPanel = class("AchievementPanel", BasePanel)
AchievementPanel._tbDefine = {
  {
    sPrefabPath = "AchievementEx/AchievementPanel.prefab",
    sCtrlName = "Game.UI.AchievementEx.AchievementCtrl"
  }
}

function AchievementPanel:Awake()
end

function AchievementPanel:OnEnable()
end

function AchievementPanel:OnAfterEnter()
end

function AchievementPanel:OnDisable()
end

function AchievementPanel:OnDestroy()
end

function AchievementPanel:OnRelease()
end

return AchievementPanel
