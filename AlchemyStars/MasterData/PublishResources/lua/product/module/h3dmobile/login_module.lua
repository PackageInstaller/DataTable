local Enum_DateTimeZoneType = {
  E_ZoneType_GMT = 0,
  E_ZoneType_Client = 1,
  E_ZoneType_ServerTimeZone = 3
}
_enum("Enum_DateTimeZoneType", Enum_DateTimeZoneType)
_class("LoginModule", LoginBaseModule)
LoginModule = LoginModule

function LoginModule:Constructor()
  self.m_login_lock = false
  self.m_noticeData = nil
  self.m_autoLogin = false
  self.m_is_in_first_story = false
  self.m_next_zero_time = 0
  self.m_gmt_next_zero_time = 0
  self.m_server_time_zone_diff = 0
  self.m_cam_next_refresh_time = 0
  self.m_signin_refresh_time = 0
  self.lastCheckTime = 0
  self.checkInterval = 3000
  self.m_intl_detect_country_num = ""
  self.m_user_choose_country_num = ""
  self.key_switch = true
end

function LoginModule:GetTimeStampByTimeStr(strDateTime, nDateTimeType)
  local l_timeTable = HelperProxy:GetInstance():GetTimeTable(strDateTime)
  if nDateTimeType == Enum_DateTimeZoneType.E_ZoneType_Client then
    return os.time(l_timeTable)
  end
  local strLocalDateTime = _utc2Local(l_timeTable)
  local l_timeStamp = HelperProxy:GetInstance():FormatDateTime(strLocalDateTime)
  if nDateTimeType == Enum_DateTimeZoneType.E_ZoneType_GMT then
    return l_timeStamp
  end
  l_timeStamp = l_timeStamp - self.m_server_time_zone_diff
  if l_timeStamp < 0 then
    l_timeStamp = 0
  end
  return l_timeStamp
end

function LoginModule:SetServerTimeZoneDiff(tmServerTimeZoneDiff)
  self.m_server_time_zone_diff = tmServerTimeZoneDiff
end

function LoginModule:GetServerTimeZoneDiff()
  return self.m_server_time_zone_diff
end

function LoginModule:GetNextZeroTime()
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local tmNowTime = math.modf(time_mod:GetServerTime() / 1000)
  if tmNowTime >= self.m_next_zero_time and self.m_next_zero_time ~= 0 then
    local l_one_day_secs = 86400
    local l_nDays = math.modf((tmNowTime - self.m_next_zero_time) / l_one_day_secs) + 1
    self.m_next_zero_time = self.m_next_zero_time + l_one_day_secs * l_nDays
  end
  return self.m_next_zero_time
end

function LoginModule:SetNextZeroTime(tmNextZeroTime)
  self.m_next_zero_time = tmNextZeroTime
end

function LoginModule:NextRefreshTime(values)
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local tmNowTime = math.modf(time_mod:GetServerTime() / 1000)
  if values <= tmNowTime and values ~= 0 then
    local l_one_day_secs = 86400
    local l_nDays = math.modf((tmNowTime - values) / l_one_day_secs) + 1
    values = values + l_one_day_secs * l_nDays
  end
  return values
end

function LoginModule:GetGMTNextZeroTime()
  return self:NextRefreshTime(self.m_gmt_next_zero_time)
end

function LoginModule:GetCampaignRefreshTime()
  return self:NextRefreshTime(self.m_cam_next_refresh_time)
end

function LoginModule:GetSignRefreshTime()
  return self:NextRefreshTime(self.m_signin_refresh_time)
end

function LoginModule:SetGMTNextZeroTime(tmGMTNextZeroTime)
  self.m_gmt_next_zero_time = tmGMTNextZeroTime
end

function LoginModule:SetCamNextRefreshTime(values)
  self.m_cam_next_refresh_time = values
end

function LoginModule:SetNextSignInRefreshTime(values)
  self.m_signin_refresh_time = values
end

function LoginModule:GetCommonActivityTime(types, dataStr)
  local cfg_map = Cfg.cfg_common_activity_time({Type = types})
  if cfg_map == nil then
    return nil
  end
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local tmNowTime = math.modf(time_mod:GetServerTime() / 1000)
  for k, v in pairs(cfg_map) do
    local timeType = Enum_DateTimeZoneType.E_ZoneType_GMT
    if v.TimeTransform == 1 then
      timeType = Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone
    end
    if dataStr ~= nil then
      tmNowTime = self:GetTimeStampByTimeStr(dataStr, timeType)
    end
    local bt = self:GetTimeStampByTimeStr(v.DateTimeBegin, timeType)
    local nt = self:GetTimeStampByTimeStr(v.DateTimeEnd, timeType)
    if tmNowTime > bt and tmNowTime < nt then
      return v, bt, nt
    end
  end
  return nil
end

function LoginModule:GetNextTimeStampByHMS(hour, minute, second)
  local seconds = second or 0
  if minute then
    seconds = seconds + minute * 60
  end
  if hour then
    seconds = seconds + hour * 60 * 60
  end
  local timeMod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local tmNowTime = math.modf(timeMod:GetServerTime() / 1000)
  local nextZeroTime = self:GetNextZeroTime()
  local maybeNextTargetTime = nextZeroTime + seconds
  local oneDaySecs = 86400
  if maybeNextTargetTime < tmNowTime + oneDaySecs then
    return maybeNextTargetTime
  else
    return maybeNextTargetTime - oneDaySecs
  end
end

function LoginModule:IsPassMissionCommonActivity(cfgId)
  if cfgId == nil then
    return false
  end
  local cfg = Cfg.cfg_common_activity_time[cfgId]
  if cfg == nil then
    return false
  end
  if cfg.NeedMissionID == nil or cfg.NeedMissionID <= 0 then
    return true
  end
  local missionModule = GameGlobal.GetModule(MissionModule)
  return missionModule:IsPassMissionID(cfg.NeedMissionID)
end

function LoginModule:SetIsInFirstStory(isInFirstStory)
  self.m_is_in_first_story = isInFirstStory
end

function LoginModule:IsInFirstStory()
  return self.m_is_in_first_story
end

function LoginModule:Init()
  LoginModule.super.Init(self)
end

function LoginModule:IsLoginState()
  return self.m_autoLogin
end

function LoginModule:SetLoginState(values)
  self.m_autoLogin = values
end

function LoginModule:Reset(reason)
  LoginModule.super.Reset(self, reason)
  GameGlobal.GameLogic():GoBack()
end

function LoginModule:InitBindChannelDataTT(TT)
  local ret = SDKProxy:GetInstance():QueryUserInfo(TT)
end

function LoginModule:InitNoticeData()
  if self.m_noticeData then
    self.m_noticeData:Dispose()
    self.m_noticeData = nil
  end
  if self.m_noticeData == nil then
    self.m_noticeData = NoticeData:New()
  end
end

function LoginModule:GetNoticeData()
  return self.m_noticeData
end

function LoginModule:Dispose()
  if self.m_noticeData then
    self.m_noticeData:Dispose()
    self.m_noticeData = nil
  end
end

function LoginModule:Reset(reason)
  LoginModule.super.Reset(self, reason)
  GameGlobal.GameLogic():GoBack()
end

function LoginModule:Login(TT, svrId, silent, timeout)
  local res = AsyncRequestRes:New()
  if self.m_login_lock then
    Log.warn(self:Key(), " login game lock is locked")
    return res
  end
  if self.svrId == svrId and self:IsLogin() and self.caller:HasAuth() then
    Log.warn(self:Key(), " already pass login game verify")
    res:SetSucc(true)
    return res
  end
  if not GameGlobal.GameLogic().ClientInfo then
    Log.fatal(self:Key(), " login game client info is null")
    return res
  end
  self.m_login_lock = true
  if self.svrId ~= svrId or not self:IsLogin() then
    self.svrId = svrId
    self.isLogin = false
    self.caller:SetPipe2Conn(NetToken:New(NetTokenType.TOKEN_GAME, "GM", self.svrId), "gateway")
  end
  self.caller:LostAuth()
  self.curTaskId = GetCurTaskId()
  Log.debug(self:Key(), " player ", GameGlobal.GameLogic():GetOpenId(), self:IsLogin() and " reconn to " or " login game to ", self.svrId)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestLoginVerify)
  request.m_is_login = self:IsLogin()
  request.m_client_info = GameGlobal.GameLogic().ClientInfo
  request.m_is_international = SDKProxy:GetInstance():IsInternationalSDK()
  if EngineGameHelper.IsEnableHotUpdate() == true then
    request.m_client_info.client_app_version = EngineGameHelper.CurrentAppVersion()
    request.m_client_info.client_res_version = EngineGameHelper.CurrentResVersion()
  else
    request.m_client_info.client_app_version = "0.0.0.0"
    request.m_client_info.client_res_version = "0.0.0.0"
  end
  request.m_client_info.idfv = EngineGameHelper.GetUserIDFA
  request.m_client_info.android_id = EngineGameHelper.GetAndroidID()
  request.m_login_info = GameGlobal.GameLogic().msdkAuthorityInfo
  Log.debug("EngineGameHelper.GetUserIDFA ", EngineGameHelper.GetUserIDFA)
  local nLoginStep = Enum_Login_Step.E_Login_Step_RequestLoginVerify
  local retry_times = 0
  local retry_ms = 1000
  while true do
    Log.debug(self:Key(), " login game while")
    local replyInfo = self:Call(TT, request, not silent, timeout)
    res:SetCallErr(replyInfo.res)
    if not replyInfo:Succ() then
      Log.fatal(self:Key(), " login game reply failed ", replyInfo.res)
      break
    end
    local reply = CEventReplyLoginVerify(replyInfo.msg)
    res:SetResult(reply.m_ret)
    local ret = res:GetResult()
    if ret == MOBILE_LOGIN_ERROR.MOBILE_LOGIN_OK then
      Log.debug(self:Key(), " login game ", ret, ", resend request")
      self.caller:GainAuth()
      res:SetSucc(true)
      AdjustTimeCS(reply.m_server_time)
      if reply.info ~= nil and reply.info.type == IndulgeRes.Tips then
        local indumod = GameGlobal.GetModule(IndulgeModule)
        indumod:SetMsgInfo(reply.info)
      end
      break
    elseif ret == MOBILE_LOGIN_ERROR.MOBILE_LOGIN_RETRY then
      if 3 <= retry_times then
        Log.fatal(self:Key(), " login game ", ret, ", retry ", retry_times, " limit")
        GameGlobal.GameLogic():BackToLogin(false, LoginModule, "retry limit: LoginGame[" .. tostring(nLoginStep) .. ", " .. tostring(ret) .. "]", silent)
        break
      end
      retry_times = retry_times + 1
      Log.debug(self:Key(), " login game ", ret, ", retry ", retry_times, " times after ", retry_ms, " ms")
      YIELD(TT, retry_ms)
    elseif ret == MOBILE_LOGIN_ERROR.MOBILE_LOGIN_INDULGE_KICK then
      if reply.info ~= nil then
        local indumod = GameGlobal.GetModule(IndulgeModule)
        indumod:SetMsgInfo(reply.info)
        Log.debug(self:Key(), " login game ", ret, ", indulge")
      end
      break
    elseif ret == MOBILE_LOGIN_ERROR.MOBILE_LOGIN_NOT_ACTIVITY then
      Log.debug(self:Key(), " login game ", ret, ", indulge")
      GameGlobal.GameLogic():BackToLogin(false, LoginModule, "login failed: LoginGame[" .. tostring(nLoginStep) .. ", " .. tostring(ret) .. "]", silent)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.LoginIdipActive)
      break
    elseif ret == MOBILE_LOGIN_ERROR.MOBILE_LOGIN_BAN then
      Log.debug(self:Key(), " login game ", ret, ", idip ban")
      local mod = GameGlobal.GetModule(IdipgameModule)
      mod:SetMsgInfo(reply.ban_info)
      break
    else
      Log.fatal(self:Key(), " login game ", ret, ", reset")
      if ret == MOBILE_LOGIN_ERROR.MOBILE_LOGIN_HOT_UPDATE_MUST_UPDATE then
        PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, StringTable.Get("str_login_msdk_tip"), StringTable.Get("str_login_version_error") .. " [" .. tostring(nLoginStep) .. ", " .. tostring(ret) .. "]", function(param)
          UnityEngine.Application.Quit()
        end)
      elseif ret == MOBILE_LOGIN_ERROR.MOBILE_LOGIN_HOT_UPDATE_REDOWNLOAD then
        PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, StringTable.Get("str_login_msdk_tip"), StringTable.Get("str_login_redown_error") .. " [" .. tostring(nLoginStep) .. ", " .. tostring(ret) .. "]")
      end
      GameGlobal.GameLogic():BackToLogin(false, LoginModule, "login failed: LoginGame[" .. tostring(nLoginStep) .. ", " .. tostring(ret) .. "]", silent, ret)
      break
    end
  end
  self.curTaskId = 0
  GameGlobal.EventDispatcher():Dispatch(GameEventType.NetWorkRetryEnd)
  self.m_login_lock = false
  Log.debug(self:Key(), " login game end")
  return res
end

function LoginModule:ChooseRole(TT, pstid)
  local res = AsyncRequestRes:New()
  pstid = pstid or 0
  res:SetSucc(false)
  Log.debug("ChooseRole")
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileChooseRole)
  request.server_id = 1
  request.persistid = pstid
  request.intl_detect_country = self.m_intl_detect_country_num
  request.player_choose_country = self.m_user_choose_country_num
  request.client_language_type = Localization.GetCurLanguage()
  local reply = self:Call(TT, request, true, 120000)
  if not reply:Succ() then
    Log.error("ChooseRole failed.")
    return res
  else
    Log.debug("ChooseRole ok.")
  end
  local replyEvent = CEventMobileChooseRoleResult(reply.msg)
  if replyEvent == nil then
    Log.fatal("choose role returned something else")
    return res
  end
  res:SetResult(replyEvent.ret)
  if replyEvent.ret == ROLE_RESULT_CODE.ROLE_ERROR_NOT_ROLE then
    Log.debug("ChooseRole not role: ", ROLE_RESULT_CODE.ROLE_ERROR_NOT_ROLE)
    return res
  elseif replyEvent.ret == ROLE_RESULT_CODE.ROLE_ALREADY_LOGIN then
    Log.debug("role already login: ", reply.ret)
    GameGlobal.GameLogic():BackToLogin(false, LoginModule, "role already login", false)
    return res
  elseif replyEvent.ret ~= ROLE_RESULT_CODE.ROLE_SUCCESS then
    Log.debug("choose role failed: ", replyEvent.ret)
    GameGlobal.GameLogic():BackToLogin(false, LoginModule, "choose role failed: " .. tostring(replyEvent.ret), false)
    return res
  end
  self.isLogin = true
  self.PstID = replyEvent.mobile_char_info.pstid
  self.key_switch = replyEvent.b_key_switch
  Log.debug("Player Login success pstid:", self.PstID, "showid ", self:GetRoleShowID())
  res:SetSucc(true)
  TSSSDKProxy:GetInstance():LogOn(self.PstID)
  local char_mod = self:GetModule(RoleModule)
  char_mod:InitCharInfo(replyEvent.mobile_char_info)
  char_mod:InitChosePainting(replyEvent.mobile_choose_painting)
  char_mod:InitTodayFirstLoginState(replyEvent.today_first_login)
  char_mod:SetZoneIdType(replyEvent.zone_id_type)
  char_mod:SetMinorChat(replyEvent.minor_chat_open)
  char_mod:SetStoreReview(replyEvent.store_review)
  char_mod:SetAPPPublishSubType(replyEvent.apppublishsubtype)
  char_mod:SetIsFixItem(replyEvent.is_fix)
  char_mod:SetNotEnough(replyEvent.fix_not_enough)
  local sign_in_mod = self:GetModule(SignInModule)
  sign_in_mod:SetIsSignInToday(replyEvent.is_sign_in_today, replyEvent.next_sign_in_time, replyEvent.b_can_re_sign_in_ex_vig)
  sign_in_mod:SetTotalLoginNextRefreshTime(replyEvent.next_sign_in_time)
  sign_in_mod:SetCurChangeDayTotalLoginDays(replyEvent.nChangeDayLoginDays)
  sign_in_mod:SetNextTotalLoginRewardDays(replyEvent.nNextTotalLoginRewardDays)
  sign_in_mod:FillNewPlayerSignupStatus(replyEvent.accept_status, replyEvent.reward_cfg)
  self:SetNextZeroTime(replyEvent.next_zero_time)
  self:SetGMTNextZeroTime(replyEvent.next_GMT_zero_time)
  self:SetServerTimeZoneDiff(replyEvent.server_time_zone_diff)
  self:SetCamNextRefreshTime(replyEvent.campaign_refresh_time)
  self:SetNextSignInRefreshTime(replyEvent.next_sign_in_time)
  local item_mod = self:GetModule(ItemModule)
  item_mod:InitItemInfos(replyEvent.item_info_vec)
  local mission_mod = self:GetModule(MissionModule)
  mission_mod:InitMissionInfo(replyEvent.mobile_char_info.chapter_id, replyEvent.pass_mission)
  mission_mod:SetAlreadyReturnMissionList(replyEvent.already_return_power_mission_list)
  mission_mod:SetAlreadyReturnCamMissionList(replyEvent.return_power_cam_mission_list)
  mission_mod:SetFormationInfos(replyEvent.m_formation_info)
  mission_mod:SetStoryActiveData(replyEvent.missionStoryData.active_story_map)
  mission_mod:SetChapterInfo(replyEvent.missionChapterAwardData)
  local extMissionModule = self:GetModule(ExtMissionModule)
  extMissionModule:SaveExtStoryData(replyEvent.m_extStoryDataList)
  local pet_md = self:GetModule(PetModule)
  pet_md:AddPets(replyEvent.pet_data_vec, replyEvent.equip_refine_new)
  pet_md:InitNewPetList(replyEvent.new_pet_list)
  pet_md:AddPetSkins(replyEvent.pet_skin_data_vec)
  local aircraft_md = self:GetModule(AircraftModule)
  aircraft_md:SetAircraftInfo(replyEvent.client_aircraft_info)
  aircraft_md:SetSpaceInfos(replyEvent.aircraft_spaces)
  local maze_md = self:GetModule(MazeModule)
  maze_md:SetMazeInitTime(replyEvent.tmMazeInitTime)
  maze_md:SetMazeInfo(replyEvent.m_maze_info)
  local res_dungeon = self:GetModule(ResDungeonModule)
  res_dungeon:SetAllData(replyEvent.resdungeonAllData)
  res_dungeon:SetAlreadyReturnedMission(replyEvent.already_returned_power_resinstance)
  local shopModule = self:GetModule(ShopModule)
  shopModule:FillInitData(replyEvent.all_market_info, replyEvent.total_diamond_count_, replyEvent.skin_market_datas)
  shopModule:FillInitConfig(replyEvent.shop_config)
  local lostareaModule = self:GetModule(LostAreaModule)
  lostareaModule:LoadInitializeData(replyEvent.area_design_cfg, replyEvent.area_level_group_cfg)
  local quest_md = self:GetModule(QuestModule)
  quest_md:SetMobileQuestData(replyEvent.quest_data)
  local mail_md = self:GetModule(MailModule)
  mail_md:CheckHaveNewMail(replyEvent.bHaveNewMail)
  local homeland_md = self:GetModule(HomelandModule)
  homeland_md:SetTaskGroupTimeline(replyEvent.task_group_timeline)
  homeland_md:SetTaskGroupCloseTimeline(replyEvent.task_group_close_timeline)
  homeland_md:SetFunctionUnlockMask(replyEvent.homeland_unlock_functions)
  homeland_md:SetRecvGroupId(replyEvent.group_id_set)
  local friend_md = self:GetModule(SocialModule)
  friend_md:CheckHaveNewMsg(replyEvent.bHaveNewMsg)
  char_mod:SetLevelInfo(replyEvent.level_info)
  local ig_mg = self:GetModule(IdipgameModule)
  ig_mg:ClearData()
  ig_mg:SetMsgInfo(replyEvent.ban_info)
  SetGuideServerClose(replyEvent.guide)
  local tower_md = self:GetModule(TowerModule)
  tower_md:SetTowerAllData(replyEvent.tower_data)
  local story_md = self:GetModule(StoryModule)
  story_md:SetSAData(replyEvent.story_affinity)
  local talePetModule = self:GetModule(TalePetModule)
  talePetModule:SetCanCall(replyEvent.b_tale_do, replyEvent.b_tale_call, replyEvent.b_tale_task)
  talePetModule:SetInitRewardRed(replyEvent.tale_stage_reward2accept)
  local gambleModule = self:GetModule(GambleModule)
  gambleModule:SetAllPoolInfo(replyEvent.gamble_pool_vec)
  local homelandModule = self:GetModule(HomelandModule)
  homelandModule:SetniqueTreeData(replyEvent.homeland_cultivation_data)
  homelandModule:SetForgeData(replyEvent.homeland_forge_data)
  homelandModule:SetVisitHelpData(replyEvent.homeland_visit_help_data)
  homelandModule:SetMovieInfo(replyEvent.movice_info)
  local medalModule = self:GetModule(MedalModule)
  medalModule:SetAllMedalData(replyEvent.medal_data)
  local seasonModule = self:GetModule(SeasonModule)
  seasonModule:SetExtData(replyEvent.season)
  local pay_mod = self:GetModule(PayModule)
  pay_mod:Load(TT)
  self:ReqRoleOtherData(TT)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCreateMe)
  return res
end

function LoginModule:ReqRoleOtherData(TT)
  self:GetModule(PetModule):HandlePropertyCultivateInfo(TT)
  self:GetModule(ItemModule):HandleCEventChessData(TT)
  self:GetModule(SignInModule):HandleGetMainDressUpReq(TT)
end

function LoginModule:GetShowIdByPstId(l_pstid)
  if GameSingle and (l_pstid == nil or l_pstid == 0) then
    return 1500331
  end
  return l_pstid & 1099511627775
end

function LoginModule:GetPstIdByShowId(l_showid)
  local l_head_mask = self.PstID & -1099511627776
  return l_showid | l_head_mask
end

function LoginModule:GetRoleShowID()
  if GameSingle and (l_pstid == nil or l_pstid == 0) then
    return 1500331
  end
  if not self.PstID then
    return nil
  end
  return self:GetShowIdByPstId(self.PstID)
end

function LoginModule:RoleCreate(TT, nick, sex)
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  Log.debug("RoleCreate")
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileCreateRole)
  request.name = nick
  request.sex = sex
  local replyInfo = self:Call(TT, request, true, 60000)
  if not replyInfo:Succ() then
    return res
  end
  local reply = CEventMobileCreateRoleResult(replyInfo.msg)
  if reply == nil then
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.ret)
  res.pstid = reply.pstid
  return res
end

function LoginModule:EnableEscKey()
  return self.key_switch
end

function LoginModule:EnterGameSucc()
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland or H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    local paymodule = self:GetModule(PayModule)
    paymodule:StartMidas()
  end
end

function LoginModule:GetStandardLoginChannel()
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

function LoginModule:NewLoginStart()
  if self:GetSingleState() then
    GameGlobal.TaskManager():StartTask(self.JudgeCanSingleLoginSucessTT, self)
  else
    self:NewLoginData()
    self:NewLoginGame()
    self:InitNoticeData()
    if IsUnityEditor() == false then
      GameGlobal.TaskManager():StartTask(self.InitBindChannelDataTT, self)
    end
  end
end

function LoginModule:NewLoginData()
  local clientInfo = GameGlobal.GameLogic().ClientInfo
  clientInfo.m_runtime_os = GetPlatformOS()
  clientInfo.m_login_source = LoginLuaHelper.GetChannelId()
  clientInfo.m_reg_channel = LoginLuaHelper.GetRegChannelDis()
  clientInfo.m_store_channel = SDKProxy:GetInstance():GetStoreChannel()
  Log.debug("clientInfo.m_reg_channel : ", clientInfo.m_reg_channel)
  Log.debug("clientInfo.m_login_source : ", clientInfo.m_login_source)
  Log.debug("clientInfo.m_store_channel : ", clientInfo.m_store_channel)
  local msdkAuthorityInfo = GameGlobal.GameLogic().msdkAuthorityInfo
  msdkAuthorityInfo.open_id = LoginLuaHelper.GetOpenId()
  msdkAuthorityInfo.account = LoginLuaHelper.GetRegAccount()
  msdkAuthorityInfo.m_token = LoginLuaHelper.GetToken()
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International and IsUnityEditor() == false then
    local authRet = INTL.INTLAPI.GetAuthResult()
    if authRet ~= nil and authRet ~= null then
      msdkAuthorityInfo.m_token = authRet.Token
      Log.debug("msdkAuthorityInfo.m_token : ", msdkAuthorityInfo.m_token)
    end
  end
  local state = LoginLuaHelper.GetStateRegionInfo()
  if state ~= nil and state ~= null then
    msdkAuthorityInfo.state_numeric = state.Numeric
    msdkAuthorityInfo.state_name = state.Name
    self.m_user_choose_country_num = state.Numeric
    local stateList = {
      "156",
      "158",
      "192",
      "344",
      "356",
      "364",
      "408",
      "446",
      "704",
      "760"
    }
    local key = "StateRegion" .. msdkAuthorityInfo.open_id
    for i, v in pairs(stateList) do
      if state.Numeric == v then
        LocalDB.SetString(key, "999")
        Log.error("[intl]: replace state:", v)
        break
      end
    end
  end
  local lbs = LoginLuaHelper.GetLBSStateRegionInfo()
  if lbs ~= nil then
    self.m_intl_detect_country_num = lbs.Numeric
  else
  end
  local thirdPartyModule = self:GetModule(ThirdPartyModule)
  thirdPartyModule:SyncOpenID(msdkAuthorityInfo.open_id)
end

function LoginModule:NewLoginGame()
  local zoneinfo = LoginLuaHelper.GetZoneInfo()
  if zoneinfo == nil or zoneinfo == null then
    ToastManager.ShowToast(StringTable.Get("str_login_getserverinfo_error"))
    return
  end
  GameGlobal.GameLogic():SetZoneID(zoneinfo.id)
  local address = {
    [1] = {
      ip = zoneinfo.domain_name,
      port = zoneinfo.port
    }
  }
  GameGlobal.TaskManager():StartTask(self.NewLoginGameTT, self, address)
end

function LoginModule:NewLoginGameTT(TT, address)
  GameGlobal.UIStateManager():Lock("DoNewLogin")
  local process = LoginProcess:New()
  local open_id = GameGlobal.GameLogic():GetOpenId()
  local logginRes = process:LoginTask(TT, open_id, address)
  if logginRes == LoginRes.Success then
    while GameGlobal.UIStateManager():CurUIStateType() ~= UIStateType.LoginEmpty do
      YIELD(TT)
    end
    self:OnLoginSuccess()
    LoginLuaHelper.CloseAllUI()
  else
    Log.error("loginProcess:LoginTask error ", logginRes)
    LoginLuaHelper.ResetCanStartGame()
  end
  GameGlobal.UIStateManager():UnLock("DoNewLogin")
end

function LoginModule:OnLoginSuccess()
  if not EDITOR then
    UIGlobalModule:SetCSUICameraStatus(false)
  end
  if _G.APPVER1190 and not IsPc() then
    SDKProxy:GetInstance():SetBindRewardData()
  end
  local module = self:GetModule(MissionModule)
  local stage1MissionId = Cfg.cfg_global.stage_1_id.IntValue
  local curMissionID = module:GetCurMissionID()
  if curMissionID == 0 then
    Log.info("LoginModule --如果第一关没通关，就进入新手关流程")
    local roleModule = self:GetModule(RoleModule)
    local isActive = module:IsMissionStoryActive(stage1MissionId, ActiveStoryType.ActiveStoryType_BeforeBattle)
    if isActive then
      GameGlobal.TaskManager():StartTask(self.EnterMatchStage1, self, false)
    else
      local discoveryData = module:GetDiscoveryData()
      local story = discoveryData:GetStoryByStageIdStoryType(stage1MissionId, StoryTriggerType.BeforeFight)
      GameGlobal.ReportCustomEvent("CreateRole", "CreateRoleAnim")
      GameGlobal.UIStateManager():ShowDialog("UIStoryController", story.id, function()
        GameGlobal.ReportCustomEvent("CreateRole", "ContinueEnterGame")
        GameGlobal.TaskManager():StartTask(function(TT)
          module:SetMissionStoryActive(TT, stage1MissionId, ActiveStoryType.ActiveStoryType_BeforeBattle)
          self:EnterMatchStage1(TT, false)
        end)
      end, false, false)
    end
  elseif curMissionID == stage1MissionId then
    local roleModule = self:GetModule(RoleModule)
    local name = roleModule:GetName()
    if string.isnullorempty(name) then
      self:ReplayCreateNameStory(stage1MissionId)
    else
      GameGlobal.TaskManager():StartTask(function(TT)
        local guideModule = self:GetModule(GuideModule)
        guideModule:DirectEnterStage2(TT)
      end)
    end
  else
    GameGlobal.TaskManager():StartTask(function(TT)
      self:_CheckTaskBeforeShowUI(TT)
    end)
  end
end

function LoginModule:_CheckTaskBeforeShowUI(TT)
  self:_CheckActivityOneAndHalfAnniversary(TT)
  self:GetModule(GuideModule):CheckMissionGuide(curMissionID)
  local guide = false
  if not NOGUIDE then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideLogin, function(trigger)
      guide = trigger
    end)
  end
  local paramsMap = SDKProxy:GetInstance():GetUniversalLink()
  if not guide then
    local jumpFunction = self:GetUniversalLinkJump(TT, paramsMap)
    if jumpFunction then
      jumpFunction()
    else
      GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
    end
  end
end

function LoginModule:_CheckActivityOneAndHalfAnniversary(TT)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  if LocalDB.GetInt("OneAndHalfAnniversary_" .. pstId, 0) == 1 then
    return
  end
  if not self:GetModule(MissionModule):IsPassMissionID(4001130) then
    return
  end
  local cfg
  local cfgs = Cfg.cfg_main_side_enter({})
  for _, v in pairs(cfgs) do
    if v.MainUI == "UIActivityOneAndHalfAnniversaryController" then
      cfg = v
    end
  end
  if not cfg then
    Log.error("cfg_main_side_enter中不存在1.5周年pv活动数据")
    return
  end
  local svrTimeModule = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local beginTime = self:GetTimeStampByTimeStr(cfg.BeginTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  local endTime = self:GetTimeStampByTimeStr(cfg.EndTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  if curTime >= beginTime and curTime < endTime then
    self:AttachEvent(GameEventType.OnOneAndHalfAnniversaryFinish, self._OnOneAndHalfAnniversaryFinish)
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIActivityOneAndHalfAnniversaryVideoController, true)
    while not self._OnOneAndHalfAnniversaryFinishFlag do
      YIELD(TT)
    end
    self:DetachEvent(GameEventType.OnOneAndHalfAnniversaryFinish, self._OnOneAndHalfAnniversaryFinish)
  end
end

function LoginModule:_OnOneAndHalfAnniversaryFinish()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  LocalDB.SetInt("OneAndHalfAnniversary_" .. pstId, 1)
  self._OnOneAndHalfAnniversaryFinishFlag = true
end

local UniversalLinkOpenType = {
  ShowDialog = 1,
  Loading = 2,
  SwitchState = 3
}
_enum("UniversalLinkOpenType", UniversalLinkOpenType)

function LoginModule:GetUniversalLinkJump(TT, paramsMap)
  local paramsMap = paramsMap
  if paramsMap and paramsMap.module then
    local cfg = Cfg.cfg_universal_link({
      ID = tonumber(paramsMap.module)
    })
    if not cfg or #cfg <= 0 then
      Log.error("cfg_universal_link error:" .. paramsMap.module)
      return nil
    end
    if cfg[1].GameModuleID and 0 < cfg[1].GameModuleID then
      local unlock = self:_ModuleUnLock(cfg[1].GameModuleID)
      if not unlock then
        Log.error("module lock:" .. cfg[1].GameModuleID)
        return nil
      end
    end
    if cfg[1].CampaignType and 0 < cfg[1].CampaignType then
      local unlock = self:_CampaignOpen(TT, cfg[1].CampaignType)
      if not unlock then
        Log.error("campaign lock:" .. cfg[1].CampaignType)
        return nil
      end
    end
    if cfg[1].UI then
      do
        local function jumpFunction()
          if cfg[1].OpenType == UniversalLinkOpenType.ShowDialog then
            GameGlobal.UIStateManager():ShowDialog(cfg[1].UI, cfg[1].Param and table.unpack(cfg[1].Param))
          elseif cfg[1].OpenType == UniversalLinkOpenType.Loading then
            GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.DrawCard_Enter_UL, "Ckt_01_new")
          elseif cfg[1].OpenType == UniversalLinkOpenType.SwitchState then
            GameGlobal.UIStateManager():SwitchState(cfg[1].UI, cfg[1].Param and table.unpack(cfg[1].Param))
          end
        end
        
        return jumpFunction
      end
    end
  end
  return nil
end

function LoginModule:_ModuleUnLock(gameModuleID)
  local module = GameGlobal.GetModule(RoleModule)
  return module:CheckModuleUnlock(gameModuleID)
end

function LoginModule:_CampaignOpen(TT, campaignType)
  local res = AsyncRequestRes:New()
  local campaign = UIActivityCampaign:New()
  campaign:LoadCampaignInfo(TT, res, campaignType)
  return res:GetSucc() and campaign:CheckCampaignOpen()
end

function LoginModule:EnterMatchStage1(TT, bblackloading)
  GameGlobal.UIStateManager():Lock("EnterMatchStage1")
  GameGlobal.UIStateManager():ShowBusy(true)
  local game = self:GetModule(GameMatchModule)
  local stage1Id = Cfg.cfg_global.stage_1_id.IntValue
  local createInfo = game:GetMatchCreateInfo(MatchType.MT_Mission, stage1Id)
  local ret = game:StartMatchTask(TT, MatchType.MT_Mission, 1, createInfo, bblackloading)
  if ret:GetSucc() then
    local missionModule = self:GetModule(MissionModule)
    local data = missionModule:GetDiscoveryData()
    local node = data:GetNodeDataByStageId(stage1Id)
    data:SetCurPosNodeId(node.id)
  else
    ToastManager.ShowToast(game:GetErrorMsg(ret:GetResult()))
    GameGlobal.GameLogic():BackToLogin(false, LoginModule, "player logout", false)
  end
  GameGlobal.UIStateManager():ShowBusy(false)
  GameGlobal.UIStateManager():UnLock("EnterMatchStage1")
end

function LoginModule:ReplayCreateNameStory(stage1MissionId)
  local mission = self:GetModule(MissionModule)
  local stage1MissionId = Cfg.cfg_global.stage_1_id.IntValue
  local discoveryData = mission:GetDiscoveryData()
  local story = discoveryData:GetStoryByStageIdStoryType(stage1MissionId, StoryTriggerType.AfterFight)
  if story then
    GameGlobal.UIStateManager():ShowDialog("UIStoryController", story.id, function()
      GameGlobal.TaskManager():StartTask(self.ActiveCreateStory, self, stage1MissionId)
    end)
  end
end

function LoginModule:ActiveCreateStory(TT, stage1MissionId)
  GameGlobal.UIStateManager():Lock("ActiveCreateStory")
  GameGlobal.UIStateManager():ShowBusy(true)
  local mission = self:GetModule(MissionModule)
  mission:SetMissionStoryActive(TT, stage1MissionId, ActiveStoryType.ActiveStoryType_AfterBattle)
  local guideModule = self:GetModule(GuideModule)
  guideModule:DirectEnterStage2(TT)
  GameGlobal.UIStateManager():ShowBusy(false)
  GameGlobal.UIStateManager():UnLock("ActiveCreateStory")
end

function StarGameNew()
  local lm = GameGlobal.GetModule(LoginModule)
  lm:NewLoginStart()
end

function LogoutGameNew()
  if HelperProxy:GetInstance():GetConfig("TMPLoginSwitch", "false") == "true" then
    GameGlobal.RealTimer():AddEvent(0, function()
      LoginLuaHelper.StartUI()
      AudioHelperController.PlayBGMById(CriAudioIDConst.BGMLogin, AudioConstValue.BGMCrossFadeTime)
    end)
  end
end

function LoginModule:JudgeCanSingleLoginSucess()
  local openid = GameGlobal.GameLogic():GetOpenId()
  local singleUserData = UnityEngine.PlayerPrefs.GetString("SingleUserData")
  local qr_openid
  if not string.isnullorempty(singleUserData) then
    qr_openid = self:GetReadStrByIdx(3)
  end
  local temp = false
  if string.isnullorempty(singleUserData) then
    GetQR_Local.ReadFile(function(str)
      if str == "-2" then
        ToastManager.ShowToast("二维码数据有误，请重新登录")
        Log.error("二维码数据有误，请重新登录1 openId = ", openid)
        self.single_error_code = -1
      elseif string.isnullorempty(str) then
        ToastManager.ShowToast("二维码数据为空，请重新登录")
        self.single_error_code = -1
      else
        local newStrList = string.split(str, "|")
        if 3 <= #newStrList then
          qr_openid = newStrList[3]
          if qr_openid ~= openid and not string.isnullorempty(openid) then
            ToastManager.ShowToast("二维码数据有误，请重新登录")
            Log.error("二维码数据有误，请重新登录2 openId qr_openid = " .. openid .. "  " .. qr_openid)
            self.single_error_code = -2
          else
            UnityEngine.PlayerPrefs.SetString("SingleUserData", str)
            self.single_error_code = 0
          end
        else
          self.single_error_code = -3
        end
      end
      temp = true
    end)
  else
    temp = true
    self.single_error_code = 0
  end
  while not temp do
  end
  return self.single_error_code
end

function LoginModule:JudgeCanSingleLoginSucessTT(TT)
  local openid = GameGlobal.GameLogic():GetOpenId()
  local singleUserData = UnityEngine.PlayerPrefs.GetString("SingleUserData")
  local qr_openid
  if not string.isnullorempty(singleUserData) then
    qr_openid = self:GetReadStrByIdx(3)
  end
  local temp = false
  if string.isnullorempty(singleUserData) then
    GetQR_Local.ReadFile(function(str)
      if str == "-2" then
        Log.error("二维码数据有误，请重新登录1 openId = ", openid)
        self.single_error_code = -1
      elseif string.isnullorempty(str) then
        self.single_error_code = -1
      else
        local newStrList = string.split(str, "|")
        if 3 <= #newStrList then
          qr_openid = newStrList[3]
          if qr_openid ~= openid and not string.isnullorempty(openid) then
            Log.error("二维码数据有误，请重新登录2 openId qr_openid = " .. openid .. "  " .. qr_openid)
            self.single_error_code = -2
          else
            UnityEngine.PlayerPrefs.SetString("SingleUserData", str)
            self.single_error_code = 0
          end
        else
          self.single_error_code = -3
        end
      end
      temp = true
    end)
  else
    self.single_error_code = 0
    temp = true
  end
  while not temp do
    YIELD(TT)
  end
  if self.single_error_code == 0 then
    GameGlobal.TaskManager():StartTask(self.OnSingleLoginSuccess, self)
  elseif self.single_error_code == -1 or self.single_error_code == -3 then
    ToastManager.ShowToast(StringTable.Get("str_set_read_data_not_fail"))
  elseif self.single_error_code == -2 then
    ToastManager.ShowToast(StringTable.Get("str_set_read_data_fail"))
  else
    ToastManager.ShowToast(StringTable.Get("str_login_load_data_error"))
  end
end

function LoginModule:OnSingleLoginSuccess(TT)
  GameGlobal.UIStateManager():Lock("DoNewLogin")
  while GameGlobal.UIStateManager():CurUIStateType() ~= UIStateType.LoginEmpty do
    YIELD(TT)
  end
  GameSingle = true
  local char_mod = self:GetModule(RoleModule)
  char_mod:InitCharInfo(nil)
  char_mod:InitChosePainting(nil)
  local medalModule = self:GetModule(MedalModule)
  medalModule:SetAllMedalData(nil)
  local pet_md = self:GetModule(PetModule)
  pet_md:HandlePetSingleData(UnityEngine.PlayerPrefs.GetString("SingleUserData"))
  local str = "4001010,0,7,1,1|4001020,0,7,1,1|4001030,0,7,1,1|4001045,0,0,3,1|4001040,0,7,1,1|4001041,0,7,1,1|4001050,0,7,1,1|4001051,0,7,1,2|4001060,0,7,1,1|4001070,0,7,2,1|4001095,0,0,3,1|4001080,0,7,1,1|4001090,0,7,1,1|4001100,0,7,1,1|4001101,0,7,1,2|4001110,0,7,1,1|4001120,0,7,1,1|4001130,0,7,2,1|4002015,0,0,3,1|4002010,0,7,1,1|4002035,0,0,3,1|4002020,0,7,1,1|4002030,0,7,1,1|4002031,0,7,1,2|4002040,0,7,1,1|4002050,0,7,1,1|4002060,0,7,2,1|4002095,0,0,3,1|4002070,0,7,1,1|4002080,0,7,1,1|4002090,0,7,1,1|4002100,0,7,1,1|4002101,0,7,1,2|4002110,0,7,1,1|4002120,0,7,2,1|4003015,0,0,3,1|4003010,0,7,1,1|4003020,0,7,1,1|4003030,0,7,1,1|4003031,0,7,1,2|4003040,0,7,1,1|4003050,0,7,1,1|4003060,0,7,2,1|4003070,0,7,1,1|4003080,0,7,1,1|4003090,0,7,1,1|4003100,0,7,1,1|4003091,0,7,1,2|4003110,0,7,1,1|4003120,0,7,2,1|4003145,0,0,3,1|4004015,0,0,3,1|4004010,0,7,1,1|4004020,0,7,1,1|4004030,0,7,1,1|4004031,0,7,1,2|4004040,0,7,1,1|4004050,0,7,1,1|4004060,0,7,2,1|4004085,0,0,3,1|4004070,0,7,1,1|4004080,0,7,1,1|4004090,0,7,1,1|4004091,0,7,1,2|4004100,0,7,1,1|4004110,0,7,1,1|4004120,0,7,2,1|4005015,0,0,3,1|4005010,0,7,1,1|4005020,0,7,1,1|4005030,0,7,1,1|4005031,0,7,1,2|4005040,0,7,1,1|4005050,0,7,1,1|4005060,0,7,2,1|4005070,0,7,1,1|4005080,0,7,1,1|4005090,0,7,1,1|4005091,0,7,1,2|4005100,0,7,1,1|4005110,0,7,1,1|4005120,0,7,2,1|4006015,0,0,3,1|4006010,0,7,1,1|4006020,0,7,1,1|4006030,0,7,1,1|4006031,0,7,1,2|4006040,0,7,1,1|4006050,0,7,1,1|4006060,0,7,2,1|4006085,0,0,3,1|4006070,0,7,1,1|4006080,0,7,1,1|4006090,0,7,1,1|4006091,0,7,1,2|4006100,0,7,1,1|4006110,0,7,1,1|4006120,0,7,2,1|4007015,0,0,3,1|4007010,0,7,1,1|4007020,0,7,1,1|4007030,0,7,1,1|4007031,0,7,1,2|4007040,0,7,1,1|4007050,0,7,1,1|4007060,0,7,2,1|4007085,0,0,3,1|4007070,0,7,1,1|4007080,0,7,1,1|4007090,0,7,1,1|4007100,0,7,1,1|4007110,0,7,1,1|4007111,0,7,1,2|4007120,0,7,2,1|4008015,0,0,3,1|4008020,0,7,1,1|4008030,0,7,1,1|4008040,0,7,1,1|4008041,0,7,1,2|4008050,0,7,1,1|4008060,0,7,1,1|4008070,0,7,2,1|4008085,0,0,3,1|4008090,0,7,1,1|4008100,0,7,1,1|4008110,0,7,1,1|4008111,0,7,1,2|4008120,0,7,1,1|4008130,0,7,1,1|4008140,0,7,2,1|4008155,0,0,3,1|4009015,0,0,3,1|4009020,0,7,1,1|4009030,0,7,1,1|4009040,0,7,1,1|4009041,0,7,1,2|4009050,0,7,1,1|4009060,0,7,1,1|4009070,0,7,2,1|4009085,0,0,3,1|4009090,0,7,1,1|4009100,0,7,1,1|4009110,0,7,1,1|4009111,0,7,1,2|4009120,0,7,1,1|4009130,0,7,1,1|4009140,0,7,2,1|4010015,0,0,3,1|4010020,0,7,1,1|4010030,0,7,1,1|4010040,0,7,1,1|4010041,0,7,1,2|4010050,0,7,1,1|4010060,0,7,1,1|4010070,0,7,2,1|4010085,0,0,3,1|4010090,0,7,1,1|4010100,0,7,1,1|4010110,0,7,1,1|4010111,0,7,1,2|4010120,0,7,1,1|4010130,0,7,1,1|4010140,0,7,2,1|4010155,0,0,3,1|4101015,0,0,3,1|4101020,0,7,1,1|4101030,0,7,1,1|4101040,0,7,2,1|4101055,0,0,3,1|4101060,0,7,1,1|4101070,0,7,1,1|4101080,0,7,1,1|4101090,0,7,2,1|4101105,0,0,3,1|4201015,0,0,3,1|4201020,0,7,1,1|4201030,0,7,1,1|4201040,0,7,1,1|4201041,0,7,1,2|4201050,0,7,1,1|4201060,0,7,1,1|4201061,0,7,1,2|4201070,0,7,1,1|4201080,0,7,1,1|4201090,0,7,2,1|4201100,0,7,1,1|4201115,0,0,3,1|4201120,0,7,1,1|4201130,0,7,1,1|4201140,0,7,2,1|4201155,0,0,3,1|4202015,0,0,3,1|4202020,0,7,1,1|4202030,0,7,1,1|4202040,0,7,1,1|4202041,0,7,1,2|4202050,0,7,1,1|4202060,0,7,1,1|4202070,0,7,2,1|4202085,0,0,3,1|4202090,0,7,1,1|4202100,0,7,1,1|4202110,0,7,1,1|4202111,0,7,1,2|4202120,0,7,1,1|4202130,0,7,1,1|4202140,0,7,2,1|4202155,0,0,3,1|4203015,0,0,3,1|4203020,0,7,1,1|4203030,0,7,1,1|4203040,0,7,1,1|4203050,0,7,1,1|4203060,0,7,1,1|4203070,0,7,2,1|4203085,0,0,3,1|4203090,0,7,1,1|4203100,0,7,1,1|4203110,0,7,1,1|4203111,0,7,1,2|4203120,0,7,1,1|4203130,0,7,1,1|4203140,0,7,2,1|4203155,0,0,3,1|4204015,0,0,3,1|4204020,0,7,1,1|4204030,0,7,1,1|4204031,0,7,1,2|4204040,0,7,1,1|4204050,0,7,1,1|4204060,0,7,1,1|4204070,0,7,2,1|4204085,0,0,3,1|4204090,0,7,1,1|4204100,0,7,1,1|4204101,0,7,1,2|4204110,0,7,1,1|4204120,0,7,1,1|4204130,0,7,1,1|4204140,0,7,2,1|4204155,0,0,3,1|4205015,0,0,3,1|4205020,0,7,1,1|4205030,0,7,1,1|4205040,0,7,1,1|4205041,0,7,1,2|4205050,0,7,1,1|4205065,0,0,3,1|4205070,0,7,1,1|4205080,0,7,1,1|4205090,0,7,2,1|4205100,0,7,1,1|4205101,0,7,1,2|4205110,0,7,1,1|4205120,0,7,1,1|4205130,0,7,1,1|4205140,0,7,2,1|4205155,0,0,3,1|4206015,0,0,3,1|4206020,0,7,1,1|4206030,0,7,1,1|4206040,0,7,1,1|4206041,0,7,1,2|4206050,0,7,1,1|4206060,0,7,1,1|4206070,0,7,1,1|4206080,0,7,1,1|4206090,0,7,2,1|4206105,0,0,3,1|4206110,0,7,1,1|4206120,0,7,1,1|4206121,0,7,1,2|4206130,0,7,1,1|4206140,0,7,2,1|4206155,0,0,3,1|4207015,0,0,3,1|4207020,0,7,1,1|4207030,0,7,1,1|4207031,0,7,1,2|4207040,0,7,1,1|4207050,0,7,1,1|4207060,0,7,1,1|4207075,0,0,3,1|4207080,0,7,1,1|4207090,0,7,2,1|4207100,0,7,1,1|4207110,0,7,1,1|4207111,0,7,1,2|4207120,0,7,1,1|4207130,0,7,1,1|4207140,0,7,2,1|4207155,0,0,3,1|4208015,0,0,3,1|4208020,0,7,1,1|4208030,0,7,1,1|4208040,0,7,1,1|4208041,0,7,1,2|4208050,0,7,1,1|4208060,0,7,2,1|4208070,0,7,1,1|4208080,0,7,1,1|4208095,0,0,3,1|4208100,0,7,1,1|4208110,0,7,1,1|4208111,0,7,1,2|4208120,0,7,1,1|4208130,0,7,1,1|4208140,0,7,2,1|4208155,0,0,3,1|4209015,0,0,3,1|4209020,0,7,1,1|4209030,0,7,1,1|4209040,0,7,1,1|4209050,0,7,1,1|4209065,0,0,3,1|4209070,0,7,1,1|4209080,0,7,1,1|4209081,0,7,1,2|4209090,0,7,2,1|4209100,0,7,1,1|4209115,0,0,3,1|4209120,0,7,1,1|4209121,0,7,1,2|4209130,0,7,1,1|4209140,0,7,1,1|4209150,0,7,2,1|4210015,0,0,3,1|4210020,0,7,1,1|4210030,0,7,1,1|4210045,0,0,3,1|4210050,0,7,1,1|4210060,0,7,1,1|4210070,0,7,1,1|4210071,0,7,1,2|4210080,0,7,2,1|4210090,0,7,1,1|4210100,0,7,1,1|4210110,0,7,1,1|4210120,0,7,1,1|4210121,0,7,1,2|4210130,0,7,1,1|4210140,0,7,2,1|4210155,0,0,3,1|4301015,0,0,3,1|4301020,0,7,1,1|4301030,0,7,1,1|4301040,0,7,1,1|4301055,0,7,1,1|4301060,0,7,1,1|4301070,0,0,3,1|4301080,0,7,1,1|4301090,0,7,2,1|4301105,0,0,3,1|90010001,0,7,2,0|90010101,0,7,2,0|90010201,0,7,2,0|90010202,0,7,2,0|90010203,0,7,2,0|90010204,0,7,2,0|90010205,0,7,2,0|90010206,0,7,2,0|90010207,0,7,2,0|90010208,0,7,2,0|90010209,0,7,2,0|90010210,0,7,2,0|90010211,0,7,2,0|90010301,0,7,2,0|90010302,0,7,2,0|90010303,0,7,2,0|90010304,0,7,2,0|90010305,0,7,2,0|90010306,0,7,2,0|90010307,0,7,2,0|90010308,0,7,2,0|90010309,0,7,2,0|90010310,0,7,2,0|90010311,0,7,2,0|90010312,0,7,2,0|90010313,0,7,2,0|90010314,0,7,2,0|90010401,0,7,2,0|90010402,0,7,2,0|90010403,0,7,2,0|90010404,0,7,2,0|90010405,0,7,2,0|90010406,0,7,2,0|90010407,0,7,2,0|90010408,0,7,2,0|90010409,0,7,2,0|90010410,0,7,2,0|90010411,0,7,2,0|90010412,0,7,2,0|4203041,0,7,1,2|4220015,0,0,3,1|4220020,0,7,1,1|4220030,0,7,1,1|4220040,0,7,1,1|4220050,0,7,1,1|4220060,0,7,1,1|4220061,0,7,1,2|4220070,0,7,1,1|4220071,0,7,1,2|4220085,0,0,3,1|4220090,0,7,2,1|4220100,0,7,1,1|4220110,0,7,2,1|4220125,0,0,3,1"
  local strList = string.split(str, "|")
  local passMission = {}
  for i = 1, #strList do
    local missionstr = string.split(strList[i], ",")
    local _mission_info = mission_info:New()
    _mission_info.id = tonumber(missionstr[1])
    _mission_info.pass_without_help = tonumber(missionstr[2])
    _mission_info.star = tonumber(missionstr[3])
    _mission_info.type = tonumber(missionstr[4])
    _mission_info.waypoint_type = tonumber(missionstr[5])
    table.insert(passMission, _mission_info)
  end
  local mission_mod = self:GetModule(MissionModule)
  mission_mod:InitMissionInfo(4208155, passMission)
  local formation_infos = PlayerPrefsGetPersonString("SingleUserFormationInfos")
  if formation_infos == nil then
    local defaultValue = ""
    for i = 1, 8 do
      if i < 8 then
        defaultValue = defaultValue .. "1500331,0,0,0,0|"
      else
        defaultValue = defaultValue .. "1500331,0,0,0,0"
      end
    end
    PlayerPrefsSetPersonString("SingleUserFormationInfos", defaultValue)
    formation_infos = defaultValue
  end
  local strListFormation = string.split(formation_infos, "|")
  local formation_infosList = {}
  for i = 1, 8 do
    local formation_infos = formation_info:New()
    formation_infos.id = i
    formation_infos.name = i
    local strListPets = string.split(strListFormation[i], ",")
    for i = 1, 5 do
      table.insert(formation_infos.pet_list, tonumber(strListPets[i]))
    end
    table.insert(formation_infosList, formation_infos)
  end
  mission_mod:SetFormationInfos(formation_infosList)
  UIGlobalModule:SetCSUICameraStatus(false)
  LoginLuaHelper.CloseAllUI()
  GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
  GameGlobal.UIStateManager():UnLock("DoNewLogin")
end

function LoginModule:GetSingleState()
  local OnLineToOffine = Cfg.cfg_global.OnLineToOffine.StrValue
  if OnLineToOffine then
    local singleTime = self:GetTimeStampByTimeStr(OnLineToOffine, Enum_DateTimeZoneType.E_ZoneType_GMT)
    local single_time = LocalDB.GetString("SingleTime", "")
    if string.isnullorempty(single_time) or tostring(singleTime) ~= single_time then
      LocalDB.SetString("SingleTime", tostring(singleTime))
    end
    local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
    local tmNowTime = math.modf(time_mod:GetServerTime() / 1000)
    if singleTime > tmNowTime then
      return false
    elseif singleTime <= tmNowTime then
      return true
    end
  else
    return false
  end
end

function LoginModule:GetSingleTimeTick()
  local single_time = LocalDB.GetString("SingleTime", "")
  if not string.isnullorempty(single_time) then
    local num_single_time = tonumber(single_time)
    return num_single_time
  end
  return 0
end

function PlayerPrefsGetPersonInt(key, defaultValue)
  return UnityEngine.PlayerPrefs.GetInt(key, defaultValue)
end

function PlayerPrefsSetPersonInt(key, defaultValue)
  UnityEngine.PlayerPrefs.SetInt(key, defaultValue)
end

function PlayerPrefsGetPersonString(key, defaultValue)
  return UnityEngine.PlayerPrefs.GetString(key, defaultValue)
end

function PlayerPrefsSetPersonString(key, defaultValue)
  UnityEngine.PlayerPrefs.SetString(key, defaultValue)
end

function DeletePlayerPersonKey(key)
  UnityEngine.PlayerPrefs.DeleteKey(key)
end

function ClearPlayerPrefsOnLogOut()
  DeletePlayerPersonKey("SingleUserData")
  DeletePlayerPersonKey("m_char_info")
  DeletePlayerPersonKey("m_choose_painting")
  DeletePlayerPersonKey("CurMainDressUp")
  DeletePlayerPersonKey("MainDressUp")
  DeletePlayerPersonKey("placement_info")
end

function LoginModule:GetSaveStr()
  local module = GameGlobal.GetModule(PetModule)
  local str = module:GetPetIndexStr() .. "|" .. module:GetPetSkinIndexStr() .. "|" .. GameGlobal.GameLogic():GetOpenId() .. "|" .. GameGlobal.GetModule(RoleModule):GetSaveName()
  return str
end

function LoginModule:GetReadStrByIdx(idx)
  local str = UnityEngine.PlayerPrefs.GetString("SingleUserData")
  local strList = string.split(str, "|")
  if idx > #strList then
    return ""
  end
  if idx == 4 then
    return GetQR_Local.UnicodeToString(strList[idx])
  end
  return strList[idx]
end
