_class("UIN29DetectiveLogin", UIController)
UIN29DetectiveLogin = UIN29DetectiveLogin

function UIN29DetectiveLogin:Constructor()
  self._cdEnd = {tick = 0, period = 30000}
end

function UIN29DetectiveLogin:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign.New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N29, ECampaignN29ComponentID.ECAMPAIGN_N29_DETECTIVE, ECampaignN29ComponentID.ECAMPAIGN_N29_QUEST)
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._detectiveComponent = self._localProcess:GetComponent(ECampaignN29ComponentID.ECAMPAIGN_N29_DETECTIVE)
  self._questComponent = self._localProcess:GetComponent(ECampaignN29ComponentID.ECAMPAIGN_N29_QUEST)
end

function UIN29DetectiveLogin:OnShow(uiParams)
  self._uiWidget = self:GetUIComponent("RectTransform", "uiWidget")
  self._btnAnywhere = self:GetUIComponent("RectTransform", "btnAnywhere")
  self._ltBtn = self:GetUIComponent("UISelectObjectPath", "ltBtn")
  self._redCollection = self:View():GetUIComponent("UISelectObjectPath", "redCollection")
  self._redCollectionSpawn = nil
  self._txtEndDuration = self:GetUIComponent("UILocalizationText", "txtEndDuration")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._plotMask = self:GetUIComponent("RectTransform", "plotMask")
  self._plotMask.gameObject:SetActive(false)
  self._localDb = UIN29DetectiveLocalDb:New()
  self._localDb:GameLoadDB()
  self._localDb:ViewedLoadDB()
  self._localDb:BreakPosition()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self.OnActivityCloseEvent)
  self:EnterFullScreenBg(false)
  self:InitCommonTopButton()
  self:FlushCollectionRedDot()
  self:FlushEndDuration()
  self:CheckGuide()
end

function UIN29DetectiveLogin:OnHide()
end

function UIN29DetectiveLogin:OnUpdate(deltaTimeMS)
  self._cdEnd.tick = self._cdEnd.tick + deltaTimeMS
  if self._cdEnd.tick >= self._cdEnd.period then
    self._cdEnd.tick = 0
    self:FlushEndDuration()
  end
end

function UIN29DetectiveLogin:OnActivityCloseEvent(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN29DetectiveLogin:GetChildComponent(parent, componentTypeName, name)
  local child = parent.transform:Find(name)
  if child == nil then
    return nil
  end
  return child:GetComponent(componentTypeName)
end

function UIN29DetectiveLogin:EnterFullScreenBg(isEnter)
  self._uiWidget.gameObject:SetActive(not isEnter)
  self._btnAnywhere.gameObject:SetActive(isEnter)
end

function UIN29DetectiveLogin:InitCommonTopButton()
  local function fnHelp()
    self:ShowDialog("UIN29DetectiveReasoning", 3)
  end
  
  self._backBtns = self._ltBtn:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIActivityN29MainController, UIStateType.UIMain, nil, self._campaign._id)
  end, fnHelp, function()
    self:SwitchState(UIStateType.UIMain)
  end, false, function()
    self:EnterFullScreenBg(true)
  end)
  self._ltBtn:Engine().gameObject:SetActive(false)
end

function UIN29DetectiveLogin:FlushCollectionRedDot()
  local showRedDot = false
  showRedDot = showRedDot or self._localDb:GetEndCGReddot()
  showRedDot = showRedDot or self._localDb:GetMemoryReddot()
  showRedDot = showRedDot or self._localDb:GetAchieveReddot()
  if self._redCollection.gameObject.activeSelf ~= showRedDot then
    self._redCollection.gameObject:SetActive(showRedDot)
  end
  if showRedDot and self._redCollectionSpawn == nil then
    self._redCollectionSpawn = self._redCollection:SpawnOneObject("ManualLoad0")
  end
end

function UIN29DetectiveLogin:ReFlushCollectionRedDot()
  self._localDb:ViewedLoadDB()
  self:FlushCollectionRedDot()
end

function UIN29DetectiveLogin:GetFormatTimerStr(deltaTime, txtColor)
  local id = {
    day = "str_activity_common_day",
    hour = "str_activity_common_hour",
    min = "str_activity_common_minute",
    zero = "str_activity_common_less_minute",
    over = "str_activity_error_107",
    clrFormat = "<color=#%s>%s</color>"
  }
  if txtColor == nil then
    txtColor = "D0BA95"
  end
  local day = 0
  local hour = 0
  local min = 0
  local second = 0
  if 0 <= deltaTime then
    day, hour, min, second = UIActivityHelper.Time2Str(deltaTime)
  end
  local timeStr
  if 0 < day and 0 < hour then
    timeStr = string.format(id.clrFormat, txtColor, day) .. StringTable.Get(id.day)
    timeStr = timeStr .. string.format(id.clrFormat, txtColor, hour) .. StringTable.Get(id.hour)
  elseif 0 < day then
    timeStr = string.format(id.clrFormat, txtColor, day) .. StringTable.Get(id.day)
  elseif 0 < hour and 0 < min then
    timeStr = string.format(id.clrFormat, txtColor, hour) .. StringTable.Get(id.hour)
    timeStr = timeStr .. string.format(id.clrFormat, txtColor, min) .. StringTable.Get(id.min)
  elseif 0 < hour then
    timeStr = string.format(id.clrFormat, txtColor, hour) .. StringTable.Get(id.hour)
  elseif 0 < min then
    timeStr = string.format(id.clrFormat, txtColor, min) .. StringTable.Get(id.min)
  else
    timeStr = string.format(id.clrFormat, txtColor, StringTable.Get(id.zero))
  end
  return timeStr
end

function UIN29DetectiveLogin:FlushEndDuration()
  local endTime = self._detectiveComponent:GetComponentInfo().m_close_time
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local deltaTime = math.max(endTime - curTime, 0)
  local timerStr = self:GetFormatTimerStr(deltaTime)
  local txtValue = StringTable.Get("str_n29_detective_end_title", timerStr)
  self._txtEndDuration:SetText(txtValue)
end

function UIN29DetectiveLogin:BtnAnywhereOnClick(go)
  self:EnterFullScreenBg(false)
end

function UIN29DetectiveLogin:BtnIntroOnClick(go)
  self:ShowDialog("UIIntroLoader", "UIN29DetectiveLoginIntro")
end

function UIN29DetectiveLogin:ExistBreak()
  return self._localDb:ExistBreak()
end

function UIN29DetectiveLogin:BtnStartNewGameOnClick(go)
  if self:ExistBreak() then
    self:ShowDialog("UIN29DetectiveBreakLoad")
  else
    self:CallUIMethod("UIN29DetectiveLogin", "OnStartPlayGame", UIN29DetectiveLocalDb.Game_New, 1)
  end
end

function UIN29DetectiveLogin:BtnLoadArchivingOnClick(go)
  self:ShowDialog("UIN29DetectiveArchiveLoad")
end

function UIN29DetectiveLogin:BtnCollectionOnClick(go)
  local endTime = self._questComponent:GetComponentInfo().m_close_time
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  if endTime <= curTime then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
  else
    self:ShowDialog("UIN29DetectiveCollection")
  end
end

function UIN29DetectiveLogin:BtnExitOnClick(go)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  campaignModule:CampaignSwitchState(true, UIStateType.UIActivityN29MainController, UIStateType.UIMain, nil, self._campaign._id)
end

function UIN29DetectiveLogin:OnStartPlayGame(gameType, idStage)
  local endTime = self._detectiveComponent:GetComponentInfo().m_close_time
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  if endTime <= curTime then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
  else
    self:StartTask(self.OnStartPlayGameTask, self, gameType, idStage)
  end
end

function UIN29DetectiveLogin:OnStartPlayGameTask(TT, gameType, idStage)
  self:Lock("UIN29DetectiveLogin:OnStartPlayGameTask")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  if gameType == UIN29DetectiveLocalDb.Game_New then
    local allStage = self._localDb:GetAllStage()
    idStage = allStage[idStage].ID
    self._detectiveComponent:HandleStartGame(TT, res, CurDetectiveInfo:New())
    self._localDb:GameIdReasoning(UIN29DetectiveLocalDb.Game_Continue)
  elseif gameType == UIN29DetectiveLocalDb.Game_Archive then
    local archiveLoadData = self._localDb:ArchiveLoadData()
    self._detectiveComponent:HandleStartGame(TT, res, archiveLoadData)
    self._localDb:GameIdReasoning(UIN29DetectiveLocalDb.Game_Continue_Reasoning)
  end
  if not res:GetSucc() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
  elseif gameType == UIN29DetectiveLocalDb.Game_New then
    self._plotMask.gameObject:SetActive(true)
    self:ShowDialog("UIStoryController", 50470000, function()
      self:OnDetective(gameType, idStage)
    end)
  else
    self:OnDetective(gameType, idStage)
  end
  self:UnLock("UIN29DetectiveLogin:OnStartPlayGameTask")
end

function UIN29DetectiveLogin:OnDetective(gameType, idStage)
  if gameType == UIN29DetectiveLocalDb.Game_Archive then
    self:ShowDialog("UIN29DetectiveReasoning", idStage)
  elseif gameType == UIN29DetectiveLocalDb.Game_Continue_Reasoning then
    self:ShowDialog("UIN29DetectiveReasoning", idStage)
  elseif gameType == UIN29DetectiveLocalDb.Game_Continue_ReasoningPlot then
    local allStage = self._localDb:GetAllStage()
    self._localDb:AfterReasoningPlot(allStage[idStage].AfterReasoningPlot, true, nil, function()
      self._localDb:PlayEndingPlot(true)
    end)
  else
    self:SwitchState(UIStateType.UIActivityN29DetectiveMapController, idStage)
  end
end

function UIN29DetectiveLogin:CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN29DetectiveLogin)
end
