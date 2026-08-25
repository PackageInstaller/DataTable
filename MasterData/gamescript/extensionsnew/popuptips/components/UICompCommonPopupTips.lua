local PopupTipsType = CommonDefine.PopupTipsType
local UICompCommonPopupTips, Super = NewViewComponent("UICompCommonPopupTips")

function UICompCommonPopupTips:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  local sizeTypeResourceMap = {
    [PopupTipsType.S] = UI_Common_Popup_Tips_SResource,
    [PopupTipsType.L] = UI_Common_Popup_Tips_LResource
  }
  self.ui = sizeTypeResourceMap[data.sizeType](uiNode)
  self._data = data
  self._clickFunc = data.clickFunc
end

function UICompCommonPopupTips:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, self._clickFunc)
  self:AddButtonClickListener(self.ui.Btn_Mask, self._clickFunc)
end

function UICompCommonPopupTips:OnEnterComponent()
  self:_RefreshText()
end

function UICompCommonPopupTips:OnExitComponent()
  Super.OnExitComponent(self)
end

function UICompCommonPopupTips:_RefreshText()
  local textTitleCN = self._data.textTitleCN
  if textTitleCN then
    self:SetText(self.ui.Text_Title, LT.Text(textTitleCN))
  end
end

return UICompCommonPopupTips
