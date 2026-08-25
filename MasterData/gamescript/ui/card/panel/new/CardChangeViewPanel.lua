local CardChangeViewPanel, Super = System.NewClass("CardChangeViewPanel", UIBasePanel)
CardChangeViewPanel.uiResCls = Panel_Operating_ChangeResource

function CardChangeViewPanel:ctor(uid, tid, changeTid, changeCb)
  Super.ctor(self)
  self.uid = uid
  self.tid = tid
  self.changeTid = changeTid
  self.changeCb = changeCb
  self.tips = Vue.ref({})
end

function CardChangeViewPanel:OnBind(binder)
  binder:BindComponent(CardBaseComponent(self.ui.Item_Card_Base, nil, self.tid))
  binder:BindButtonClick(self.ui.Btn_Cancel, System.fn(self, self.OnClickCancel))
  binder:BindZ1Button(self.ui.Btn_Change, System.fn(self, self.OnClickChange), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "Event_ChangeCard_String_3"
  end)
  self.tips.value = CardDataUtils.GetCardKeywordTips(self.tid)
  Logger.Debug("tipslength: " .. #self.tips.value)
  binder:BindToCircularListView(self.ui.ScrollView_Tips_List, function()
    return self.tips.value
  end, function(itemBinder, item, index)
    itemBinder:BindComponent(CardKeyWordTipItem(item, nil, self.tips.value[index]))
  end)
  if self.changeId then
    binder:BindComponent(CardBaseComponent(self.ui.Item_Card_Base2, nil, self.changeTid))
  end
end

function CardChangeViewPanel:OnClickCancel()
  self:Close()
end

function CardChangeViewPanel:OnClickChange()
  if self.changeCb then
    Logger.Debug("changeCb")
    self.changeCb(self.uid, System.fn(self, self.OnClickCancel))
  end
end

return CardChangeViewPanel
