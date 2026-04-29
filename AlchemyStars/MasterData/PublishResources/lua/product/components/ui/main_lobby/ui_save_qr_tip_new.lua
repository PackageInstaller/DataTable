_class("UISaveQRTipNew", UIController)
UISaveQRTipNew = UISaveQRTipNew

function UISaveQRTipNew:OnShow(uiParams)
end

function UISaveQRTipNew:OnHide()
end

function UISaveQRTipNew:InitUI()
end

function UISaveQRTipNew:ButtonOkOnClick()
  local module = GameGlobal.GetModule(LoginModule)
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local str = module:GetSaveStr()
  GetQR_Local.SaveFile(str)
  local roleModule = GameGlobal.GetModule(RoleModule)
  roleModule:GameSingleSaveChoosePainting()
  ToastManager.ShowToast(StringTable.Get("str_set_download_success"))
  self:CloseDialog()
end

function UISaveQRTipNew:ButtonHelpOnClick()
  self:ShowDialog("UISaveQRDetail")
end
