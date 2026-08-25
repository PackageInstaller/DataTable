local CommonPopupFullTips, Super = System.NewComponent("CommonPopupFullTips")

function CommonPopupFullTips:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Common_Popup_Tips_FullResource(uiNode)
  self.data = data
end

function CommonPopupFullTips:OnBind(binder)
  self.binder = binder
  if self.data.textTitleCN then
    binder:BindToText(self.ui.Text_Title, function()
      return self.data.textTitleCN
    end)
  end
  if self.data.textTitleEN then
    binder:BindToText(self.ui.Text_Title_En, function()
      return self.data.textTitleEN
    end)
  end
end

return CommonPopupFullTips
