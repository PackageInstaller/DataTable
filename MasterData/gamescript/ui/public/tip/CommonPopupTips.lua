local PopupTipsType = CommonDefine.PopupTipsType
local CommonPopupTips, Super = System.NewComponent("CommonPopupTips")

function CommonPopupTips:ctor(uiNode, data)
  Super.ctor(self)
  local sizeTypeResourceMap = {
    [PopupTipsType.S] = UI_Common_Popup_Tips_SResource,
    [PopupTipsType.L] = UI_Common_Popup_Tips_LResource
  }
  self.ui = sizeTypeResourceMap[data.sizeType](uiNode)
  self.data = data
end

function CommonPopupTips:OnBind(binder)
  self.binder = binder
  if self.data.textTitleCN then
    binder:BindToText(self.ui.Text_Title, function()
      return self.data.textTitleCN
    end)
  end
  if self.data.clickFunc then
    binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, function()
      self.data.clickFunc()
    end)
  end
  if self.data.clickFunc then
    binder:BindButtonClick(self.ui.Btn_Mask, function()
      self.data.clickFunc()
    end)
  end
end

return CommonPopupTips
