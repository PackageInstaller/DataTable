_class("UICN7N36TotalLoginAwardController", UIController)
UICN7N36TotalLoginAwardController = UICN7N36TotalLoginAwardController

function UICN7N36TotalLoginAwardController:Constructor()
  self._campaignTypeId = ECampaignType.CAMPAIGN_TYPE_EVERESCUEPLAN
  self._componentTypeId = ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_CUMULATIVE_LOGIN
  self._event = nil
  self._nextRefreshEvent = nil
  self._complateFlag = nil
  self._cmptCloseTime = 0
  self._nextRefreshTime = 0
  self._svrTimeModule = self:GetModule(SvrTimeModule)
end

function UICN7N36TotalLoginAwardController:_InitCmpt(TT, res, forceSend)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignTypeId, self._componentTypeId)
  if not res:GetSucc() then
    if not self.isAutoPopShow then
      campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    end
    self:OnAutoPopOpenFail()
    return
  end
  if forceSend then
    self._campaign:ReLoadCampaignInfo_Force(TT, res)
    if not res:GetSucc() then
      if not self.isAutoPopShow then
        campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
      end
      self:OnAutoPopOpenFail()
      return
    end
  end
  if res:GetSucc() then
    local svrTimeModule = self:GetModule(SvrTimeModule)
    local svrTime = math.floor(svrTimeModule:GetServerTime() / 1000)
    local component = self._campaign:GetComponent(self._componentTypeId)
    local componentInfo = component:GetComponentInfo()
    local sampleInfo = self._campaign:GetSample()
    if sampleInfo then
      self._nextRefreshTime = sampleInfo.m_extend_info_time[CampainExtendKey.E_CAMPAIGN_EXTEND_KEY_NEXT_REFRESH_TIME]
      self._complateFlag = sampleInfo.m_extend_info[CampainExtendKey.E_CAMPAIGN_EXTEND_KEY_CUMULATIVE_LOGIN_COMPLATE]
    end
    if component then
      self._cumulativeLoginCmpt = component
      local cmptInfo = self._cumulativeLoginCmpt:GetComponentInfo()
      if cmptInfo then
        local openTime = cmptInfo.m_unlock_time
        local closeTime = cmptInfo.m_close_time
        local now = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
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
        self._cmptCloseTime = cmptInfo.m_close_time
        self._componentFullId = self._cumulativeLoginCmpt:GetComponetCfgId(self._campaign._id, cmptInfo.m_component_id)
      end
    end
  else
    if not self.isAutoPopShow then
      campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    end
    self:OnAutoPopOpenFail()
    return
  end
end

function UICN7N36TotalLoginAwardController:OnAutoPopOpenFail()
  if self.isAutoPopShow then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MainLobbyAutoOpenTryFail)
  end
end

function UICN7N36TotalLoginAwardController:CloseDialogWithAnim()
  self:CloseDialog()
end

function UICN7N36TotalLoginAwardController:OnShow(uiParams)
  local clientCfg = Cfg.cfg_activity_total_login_client[self._componentFullId]
  if clientCfg then
    self._showLast = clientCfg.ShowLastAward or false
  else
    Log.error("###[UICN7N36TotalLoginAwardController] clientCfg is nil ! id --> ", self._componentFullId)
  end
  self:InitWidget()
  self:_InitScrollPos()
  self:AddListener()
end

function UICN7N36TotalLoginAwardController:OnHide()
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
  self:DetachListener()
end

function UICN7N36TotalLoginAwardController:AddListener()
  self:AttachEvent(GameEventType.OnActivityTotalAwardCellSelect, self.OnActivityTotalAwardCellSelect)
  self:AttachEvent(GameEventType.ActivityCloseEvent, self.OnActivityCloseEvent)
end

function UICN7N36TotalLoginAwardController:DetachListener()
  self:DetachEvent(GameEventType.OnActivityTotalAwardCellSelect, self.OnActivityTotalAwardCellSelect)
  self:DetachEvent(GameEventType.ActivityCloseEvent, self.OnActivityCloseEvent)
end

function UICN7N36TotalLoginAwardController:OnActivityCloseEvent(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UICN7N36TotalLoginAwardController:OnActivityTotalAwardCellSelect(days)
  self._curSelectedDayNum = days
end

function UICN7N36TotalLoginAwardController:LoadDataOnEnter(TT, res, uiParams)
  if uiParams[1] then
    self.isAutoPopShow = uiParams[1]
  else
    self.isAutoPopShow = false
  end
  if uiParams[2] then
    self._campaignTypeId = uiParams[2]
  end
  if uiParams[3] then
    self._componentTypeId = uiParams[3]
  end
  self:_InitCmpt(TT, res, self.isAutoPopShow)
end

function UICN7N36TotalLoginAwardController:InitWidget()
  self._refreshTaskID = nil
  self._curSelectedDayNum = -1
  self._rootAnim = self:GetUIComponent("Animation", "Root")
  self._bgImgLoader = self:GetUIComponent("RawImageLoader", "Bg")
  self._centerBgImgLoader = self:GetUIComponent("RawImageLoader", "CenterBg")
  self._sideImgLoader = self:GetUIComponent("RawImageLoader", "SideImg")
  self._petModule = GameGlobal.GetModule(PetModule)
  self._titleText = self:GetUIComponent("UILocalizationText", "TitleText")
  self._restTimeText = self:GetUIComponent("UILocalizationText", "RestTimeText")
  self._restTimeAreaGo = self:GetGameObject("RestTimeArea")
  self._nextTimeText = self:GetUIComponent("UILocalizationText", "NextTimeText")
  self._nextTimeAreaGo = self:GetGameObject("NextTimeArea")
  self._lastDataPool = self:GetUIComponent("UISelectObjectPath", "lastDataPool")
  self._lastDataPoolGo = self:GetGameObject("lastData")
  self._lastDataImgGo = self:GetGameObject("lastDataImg")
  self._lastDataImg = self:GetUIComponent("RawImageLoader", "lastDataImg")
  self._scrollRect = self:GetUIComponent("ScrollRect", "DayRewardList")
  self._dayRewardList = self:GetUIComponent("UIDynamicScrollView", "DayRewardList")
  local s = self:GetUIComponent("UISelectObjectPath", "ItemInfo")
  self._tips = s:SpawnObject("UISelectInfo")
  self:_FillCfgUiRes()
  self:_InitData()
  self:_InitDayRewardList()
  self:_ShowLastData()
  self:_ShowLastAward()
  self:_OnValueRemainingTime()
  self:_OnValueNextRefreshRemainingTime()
end

function UICN7N36TotalLoginAwardController:_FillCfgUiRes()
  if not self._componentFullId then
    return
  end
  local clientCfg = Cfg.cfg_activity_total_login_client[self._componentFullId]
  if clientCfg then
    self._titleText:SetText(StringTable.Get(clientCfg.Title, clientCfg.TitleParam))
    if self._titleText.preferredHeight > 100 then
      self._titleText.fontSize = 32
      self._titleText.lineSpacing = 0.7
    end
    self._bgImgLoader:LoadImage(clientCfg.BgImage)
    self._centerBgImgLoader:LoadImage(clientCfg.CenterBgImage)
    self._sideImgLoader:LoadImage(clientCfg.SideImage)
    self._cfg_cell_data = {}
    self._cfg_cell_data.NormalBg = clientCfg.NormalBg
    self._cfg_cell_data.SpecialBg = clientCfg.SpecialBg
    self._cfg_cell_data.AwardParticecleF = clientCfg.AwardParticecleF
    self._cfg_cell_data.AwardParticecleB = clientCfg.AwardParticecleB
    self._cfg_cell_data.LastDataImg = clientCfg.LastDataImg
    self._cfg_cell_data.NormalTextColor = clientCfg.NormalTextColor
    self._cfg_cell_data.SpecialTextColor = clientCfg.SpecialTextColor
  end
end

function UICN7N36TotalLoginAwardController:CloseBtnOnClick(go)
  self:CloseDialogWithAnim()
end

function UICN7N36TotalLoginAwardController:_InitData()
  self._data = {}
  self._data.cells = {}
  if self._cumulativeLoginCmpt then
    local cmptInfo = self._cumulativeLoginCmpt:GetComponentInfo()
    if cmptInfo then
      self._data.next_refresh_time = cmptInfo.m_m_next_refresh_time
      for key, value in pairs(cmptInfo.m_cumulative_info) do
        local rewardInfo = value
        local day = value.m_login_days
        local cellData = DActivityTotalLoginAwardCell:New()
        cellData._state = value.m_reward_status
        cellData._dayNum = value.m_login_days
        cellData._isSpecial = value.m_is_special
        cellData._items = {}
        for rewardIndex, rewardValue in ipairs(value.m_rewards) do
          local itemInfo = RoleAsset:New()
          itemInfo.assetid = rewardValue.assetid
          itemInfo.count = rewardValue.count
          table.insert(cellData._items, itemInfo)
        end
        table.insert(self._data.cells, cellData)
      end
    end
    table.sort(self._data.cells, function(e1, e2)
      return e1._dayNum < e2._dayNum
    end)
    if self._showLast then
      self._lastData = self._data.cells[#self._data.cells]
      local tmpData = self._data.cells
      table.remove(tmpData, #tmpData)
      self._data.cells = tmpData
    end
  end
end

function UICN7N36TotalLoginAwardController:_InitDayRewardList()
  self._dayRewardList:InitListView(#self._data.cells, function(scrollview, index)
    return self:_OnGetRewardCell(scrollview, index)
  end)
end

function UICN7N36TotalLoginAwardController:_OnGetRewardCell(scrollview, index)
  local item = scrollview:NewListViewItem("CellItem")
  local cellPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    cellPool:SpawnObjects("UICN7N36TotalLoginAwardCell", 1)
  end
  local rowList = cellPool:GetAllSpawnList()
  local itemWidget = rowList[1]
  if itemWidget then
    local itemIndex = index + 1
    local cellData = self._data.cells[itemIndex]
    itemWidget:InitData(cellData, self._cfg_cell_data, function(matid, pos)
      self:ShowItemInfo(matid, pos)
    end, function(days)
      self:GetTotalAward(days)
    end, false)
    if cellData and cellData._dayNum == self._curSelectedDayNum then
      itemWidget:SetSelected(true)
    else
      itemWidget:SetSelected(false)
    end
    if itemIndex > #self._data.cells then
      itemWidget:GetGameObject():SetActive(false)
    else
    end
  end
  return item
end

function UICN7N36TotalLoginAwardController:ShowItemInfo(matid, pos)
  self._tips:SetData(matid, pos)
end

function UICN7N36TotalLoginAwardController:_InitScrollPos()
  local firstItemIndex = self:_GetFirstShowItemIndex()
  if firstItemIndex < 0 then
    firstItemIndex = 0
  end
  self:_MoveScrollToItemIndex(firstItemIndex)
end

function UICN7N36TotalLoginAwardController:_MoveScrollToItemIndex(itemIndex)
  self._dayRewardList:MovePanelToItemIndex(itemIndex, 0)
  self._dayRewardList:FinishSnapImmediately()
end

function UICN7N36TotalLoginAwardController:_GetFirstShowItemIndex()
  local cellIndex = 1
  for index, value in ipairs(self._data.cells) do
    if value:CanReceive() then
      cellIndex = index
      break
    end
  end
  return cellIndex - 1
end

function UICN7N36TotalLoginAwardController:GetTotalAward(days)
  self:Lock("UICN7N36TotalLoginAwardController:GetTotalAward(id)")
  self:StartTask(self.OnGetTotalAward, self, days)
end

function UICN7N36TotalLoginAwardController:OnGetTotalAward(TT, days)
  if self._cumulativeLoginCmpt then
    local res = AsyncRequestRes:New()
    GameGlobal.GetModule(ItemModule):CommonAutoConversionEventOpen(true)
    local awards = self._cumulativeLoginCmpt:HandleReceiveCumulativeLoginReward(TT, res, days)
    GameGlobal.GetModule(ItemModule):CommonAutoConversionEventOpen(false)
    self._autoConversionList = GameGlobal.GetModule(ItemModule):GetConverList()
    self:UnLock("UICN7N36TotalLoginAwardController:GetTotalAward(id)")
    if res == nil then
      return
    end
    if res:GetSucc() then
      if awards ~= nil and 0 < #awards then
        self:_ShowAwards(awards, days)
      end
      GameGlobal.EventDispatcher():Dispatch(GameEventType.SummerTwoLoginRed)
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

function UICN7N36TotalLoginAwardController:_ShowAwards(awards, days)
  local tempPets = {}
  if 0 < #awards then
    for i = 1, #awards do
      local ispet = self._petModule:IsPetID(awards[i].assetid)
      if ispet then
        table.insert(tempPets, awards[i])
      end
    end
  end
  
  local function cbFunc()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnActivityTotalAwardGot, days)
  end
  
  if 0 < #tempPets then
    self:ShowDialog("UIPetObtain", tempPets, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
      self:ShowDialog("UIGetItemController", awards, function()
        if self._autoConversionList and next(self._autoConversionList) then
          GameGlobal.UIStateManager():ShowDialog("UICommonConversionController", self._autoConversionList, function()
            cbFunc()
          end)
        else
          cbFunc()
        end
      end)
    end)
  else
    self:ShowDialog("UIGetItemController", awards, function()
      if self._autoConversionList and next(self._autoConversionList) then
        GameGlobal.UIStateManager():ShowDialog("UICommonConversionController", self._autoConversionList, function()
          cbFunc()
        end)
      else
        cbFunc()
      end
    end)
  end
end

function UICN7N36TotalLoginAwardController:_SetListCellCount()
  self._dayRewardList:SetListItemCount(#self._data.cells, false)
end

function UICN7N36TotalLoginAwardController:_ForceRefresh()
  self._refreshTaskID = self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self:_InitCmpt(TT, res, true)
    if res and res:GetSucc() then
      self:_InitData()
      self:_SetListCellCount()
      self._dayRewardList:RefreshAllShownItem()
      self:_InitScrollPos()
      self:_OnValueRemainingTime()
      self:_OnValueNextRefreshRemainingTime()
      self:_ShowLastData()
    end
  end, self)
end

function UICN7N36TotalLoginAwardController:_ShowLastData()
  if self._showLast then
    self._lastDataPoolGo:SetActive(true)
    if not self._lastDataItem then
      self._lastDataItem = self._lastDataPool:SpawnObject("UICN7N36TotalLoginAwardCell")
    end
    local active = self._cfg_cell_data.LastDataImg ~= nil
    self._lastDataImgGo:SetActive(active)
    if active then
      self._lastDataImg:LoadImage(self._cfg_cell_data.LastDataImg)
    end
    self._lastDataItem:InitData(self._lastData, self._cfg_cell_data, function(matid, pos)
      self:ShowItemInfo(matid, pos)
    end, function(days)
      self:GetTotalAward(days)
    end, true)
  else
    self._lastDataPoolGo:SetActive(false)
  end
end

function UICN7N36TotalLoginAwardController:_OnValueRemainingTime()
  self:_ShowRemainingTime()
  if self._event then
    GameGlobal.RealTimer():CancelEvent(self._event)
    self._event = nil
  end
  self._event = GameGlobal.RealTimer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:_ShowRemainingTime()
  end)
end

function UICN7N36TotalLoginAwardController:_ShowRemainingTime()
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

function UICN7N36TotalLoginAwardController:_GetFormatString(stamp)
  local formatStr = "%s <color=#%s>%s</color>"
  local descStr = StringTable.Get("str_activity_common_login_reward_remainingtime")
  local colorStr = "FFFFFF"
  local timeStr = UIActivityHelper.GetFormatTimerStr(stamp)
  local showStr = string.format(formatStr, descStr, colorStr, timeStr)
  return showStr
end

function UICN7N36TotalLoginAwardController:_OnValueNextRefreshRemainingTime()
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

function UICN7N36TotalLoginAwardController:_ShowNextRefreshRemainingTime()
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

function UICN7N36TotalLoginAwardController:_GetNextRefreshFormatString(stamp)
  local formatStr = "%s <color=#%s>%s</color>"
  local descStr = StringTable.Get("str_activity_common_login_reward_next_remain_time")
  local colorStr = "F89001"
  local timeStr = UIActivityHelper.GetFormatTimerStr(stamp)
  local showStr = string.format(formatStr, descStr, colorStr, timeStr)
  return showStr
end

function UICN7N36TotalLoginAwardController:_IsAllRewardUnlocked()
  for index, value in ipairs(self._data.cells) do
    if not value:Unlocked() then
      return false
    end
  end
  if self._lastData and not self._lastData:Unlocked() then
    return false
  end
  return true
end

function UICN7N36TotalLoginAwardController:_ShowLastAward()
  self._item1 = self:GetUIComponent("UISelectObjectPath", "Item1")
  self._item2 = self:GetUIComponent("UISelectObjectPath", "Item2")
  self._items = {
    self._item1,
    self._item2
  }
  for index, value in ipairs(self._items) do
    value:SpawnObject("UICN7N36TotalLoginAwardItem")
    local widgets = value:GetAllSpawnList()
    for indexWidget, valueWidget in ipairs(widgets) do
      valueWidget:SetData(self._data.cells[8]._items[index], function(matid, pos)
        self:ShowItemInfo(matid, pos)
      end, true)
    end
  end
end
