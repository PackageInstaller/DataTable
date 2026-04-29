require("ui_side_enter_center_content_base")
_class("UIActivityN0Cook", UISideEnterCenterContentBase)
UIActivityN0Cook = UIActivityN0Cook

function UIActivityN0Cook:Constructor()
end

function UIActivityN0Cook:DoInit()
  self._campaign = self._data
  self._localProcess = self._campaign:GetLocalProcess()
  self._cookComp = self._localProcess:GetComponent(ECCampaignInlandDinnerComponentID.ECAMPAIGN_INLAND_DINNER)
  self._cookCompInfo = self._localProcess:GetComponentInfo(ECCampaignInlandDinnerComponentID.ECAMPAIGN_INLAND_DINNER)
  self._cookData = UIN0CookData:New()
  self._cookData:InitWith(self._campaign, self._cookComp, self._cookCompInfo)
  self:_ForceRefresh()
end

function UIActivityN0Cook:_ForceRefresh()
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._campaign:ReLoadCampaignInfo_Force(TT, res)
    self:Refresh(false)
  end, self)
end

function UIActivityN0Cook:DoShow(uiParams)
  self:StartTask(function(TT)
    self._campaign:ClearCampaignNew(TT)
  end)
  self:InitWidget()
  self:Refresh(true)
  self:PlayEnterAni()
  self._eventMakeSucc = GameHelper:GetInstance():CreateCallback(self.OnMakeSucc, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.OnN0CookMakeSucc, self._eventMakeSucc)
  self:StartRefreshTimer()
  self:RefreshTime()
  local showFirstStory = self._cookData:CheckFirstPlayStory()
  self.requireBtn:SetActive(not showFirstStory)
  self.cookBtn:SetActive(not showFirstStory)
  self.reReadStoryBtn:SetActive(not showFirstStory)
  self.startBtn:SetActive(showFirstStory)
end

function UIActivityN0Cook:DoHide()
  if self._eventMakeSucc then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.OnN0CookMakeSucc, self._eventMakeSucc)
    self._eventMakeSucc = nil
  end
  self:CancelTimer()
  UIWidgetHelper.ClearWidgets(self, "itemInfo")
end

function UIActivityN0Cook:DoDestroy()
end

function UIActivityN0Cook:PlayEnterAni()
  self:StartTask(function(TT)
    local lockName = "UIActivityN0Cook:PlayEnterAni"
    self:Lock(lockName)
    local delay = 20
    for i, v in ipairs(self._items) do
      YIELD(TT, delay)
      v:SetVisible(true)
      v:PlayEnterAni()
      delay = delay + 20
    end
    self:UnLock(lockName)
  end)
end

function UIActivityN0Cook:OnMakeSucc()
  self:StartTask(function(TT)
    self:Refresh()
  end)
end

function UIActivityN0Cook:Refresh(hide)
  self:InitCollectList()
  self:RefreshCollectList(hide)
  self:RefreshRequireRed()
  local cookNew = UIN0CookData.CheckNew_CookBook(self._cookCompInfo)
  self.cookNew:SetActive(cookNew)
  self.cookRed:SetActive(not cookNew and UIN0CookData.CheckRed_CookBook(self._cookCompInfo))
  if self._cookData:IsCookedAll() then
    self.bg:LoadImage("n0_xyx_bg07")
    self.endStoryObj:SetActive(true)
    self.endStoryRed:SetActive(UIN0CookData.CheckRed_EndStory(self._cookCompInfo))
  else
    self.endStoryObj:SetActive(false)
  end
end

function UIActivityN0Cook:RefreshRequireRed()
  self.requireRed:SetActive(UIN0CookData.CheckRed_MatRequire(self._cookCompInfo))
end

function UIActivityN0Cook:InitCollectList()
  self._collectData = {}
  local componnetId = self._cookData:GetComponentId()
  local cfgs = Cfg.cfg_component_newyear_dinner_collect({ComponentID = componnetId})
  if not cfgs then
    Log.error("cfg_component_newyear_dinner_collect no data with ComponnetID = " .. componnetId)
    return
  end
  for i, v in ipairs(cfgs) do
    local collectId = v.CollectID
    local collectData = {}
    collectData.cfg = v
    collectData.status = self._cookData:GetCollectStatus(collectId)
    table.insert(self._collectData, collectData)
  end
  table.sort(self._collectData, function(a, b)
    local sA = a.status
    local sB = b.status
    if sA == sB then
      return a.cfg.CollectID < b.cfg.CollectID
    end
    if sA == NewYearDinner_Status.E_NewYearDinner_Status_CAN_RECV then
      return true
    end
    if sA == NewYearDinner_Status.E_NewYearDinner_Status_RECVED then
      return false
    end
    if sB == NewYearDinner_Status.E_NewYearDinner_Status_CAN_RECV then
      return false
    end
    return true
  end)
end

function UIActivityN0Cook:RefreshCollectList(hide)
  local count = 0
  local len = #self._collectData
  local items = self.list:SpawnObjects("UIN0CookMainCollectItem", len)
  self._items = items
  for i, v in ipairs(items) do
    local subCollectData = self._collectData[i]
    local cCount = subCollectData.cfg.Count
    if count < cCount then
      count = cCount
    end
    v:SetData(subCollectData, function(collectId)
      self:_RequestReceive(collectId)
    end, function(tplId, pos)
      self:OnItemClicked(tplId, pos)
    end)
    if hide then
      v:SetVisible(false)
    end
  end
  local collectCount = self._cookData:GetMakeFoodNum()
  self.collectNum:SetText("<color=#ffffff><size=35>" .. collectCount .. "</size></color>/" .. count)
end

function UIActivityN0Cook:_RequestReceive(collectId)
  if not self:CheckTime() then
    return
  end
  self:StartTask(function(TT)
    local lockName = "UIActivityN0Cook_RequestReceive"
    self:Lock(lockName)
    local res, rewards = self._cookData:RequestReceiveReward(TT, NewYearDinner_Reward_Type.E_NewYearDinner_Reward_Collect, collectId)
    if res and res:GetSucc() then
      self:ShowDialog("UIGetItemController", rewards)
      self:Refresh()
    end
    self:UnLock(lockName)
  end, self)
end

function UIActivityN0Cook:InitWidget()
  self.remaindTime = self:GetUIComponent("UILocalizationText", "remaindTime")
  self.collectNum = self:GetUIComponent("UILocalizationText", "collectNum")
  self.list = self:GetUIComponent("UISelectObjectPath", "list")
  self.requireRed = self:GetGameObject("requireRed")
  self.endStoryRed = self:GetGameObject("endStoryRed")
  self.cookRed = self:GetGameObject("cookRed")
  self.cookNew = self:GetGameObject("new")
  self.endStoryObj = self:GetGameObject("endStoryObj")
  self.requireBtn = self:GetGameObject("requireBtn")
  self.cookBtn = self:GetGameObject("cookBtn")
  self.startBtn = self:GetGameObject("startBtn")
  self.reReadStoryBtn = self:GetGameObject("reReadStoryBtn")
  self._itemInfo = self:GetUIComponent("UISelectObjectPath", "itemInfo")
  self._selectInfo = self._itemInfo:SpawnObject("UISelectInfo")
  self.bg = self:GetUIComponent("RawImageLoader", "bg")
  self.animation = self:GetUIComponent("Animation", "animation")
end

function UIActivityN0Cook:CloseCoro(TT)
  self:Lock("UIActivityN0Cook_CloseCoro")
  self.animation:Play("uieff_N0_CookMainController_out")
  YIELD(TT, 400)
  self:UnLock("UIActivityN0Cook_CloseCoro")
end

function UIActivityN0Cook:StartRefreshTimer()
  self:CancelTimer()
  self._timerHandler = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:RefreshTime()
  end)
end

function UIActivityN0Cook:CancelTimer()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UIActivityN0Cook:RefreshTime()
  if not self._cookCompInfo then
    return
  end
  local endTime = self._cookCompInfo.m_close_time
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local str = self:GetFormatTimerStr(endTime - curTime)
  local timeStr = StringTable.Get("str_n0_activity_remain_time", str)
  self.remaindTime:SetText(timeStr)
  if endTime < curTime and not self.lineEnd then
    self.lineEnd = true
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    local campain = self._cookData:GetCampaign()
  end
end

function UIActivityN0Cook:GetFormatTimerStr(time)
  local id = {
    day = "str_activity_common_day",
    hour = "str_activity_common_hour",
    min = "str_activity_common_minute",
    zero = "str_activity_common_less_minute",
    over = "str_activity_error_107"
  }
  local timeStr = StringTable.Get(id.over)
  if time < 0 then
    return timeStr
  end
  local day, hour, min, second = UIActivityHelper.Time2Str(time)
  if 0 < day then
    if 0 < hour then
      timeStr = "<color=#fabf4f>" .. day .. "</color>" .. StringTable.Get(id.day) .. "<color=#fabf4f>" .. hour .. "</color>" .. StringTable.Get(id.hour) .. "<color=#fabf4f>" .. min .. "</color>" .. StringTable.Get(id.min)
    else
      timeStr = "<color=#fabf4f>" .. day .. "</color>" .. StringTable.Get(id.day) .. "<color=#fabf4f>" .. min .. "</color>" .. StringTable.Get(id.min)
    end
  elseif 0 < hour then
    timeStr = "<color=#fabf4f>" .. hour .. "</color>" .. StringTable.Get(id.hour) .. "<color=#fabf4f>" .. min .. "</color>" .. StringTable.Get(id.min)
  elseif 0 < min then
    timeStr = "<color=#fabf4f>" .. min .. "</color>" .. StringTable.Get(id.min)
  else
    timeStr = "<color=#fabf4f>" .. StringTable.Get(id.zero) .. "</color>"
  end
  return timeStr
end

function UIActivityN0Cook:InfroBtnOnClick(go)
  if not self:CheckTime() then
    return
  end
  self:ShowDialog("UIIntroLoader", "UIN0CookIntro", MaskType.MT_BlurMask)
end

function UIActivityN0Cook:RequireBtnOnClick(go)
  if not self:CheckTime() then
    return
  end
  self:ShowDialog("UIN0CookMatRequireController", self._cookData, function()
    local cookNew = UIN0CookData.CheckNew_CookBook(self._cookCompInfo)
    self.cookNew:SetActive(cookNew)
    self.cookRed:SetActive(not cookNew and UIN0CookData.CheckRed_CookBook(self._cookCompInfo))
    self:RefreshRequireRed()
  end)
end

function UIActivityN0Cook:EndStroyBtnOnClick(go)
  if not self:CheckTime() then
    return
  end
  UIN0CookData.ClearRed_EndStory(self._cookCompInfo)
  self.endStoryRed:SetActive(false)
  local storyId = self._cookData:GetEndPlayStoryID()
  if not storyId then
    Log.error("UIActivityN0Cook can't find endStory")
    return
  end
  self:ShowDialog("UIStoryController", storyId)
end

function UIActivityN0Cook:CookBtnOnClick(go)
  if not self:CheckTime() then
    return
  end
  self:StartTask(function(TT)
    local lockName = "UIActivityN0Cook_CookBtnOnClick"
    self:Lock(lockName)
    self.animation:Play("uieff_N0_CookMainController_getinto")
    YIELD(TT, 300)
    self:ShowDialog("UIN0CookBookController", self._cookData, function()
      self:OnCookBookClose()
    end)
    UIN0CookData.ClearNew_CookBook(self._cookCompInfo)
    self:UnLock(lockName)
  end)
end

function UIActivityN0Cook:StartBtnOnClick(go)
  local firstStoryId = self._cookData:GetFirstPlayStoryID()
  if firstStoryId then
    self._cookData:SetFirstPlayStoryAsRead()
    self:ShowDialog("UIStoryController", firstStoryId, function()
      self.requireBtn:SetActive(true)
      self.cookBtn:SetActive(true)
      self.reReadStoryBtn:SetActive(true)
      self.startBtn:SetActive(false)
    end)
  end
end

function UIActivityN0Cook:ReReadStoryBtnOnClick(go)
  local firstStoryId = self._cookData:GetFirstPlayStoryID()
  if firstStoryId then
    self:ShowDialog("UIStoryController", firstStoryId)
  end
end

function UIActivityN0Cook:CheckTime()
  if self.lineEnd then
    local result = self._campaign:CheckComponentOpenClientError(ECCampaignInlandDinnerComponentID.ECAMPAIGN_INLAND_DINNER)
    self._campaign:CheckErrorCode(result)
    return false
  end
  return true
end

function UIActivityN0Cook:OnCookBookClose()
  self:StartTask(function(TT)
    local lockName = "UIActivityN0Cook_OnCookBookClose"
    self:Lock(lockName)
    local res = AsyncRequestRes:New()
    self:Refresh()
    YIELD(TT, 400)
    self.animation:Play("uieff_N0_CookMainController_return")
    YIELD(TT, 300)
    self:UnLock(lockName)
  end)
end

function UIActivityN0Cook:OnItemClicked(matid, pos)
  self._selectInfo:SetData(matid, pos)
end
