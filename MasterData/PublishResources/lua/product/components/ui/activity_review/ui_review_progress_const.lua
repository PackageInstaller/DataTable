_class("UIReviewProgressConst", UICustomWidget)
UIReviewProgressConst = UIReviewProgressConst

function UIReviewProgressConst.SpawnObject(uiView, widgetName, reviewData)
  local id = reviewData and reviewData:ActivityID() or 0
  local cfg = Cfg.cfg_activity_review_ui_progress[id]
  if not cfg then
    Log.exception("UIReviewProgressConst.SpawnObject() cfg_activity_review_ui_progress[", id, "] = nil")
    return
  end
  local progress = UIWidgetHelper.SpawnObject(uiView, widgetName, "UIReviewProgress", cfg.PrefabProgress)
  progress:SetData(reviewData, cfg)
  return progress
end
