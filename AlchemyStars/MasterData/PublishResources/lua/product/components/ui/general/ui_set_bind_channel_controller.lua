_class("UISetBindChannelController", UIController)
UISetBindChannelController = UISetBindChannelController

function UISetBindChannelController:OnShow(uiParams)
  self._mail = self:GetGameObject("Mail")
  self._apple = self:GetGameObject("Apple")
  self._google = self:GetGameObject("Google")
  self._twitter = self:GetGameObject("Twitter")
  self._facebook = self:GetGameObject("Facebook")
  self._line = self:GetGameObject("Line")
  self._dmm = self:GetGameObject("DMM")
  self._tip = self:GetGameObject("Tip")
  local channelList = uiParams[1]
  if channelList == nil then
    channelList = {}
  end
  local channelId = GameGlobal.GameLogic().ClientInfo.m_login_source
  if channelId ~= MobileClientLoginChannel.MCLC_TWITTER then
    self._mail:SetActive(false)
    self._apple:SetActive(channelList[MobileClientLoginChannel.MCLC_APPLE] and true)
    self._google:SetActive(channelList[MobileClientLoginChannel.MCLC_GOOGLE_PLAY] and true)
    self._twitter:SetActive(channelList[MobileClientLoginChannel.MCLC_TWITTER] and true)
    self._facebook:SetActive(channelList[MobileClientLoginChannel.MCLC_FACEBOOK] and true)
    self._line:SetActive(channelList[MobileClientLoginChannel.MCLC_LINE] and true)
    self._dmm:SetActive(channelList[MobileClientLoginChannel.MCLC_DMM] and true)
  else
    self._mail:SetActive(channelList[EngineGameHelper.SAIchannelId()] and true)
    self._apple:SetActive(false)
    self._google:SetActive(false)
    self._twitter:SetActive(false)
    self._facebook:SetActive(false)
    self._line:SetActive(false)
    self._dmm:SetActive(channelList[MobileClientLoginChannel.MCLC_DMM] and true)
  end
  if APPVER125 then
    local gv = HelperProxy:GetInstance():GetGameVersion()
    if gv == GameVersionType.INTL then
      self._tip:SetActive(true)
    else
      self._tip:SetActive(false)
    end
  else
    self._tip:SetActive(false)
  end
end

function UISetBindChannelController:MailOnClick()
  self:ShowDialog("UISetBindChannelTipsController", EngineGameHelper.SAIchannelId())
end

function UISetBindChannelController:AppleOnClick()
  self:ShowDialog("UISetBindChannelTipsController", MobileClientLoginChannel.MCLC_APPLE)
end

function UISetBindChannelController:GoogleOnClick()
  self:ShowDialog("UISetBindChannelTipsController", MobileClientLoginChannel.MCLC_GOOGLE_PLAY)
end

function UISetBindChannelController:TwitterOnClick()
  self:ShowDialog("UISetBindChannelTipsController", MobileClientLoginChannel.MCLC_TWITTER)
end

function UISetBindChannelController:FacebookOnClick()
  self:ShowDialog("UISetBindChannelTipsController", MobileClientLoginChannel.MCLC_FACEBOOK)
end

function UISetBindChannelController:LineOnClick()
  self:ShowDialog("UISetBindChannelTipsController", MobileClientLoginChannel.MCLC_LINE)
end

function UISetBindChannelController:DMMOnClick()
  self:ShowDialog("UISetBindChannelTipsController", MobileClientLoginChannel.MCLC_DMM)
end

function UISetBindChannelController:MaskOnClick()
  self:CloseDialog()
end
