local ActivityStoryReviewPanel = class("ActivityStoryReviewPanel", BasePanel)
ActivityStoryReviewPanel._tbDefine = {
  {
    sPrefabPath = "ActivityStoryReview/ActivityStoryReviewPanel.prefab",
    sCtrlName = "Game.UI.ActivityStoryReview.ActivityStoryReviewCtrl"
  }
}

function ActivityStoryReviewPanel:Awake()
end

function ActivityStoryReviewPanel:OnEnable()
end

function ActivityStoryReviewPanel:OnAfterEnter()
end

function ActivityStoryReviewPanel:OnDisable()
end

function ActivityStoryReviewPanel:OnDestroy()
end

function ActivityStoryReviewPanel:OnRelease()
end

return ActivityStoryReviewPanel
