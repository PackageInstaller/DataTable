_class("UIN21MainLobbyEntry", UICustomWidget)
UIN21MainLobbyEntry = UIN21MainLobbyEntry

function UIN21MainLobbyEntry:Constructor()
  self._campaignModule = self:GetModule(CampaignModule)
end

function UIN21MainLobbyEntry:OnShow(uiParams)
  self:_GetComponents()
  self:_InitNewFlagAndRedPoint()
end

function UIN21MainLobbyEntry:_GetComponents()
  self._redPoint = self:GetGameObject("RedPoint")
  self._newFlag = self:GetGameObject("NewFlag")
  self._gameGo = self:GetGameObject("gameGo")
  self._questGo = self:GetGameObject("questGo")
  self._gameTex = self:GetUIComponent("RollingText", "gameTex")
  self._questTex = self:GetUIComponent("RollingText", "questTex")
end

function UIN21MainLobbyEntry:CheckText()
  local questOpen = self:QuestOpen()
  local gameOpen = self:GameOpen()
  self._questGo:SetActive(false)
  self._gameGo:SetActive(false)
  if questOpen then
    self._questGo:SetActive(true)
    self._questTex:RefreshText(StringTable.Get("str_n21_main_lobby_quest"))
  elseif gameOpen then
    self._gameGo:SetActive(true)
    self._gameTex:RefreshText(StringTable.Get("str_n21_main_lobby_game"))
  end
end

function UIN21MainLobbyEntry:GameOpen()
  local cInfo = self._campaign:GetComponentInfo(ECampaignN21ComponentID.ECAMPAIGN_N21_MINI_GAME)
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  if nowTimestamp < cInfo.m_unlock_time then
    return false
  elseif nowTimestamp > cInfo.m_close_time then
    return false
  end
  return true
end

function UIN21MainLobbyEntry:QuestOpen()
  do return false end
  local cInfo = self._campaign:GetComponentInfo(ECampaignN21ComponentID.ECAMPAIGN_N21_PANGOLIN)
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  if nowTimestamp < cInfo.m_unlock_time then
    return false
  elseif nowTimestamp > cInfo.m_close_time then
    return false
  end
  return true
end

function UIN21MainLobbyEntry:_InitNewFlagAndRedPoint()
  GameGlobal.TaskManager():StartTask(self.RequestData, self)
end

function UIN21MainLobbyEntry:SetData_uiMainLobbyController(controller)
  self._uiMainLobbyController = controller
end

function UIN21MainLobbyEntry:_Entry()
  self:SwitchState(UIStateType.UIN21Controller)
end

function UIN21MainLobbyEntry:RequestData(TT)
  self:Lock("UIN21MainLobbyEntry_InitNewFlagAndRedPoint")
  local res = AsyncRequestRes:New()
  self._loginModule = self:GetModule(LoginModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N21, ECampaignN21ComponentID.ECAMPAIGN_N21_CUMULATIVE_LOGIN, ECampaignN21ComponentID.ECAMPAIGN_N21_LEVEL_COMMON, ECampaignN21ComponentID.ECAMPAIGN_N21_LOTTERY, ECampaignN21ComponentID.ECAMPAIGN_N21_MINI_GAME, ECampaignN21ComponentID.ECAMPAIGN_N21_PANGOLIN, ECampaignN21ComponentID.ECAMPAIGN_N21_POWER2ITEM, ECampaignN21ComponentID.ECAMPAIGN_N21_LEVEL_FIXTEAM)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local openID = roleModule:GetPstId()
  self._key = "N21MainLobbyNew2" .. openID
  self._new = true
  if LocalDB.GetInt(self._key, 0) == 1 then
    self._new = false
  end
  self._red = self:Red()
  self:_RefreshNewFlagAndRedPoint(self._new, self._red)
  self:UnLock("UIN21MainLobbyEntry_InitNewFlagAndRedPoint")
end

function UIN21MainLobbyEntry:Red()
  local redSignIn = self:_CheckRedPoint(self.SignInRed, ECampaignN21ComponentID.ECAMPAIGN_N21_CUMULATIVE_LOGIN)
  local redPool = self:_CheckRedPoint(self.PoolRed, ECampaignN21ComponentID.ECAMPAIGN_N21_LOTTERY)
  local redTry = self:_CheckRedPoint(self.PetTryRed, ECampaignN21ComponentID.ECAMPAIGN_N21_LEVEL_FIXTEAM)
  local redLine = self:_CheckRedPoint(self.PetTryRed, ECampaignN21ComponentID.ECAMPAIGN_N21_LEVEL_COMMON)
  local redGame = self:CheckGameRed(ECampaignN21ComponentID.ECAMPAIGN_N21_MINI_GAME)
  local redQuest = self:_CheckRedPoint(self.PetTryRed, ECampaignN21ComponentID.ECAMPAIGN_N21_PANGOLIN)
  return redSignIn or redPool or redTry or redLine or redGame or redQuest
end

function UIN21MainLobbyEntry:CheckGameRed(componentid)
  local component = self._campaign:GetComponent(componentid)
  local cfgId = component and component:GetComponentCfgId()
  local cfg = Cfg.cfg_component_minigame_explore_limit({ComponentID = cfgId})
  local c1, c2 = HomelandFindTreasureConst.GetSingleCount(cfg and cfg[1])
  local unlock = false
  local component = self._campaign:GetComponent(componentid)
  if component then
    local curTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
    local unlockTime = component:ComponentUnLockTime()
    local stamp = unlockTime - curTime
    if not component:ComponentIsClose() then
      unlock = false
    elseif 0 < stamp then
      unlock = false
    elseif not component:ComponentIsUnLock() then
      unlock = false
    else
      unlock = true
    end
  end
  return unlock and 0 < c2
end

function UIN21MainLobbyEntry:_CheckRedPoint(obj, ...)
  local bShow = self._campaign:CheckComponentRed(...)
  return bShow
end

function UIN21MainLobbyEntry:EntryBtnOnClick(go)
  GameGlobal.TaskManager():StartTask(self.EntryBtnOnClickCoro, self)
end

function UIN21MainLobbyEntry:EntryBtnOnClickCoro(TT)
  UIActivityHelper.PlayFirstPlot_Campaign(self._campaign, function()
    self:_Entry()
  end)
  if self._new then
    LocalDB.SetInt(self._key, 1)
  end
end

function UIN21MainLobbyEntry:_RefreshNewFlagAndRedPoint(isShowNew, isShowRed, existNotReadPaper)
  self._newFlag:SetActive(isShowNew)
  if isShowNew then
    self._redPoint:SetActive(false)
  else
    self._redPoint:SetActive(isShowRed or existNotReadPaper)
  end
  self:CheckText()
end
