local ConfirmTipsType = CommonDefine.ConfirmTipsType
local CommonPopupConfirmTips, Super = System.NewComponent("CommonPopupConfirmTips")

function CommonPopupConfirmTips:ctor(uiNode, data)
  Super.ctor(self)
  local sizeTypeResourceMap = {
    [ConfirmTipsType.L] = UI_Common_Popup_Tips_Confirm_LResource,
    [ConfirmTipsType.S] = UI_Common_Popup_Tips_Confirm_SResource,
    [ConfirmTipsType.M] = UI_Common_Popup_Tips_Confirm_MResource
  }
  self.ui = sizeTypeResourceMap[data.sizeType](uiNode)
  self.data = data
  self.banMaskClick = data.banMaskClick
end

function CommonPopupConfirmTips:OnBind(binder)
  self.binder = binder
  self.animCtrl = self.ui.uiNode:GetComponent(typeof(CS.Z1Client.UIAnimationController))
  local confirmBtnTipsData = self.data.confirmBtnTipsData
  local cancelBtnTipsData = self.data.cancelBtnTipsData
  if confirmBtnTipsData then
    binder:BindZ1Button(self.ui.Btn_Confirm, confirmBtnTipsData.clickFunc, confirmBtnTipsData.stateFunc, function()
      if not confirmBtnTipsData.textFunc then
        return (not confirmBtnTipsData.text or confirmBtnTipsData.text == "") and LT.Text("UniversalConfirmButton") or LT.Text(confirmBtnTipsData.text)
      end
      do return end
      return confirmBtnTipsData.textFunc, confirmBtnTipsData.text
    end, confirmBtnTipsData.redFunc, nil, nil)
  end
  if cancelBtnTipsData then
    binder:BindZ1Button(self.ui.Btn_Cancel, cancelBtnTipsData.clickFunc, cancelBtnTipsData.stateFunc, function()
      return (not cancelBtnTipsData.text or cancelBtnTipsData.text == "") and LT.Text("UniversalCancelButton") or LT.Text(cancelBtnTipsData.text)
    end, cancelBtnTipsData.redFunc, nil, nil)
  end
  if not self.banMaskClick and (self.data.maskClickFunc or cancelBtnTipsData and cancelBtnTipsData.clickFunc) then
    binder:BindButtonClick(self.ui.Btn_Mask, function()
      if self.data.maskClickFunc then
        self.data.maskClickFunc()
        return
      end
      if cancelBtnTipsData and cancelBtnTipsData.clickFunc then
        cancelBtnTipsData.clickFunc()
      end
    end)
  end
  if self.data.textTitleCN then
    binder:BindToText(self.ui.Text_Title, function()
      do return LT.Text end
      return LT.Text, self.data.textTitleCN
    end)
  end
  if self.data.textTitleEN then
    binder:BindToText(self.ui.Text_Title_En, function()
      do return LT.Text end
      return LT.Text, self.data.textTitleEN
    end)
  end
end

return CommonPopupConfirmTips
