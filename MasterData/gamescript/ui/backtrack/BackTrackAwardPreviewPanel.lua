local BackTrackAwardPreviewPanel, Super = System.NewClass("BackTrackAwardPreviewPanel", UIBasePanel)
BackTrackAwardPreviewPanel.uiResCls = UI_Awaker_Popup_Preview_TipResource

function BackTrackAwardPreviewPanel:ctor(itemList)
  Super.ctor(self)
  self.itemList = itemList
end

function BackTrackAwardPreviewPanel:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  binder:BindToCircularListView(self.ui.ScrollView, function()
    return self.itemList
  end, function(childBinder, obj, index)
    local itemData = self.itemList[index]
    childBinder:BindComponent(CommonIconItemType2(obj, itemData))
  end)
  local content = self.ui.ScrollView:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect)).content
  local groupCom = content:GetComponent(typeof(CS.UnityEngine.UI.HorizontalLayoutGroup))
  if #self.itemList <= 5 then
    groupCom.enabled = true
    groupCom.childAlignment = CS.UnityEngine.TextAnchor.MiddleCenter
  else
    groupCom.enabled = false
  end
end

return BackTrackAwardPreviewPanel
