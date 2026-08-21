_class("UIActivityTimeLoginProgressListItem", UICustomWidget)
UIActivityTimeLoginProgressListItem = UIActivityTimeLoginProgressListItem

function UIActivityTimeLoginProgressListItem:OnShow(uiParams)
end

function UIActivityTimeLoginProgressListItem:OnHide()
end

function UIActivityTimeLoginProgressListItem:SetData(roleAsset, progress, state, recvCallback, tipsCallback)
  self._roleAsset = roleAsset
  self._recvCallback = recvCallback
  self._tipsCallback = tipsCallback
  UIWidgetHelper.SetLocalizationText(self, "_txtProgress", progress)
  self:_SetItem(roleAsset.assetid, roleAsset.count)
  self:_SetState(state)
end

function UIActivityTimeLoginProgressListItem:_SetItem(itemId, count)
  UIWidgetHelper.SetItemIcon(self, itemId, "_icon")
  UIWidgetHelper.SetLocalizationText(self, "_txtCount", count)
end

function UIActivityTimeLoginProgressListItem:_SetState(state)
  local objs = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {
      "state_Accepted"
    },
    {
      "state_Completed"
    },
    {
      "state_Taken"
    }
  })
  UIWidgetHelper.SetObjGroupShow(objs, state)
end

function UIActivityTimeLoginProgressListItem:AcceptedOnClick(go)
  if self._tipsCallback then
    self._tipsCallback(self._roleAsset.assetid, go.transform.position)
  end
end

function UIActivityTimeLoginProgressListItem:CompletedOnClick(go)
  if self._recvCallback then
    self._recvCallback()
  end
end
