_class("UIReviewProgressAwardDetailItem", UICustomWidget)
UIReviewProgressAwardDetailItem = UIReviewProgressAwardDetailItem

function UIReviewProgressAwardDetailItem:SetData(id, count, progress, collected, canCollect, onClick, collectCallback)
  self:_SetAwardIcon(id)
  self:_SetAwardCount(count)
  self:_SetProgress(progress)
  self._progress = progress
  local state = 1
  if collected then
    state = 3
  elseif canCollect then
    state = 2
  else
    state = 1
  end
  self:_SetState(state)
  self._onClick = onClick
  self._collectCallback = collectCallback
  self._itemID = id
end

function UIReviewProgressAwardDetailItem:_SetAwardIcon(id)
  local url = Cfg.cfg_item[id].Icon
  UIWidgetHelper.SetRawImage(self, "icon", url)
end

function UIReviewProgressAwardDetailItem:_SetAwardCount(count)
  UIWidgetHelper.SetLocalizationText(self, "count", "x" .. count)
end

function UIReviewProgressAwardDetailItem:_SetProgress(num)
  local tb = {"progress"}
  for _, w in ipairs(tb) do
    UIWidgetHelper.SetLocalizationText(self, w, num .. "%")
  end
end

function UIReviewProgressAwardDetailItem:_SetState(state)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {
      "cantCollect"
    },
    {"canCollect"},
    {"collected"}
  }, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UIReviewProgressAwardDetailItem:PlayEnterAni(index)
  local delay = 0 + (index - 1) * 50
  UIWidgetHelper.PlayAnimationInSequence(self, "_anim", nil, "uieffanim_UIReviewProgressAwardDetailItem_in", delay)
end

function UIReviewProgressAwardDetailItem:IconOnClick(go)
  self._onClick(self._itemID, go)
end

function UIReviewProgressAwardDetailItem:CollectBtnOnClick(go)
  self._collectCallback(self._progress)
end
