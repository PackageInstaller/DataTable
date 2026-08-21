_class("UISetBindChannelTipsController", UIController)
UISetBindChannelTipsController = UISetBindChannelTipsController

function UISetBindChannelTipsController:OnShow(uiParams)
  self._desLabel = self:GetUIComponent("UILocalizationText", "Des")
  self._channelId = uiParams[1]
  local des = ""
  if self._channelId == EngineGameHelper.SAIchannelId() then
    des = StringTable.Get("str_set_bind_channel_mail_bind_tips")
  elseif self._channelId == MobileClientLoginChannel.MCLC_APPLE then
    des = StringTable.Get("str_set_bind_channel_apple_bind_tips")
  elseif self._channelId == MobileClientLoginChannel.MCLC_GOOGLE_PLAY then
    des = StringTable.Get("str_set_bind_channel_google_bind_tips")
  elseif self._channelId == MobileClientLoginChannel.MCLC_TWITTER then
    des = StringTable.Get("str_set_bind_channel_twitter_bind_tips")
  elseif self._channelId == MobileClientLoginChannel.MCLC_FACEBOOK then
    des = StringTable.Get("str_set_bind_channel_facebook_bind_tips")
  elseif self._channelId == MobileClientLoginChannel.MCLC_LINE then
    des = StringTable.Get("str_set_bind_channel_line_bind_tips")
  elseif self._channelId == MobileClientLoginChannel.MCLC_DMM then
    des = StringTable.Get("str_set_bind_channel_dmm_bind_tips")
  end
  self._desLabel:SetText(des)
  self._oldChannelId = GameGlobal.GameLogic().ClientInfo.m_login_source
end

function UISetBindChannelTipsController:ConfirmBtnOnClick()
  if self._channelId == EngineGameHelper.SAIchannelId() then
    self:ShowDialog("UISetBindMailController")
    self:CloseDialog()
    GameGlobal.UIStateManager():CloseDialog("UISetBindChannelController")
  else
    self:Lock("UISetBindChannelTipsController_ConfirmBtnOnClick")
    self:SetShowBusy(true)
    GameGlobal.TaskManager():StartTask(self.ConfirmBtnOnClickCoro, self)
  end
end

function UISetBindChannelTipsController:ConfirmBtnOnClickCoro(TT)
  local channelName = SDKProxy:GetInstance():GetIntlChannel(self._channelId)
  if channelName == nil then
    self:SetShowBusy(false)
    self:UnLock("UISetBindChannelTipsController_ConfirmBtnOnClick")
    return
  end
  local ret = SDKProxy:GetInstance():BindChannel(TT, channelName)
  if ret.RetCode == INTL.INTLErrorCode.SUCCESS then
    ToastManager.ShowToast(StringTable.Get("str_set_bind_bind_success"))
    YIELD(TT)
    if self._oldChannelId == MobileClientLoginChannel.MCLC_GUEST then
      SDKProxy:GetInstance():ResetGuest(TT)
    end
    self:CloseDialog()
    GameGlobal.GameLogic():BackToLogin(true, LoginModule, "bind account", false)
  else
    UICommonHelper:GetInstance():HandleLoginErrorCode(ret.RetCode, ret.ThirdCode)
  end
  self:SetShowBusy(false)
  self:UnLock("UISetBindChannelTipsController_ConfirmBtnOnClick")
end

function UISetBindChannelTipsController:CancelBtnOnClick()
  self:CloseDialog()
end
