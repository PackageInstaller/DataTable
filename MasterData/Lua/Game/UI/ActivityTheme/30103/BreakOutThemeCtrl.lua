local BaseCtrl = require("GameCore.UI.BaseCtrl")
local BreakOutThemeCtrl = class("BreakOutThemeCtrl", BaseCtrl)
local ClientManager = CS.ClientManager.Instance
local TimerManager = require("GameCore.Timer.TimerManager")
BreakOutThemeCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  BreakOutLevelSelectPanel = {
    sNodeName = "----BreakOutLevelSelect----",
    sCtrlName = "Game.UI.Play_BreakOut_30101.LevelSelectCtrl"
  },
  imgProgressBg = {
    sNodeName = "imgProgressBg"
  },
  txt_Target = {
    sNodeName = "txt_Target",
    sComponentName = "TMP_Text",
    sLanguageId = "ChallengingGoals"
  },
  imgFill = {sNodeName = "imgFill"},
  txtProgress = {
    sNodeName = "txtProgress",
    sComponentName = "TMP_Text"
  },
  TaskActivityTime = {},
  txtTaskActivityTime = {
    sNodeName = "txtTaskActivityTime",
    sComponentName = "TMP_Text"
  },
  TaskMask = {},
  txt_TaskEnd = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_End"
  },
  ShopActivityTime = {},
  txt_Shop = {
    sComponentName = "TMP_Text",
    sLanguageId = "ExchangeShop"
  },
  txtShopActivityTime = {
    sNodeName = "txtShopActivityTime",
    sComponentName = "TMP_Text"
  },
  btnEntrance_ = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtn_ClickActivityEntrance"
  },
  redDotEntrance2 = {}
}
BreakOutThemeCtrl._mapEventConfig = {
  JumpToLevelDetail = "JumpTo_LevelDetail",
  SetAnimatorState = "SetAnimatorState"
}
BreakOutThemeCtrl._mapRedDotConfig = {}
local ActivityState = {
  NotOpen = 1,
  Open = 2,
  Closed = 3
}

function BreakOutThemeCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
  end
  self.BreakOut_30101Data = PlayerData.Activity:GetActivityGroupDataById(self.nActId)
  if self.BreakOut_30101Data == nil then
    printError("活动组 id:" .. self.nActId .. " 数据为空")
    return
  else
    self.ActivityGroupCfg = self.BreakOut_30101Data.actGroupConfig
  end
  self.isLevelEnd = false
end

function BreakOutThemeCtrl:OnEnable()
  self.BreakOutTheme_Animator = self.gameObject:GetComponent("Animator")
  if self.BreakOut_30101Data == nil then
    printError("活动组 id:" .. self.nActId .. " 数据为空")
    return
  end
  self:RefreshPanel()
  for i = 1, 5 do
    local actData = self.BreakOut_30101Data:GetActivityDataByIndex(i)
    if actData ~= nil and i == AllEnum.ActivityThemeFuncIndex.Task then
      local nActId = actData.ActivityId
      RedDotManager.RegisterNode(RedDotDefine.Activity_Group_Task, {
        self.nActId,
        nActId
      }, self._mapNode.redDotEntrance2)
    end
  end
  self:SetAnimatorState()
end

function BreakOutThemeCtrl:OnDisable()
  if nil ~= self.remainTimer then
    TimerManager.Remove(self.remainTimer)
    self.remainTimer = nil
  end
  if nil ~= self.shopRemainTimer then
    TimerManager.Remove(self.shopRemainTimer)
    self.shopRemainTimer = nil
  end
  if nil ~= self.avgRemainTimer then
    TimerManager.Remove(self.avgRemainTimer)
    self.avgRemainTimer = nil
  end
  if nil ~= self.taskRemainTimer then
    TimerManager.Remove(self.taskRemainTimer)
    self.taskRemainTimer = nil
  end
end

function BreakOutThemeCtrl:RefreshPanel()
  if self.BreakOut_30101Data == nil or self.ActivityGroupCfg == nil then
    return
  end
  self:RefreshTime()
  self:RefreshButtonState()
end

function BreakOutThemeCtrl:RefreshTime()
  local bOpen = self.BreakOut_30101Data:CheckActivityGroupOpen()
  if bOpen then
    self:RefreshRemainTime(self.BreakOut_30101Data:GetActGroupEndTime(), self._mapNode.txtActivityTime)
    if nil == self.remainTimer then
      self.remainTimer = self:AddTimer(0, 1, function()
        local remainTime = self:RefreshRemainTime(self.BreakOut_30101Data:GetActGroupEndTime(), self._mapNode.txtActivityTime)
        if remainTime <= 0 then
          TimerManager.Remove(self.remainTimer)
          self.remainTimer = nil
        end
      end, true, true, false)
    end
  end
end

function BreakOutThemeCtrl:RefreshRemainTime(endTime, txtComp)
  local curTime = ClientManager.serverTimeStamp
  local remainTime = endTime - curTime
  local sTimeStr = ""
  if remainTime <= 60 then
    local sec = math.floor(remainTime)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Sec") or "", sec)
  elseif 60 < remainTime and remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    local sec = math.floor(remainTime - min * 60)
    if sec == 0 then
      min = min - 1
      sec = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Min") or "", min, sec)
  elseif 3600 < remainTime and remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    local min = math.floor((remainTime - hour * 3600) / 60)
    if min == 0 then
      hour = hour - 1
      min = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Hour") or "", hour, min)
  elseif 86400 < remainTime then
    local day = math.floor(remainTime / 86400)
    local hour = math.floor((remainTime - day * 86400) / 3600)
    if hour == 0 then
      day = day - 1
      hour = 24
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Day") or "", day, hour)
  end
  NovaAPI.SetTMPText(txtComp, sTimeStr)
  return remainTime
end

function BreakOutThemeCtrl:RefreshRemainOpenTime(openTime)
  local curTime = ClientManager.serverTimeStamp
  local remainTime = openTime - curTime
  local sTimeStr = ""
  if remainTime <= 60 then
    local sec = math.floor(remainTime)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Open_Time_Sec") or "", sec)
  elseif 60 < remainTime and remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Open_Time_Min") or "", min)
  elseif 3600 < remainTime and remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Open_Time") or "", hour)
  elseif 86400 < remainTime then
    local day = math.floor(remainTime / 86400)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Open_Time_Day") or "", day)
  end
  return sTimeStr
end

function BreakOutThemeCtrl:RefreshButtonState()
  self.tbActState = {}
  for i = 1, 5 do
    local actData = self.BreakOut_30101Data:GetActivityDataByIndex(i)
    if actData ~= nil then
      if i == AllEnum.ActivityThemeFuncIndex.Task then
        self:RefreshTaskButtonState(actData)
      elseif i == AllEnum.ActivityThemeFuncIndex.Shop then
        self:RefreshShopButtonState(actData)
      end
    end
  end
end

function BreakOutThemeCtrl:RefreshButtonTimer(actData, timer, txtTrans, imgTrans, refreshFunc)
  local countDownTimer
  local activityId = actData.ActivityId
  local activityData = ConfigTable.GetData("Activity", activityId)
  local state = ActivityState.NotOpen
  local bShowCountDown = false
  if activityData ~= nil then
    local curTime = ClientManager.serverTimeStamp
    if activityData.StartTime ~= "" and activityData.EndTime ~= "" then
      local openTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.StartTime)
      local endTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.EndTime)
      if curTime < openTime then
        state = ActivityState.NotOpen
      elseif curTime >= openTime and curTime <= endTime then
        state = ActivityState.Open
      else
        state = ActivityState.Closed
      end
    elseif activityData.EndType == GameEnum.activityEndType.NoLimit then
      state = ActivityState.Open
      if activityData.StartTime ~= "" then
        local openTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.StartTime)
        if curTime < openTime then
          state = ActivityState.NotOpen
        end
      end
    end
    if state == ActivityState.NotOpen then
      if nil == timer and activityData.StartTime ~= "" and activityData.EndTime ~= "" then
        local openTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.StartTime)
        
        local function fcTimer()
          curTime = ClientManager.serverTimeStamp
          local remainTime = openTime - curTime
          if imgTrans == nil then
            return
          end
          if 0 < remainTime then
            local sTimeStr = self:RefreshRemainOpenTime(openTime)
            local txtUnlock = imgTrans:GetComponentInChildren(typeof(CS.TMPro.TMP_Text))
            if txtUnlock ~= nil then
              NovaAPI.SetTMPText(txtUnlock, sTimeStr)
            end
          else
            imgTrans:SetActive(false)
            TimerManager.Remove(timer)
            countDownTimer = nil
            self.tbActState[activityId] = ActivityState.Open
            refreshFunc(actData)
            self:RefreshActivityData()
          end
        end
        
        fcTimer()
        countDownTimer = self:AddTimer(0, 1, fcTimer, true, true, false)
      end
    elseif state == ActivityState.Open and activityData.StartTime ~= "" and activityData.EndTime ~= "" then
      do
        local endTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.EndTime)
        if endTime > self.BreakOut_30101Data:GetActGroupEndTime() then
          bShowCountDown = true
        elseif endTime < self.BreakOut_30101Data:GetActGroupEndTime() then
          bShowCountDown = endTime - curTime <= 259200
        end
        if timer == nil and bShowCountDown then
          self:RefreshRemainTime(endTime, txtTrans)
          do
            local function fcTimer()
              local remainTime = self:RefreshRemainTime(endTime, txtTrans)
              
              if remainTime <= 0 then
                TimerManager.Remove(timer)
                countDownTimer = nil
                refreshFunc(actData)
              end
            end
            
            fcTimer()
            countDownTimer = self:AddTimer(0, 1, fcTimer, true, true, false)
          end
        end
      end
    end
  end
  return state, bShowCountDown, countDownTimer
end

function BreakOutThemeCtrl:RefreshTaskButtonState(actData)
  local activityId = actData.ActivityId
  local actInsData = PlayerData.Activity:GetActivityDataById(activityId)
  local activityData = ConfigTable.GetData("Activity", activityId)
  if activityData ~= nil then
    local function refreshFunc(actData)
      if actInsData ~= nil then
        actInsData:RefreshTaskRedDot()
      end
      self:RefreshTaskButtonState(actData)
    end
    
    local state, bShowCountDown, countDownTimer = self:RefreshButtonTimer(actData, self.taskRemainTimer, self._mapNode.txtTaskActivityTime, nil, refreshFunc)
    if self.taskRemainTimer == nil then
      self.taskRemainTimer = countDownTimer
    end
    if state == ActivityState.Closed and actInsData ~= nil then
      actInsData:RefreshTaskRedDot()
    end
    self._mapNode.TaskActivityTime:SetActive(state == ActivityState.Open and bShowCountDown)
    self._mapNode.TaskMask:SetActive(state == ActivityState.Closed)
    self.tbActState[activityId] = state
    local ActivityTaskData = PlayerData.Activity:GetActivityDataById(activityId)
    local nDone, nTotal = 0, 0
    if ActivityTaskData ~= nil then
      nDone, nTotal = ActivityTaskData:CalcTotalProgress()
    end
    local progress = string.format("%d/%d", nDone, nTotal)
    local rt = self._mapNode.imgProgressBg:GetComponent("RectTransform")
    local nWidth = 0 < nTotal and nDone / nTotal * rt.rect.width or 0
    self._mapNode.imgFill:GetComponent("RectTransform").sizeDelta = Vector2(nWidth, rt.rect.height)
    NovaAPI.SetTMPText(self._mapNode.txtProgress, progress)
  end
end

function BreakOutThemeCtrl:RefreshShopButtonState(actData)
  local activityId = actData.ActivityId
  local activityData = ConfigTable.GetData("Activity", activityId)
  if activityData ~= nil then
    local function refreshFunc(actData)
      self:RefreshShopButtonState(actData)
    end
    
    local state, bShowCountDown, countDownTimer = self:RefreshButtonTimer(actData, self.shopRemainTimer, self._mapNode.txtShopActivityTime, nil, refreshFunc)
    if self.shopRemainTimer == nil then
      self.shopRemainTimer = countDownTimer
    end
    self._mapNode.ShopActivityTime:SetActive(state == ActivityState.Open and bShowCountDown)
    self.tbActState[activityId] = state
  end
end

function BreakOutThemeCtrl:RequireActivityData()
  if self.bRequiredActData then
    return
  end
  
  local function callFunc()
    self.bRequireSucc = true
    self:RefreshPanel()
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_detail_req, {}, nil, callFunc)
  self.bRequiredActData = true
  self:AddTimer(1, 1, function()
    self.bRequiredActData = false
  end, true, true, true)
end

function BreakOutThemeCtrl:RefreshActivityData()
  if self.bRequiredActData then
    return
  end
  self:AddTimer(1, 3, self.RequireActivityData, true, true, true)
end

function BreakOutThemeCtrl:OnBtn_ClickActivityEntrance(btn, nIndex)
  local actData
  if nIndex == 1 then
    nIndex = AllEnum.ActivityThemeFuncIndex.Shop
    actData = self.BreakOut_30101Data:GetActivityDataByIndex(nIndex)
  elseif nIndex == 2 then
    nIndex = AllEnum.ActivityThemeFuncIndex.Task
    actData = self.BreakOut_30101Data:GetActivityDataByIndex(nIndex)
  end
  local state = self.tbActState[actData.ActivityId]
  if nil == state then
    return
  end
  if state == ActivityState.Closed then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_End_Notice"))
    return
  elseif state == ActivityState.NotOpen then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_Not_Open"))
    return
  elseif state == ActivityState.Open then
    local activityData = PlayerData.Activity:GetActivityDataById(actData.ActivityId)
    if activityData == nil then
      local bHint = true
      if self.bRequiredActData and bHint then
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_Data_Refreshing"))
        return
      end
      if bHint then
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_Not_Open"))
        self:RequireActivityData()
        return
      end
    end
  end
  if actData.PanelId ~= nil and ActivityState.Open == state then
    EventManager.Hit(EventId.OpenPanel, actData.PanelId, actData.ActivityId)
  end
end

function BreakOutThemeCtrl:JumpTo_LevelDetail(nActId, nLevelId)
  local function OpenPanel()
    EventManager.Hit(EventId.OpenPanel, PanelId.BreakOutLevelDetailPanelS3, nActId, nLevelId)
  end
  
  EventManager.Hit(EventId.SetTransition, 3, OpenPanel)
end

function BreakOutThemeCtrl:SetAnimatorState()
  self.BreakOutTheme_Animator:Play("BreakOutThemePanel_idle", 0, 0)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.02))
    self.BreakOutTheme_Animator:Play("BreakOutThemePanel_in", 0, 0)
  end
  
  cs_coroutine.start(wait)
end

return BreakOutThemeCtrl
