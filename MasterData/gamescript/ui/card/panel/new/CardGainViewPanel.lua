local CardGainViewPanel, Super = System.NewClass("CardGainViewPanel", UIBasePanel)
CardGainViewPanel.uiResCls = Panel_Operating_CardInfoResource

function CardGainViewPanel:ctor(uid, tid, callback)
  Super.ctor(self)
  self.uid = uid
  self.tid = tid
  self.callback = callback
  self.tips = Vue.ref({})
end

function CardGainViewPanel:OnBind(binder)
  binder:BindComponent(CardBaseComponent(self.ui.Item_Card_Base, nil, self.tid))
  binder:BindButtonClick(self.ui.Btn_Cancel, System.fn(self, self.OnClickCancel))
  binder:BindZ1Button(self.ui.Btn_Confirm, System.fn(self, self.OnClickGain), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "Event_SelectCard_String_1"
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

function CardGainViewPanel:OnClickCancel()
  Logger.Debug("CardGainViewPanel: Gain Close")
  self:Close()
end

function CardGainViewPanel:OnClickGain()
  if self.callback and self.uid then
    self.callback(self.uid, System.fn(self, self.OnClickCancel))
  end
end

return CardGainViewPanel
