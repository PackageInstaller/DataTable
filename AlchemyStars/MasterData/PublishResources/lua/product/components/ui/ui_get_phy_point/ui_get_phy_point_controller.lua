_class("UIGetPhyPointController", UIController)
UIGetPhyPointController = UIGetPhyPointController

function UIGetPhyPointController:LoadDataOnEnter(TT, res, uiParams)
  self._shopModule = GameGlobal.GetModule(ShopModule)
  self._roleModule = self:GetModule(RoleModule)
  self._loginModule = GameGlobal.GetModule(LoginModule)
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  res:SetSucc(true)
  self:Lock("_InitRefresh")
  self.loadSuc = false
  self:StartTask(self._InitRefresh, self)
end

function UIGetPhyPointController:_InitRefresh(TT)
  local shopModule = GameGlobal.GetModule(ShopModule)
  local req = shopModule:RequestPhysicalData(TT)
  if req:GetSucc() then
    self.loadSuc = true
    self:_OnValue()
    self:RefreshTitle()
    self:UnLock("_InitRefresh")
    if self.aircraftModule:GetRoomByRoomType(AirRoomType.PrismRoom) == nil then
      self:LockPhyRoomRefreshGetPanel()
    end
  else
    self.loadSuc = true
    self:_OnValue()
    self:RefreshTitle()
    self:UnLock("_InitRefresh")
  end
end

function UIGetPhyPointController:OnShow(uiParams)
  self._active = true
  self._roleModule = self:GetModule(RoleModule)
  self.aircraftModule = GameGlobal.GetModule(AircraftModule)
  self.needCheck = true
  self:_GetComponents()
  self._bugState = nil
  self._bugMaxCount = 999
  self:AttachEvent(GameEventType.ItemCountChanged, self.OnItemCountChange)
  self:AttachEvent(GameEventType.DiamondCountChanged, self.OnItemCountChange)
  self._newCenterCanvasGroup.alpha = 0
  self._newCenterCanvasGroup:DOFade(1, 0.3)
  if not self.loadSuc then
    return
  end
  self:_OnValue()
end

function UIGetPhyPointController:OnHide()
  self._active = false
  if self._showTimeEvent then
    GameGlobal.RealTimer():CancelEvent(self._showTimeEvent)
    self._showTimeEvent = nil
  end
  if self._phyEvent then
    GameGlobal.RealTimer():CancelEvent(self._phyEvent)
    self._phyEvent = nil
  end
  if self.checkServerPhyTask then
    self.checkServerPhyTask = nil
  end
end

function UIGetPhyPointController:_GetComponents()
  self._pressTime = Cfg.cfg_global.sale_and_use_press_long_deltaTime.IntValue
  self._updateTime = 0
  self:InitNewComponet()
end

function UIGetPhyPointController:InitNewComponet()
  self.newCenter = self:GetGameObject("NewCenter")
  self.newCenter:SetActive(true)
  self.newCenterAnim = self:GetUIComponent("Animation", "NewCenter")
  self.next_recover_txt = self:GetUIComponent("UILocalizationText", "next_recover_txt")
  self.all_recover_txt = self:GetUIComponent("UILocalizationText", "all_recover_txt")
  self.recoverRoot = self:GetGameObject("RecoverRoot")
  self.useRoot = self:GetGameObject("UseRoot")
  self.decoreRoot = self:GetGameObject("DecoreRoot")
  self.left_use_count = self:GetUIComponent("UILocalizationText", "left_use_count")
  self.can_use_num_count_txt = self:GetUIComponent("UILocalizationText", "can_use_num_count_txt")
  self.can_use_by_day_txt = self:GetUIComponent("UILocalizationText", "can_use_by_day_txt")
  self.today_can_tip = self:GetUIComponent("UILocalizationText", "today_can_tip")
  self.use_count_txt = self:GetUIComponent("UILocalizationText", "use_count_txt")
  self.cost_light_cont_txt = self:GetUIComponent("UILocalizationText", "cost_light_cont_txt")
  self.can_get_phy_cont_txt = self:GetUIComponent("UILocalizationText", "can_get_phy_cont_txt")
  self.has_max_txt_obj = self:GetGameObject("has_max_txt")
  self.phy_get_panel = self:GetGameObject("phy_get_panel")
  self._useSubBtn = self:GetGameObject("use_sub")
  self._useAddBtn = self:GetGameObject("use_add")
  self._newCenterCanvasGroup = self:GetUIComponent("CanvasGroup", "NewCenter")
  self.rootAnim = self:GetUIComponent("Animation", "UIGetPhyPointController")
  self._countDownBg = self:GetUIComponent("Image", "countDownBg")
  self._isSubMouseDown = false
  self._isAddMouseDown = false
  local useSub = UILongPressTriggerListener.Get(self._useSubBtn)
  
  function useSub.onLongPress(go)
    if self._isSubMouseDown == false then
      self._isSubMouseDown = true
    end
  end
  
  function useSub.onLongPressEnd(go)
    if self._isSubMouseDown == true then
      self._isSubMouseDown = false
    end
  end
  
  local useAdd = UILongPressTriggerListener.Get(self._useAddBtn)
  
  function useAdd.onLongPress(go)
    if self._isAddMouseDown == false then
      self._isAddMouseDown = true
    end
  end
  
  function useAdd.onLongPressEnd(go)
    if self._isAddMouseDown == true then
      self._isAddMouseDown = false
    end
  end
  
  self.phy_get_panel:SetActive(true)
  self.power_rawimg = self:GetUIComponent("RawImageLoader", "Power_rawimg")
  self.power_rawimg:LoadImage(self.power_rawimg.m_rawimage_name)
  self.cur_have_phy_txt = self:GetUIComponent("UILocalizationText", "cur_have_phy_txt")
  self.air_phy_txt = self:GetUIComponent("UILocalizationText", "air_phy_txt")
  self.effectObj = self:GetGameObject("Effect")
  self.effectObj:SetActive(false)
  if not self.loadSuc then
    return
  end
  self.CurSelectModType = SelectModType.Get
  if self.aircraftModule:GetRoomByRoomType(AirRoomType.PrismRoom) == nil then
    self.CurSelectModType = SelectModType.Use
    self:LockPhyRoomRefreshGetPanel()
  end
  self:RefreshPoolsBtn()
  self.aircaftPhy = math.floor(self.aircraftModule:GetPhysicStorage())
  self:RefreshTitle()
end

function UIGetPhyPointController:RefreshTitle()
  self:StartTask(self.OnOpenPhyTimer, self)
end

function UIGetPhyPointController:OnOpenPhyTimer(TT)
  self:Lock("OnOpenPhyTimer")
  local res, startTime, intervalRecoverTime, leftRecoverTime, allRecoverTime = self._roleModule:GetRecoverData(TT, 0)
  if not res:GetSucc() then
    Log.fatal("### request fail -- self._roleModule:GetRecoverData !")
    return
  end
  self._gapTimeNum = intervalRecoverTime
  self._nextTimeNum = leftRecoverTime
  self._allTimeNum = allRecoverTime
  self._phyPanelIsOpen = true
  if self._phyEvent then
    GameGlobal.RealTimer():CancelEvent(self._phyEvent)
    self._phyEvent = nil
  end
  self._phyEvent = GameGlobal.RealTimer():AddEvent(2000, function()
  end)
  if not self._active or self.has_max_txt_obj == nil then
    YIELD(TT)
  end
  local nextStr = StringTable.Get("str_get_phy_point_next_recover") .. self:Time2Str(self._nextTimeNum)
  if self._allTimeNum == 0 then
    nextStr = StringTable.Get("str_get_phy_point_topmax_tips")
    if self.has_max_txt_obj then
      self.has_max_txt_obj:SetActive(true)
    end
    self.next_recover_txt.gameObject:SetActive(false)
  else
    if self.has_max_txt_obj then
      self.has_max_txt_obj:SetActive(false)
    end
    self.next_recover_txt.gameObject:SetActive(true)
    self.next_recover_txt:SetText(nextStr)
  end
  local allStr = StringTable.Get("str_get_phy_point_all_recover") .. self:Time2Str(self._allTimeNum)
  if self._allTimeNum == 0 then
    allStr = StringTable.Get("str_get_phy_point_topmax_tips")
    if self.has_max_txt_obj then
      self.has_max_txt_obj:SetActive(true)
    end
    self.all_recover_txt.gameObject:SetActive(false)
  else
    if self.has_max_txt_obj then
      self.has_max_txt_obj:SetActive(false)
    end
    self.all_recover_txt.gameObject:SetActive(true)
    self.all_recover_txt:SetText(allStr)
  end
  if self._showTimeEvent then
    GameGlobal.RealTimer():CancelEvent(self._showTimeEvent)
    self._showTimeEvent = nil
  end
  self._showTimeEvent = GameGlobal.RealTimer():AddEventTimes(1000, TimerTriggerCount.Infinite, self.ShowTime, self)
  self:UnLock("OnOpenPhyTimer")
end

function UIGetPhyPointController:ClosePhyTimer()
  if self._showTimeEvent then
    GameGlobal.RealTimer():CancelEvent(self._showTimeEvent)
    self._showTimeEvent = nil
  end
  if self._phyEvent then
    GameGlobal.RealTimer():CancelEvent(self._phyEvent)
    self._phyEvent = nil
  end
end

function UIGetPhyPointController:ShowTime()
  self._nextTimeNum = self._nextTimeNum - 1
  self._allTimeNum = self._allTimeNum - 1
  if self._nextTimeNum < 0 then
    self._nextTimeNum = self._gapTimeNum - 1
    if self._allTimeNum > 0 then
      self.checkServerPhyTask = GameGlobal.TaskManager():StartTask(self.CheckServerPhy, self)
    end
  end
  if self._allTimeNum < 0 then
    self._allTimeNum = 0
    self:ShowPhyPoint()
    if self._showTimeEvent then
    end
  end
  if self._allTimeNum > 0 and self.needCheck then
    GameGlobal.TaskManager():StartTask(self.CheckServerTime, self)
  end
  local currentPhyPower = self._roleModule:GetHealthPoint()
  if currentPhyPower == nil then
    currentPhyPower = 0
  end
  local currentPhysicalPowerUpper = self._roleModule:GetHpLevelMax()
  if currentPhysicalPowerUpper == nil then
    currentPhysicalPowerUpper = 0
  end
  if currentPhyPower > currentPhysicalPowerUpper then
    self._nextTimeNum = 0
    self._allTimeNum = 0
  end
  local nextStr = StringTable.Get("str_get_phy_point_next_recover") .. self:Time2Str(self._nextTimeNum)
  if self._allTimeNum == 0 then
    nextStr = StringTable.Get("str_get_phy_point_topmax_tips")
    if self.has_max_txt_obj then
      self.has_max_txt_obj:SetActive(true)
    end
    self.next_recover_txt.gameObject:SetActive(false)
  else
    if self.has_max_txt_obj then
      self.has_max_txt_obj:SetActive(false)
    end
    self.next_recover_txt.gameObject:SetActive(true)
    self.next_recover_txt:SetText(nextStr)
  end
  local allStr = StringTable.Get("str_get_phy_point_all_recover") .. self:Time2Str(self._allTimeNum)
  if self._allTimeNum == 0 then
    allStr = StringTable.Get("str_get_phy_point_topmax_tips")
    if self.has_max_txt_obj then
      self.has_max_txt_obj:SetActive(true)
    end
    self.all_recover_txt.gameObject:SetActive(false)
  else
    if self.has_max_txt_obj then
      self.has_max_txt_obj:SetActive(false)
    end
    self.all_recover_txt.gameObject:SetActive(true)
    self.all_recover_txt:SetText(allStr)
  end
  self:RefreshItemSec()
end

function UIGetPhyPointController:CheckServerTime(TT)
  Log.debug("[fx]UIGetPhyPointController  CheckServerTime")
  self.needCheck = false
  self:Lock("CheckServerTime")
  local res, startTime, intervalRecoverTime, leftRecoverTime, allRecoverTime = self._roleModule:GetRecoverData(TT, 0)
  if not res:GetSucc() then
    Log.fatal("### request fail -- self._roleModule:GetRecoverData !")
    return
  end
  self._nextTimeNum = leftRecoverTime
  self._allTimeNum = allRecoverTime
  self:ShowPhyPoint()
  self:UnLock("CheckServerTime")
  YIELD(TT, 5000)
  self.needCheck = true
end

function UIGetPhyPointController:CheckServerPhy(TT)
  Log.debug("[fx]UIGetPhyPointController  CheckServerPhy")
  self:Lock("CheckServerPhy")
  local req = self._shopModule:RequestPhysicalData(TT)
  if req:GetSucc() then
    YIELD(TT)
    self:OnItemCountChange()
    self:RefreshPoolsBtn()
    self:ShowPhyPoint()
    self:UnLock("CheckServerPhy")
  else
    YIELD(TT)
    self:OnItemCountChange()
    self:RefreshPoolsBtn()
    self:ShowPhyPoint()
    self:UnLock("CheckServerPhy")
  end
end

function UIGetPhyPointController:Time2Str(time)
  local str = ""
  local timeTab = self:ChangeSecondToTime(time)
  str = self:ChangeTimeTableToStr(timeTab)
  return str
end

function UIGetPhyPointController:ChangeTimeTableToStr(timeTable)
  local hourStr, minStr, secStr
  if timeTable.hour > 9 then
    hourStr = timeTable.hour
  else
    hourStr = "0" .. timeTable.hour
  end
  if 9 < timeTable.min then
    minStr = timeTable.min
  else
    minStr = "0" .. timeTable.min
  end
  if 9 < timeTable.sec then
    secStr = timeTable.sec
  else
    secStr = "0" .. timeTable.sec
  end
  return hourStr .. ":" .. minStr .. ":" .. secStr
end

function UIGetPhyPointController:ChangeSecondToTime(second)
  local timeTable = {
    hour = 0,
    min = 0,
    sec = 0
  }
  if second == 0 then
    return timeTable
  end
  local sec = math.modf(second % 60)
  local minAll = math.modf((second - sec) / 60)
  local min = math.modf(minAll % 60)
  local hour = math.modf((minAll - min) / 60)
  timeTable.hour = hour
  timeTable.min = min
  timeTable.sec = sec
  return timeTable
end

local SelectModType = {
  Get = 0,
  Use = 1,
  Decore = 2
}
_enum("SelectModType", SelectModType)

function UIGetPhyPointController:LockPhyRoomRefreshGetPanel()
  self.phy_get_panel:SetActive(false)
end

function UIGetPhyPointController:UnLockPhyRoomRefreshGetPanel()
end

function UIGetPhyPointController:RefreshPoolsBtn()
  if not self._active then
    return
  end
  self.recoverRoot:SetActive(false)
  self.useRoot:SetActive(false)
  self.decoreRoot:SetActive(false)
  if self.CurSelectModType == SelectModType.Get then
    self.recoverRoot:SetActive(true)
  elseif self.CurSelectModType == SelectModType.Use then
    self.useRoot:SetActive(true)
  elseif self.CurSelectModType == SelectModType.Decore then
    self.decoreRoot:SetActive(true)
  end
  self:InitGetPanel()
  self:InitUsePanel()
  self:InitDecorePanel()
  self:ShowPhyPoint()
end

function UIGetPhyPointController:ShowPhyPoint()
  local currentPhyPower = self._roleModule:GetHealthPoint()
  if currentPhyPower == nil then
    currentPhyPower = 0
  end
  local currentPhysicalPowerUpper = self._roleModule:GetHpLevelMax()
  if currentPhysicalPowerUpper == nil then
    currentPhysicalPowerUpper = 0
  end
  local moreThan = false
  if currentPhyPower > currentPhysicalPowerUpper then
    moreThan = true
  end
  if 999 < currentPhyPower then
    currentPhyPower = "999+"
  end
  if moreThan then
  end
  if self.recodePhyP ~= nil and currentPhyPower > self.recodePhyP then
    self.newCenterAnim:Play("uianim_UIGetPhyPointController_add")
    self.effectObj:SetActive(false)
    self.effectObj:SetActive(true)
  end
  self.cur_have_phy_txt:SetText(currentPhyPower .. "/" .. currentPhysicalPowerUpper)
  self.recodePhyP = currentPhyPower
  local phy = self.aircraftModule:GetPhysicStorage()
  local max = self.aircraftModule:GetPhysicStorageLimit()
  local ceiling = math.floor(max)
  local curPhy = math.floor(phy)
  self.air_phy_txt:SetText(curPhy .. "/" .. ceiling)
  self.calcuPhy = curPhy
end

local toint = math.tointeger

function UIGetPhyPointController:InitGetPanel()
  local phy = math.floor(self.aircraftModule:GetPhysicStorage())
  local curGetPhy = phy
  local currentPhyPower = self._roleModule:GetHealthPoint()
  if currentPhyPower == nil then
    currentPhyPower = 0
  end
  local currentPhysicalPowerUpper = self._roleModule:GetHpLevelMax()
  if currentPhysicalPowerUpper == nil then
    currentPhysicalPowerUpper = 0
  end
  local delta = currentPhysicalPowerUpper - currentPhyPower
  if phy > delta then
    curGetPhy = delta
  end
  local percentValue = curGetPhy / phy
  local cfg_item = Cfg.cfg_item[RoleAssetID.RoleAssetPhyPoint]
  local name = StringTable.Get(cfg_item.Name)
  local tips = StringTable.Get("str_get_phy_point_reply_succ_tips", name, 0)
  self.calcuPhy = math.floor(phy)
end

function UIGetPhyPointController:InitUsePanel()
  local left_count_now = 0
  local allValid = self._shopModule:GetCurExchangePhyValidLeftState()
  local targetAllValid = allValid[1]
  local getSuc = false
  for _, value in pairs(allValid) do
    left_count_now = left_count_now + self._roleModule:GetAssetCount(value.cost_id)
    if not getSuc and 0 < left_count_now then
      targetAllValid = value
      getSuc = true
    end
  end
  if allValid == nil then
    self.can_use_by_day_txt.transform.parent.gameObject:SetActive(false)
    return
  end
  if targetAllValid == nil then
    self.can_use_by_day_txt.transform.parent.gameObject:SetActive(false)
    return
  end
  if not self:CheckHasTimeBack(allValid) then
    self.can_use_by_day_txt.transform.parent.gameObject:SetActive(false)
    return
  end
  local itemId = targetAllValid.cost_id
  local cfg_item = Cfg.cfg_item[itemId]
  if not cfg_item then
    Log.error("###[fx] cfg is nil ! id --> ", itemId)
  end
  self._lessTimeStr = cfg_item.DeadTime
  if string.isnullorempty(self._lessTimeStr) then
    self._lessTimeStr = cfg_item.CompulsiveDeadTime
  end
  self._isTimeItem = true
  if string.isnullorempty(self._lessTimeStr) then
    self._isTimeItem = false
  end
  if self._isTimeItem then
    self.can_use_by_day_txt.transform.parent.gameObject:SetActive(true)
    self._timeType = Enum_DateTimeZoneType.E_ZoneType_GMT
    local lessTime = math.floor(self._loginModule:GetTimeStampByTimeStr(self._lessTimeStr, self._timeType))
    local nowTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
    local gapTime = lessTime - nowTime
    if 0 < gapTime then
      local timeTex = self:Time2Tex(gapTime)
      self.can_use_by_day_txt:SetText(timeTex)
    else
      self.can_use_by_day_txt:SetText("已过期")
    end
  else
    self.can_use_by_day_txt.transform.parent.gameObject:SetActive(false)
  end
  self.can_use_num_count_txt:SetText(left_count_now)
end

function UIGetPhyPointController:CheckHasTimeBack(allValid)
  for i = 1, #allValid do
    local item = allValid[i]
    if item ~= nil then
      local leftPower = self._roleModule:GetAssetCount(item.cost_id)
      if 0 < leftPower then
        return true
      end
    end
  end
  return false
end

function UIGetPhyPointController:Time2Tex(sec)
  local timeStr = ""
  local minAll = sec // 60
  local min = minAll % 60
  local hourAll = minAll // 60
  local hour = hourAll % 24
  local day = hourAll // 24
  if day and 0 < day then
    if hour and 0 < hour then
      timeStr = StringTable.Get("str_week_tower_reset_time_day", day + 1)
    else
      timeStr = StringTable.Get("str_week_tower_reset_time_day", day)
    end
    return timeStr
  end
  if hour and 0 < hour then
    if min and 0 < min then
      timeStr = StringTable.Get("str_week_tower_reset_time_hour", hour + 1)
    else
      timeStr = StringTable.Get("str_week_tower_reset_time_hour", hour)
    end
    return timeStr
  end
  if min and 0 < min then
    timeStr = StringTable.Get("str_week_tower_reset_time_only_min", min + 1)
    return timeStr
  end
  timeStr = StringTable.Get("str_week_tower_reset_time_only_sec")
  return timeStr
end

function UIGetPhyPointController:RefreshItemSec()
  self:InitUsePanel()
end

function UIGetPhyPointController:InitDecorePanel()
  self._left_data, self._right_data = self._shopModule:GetCurExchangePhyState()
  self._right_cost_id = self._right_data.cost_id
  self._right_cost_count = self._right_data.cost_count
  self._right_reply_count = self._right_data.add_phy_count
  local allValid = self._shopModule:GetCurExchangePhyValidLeftState()
  for _, value in ipairs(allValid) do
    if self._roleModule:GetAssetCount(value.cost_id) > 0 then
      self._left_data = value
      break
    end
  end
  local right_have_count = self._roleModule:GetAssetCount(self._right_cost_id)
  self._right_reply_count = self._right_data.add_phy_count
  local get_count = self._right_reply_count
  local right_cost_str = 0
  if right_have_count < self._right_cost_count then
    right_cost_str = "<color=#CC0000>" .. self._right_cost_count .. "</color>"
  else
    right_cost_str = self._right_cost_count
  end
  local tips = StringTable.Get("str_get_phy_point_decore_tips", right_cost_str, get_count)
  self.cost_light_cont_txt:SetText("x" .. right_cost_str)
  self.can_get_phy_cont_txt:SetText("x" .. get_count)
end

function UIGetPhyPointController:GetPanelClick()
  if self.aircraftModule:GetRoomByRoomType(AirRoomType.PrismRoom) == nil then
    return
  end
  self.CurSelectModType = SelectModType.Get
  self:RefreshPoolsBtn()
end

function UIGetPhyPointController:UsePanelClick()
  self.CurSelectModType = SelectModType.Use
  self:RefreshPoolsBtn()
end

function UIGetPhyPointController:DecorePanelClick()
  self.CurSelectModType = SelectModType.Decore
  self:RefreshPoolsBtn()
end

function UIGetPhyPointController:Quick_use_ButtonOnClick()
  self:left_btnOnClick()
end

function UIGetPhyPointController:Quick_decore_ButtonOnClick()
  self:right_btnOnClick()
end

function UIGetPhyPointController:Quick_get_ButtonOnClick()
  if self.calcuPhy > 0 then
    GameGlobal.TaskManager():StartTask(self._GetPhy, self)
  else
    ToastManager.ShowToast(StringTable.Get("str_get_phy_point_un_get"))
  end
end

function UIGetPhyPointController:_GetPhy(TT)
  self:Lock("UIGetPhyPointController_GetPhy")
  local phyCount = self.calcuPhy
  local res, reply = self.aircraftModule:HandleCEventCollectPrism(TT, self.calcuPhy)
  if res:GetSucc() then
    YIELD(TT)
    Log.debug("GetSuccess")
    self:RefreshPoolsBtn()
    local cfg_item = Cfg.cfg_item[RoleAssetID.RoleAssetPhyPoint]
    local name = StringTable.Get(cfg_item.Name)
    local tips = StringTable.Get("str_get_phy_point_reply_succ_tips", name, phyCount)
    ToastManager.ShowToast(tips)
  else
    ToastManager.ShowToast(self.aircraftModule:GetErrorMsg(res:GetResult()))
  end
  self:UnLock("UIGetPhyPointController_GetPhy")
end

function UIGetPhyPointController:Use_subOnClick()
  self:Left_subClick()
end

function UIGetPhyPointController:Use_addOnClick()
  self:Left_addClick()
end

function UIGetPhyPointController:Today_tips_btnOnClick()
  self:ShowDialog("UIGetPhyPointTipsController", self._right_data)
end

function UIGetPhyPointController:CloseButtonOnClick()
  self:bgOnClick()
end

function UIGetPhyPointController:OnUpdate(deltaTimeMS)
  if not self.loadSuc then
    return
  end
  self._updateTime = self._updateTime + deltaTimeMS
  if self._updateTime > self._pressTime then
    self._updateTime = self._updateTime - self._pressTime
    if self._isAddMouseDown then
      self:Left_addClick()
    end
    if self._isSubMouseDown then
      self:Left_subClick()
    end
  end
  if self.aircaftPhy ~= nil then
    local phy = math.floor(self.aircraftModule:GetPhysicStorage())
    if self.aircaftPhy ~= phy then
      self:RefreshPoolsBtn()
      self.aircaftPhy = phy
    end
  end
  local right_have_count = self._roleModule:GetAssetCount(self._right_cost_id)
  local right_cost_str = 0
  if right_have_count < self._right_cost_count then
    right_cost_str = "<color=#CC0000>" .. self._right_cost_count .. "</color>"
  else
    right_cost_str = self._right_cost_count
  end
  self.cost_light_cont_txt:SetText("x" .. right_cost_str)
end

function UIGetPhyPointController:_OnValue()
  self._left_data, self._right_data = self._shopModule:GetCurExchangePhyState()
  local allValid = self._shopModule:GetCurExchangePhyValidLeftState()
  for _, value in ipairs(allValid) do
    if self._roleModule:GetAssetCount(value.cost_id) > 0 then
      self._left_data = value
      break
    end
  end
  self._leftCostID = self._left_data.cost_id
  if not self._leftCostID then
    Log.fatal("###[UIGetPhyPointController] self._leftCostID is nil !")
  end
  local cfg_item = Cfg.cfg_item[self._leftCostID]
  if not cfg_item then
    Log.fatal("###[UIGetPhyPointController] cfg_item is nil ! id --> ", self._leftCostID)
  end
  local left_count_now = 0
  for _, value in pairs(allValid) do
    left_count_now = left_count_now + self._roleModule:GetAssetCount(value.cost_id)
  end
  self._left_cost_count = self._left_data.cost_count
  local left_cost_str
  if left_count_now < self._left_cost_count then
    left_cost_str = "<color=#CC0000>" .. 0 .. "</color>"
  else
    left_cost_str = self._left_cost_count
  end
  self.left_use_count:SetText(left_cost_str)
  self._left_add = self._left_data.add_phy_count
  local addstr = self._left_add
  local str = "<color=#dfb677>" .. StringTable.Get("str_get_phy_point_use_somethine_count", addstr) .. "</color>"
  if left_count_now == 0 then
    str = "<color=#CC0000>" .. StringTable.Get("str_get_phy_point_use_somethine_count", 0) .. "</color>"
  end
  self.use_count_txt:SetText(str)
  local current_phy_point = self._roleModule:GetAssetCount(RoleAssetID.RoleAssetPhyPoint)
  local current_phy_point_str
  if 999 < current_phy_point then
    current_phy_point_str = "999+"
  elseif current_phy_point < 0 then
    current_phy_point_str = "0"
  else
    current_phy_point_str = current_phy_point
  end
  local left_after_phy_point = current_phy_point + self._left_add
  local left_after_phy_point_str
  if 999 < left_after_phy_point then
    left_after_phy_point_str = "999+"
  elseif left_after_phy_point < 0 then
    left_after_phy_point_str = "0"
  else
    left_after_phy_point_str = left_after_phy_point
  end
  local left_dead_time = cfg_item.DeadTime
  if string.isnullorempty(left_dead_time) then
    left_dead_time = cfg_item.CompulsiveDeadTime
  end
  if not string.isnullorempty(left_dead_time) then
    local loginModule = self:GetModule(LoginModule)
    local time = loginModule:GetTimeStampByTimeStr(left_dead_time, Enum_DateTimeZoneType.E_ZoneType_GMT)
    local deltaTime = time - GetSvrTimeNow()
    if 0 < deltaTime then
      if self._refreshTimer then
        GameGlobal.Timer():CancelEvent(self._refreshTimer)
      end
      self._refreshTimer = GameGlobal.Timer():AddEvent(deltaTime * 1000, function()
        self:StartTask(self._RequestAndRefresh, self)
      end)
    end
  end
  self._getTimes = self._right_data.max_times - self._right_data.cur_times
  local getTimesMax = self._right_data.max_times
  self._right_cost_id = self._right_data.cost_id
  if not self._right_cost_id then
    Log.fatal("###[UIGetPhyPointController] self._right_cost_id is nil !")
  end
  self._right_cost_count = self._right_data.cost_count
  self._right_reply_count = self._right_data.add_phy_count
  local cfg_item_right = Cfg.cfg_item[self._right_cost_id]
  if not cfg_item_right then
    Log.fatal("###[UIGetPhyPointController] cfg_item_right is nil ! id --> ", self._right_cost_id)
  end
  local getTimesStr
  if 0 >= self._getTimes then
    getTimesStr = "<color=#CC0000>" .. self._getTimes .. "</color>"
  else
    getTimesStr = self._getTimes
  end
  local _right_tips = getTimesStr .. "/" .. getTimesMax
  self.today_can_tip:SetText(StringTable.Get("str_get_phy_point_today_bug_times", _right_tips))
  local right_have_count = self._roleModule:GetAssetCount(self._right_cost_id)
  local right_cost_str
  if right_have_count < self._right_cost_count then
    right_cost_str = "<color=#CC0000>" .. self._right_cost_count .. "</color>"
  else
    right_cost_str = self._right_cost_count
  end
  local right_after_phy_point = current_phy_point + self._right_reply_count
  local right_after_phy_point_str
  if 999 < right_after_phy_point then
    right_after_phy_point_str = "999+"
  elseif right_after_phy_point < 0 then
    right_after_phy_point_str = "0"
  else
    right_after_phy_point_str = right_after_phy_point
  end
  self:RefreshPoolsBtn()
end

function UIGetPhyPointController:OnItemCountChange()
  local left_count_now = self._roleModule:GetAssetCount(self._leftCostID)
  local left_cost_str
  if left_count_now < self._left_cost_count then
    left_cost_str = "<color=#CC0000>" .. 0 .. "</color>"
  else
    left_cost_str = self._left_cost_count
  end
  self.left_use_count:SetText(left_cost_str)
  local right_have_count = self._roleModule:GetAssetCount(self._right_cost_id)
  local right_cost_str
  if right_have_count < self._right_cost_count then
    right_cost_str = "<color=#CC0000>" .. self._right_cost_count .. "</color>"
  else
    right_cost_str = self._right_cost_count
  end
end

function UIGetPhyPointController:bgOnClick()
  if self._active then
    if self.rootAnim:IsPlaying("uieff_UIGetPhyPointController_in") then
      Log.debug("###[UIGetPhyPointController]  uieff_UIGetPhyPointController_in is playing please close after!")
      return
    end
    if self.rootAnim:IsPlaying("uieff_UIGetPhyPointController_out") then
      Log.debug("###[UIGetPhyPointController]  uieff_UIGetPhyPointController_out is playing please close after!")
      return
    end
    self.rootAnim:Play("uieff_UIGetPhyPointController_out")
    GameGlobal.RealTimer():AddEvent(200, function()
      self:CloseDialog()
    end)
  end
end

function UIGetPhyPointController:right_tips_btnOnClick()
  self:ShowDialog("UIGetPhyPointTipsController", self._right_data)
end

function UIGetPhyPointController:right_btnOnClick()
  local hasCount = self._roleModule:GetAssetCount(self._right_cost_id)
  if hasCount < self._right_cost_count then
    self:ShowDialog("UIShopCurrency1To2", self._right_cost_count - hasCount)
    return
  end
  if self._getTimes <= 0 then
    local tips = StringTable.Get("str_get_phy_point_bug_times_nil")
    ToastManager.ShowToast(tips)
    return
  end
  self._bugState = ExchangePhyPointType.EPPT_RIGHT
  local costId = self._right_cost_id
  local costCount = self._right_cost_count
  local replyId = RoleAssetID.RoleAssetPhyPoint
  local replyCount = self._right_reply_count
  self:TipsToast(costId, costCount, replyId, replyCount, 0, 0)
end

function UIGetPhyPointController:left_btnOnClick()
  local left_count_now = 0
  local allValid = self._shopModule:GetCurExchangePhyValidLeftState()
  for _, value in pairs(allValid) do
    left_count_now = left_count_now + self._roleModule:GetAssetCount(value.cost_id)
  end
  local not_expire_count = self._roleModule:GetAssetCount(3400043)
  local other_count = left_count_now - not_expire_count
  if left_count_now < self._left_cost_count then
    local cfg_item_cost = Cfg.cfg_item[self._leftCostID]
    local costName = StringTable.Get(cfg_item_cost.Name)
    local cfg_item_get = Cfg.cfg_item[RoleAssetID.RoleAssetPhyPoint]
    local getName = StringTable.Get(cfg_item_get.Name)
    local tips = StringTable.Get("str_get_phy_point_mat_not_enough", costName, getName)
    ToastManager.ShowToast(tips)
    local str = "<color=#CC0000>" .. StringTable.Get("str_get_phy_point_use_somethine_count", 0) .. "</color>"
    self.use_count_txt:SetText(str)
    self.can_use_num_count_txt:SetText(left_count_now)
    self.left_use_count:SetText("<color=#CC0000>" .. 0 .. "</color>")
    return
  end
  if allValid[1] ~= nil then
    local itemId = allValid[1].cost_id
    local cfg_item = Cfg.cfg_item[itemId]
    if not cfg_item then
      Log.error("###[fx] cfg is nil ! id --> ", itemId)
    end
    self._lessTimeStr = cfg_item.DeadTime
    if string.isnullorempty(self._lessTimeStr) then
      self._lessTimeStr = cfg_item.CompulsiveDeadTime
    end
    self._isTimeItem = true
    if string.isnullorempty(self._lessTimeStr) then
      self._isTimeItem = false
    end
    if self._isTimeItem then
      self._timeType = Enum_DateTimeZoneType.E_ZoneType_GMT
      local lessTime = math.floor(self._loginModule:GetTimeStampByTimeStr(self._lessTimeStr, self._timeType))
      local nowTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
      local gapTime = lessTime - nowTime
      if gapTime < 0 then
        local tips = StringTable.Get("str_get_phy_point_phy_out")
        ToastManager.ShowToast(tips)
        GameGlobal.TaskManager():StartTask(self.ItemTimeOutRefresh, self)
        return
      end
    end
  end
  self._bugState = ExchangePhyPointType.EPPT_LEFT
  local costId = self._leftCostID
  local costCount = self._left_cost_count
  local replyId = RoleAssetID.RoleAssetPhyPoint
  local replyCount = self._left_add
  self:TipsToast(costId, costCount, replyId, replyCount, not_expire_count, other_count)
end

function UIGetPhyPointController:ItemTimeOutRefresh(TT)
  local req = self._shopModule:RequestPhysicalData(TT)
  if req:GetSucc() then
    YIELD(TT)
    self:RefreshPoolsBtn()
    local left_count_now = 0
    local allValid = self._shopModule:GetCurExchangePhyValidLeftState()
    for _, value in pairs(allValid) do
      left_count_now = left_count_now + self._roleModule:GetAssetCount(value.cost_id)
    end
    if left_count_now < self._left_cost_count then
      local str = "<color=#CC0000>" .. StringTable.Get("str_get_phy_point_use_somethine_count", 0) .. "</color>"
      self.use_count_txt:SetText(str)
      self.can_use_num_count_txt:SetText(left_count_now)
      self.left_use_count:SetText("<color=#CC0000>" .. 0 .. "</color>")
    end
  else
    YIELD(TT)
    self:RefreshPoolsBtn()
  end
end

function UIGetPhyPointController:TipsToast(cId, cCount, rId, rCount, nCount, oCount)
  local type = self._bugState
  local current_phy_point = self._roleModule:GetAssetCount(RoleAssetID.RoleAssetPhyPoint)
  if current_phy_point + rCount >= self._bugMaxCount then
    local cfg_item = Cfg.cfg_item[RoleAssetID.RoleAssetPhyPoint]
    local name = StringTable.Get(cfg_item.Name)
    local tips = StringTable.Get("str_get_phy_point_reply_fail_more_than", name)
    ToastManager.ShowToast(tips)
    return
  end
  local cfg_item_cost = Cfg.cfg_item[cId]
  local costName = StringTable.Get(cfg_item_cost.Name)
  local cfg_item_reply = Cfg.cfg_item[rId]
  local replyName = StringTable.Get(cfg_item_reply.Name)
  local cfg_item_not_expire = Cfg.cfg_item[3400043]
  local not_expire_name = StringTable.Get(cfg_item_not_expire.Name)
  local tips = StringTable.Get("str_get_phy_point_bug_toast_tips", cCount, costName, rCount, replyName)
  if type == 1 and oCount < cCount and nCount ~= 0 and oCount ~= 0 then
    tips = StringTable.Get("str_get_phy_point_bug_toast_another_tips", oCount, cCount - oCount, not_expire_name, rCount, replyName)
  end
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", tips, function(param)
    self:Lock("UIGetPhyPointController:TipsToast")
    GameGlobal.TaskManager():StartTask(self.OnTipsToast, self, param)
  end, rCount, function(param)
    Log.debug("###[UIGetPhyPointController]TipsToast cancel ..")
  end, nil)
end

function UIGetPhyPointController:OnTipsToast(TT, param)
  local p = self._bugState
  local count = self._left_cost_count
  if p == 2 then
    count = 0
  end
  local res = self._shopModule:BuyPhysicalPower(TT, p, count)
  if res:GetSucc() then
    local cfg_item = Cfg.cfg_item[RoleAssetID.RoleAssetPhyPoint]
    local name = StringTable.Get(cfg_item.Name)
    local tips = StringTable.Get("str_get_phy_point_reply_succ_tips", name, param)
    ToastManager.ShowToast(tips)
    self._shopModule:RequestPhysicalData(TT)
    self:_OnValue()
    self:UnLock("UIGetPhyPointController:TipsToast")
  else
    local result = res:GetResult()
    Log.error("###[UIGetPhyPointController] OnTipsToast fail -- result --> ", result)
    local tips = StringTable.Get("str_get_phy_point_reply_fail_error_code") .. " - " .. result
    ToastManager.ShowToast(tips)
    self:UnLock("UIGetPhyPointController:TipsToast")
  end
end

function UIGetPhyPointController:_RequestAndRefresh(TT)
  self:Lock("UIGetPhyPointController:_RequestAndRefresh")
  local req = self._shopModule:RequestPhysicalData(TT)
  self:UnLock("UIGetPhyPointController:_RequestAndRefresh")
  if not self._active then
    return
  end
  if req:GetSucc() then
    self:_OnValue()
  else
    Log.error("###[UIGetPhyPointController] request refresh error:", req:GetResult())
  end
end

function UIGetPhyPointController:Left_addClick()
  if self._left_cost_count > 999 then
    return
  end
  local current_phy_point = self._roleModule:GetAssetCount(RoleAssetID.RoleAssetPhyPoint)
  if 999 < current_phy_point + self._left_add then
    return
  end
  local left_cost_str
  local left_count_now = 0
  local allValid = self._shopModule:GetCurExchangePhyValidLeftState()
  for _, value in pairs(allValid) do
    left_count_now = left_count_now + self._roleModule:GetAssetCount(value.cost_id)
  end
  if left_count_now < self._left_cost_count + 1 then
    return
  end
  self._left_cost_count = self._left_cost_count + 1
  left_cost_str = self._left_cost_count
  self.left_use_count:SetText(left_cost_str)
  self:LeftValueChange()
end

function UIGetPhyPointController:Left_subClick()
  if self._left_cost_count <= 1 then
    return
  end
  local left_cost_str
  local left_count_now = 0
  local allValid = self._shopModule:GetCurExchangePhyValidLeftState()
  for _, value in pairs(allValid) do
    left_count_now = left_count_now + self._roleModule:GetAssetCount(value.cost_id)
  end
  self._left_cost_count = self._left_cost_count - 1
  if left_count_now < self._left_cost_count then
    left_cost_str = "<color=#CC0000>" .. self._left_cost_count .. "</color>"
  else
    left_cost_str = self._left_cost_count
  end
  self.left_use_count:SetText(left_cost_str)
  self:LeftValueChange()
end

function UIGetPhyPointController:LeftValueChange()
  self._left_add = self._left_data.add_phy_count * self._left_cost_count
  local addstr = self._left_add
  local str = "<color=#dfb677>" .. StringTable.Get("str_get_phy_point_use_somethine_count", addstr) .. "</color>"
  self.use_count_txt:SetText(str)
  local current_phy_point = self._roleModule:GetAssetCount(RoleAssetID.RoleAssetPhyPoint)
  local left_after_phy_point = current_phy_point + self._left_add
  local left_after_phy_point_str
  if 999 < left_after_phy_point then
    left_after_phy_point_str = "999+"
  elseif left_after_phy_point < 0 then
    left_after_phy_point_str = "0"
  else
    left_after_phy_point_str = left_after_phy_point
  end
end
