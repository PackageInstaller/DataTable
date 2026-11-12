local BaseCtrl = require("GameCore.UI.BaseCtrl")
local SwimThemeCtrl = class("SwimThemeCtrl", BaseCtrl)
local ClientManager = CS.ClientManager.Instance
local TimerManager = require("GameCore.Timer.TimerManager")
SwimThemeCtrl._mapNodeConfig = {
  btnEntrance_ = {
    nCount = 5,
    sComponentName = "UIButton",
    callback = "OnBtn_ClickActivityEntrance"
  },
  imgActivityTime = {},
  txtActivityTime = {sComponentName = "TMP_Text"},
  txtActivityDate = {sComponentName = "TMP_Text"},
  imgEnd = {},
  txtActivityEnd = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_End"
  },
  imgMiniGame = {sComponentName = "Image"},
  txtMiniGame = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Mini_Game"
  },
  imgMiniGameEnd = {},
  txtMiniGameEnd = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Mini_Game"
  },
  txtMiniGame_End = {},
  txtTask = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Task"
  },
  txtTaskProgress = {sComponentName = "TMP_Text"},
  imgTaskActivityTime = {},
  txtTaskActivityTime = {sComponentName = "TMP_Text"},
  txtStory = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Story"
  },
  imgStory = {sComponentName = "Image"},
  imgStoryIcon = {sComponentName = "Image"},
  imgStoryEnd = {},
  goStoryEnd = {},
  txtStory_End = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Story"
  },
  imgStoryIconEnd = {},
  txtStoryEnd = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_End"
  },
  txtMiniGameEndState = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_End"
  },
  txtTaskEndState = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_End"
  },
  txtShopEndState = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_End"
  },
  txtShop = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Shop"
  },
  imgShopActivityTime = {},
  txtShopActivityTime = {sComponentName = "TMP_Text"},
  imgLevel = {sComponentName = "Image"},
  txtLevel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Level"
  },
  goLevelEnd = {},
  txtLevelEnd = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_End"
  },
  imgLevelActivityUnlockTime = {},
  txtLevelActivityUnlockTime = {sComponentName = "TMP_Text"},
  txtLevel_End = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Level"
  },
  imgLevelEnd = {},
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  imgMiniGameActivityUnlockTime = {},
  txtMiniGameActivityUnlockTime = {sComponentName = "TMP_Text"},
  imgTaskBgEnd = {},
  imgTaskEnd = {},
  txtTaskEnd = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Task"
  },
  txtTaskProgress_End = {},
  imgTaskActivityUnlockTime = {},
  txtTaskActivityUnlockTime = {sComponentName = "TMP_Text"},
  imgStoryActivityTime = {},
  txtStoryActivityTime = {sComponentName = "TMP_Text"},
  imgStoryActivityUnlockTime = {},
  txtStoyActivityUnlockTime = {sComponentName = "TMP_Text"},
  imgShopActivityUnlockTime = {},
  txtShopActivityUnlockTime = {sComponentName = "TMP_Text"},
  imgLevelActivityTime = {},
  txtLevelActivityTime = {sComponentName = "TMP_Text"},
  imgMiniGameActivityTime = {},
  txtMiniGameActivityTime = {sComponentName = "TMP_Text"},
  txtShopEnd = {},
  imgShopEnd = {},
  txtShop_End = {},
  txtTaskProgressEnd = {sComponentName = "TMP_Text"},
  redDotEntrance2 = {},
  storyRedDot = {},
  reddotLevel = {}
}
SwimThemeCtrl._mapEventConfig = {}
SwimThemeCtrl._mapRedDotConfig = {}
local ActivityState = {
  NotOpen = 1,
  Open = 2,
  Closed = 3
}

function SwimThemeCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
  end
  self.SwimThemeData = PlayerData.Activity:GetActivityGroupDataById(self.nActId)
  if self.SwimThemeData ~= nil then
    self.ActivityGroupCfg = self.SwimThemeData.actGroupConfig
  end
end

function SwimThemeCtrl:FadeIn()
  EventManager.Hit(EventId.SetTransition)
end

function SwimThemeCtrl:OnEnable()
  self:RefreshPanel()
  for i = 1, 5 do
    local actData = self.SwimThemeData:GetActivityDataByIndex(i)
    if i == AllEnum.ActivityThemeFuncIndex.Task then
      local nActId = actData.ActivityId
      RedDotManager.RegisterNode(RedDotDefine.Activity_Group_Task, {
        self.nActId,
        nActId
      }, self._mapNode.redDotEntrance2)
    elseif i == AllEnum.ActivityThemeFuncIndex.Story then
      local nActId = actData.ActivityId
      RedDotManager.RegisterNode(RedDotDefine.Activity_GroupNew_Avg, {
        self.nActId,
        nActId
      }, self._mapNode.storyRedDot)
    elseif i == AllEnum.ActivityThemeFuncIndex.Level then
      local nActId = actData.ActivityId
      RedDotManager.RegisterNode(RedDotDefine.ActivityLevel, {
        self.nActId,
        nActId
      }, self._mapNode.reddotLevel)
    end
  end
end

function SwimThemeCtrl:OnDisable()
  if nil ~= self.minigameRemainTimer then
    TimerManager.Remove(self.minigameRemainTimer)
    self.minigameRemainTimer = nil
  end
  if nil ~= self.remainTimer then
    TimerManager.Remove(self.remainTimer)
    self.remainTimer = nil
  end
  if nil ~= self.shopRemainTimer then
    TimerManager.Remove(self.shopRemainTimer)
    self.shopRemainTimer = nil
  end
  if nil ~= self.levelRemainTimer then
    TimerManager.Remove(self.levelRemainTimer)
    self.levelRemainTimer = nil
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

function SwimThemeCtrl:RefreshPanel()
  if self.SwimThemeData == nil or self.ActivityGroupCfg == nil then
    return
  end
  self:RefreshTime()
  self:RefreshButtonState()
end

function SwimThemeCtrl:RefreshTime()
  local bOpen = self.SwimThemeData:CheckActivityGroupOpen()
  if bOpen then
    RefreshRemainTime(self.SwimThemeData:GetActGroupEndTime(), self._mapNode.txtActivityTime)
    if nil == self.remainTimer then
      self.remainTimer = self:AddTimer(0, 1, function()
        local remainTime = RefreshRemainTime(self.SwimThemeData:GetActGroupEndTime(), self._mapNode.txtActivityTime)
        if remainTime <= 0 then
          TimerManager.Remove(self.remainTimer)
          self.remainTimer = nil
        end
      end, true, true, false)
    end
  end
  self._mapNode.imgActivityTime:SetActive(bOpen)
  self._mapNode.imgEnd:SetActive(not bOpen)
  local nOpenMonth, nOpenDay, nEndMonth, nEndDay, nOpenYear, nEndYear = self.SwimThemeData:GetActGroupDate()
  local strOpenDay = string.format("%d", nOpenDay)
  local strEndDay = string.format("%d", nEndDay)
  local dateStr = string.format("%s/%s/%s ~ %s/%s/%s", nOpenYear, nOpenMonth, strOpenDay, nEndYear, nEndMonth, strEndDay)
  NovaAPI.SetTMPText(self._mapNode.txtActivityDate, dateStr)
end

function SwimThemeCtrl:RefreshRemainOpenTime(openTime)
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

function SwimThemeCtrl:RefreshButtonState()
  self.tbActState = {}
  for i = 1, 5 do
    local actData = self.SwimThemeData:GetActivityDataByIndex(i)
    if i == AllEnum.ActivityThemeFuncIndex.MiniGame then
      self:RefreshMiniGameButtonState(actData)
    elseif i == AllEnum.ActivityThemeFuncIndex.Task then
      self:RefreshTaskButtonState(actData)
    elseif i == AllEnum.ActivityThemeFuncIndex.Story then
      self:RefreshStoryButtonState(actData)
    elseif i == AllEnum.ActivityThemeFuncIndex.Level then
      self:RefreshLevelButtonState(actData)
    elseif i == AllEnum.ActivityThemeFuncIndex.Shop then
      self:RefreshShopButtonState(actData)
    end
  end
end

function SwimThemeCtrl:RefreshMiniGameButtonState(actData)
  local activityId = actData.ActivityId
  local activityData = ConfigTable.GetData("Activity", activityId)
  if activityData ~= nil then
    local state = ActivityState.NotOpen
    local curTime = ClientManager.serverTimeStamp
    local bShowCountDown = false
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
      if nil == self.minigameRemainTimer and activityData.StartTime ~= "" and activityData.EndTime ~= "" then
        local openTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.StartTime)
        local sTimeStr = self:RefreshRemainOpenTime(openTime)
        NovaAPI.SetTMPText(self._mapNode.txtMiniGameActivityUnlockTime, sTimeStr)
        self.minigameRemainTimer = self:AddTimer(0, 1, function()
          curTime = ClientManager.serverTimeStamp
          local remainTime = openTime - curTime
          if 0 < remainTime then
            local sTimeStr = self:RefreshRemainOpenTime(openTime)
            NovaAPI.SetTMPText(self._mapNode.txtMiniGameActivityUnlockTime, sTimeStr)
          else
            self._mapNode.imgMiniGameActivityUnlockTime:SetActive(false)
            TimerManager.Remove(self.minigameRemainTimer)
            self.minigameRemainTimer = nil
            self.tbActState[activityId] = ActivityState.Open
            self:RefreshMiniGameButtonState(actData)
            self:RefreshActivityData()
          end
        end, true, true, false)
      end
    elseif state == ActivityState.Open and activityData.StartTime ~= "" and activityData.EndTime ~= "" then
      local endTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.EndTime)
      if endTime > self.SwimThemeData:GetActGroupEndTime() then
        bShowCountDown = curTime >= self.SwimThemeData:GetActGroupEndTime()
      elseif endTime < self.SwimThemeData:GetActGroupEndTime() then
        bShowCountDown = endTime - curTime <= 259200
      end
      if nil == self.minigameRemainTimer and bShowCountDown then
        RefreshRemainTime(endTime, self._mapNode.txtMiniGameActivityTime)
        self.minigameRemainTimer = self:AddTimer(0, 1, function()
          local remainTime = RefreshRemainTime(endTime, self._mapNode.txtMiniGameActivityTime)
          if remainTime <= 0 then
            TimerManager.Remove(self.minigameRemainTimer)
            self.minigameRemainTimer = nil
            self:RefreshMiniGameButtonState(actData)
          end
        end, true, true, false)
      end
    end
    self._mapNode.imgMiniGameActivityUnlockTime:SetActive(state == ActivityState.NotOpen)
    self._mapNode.imgMiniGameActivityTime.gameObject:SetActive(state == ActivityState.Open and bShowCountDown)
    self._mapNode.imgMiniGameEnd:SetActive(state == ActivityState.Closed)
    self._mapNode.txtMiniGame_End:SetActive(state == ActivityState.Closed)
    self._mapNode.txtMiniGameEnd.gameObject:SetActive(state == ActivityState.Closed)
    self.tbActState[activityId] = state
  end
end

function SwimThemeCtrl:RefreshTaskButtonState(actData)
  local activityId = actData.ActivityId
  local actInsData = PlayerData.Activity:GetActivityDataById(activityId)
  local activityData = ConfigTable.GetData("Activity", activityId)
  if activityData ~= nil then
    local bShowCountDown = false
    local state = ActivityState.NotOpen
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
        if actInsData ~= nil then
          actInsData:RefreshTaskRedDot()
        end
      end
      if endTime > self.SwimThemeData:GetActGroupEndTime() then
        bShowCountDown = curTime >= self.SwimThemeData:GetActGroupEndTime()
      elseif endTime < self.SwimThemeData:GetActGroupEndTime() then
        bShowCountDown = endTime - curTime <= 259200
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
      if nil == self.taskRemainTimer and activityData.StartTime ~= "" and activityData.EndTime ~= "" then
        local openTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.StartTime)
        local sTimeStr = self:RefreshRemainOpenTime(openTime)
        NovaAPI.SetTMPText(self._mapNode.txtTaskActivityUnlockTime, sTimeStr)
        self.taskRemainTimer = self:AddTimer(0, 1, function()
          curTime = ClientManager.serverTimeStamp
          local remainTime = openTime - curTime
          if 0 < remainTime then
            local sTimeStr = self:RefreshRemainOpenTime(openTime)
            NovaAPI.SetTMPText(self._mapNode.txtTaskActivityUnlockTime, sTimeStr)
          else
            self._mapNode.imgTaskActivityUnlockTime:SetActive(false)
            TimerManager.Remove(self.taskRemainTimer)
            self.taskRemainTimer = nil
            self.tbActState[activityId] = ActivityState.Open
            self:RefreshTaskButtonState(actData)
            self:RefreshActivityData()
          end
        end, true, true, false)
      end
    elseif state == ActivityState.Open and nil == self.taskRemainTimer and activityData.StartTime ~= "" and activityData.EndTime ~= "" and bShowCountDown then
      local endTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.EndTime)
      RefreshRemainTime(endTime, self._mapNode.txtTaskActivityTime)
      self.taskRemainTimer = self:AddTimer(0, 1, function()
        local remainTime = RefreshRemainTime(endTime, self._mapNode.txtTaskActivityTime)
        if remainTime <= 0 then
          TimerManager.Remove(self.taskRemainTimer)
          self.taskRemainTimer = nil
          if actInsData ~= nil then
            actInsData:RefreshTaskRedDot()
          end
          self:RefreshTaskButtonState(actData)
        end
      end, true, true, false)
    end
    self._mapNode.imgTaskActivityTime:SetActive(state == ActivityState.Open and bShowCountDown)
    self._mapNode.txtTaskProgress_End:SetActive(state == ActivityState.Closed)
    self._mapNode.txtTaskProgressEnd.gameObject:SetActive(state == ActivityState.Closed)
    self._mapNode.imgTaskBgEnd:SetActive(state == ActivityState.Closed)
    self._mapNode.imgTaskEnd:SetActive(state == ActivityState.Closed)
    self._mapNode.txtTaskEnd.gameObject:SetActive(state == ActivityState.Closed)
    self._mapNode.imgTaskActivityUnlockTime:SetActive(state == ActivityState.NotOpen)
    self._mapNode.txtTaskProgress.gameObject:SetActive(state >= ActivityState.Open)
    self.tbActState[activityId] = state
    local ActivityTaskData = PlayerData.Activity:GetActivityDataById(activityId)
    local nDone, nTotal = 0, 0
    if ActivityTaskData ~= nil then
      nDone, nTotal = ActivityTaskData:CalcTotalProgress()
    end
    local progress = string.format("%d/%d", nDone, nTotal)
    NovaAPI.SetTMPText(self._mapNode.txtTaskProgress, progress)
    NovaAPI.SetTMPText(self._mapNode.txtTaskProgressEnd, progress)
  end
end

function SwimThemeCtrl:RefreshStoryButtonState(actData)
  local activityId = actData.ActivityId
  local activityData = ConfigTable.GetData("Activity", activityId)
  if activityData ~= nil then
    local bShowCountDown = false
    local state = ActivityState.NotOpen
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
      if endTime > self.SwimThemeData:GetActGroupEndTime() then
        bShowCountDown = curTime >= self.SwimThemeData:GetActGroupEndTime()
      elseif endTime < self.SwimThemeData:GetActGroupEndTime() then
        bShowCountDown = endTime - curTime <= 259200
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
      if nil == self.avgRemainTimer and activityData.StartTime ~= "" and activityData.EndTime ~= "" then
        local openTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.StartTime)
        local sTimeStr = self:RefreshRemainOpenTime(openTime)
        NovaAPI.SetTMPText(self._mapNode.txtStoyActivityUnlockTime, sTimeStr)
        self.avgRemainTimer = self:AddTimer(0, 1, function()
          curTime = ClientManager.serverTimeStamp
          local remainTime = openTime - curTime
          if 0 < remainTime then
            local sTimeStr = self:RefreshRemainOpenTime(openTime)
            NovaAPI.SetTMPText(self._mapNode.txtStoyActivityUnlockTime, sTimeStr)
          else
            self._mapNode.imgStoryActivityUnlockTime:SetActive(false)
            TimerManager.Remove(self.avgRemainTimer)
            self.avgRemainTimer = nil
            self.tbActState[activityId] = ActivityState.Open
            self:RefreshStoryButtonState(actData)
            self:RefreshActivityData()
            PlayerData.ActivityAvg:RefreshAvgRedDot()
          end
        end, true, true, false)
      end
    elseif state == ActivityState.Open then
      if nil == self.avgRemainTimer and activityData.StartTime ~= "" and activityData.EndTime ~= "" and bShowCountDown then
        local endTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.EndTime)
        RefreshRemainTime(endTime, self._mapNode.txtStoryActivityTime)
        self.avgRemainTimer = self:AddTimer(0, 1, function()
          local remainTime = RefreshRemainTime(endTime, self._mapNode.txtStoryActivityTime)
          if remainTime <= 0 then
            TimerManager.Remove(self.avgRemainTimer)
            self.avgRemainTimer = nil
            self:RefreshStoryButtonState(actData)
            PlayerData.ActivityAvg:RefreshAvgRedDot()
          end
        end, true, true, false)
      end
    elseif state == ActivityState.Closed then
      PlayerData.ActivityAvg:RefreshAvgRedDot()
    end
    self._mapNode.imgStoryEnd:SetActive(state == ActivityState.Closed)
    self._mapNode.imgStoryIconEnd:SetActive(state == ActivityState.Closed)
    self._mapNode.txtStory_End.gameObject:SetActive(state == ActivityState.Closed)
    self._mapNode.goStoryEnd:SetActive(state == ActivityState.Closed)
    self._mapNode.imgStoryActivityTime:SetActive(state == ActivityState.Open and bShowCountDown)
    self._mapNode.imgStoryActivityUnlockTime:SetActive(state == ActivityState.NotOpen)
    self.tbActState[activityId] = state
  end
end

function SwimThemeCtrl:RefreshLevelButtonState(actData)
  local activityId = actData.ActivityId
  local activityData = ConfigTable.GetData("Activity", activityId)
  if activityData ~= nil then
    local bShowCountDown = false
    local state = ActivityState.NotOpen
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
      if endTime > self.SwimThemeData:GetActGroupEndTime() then
        bShowCountDown = curTime >= self.SwimThemeData:GetActGroupEndTime()
      elseif endTime < self.SwimThemeData:GetActGroupEndTime() then
        bShowCountDown = endTime - curTime <= 259200
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
      if nil == self.levelRemainTimer and activityData.StartTime ~= "" and activityData.EndTime ~= "" then
        local openTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.StartTime)
        local sTimeStr = self:RefreshRemainOpenTime(openTime)
        NovaAPI.SetTMPText(self._mapNode.txtLevelActivityUnlockTime, sTimeStr)
        self.levelRemainTimer = self:AddTimer(0, 1, function()
          curTime = ClientManager.serverTimeStamp
          local remainTime = openTime - curTime
          if 0 < remainTime then
            local sTimeStr = self:RefreshRemainOpenTime(openTime)
            NovaAPI.SetTMPText(self._mapNode.txtLevelActivityUnlockTime, sTimeStr)
          else
            self._mapNode.imgLevelActivityUnlockTime:SetActive(false)
            TimerManager.Remove(self.levelRemainTimer)
            self.levelRemainTimer = nil
            self.tbActState[activityId] = ActivityState.Open
            self:RefreshLevelButtonState(actData)
            self:RefreshActivityData()
            local activityLevelsData = PlayerData.Activity:GetActivityDataById(activityId)
            if nil ~= activityLevelsData then
              activityLevelsData:ChangeAllRedHot()
            end
          end
        end, true, true, false)
      end
    elseif state == ActivityState.Open then
      if nil == self.levelRemainTimer and activityData.StartTime ~= "" and activityData.EndTime ~= "" and bShowCountDown then
        local endTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.EndTime)
        RefreshRemainTime(endTime, self._mapNode.txtLevelActivityTime)
        self.levelRemainTimer = self:AddTimer(0, 1, function()
          local remainTime = RefreshRemainTime(endTime, self._mapNode.txtLevelActivityTime)
          if remainTime <= 0 then
            TimerManager.Remove(self.levelRemainTimer)
            self.levelRemainTimer = nil
            self:RefreshLevelButtonState(actData)
            local activityLevelsData = PlayerData.Activity:GetActivityDataById(activityId)
            if activityLevelsData ~= nil then
              activityLevelsData:ChangeAllRedHot()
            end
          end
        end, true, true, false)
      end
    elseif state == ActivityState.Closed then
      local activityLevelsData = PlayerData.Activity:GetActivityDataById(activityId)
      if activityLevelsData ~= nil then
        activityLevelsData:ChangeAllRedHot()
      end
    end
    self._mapNode.imgLevelActivityTime:SetActive(state == ActivityState.Open and bShowCountDown)
    self._mapNode.imgLevelActivityUnlockTime:SetActive(state == ActivityState.NotOpen)
    self._mapNode.imgLevelEnd:SetActive(state == ActivityState.Closed)
    self._mapNode.txtLevel_End.gameObject:SetActive(state == ActivityState.Closed)
    self._mapNode.goLevelEnd:SetActive(state == ActivityState.Closed)
    self.tbActState[activityId] = state
  end
end

function SwimThemeCtrl:RefreshShopButtonState(actData)
  local activityId = actData.ActivityId
  local activityData = ConfigTable.GetData("Activity", activityId)
  if activityData ~= nil then
    local bShowCountDown = false
    local state = ActivityState.NotOpen
    local curTime = ClientManager.serverTimeStamp
    if activityData.StartTime ~= "" and activityData.EndTime ~= "" then
      local openTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.StartTime)
      local endTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.EndTime)
      local curTime = ClientManager.serverTimeStamp
      if openTime > curTime then
        state = ActivityState.NotOpen
      elseif openTime <= curTime and endTime >= curTime then
        state = ActivityState.Open
      else
        state = ActivityState.Closed
      end
      if endTime > self.SwimThemeData:GetActGroupEndTime() then
        bShowCountDown = curTime >= self.SwimThemeData:GetActGroupEndTime()
      elseif endTime < self.SwimThemeData:GetActGroupEndTime() then
        bShowCountDown = endTime - curTime <= 259200
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
      if nil == self.shopRemainTimer and activityData.StartTime ~= "" and activityData.EndTime ~= "" then
        local openTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.StartTime)
        local sTimeStr = self:RefreshRemainOpenTime(openTime)
        NovaAPI.SetTMPText(self._mapNode.txtShopActivityUnlockTime, sTimeStr)
        self.shopRemainTimer = self:AddTimer(0, 1, function()
          curTime = ClientManager.serverTimeStamp
          local remainTime = openTime - curTime
          if 0 < remainTime then
            local sTimeStr = self:RefreshRemainOpenTime(openTime)
            NovaAPI.SetTMPText(self._mapNode.txtShopActivityUnlockTime, sTimeStr)
          else
            self._mapNode.imgShopActivityUnlockTime:SetActive(false)
            TimerManager.Remove(self.shopRemainTimer)
            self.shopRemainTimer = nil
            self.tbActState[activityId] = ActivityState.Open
            self:RefreshShopButtonState(actData)
            self:RefreshActivityData()
          end
        end, true, true, false)
      end
    elseif state == ActivityState.Open and nil == self.shopRemainTimer and activityData.StartTime ~= "" and activityData.EndTime ~= "" and bShowCountDown then
      local endTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.EndTime)
      RefreshRemainTime(endTime, self._mapNode.txtShopActivityTime)
      self.shopRemainTimer = self:AddTimer(0, 1, function()
        local remainTime = RefreshRemainTime(endTime, self._mapNode.txtShopActivityTime)
        if remainTime <= 0 then
          TimerManager.Remove(self.shopRemainTimer)
          self.shopRemainTimer = nil
          self:RefreshShopButtonState(actData)
        end
      end, true, true, false)
    end
    self._mapNode.imgShopActivityTime:SetActive(state == ActivityState.Open and bShowCountDown)
    self._mapNode.imgShopActivityUnlockTime:SetActive(state == ActivityState.NotOpen)
    self._mapNode.txtShopEnd:SetActive(state == ActivityState.Closed)
    self._mapNode.imgShopEnd:SetActive(state == ActivityState.Closed)
    self._mapNode.txtShop_End:SetActive(state == ActivityState.Closed)
    self.tbActState[activityId] = state
  end
end

function SwimThemeCtrl:RequireActiviyData()
  if self.bRequiredActData then
    return
  end
  
  local function callFunc(mapMsgData)
    self.bRequireSucc = true
    PlayerData.Activity:CacheAllActivityData(mapMsgData)
    self:RefreshPanel()
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_detail_req, {}, nil, callFunc)
  self.bRequiredActData = true
  self:AddTimer(1, 1, function()
    self.bRequiredActData = false
  end, true, true, true)
end

function SwimThemeCtrl:RefreshActivityData()
  if self.bRequiredActData then
    return
  end
  self:AddTimer(1, 3, self.RequireActiviyData, true, true, true)
end

function SwimThemeCtrl:OnBtn_ClickActivityEntrance(btn, nIndex)
  local actData = self.SwimThemeData:GetActivityDataByIndex(nIndex)
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
      if nIndex == AllEnum.ActivityThemeFuncIndex.Story then
        bHint = not PlayerData.ActivityAvg:HasActivityData(actData.ActivityId)
      end
      if self.bRequiredActData and bHint then
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_Data_Refreshing"))
        return
      end
      if bHint then
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_Not_Open"))
        self:RequireActiviyData()
        return
      end
    end
  end
  if actData.PanelId ~= nil and ActivityState.Open == state then
    if nIndex == AllEnum.ActivityThemeFuncIndex.MiniGame then
      local function callback()
        EventManager.Hit(EventId.OpenPanel, actData.PanelId, actData.ActivityId)
      end
      
      local miniGameData = PlayerData.Activity:GetActivityDataById(actData.ActivityId)
      if miniGameData ~= nil then
        miniGameData:RequestLevelData(0, callback)
      end
    else
      EventManager.Hit(EventId.OpenPanel, actData.PanelId, actData.ActivityId)
    end
  end
end

return SwimThemeCtrl
