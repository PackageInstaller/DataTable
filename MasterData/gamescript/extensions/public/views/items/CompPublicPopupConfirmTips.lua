local TYPOF_UIANIMATIONCONTROLLER = typeof(CS.Z1Client.UIAnimationController)
local ConfirmTipsType = CommonDefine.ConfirmTipsType
local CompPublicPopupConfirmTips, Super = NewViewComponent("CompPublicPopupConfirmTips")

function CompPublicPopupConfirmTips:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  local sizeTypeResourceMap = {
    [ConfirmTipsType.L] = UI_Common_Popup_Tips_Confirm_LResource,
    [ConfirmTipsType.S] = UI_Common_Popup_Tips_Confirm_SResource,
    [ConfirmTipsType.M] = UI_Common_Popup_Tips_Confirm_MResource
  }
  self.ui = sizeTypeResourceMap[data.sizeType](uiNode)
  self.data = data
  self.animCtrl = self.ui.uiNode:GetComponent(TYPOF_UIANIMATIONCONTROLLER)
end

function CompPublicPopupConfirmTips:OnEnterComponent()
  local data = self.data
  local confirmBtnTipsData = data.confirmBtnTipsData
  local cancelBtnTipsData = data.cancelBtnTipsData
  self:_OnInitBtn(self.ui.Btn_Confirm, confirmBtnTipsData, System.fn(self, self._GetConfirmBtnText))
  self:_OnInitBtn(self.ui.Btn_Cancel, cancelBtnTipsData, System.fn(self, self._GetCancelBtnText))
  if not data.banMaskClick and (data.maskClickFunc or cancelBtnTipsData and cancelBtnTipsData.clickFunc) then
    self:AddButtonClickListener(self.ui.Btn_Mask, function()
      if data.maskClickFunc then
        data.maskClickFunc()
        return
      end
      if cancelBtnTipsData and cancelBtnTipsData.clickFunc then
        cancelBtnTipsData.clickFunc()
      end
    end)
  end
  if data.textTitleCN then
    self:SetText(self.ui.Text_Title, LT.Text(data.textTitleCN))
  end
  if data.textTitleCN then
    self:SetText(self.ui.Text_Title_En, LT.Text(data.textTitleEN))
  end
end

function CompPublicPopupConfirmTips:_OnInitBtn(itemObj, btnTipsData, getTextFunc)
  if btnTipsData then
    local btnState = btnTipsData.stateFunc and btnTipsData.stateFunc() or CommonDefine.BtnType.High
    self:AddButtonClickListener(itemObj, btnTipsData.clickFunc)
    self:SetButtonState(itemObj, btnState)
    self:SetButtonText(itemObj, getTextFunc(btnTipsData))
    self:SetButtonRedPoint(itemObj, btnTipsData.redFunc)
  end
end

function CompPublicPopupConfirmTips:_GetConfirmBtnText(confirmBtnTipsData)
  return (not confirmBtnTipsData.text or confirmBtnTipsData.text == "") and LT.Text("UniversalConfirmButton") or LT.Text(confirmBtnTipsData.text)
end

function CompPublicPopupConfirmTips:_GetCancelBtnText(cancelBtnTipsData)
  return (not cancelBtnTipsData.text or cancelBtnTipsData.text == "") and LT.Text("UniversalCancelButton") or LT.Text(cancelBtnTipsData.text)
end

function CompPublicPopupConfirmTips:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompPublicPopupConfirmTips
