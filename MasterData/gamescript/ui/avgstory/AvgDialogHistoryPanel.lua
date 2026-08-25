local AvgDialogHistoryPanel, Super = System.NewClass("AvgDialogHistoryPanel", UIBasePanel)
AvgDialogHistoryPanel.uiResCls = UI_Story_Popup_History_TextResource

function AvgDialogHistoryPanel:ctor(histList)
  Super.ctor(self)
  self.histList = Vue.ref(histList)
end

function AvgDialogHistoryPanel:OnBind(binder)
  self.binder = binder
  self.scrollRect = self.ui.ScrollView:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
  self.loopListView = self.ui.ScrollView:GetComponent(typeof(CS.Z1ScrollView.LoopListView))
  self.adaptaionSpacing = self.loopListView.mAdaptationSpacing
  self.closeBtn = binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    self:Close()
  end))
  binder:BindButtonClick(self.ui.Button_Block, System.fn(self, self.Close))
  binder:BindEvent(EventMgr.Instance.OnStoryEnd, System.fn(self, self.Close))
  binder:BindRawTable(function()
    return self.histList.value
  end, function()
    self.histList.value = self.histList.value
  end)
  binder:BindExpandListView(self.ui.ScrollView, function()
    return self.histList.value
  end, function()
    return "UI_Story_Item_History_Text"
  end, function(itemBinder, item, index)
    local histData = self.histList.value[index]
    itemBinder:BindComponent(AvgDialogHistoryText(item, histData, self.histList, self.adaptaionSpacing))
  end)
  if #self.histList.value > 0 then
    binder:ListViewJumpToIndex(self.ui.ScrollView, #self.histList.value)
  end
end

function AvgDialogHistoryPanel:Close()
  self.closeBtn:PlayCloseAnim()
  Super.Close(self)
end

function AvgDialogHistoryPanel:OnUnbind()
end

return AvgDialogHistoryPanel
