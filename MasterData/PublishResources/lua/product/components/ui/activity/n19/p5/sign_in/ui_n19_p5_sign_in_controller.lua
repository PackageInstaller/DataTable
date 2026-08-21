require("ui_n19_p5_sign_in_cls")
_class("UIN19P5SignInController", UIController)
UIN19P5SignInController = UIN19P5SignInController

function UIN19P5SignInController:LoadDataOnEnter(TT, res, uiParams)
  if uiParams[1] then
    self.isAutoPopShow = uiParams[1]
  else
    self.isAutoPopShow = false
  end
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self._uiModule = GameGlobal.GetModule(RoleModule).uiModule
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N19_P5, ECampaignN19P5ComponentID.CUMULATIVE_LOGIN)
  if not res:GetSucc() then
    if not self.isAutoPopShow then
      self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    end
    self:OnAutoPopOpenFail()
    return
  end
  if self.isAutoPopShow then
    self._campaign:ReLoadCampaignInfo_Force(TT, res)
    if not res:GetSucc() then
      if not self.isAutoPopShow then
        self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
      end
      self:OnAutoPopOpenFail()
      return
    end
  end
  self._component = self._campaign:GetComponent(ECampaignN19P5ComponentID.CUMULATIVE_LOGIN)
  self._componentInfo = self._campaign:GetComponentInfo(ECampaignN19P5ComponentID.CUMULATIVE_LOGIN)
  self._nextRefreshTime = 0
  if res:GetSucc() then
    local componentInfo = self._component:GetComponentInfo()
    local sampleInfo = self._campaign:GetSample()
    local sampleInfo = self._campaign:GetSample()
    if sampleInfo then
      self._nextRefreshTime = sampleInfo.m_extend_info_time[CampainExtendKey.E_CAMPAIGN_EXTEND_KEY_NEXT_REFRESH_TIME]
    end
    if self._component then
      local cmptInfo = self._component:GetComponentInfo()
      if cmptInfo then
        local openTime = cmptInfo.m_unlock_time
        local closeTime = cmptInfo.m_close_time
        local now = self._svrTimeModule:GetServerTime() * 0.001
        if openTime > now then
          if not self.isAutoPopShow then
            ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
          end
          res:SetSucc(false)
          self:OnAutoPopOpenFail()
          return
        elseif closeTime < now then
          if not self.isAutoPopShow then
            ToastManager.ShowToast(StringTable.Get("str_activity_error_107"))
          end
          res:SetSucc(false)
          self:OnAutoPopOpenFail()
          return
        end
      end
    end
  else
    if not self.isAutoPopShow then
      self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    end
    self:OnAutoPopOpenFail()
    return
  end
  self._cmptCloseTime = self._componentInfo.m_close_time or 0
  self:CreateDdata()
  self.currentIdx = self:GetCurrentIdx()
end

function UIN19P5SignInController:OnAutoPopOpenFail()
  if self.isAutoPopShow then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MainLobbyAutoOpenTryFail)
  end
end

function UIN19P5SignInController:CreateDdata()
  local info = self._componentInfo.m_cumulative_info
  self.data = {}
  for key, value in pairs(info) do
    local reward = value
    local awards = reward.m_rewards
    local day = reward.m_login_days
    local status = reward.m_reward_status
    local special = reward.m_is_special
    local data = {}
    data.awards = awards
    data.day = day
    data.status = status
    data.special = special
    table.insert(self.data, data)
  end
  table.sort(self.data, function(e1, e2)
    return e1.day < e2.day
  end)
end

function UIN19P5SignInController:OnHide()
  if self._refreshTaskID then
    GameGlobal.TaskManager():KillTask(self._refreshTaskID)
    self._refreshTaskID = nil
  end
  if self._event then
    GameGlobal.RealTimer():CancelEvent(self._event)
    self._event = nil
  end
  if self._nextRefreshEvent then
    GameGlobal.RealTimer():CancelEvent(self._nextRefreshEvent)
    self._nextRefreshEvent = nil
  end
  if self.contentTweener then
    self.contentTweener:Kill()
    self.contentTweener = nil
  end
end

function UIN19P5SignInController:OnShow()
  self:GetComponents()
  self:AddListener()
  self.tweenerTime = 0.3
  self.scrollDelta = 100
  self:InitList()
  self:MoveToIndex(self.currentIdx)
  self:CalcOffsetX()
  self:_OnValueRemainingTime()
  self:_OnValueNextRefreshRemainingTime()
  self:LastAwards()
end

function UIN19P5SignInController:N19P5SignInRefresh()
  self:CreateDdata()
  self.currentIdx = self:GetCurrentIdx()
  self:InitList()
  self:MoveToIndex(self.currentIdx)
  self:CalcOffsetX()
end

function UIN19P5SignInController:AddListener()
  self:AttachEvent(GameEventType.OnUIN19P5SignInGet, self.OnUIN19P5SignInGet)
end

function UIN19P5SignInController:OnUIN19P5SignInGet(day)
  self:Lock("UIActivityTotalLoginAwardController:GetTotalAward(id)")
  self:StartTask(self.OnGetTotalAward, self, day)
end

function UIN19P5SignInController:OnGetTotalAward(TT, day)
  local component = self._campaign:GetComponent(ECampaignN19P5ComponentID.CUMULATIVE_LOGIN)
  if component then
    local res = AsyncRequestRes:New()
    local awards = component:HandleReceiveCumulativeLoginReward(TT, res, day)
    self:UnLock("UIActivityTotalLoginAwardController:GetTotalAward(id)")
    if res == nil then
      return
    end
    if res:GetSucc() then
      if awards ~= nil and 0 < #awards then
        self:_ShowAwards(awards, day)
      end
      GameGlobal.EventDispatcher():Dispatch(GameEventType.N19P5SignInRed)
    else
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      campaignModule:CheckErrorCode(res:GetResult(), self._campaign._id, function()
        self:_ForceRefresh()
      end, function()
        self:CloseDialog()
      end)
    end
  end
end

function UIN19P5SignInController:_ShowAwards(awards, day)
  local petModule = GameGlobal.GetModule(PetModule)
  local tempPets = {}
  if 0 < #awards then
    for i = 1, #awards do
      local ispet = petModule:IsPetID(awards[i].assetid)
      if ispet then
        table.insert(tempPets, awards[i])
      end
    end
  end
  
  local function cbFunc()
    self:N19P5SignInRefresh()
  end
  
  if 0 < #tempPets then
    self:ShowDialog("UIPetObtain", tempPets, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
      self:ShowDialog("UIGetItemController", awards, cbFunc)
    end)
  else
    self:ShowDialog("UIGetItemController", awards, cbFunc)
  end
end

function UIN19P5SignInController:LastAwards()
  local lastAwards = self.data[#self.data].awards
  self.lastAwardsPool:SpawnObjects("UIN19P5SignInAward", #lastAwards)
  local pool = self.lastAwardsPool:GetAllSpawnList()
  for i = 1, #pool do
    local item = pool[i]
    local award = lastAwards[i]
    item:Flush(i, award, function(id, go)
      local awardInfo = AwardInfo:New()
      awardInfo.m_item_id = id
      self:ShowDialog("UIN19P5Tip", awardInfo, true)
    end)
  end
end

function UIN19P5SignInController:_IsAllRewardUnlocked()
  for index, value in ipairs(self.data) do
    local unlock = value.status == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV or value.status == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_RECVED
    if not unlock then
      return false
    end
  end
  return true
end

function UIN19P5SignInController:_OnValueNextRefreshRemainingTime()
  local isAllUnlocked = self:_IsAllRewardUnlocked()
  local isNotEnoughTime = false
  if not isAllUnlocked then
    local stopTime = self._cmptCloseTime
    local nowTime = math.floor(self._svrTimeModule:GetServerTime() / 1000)
    local remainingTime = stopTime - nowTime
    local nextTime = self._nextRefreshTime
    if nextTime and stopTime > nextTime then
    else
      isNotEnoughTime = true
    end
  end
  if isAllUnlocked or isNotEnoughTime then
    if self._nextRefreshEvent then
      GameGlobal.RealTimer():CancelEvent(self._nextRefreshEvent)
      self._nextRefreshEvent = nil
    end
    self._nextTimeAreaGo:SetActive(false)
    return
  end
  self:_ShowNextRefreshRemainingTime()
  if self._nextRefreshEvent then
    GameGlobal.RealTimer():CancelEvent(self._nextRefreshEvent)
    self._nextRefreshEvent = nil
  end
  self._nextRefreshEvent = GameGlobal.RealTimer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:_ShowNextRefreshRemainingTime()
  end)
end

function UIN19P5SignInController:_ShowNextRefreshRemainingTime()
  if not self._nextRefreshTime then
    self._nextTimeAreaGo:SetActive(false)
    return
  end
  local nextTime = self._nextRefreshTime
  local nowTime = math.floor(self._svrTimeModule:GetServerTime() / 1000)
  local remainingTime = nextTime - nowTime
  local isNotEnoughTime = false
  local stopTime = self._cmptCloseTime
  local stopRemainTime = stopTime - nowTime
  if nextTime >= stopTime then
    isNotEnoughTime = true
  end
  if remainingTime <= 0 or isNotEnoughTime then
    if self._nextRefreshEvent then
      GameGlobal.RealTimer():CancelEvent(self._nextRefreshEvent)
      self._nextRefreshEvent = nil
    end
    self._nextTimeAreaGo:SetActive(false)
    remainingTime = 0
    if 0 < nextTime and remainingTime <= 0 then
      self:_ForceRefresh()
    end
    return
  else
    self._nextTimeAreaGo:SetActive(true)
  end
  self._nextTimeText:SetText(self:_GetNextRefreshFormatString(remainingTime))
end

function UIN19P5SignInController:_InitCmpt(TT, res, forceSend)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N19_P5, ECampaignN19P5ComponentID.CUMULATIVE_LOGIN)
  self._component = self._campaign:GetComponent(ECampaignN19P5ComponentID.CUMULATIVE_LOGIN)
  self._componentInfo = self._campaign:GetComponentInfo(ECampaignN19P5ComponentID.CUMULATIVE_LOGIN)
  local sampleInfo = self._campaign:GetSample()
  if sampleInfo then
    self._nextRefreshTime = sampleInfo.m_extend_info_time[CampainExtendKey.E_CAMPAIGN_EXTEND_KEY_NEXT_REFRESH_TIME]
  else
    self._nextRefreshTime = 0
  end
  self._cmptCloseTime = self._componentInfo.m_close_time or 0
  self:CreateDdata()
  self.currentIdx = self:GetCurrentIdx()
end

function UIN19P5SignInController:GetCurrentIdx()
  local idx = 1
  for i, data in ipairs(self.data) do
    if data.status == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV or data.status == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_LOCK then
      idx = i
      break
    end
  end
  return idx
end

function UIN19P5SignInController:_ForceRefresh()
  self._refreshTaskID = self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self:_InitCmpt(TT, res, true)
    if res and res:GetSucc() then
      self:InitList()
      self:_OnValueRemainingTime()
      self:_OnValueNextRefreshRemainingTime()
    end
  end, self)
end

function UIN19P5SignInController:_GetNextRefreshFormatString(stamp)
  local formatStr = "%s %s"
  local descStr = StringTable.Get("str_activity_common_login_reward_next_remain_time")
  local timeStr = UIActivityHelper.GetFormatTimerStr(stamp)
  local showStr = string.format(formatStr, descStr, timeStr)
  return showStr
end

function UIN19P5SignInController:_OnValueRemainingTime()
  self:_ShowRemainingTime()
  if self._event then
    GameGlobal.RealTimer():CancelEvent(self._event)
    self._event = nil
  end
  self._event = GameGlobal.RealTimer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:_ShowRemainingTime()
  end)
end

function UIN19P5SignInController:_ShowRemainingTime()
  local stopTime = self._cmptCloseTime
  local nowTime = math.floor(self._svrTimeModule:GetServerTime() / 1000)
  local remainingTime = stopTime - nowTime
  if remainingTime <= 0 then
    if self._event then
      GameGlobal.RealTimer():CancelEvent(self._event)
      self._event = nil
    end
    remainingTime = 0
  end
  self.lessTime:SetText(self:_GetFormatString(remainingTime))
end

function UIN19P5SignInController:_GetFormatString(stamp)
  local formatStr = "%s %s"
  local descStr = StringTable.Get("str_activity_common_login_reward_remainingtime")
  local timeStr = UIActivityHelper.GetFormatTimerStr(stamp)
  local showStr = string.format(formatStr, descStr, timeStr)
  return showStr
end

function UIN19P5SignInController:AddScrollEvent()
  UIEventTriggerListener.Get(self.scroll).onDrag = function(PointerEventData)
    self:_OnDrag(PointerEventData)
  end
  UIEventTriggerListener.Get(self.scroll).onBeginDrag = function(PointerEventData)
    self:_BeginDrag(PointerEventData)
  end
  UIEventTriggerListener.Get(self.scroll).onEndDrag = function(PointerEventData)
    self:_EndDrag(PointerEventData)
  end
end

function UIN19P5SignInController:_OnDrag(PointerEventData)
  if self.moving then
    return
  end
  local data = PointerEventData
  if self._draging then
    local posv2 = data.position
    local deltaY = posv2.y - self.beginPos.y
    local dir
    if deltaY > self.scrollDelta then
      dir = 1
      if self.currentIdx >= #self.data then
        return
      end
    elseif deltaY < -1 * self.scrollDelta then
      dir = -1
      if 1 >= self.currentIdx then
        return
      end
    end
    if dir then
      self._draging = false
      do
        local toIdx = self.currentIdx + dir
        self:MoveToIndex(toIdx, self.tweenerTime, function()
          self.beginPos = posv2
          self._draging = true
        end)
      end
    end
  end
end

function UIN19P5SignInController:_BeginDrag(PointerEventData)
  if self.moving then
    return
  end
  self.beginPos = PointerEventData.position
  self._draging = true
end

function UIN19P5SignInController:_EndDrag(PointerEventData)
  if self.moving then
    return
  end
  self._draging = false
end

function UIN19P5SignInController:GetComponents()
  self.ori = self:GetUIComponent("RectTransform", "ori")
  self._ori = self.ori.anchoredPosition
  self._nextTimeAreaGo = self:GetGameObject("nextTimeAreaGo")
  self.scroll = self:GetGameObject("scroll")
  self.lessTime = self:GetUIComponent("UILocalizationText", "lessTime")
  self._nextTimeText = self:GetUIComponent("UILocalizationText", "nextTimeText")
  self.lastAwardsPool = self:GetUIComponent("UISelectObjectPath", "pool")
  self.Pool = self:GetUIComponent("UISelectObjectPath", "Content")
  self.ScrollRect = self:GetUIComponent("ScrollRect", "ScrollView")
  self.ViewPortRect = self.ScrollRect.viewport
  self.ContentRect = self.ScrollRect.content
  self.ScrollRect.onValueChanged:AddListener(function(value)
    self:OnValueChanged(value)
  end)
  self.itemSize = Vector2(650, 230)
  self.bigItemSize = Vector2(650, 350)
  self:AddScrollEvent()
end

function UIN19P5SignInController:MoveToIndex(idx, duration, callback)
  self.moving = true
  self._tweenCallback = callback
  local y = (idx - 1) * self.itemSize.y
  local pos = Vector2(0, y)
  if duration then
    if self.contentTweener then
      self.contentTweener:Kill()
    end
    self.contentTweener = self.ContentRect:DOAnchorPos(pos, duration):OnComplete(function()
      if self._tweenCallback then
        self._tweenCallback()
        self._tweenCallback = nil
      end
      self.currentIdx = idx
      self.moving = false
    end)
  else
    self.ContentRect.anchoredPosition = pos
    if self._tweenCallback then
      self._tweenCallback()
      self._tweenCallback = nil
    end
    self.currentIdx = idx
    self.moving = false
  end
  for i = 1, #self.uiWidgets do
    local widget = self.uiWidgets[i]
    local type
    if i == idx then
      type = UIN19P5SignInPosType.Current
    elseif idx < i then
      type = UIN19P5SignInPosType.Down
    elseif idx > i then
      type = UIN19P5SignInPosType.Up
    end
    widget:RefreshType(type)
  end
end

function UIN19P5SignInController:OnValueChanged(value)
  if self.moving then
    self:CalcOffsetX()
  end
end

function UIN19P5SignInController:CalcOffsetX()
  local contentPosY = self.ContentRect.anchoredPosition.y
  if self.uiWidgets and #self.uiWidgets > 0 then
    for i = 1, #self.uiWidgets do
      local item = self.uiWidgets[i]
      local x = self:CalcItemX(i, contentPosY)
      item:SetOffsetX(x)
    end
  end
end

function UIN19P5SignInController:CalcItemX(i, contentPosY)
  local y
  if i < self.currentIdx then
    y = contentPosY - (i - 1) * self.itemSize.y + self.itemSize.y * 0.5
  else
    y = contentPosY - (i - 1) * self.itemSize.y + self.bigItemSize.y * 0.5
  end
  local sqrt = (328 - self._ori.x) * (328 - self._ori.x) + (175 - self._ori.y) * (175 - self._ori.y) - (y - self._ori.y) * (y - self._ori.y)
  if sqrt < 0 then
    sqrt = 0
  end
  local x = math.sqrt(sqrt) + self._ori.x
  return x
end

function UIN19P5SignInController:Offset(x)
  local x1 = -175
  local y1 = -328
  local x2 = -478
  local y2 = -460
  local x3 = -719
  local y3 = -556
  local y = (x - x1) * (x - x2) / (x3 - x1) * (x3 - x2) * y3 + (x - x1) * (x - x3) / (x2 - x1) * (x2 - x3) * y2 + (x - x2) * (x - x3) / (x1 - x2) * (x1 - x3) * y1
  return y
end

function UIN19P5SignInController:InitList()
  self.Pool:SpawnObjects("UIN19P5SignInItem", #self.data)
  self.uiWidgets = self.Pool:GetAllSpawnList()
  for i = 1, #self.uiWidgets do
    local item = self.uiWidgets[i]
    local data = self.data[i]
    local awards = data.awards
    local status = UIN19P5SignInStatus.Lock
    if data.status == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV then
      status = UIN19P5SignInStatus.Get
    elseif data.status == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_LOCK then
      status = UIN19P5SignInStatus.Lock
    elseif data.status == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_RECVED then
      status = UIN19P5SignInStatus.Finish
    end
    local type
    if i == self.currentIdx then
      type = UIN19P5SignInPosType.Current
    elseif i < self.currentIdx then
      type = UIN19P5SignInPosType.Up
    elseif i > self.currentIdx then
      type = UIN19P5SignInPosType.Down
    end
    item:Flush(i, awards, status, type, function(idx)
      self:ItemClick(idx)
    end, function(pData)
      self:_BeginDrag(pData)
    end, function(pData)
      self:_OnDrag(pData)
    end, function(pData)
      self:_EndDrag(pData)
    end)
  end
  self:CalcOffsetX()
end

function UIN19P5SignInController:ItemClick(idx)
  local abs = 1
  local length = abs * self.tweenerTime
  self:Lock("UIN19P5SignInController:ItemClick")
  self:MoveToIndex(idx, length, function()
    self:UnLock("UIN19P5SignInController:ItemClick")
  end)
end

function UIN19P5SignInController:CloseBtnOnClick(go)
  self:CloseDialog()
end
