_class("TSSSDKProxy", Singleton)
TSSSDKProxy = TSSSDKProxy

function TSSSDKProxy:Init()
  if IsUnityEditor() then
    return
  end
  if GetPlatformOS() ~= ClientRuntimeOS.CRO_PC and SDKProxy:GetInstance():IsInlandSDK() then
  elseif GetPlatformOS() ~= ClientRuntimeOS.CRO_PC and SDKProxy:GetInstance():IsInternationalSDK() then
    local tss_appid = 0
    local gv = HelperProxy:GetInstance():GetGameVersion()
    if gv == GameVersionType.INTL then
      tss_appid = tonumber(EngineGameHelper.GCloudGameID)
    elseif gv == GameVersionType.USA then
      tss_appid = 2749
    else
      tss_appid = 2757
    end
    GCloud.AnoSDK.AnoSDK.Init(tss_appid)
    Log.debug("After tonumber(EngineGameHelper.GCloudGameID) id : ", tss_appid)
    SDKProxy:GetInstance():InitInternationalTssServerInfo()
  elseif GetPlatformOS() == ClientRuntimeOS.CRO_PC then
    local client_init_info = AceSdk.ClientInitInfo:New()
    client_init_info.base_dat_path = nil
    client_init_info.current_process_role_id = -1
    client_init_info.first_process_pid = EngineGameHelper.GetCurrentProcessId()
    local ret, client_init_info, ace_client = AceSdk.AceClient.init(client_init_info, nil, nil)
    self.ace_client = ace_client
    if ret ~= AceSdk.AntiCheatExpertResult.ACE_OK then
      Log.error("AceSdk.AceClient.init failed ret =  ", ret)
    end
  end
end

function TSSSDKProxy:LogOn(PstID)
  if IsUnityEditor() then
    return
  end
  if GetPlatformOS() ~= ClientRuntimeOS.CRO_PC then
    local channel = self:GetStandardLoginChannel():ToInt()
    GCloud.AnoSDK.AnoSDK.SetUserInfo(channel, GameGlobal.GameLogic():GetOpenId())
    Log.debug("open_id : ", GameGlobal.GameLogic():GetOpenId())
    Log.debug("LoginChannel():", self:GetStandardLoginChannel())
  elseif self.ace_client ~= nil then
    local ace_account_info = AceSdk.AceAccountInfo:New()
    local id = AceSdk.AceAccountId:New()
    id.account_ = GameGlobal.GameLogic():GetOpenId()
    id.account_type_ = AceSdk.AceAccountType.ACEACCOUNT_TYPE_COMMON_ID:ToInt()
    ace_account_info.account_id_ = id
    ace_account_info.plat_id_ = AceSdk.AceAccountPlatId.ACEPLAT_ID_PC_CLIENT:ToInt()
    ace_account_info.game_id_ = 280177486
    ace_account_info.world_id_ = 0
    ace_account_info.channel_id_ = 0
    ace_account_info.role_id_ = PstID
    local ret = self.ace_client:log_on(ace_account_info)
    if ret ~= AceSdk.AntiCheatExpertResult.ACE_OK then
      Log.error("AceSdk.AceClient.LogOn failed ret =  ", ret)
    end
  else
    Log.error("TSSSDKProxy:LogOn AceSdk.AceClient is invaild")
  end
end

function TSSSDKProxy:LogOff()
  if GetPlatformOS() == ClientRuntimeOS.CRO_PC and self.ace_client ~= nil then
    self.ace_client:log_off()
  end
end

function TSSSDKProxy:Tick()
  if GetPlatformOS() == ClientRuntimeOS.CRO_PC and self.ace_client ~= nil then
    self.ace_client:tick()
  end
end

function TSSSDKProxy:OnPause()
  if IsUnityEditor() then
    return
  end
  if GetPlatformOS() ~= ClientRuntimeOS.CRO_PC then
    GCloud.AnoSDK.AnoSDK.OnPause()
  end
end

function TSSSDKProxy:OnResume()
  if IsUnityEditor() then
    return
  end
  if GetPlatformOS() ~= ClientRuntimeOS.CRO_PC then
    GCloud.AnoSDK.AnoSDK.OnResume()
  end
end

function TSSSDKProxy:OnQuit()
  if GetPlatformOS() == ClientRuntimeOS.CRO_PC and self.ace_client ~= nil then
    self.ace_client:exit_process()
  end
end

function TSSSDKProxy:GetTssReportDataString()
  if IsUnityEditor() then
    return
  end
  if GetPlatformOS() == ClientRuntimeOS.CRO_PC and self.ace_client ~= nil then
    local opt = self.ace_client:get_optional_interface()
    local antibot = opt:get_tss_antibot()
    local data = antibot:GetReportData()
    if APPVER1170 then
      return StringHelper.ToHexStringNew(data)
    else
      return StringHelper.ToHexString(data)
    end
  elseif SDKProxy:GetInstance():IsInternationalSDK() then
    return EngineGameHelper.GetTssReportDataString()
  else
    return ""
  end
end

function TSSSDKProxy:OnRecvData(nsg)
  if GetPlatformOS() == ClientRuntimeOS.CRO_PC and self.ace_client ~= nil then
    local opt = self.ace_client:get_optional_interface()
    local antibot = opt:get_tss_antibot()
    antibot:OnRecvAntiData(msg)
  end
end

function TSSSDKProxy:GetStandardLoginChannel()
  local mobileClientLoginChannel = GameGlobal.GameLogic().ClientInfo.m_login_source
  Log.debug("mobileClientLoginChannel : ", mobileClientLoginChannel)
  if mobileClientLoginChannel == MobileClientLoginChannel.MCLC_WX then
    return GCloud.AnoSDK.AnoSDKEntryType.EntryIdMM
  elseif mobileClientLoginChannel == MobileClientLoginChannel.MCLC_QQ then
    return GCloud.AnoSDK.AnoSDKEntryType.EntryIdQQ
  elseif mobileClientLoginChannel == MobileClientLoginChannel.MCLC_FACEBOOK then
    return GCloud.AnoSDK.AnoSDKEntryType.EntryIdFacebook
  elseif mobileClientLoginChannel == MobileClientLoginChannel.MCLC_TWITTER then
    return GCloud.AnoSDK.AnoSDKEntryType.EntryIdTwitter
  elseif mobileClientLoginChannel == MobileClientLoginChannel.MCLC_GOOGLE_PLAY then
    return GCloud.AnoSDK.AnoSDKEntryType.EntryIdGoogleplay
  elseif mobileClientLoginChannel == MobileClientLoginChannel.MCLC_GARENA then
    return GCloud.AnoSDK.AnoSDKEntryType.EntryIdGarena
  elseif mobileClientLoginChannel == MobileClientLoginChannel.MCLC_APPLE then
    return GCloud.AnoSDK.AnoSDKEntryType.EntryIdApple
  else
    return GCloud.AnoSDK.AnoSDKEntryType.EntryIdOthers
  end
end
