local LoginPVDisplayView, Super = NewClass("LoginPVDisplayView", BaseView)
LoginPVDisplayView.uiResCls = UI_Collection_Panel_SetMainBgResource
local LoginPVDataUtils = require("GameScript.Data.LoginPVDataUtils")
local STEP_PV_PREVIEW = 1
local STEP_PV_TO_SET = 2
local STEP_PV_CONFIRM = 3

function LoginPVDisplayView:ctor(cfg)
  Super.ctor(self)
  self._cfg = cfg
  self._isSetBgClicked = false
  self._isResetManualMode = false
  self._step = STEP_PV_PREVIEW
end

function LoginPVDisplayView:OnBuildView()
  Super.OnBuildView(self)
  self:_SetStep(STEP_PV_PREVIEW)
end

function LoginPVDisplayView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_ShowContent, System.fn(self, self._OnClickShowContent))
  self:AddButtonClickListener(self.ui.Btn_ShowSetPV, System.fn(self, self._OnClickShowSetPV))
  self:AddButtonClickListener(self.ui.Btn_SavePV, System.fn(self, self._OnClickConfirm))
  self:AddButtonClickListener(self.ui.Btn_CancelPV, System.fn(self, self._OnClickCancel))
  self:AddViewComponent(self.ui.UI_Common_Btn_Back2_PV, UICompBtnCloseItem, System.fn(self, self.Close))
  self:SetButtonText(self.ui.Btn_SavePV, LT.Text("UniversalConfirmButton"))
  self:SetButtonText(self.ui.Btn_CancelPV, LT.Text("UniversalCancelButton"))
end

function LoginPVDisplayView:_SetStep(step)
  self._step = step
  if step == STEP_PV_PREVIEW then
    self:_HideOtherNodes()
  else
    self:SetActive(self.ui.Content_LoginPV, step > STEP_PV_PREVIEW)
    self:SetActive(self.ui.UI_Common_Btn_Back2_PV, step > STEP_PV_PREVIEW)
    self:SetActive(self.ui.Btn_ShowSetPV, step == STEP_PV_TO_SET)
    self:SetActive(self.ui.Btn_SavePV, step == STEP_PV_CONFIRM)
    self:SetActive(self.ui.Btn_CancelPV, step == STEP_PV_CONFIRM)
    if step == STEP_PV_TO_SET then
      self:_RefreshSetPVBtnState()
    end
  end
end

function LoginPVDisplayView:_HideOtherNodes()
  self.ui.Image_RT:SetActive(false)
  self.ui.Image_Bg:SetActive(false)
  self.ui.Image_CG:SetActive(false)
  self.ui.Content_CG:SetActive(false)
  self.ui.Content_LoginPV:SetActive(false)
  self.ui.UI_Common_Btn_Back2:SetActive(false)
end

function LoginPVDisplayView:_OnClickShowContent()
  self:_SetStep(STEP_PV_TO_SET)
  self:_StartBackToPreviewTimer()
end

function LoginPVDisplayView:_StartBackToPreviewTimer()
  self:_StopBackToPreviewTimer()
  self._backToPreviewTimer = self:BindTimer(2, 0, nil, function()
    self:_SetStep(STEP_PV_PREVIEW)
  end)
end

function LoginPVDisplayView:_StopBackToPreviewTimer()
  if self._backToPreviewTimer then
    self:StopTimer(self._backToPreviewTimer)
    self._backToPreviewTimer = nil
  end
end

function LoginPVDisplayView:_OnClickShowSetPV()
  if self._isResetManualMode then
    self:_StopBackToPreviewTimer()
    LoginPVDataUtils.ClearManualLoginPV()
    self:_RefreshSetPVBtnState()
    return
  end
  self:_SetStep(STEP_PV_CONFIRM)
  if self._backToPreviewTimer then
    self:StopTimer(self._backToPreviewTimer)
    self._backToPreviewTimer = nil
  end
end

function LoginPVDisplayView:_RefreshSetPVBtnState()
  local currentVideo = self._cfg and self._cfg[2]
  local manualInfo = LoginPVDataUtils.GetManualLoginPVInfo()
  self._isResetManualMode = nil ~= manualInfo and nil ~= currentVideo and manualInfo.video == currentVideo
  local btnTextKey = self._isResetManualMode and "Login_ResetLoginBackground" or "Login_SetLoginBackground"
  self:SetButtonText(self.ui.Btn_ShowSetPV, LT.Text(btnTextKey))
end

function LoginPVDisplayView:_OnClickConfirm()
  self:SaveLoginPV(self._cfg)
  self:_StopBackToPreviewTimer()
  self:Close()
end

function LoginPVDisplayView:SaveLoginPV(cfg)
  local _, pvVideo, pvMusic, pvCaption = table.unpack(cfg)
  LoginPVDataUtils.SetManualLoginPV(pvVideo, pvMusic, pvCaption)
  Logger.Info("LoginPVModifyItem: Save Login PV", pvVideo, pvMusic)
  Alert.Show(10723)
end

function LoginPVDisplayView:_OnClickCancel()
  self:_SetStep(STEP_PV_PREVIEW)
  self:Close()
end

function LoginPVDisplayView:Close()
  Super.Close(self)
  AudioManager.Instance:PostSoundEvent("MAININTERFACE_MUSIC")
  UIManager.Instance:CloseByUrl(Urls.AvgDialogPanelNew)
end

return LoginPVDisplayView
