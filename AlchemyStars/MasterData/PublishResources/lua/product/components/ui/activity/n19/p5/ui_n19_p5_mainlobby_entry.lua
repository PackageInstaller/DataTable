_class("UIN19P5MainLobbyEntry", UICustomWidget)
UIN19P5MainLobbyEntry = UIN19P5MainLobbyEntry

function UIN19P5MainLobbyEntry:Constructor()
  self._campaignModule = self:GetModule(CampaignModule)
end

function UIN19P5MainLobbyEntry:OnShow(uiParams)
  self:_GetComponents()
  self:_InitNewFlagAndRedPoint()
end

function UIN19P5MainLobbyEntry:_GetComponents()
  self._redPoint = self:GetGameObject("RedPoint")
  self._newFlag = self:GetGameObject("NewFlag")
end

function UIN19P5MainLobbyEntry:_InitNewFlagAndRedPoint()
  GameGlobal.TaskManager():StartTask(self.RequestData, self)
end

function UIN19P5MainLobbyEntry:SetData_uiMainLobbyController(controller)
  self._uiMainLobbyController = controller
end

function UIN19P5MainLobbyEntry:_Entry()
  if self._uiMainLobbyController then
    self._uiMainLobbyController._screenShot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self._uiMainLobbyController:GetName())
    local rt = self._uiMainLobbyController._screenShot:RefreshBlurTexture()
    local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
    self:StartTask(function(TT)
      YIELD(TT)
      UnityEngine.Graphics.Blit(rt, cache_rt)
      self:SwitchState(UIStateType.UIN19P5, cache_rt)
    end)
  else
    self:SwitchState(UIStateType.UIN19P5)
  end
end

function UIN19P5MainLobbyEntry:RequestData(TT)
  self:Lock("UIN19P5MainLobbyEntry_InitNewFlagAndRedPoint")
  local res = AsyncRequestRes:New()
  self._loginModule = self:GetModule(LoginModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N19_P5, ECampaignN19P5ComponentID.POWER2ITEM, ECampaignN19P5ComponentID.POWER_SHOP, ECampaignN19P5ComponentID.CUMULATIVE_LOGIN, ECampaignN19P5ComponentID.LEVEL)
  self:OnComponentStepChange()
  self:UnLock("UIN19P5MainLobbyEntry_InitNewFlagAndRedPoint")
end

function UIN19P5MainLobbyEntry:OnComponentStepChange()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local openID = roleModule:GetPstId()
  self._key = "N19P5MainLobbyNew2" .. openID
  self._new = true
  if LocalDB.GetInt(self._key, 0) == 1 then
    self._new = false
  end
  self._red = self:Red()
  self:_RefreshNewFlagAndRedPoint(self._new, self._red)
end

function UIN19P5MainLobbyEntry:Red()
  local storyRed = self:EndStoryShowAndRed()
  local redSignIn = self:GetSignInLock()
  local redPool = self:_CheckRedPoint(self.PoolRed, ECampaignN19P5ComponentID.POWER_SHOP)
  local redTry = self:GetPetTryLock()
  return storyRed or redSignIn or redPool or redTry
end

function UIN19P5MainLobbyEntry:GetSignInLock()
  local red = self:_CheckRedPoint(self.SignInRed, ECampaignN19P5ComponentID.CUMULATIVE_LOGIN)
  local component = self._campaign:GetComponentInfo(ECampaignN19P5ComponentID.CUMULATIVE_LOGIN)
  local lock = false
  if component then
    local endTime = component.m_close_time
    local nowTime = self._svrTimeModule:GetServerTime() * 0.001
    lock = endTime < nowTime
  end
  return red and not lock
end

function UIN19P5MainLobbyEntry:GetPetTryLock()
  self._localProcess = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N19_P5)
  local red = self._localProcess:PetStageRedPoint()
  local lock = false
  local component = self._campaign:GetComponentInfo(ECampaignN19P5ComponentID.LEVEL)
  if component then
    local endTime = component.m_close_time
    local nowTime = self._svrTimeModule:GetServerTime() * 0.001
    lock = endTime < nowTime
  end
  return red and not lock
end

function UIN19P5MainLobbyEntry:EndStoryShowAndRed()
  self._endStoryRed = false
  self._endStoryKay = "N19P5EndStoryKey"
  if LocalDB.GetInt(self._endStoryKay, 0) == 1 then
    self._endStoryRed = false
  else
    self._endStoryRed = true
  end
  local endStoryOpen = self:_GetCampaignEndStoryBtnState()
  return self._endStoryRed and endStoryOpen
end

function UIN19P5MainLobbyEntry:_GetCampaignEndStoryBtnState()
  local cfg = Cfg.cfg_n19_p5_end_story[1]
  if not cfg then
    return false
  end
  local endTime = self._loginModule:GetTimeStampByTimeStr(cfg.OpenTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  local nowTime = self._svrTimeModule:GetServerTime() * 0.001
  return endTime <= nowTime
end

function UIN19P5MainLobbyEntry:_CheckRedPoint(obj, ...)
  local bShow = self._campaign:CheckComponentRed(...)
  return bShow
end

function UIN19P5MainLobbyEntry:EntryBtnOnClick(go)
  GameGlobal.TaskManager():StartTask(self.EntryBtnOnClickCoro, self)
end

function UIN19P5MainLobbyEntry:EntryBtnOnClickCoro(TT)
  UIActivityHelper.PlayFirstPlot_Campaign(self._campaign, function()
    self:_Entry()
  end)
  if self._new then
    LocalDB.SetInt(self._key, 1)
  end
end

function UIN19P5MainLobbyEntry:_RefreshNewFlagAndRedPoint(isShowNew, isShowRed, existNotReadPaper)
  self._newFlag:SetActive(isShowNew)
  if isShowNew then
    self._redPoint:SetActive(false)
  else
    self._redPoint:SetActive(isShowRed or existNotReadPaper)
  end
end
