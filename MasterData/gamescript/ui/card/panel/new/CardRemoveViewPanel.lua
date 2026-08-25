local CardRemoveViewPanel, Super = System.NewClass("CardRemoveViewPanel", UIBasePanel)
CardRemoveViewPanel.uiResCls = Panel_Operating_RemoveResource

function CardRemoveViewPanel:ctor(uid, tid, removeCb)
  Super.ctor(self)
  self.uid = uid
  self.tid = tid
  self.removeCb = removeCb
  self.tips = Vue.ref({})
end

function CardRemoveViewPanel:OnBind(binder)
  binder:BindComponent(CardBaseComponent(self.ui.Item_Card_Base, nil, self.tid))
  binder:BindButtonClick(self.ui.Btn_Cancel, System.fn(self, self.OnClickCancel))
  binder:BindZ1Button(self.ui.Btn_Remove, System.fn(self, self.OnClickRemove), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "Event_DeleteCard_String_3"
  end)
  if self.tid then
    self.tips.value = CardDataUtils.GetCardKeywordTips(self.tid)
    binder:BindToCircularListView(self.ui.ScrollView_Tips_List, function()
      return self.tips.value
    end, function(itemBinder, item, index)
      itemBinder:BindComponent(CardKeyWordTipItem(item, nil, self.tips.value[index]))
    end)
  end
end

function CardRemoveViewPanel:OnClickCancel()
  Logger.Debug("CardRemoveViewPanel: Remove Close")
  self:Close()
end

function CardRemoveViewPanel:OnClickRemove()
  if self.removeCb and self.uid then
    self.removeCb(self.uid, System.fn(self, self.OnClickCancel))
  end
end

return CardRemoveViewPanel
