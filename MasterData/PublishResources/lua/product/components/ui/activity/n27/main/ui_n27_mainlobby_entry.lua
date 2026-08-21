_class("UIN27MainLobbyEntry", UICustomWidget)
UIN27MainLobbyEntry = UIN27MainLobbyEntry

function UIN27MainLobbyEntry:Constructor()
  self._campaignModule = self:GetModule(CampaignModule)
end

function UIN27MainLobbyEntry:OnShow(uiParams)
  self:_GetComponents()
  self:_InitNewFlagAndRedPoint()
end

function UIN27MainLobbyEntry:_GetComponents()
  self._redPoint = self:GetGameObject("RedPoint")
  self._newFlag = self:GetGameObject("NewFlag")
  self._texGo = self:GetGameObject("texGo")
  self._img = self:GetUIComponent("Image", "texGo")
  self._tex = self:GetUIComponent("RollingText", "tex")
  self._texComponent = self:GetUIComponent("UILocalizationText", "tex")
  self._atlas = self:GetAsset("UIN27.spriteatlas", LoadType.SpriteAtlas)
end

function UIN27MainLobbyEntry:CheckText()
  local questOpen = self:QuestOpen()
  local gameOpen = self:GameOpen()
  local diffOpen = self:DiffOpen()
  local lineOpen = self:LineOpen()
  local texColor = Color(0.2901960784313726, 0.3254901960784314, 0.5411764705882353, 1)
  local tex
  local sprite = "n27_zjm_state1"
  local open = false
  if questOpen then
  elseif gameOpen then
    open = true
    tex = "str_n27_main_entry_game_open"
    sprite = "n27_zjm_state2"
    texColor = Color(0.10980392156862745, 0.3058823529411765, 0.23921568627450981, 1)
  elseif diffOpen then
    open = true
    tex = "str_n27_main_entry_diff_open"
  elseif lineOpen then
    open = true
    tex = "str_n27_main_entry_line_open"
  end
  self._img.sprite = self._atlas:GetSprite(sprite)
  self._texGo:SetActive(open)
  if open then
    self._texComponent.color = texColor
    self._tex:RefreshText(StringTable.Get(tex))
  end
end

function UIN27MainLobbyEntry:LineOpen()
  local cInfo = self._campaign:GetComponentInfo(ECampaignN27ComponentID.ECAMPAIGN_N27_LINE_MISSION)
  if not cInfo then
    return false
  end
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  if nowTimestamp < cInfo.m_unlock_time then
    return false
  elseif nowTimestamp > cInfo.m_close_time then
    return false
  end
  return true
end

function UIN27MainLobbyEntry:DiffOpen()
  local cInfo = self._campaign:GetComponentInfo(ECampaignN27ComponentID.ECAMPAIGN_N27_DIFFICULT_MISSION)
  if not cInfo then
    return false
  end
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  if nowTimestamp < cInfo.m_unlock_time then
    return false
  elseif nowTimestamp > cInfo.m_close_time then
    return false
  end
  return true
end

function UIN27MainLobbyEntry:GameOpen()
  local cInfo = self._campaign:GetComponentInfo(ECampaignN27ComponentID.ECAMPAIGN_N27_POSTSTATON)
  if not cInfo then
    return false
  end
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  if nowTimestamp < cInfo.m_unlock_time then
    return false
  elseif nowTimestamp > cInfo.m_close_time then
    return false
  end
  return true
end

function UIN27MainLobbyEntry:QuestOpen()
  return false
end

function UIN27MainLobbyEntry:_InitNewFlagAndRedPoint()
  GameGlobal.TaskManager():StartTask(self.RequestData, self)
end

function UIN27MainLobbyEntry:SetData_uiMainLobbyController(controller)
  self._uiMainLobbyController = controller
end

function UIN27MainLobbyEntry:_Entry()
  CutsceneManager.ExcuteCutsceneIn_Shot()
  self:SwitchState(UIStateType.UIN27Controller)
end

function UIN27MainLobbyEntry:RequestData(TT)
  self:Lock("UIN27MainLobbyEntry_InitNewFlagAndRedPoint")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._loginModule = self:GetModule(LoginModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N27, ECampaignN27ComponentID.ECAMPAIGN_N27_CUMULATIVE_LOGIN, ECampaignN27ComponentID.ECAMPAIGN_N27_FIRST_MEET, ECampaignN27ComponentID.ECAMPAIGN_N27_POWER2ITEM, ECampaignN27ComponentID.ECAMPAIGN_N27_LINE_MISSION, ECampaignN27ComponentID.ECAMPAIGN_N27_DIFFICULT_MISSION, ECampaignN27ComponentID.ECAMPAIGN_N27_BLACK_DIFFICULT_MISSION, ECampaignN27ComponentID.ECAMPAIGN_N27_LOTTERY, ECampaignN27ComponentID.ECAMPAIGN_N27_POSTSTATON)
  self.N27MinigameHelper = N27MinigameHelper:New()
  self.N27MinigameHelper:LoadData(TT, res)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local openID = roleModule:GetPstId()
  self._new = self:GetNew()
  self._red = self:Red()
  self:_RefreshNewFlagAndRedPoint(self._new, self._red)
  self:UnLock("UIN27MainLobbyEntry_InitNewFlagAndRedPoint")
end

function UIN27MainLobbyEntry:SetMainEntryNew()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local openID = roleModule:GetPstId()
  local key = "UIN27MAIN_ENTRY_" .. openID
  local val = LocalDB.GetInt(key, 0)
  if val == 0 then
    LocalDB.SetInt(key, 1)
  end
end

function UIN27MainLobbyEntry:GetNew()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local openID = roleModule:GetPstId()
  local mainNew = false
  do
    local key = "UIN27MAIN_ENTRY_" .. openID
    local val = LocalDB.GetInt(key, 0)
    mainNew = val == 0
  end
  local lineNew = false
  local lineOpen = self:CheckComponentLock(ECampaignN27ComponentID.ECAMPAIGN_N27_LINE_MISSION) == N27ComponetStatus.Open
  if lineOpen then
    local key = "UIN27MAIN_LINEMISSIOIN_" .. openID
    local val = LocalDB.GetInt(key, 0)
    lineNew = val == 0
  end
  local diffNew = false
  local diffOpen = self:CheckComponentLock(ECampaignN27ComponentID.ECAMPAIGN_N27_DIFFICULT_MISSION) == N27ComponetStatus.Open
  if diffOpen then
    local key = "UIN27MAIN_DIFF_" .. openID
    local val = LocalDB.GetInt(key, 0)
    diffNew = val == 0
  end
  local gameNew = false
  local gameOpen = self:CheckComponentLock(ECampaignN27ComponentID.ECAMPAIGN_N27_POSTSTATON) == N27ComponetStatus.Open
  if gameOpen then
    local key = "UIN27MAIN_GAME_" .. openID
    local val = LocalDB.GetInt(key, 0)
    local gameNew_main = val == 0
    local gameNew_inner = self.N27MinigameHelper:IsShowEntryNewOrRed()
    gameNew = gameNew_main or gameNew_inner
  end
  return gameNew or diffNew or lineNew or mainNew
end

function UIN27MainLobbyEntry:Red()
  local redSignIn = self:_CheckRedPoint(self.SignInRed, ECampaignN27ComponentID.ECAMPAIGN_N27_CUMULATIVE_LOGIN)
  local redPool = self:_CheckRedPoint(self.PoolRed, ECampaignN27ComponentID.ECAMPAIGN_N27_LOTTERY)
  local redTry = self:_CheckRedPoint(self.PetTryRed, ECampaignN27ComponentID.ECAMPAIGN_N27_FIRST_MEET)
  local redLine = self:_CheckRedPoint(self.PetTryRed, ECampaignN27ComponentID.ECAMPAIGN_N27_LINE_MISSION)
  local redGame = self:CheckGameRed(ECampaignN27ComponentID.ECAMPAIGN_N27_POSTSTATON)
  return redSignIn or redPool or redTry or redLine or redGame
end

function UIN27MainLobbyEntry:CheckGameRed(componentid)
  local newGame, redGame = self.N27MinigameHelper:IsShowEntryNewOrRed()
  local status = self:CheckComponentLock(ECampaignN27ComponentID.ECAMPAIGN_N27_POSTSTATON)
  local unlock = status == N27ComponetStatus.Open
  return unlock and redGame
end

function UIN27MainLobbyEntry:_CheckRedPoint(obj, ...)
  local bShow = self._campaign:CheckComponentRed(...)
  return bShow
end

function UIN27MainLobbyEntry:EntryBtnOnClick(go)
  GameGlobal.TaskManager():StartTask(self.EntryBtnOnClickCoro, self)
end

function UIN27MainLobbyEntry:EntryBtnOnClickCoro(TT)
  UIActivityHelper.PlayFirstPlot_Campaign(self._campaign, function()
    self:_Entry()
  end)
  self:SetMainEntryNew()
end

function UIN27MainLobbyEntry:CheckComponentLock(componentid)
  local component = self._campaign:GetComponent(componentid)
  if not component then
    Log.error("###[UIN27MainLobbyEntry] UIN27MainLobbyEntry:CheckComponentLock component == nil,componentid=", componentid)
    return N27ComponetStatus.Other
  end
  local curTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local unlockTime = component:ComponentUnLockTime()
  local stamp = unlockTime - curTime
  if component:ComponentIsClose() then
    return N27ComponetStatus.OverTime
  elseif 0 < stamp then
    return N27ComponetStatus.NotStart, unlockTime
  elseif not component:ComponentIsUnLock() then
    return N27ComponetStatus.Lock
  else
    local cInfo = self._campaign:GetComponentInfo(componentid)
    local closeTime = cInfo.m_close_time
    return N27ComponetStatus.Open, closeTime
  end
end

function UIN27MainLobbyEntry:_RefreshNewFlagAndRedPoint(isShowNew, isShowRed, existNotReadPaper)
  self._newFlag:SetActive(isShowNew)
  if isShowNew then
    self._redPoint:SetActive(false)
  else
    self._redPoint:SetActive(isShowRed or existNotReadPaper)
  end
  self:CheckText()
end
