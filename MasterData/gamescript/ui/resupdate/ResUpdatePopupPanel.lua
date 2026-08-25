local ResUpdatePopupPanel, Super = System.NewClass("ResUpdatePopupPanel", UIBasePanel)
ResUpdatePopupPanel.uiResCls = UI_Login_ResUpdate_PopupResource

function ResUpdatePopupPanel:ctor(confirmFunc)
  Super.ctor(self)
  self.confirmFunc = confirmFunc
end

function ResUpdatePopupPanel:OnBind(binder)
  self.binder = binder
  local tipConfig = DT.TipsType[20100]
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self.OnConfirmClick),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.S,
    confirmBtnTipsData = confirmBtnTipsData,
    textTitleCN = tipConfig.Title and LT.Text(tipConfig.Title) or LT.Text("UniversalAlertTitle")
  }
  self.binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_Confirm_S, commonPopupConfirmTipsData))
  self.ui.Btn_Cancel:SetActive(false)
  self.binder:SetText(self.ui.Text_detail, LT.Text(tipConfig.Desc))
end

function ResUpdatePopupPanel:OnConfirmClick()
  Main.DisableNextTick()
  if self.confirmFunc then
    self.confirmFunc()
  end
  self:Close()
  ApplicationUtils.ExitGame()
end

return ResUpdatePopupPanel
