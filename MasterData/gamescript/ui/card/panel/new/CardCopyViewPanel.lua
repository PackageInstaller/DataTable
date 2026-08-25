local CardCopyViewPanel, Super = System.NewClass("CardCopyViewPanel", UIBasePanel)
CardCopyViewPanel.uiResCls = Panel_Operating_CopyResource

function CardCopyViewPanel:ctor(uid, tid, copyCb)
  Super.ctor(self)
  self.uid = uid
  self.tid = tid
  self.copyCb = copyCb
  self.tips = Vue.ref({})
end

function CardCopyViewPanel:OnBind(binder)
  binder:BindComponent(CardBaseComponent(self.ui.Item_Card_Base, nil, self.tid))
  binder:BindButtonClick(self.ui.Btn_Cancel, System.fn(self, self.OnClickCancel))
  binder:BindZ1Button(self.ui.Btn_Copy, System.fn(self, self.OnClickCopy), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "Event_CopyCard_String_3"
  end)
  self.tips.value = CardDataUtils.GetCardKeywordTips(self.tid)
  binder:BindToCircularListView(self.ui.ScrollView_Tips_List, function()
    return self.tips.value
  end, function(itemBinder, item, index)
    itemBinder:BindComponent(CardKeyWordTipItem(item, nil, self.tips.value[index]))
  end)
end

function CardCopyViewPanel:OnClickCancel()
  self:Close()
end

function CardCopyViewPanel:OnClickCopy()
  if self.copyCb then
    self.copyCb(self.uid, System.fn(self, self.OnClickCancel))
  end
end

return CardCopyViewPanel
