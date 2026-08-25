local ConfirmTipsType = CommonDefine.ConfirmTipsType
local TYPEOF_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local UICompCommonPopupConfirmTips, Super = NewViewComponent("UICompCommonPopupConfirmTips")

function UICompCommonPopupConfirmTips:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  local SizeTypeResourceMap = {
    [ConfirmTipsType.L] = UI_Common_Popup_Tips_Confirm_LResource,
    [ConfirmTipsType.S] = UI_Common_Popup_Tips_Confirm_SResource,
    [ConfirmTipsType.M] = UI_Common_Popup_Tips_Confirm_MResource
  }
  self.ui = SizeTypeResourceMap[data.sizeType](uiNode)
  self._data = data
  self._banMaskClick = data.banMaskClick
end

function UICompCommonPopupConfirmTips:OnEnterComponent()
  self.animCtrl = self.ui.uiNode:GetComponent(TYPEOF_UIAnimationController)
  local confirmBtnTipsData = self._data.confirmBtnTipsData
  local cancelBtnTipsData = self._data.cancelBtnTipsData
  if confirmBtnTipsData then
    self:_SetConfirmBtn(confirmBtnTipsData)
  end
  if cancelBtnTipsData then
    self:_SetCancelBtn(cancelBtnTipsData)
  end
  if not self._banMaskClick and (self._data.maskClickFunc or cancelBtnTipsData and cancelBtnTipsData.clickFunc) then
    self:AddButtonClickListener(self.ui.Btn_Mask, function()
      if self._data.maskClickFunc then
        self._data.maskClickFunc()
        return
      end
      if cancelBtnTipsData and cancelBtnTipsData.clickFunc then
        cancelBtnTipsData.clickFunc()
      end
    end)
  end
  if self._data.textTitleCN then
    self:SetText(self.ui.Text_Title, LT.Text(self._data.textTitleCN))
  end
  if self._data.textTitleEN then
    self:SetText(self.ui.Text_Title_En, LT.Text(self._data.textTitleEN))
  end
end

function UICompCommonPopupConfirmTips:_SetConfirmBtn(btnTipsData)
  if btnTipsData.clickFunc then
    self:AddButtonClickListener(self.ui.Btn_Confirm, btnTipsData.clickFunc)
  end
  if btnTipsData.stateFunc then
    self:SetButtonState(self.ui.Btn_Confirm, btnTipsData.stateFunc())
  end
  local text
  if btnTipsData.textFunc then
    text = btnTipsData.textFunc()
  else
    text = (not btnTipsData.text or btnTipsData.text == "") and LT.Text("UniversalConfirmButton") or LT.Text(btnTipsData.text)
  end
  self:SetButtonText(self.ui.Btn_Confirm, text)
  if btnTipsData.redFunc then
    self:SetButtonRedPoint(self.ui.Btn_Confirm, btnTipsData.redFunc)
  end
end

function UICompCommonPopupConfirmTips:_SetCancelBtn(btnTipsData)
  if btnTipsData.clickFunc then
    self:AddButtonClickListener(self.ui.Btn_Cancel, btnTipsData.clickFunc)
  end
  if btnTipsData.stateFunc then
    self:SetButtonState(self.ui.Btn_Cancel, btnTipsData.stateFunc())
  end
  local text = (not btnTipsData.text or btnTipsData.text == "") and LT.Text("UniversalCancelButton") or LT.Text(btnTipsData.text)
  self:SetButtonText(self.ui.Btn_Cancel, text)
  if btnTipsData.redFunc then
    self:SetButtonRedPoint(self.ui.Btn_Cancel, btnTipsData.redFunc)
  end
end

return UICompCommonPopupConfirmTips
