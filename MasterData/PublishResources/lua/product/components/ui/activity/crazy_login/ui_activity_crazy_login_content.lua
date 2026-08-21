require("ui_side_enter_center_content_base")
_class("UIActivityCrazyLoginContent", UISideEnterCenterContentBase)
UIActivityCrazyLoginContent = UIActivityCrazyLoginContent

function UIActivityCrazyLoginContent:DoInit(params)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_SIGN_IN
  self._componentId = ECampaignSignInComponentID.ECAMPAIGN_SIGN_IN_CUMULATIVE_LOGIN
  self._campaignId = params and params.campaign_id
  self._event = nil
  self._nextRefreshEvent = nil
  self._complateFlag = nil
  self._cmptCloseTime = 0
  self._nextRefreshTime = 0
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaign = self._data
end

function UIActivityCrazyLoginContent:DoShow()
  self:_AttachEvent()
  self._component = self._campaign:GetComponent(self._componentId)
  local cfgId = self._component:GetComponentCfgId()
  self._clientCfg = Cfg.cfg_activity_crazy_login_content[cfgId]
  if not self._clientCfg then
    Log.fatal("UIActivityCrazyLoginContent:_Refresh() cfg_activity_crazy_login_content is nil ! id --> ", cfgId)
  end
  self:_FillUIByCfg(self._clientCfg)
  self:InitWidget()
  self:_Refresh()
  self:StartTask(function(TT)
    self._campaign:ClearCampaignNew(TT)
  end)
end

function UIActivityCrazyLoginContent:DoHide()
  self:_DetachEvent()
  UIWidgetHelper.ClearWidgets(self, "ItemInfo")
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
end

function UIActivityCrazyLoginContent:DoDestroy()
end

function UIActivityCrazyLoginContent:_ForceRefresh()
  if self._refreshTaskID ~= nil then
    return
  end
  self._refreshTaskID = self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._campaign:ReLoadCampaignInfo_Force(TT, res)
    if res and res:GetSucc() then
      self:_Refresh()
    end
    self._refreshTaskID = nil
  end, self)
end

function UIActivityCrazyLoginContent:_Refresh(notMove)
  local componentInfo = self._component:GetComponentInfo()
  self._cmptCloseTime = componentInfo and componentInfo.m_close_time
  self._nextRefreshTime, self._complateFlag = self:_GetRefreshTime()
  self:_InitData()
  self:_SetCellList()
  if not notMove then
    self:_InitScrollPos()
  end
  self:_OnValueRemainingTime()
  self:_OnValueNextRefreshRemainingTime()
end

function UIActivityCrazyLoginContent:InitWidget()
  self._refreshTaskID = nil
  self._curSelectedDayNum = -1
  self._restTimeText = self:GetUIComponent("UILocalizationText", "RestTimeText")
  self._restTimeAreaGo = self:GetGameObject("RestTimeArea")
  self._nextTimeText = self:GetUIComponent("UILocalizationText", "NextTimeText")
  self._nextTimeAreaGo = self:GetGameObject("NextTimeArea")
end

function UIActivityCrazyLoginContent:_GetRefreshTime()
  local sample = self._campaign:GetSample()
  if sample then
    local time = sample.m_extend_info_time[CampainExtendKey.E_CAMPAIGN_EXTEND_KEY_NEXT_REFRESH_TIME]
    local flag = sample.m_extend_info[CampainExtendKey.E_CAMPAIGN_EXTEND_KEY_CUMULATIVE_LOGIN_COMPLATE]
    return time, flag
  end
end

function UIActivityCrazyLoginContent:_FillUIByCfg(clientCfg)
  self._showLast = clientCfg.ShowLastAward and true or false
  self:_SetTitleText(clientCfg)
  self:_SetTitleTextBg(clientCfg)
  self:_SetTitleTextBgRawImage(clientCfg)
  UIWidgetHelper.SetRawImage(self, "Bg", clientCfg.BgImage)
  UIWidgetHelper.SetRawImage(self, "SideImg", clientCfg.SideImage)
end

function UIActivityCrazyLoginContent:_SetTitleText(clientCfg)
  local text = StringTable.Get(clientCfg.Title, clientCfg.TitleParam)
  UIWidgetHelper.SetLocalizationText(self, "TitleText", text)
end

function UIActivityCrazyLoginContent:_SetTitleTextBg(clientCfg)
  local widgetName = "titleTextBg"
  local ttbgName = clientCfg.TitleTextBgName
  if ttbgName then
    UIWidgetHelper.SetImageSprite(self, widgetName, ttbgName[1], ttbgName[2])
    self:_SetTitleTextBgTrans(widgetName, clientCfg)
  end
  self:GetGameObject(widgetName):SetActive(ttbgName ~= nil)
end

function UIActivityCrazyLoginContent:_SetTitleTextBgRawImage(clientCfg)
  local widgetName = "titleTextBgR"
  local ttbgName = clientCfg.TitleTextBgRawName
  if ttbgName then
    UIWidgetHelper.SetRawImage(self, widgetName, ttbgName)
    self:_SetTitleTextBgTrans(widgetName, clientCfg)
  end
  self:GetGameObject(widgetName):SetActive(ttbgName ~= nil)
end

function UIActivityCrazyLoginContent:_SetTitleTextBgTrans(widgetName, clientCfg)
  local ttbgInfo = clientCfg.TitleTextBgInfo
  if ttbgInfo then
    local trans = self:GetUIComponent("RectTransform", widgetName)
    trans.localPosition = Vector3(ttbgInfo[1], ttbgInfo[2], 0)
    trans.sizeDelta = Vector2(ttbgInfo[3], ttbgInfo[4])
  end
end

function UIActivityCrazyLoginContent:_InitData()
  self._cells = {}
  if self._component then
    local cmptInfo = self._component:GetComponentInfo()
    if cmptInfo then
      for key, value in pairs(cmptInfo.m_cumulative_info) do
        local cellData = {}
        cellData._state = value.m_reward_status
        cellData._dayNum = value.m_login_days
        cellData._isSpecial = value.m_is_special
        cellData._items = {}
        for rewardIndex, rewardValue in ipairs(value.m_rewards) do
          local ra = RoleAsset:New()
          ra.assetid = rewardValue.assetid
          ra.count = rewardValue.count
          table.insert(cellData._items, ra)
        end
        table.insert(self._cells, cellData)
      end
    end
    table.sort(self._cells, function(e1, e2)
      return e1._dayNum < e2._dayNum
    end)
  end
end

function UIActivityCrazyLoginContent:_SetCellList()
  local datas = self._cells
  local listCount = self._showLast and #datas - 1 or #datas
  local items = UIWidgetHelper.SpawnObjects(self, "Content", "UIActivityCrazyLoginCell", listCount)
  self:GetGameObject("lastDataPool"):SetActive(self._showLast)
  if self._showLast then
    local lastItem = UIWidgetHelper.SpawnObject(self, "lastDataPool", "UIActivityCrazyLoginCell")
    table.insert(items, lastItem)
  end
  self._items = items
  for i, v in ipairs(self._items) do
    local isLastDay = self._showLast and i == #self._items
    v:SetData(i, datas[i], self._clientCfg, function(idx)
      for i, v in ipairs(self._items) do
        v:SetSelected(i == idx)
      end
    end, function(idx)
      self:GetTotalAward(idx)
    end, function(matid, pos)
      UIWidgetHelper.SetAwardItemTips(self, "ItemInfo", matid, pos)
    end, isLastDay)
  end
end

function UIActivityCrazyLoginContent:_InitScrollPos()
  local canGetIdx = self:_CheckCanGetIndex()
  if canGetIdx ~= 0 then
    local content = self:GetUIComponent("RectTransform", "Content")
    local height = (canGetIdx - 1) * 139
    content.anchoredPosition = Vector2(content.anchoredPosition.x, height)
  end
end

function UIActivityCrazyLoginContent:_CheckCanGetIndex()
  for index, value in ipairs(self._cells) do
    local tb_check = {
      [ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV] = true,
      [ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_LOCK] = true
    }
    if tb_check[value._state] then
      return index
    end
  end
  return 1
end

function UIActivityCrazyLoginContent:GetTotalAward(idx)
  local days = self._cells[idx]._dayNum
  self._component:Start_HandleReceiveCumulativeLoginReward(days, function(res, rewards)
    self:_OnReceiveRewards(idx, res, rewards)
  end)
end

function UIActivityCrazyLoginContent:_OnReceiveRewards(idx, res, rewards)
  if self.view == nil then
    return
  end
  if res:GetSucc() then
    self._items[idx]:OnAwardGot(rewards)
  else
    self._campaign:CheckErrorCode(res.m_result, nil, nil)
  end
end

function UIActivityCrazyLoginContent:_OnValueRemainingTime()
  self:_ShowRemainingTime()
  if self._event then
    GameGlobal.RealTimer():CancelEvent(self._event)
    self._event = nil
  end
  self._event = GameGlobal.RealTimer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:_ShowRemainingTime()
  end)
end

function UIActivityCrazyLoginContent:_ShowRemainingTime()
  local stopTime = self._cmptCloseTime
  local nowTime = math.floor(self._svrTimeModule:GetServerTime() / 1000)
  local remainingTime = stopTime - nowTime
  if remainingTime <= 0 then
    if self._event then
      GameGlobal.RealTimer():CancelEvent(self._event)
      self._event = nil
    end
    self._restTimeAreaGo:SetActive(false)
    remainingTime = 0
  else
    self._restTimeAreaGo:SetActive(true)
  end
  self._restTimeText:SetText(self:_GetFormatString(remainingTime))
end

function UIActivityCrazyLoginContent:_GetFormatString(stamp)
  local formatStr = "%s <color=#%s>%s</color>"
  local descStr = StringTable.Get("str_activity_common_login_reward_remainingtime")
  local colorStr = "FFD862"
  local timeStr = UIActivityHelper.GetFormatTimerStr(stamp)
  local showStr = string.format(formatStr, descStr, colorStr, timeStr)
  return showStr
end

function UIActivityCrazyLoginContent:_OnValueNextRefreshRemainingTime()
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

function UIActivityCrazyLoginContent:_ShowNextRefreshRemainingTime()
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

function UIActivityCrazyLoginContent:_GetNextRefreshFormatString(stamp)
  local formatStr = "%s <color=#%s>%s</color>"
  local descStr = StringTable.Get("str_activity_common_login_reward_next_remain_time")
  local colorStr = "FFD862"
  local timeStr = UIActivityHelper.GetFormatTimerStr(stamp)
  local showStr = string.format(formatStr, descStr, colorStr, timeStr)
  return showStr
end

function UIActivityCrazyLoginContent:_IsAllRewardUnlocked()
  local tb_check = {
    [ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV] = true,
    [ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_RECVED] = true
  }
  for index, value in ipairs(self._cells) do
    if not tb_check[value._state] then
      return false
    end
  end
  return true
end

function UIActivityCrazyLoginContent:_AttachEvent()
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIActivityCrazyLoginContent:_DetachEvent()
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIActivityCrazyLoginContent:OnUIGetItemCloseInQuest()
  self:_Refresh(true)
end
