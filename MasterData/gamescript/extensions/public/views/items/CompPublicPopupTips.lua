local TYPOF_UIANIMATIONCONTROLLER = typeof(CS.Z1Client.UIAnimationController)
local ConfirmTipsType = CommonDefine.ConfirmTipsType
local CompPublicPopupTips, Super = NewViewComponent("CompPublicPopupTips")

function CompPublicPopupTips:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  local sizeTypeResourceMap = {
    [ConfirmTipsType.L] = UI_Common_Popup_Tips_LResource,
    [ConfirmTipsType.S] = UI_Common_Popup_Tips_SResource
  }
  self.ui = sizeTypeResourceMap[data.sizeType](uiNode)
  self.data = data
  self.animCtrl = self.ui.uiNode:GetComponent(TYPOF_UIANIMATIONCONTROLLER)
end

function CompPublicPopupTips:OnEnterComponent()
  local data = self.data
  self:_OnInitBtns()
  if not data.banMaskClick and (data.maskClickFunc or self.data and self.data.clickFunc) then
    self:AddButtonClickListener(self.ui.Btn_Mask, function()
      if data.maskClickFunc then
        data.maskClickFunc()
        return
      end
      if self.data and self.data.clickFunc then
        self.data.clickFunc()
      end
    end)
  end
  if data.textTitleCN then
    self:SetText(self.ui.Text_Title, LT.Text(data.textTitleCN))
  end
end

function CompPublicPopupTips:_OnInitBtns(itemObj, clickFunc)
  self:RemoveButtonClickListener(self.ui.UI_Common_Btn_Back1)
  self:RemoveButtonClickListener(self.ui.Btn_Mask)
  if self.data and self.data.clickFunc then
    self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, self.data.clickFunc)
    self:AddButtonClickListener(self.ui.Btn_Mask, self.data.clickFunc)
  end
end

function CompPublicPopupTips:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompPublicPopupTips
