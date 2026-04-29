_class("UISignInController", UIController)
UISignInController = UISignInController

function UISignInController:LoadDataOnEnter(TT, res, uiParams)
  self._module = self:GetModule(SignInModule)
  if uiParams[1] then
    self._showType = uiParams[1]
  else
    self._showType = UISignInShowType.EVERYDAY
  end
  self._str2anim = {
    ShowEveryDayInfo = "uieff_SignIn_SwitchToDaily_new",
    ShowTotalInfo = "uieff_SignIn_SwitchToTotal_new"
  }
  local resState
  local result, msg = self._module:GetCurMonthData(TT)
  if result:GetSucc() then
    resState = true
    self._data = msg.sign_in_base_info
    self._currentDay = self._data.RoleSignInState.sign_in_days
    self._currentDaySignIn = self._module:IsSignInToday()
  else
    resState = false
  end
  if resState then
    local res2, msg2 = self._module:TotalLoginReq(TT)
    if res2:GetSucc() then
      self._totalData = msg2.total_login_info
      self._currentTotalDay = msg2.nTotalLoginDays
      resState = true
    else
      resState = false
    end
  end
  res:SetSucc(resState)
end

function UISignInController:OnShow(uiParams)
  self:_GetComponents()
  self:SetWakeUpFrom()
  self._error2str = {
    [SIGN_IN_RESULT_CODE.SIGN_IN_INVALID] = "str_sign_in_SIGN_IN_INVALID",
    [SIGN_IN_RESULT_CODE.SIGN_IN_MON_SIGN_DATA_INVALID] = "str_sign_in_SIGN_IN_MON_SIGN_DATA_INVALID",
    [SIGN_IN_RESULT_CODE.SIGN_IN_TODAY_IS_SIGN] = "str_sign_in_SIGN_IN_TODAY_IS_SIGN",
    [SIGN_IN_RESULT_CODE.SIGN_IN_FULL] = "str_sign_in_SIGN_IN_FULL",
    [SIGN_IN_RESULT_CODE.SIGN_IN_NOT_SIGN_CANT_RE_SIGN] = "str_sign_in_SIGN_IN_NOT_SIGN_CANT_RE_SIGN",
    [SIGN_IN_RESULT_CODE.SIGN_IN_RE_SIGN_VIG_POINT] = "str_sign_in_SIGN_IN_RE_SIGN_VIG_POINT",
    [SIGN_IN_RESULT_CODE.SIGN_IN_TOTAL_LOGIN_DAYS_INVALID] = "str_sign_in_SIGN_IN_TOTAL_LOGIN_DAYS_INVALID",
    [SIGN_IN_RESULT_CODE.SIGN_IN_TOTAL_LOGIN_IS_RECVED] = "str_sign_in_SIGN_IN_TOTAL_LOGIN_IS_RECVED",
    [SIGN_IN_RESULT_CODE.SIGN_IN_TOTAL_LOGIN_NOT_ENOUGH] = "str_sign_in_SIGN_IN_TOTAL_LOGIN_NOT_ENOUGH",
    [SIGN_IN_RESULT_CODE.SIGN_IN_IS_RE_SIGNED] = "str_sign_in_SIGN_IN_IS_RE_SIGNED"
  }
  self._petModule = GameGlobal.GetModule(PetModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._itemCountPerRow = 1
  self.type2btnStr = {
    [UISignInShowType.EVERYDAY] = "str_sign_in_btn_str_sign_in",
    [UISignInShowType.TOTAL] = "str_sign_in_btn_str_total"
  }
  self._activeMakeUpValue = self._module:ReSignInNeedVigPoint()
  if self._showType == UISignInShowType.EVERYDAY then
    self._currentDaySignIn = self._module:IsSignInToday()
    self:ShowEveryDayInfo()
    local nextSignInTime = self._module:GetNextSignInTime()
    local currTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
    local timeStamp = nextSignInTime - currTime
    if timeStamp < 0 then
      timeStamp = 0
    end
    local timeStr = HelperProxy:GetInstance():FormatTime(timeStamp)
    self._timeDownText:SetText(timeStr)
    if self._currentDaySignIn then
      self:TimeDown()
    else
      self:CheckAndSignIn()
    end
  else
    self:TimeDown()
    self:ShowTotalInfo()
  end
  self:_OnValue()
  self:BtnState()
  self:ShowActBox()
end

function UISignInController:ShowActBox()
  local startTime, endTime = self:GetCheckTimeStr(self._currentDay)
  if startTime then
    self._startTime = startTime
    self._endTime = endTime
    self._actBox:SetActive(true)
    local month = self._data.nMonth
    local tips = StringTable.Get("str_sign_in_act_box_tips", StringTable.Get("str_sign_in_month_by_num_" .. month))
    self._actBoxTips:SetText(tips)
  else
    self._actBox:SetActive(false)
  end
end

function UISignInController:GetCheckTimeStr(dday)
  local day = dday
  if day <= 0 then
    day = 1
  end
  local month = self._data.nMonth
  local year = self._data.nYear
  local time = "12:00:00"
  local concatList = {
    year,
    "-",
    month,
    "-",
    day,
    " ",
    time
  }
  local str = table.concat(concatList)
  local cfg, startTime, endTime = self._module:GetActivityTime(str)
  return startTime, endTime
end

function UISignInController:ActBoxBgOnClick(go)
  self:ShowDialog("UISignInActBoxTipsController", self._endTime)
end

function UISignInController:CloseBtnOnClick(go)
  self:CloseDialog()
end

function UISignInController:_GetComponents()
  local s = self:GetUIComponent("UISelectObjectPath", "itemInfo")
  self._tips = s:SpawnObject("UISelectInfo")
  self._anim = self:GetUIComponent("Animation", "UICanvas")
  self._totalGo = self:GetGameObject("total")
  self._everyDayGo = self:GetGameObject("everyDay")
  self._totalTr = self:GetUIComponent("Transform", "total")
  self._everyDayTr = self:GetUIComponent("Transform", "everyDay")
  self._totalCanvasGroup = self:GetUIComponent("CanvasGroup", "total")
  self._everyDayCanvasGroup = self:GetUIComponent("CanvasGroup", "everyDay")
  self._activePointTextValue = self:GetUIComponent("UILocalizationText", "activePointTextValue")
  self._activePointTipsText = self:GetUIComponent("UILocalizationText", "activePointTipsText")
  self._timeDownText = self:GetUIComponent("UILocalizationText", "timeDownText")
  self._e_title = self:GetUIComponent("UILocalizationText", "e_title")
  self._e_title2 = self:GetUIComponent("UILocalizationText", "e_title2")
  self._dayPool = self:GetUIComponent("UISelectObjectPath", "group")
  self._eRed = self:GetGameObject("eRed")
  self._tRed = self:GetGameObject("tRed")
  self._totalLogin = self:GetUIComponent("UILocalizationText", "totalLogin")
  self._totalLogin2 = self:GetUIComponent("UILocalizationText", "totalLogin2")
  self._totalAwardsList = self:GetUIComponent("UISelectObjectPath", "Content")
  self._totalAwardsListRect = self:GetUIComponent("RectTransform", "Content")
  self._actBox = self:GetGameObject("actBox")
  self._actBoxTips = self:GetUIComponent("UILocalizationText", "actBoxTips")
  self._wakeUpFromGo = self:GetGameObject("wakeUpGameCenter")
  self._wakeUpText = self:GetUIComponent("UILocalizationText", "wakeUpText")
  self._e_select = self:GetGameObject("e_select")
  self._e_normal = self:GetGameObject("e_normal")
  self._t_normal = self:GetGameObject("t_normal")
  self._t_select = self:GetGameObject("t_select")
end

function UISignInController:ShowEveryDayInfo(anim, hideCellAnim)
  self._everyDayTr:SetAsLastSibling()
  self._currentMonth = self._data.nMonth
  self:TodayActive()
  self:ShowDays(anim, hideCellAnim)
  self:ShowTitle()
  self._totalCanvasGroup.blocksRaycasts = false
  self._everyDayCanvasGroup.blocksRaycasts = true
  if anim then
    self:Lock("UISignInController:ShowEveryDayInfo")
    self._anim:Play(self._str2anim.ShowEveryDayInfo)
    self:StartTask(function(TT)
      YIELD(TT, 500)
      self:UnLock("UISignInController:ShowEveryDayInfo")
    end, self)
  end
end

function UISignInController:CheckAndSignIn(total)
  self:Lock("UISignInController:CheckAndSignIn")
  GameGlobal.TaskManager():StartTask(self.OnCheckAndSignIn, self, total)
end

function UISignInController:OnCheckAndSignIn(TT, total)
  local res, msg = self._module:SignInTodayReq(TT, false)
  self:UnLock("UISignInController:CheckAndSignIn")
  if not self.view then
    Log.debug("###[UISignInController] not view return !")
    return
  end
  if res and res:GetSucc() then
    self._data = msg.sign_in_base_info
    local activityAwards = msg.act_assets
    self._currentDay = self._data.RoleSignInState.sign_in_days
    Log.debug("###[UISignInController] OnCheckAndSignIn succ ! day --> ", self._currentDay)
    self:ShowEveryDayInfo()
    self._currentDaySignIn = self._module:IsSignInToday()
    self:Lock("PlaySignInAnim")
    YIELD(TT, 633)
    local itemPrefab = self._items[self._currentDay]
    itemPrefab:ShowGetting(true)
    itemPrefab:PlayAnim()
    YIELD(TT, 1067)
    if not self.view then
      Log.debug("###[UISignInController] not view return !")
      return
    end
    itemPrefab:ShowGetting(false)
    self:UnLock("PlaySignInAnim")
    self:PlayAnim(activityAwards)
    self:ShowEveryDayInfo(false, true)
    self:TimeDown()
    self:BtnState()
  else
    local errorCode = res:GetResult()
    Log.error("###[UISignInController] CheckAndSignIn fail ! result --> ", errorCode)
    ToastManager.ShowToast(StringTable.Get(self._error2str[errorCode]))
  end
  if total then
    self:Lock("UISignInController:CheckAndSignIn-2")
    local res2, msg2 = self._module:TotalLoginReq(TT)
    self:UnLock("UISignInController:CheckAndSignIn-2")
    if res2:GetSucc() then
      self._totalData = msg2.total_login_info
      self._currentTotalDay = msg2.nTotalLoginDays
      self:TotalLoginDayCount()
      self:ShowTotalAwards()
      self:BtnState()
    else
      local errorCode = res2:GetResult()
      Log.error("###[UISignInController] CheckAndSignIn fail ! result --> ", errorCode)
      ToastManager.ShowToast(StringTable.Get(self._error2str[errorCode]))
    end
  end
  self:ShowActBox()
end

function UISignInController:PlayAnim(activityAwards)
  local awardList = {}
  local awards = self._days[self._currentDay].Items
  table.insert(awardList, awards)
  if activityAwards and 0 < #activityAwards then
    for i = 1, #activityAwards do
      local award = activityAwards[i]
      table.insert(awardList, award)
    end
  end
  local tempPets = {}
  if 0 < #awardList then
    for i = 1, #awardList do
      local ispet = self._petModule:IsPetID(awardList[i].assetid)
      if ispet then
        table.insert(tempPets, awardList[i])
      end
    end
  end
  if 0 < #tempPets then
    self:ShowDialog("UIPetObtain", tempPets, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
      self:ShowDialog("UIGetItemController", awardList)
    end)
  else
    self:ShowDialog("UIGetItemController", awardList)
  end
end

function UISignInController:ShowDays(addYieldTime, hideAnim)
  self._days = {}
  local awardList = self._data.MonthInfo
  local canMakeUp = false
  for i = 1, #awardList do
    local award = awardList[i]
    local got = false
    if i < self._currentDay then
      got = true
    elseif i == self._currentDay and self._currentDaySignIn then
      got = true
    end
    local itemCanMakeUp = false
    if not got and not canMakeUp and self._module:IsReSignInToday() then
      itemCanMakeUp = true
      canMakeUp = true
    end
    local data = UISignInAwardData:New(i, award.nDay, award.reward, award.reward_is_good, got, itemCanMakeUp)
    table.insert(self._days, data)
  end
  local spawnCount = #self._days
  self._dayPool:SpawnObjects("UISignInEveryDayItem", spawnCount)
  self._items = self._dayPool:GetAllSpawnList()
  for i = 1, #self._items do
    local dayData
    if i <= table.count(self._days) then
      dayData = self._days[i]
    else
      dayData = nil
    end
    local yieldTime
    if not hideAnim then
      yieldTime = (i - 1) // 7 * 60
    end
    if addYieldTime then
      yieldTime = yieldTime + 50
    end
    self._items[i]:SetData(dayData, self._currentDay, function()
      self:CheckAndSignIn()
    end, function(matid, pos)
      self:ShowItemInfo(matid, pos)
    end, function(idx)
      self:MakeUpDay(idx)
    end, function(day)
      return self:CheckActBoxByDay(day)
    end, yieldTime)
  end
end

function UISignInController:CheckActBoxByDay(day)
  return self:GetCheckTimeStr(day)
end

function UISignInController:MakeUpDay(idx)
  self:Lock("UISignInController:MakeUpDay(idx)")
  GameGlobal.TaskManager():StartTask(self.OnMakeUpDay, self, idx)
end

function UISignInController:OnMakeUpDay(TT, idx)
  local res, msg = self._module:SignInTodayReq(TT, true)
  self:UnLock("UISignInController:MakeUpDay(idx)")
  if res and res:GetSucc() then
    self._data = msg.sign_in_base_info
    local activityAwards = msg.act_assets
    self._currentDay = self._data.RoleSignInState.sign_in_days
    self._currentDaySignIn = self._module:IsSignInToday()
    self:TodayActive()
    self:Lock("PlaySignInAnim")
    local itemPrefab = self._items[idx]
    itemPrefab:ShowGetting(true)
    itemPrefab:MakeUpAnim()
    YIELD(TT, 867)
    itemPrefab:ShowGetting(false)
    self:UnLock("PlaySignInAnim")
    self:MakeUpAnim(idx, activityAwards)
  else
    Log.fatal("###[UISignInController] self._module:MakeUpDay fail ! error --> ", res:GetResult())
  end
end

function UISignInController:MakeUpAnim(idx, activityAwards)
  local data = self._days[idx]
  local awards = {}
  local tempAwards = data.Items
  table.insert(awards, tempAwards)
  if activityAwards and 0 < #activityAwards then
    for i = 1, #activityAwards do
      local award = activityAwards[i]
      table.insert(awards, award)
    end
  end
  local tempPets = {}
  if 0 < #awards then
    for i = 1, #awards do
      local ispet = self._petModule:IsPetID(awards[i].assetid)
      if ispet then
        table.insert(tempPets, awards[i])
      end
    end
  end
  if 0 < #tempPets then
    self:ShowDialog("UIPetObtain", tempPets, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
      self:ShowDialog("UIGetItemController", awards)
    end)
  else
    self:ShowDialog("UIGetItemController", awards)
  end
  self:ShowDays(false, true)
end

function UISignInController:TimeDown()
  self:ShowTime()
  if self._timeEvent then
    GameGlobal.Timer():CancelEvent(self._timeEvent)
    self._timeEvent = nil
  end
  self._timeEvent = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:ShowTime()
  end)
end

function UISignInController:ShowTime()
  local nextSignInTime = self._module:GetNextSignInTime()
  local currTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local timeStamp = nextSignInTime - currTime
  if 0 <= timeStamp then
    if self._showType == UISignInShowType.EVERYDAY then
      local timeStr = HelperProxy:GetInstance():FormatTime(timeStamp)
      self._timeDownText:SetText(timeStr)
    end
  else
    self._currentDaySignIn = self._module:IsSignInToday()
    if self._currentDaySignIn then
      return
    end
    if self._timeEvent then
      GameGlobal.Timer():CancelEvent(self._timeEvent)
      self._timeEvent = nil
    end
    if self._showType == UISignInShowType.EVERYDAY then
      self:CheckAndSignIn(true)
    else
      self:RefreshData()
    end
  end
end

function UISignInController:RefreshData()
  GameGlobal.TaskManager():StartTask(self.OnRefreshData, self)
end

function UISignInController:OnRefreshData(TT)
  self:Lock("UISignInController:OnRefreshData")
  local res1, msg1 = self._module:GetCurMonthData(TT)
  self:UnLock("UISignInController:OnRefreshData")
  if res1:GetSucc() then
    self._data = msg1.sign_in_base_info
    self._currentDay = self._data.RoleSignInState.sign_in_days
    self._currentDaySignIn = self._module:IsSignInToday()
  else
    local errorCode = res1:GetResult()
    Log.error("###[UISignInController] OnRefreshData fail ! result --> ", errorCode)
    ToastManager.ShowToast(StringTable.Get(self._error2str[errorCode]))
  end
  self:Lock("UISignInController:OnRefreshData-2")
  local res2, msg2 = self._module:TotalLoginReq(TT)
  self:UnLock("UISignInController:OnRefreshData-2")
  if res2:GetSucc() then
    self._totalData = msg2.total_login_info
    self._currentTotalDay = msg2.nTotalLoginDays
    self:ShowTotalInfo()
    self:TimeDown()
    self:BtnState()
  else
    local errorCode = res2:GetResult()
    Log.error("###[UISignInController] OnRefreshData fail ! result --> ", errorCode)
    ToastManager.ShowToast(StringTable.Get(self._error2str[errorCode]))
  end
  self:ShowActBox()
end

function UISignInController:TodayActive()
  local questModule = self:GetModule(QuestModule)
  local activePoint = questModule:GetDailyQuestVigorous()
  self._activePointTextValue:SetText(activePoint)
  self._activePointTipsText:SetText(StringTable.Get("str_sign_in_make_up_tips", self._activeMakeUpValue))
end

function UISignInController:ShowTitle()
  local monthStr = StringTable.Get("str_sign_in_title_month_by_num_" .. tostring(self._currentMonth))
  self._e_title:SetText(StringTable.Get("str_sign_in_current_month_2", "<color=#ffffff>" .. monthStr .. "</color>"))
  self._e_title2:SetText(StringTable.Get("str_sign_in_current_month_2", monthStr))
end

function UISignInController:ShowTotalInfo(anim)
  self._totalTr:SetAsLastSibling()
  self:TotalLoginDayCount()
  self:ShowTotalAwards(anim)
  self._totalCanvasGroup.blocksRaycasts = true
  self._everyDayCanvasGroup.blocksRaycasts = false
  if anim then
    self:Lock("UISignInController:ShowTotalInfo")
    self._anim:Play(self._str2anim.ShowTotalInfo)
    self:StartTask(function(TT)
      YIELD(TT, 733)
      self:UnLock("UISignInController:ShowTotalInfo")
    end, self)
  end
end

function UISignInController:TotalLoginDayCount()
  self._totalLogin:SetText(StringTable.Get("str_sign_in_day_str", self._currentTotalDay))
  self._totalLogin2:SetText(StringTable.Get("str_sign_in_day_str", self._currentTotalDay))
end

function UISignInController:ShowTotalAwards(anim)
  self._totalAwardsData = {}
  local awardList = {}
  for i, v in HelperProxy:GetInstance():pairsByKeys(self._totalData) do
    table.insert(awardList, v)
  end
  for i = 1, #awardList do
    local award = awardList[i]
    local data = UITotalAwardData:New(i, award.nDay, award.Reward, award.bIsAccept)
    table.insert(self._totalAwardsData, data)
  end
  self._listCount = table.count(self._totalAwardsData)
  local firstIdx = self:MoveTotalList()
  self._totleItemPlayAnim = anim
  self._totalAwardsList:SpawnObjects("UISignInTotalItem", self._listCount)
  self._totalAwardPool = self._totalAwardsList:GetAllSpawnList()
  for i = 1, self._listCount do
    local item = self._totalAwardPool[i]
    self:_ShowTotalAwardItem(item, i, firstIdx)
  end
  self._totleItemPlayAnim = false
end

function UISignInController:MoveTotalList()
  local moveIdx = 0
  for i = 1, #self._totalAwardsData do
    local data = self._totalAwardsData[i]
    if not data.Got and data.DayCount <= self._currentTotalDay then
      moveIdx = i - 1
      break
    end
  end
  local spacingY = 15
  local topPadding = moveIdx == 0 and 0 or 35 - spacingY
  local cellHeight = 220
  local pos = cellHeight * moveIdx + moveIdx * spacingY + topPadding
  self._totalAwardsListRect.anchoredPosition = Vector2(0, pos)
  return moveIdx + 1
end

function UISignInController:_InitScrollView(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UISignInTotalItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local item = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    self:_ShowTotalAwardItem(item, itemIndex)
  end
  return item
end

function UISignInController:_ShowTotalAwardItem(item, idx, firstIdx)
  local data = self._totalAwardsData[idx]
  local yieldTime
  if self._totleItemPlayAnim and firstIdx <= idx then
    yieldTime = (idx - firstIdx) * 60 + 50
  end
  item:SetData(data, self._currentTotalDay, function(matid, pos)
    self:ShowItemInfo(matid, pos)
  end, function(days)
    self:GetTotalAward(days)
  end, yieldTime)
end

function UISignInController:GetTotalAward(days)
  self:Lock("UISignInController:GetTotalAward(id)")
  GameGlobal.TaskManager():StartTask(self.OnGetTotalAward, self, days)
end

function UISignInController:OnGetTotalAward(TT, days)
  local res, returnDays = self._module:RecvTotalLoginRewardReq(TT, days)
  self:UnLock("UISignInController:GetTotalAward(id)")
  if res and res:GetSucc() then
    local data
    for i = 1, #self._totalAwardsData do
      if self._totalAwardsData[i].DayCount == returnDays then
        data = self._totalAwardsData[i]
        break
      end
    end
    data.Got = true
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTotalAwardGot, returnDays, data)
    self:Lock("GameEventType.OnTotalAwardGot_anim")
    YIELD(TT, 700)
    self:UnLock("GameEventType.OnTotalAwardGot_anim")
    self:BtnState()
    local awards = data.Items
    local tempPets = {}
    if 0 < #awards then
      for i = 1, #awards do
        local ispet = self._petModule:IsPetID(awards[i].assetid)
        if ispet then
          table.insert(tempPets, awards[i])
        end
      end
    end
    if 0 < #tempPets then
      self:ShowDialog("UIPetObtain", tempPets, function()
        GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
        self:ShowDialog("UIGetItemController", awards, function()
          self:Share(days)
        end)
      end)
    else
      self:ShowDialog("UIGetItemController", awards, function()
        self:Share(days)
      end)
    end
  else
    Log.fatal("###[UISignInController] self._module:GetTotalAward fail ! error --> ", res:GetResult())
  end
end

function UISignInController:Share(days)
  local shareModule = GameGlobal.GetModule(ShareModule)
  if shareModule:CanShare() then
    self:ShowDialog("UISignInShare", days)
  end
end

function UISignInController:eBtnOnClick(go)
  if self._showType ~= UISignInShowType.EVERYDAY then
    self._showType = UISignInShowType.EVERYDAY
    self:OnButtonOnClickEnd()
  end
end

function UISignInController:tBtnOnClick(go)
  if self._showType ~= UISignInShowType.TOTAL then
    self._showType = UISignInShowType.TOTAL
    self:OnButtonOnClickEnd()
  end
end

function UISignInController:ButtonOnClick(go)
  if self._showType == UISignInShowType.EVERYDAY then
    self._showType = UISignInShowType.TOTAL
  else
    self._showType = UISignInShowType.EVERYDAY
  end
  self:OnButtonOnClickEnd()
end

function UISignInController:OnButtonOnClick(TT)
  if self._showType == UISignInShowType.EVERYDAY then
    local result, msg = self._module:GetCurMonthData(TT)
    self:UnLock("UISignInController:ButtonOnClick")
    if result:GetSucc() then
      self._data = msg.sign_in_base_info
      self:OnButtonOnClickEnd()
    else
      local errorCode = result:GetResult()
      Log.error("###[UISignInController] OnButtonOnClick --> GetCurMonthData fail ! result --> ", errorCode)
      ToastManager.ShowToast(StringTable.Get(self._error2str[errorCode]))
    end
  else
    local result, msg = self._module:TotalLoginReq(TT)
    self:UnLock("UISignInController:ButtonOnClick")
    if result:GetSucc() then
      self._totalData = msg.total_login_info
      self._currentTotalDay = msg.nTotalLoginDays
      self:OnButtonOnClickEnd()
    else
      local errorCode = result:GetResult()
      Log.error("###[UISignInController] OnButtonOnClick --> GetCurMonthData fail ! result --> ", errorCode)
      ToastManager.ShowToast(StringTable.Get(self._error2str[errorCode]))
    end
  end
end

function UISignInController:OnButtonOnClickEnd()
  if self._showType == UISignInShowType.EVERYDAY then
    self._currentDaySignIn = self._module:IsSignInToday()
    self:ShowEveryDayInfo(true)
    if self._currentDaySignIn then
    else
      self:CheckAndSignIn()
    end
  else
    self:ShowTotalInfo(true)
  end
  self:_OnValue()
  self:BtnState()
  self:Lock("UISignInController:OnButtonOnClickEnd")
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
  self._event = GameGlobal.Timer():AddEvent(433, function()
    self:UnLock("UISignInController:OnButtonOnClickEnd")
  end)
end

function UISignInController:OnHide()
  if self._event then
    self:UnLock("UISignInController:OnButtonOnClickEnd")
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
  if self._req then
    self._req:Dispose()
  end
  self:UnLock("PlaySignInAnim")
end

function UISignInController:_OnValue()
  if self._showType == UISignInShowType.EVERYDAY then
    self._everyDayTr:SetAsLastSibling()
    self._totalCanvasGroup.alpha = 0
    self._everyDayCanvasGroup.alpha = 1
    self._totalCanvasGroup.blocksRaycasts = false
    self._everyDayCanvasGroup.blocksRaycasts = true
  elseif self._showType == UISignInShowType.TOTAL then
    self._totalTr:SetAsLastSibling()
    self._totalCanvasGroup.alpha = 1
    self._everyDayCanvasGroup.alpha = 0
    self._totalCanvasGroup.blocksRaycasts = true
    self._everyDayCanvasGroup.blocksRaycasts = false
  end
end

function UISignInController:SetWakeUpFrom()
  local wakeUp = self:GetUIComponent("UISelectObjectPath", "wakeUp")
  self.wakeUp = wakeUp:SpawnObject("UIWakeUpSign")
end

function UISignInController:BtnState()
  local eRed = false
  eRed = not self._currentDaySignIn
  local tRed = false
  tRed = self._module:HaveTotalLoginReward()
  self._eRed:SetActive(eRed)
  self._tRed:SetActive(tRed)
  self._e_select:SetActive(self._showType == UISignInShowType.EVERYDAY)
  self._e_normal:SetActive(self._showType == UISignInShowType.TOTAL)
  self._t_select:SetActive(self._showType == UISignInShowType.TOTAL)
  self._t_normal:SetActive(self._showType == UISignInShowType.EVERYDAY)
end

function UISignInController:ShowItemInfo(matid, pos)
  self._tips:SetData(matid, pos)
end

function UISignInController:OnHide()
  if self._timeEvent then
    GameGlobal.Timer():CancelEvent(self._timeEvent)
    self._timeEvent = nil
  end
end

local UISignInShowType = {EVERYDAY = 1, TOTAL = 2}
_enum("UISignInShowType", UISignInShowType)
_class("UISignInAwardData", Object)
UISignInAwardData = UISignInAwardData

function UISignInAwardData:Constructor(index, day, items, good, itemGot, canMakeUp)
  self.Index = index
  self.Day = day
  self.Items = items
  self.Good = good
  self.ItemGot = itemGot
  self.CanMakeUp = canMakeUp
end

_class("UITotalAwardData", Object)
UITotalAwardData = UITotalAwardData

function UITotalAwardData:Constructor(index, dayCount, items, got)
  self.Index = index
  self.DayCount = dayCount
  self.Items = items
  self.Got = got
end
