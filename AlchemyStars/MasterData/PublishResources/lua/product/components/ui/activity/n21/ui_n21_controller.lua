_class("UIN21Controller", UIController)
UIN21Controller = UIN21Controller
local N21ComponetStatus = {
  NotStart = 1,
  OverTime = 2,
  Lock = 3,
  Other = 4,
  Open = 5
}
_enum("N21ComponetStatus", N21ComponetStatus)

function UIN21Controller:LoadDataOnEnter(TT, res, uiParams)
  self._loginModule = self:GetModule(LoginModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._missionModule = self:GetModule(MissionModule)
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N21, ECampaignN21ComponentID.ECAMPAIGN_N21_CUMULATIVE_LOGIN, ECampaignN21ComponentID.ECAMPAIGN_N21_LEVEL_COMMON, ECampaignN21ComponentID.ECAMPAIGN_N21_LOTTERY, ECampaignN21ComponentID.ECAMPAIGN_N21_MINI_GAME, ECampaignN21ComponentID.ECAMPAIGN_N21_PANGOLIN, ECampaignN21ComponentID.ECAMPAIGN_N21_POWER2ITEM, ECampaignN21ComponentID.ECAMPAIGN_N21_LEVEL_FIXTEAM)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._lotteryComponentInfo = self._campaign:GetComponentInfo(ECampaignN21ComponentID.ECAMPAIGN_N21_LOTTERY)
  self._costItemID = self._lotteryComponentInfo.m_cost_item_id
  self._localProcess = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N21)
  self._endType = 0
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, function()
    end, function()
      self:SwitchState(UIStateType.UIMain)
    end)
  end
  self:LoadDataOnEnter_BattlePass(TT)
end

function UIN21Controller:LoadDataOnEnter_BattlePass(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._battlepassCampaign = UIActivityCampaign:New()
  self._battlepassCampaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
end

function UIN21Controller:OnShow(uiParams)
  CutsceneManager.ExcuteCutsceneOut()
  self._rt = uiParams[1]
  self:GetComponents()
  self:AddListener()
  self:OnValue()
  self:Enternim()
  self:_CheckNewsignal()
  self:_CheckGuide()
end

function UIN21Controller:Enternim()
  if self.lineLock == N21ComponetStatus.Open then
    self.lineLight:SetActive(true)
  end
  if self.poolLock == N21ComponetStatus.Open then
    self.poolLight:SetActive(true)
  end
  if self.gameLock == N21ComponetStatus.Open then
    self.gameLight:SetActive(true)
  end
  if self.questLock == N21ComponetStatus.Open then
    self.questLight:SetActive(true)
  end
end

function UIN21Controller:AddListener()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.SummerTwoLoginRed, self.N19P5SignInRed)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self.OnComponentStepChange)
  self:AttachEvent(GameEventType.QuestUpdate, self.OnComponentStepChange)
end

function UIN21Controller:OnComponentStepChange()
  local redEvent = UIActivityHelper.CheckCampaignSampleRedPoint(self._battlepassCampaign)
  self.EventRed:SetActive(redEvent)
end

function UIN21Controller:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN21Controller:GetComponents()
  self.timeStr = self:GetUIComponent("RollingText", "timeStr")
  self.itemIcon = self:GetUIComponent("RawImageLoader", "itemIcon")
  self.backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self.SignInRed = self:GetGameObject("SignInRed")
  self.EventRed = self:GetGameObject("EventRed")
  self.PoolRed = self:GetGameObject("PoolRed")
  self.ShowBtn = self:GetGameObject("ShowBtn")
  self.Full = self:GetUIComponent("CanvasGroup", "Full")
  self.uiAnim = self:GetUIComponent("Animation", "uiAnim")
  self.itemCount2 = self:GetUIComponent("UILocalizationText", "itemCount2")
  self.itemCount = self:GetUIComponent("UILocalizationText", "itemCount")
  self.LineMissionRed = self:GetGameObject("LineMissionRed")
  self.GameRed = self:GetGameObject("GameRed")
  self.GameNew = self:GetGameObject("GameNew")
  self.QuestRed = self:GetGameObject("QuestRed")
  self.GameLockGo = self:GetGameObject("gameLock")
  self.QuestLockGo = self:GetGameObject("questLock")
  self.PoolLockGo = self:GetGameObject("poolLock")
  self.MissionLockGo = self:GetGameObject("missionLock")
  self.QuestTimerTex = self:GetUIComponent("RollingText", "QuestTimerTex")
  self.QuestTimerTexGo = self:GetGameObject("QuestTimerTexGo")
  self.GameTimerTex = self:GetUIComponent("RollingText", "GameTimerTex")
  self.GameTimerTexGo = self:GetGameObject("GameTimerTexGo")
  self._itemIcon = self:GetUIComponent("RawImageLoader", "itemIcon")
  self.lineLight = self:GetGameObject("mask_LineMissionBtn")
  self.poolLight = self:GetGameObject("mask_PoolBtn")
  self.gameLight = self:GetGameObject("mask_GameBtn")
  self.questLight = self:GetGameObject("mask_QuestBtn")
end

function UIN21Controller.GetItemCountStr(count, preColor, countColor)
  local dight = 0
  local tmpCount = count
  if tmpCount < 0 then
    tmpCount = -tmpCount
  end
  while 0 < tmpCount do
    tmpCount = math.floor(tmpCount / 10)
    dight = dight + 1
  end
  local pre = ""
  if 0 <= count then
    for i = 1, 7 - dight do
      pre = pre .. "0"
    end
  else
    for i = 1, 7 - dight - 1 do
      pre = pre .. "0"
    end
  end
  if 0 < count then
    return string.format("<color=" .. preColor .. ">%s</color><color=" .. countColor .. ">%s</color>", pre, count)
  elseif count == 0 then
    return string.format("<color=" .. preColor .. ">%s</color>", pre)
  else
    return string.format("<color=" .. preColor .. ">%s</color><color=" .. countColor .. ">%s</color>", pre, count)
  end
end

function UIN21Controller:ItemCount()
  local itemModule = GameGlobal.GetModule(ItemModule)
  local count = itemModule:GetItemCount(self._costItemID)
  self.itemCount:SetText(UIN21Controller.GetItemCountStr(count, "#8D8D8D", "#ffd146"))
  self.itemCount2:SetText(UIN21Controller.GetItemCountStr(count, "#000000", "#000000"))
  local cfg = Cfg.cfg_item[self._costItemID]
  if not cfg then
    Log.error("###[UIN21Controller] cfg is nil ! id --> ", self._costItemID)
  end
  self.itemIcon:LoadImage(cfg.Icon)
end

function UIN21Controller:OnHide()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  if self._timerEvent then
    GameGlobal.Timer():CancelEvent(self._timerEvent)
    self._timerEvent = nil
  end
  if self.animEvent then
    GameGlobal.Timer():CancelEvent(self.animEvent)
    self.animEvent = nil
  end
  if self._gameTimer then
    GameGlobal.Timer():CancelEvent(self._gameTimer)
    self._gameTimer = nil
  end
  if self._questTimer then
    GameGlobal.Timer():CancelEvent(self._questTimer)
    self._questTimer = nil
  end
end

function UIN21Controller:OnValue()
  local btns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    self:SwitchState(UIStateType.UIMain)
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end, false, function()
    self:HideBtnOnClick()
  end)
  self:ItemCount()
  self:CheckBtnLock()
  self:RT()
  self:Red()
  self:SetIcon()
end

function UIN21Controller:SetIcon()
  local cfg = Cfg.cfg_item[self._costItemID]
  if not cfg then
    Log.error("###[UIN21Controller] cfg is nil ! id --> ", self._costItemID)
  else
    self._itemIcon:LoadImage(cfg.Icon)
  end
end

function UIN21Controller:CheckBtnLock()
  self:LineLock()
  self:PoolLock()
  self:QuestLock()
  self:GameLock()
  self:CampaignLock()
end

function UIN21Controller:CampaignLock()
  local lineLock, lineEndTime = self:CheckComponentLock(ECampaignN21ComponentID.ECAMPAIGN_N21_LEVEL_COMMON)
  if lineLock == N21ComponetStatus.Open then
    self._endTime = lineEndTime
    self._endType = 1
  else
    local gameLock, gameEndTime = self:CheckComponentLock(ECampaignN21ComponentID.ECAMPAIGN_N21_MINI_GAME)
    if gameLock == N21ComponetStatus.Open then
      self._endTime = gameEndTime
      self._endType = 2
    else
      local sample = self._campaign:GetSample()
      self._endTime = sample.end_time
      self._endType = 3
    end
  end
  self:InitTimer()
end

function UIN21Controller:LineLock()
  self.lineLock = self:CheckComponentLock(ECampaignN21ComponentID.ECAMPAIGN_N21_LEVEL_COMMON)
  self.MissionLockGo:SetActive(self.lineLock ~= N21ComponetStatus.Open)
end

function UIN21Controller:PoolLock()
  self.poolLock = self:CheckComponentLock(ECampaignN21ComponentID.ECAMPAIGN_N21_LOTTERY)
  self.PoolLockGo:SetActive(self.poolLock ~= N21ComponetStatus.Open)
end

function UIN21Controller:GameLock()
  local status, param = self:CheckComponentLock(ECampaignN21ComponentID.ECAMPAIGN_N21_MINI_GAME)
  self.gameLock = status
  self.GameLockGo:SetActive(status ~= N21ComponetStatus.Open)
  self.GameTimerTexGo:SetActive(status == N21ComponetStatus.NotStart)
  if status == N21ComponetStatus.NotStart then
    self._gameStartTime = param or 0
    self:InitGameTimer()
  end
end

function UIN21Controller:InitGameTimer()
  if self._gameTimer then
    GameGlobal.Timer():CancelEvent(self._gameTimer)
  end
  self._gameTimer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:SetGameTimerTex()
  end)
  self:SetGameTimerTex()
end

function UIN21Controller:SetGameTimerTex()
  local svrTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local sec = self._gameStartTime - svrTime
  if sec < 0 then
    if self._gameTimer then
      GameGlobal.Timer():CancelEvent(self._gameTimer)
      self._gameTimer = nil
    end
    self:SwitchState(UIStateType.UIN21Controller)
  else
    local timeStr = HelperProxy:GetInstance():Time2Tex(sec)
    self.GameTimerTex:RefreshText(timeStr)
  end
end

function UIN21Controller:QuestLock()
  local status, param = self:CheckComponentLock(ECampaignN21ComponentID.ECAMPAIGN_N21_PANGOLIN)
  self.questLock = status
  self.QuestLockGo:SetActive(status ~= N21ComponetStatus.Open)
  self.QuestTimerTexGo:SetActive(status == N21ComponetStatus.NotStart)
  if status == N21ComponetStatus.NotStart then
    self._questStartTime = param or 0
    self:InitQuestTimer()
  end
end

function UIN21Controller:InitQuestTimer()
  if self._questTimer then
    GameGlobal.Timer():CancelEvent(self._questTimer)
  end
  self._questTimer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:SetQuestTimerTex()
  end)
  self:SetQuestTimerTex()
end

function UIN21Controller:SetQuestTimerTex()
  local svrTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local sec = self._questStartTime - svrTime
  if sec < 0 then
    if self._questTimer then
      GameGlobal.Timer():CancelEvent(self._questTimer)
      self._questTimer = nil
    end
    self:SwitchState(UIStateType.UIN21Controller)
  else
    local timeStr = HelperProxy:GetInstance():Time2Tex(sec)
    self.QuestTimerTex:RefreshText(timeStr)
  end
end

function UIN21Controller:RT()
  if self._rt then
    local rt = self:GetUIComponent("RawImage", "rt")
    rt.texture = self._rt
  end
end

function UIN21Controller:InitTimer()
  if self._endType == 0 then
    return
  end
  if self._timerEvent then
    GameGlobal.Timer():CancelEvent(self._timerEvent)
    self._timerEvent = nil
  end
  self._timerEvent = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:SetTimerTex()
  end)
  self:SetTimerTex()
end

function UIN21Controller:SetTimerTex()
  local svrTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local sec = self._endTime - svrTime
  if sec < 0 then
    if self._timerEvent then
      GameGlobal.Timer():CancelEvent(self._timerEvent)
      self._timerEvent = nil
    end
  else
    local timeStr = HelperProxy:GetInstance():Time2Tex(sec)
    local titleStr = ""
    if self._endType == 1 then
      titleStr = "str_n21_title_timer_line"
    elseif self._endType == 2 then
      titleStr = "str_n21_title_timer_game"
    elseif self._endType == 3 then
      titleStr = "str_n21_title_timer_title"
    end
    self.timeStr:RefreshText(StringTable.Get(titleStr, timeStr))
  end
end

function UIN21Controller:HideBtnOnClick()
  self.ShowBtn:SetActive(true)
  self.Full.blocksRaycasts = false
  self:Lock("UIN21ControllerAnim")
  if self.uiAnim then
    self.uiAnim:Play("uieffanim_N21Main_out")
  end
  if self.animEvent then
    GameGlobal.Timer():CancelEvent(self.animEvent)
  end
  self.animEvent = GameGlobal.Timer():AddEvent(500, function()
    self:UnLock("UIN21ControllerAnim")
  end)
end

function UIN21Controller:N19P5SignInRed()
  local redSignIn = self:_CheckRedPoint(self.SignInRed, ECampaignN21ComponentID.ECAMPAIGN_N21_CUMULATIVE_LOGIN)
  self.SignInRed:SetActive(redSignIn)
end

function UIN21Controller:Red()
  local redEvent = UIActivityHelper.CheckCampaignSampleRedPoint(self._battlepassCampaign)
  self.EventRed:SetActive(redEvent)
  local redSignIn = self:_CheckRedPoint(self.SignInRed, ECampaignN21ComponentID.ECAMPAIGN_N21_CUMULATIVE_LOGIN)
  self.SignInRed:SetActive(redSignIn)
  local redPool = self:_CheckRedPoint(self.PoolRed, ECampaignN21ComponentID.ECAMPAIGN_N21_LOTTERY)
  self.PoolRed:SetActive(redPool)
  local redLine = self:_CheckRedPoint(self.LineMissionRed, ECampaignN21ComponentID.ECAMPAIGN_N21_LEVEL_COMMON)
  local redTry = self:_CheckRedPoint(self.LineMissionRed, ECampaignN21ComponentID.ECAMPAIGN_N21_LEVEL_FIXTEAM)
  self.LineMissionRed:SetActive(redLine or redTry)
  local newGame = self._campaign:GetLocalProcess():WeiSiExploreReddot()
  local component = self._campaign:GetComponent(ECampaignN21ComponentID.ECAMPAIGN_N21_MINI_GAME)
  local cfgId = component and component:GetComponentCfgId()
  local cfg = Cfg.cfg_component_minigame_explore_limit({ComponentID = cfgId})
  local c1, c2 = HomelandFindTreasureConst.GetSingleCount(cfg and cfg[1])
  local redGame = 0 < c2
  self.GameNew:SetActive(newGame and self.gameLock == N21ComponetStatus.Open)
  self.GameRed:SetActive(redGame and not newGame and self.gameLock == N21ComponetStatus.Open)
  local redQuest = self:_CheckRedPoint(self.QuestRed, ECampaignN21ComponentID.ECAMPAIGN_N21_PANGOLIN)
  self.QuestRed:SetActive(redQuest)
end

function UIN21Controller:_CheckNewsignal()
  local localProcess = self._campaign:GetLocalProcess()
  if localProcess:HaveNewHighEquip() then
    self:ShowDialog("UIN17MainTipsController")
    localProcess:OnEnterMiniGame()
  end
end

function UIN21Controller:_CheckRedPoint(obj, ...)
  local bShow = self._campaign:CheckComponentRed(...)
  return bShow
end

function UIN21Controller:IntrBtnOnClick(go)
  self:ShowDialog("UIN21IntrController", "UIN21Controller")
end

function UIN21Controller:StoryBtnOnClick(go)
  local canReviewStages = {}
  local cfgs = Cfg.cfg_n21_story_review({})
  if cfgs then
    for i = 1, #cfgs do
      local cfg = cfgs[i]
      local curStage = DiscoveryStage:New()
      curStage.id = cfg.ID
      curStage.longDesc = StringTable.Get(cfg.Des)
      curStage.name = StringTable.Get(cfg.Name)
      curStage.stageIdx = StringTable.Get(cfg.StageIndexTitle)
      curStage.fullname = StringTable.Get(cfg.FullName)
      local storyList = DiscoveryStoryList:New()
      local slist = {}
      storyList.stageId = cfg.ID
      local storyListCfg = cfg.StoryList
      for i = 1, #storyListCfg do
        local story = DiscoveryStory:New()
        story:Init(storyListCfg[i][1], storyListCfg[i][2])
        table.insert(slist, story)
      end
      storyList.list = slist
      curStage.story = storyList
      table.insert(canReviewStages, curStage)
    end
  end
  local tempStage = canReviewStages[1]
  self:ShowDialog("UIPlot", tempStage, canReviewStages, false, true, StringTable.Get("str_n20_sub_title"))
end

function UIN21Controller:SignInBtnOnClick(go)
  self:ShowDialog("UIActivityTotalLoginAwardController", false, ECampaignType.CAMPAIGN_TYPE_N21, ECampaignN21ComponentID.ECAMPAIGN_N21_CUMULATIVE_LOGIN)
end

function UIN21Controller:EventBtnOnClick(go)
  UIActivityBattlePassHelper.OpenMainController()(self._battlepassCampaign)
end

function UIN21Controller:PoolBtnOnClick(go)
  if self.poolLock == N21ComponetStatus.NotStart then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
  elseif self.poolLock == N21ComponetStatus.OverTime then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
  elseif self.poolLock == N21ComponetStatus.Lock then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
  elseif self.poolLock == N21ComponetStatus.Other then
    Log.fatal("###[UIN21Controller] PoolBtnOnClick lock --> other !")
  else
    self:SwitchState(UIStateType.UIN21ShopController)
  end
end

function UIN21Controller:PetTryBtnOnClick(go)
  self:ShowDialog("UIActivityPetTryController", ECampaignType.CAMPAIGN_TYPE_N21, ECampaignN21ComponentID.ECAMPAIGN_N21_LEVEL_FIXTEAM, function(mid)
    local component = self._campaign:GetComponent(ECampaignN21ComponentID.ECAMPAIGN_N21_LEVEL_FIXTEAM)
    return component:IsPassCamMissionID(mid)
  end, function(missionid)
    local ctx = self._missionModule:TeamCtx()
    local missionComponent = self._campaign:GetComponent(ECampaignN21ComponentID.ECAMPAIGN_N21_LEVEL_FIXTEAM)
    local param = {
      missionid,
      missionComponent:GetCampaignMissionComponentId(),
      missionComponent:GetCampaignMissionParamKeyMap()
    }
    ctx:Init(TeamOpenerType.Campaign, param)
    ctx:ShowDialogUITeams(false)
  end)
end

function UIN21Controller:StartStoryBtnOnClick(go)
  local cfg = Cfg.cfg_campaign[self._campaign._id]
  if cfg then
    local storyIDs = cfg.FirstEnterStoryID
    if storyIDs then
      local id = storyIDs[1]
      if id then
        self:ShowDialog("UIStoryController", id)
      end
    end
  end
end

function UIN21Controller:ShowBtnOnClick(go)
  self.ShowBtn:SetActive(false)
  self.Full.blocksRaycasts = true
  self:Lock("UIN21ControllerAnim")
  if self.uiAnim then
    self.uiAnim:Play("uieffanim_N21Main_in")
  end
  if self.animEvent then
    GameGlobal.Timer():CancelEvent(self.animEvent)
  end
  self.animEvent = GameGlobal.Timer():AddEvent(500, function()
    self:UnLock("UIN21ControllerAnim")
  end)
end

function UIN21Controller:LineMissionBtnOnClick(go)
  if self.lineLock == N21ComponetStatus.NotStart then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
  elseif self.lineLock == N21ComponetStatus.OverTime then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
  elseif self.lineLock == N21ComponetStatus.Lock then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
  elseif self.lineLock == N21ComponetStatus.Other then
    Log.fatal("###[UIN21Controller] LineMissionBtnOnClick lock --> other !")
  else
    self:SwitchState(UIStateType.UIN21LineMissionController)
  end
end

function UIN21Controller:QuestBtnOnClick(go)
  if self.questLock == N21ComponetStatus.NotStart then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
  elseif self.questLock == N21ComponetStatus.OverTime then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
  elseif self.questLock == N21ComponetStatus.Lock then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
  elseif self.questLock == N21ComponetStatus.Other then
    Log.fatal("###[UIN21Controller] QuestBtnOnClick lock --> other !")
  else
    self:ShowDialog("UIHomelandStoryTaskSimpleController", 1, ECampaignType.CAMPAIGN_TYPE_N21, ECampaignN21ComponentID.ECAMPAIGN_N21_PANGOLIN)
  end
end

function UIN21Controller:GameBtnOnClick(go)
  if not self._campaign:CheckCampaignOpen() then
    self._campaign:CheckErrorCode(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED)
  end
  if self.gameLock == N21ComponetStatus.NotStart then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
  elseif self.gameLock == N21ComponetStatus.OverTime then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
  elseif self.gameLock == N21ComponetStatus.Lock then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
  elseif self.gameLock == N21ComponetStatus.Other then
    Log.fatal("###[UIN21Controller] GameBtnOnClick game lock --> other !")
  else
    UIActivityHelper.PlayFirstPlot_Component(self._campaign, ECampaignN21ComponentID.ECAMPAIGN_N21_MINI_GAME, function()
      GameGlobal.UIStateManager():ShowDialog("UIFindTreasureDetail", true, ECampaignType.CAMPAIGN_TYPE_N21, ECampaignN21ComponentID.ECAMPAIGN_N21_MINI_GAME)
    end)
  end
end

function UIN21Controller:CheckComponentLock(componentid)
  local component = self._campaign:GetComponent(componentid)
  if not component then
    Log.error("###[UIN21Controller] UIN21Controller:CheckComponentLock component == nil,componentid=", componentid)
    return N21ComponetStatus.Other
  end
  local curTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local unlockTime = component:ComponentUnLockTime()
  local stamp = unlockTime - curTime
  if component:ComponentIsClose() then
    return N21ComponetStatus.OverTime
  elseif 0 < stamp then
    return N21ComponetStatus.NotStart, unlockTime
  elseif not component:ComponentIsUnLock() then
    return N21ComponetStatus.Lock
  else
    local cInfo = self._campaign:GetComponentInfo(componentid)
    local closeTime = cInfo.m_close_time
    return N21ComponetStatus.Open, closeTime
  end
end

function UIN21Controller:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN21Controller)
end
