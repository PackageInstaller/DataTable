_class("UIN27Controller", UIController)
UIN27Controller = UIN27Controller

function UIN27Controller:LoadDataOnEnter(TT, res, uiParams)
  self._loginModule = self:GetModule(LoginModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._missionModule = self:GetModule(MissionModule)
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N27, ECampaignN27ComponentID.ECAMPAIGN_N27_CUMULATIVE_LOGIN, ECampaignN27ComponentID.ECAMPAIGN_N27_FIRST_MEET, ECampaignN27ComponentID.ECAMPAIGN_N27_POWER2ITEM, ECampaignN27ComponentID.ECAMPAIGN_N27_LINE_MISSION, ECampaignN27ComponentID.ECAMPAIGN_N27_DIFFICULT_MISSION, ECampaignN27ComponentID.ECAMPAIGN_N27_BLACK_DIFFICULT_MISSION, ECampaignN27ComponentID.ECAMPAIGN_N27_LOTTERY, ECampaignN27ComponentID.ECAMPAIGN_N27_POSTSTATON)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self.N27MinigameHelper = N27MinigameHelper:New()
  self.N27MinigameHelper:LoadData(TT, res)
  self._lotteryComponentInfo = self._campaign:GetComponentInfo(ECampaignN27ComponentID.ECAMPAIGN_N27_LOTTERY)
  self._costItemID = self._lotteryComponentInfo.m_cost_item_id
  self._localProcess = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N27)
  if res and not res:GetSucc() then
    CutsceneManager.ExcuteCutsceneOut_Shot()
    self._campaign:CheckErrorCode(res.m_result, function()
    end, function()
      self:SwitchState(UIStateType.UIMain)
    end)
  end
  self:LoadDataOnEnter_BattlePass(TT)
end

function UIN27Controller:LoadDataOnEnter_BattlePass(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._battlepassCampaign = UIActivityCampaign:New()
  self._battlepassCampaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
end

function UIN27Controller:OnShow(uiParams)
  CutsceneManager.ExcuteCutsceneOut_Shot()
  self._endType = 0
  self.componentNotStartTimerMap = {}
  self._rt = uiParams[1]
  self:GetComponents()
  self:AddListener()
  self:OnValue()
  self:_CheckGuide()
end

function UIN27Controller:AddListener()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.SummerTwoLoginRed, self.N27SignInRed)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self.OnComponentStepChange)
  self:AttachEvent(GameEventType.QuestUpdate, self.OnComponentStepChange)
  self:AttachEvent(GameEventType.ItemCountChanged, self.ItemCount)
end

function UIN27Controller:OnComponentStepChange()
  local redEvent = UIActivityHelper.CheckCampaignSampleRedPoint(self._battlepassCampaign)
  self.EventRed:SetActive(redEvent)
end

function UIN27Controller:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN27Controller:GetComponents()
  self.timeStr = self:GetUIComponent("UILocalizationText", "timeStr")
  self.timeStr2 = self:GetUIComponent("UILocalizationText", "timeStr2")
  self.itemIcon = self:GetUIComponent("RawImageLoader", "itemIcon")
  self.backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self.SignInRed = self:GetGameObject("SignInRed")
  self.EventRed = self:GetGameObject("EventRed")
  self.PoolRed = self:GetGameObject("PoolRed")
  self.ShowBtn = self:GetGameObject("ShowBtn")
  self.uiAnim = self:GetUIComponent("Animation", "uiAnim")
  self.itemCount2 = self:GetUIComponent("UILocalizationText", "itemCount2")
  self.itemCount = self:GetUIComponent("UILocalizationText", "itemCount")
  self.LineMissionRed = self:GetGameObject("LineMissionRed")
  self.LineMissionNew = self:GetGameObject("LineMissionNew")
  self.GameRed = self:GetGameObject("GameRed")
  self.GameNew = self:GetGameObject("GameNew")
  self.DiffNew = self:GetGameObject("DiffNew")
  self.DiffRed = self:GetGameObject("DiffRed")
  self.GameLockGo = self:GetGameObject("gameLock")
  self.DiffLockGo = self:GetGameObject("diffLock")
  self.PoolLockGo = self:GetGameObject("poolLock")
  self.MissionLockGo = self:GetGameObject("missionLock")
  self.GameGrayGo = self:GetGameObject("gameGray")
  self.DiffGrayGo = self:GetGameObject("diffGray")
  self.PoolGrayGo = self:GetGameObject("poolGray")
  self.MissionGrayGo = self:GetGameObject("missionGray")
  self.LineMissionTimerGo = self:GetGameObject("LineMissionTimerGo")
  self.LineMissionTimerTex = self:GetUIComponent("UILocalizationText", "LineMissionTimerTex")
  self.DiffTimerTex = self:GetUIComponent("UILocalizationText", "DiffTimerTex")
  self.DiffTimerTexGo = self:GetGameObject("DiffTimerTexGo")
  self.GameTimerTex = self:GetUIComponent("UILocalizationText", "GameTimerTex")
  self.GameTimerTexGo = self:GetGameObject("GameTimerTexGo")
  self.GameTimerTex2 = self:GetUIComponent("UILocalizationText", "GameTimerTex2")
  self.DiffTimerTex2 = self:GetUIComponent("UILocalizationText", "DiffTimerTex2")
  self.LineMissionTimerTex2 = self:GetUIComponent("UILocalizationText", "LineMissionTimerTex2")
  self.PoolTimerTex2 = self:GetUIComponent("UILocalizationText", "PoolTimerTex2")
  self.PoolTimerTex = self:GetUIComponent("UILocalizationText", "PoolTimerTex")
  self.PoolItemGo = self:GetGameObject("item")
  self.PoolLockTexGo = self:GetGameObject("lockTex")
  self.uiAnim2 = self:GetUIComponent("Animation", "uiAnim2")
end

function UIN27Controller.GetItemCountStr(count, preColor, countColor)
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

function UIN27Controller:ItemCount()
  local itemModule = GameGlobal.GetModule(ItemModule)
  local count = itemModule:GetItemCount(self._costItemID)
  self.itemCount:SetText(UIN27Controller.GetItemCountStr(count, "#bcd4f3", "#ffffff"))
  self.itemCount2:SetText(UIN27Controller.GetItemCountStr(count, "#193352", "#193352"))
  local cfg = Cfg.cfg_item[self._costItemID]
  if not cfg then
    Log.error("###[UIN27Controller] cfg is nil ! id --> ", self._costItemID)
  end
  self.itemIcon:LoadImage(cfg.Icon)
end

function UIN27Controller:OnHide()
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
  if self._lineMissionTimer then
    GameGlobal.Timer():CancelEvent(self._lineMissionTimer)
    self._lineMissionTimer = nil
  end
  if self._diffTimer then
    GameGlobal.Timer():CancelEvent(self._diffTimer)
    self._diffTimer = nil
  end
  if self.componentNotStartTimerMap then
    for id, timer in pairs(self.componentNotStartTimerMap) do
      GameGlobal.Timer():CancelEvent(timer)
    end
    self.componentNotStartTimerMap = nil
  end
end

function UIN27Controller:OnValue()
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
end

function UIN27Controller:CheckBtnLock()
  self:LineLock()
  self:PoolLock()
  self:DiffLock()
  self:GameLock()
  self:CampaignLock()
end

function UIN27Controller:CampaignLock()
  local lineLock, lineEndTime = self:CheckComponentLock(ECampaignN27ComponentID.ECAMPAIGN_N27_LINE_MISSION)
  if lineLock == N27ComponetStatus.Open then
    Log.debug("###[UIN27Controller] 线性关 开启中")
    self._endTime = lineEndTime
    self._endType = 1
  else
    Log.debug("###[UIN27Controller] 线性关 关闭了")
    local sample = self._campaign:GetSample()
    self._endTime = sample.end_time
    self._endType = 3
  end
  self:InitTimer()
end

function UIN27Controller:LineLock()
  local status, endTime = self:CheckComponentLock(ECampaignN27ComponentID.ECAMPAIGN_N27_LINE_MISSION)
  self.lineLock = status
  self.MissionLockGo:SetActive(self.lineLock == N27ComponetStatus.NotStart or self.lineLock == N27ComponetStatus.Lock)
  self.MissionGrayGo:SetActive(self.lineLock ~= N27ComponetStatus.Open)
  if self.lineLock == N27ComponetStatus.Open then
    self.lineMissionEndTime = endTime
    self:InitLineMissionTimer()
  elseif self.lineLock == N27ComponetStatus.OverTime then
    local tex = "str_n27_activity_end"
    self.LineMissionTimerTex:SetText(StringTable.Get(tex))
    self.LineMissionTimerTex2:SetText(StringTable.Get(tex))
  else
    Log.fatal("###[UIN27Controller] line lock other ! self.lineLock:", self.lineLock)
  end
end

function UIN27Controller:InitLineMissionTimer()
  Log.debug("###[UIN27Controller] InitLineMissionTimer")
  if self._lineMissionTimer then
    GameGlobal.Timer():CancelEvent(self._lineMissionTimer)
  end
  self._lineMissionTimer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:SetLineMissionTimerTex()
  end)
  self:SetLineMissionTimerTex()
end

function UIN27Controller:SetLineMissionTimerTex()
  local svrTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local sec = self.lineMissionEndTime - svrTime
  if sec < 0 then
    if self._gameTimer then
      GameGlobal.Timer():CancelEvent(self._gameTimer)
      self._gameTimer = nil
    end
    Log.debug("###[UIN27Controller] SetLineMissionTimerTex time over,refresh dialog !")
    self:SwitchState(UIStateType.UIN27Controller)
  else
    local timeStr = HelperProxy:GetInstance():Time2Tex(sec)
    local tex = "str_n27_main_component_less_time"
    self.LineMissionTimerTex:SetText(StringTable.Get(tex, timeStr))
    self.LineMissionTimerTex2:SetText(StringTable.Get(tex, timeStr))
  end
end

function UIN27Controller:PoolLock()
  self.poolLock = self:CheckComponentLock(ECampaignN27ComponentID.ECAMPAIGN_N27_LOTTERY)
  self.PoolLockGo:SetActive(self.poolLock == N27ComponetStatus.NotStart or self.poolLock == N27ComponetStatus.Lock)
  self.PoolGrayGo:SetActive(self.poolLock ~= N27ComponetStatus.Open)
  self.PoolItemGo:SetActive(self.poolLock == N27ComponetStatus.Open)
  self.PoolLockTexGo:SetActive(self.poolLock ~= N27ComponetStatus.Open)
  if self.poolLock == N27ComponetStatus.OverTime then
    local tex = "str_n27_activity_end"
    self.PoolTimerTex:SetText(StringTable.Get(tex))
    self.PoolTimerTex2:SetText(StringTable.Get(tex))
  end
end

function UIN27Controller:GameLock()
  local status, param = self:CheckComponentLock(ECampaignN27ComponentID.ECAMPAIGN_N27_POSTSTATON)
  self.GameLockGo:SetActive(status == N27ComponetStatus.NotStart or status == N27ComponetStatus.Lock)
  self.GameGrayGo:SetActive(status ~= N27ComponetStatus.Open)
  self.gameLock = status
  if status == N27ComponetStatus.Open then
    self._gameEndTime = param or 0
    self:InitGameTimer()
  else
    local tex = ""
    if status == N27ComponetStatus.NotStart then
      local unlockTime = param
      local svrTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
      local sec = unlockTime - svrTime
      local timeStr = HelperProxy:GetInstance():Time2Tex(sec)
      tex = StringTable.Get("str_n27_main_component_lock_time", timeStr)
      self:InitComponentNotStartTimer(ECampaignN27ComponentID.ECAMPAIGN_N27_POSTSTATON, sec)
    elseif status == N27ComponetStatus.Lock then
      local missionid = param
      local missionCfg = Cfg.cfg_campaign_mission[missionid]
      local missionName = StringTable.Get(missionCfg.Name)
      tex = StringTable.Get("str_n27_main_component_lock_stage", missionName)
    elseif status == N27ComponetStatus.OverTime then
      tex = "str_n27_activity_end"
    else
      Log.fatal("###[UIN27Controller] game lock other ! self.lineLock:", self.lineLock)
    end
    self.GameTimerTex:SetText(tex)
    self.GameTimerTex2:SetText(tex)
  end
end

function UIN27Controller:InitComponentNotStartTimer(comid, sec)
  Log.debug("###[UIN27Controller] InitComponentNotStartTimer comid:", comid, "|sec:", sec)
  if self.componentNotStartTimerMap[comid] then
    local tmpTimer = self.componentNotStartTimerMap[comid]
    GameGlobal.Timer():CancelEvent(tmpTimer)
  end
  local timer = GameGlobal.Timer():AddEvent((sec + 1) * 1000, function()
    Log.debug("###[UIN27Controller] InitComponentNotStartTimer refresh dialog !")
    self:SwitchState(UIStateType.UIN27Controller)
  end)
  self.componentNotStartTimerMap[comid] = timer
end

function UIN27Controller:InitGameTimer()
  Log.debug("###[UIN27Controller] InitGameTimer")
  if self._gameTimer then
    GameGlobal.Timer():CancelEvent(self._gameTimer)
  end
  self._gameTimer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:SetGameTimerTex()
  end)
  self:SetGameTimerTex()
end

function UIN27Controller:SetGameTimerTex()
  local svrTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local sec = self._gameEndTime - svrTime
  if sec < 0 then
    if self._gameTimer then
      GameGlobal.Timer():CancelEvent(self._gameTimer)
      self._gameTimer = nil
    end
    Log.debug("###[UIN27Controller] SetGameTimerTex time over,refresh dialog !")
    self:SwitchState(UIStateType.UIN27Controller)
  else
    local timeStr = HelperProxy:GetInstance():Time2Tex(sec)
    local tex = "str_n27_main_component_less_time"
    self.GameTimerTex:SetText(StringTable.Get(tex, timeStr))
    self.GameTimerTex2:SetText(StringTable.Get(tex, timeStr))
  end
end

function UIN27Controller:DiffLock()
  local status, param = self:CheckComponentLock(ECampaignN27ComponentID.ECAMPAIGN_N27_DIFFICULT_MISSION)
  self.diffLock = status
  self.DiffLockGo:SetActive(status == N27ComponetStatus.NotStart or status == N27ComponetStatus.Lock)
  self.DiffGrayGo:SetActive(status ~= N27ComponetStatus.Open)
  if status == N27ComponetStatus.Open then
    self._diffEndTime = param or 0
    self:InitDiffTimer()
  else
    local tex
    if status == N27ComponetStatus.NotStart then
      local unlockTime = param
      local svrTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
      local sec = unlockTime - svrTime
      local timeStr = HelperProxy:GetInstance():Time2Tex(sec)
      tex = StringTable.Get("str_n27_main_component_lock_time", timeStr)
      self:InitComponentNotStartTimer(ECampaignN27ComponentID.ECAMPAIGN_N27_DIFFICULT_MISSION, sec)
    elseif status == N27ComponetStatus.Lock then
      local missionid = param
      local missionCfg = Cfg.cfg_campaign_mission[missionid]
      local missionName = StringTable.Get(missionCfg.Name)
      tex = StringTable.Get("str_n27_main_component_lock_stage", missionName)
    elseif status == N27ComponetStatus.OverTime then
      tex = StringTable.Get("str_n27_activity_end")
    else
      Log.fatal("###[UIN27Controller] diff lock other ! status:", status)
    end
    self.DiffTimerTex:SetText(tex)
    self.DiffTimerTex2:SetText(tex)
  end
end

function UIN27Controller:InitDiffTimer()
  Log.debug("###[UIN27Controller] InitDiffTimer")
  if self._diffTimer then
    GameGlobal.Timer():CancelEvent(self._diffTimer)
  end
  self._diffTimer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:SetDiffTimerTex()
  end)
  self:SetDiffTimerTex()
end

function UIN27Controller:SetDiffTimerTex()
  local svrTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local sec = self._diffEndTime - svrTime
  if sec < 0 then
    if self._diffTimer then
      GameGlobal.Timer():CancelEvent(self._diffTimer)
      self._diffTimer = nil
    end
    Log.debug("###[UIN27Controller] SetDiffTimerTex time over,refresh dialog !")
    self:SwitchState(UIStateType.UIN27Controller)
  else
    local timeStr = HelperProxy:GetInstance():Time2Tex(sec)
    local tex = "str_n27_main_component_less_time"
    self.DiffTimerTex:SetText(StringTable.Get(tex, timeStr))
    self.DiffTimerTex2:SetText(StringTable.Get(tex, timeStr))
  end
end

function UIN27Controller:RT()
  if self._rt then
    local rt = self:GetUIComponent("RawImage", "rt")
    rt.texture = self._rt
  end
end

function UIN27Controller:InitTimer()
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

function UIN27Controller:SetTimerTex()
  local svrTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local sec = self._endTime - svrTime
  if sec < 0 then
    if self._timerEvent then
      GameGlobal.Timer():CancelEvent(self._timerEvent)
      self._timerEvent = nil
    end
    if self._endType == 1 then
      Log.debug("###[UIN27Controller] 线性关时间到了，重新计算，显示活动结束时间")
    end
  else
    local timeStr = HelperProxy:GetInstance():Time2Tex(sec)
    local titleStr = ""
    if self._endType == 1 then
      titleStr = "str_n27_level_remain_time_tips"
    elseif self._endType == 3 then
      titleStr = "str_n27_main_exchange_time"
    else
      return
    end
    self.timeStr:SetText(StringTable.Get(titleStr, timeStr))
    self.timeStr2:SetText(StringTable.Get(titleStr, timeStr))
  end
end

function UIN27Controller:HideBtnOnClick()
  self.ShowBtn:SetActive(true)
  self:Lock("UIN27ControllerAnim")
  if self.uiAnim2 then
    self.uiAnim2:Play("uieff_UIN27Controller_uiout")
  end
  if self.animEvent then
    GameGlobal.Timer():CancelEvent(self.animEvent)
  end
  self.animEvent = GameGlobal.Timer():AddEvent(333, function()
    self:UnLock("UIN27ControllerAnim")
  end)
end

function UIN27Controller:N27SignInRed()
  local redSignIn = self:_CheckRedPoint(self.SignInRed, ECampaignN27ComponentID.ECAMPAIGN_N27_CUMULATIVE_LOGIN)
  self.SignInRed:SetActive(redSignIn)
end

function UIN27Controller:Red()
  local redEvent = UIActivityHelper.CheckCampaignSampleRedPoint(self._battlepassCampaign)
  self.EventRed:SetActive(redEvent)
  local redSignIn = self:_CheckRedPoint(self.SignInRed, ECampaignN27ComponentID.ECAMPAIGN_N27_CUMULATIVE_LOGIN)
  self.SignInRed:SetActive(redSignIn)
  local redPool = self:_CheckRedPoint(self.PoolRed, ECampaignN27ComponentID.ECAMPAIGN_N27_LOTTERY)
  self.PoolRed:SetActive(redPool)
  local newLineMission = self:GetLineMissionNew()
  local redLine = self:_CheckRedPoint(self.LineMissionRed, ECampaignN27ComponentID.ECAMPAIGN_N27_LINE_MISSION)
  local redTry = self:_CheckRedPoint(self.LineMissionRed, ECampaignN27ComponentID.ECAMPAIGN_N27_FIRST_MEET)
  local redLineMission = redLine or redTry
  self.LineMissionNew:SetActive(newLineMission and self.lineLock == N27ComponetStatus.Open)
  self.LineMissionRed:SetActive(redLineMission and not newLineMission and self.lineLock == N27ComponetStatus.Open)
  local newDiff = self:GetDiffNew()
  local redDiff = false
  self.DiffNew:SetActive(newDiff and self.diffLock == N27ComponetStatus.Open)
  self.DiffRed:SetActive(redDiff and not newDiff and self.diffLock == N27ComponetStatus.Open)
  local newGame, redGame = self:GetGameNew()
  self.GameNew:SetActive(newGame and self.gameLock == N27ComponetStatus.Open)
  self.GameRed:SetActive(redGame and not newGame and self.gameLock == N27ComponetStatus.Open)
end

function UIN27Controller:GetLineMissionNew()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local openID = roleModule:GetPstId()
  local key = "UIN27MAIN_LINEMISSIOIN_" .. openID
  local val = LocalDB.GetInt(key, 0)
  return val == 0
end

function UIN27Controller:SetLineMissionNew()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local openID = roleModule:GetPstId()
  local key = "UIN27MAIN_LINEMISSIOIN_" .. openID
  local val = LocalDB.SetInt(key, 1)
end

function UIN27Controller:GetDiffNew()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local openID = roleModule:GetPstId()
  local key = "UIN27MAIN_DIFF_" .. openID
  local val = LocalDB.GetInt(key, 0)
  return val == 0
end

function UIN27Controller:SetDiffNew()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local openID = roleModule:GetPstId()
  local key = "UIN27MAIN_DIFF_" .. openID
  local val = LocalDB.SetInt(key, 1)
end

function UIN27Controller:GetGameNew()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local openID = roleModule:GetPstId()
  local key = "UIN27MAIN_GAME_" .. openID
  local val = LocalDB.GetInt(key, 0)
  local mainNew = val == 0
  local new, red = self.N27MinigameHelper:IsShowEntryNewOrRed()
  return mainNew or new, red
end

function UIN27Controller:SetGameNew()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local openID = roleModule:GetPstId()
  local key = "UIN27MAIN_GAME_" .. openID
  local val = LocalDB.SetInt(key, 1)
end

function UIN27Controller:_CheckRedPoint(obj, ...)
  local bShow = self._campaign:CheckComponentRed(...)
  return bShow
end

function UIN27Controller:IntrBtnOnClick(go)
  self:ShowDialog("UIN27IntrController", "UIN27Controller")
end

function UIN27Controller:SignInBtnOnClick(go)
  self:ShowDialog("UIActivityTotalLoginAwardController", false, ECampaignType.CAMPAIGN_TYPE_N27, ECampaignN27ComponentID.ECAMPAIGN_N27_CUMULATIVE_LOGIN)
end

function UIN27Controller:EventBtnOnClick(go)
  UIActivityBattlePassHelper.OpenMainController()(self._battlepassCampaign)
end

function UIN27Controller:PoolBtnOnClick(go)
  if self.poolLock == N27ComponetStatus.NotStart then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
  elseif self.poolLock == N27ComponetStatus.OverTime then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_109"))
  elseif self.poolLock == N27ComponetStatus.Lock then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
  elseif self.poolLock == N27ComponetStatus.Other then
    Log.fatal("###[UIN27Controller] PoolBtnOnClick lock --> other !")
  else
    self:ShowDialog("UIN27LotteryMain")
  end
end

function UIN27Controller:ShowBtnOnClick(go)
  self.ShowBtn:SetActive(false)
  self:Lock("UIN27ControllerAnim")
  if self.uiAnim2 then
    self.uiAnim2:Play("uieff_UIN27Controller_uiback")
  end
  if self.animEvent then
    GameGlobal.Timer():CancelEvent(self.animEvent)
  end
  self.animEvent = GameGlobal.Timer():AddEvent(633, function()
    self:UnLock("UIN27ControllerAnim")
  end)
end

function UIN27Controller:LineMissionBtnOnClick(go)
  if self.lineLock == N27ComponetStatus.NotStart then
  elseif self.lineLock == N27ComponetStatus.OverTime then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_109"))
  elseif self.lineLock == N27ComponetStatus.Lock then
  elseif self.lineLock == N27ComponetStatus.Other then
    Log.fatal("###[UIN27Controller] LineMissionBtnOnClick lock --> other !")
  else
    CutsceneManager.ExcuteCutsceneIn_Shot()
    self:SwitchState(UIStateType.UIN27LineMissionController)
    self:SetLineMissionNew()
  end
end

function UIN27Controller:DiffBtnOnClick(go)
  if self.diffLock == N27ComponetStatus.NotStart then
  elseif self.diffLock == N27ComponetStatus.OverTime then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_109"))
  elseif self.diffLock == N27ComponetStatus.Lock then
  elseif self.diffLock == N27ComponetStatus.Other then
    Log.fatal("###[UIN27Controller] DiffBtnOnClick lock --> other !")
  else
    self:ShowDialog("UIActivityN27HardLevelMain")
    self:SetDiffNew()
  end
end

function UIN27Controller:GameBtnOnClick(go)
  if not self._campaign:CheckCampaignOpen() then
    self._campaign:CheckErrorCode(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED)
  end
  if self.gameLock == N27ComponetStatus.NotStart then
  elseif self.gameLock == N27ComponetStatus.OverTime then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_109"))
  elseif self.gameLock == N27ComponetStatus.Lock then
  elseif self.gameLock == N27ComponetStatus.Other then
    Log.fatal("###[UIN27Controller] GameBtnOnClick game lock --> other !")
  else
    UIActivityHelper.PlayFirstPlot_Component(self._campaign, ECampaignN27ComponentID.ECAMPAIGN_N27_POSTSTATON, function()
      CutsceneManager.ExcuteCutsceneIn_Shot()
      self:SwitchState(UIStateType.UIN27MiniGameController)
      self:SetGameNew()
    end)
  end
end

function UIN27Controller:CheckComponentLock(componentid)
  local component = self._campaign:GetComponent(componentid)
  if not component then
    Log.error("###[UIN27Controller] UIN27Controller:CheckComponentLock component == nil,componentid=", componentid)
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
    local missionid = component:GetComponentInfo().m_need_mission_id
    return N27ComponetStatus.Lock, missionid
  else
    local cInfo = self._campaign:GetComponentInfo(componentid)
    local closeTime = cInfo.m_close_time
    return N27ComponetStatus.Open, closeTime
  end
end

function UIN27Controller:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN27Controller)
end
