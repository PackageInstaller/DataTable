local LoginNetWorkCtrl = class("LoginNetWorkCtrl", NetworkCtrlBase)
local cs_NetworkManager = CS.NetworkManager.Instance
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function LoginNetWorkCtrl:ctor()
end

function LoginNetWorkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Login, self, proto_csmsg.SC_Login, self.SC_Login)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Logout, self, proto_csmsg.SC_Logout, self.SC_Logout)
end

function LoginNetWorkCtrl:CS_Login(osdkUserId, token, clientVersionInfo, isReconnect, callBack)
  local loginMsg = {
    open_id = osdkUserId,
    token = token,
    version = clientVersionInfo
  }
  if isReconnect then
    self.reConnSeq = self.reConnSeq and self.reConnSeq + 1 or 1
    if isGameDev and CS.GMController.Instance.netSeqLog then
      print("[CS_Login] reConnSeq : " .. tostring(self.reConnSeq))
    end
    loginMsg.reConnSeq = self.reConnSeq
    loginMsg.seq = {
      clientSeq = cs_NetworkManager.SeqClient,
      serverSeq = cs_NetworkManager.SeqServer
    }
  end
  loginMsg.platformCat = 0
  if GameSystemInfo.Platform == GameSystemInfo.PlatformType.Android then
    loginMsg.platformCat = 1
  elseif GameSystemInfo.Platform == GameSystemInfo.PlatformType.iOS then
    loginMsg.platformCat = 2
  end
  loginMsg.params = {
    LoginClientDeviceNum = CS.MicaSDKManager.Instance.UUID
  }
  cs_WaitNetworkResponse:ResumeWait()
  NetworkManager.luaNetworkAgent:SaveLoginData(loginMsg)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Login, proto_csmsg.CS_Login, loginMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Login, callBack, proto_csmsg_MSG_ID.MSG_SC_Login)
end

function LoginNetWorkCtrl:SC_Login(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
    PlayerDataCenter:UserLoginComplete(msg.role, msg.firstLogin)
    CS.WaitNetworkResponse.Instance:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Login, true)
    if msg.seq == nil then
      NetworkManager:GetNetwork(NetworkTypeID.Object):WaitUserPreData()
    else
      cs_NetworkManager:DealReconnectedSeq(msg.seq.clientSeq, msg.seq.serverSeq)
    end
  else
    local err = "LoginNetWorkCtrl:OnRecvLogin error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    CS.WaitNetworkResponse.Instance:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Login, false)
  end
end

function LoginNetWorkCtrl:SC_Logout(msg)
  local reason = msg.reason
  if reason == 0 then
    return
  end
  local isLogin = CS.WaitNetworkResponse.Instance:ContainWait(proto_csmsg_MSG_ID.MSG_CS_Login)
  MsgCenter:Broadcast(eMsgEventId.OnLogout)
  if 100 < reason then
    return
  end
  if reason == proto_csmsg_UserStatus.StatusServerMaintain then
    local msg
    if isLogin then
      msg = ConfigData:GetTipContent(269)
    else
      msg = ConfigData:GetTipContent(274)
    end
    CS.NetworkManager.Instance:CloseAndQuitToLogin(msg)
    return
  end
  if reason == proto_csmsg_UserStatus.StatusOtherDeviceLogin then
    CS.NetworkManager.Instance:CloseAndQuitToLogin(ConfigData:GetTipContent(270))
    return
  end
  if reason == proto_csmsg_UserStatus.StatusHeatbeatOvertime then
    CS.NetworkManager.Instance:CloseAndQuitToLogin(ConfigData:GetTipContent(271))
    return
  end
  if reason == proto_csmsg_UserStatus.StatusIsFreeze then
    CS.NetworkManager.Instance:CloseAndQuitToLogin(ConfigData:GetTipContent(276))
    return
  end
  if reason == proto_csmsg_UserStatus.StatusInvalidGuestToken or reason == proto_csmsg_UserStatus.StatusInvalidUserToken then
    CS.NetworkManager.Instance:CloseAndQuitToLogin(ConfigData:GetTipContent(402))
    return
  end
  if reason == proto_csmsg_UserStatus.StatusHeroRevertNtf then
    CS.NetworkManager.Instance:CloseAndQuitToLogin(ConfigData:GetTipContent(557))
    return
  end
  CS.NetworkManager.Instance:CloseAndQuitToLogin(string.format(ConfigData:GetTipContent(272), reason))
end

function LoginNetWorkCtrl:Reset()
end

return LoginNetWorkCtrl
