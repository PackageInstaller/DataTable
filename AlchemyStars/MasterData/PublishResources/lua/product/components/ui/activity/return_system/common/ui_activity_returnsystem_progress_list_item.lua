_class("UIActivityReturnSystemProgressListItem", UICustomWidget)
UIActivityReturnSystemProgressListItem = UIActivityReturnSystemProgressListItem

function UIActivityReturnSystemProgressListItem:OnShow(uiParams)
end

function UIActivityReturnSystemProgressListItem:OnHide()
end

function UIActivityReturnSystemProgressListItem:SetData(campaign, component, progress, callback, tipsCallback)
  self._campaign = campaign
  self._component = component
  self._progress = progress
  self._callback = callback
  self._tipsCallback = tipsCallback
  self:_Refresh()
end

function UIActivityReturnSystemProgressListItem:_Refresh()
  self._state = self._component:CheckItemStatus(self._progress)
  self:_SetState(self._state)
  self:_SetArrow(self._state)
  self:_SetItem()
end

function UIActivityReturnSystemProgressListItem:_SetState(state)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {
      "state_Accepted"
    },
    {
      "state_Completed",
      "state_Completed_bg"
    },
    {
      "state_Taken"
    }
  }, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UIActivityReturnSystemProgressListItem:_SetArrow(state)
  local obj = UIWidgetHelper.SpawnObject(self, "_arrowPool", "UIActivityReturnSystemProgressArrow")
  obj:SetData(self._progress, state)
end

function UIActivityReturnSystemProgressListItem:_SetItem()
  local rewards = self._component:GetProgressRewards(self._progress)
  self._roleAsset = rewards and rewards[1]
  local cfg_item = Cfg.cfg_item[self._roleAsset.assetid]
  if cfg_item == nil then
    Log.fatal("[quest] error --> cfg_item is nil ! id --> " .. self._roleAsset.assetid)
    return
  end
  local obj = UIWidgetHelper.SpawnObject(self, "_itemPool", "UIItem")
  obj:SetForm(UIItemForm.Base, self._scale)
  local icon = cfg_item.Icon
  local quality = cfg_item.Color
  local text1 = self._roleAsset.count
  obj:SetData({
    icon = icon,
    quality = quality,
    text1 = text1,
    itemId = self._roleAsset.assetid
  })
end

function UIActivityReturnSystemProgressListItem:AcceptedOnClick(go)
  if self._tipsCallback then
    self._tipsCallback(self._roleAsset.assetid, go.transform.position)
  end
end

function UIActivityReturnSystemProgressListItem:CompletedOnClick(go)
  if self._callback then
    self._callback(self._progress)
  end
end
