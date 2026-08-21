_class("UIMainModule", UIModule)
UIMainModule = UIMainModule

function UIMainModule:Dispose()
  self._openIdx = nil
  self._openList = nil
end

function UIMainModule:Constructor()
  self._openList = {}
  self._openIdx = 1
  self:RegisterAllOpenList()
end

function UIMainModule:GetOpenIdx()
  return self._openIdx
end

function UIMainModule:SetOpenIdx(idx)
  self._openIdx = idx
end

function UIMainModule:GetOpenList()
  local retList = {}
  if self._openList and table.count(self._openList) > 0 then
    for i = 1, #self._openList do
      local _data = self._openList[i]
      table.insert(retList, _data)
    end
  end
  return retList
end

function UIMainModule:RegisertOpenData(data)
  if not self._openList then
    self._openList = {}
  end
  if table.count(self._openList) > 0 then
    for i = 1, #self._openList do
      local _data = self._openList[i]
      if _data.ID == data.ID then
        Log.error("###[UIMainModule] RegisertOpenData -- regisert a same data ! id --> ", data.ID)
        return
      end
    end
  end
  local _data = data
  table.insert(self._openList, _data)
  Log.debug("###[UIMainModule] register one data ! id --> ", data.ID)
end

function UIMainModule:RemoveOpenData(data)
  if self._openList and table.count(self._openList) > 0 then
    for i = 1, #self._openList do
      local _data = self._openList[i]
      if _data.ID == data.ID then
        table.remove(self._openList, i)
        break
      end
    end
  end
end

function UIMainModule:RegisterAllOpenList()
  self:RegisterSignInOpen()
  if not NoNoticeOut then
    self:RegisterNoticeOpen()
  end
  local regCampaignCfgList = Cfg.cfg_main_open_list({NormalAndActivity = 1, Reg = true})
  if regCampaignCfgList and 0 < #regCampaignCfgList then
    for i = 1, #regCampaignCfgList do
      local cfg = regCampaignCfgList[i]
      self:RegisterActivityTotalLoginOpen(cfg.UIType)
    end
  end
end

function UIMainModule:RegisterSignInOpen()
  local uIMainOpenData = UIMainOpenData:New(UIMainOpenType.SignIn, function()
    local isPassMissionID = Cfg.cfg_global.signInPassMissionID.IntValue
    local missionModule = GameGlobal.GetModule(MissionModule)
    local isPass = missionModule:IsPassMissionID(isPassMissionID)
    if not isPass then
      return false
    end
    local signInModule = GameGlobal.GetModule(SignInModule)
    local todaySignIn = signInModule:IsSignInToday()
    if not todaySignIn then
      GameGlobal.UIStateManager():ShowDialog("UISignInController")
      return true
    end
    return false
  end, UIMainOpenState.DayOnce)
  self:RegisertOpenData(uIMainOpenData)
end

function UIMainModule:RegisterPetOpen()
  local uiMainOpenData = UIMainOpenData:New(UIMainOpenType.Pet, function()
    GameGlobal.UIStateManager():ShowDialog("UIHeartSpiritController")
    return true
  end, UIMainOpenState.DayOnce)
  self:RegisertOpenData(uiMainOpenData)
end

function UIMainModule:RegisterNoticeOpen()
  local uIMainOpenData = UIMainOpenData:New(UIMainOpenType.Notice, function()
    local noticeData = GameGlobal.GetModule(LoginModule):GetNoticeData()
    if noticeData == nil then
      Log.debug("###[UIMainModule] noticeData == nil!")
      return false
    end
    local systemState = noticeData:GetNoticeNewStateWithGroup(NoticeType.System)
    local activeState = noticeData:GetNoticeNewStateWithGroup(NoticeType.Active)
    local systemCount = noticeData:GetNoticeCountStateWithGroup(NoticeType.System)
    local activeCount = noticeData:GetNoticeCountStateWithGroup(NoticeType.Active)
    local systemState = noticeData:GetNoticeNewStateWithGroup(NoticeType.System)
    local ret = false
    local noticeOpen = GameGlobal.GetModule(RoleModule):CheckModuleUnlock(GameModuleID.MD_Notify)
    if noticeOpen then
      if systemState then
        if not noticeData._firstLogin and not NoPopNotice then
          GameGlobal.UIStateManager():ShowDialog("UINoticeController", NoticeType.System)
          ret = true
        end
      elseif activeState and not noticeData._firstLogin and not NoPopNotice then
        GameGlobal.UIStateManager():ShowDialog("UINoticeController", NoticeType.Active)
        ret = true
      end
    end
    if not noticeData._firstLogin then
      noticeData:ChangeFirstLogin()
    end
    if not ret then
      Log.debug("###[UIMainModule] notice no pop !")
    end
    return ret
  end, UIMainOpenState.Once)
  self:RegisertOpenData(uIMainOpenData)
end

function UIMainModule:RegisterActivityTotalLoginOpen(openType)
  local componentType = 0
  local open_cfg = Cfg.cfg_main_open_list({UIType = openType})
  if open_cfg and 0 < #open_cfg then
    componentType = open_cfg[1].RegParam
    if not componentType then
      return
    end
  else
    return
  end
  local campaignType = openType
  local uIMainOpenData = UIMainOpenData:New(openType, function()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    if not campaignModule then
      return false
    end
    local isCmptOpened = false
    local sampleInfo = campaignModule.m_campaign_manager:GetSampleByType(campaignType)
    if not sampleInfo then
      return false
    end
    if sampleInfo.is_open then
      isCmptOpened = true
    end
    if not isCmptOpened then
      return false
    end
    if openType == ECampaignType.CAMPAIGN_TYPE_COLLECT_FROG then
      local uiModule = GameGlobal.GetUIModule(CampaignModule)
      uiModule:ShowCollectFrogGuide()
    end
    local complateFlag = sampleInfo.m_extend_info[CampainExtendKey.E_CAMPAIGN_EXTEND_KEY_CUMULATIVE_LOGIN_COMPLATE]
    if complateFlag and complateFlag == 1 then
      return false
    end
    if openType == ECampaignType.CAMPAIGN_TYPE_N10 then
      GameGlobal.UIStateManager():ShowDialog("UIN10TotalLoginAwardController", true, campaignType, componentType)
    elseif openType == ECampaignType.CAMPAIGN_TYPE_N19_P5 then
      GameGlobal.UIStateManager():ShowDialog("UIN19P5SignInController", true)
    elseif openType == ECampaignType.CAMPAIGN_TYPE_N25_NEW_YEAR then
      GameGlobal.UIStateManager():ShowDialog("UIN25NewYear", true)
    elseif openType == ECampaignType.CAMPAIGN_TYPE_N31_ANNIVERSARY then
      local campaign = UIActivityCampaign:New()
      campaign:LoadCampaignInfo_Local(ECampaignType.CAMPAIGN_TYPE_N31_ANNIVERSARY)
      local show = UIN31SecondAnniversaryContent.CheckAutoPop(campaign)
      if show then
        GameGlobal.UIStateManager():ShowDialog("UISideEnterCenterController", {
          campaign_type = 10045,
          params = {true},
          single_mode = true
        })
      else
        return false
      end
    elseif openType == ECampaignType.CAMPAIGN_TYPE_INLAND_N7 then
      GameGlobal.UIStateManager():ShowDialog("UICN7N36TotalLoginAwardController", true, ECampaignType.CAMPAIGN_TYPE_INLAND_N7, ECampaignCN7ComponentID.ECAMPAIGN_N7_CUMULATIVE_LOGIN)
    else
      GameGlobal.UIStateManager():ShowDialog("UIActivityTotalLoginAwardController", true, campaignType, componentType)
    end
    return true
  end, UIMainOpenState.DayOnce)
  self:RegisertOpenData(uIMainOpenData)
end

function UIMainModule:GetUnLockBGMs()
  return self._unlockBgms
end

function UIMainModule:RemoveBGM1()
  if self._unlockBgms and next(self._unlockBgms) then
    table.remove(self._unlockBgms, 1)
  end
end

function UIMainModule:AddBGM(id)
  if not self._unlockBgms then
    self._unlockBgms = {}
  end
  if not table.icontains(self._unlockBgms, id) then
    table.insert(self._unlockBgms, id)
  end
end

function UIMainModule:CheckEventOpen(eventType)
  local cfgs = Cfg.cfg_common_event({Type = eventType})
  if #cfgs == 0 then
    return false
  end
  local cfg = cfgs[1]
  local startTime = HelperProxy:GetInstance():FormatGMTDateTime(cfg.DateTimeBegin)
  local endTime = HelperProxy:GetInstance():FormatGMTDateTime(cfg.DateTimeEnd)
  local svrTime = self:GetModule(SvrTimeModule):GetServerTime() / 1000
  return startTime <= svrTime and endTime >= svrTime
end

function UIMainModule:SetMainLobbyButtomCloseState(state)
  self._close = state
end

function UIMainModule:GetMainLobbyButtomCloseState()
  return self._close or false
end

_class("UIMainOpenData", Object)
UIMainOpenData = UIMainOpenData

function UIMainOpenData:Constructor(ID, checkFunc, openState)
  self.ID = ID
  self.CheckFunc = checkFunc
  self.OpenState = openState
  self.OpenTimes = 0
end

local UIMainOpenType = {
  Notice = 1,
  SignIn = 2,
  Pet = 3,
  TempSignIn = 104,
  YFXS = 10003,
  FEI = 10004,
  XIAHUO1 = 10005,
  XIAHUO2 = 10006,
  N5 = 10008,
  HOLLOWEEN = 10009,
  N7 = 10013,
  N8 = 10014,
  N9 = 10015,
  N10 = 10016,
  N11 = 10017,
  N12 = 10018,
  N13 = 10019,
  N14 = 10020,
  N15 = 10021,
  N16 = 10022,
  N17 = 10023,
  N18 = 10024,
  N19P5 = 10026,
  N20 = 10027,
  N21 = 10029,
  N22 = 10030,
  N25 = 10034
}
_enum("UIMainOpenType", UIMainOpenType)
local UIMainOpenState = {
  DayOnce = 0,
  Once = 1,
  Times = 99
}
_enum("UIMainOpenState", UIMainOpenState)
local CommonEventType = {LimitedTimeRecharge = 1}
_enum("CommonEventType", CommonEventType)
