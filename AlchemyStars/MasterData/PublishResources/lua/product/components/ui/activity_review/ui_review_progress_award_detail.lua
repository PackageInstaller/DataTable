_class("UIReviewProgressAwardDetail", UIController)
UIReviewProgressAwardDetail = UIReviewProgressAwardDetail

function UIReviewProgressAwardDetail:OnShow(uiParams)
  local campaignType = uiParams and uiParams[1]
  local cfg = uiParams and uiParams[2]
  Log.info("UIReviewProgressAwardDetail:OnShow() cfg_activity_review_ui_progress[", cfg and cfg.ID or 0, "]")
  local contentClassName = cfg and cfg.ClassContent or "UIReviewProgressAwardDetailContent"
  local contentPrefabName = cfg and cfg.PrefabContent or "UIReviewProgressAwardDetailContent.prefab"
  local itemClassName = cfg and cfg.ClassContentItem or "UIReviewProgressAwardDetailItem"
  local itemPrefabName = cfg and cfg.PrefabContentItem or "UIReviewProgressAwardDetailItem.prefab"
  local obj = UIWidgetHelper.SpawnObject(self, "_pool", contentClassName, contentPrefabName)
  obj:SetData(self, function(id, go)
    local obj = UIWidgetHelper.SpawnObject(self, "selectInfo", "UISelectInfo")
    obj:SetData(id, go.transform.position)
  end, campaignType, itemClassName, itemPrefabName)
end
