local BaseCtrl = require("GameCore.UI.BaseCtrl")
local GunStormCtrl = class("GunStormCtrl", BaseCtrl)
local ClientManager = CS.ClientManager.Instance
local TimerManager = require("GameCore.Timer.TimerManager")
local LocalData = require("GameCore.Data.LocalData")
GunStormCtrl._mapNodeConfig = {
  btnEntrance_ = {
    nCount = 5,
    sComponentName = "UIButton",
    callback = "OnBtn_ClickActivityEntrance"
  },
  imgRemaineTime = {},
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
    sLanguageId = "Activity_Mini_Game_10109"
  },
  imgMiniGameEnd = {},
  txtMiniGameEnd = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Mini_Game_10109"
  },
  txtMiniGame_End = {},
  txtTask = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Task"
  },
  txtTaskProgress = {sComponentName = "TMP_Text"},
  imgTaskActivityTime = {},
  txtTaskActivityTime = {sComponentName = "TMP_Text"},
  imgStory = {sComponentName = "Image"},
  txtStory = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Story"
  },
  txtStory_End = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Story"
  },
  goStoryEnd = {},
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
  txtLevel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Level"
  },
  txtLevel_End = {
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
  imgLevelEnd = {},
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  imgMiniGameActivityUnlockTime = {},
  txtMiniGameActivityUnlockTime = {sComponentName = "TMP_Text"},
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
  txtStoryActivityUnlockTime = {sComponentName = "TMP_Text"},
  imgShopActivityUnlockTime = {},
  txtShopActivityUnlockTime = {sComponentName = "TMP_Text"},
  imgLevelActivityTime = {},
  txtLevelActivityTime = {sComponentName = "TMP_Text"},
  imgMiniGameActivityTime = {},
  txtMiniGameActivityTime = {sComponentName = "TMP_Text"},
  txtShopEnd = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Shop"
  },
  imgShopEnd = {},
  txtShop_End = {},
  txtTaskProgressEnd = {sComponentName = "TMP_Text"},
  dbTaskEnd = {},
  miniGameRedDot = {},
  redDotEntrance2 = {},
  storyRedDot = {},
  reddotLevel = {},
  goMiniGameEnd = {},
  imgStoryEnd = {},
  reddotMiniGame = {
    sNodeName = "miniGameRedDot"
  }
}
GunStormCtrl._mapEventConfig = {}
local ActivityState = {
  NotOpen = 1,
  Open = 2,
  Closed = 3
}

function GunStormCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
  end
  self.GunStormData = PlayerData.Activity:GetActivityGroupDataById(self.nActId)
  if self.GunStormData ~= nil then
    self.ActivityGroupCfg = self.GunStormData.actGroupConfig
  end
  for k, v in pairs(self._mapNode.btnEntrance_) do
    v.interactable = false
  end
end

function GunStormCtrl:FadeIn()
  EventManager.Hit(EventId.SetTransition)
  local sAnimName = "GunStormPanel_in"
  local sSoundName = "Mode_Maoyan_activity"
  if self.animRoot ~= nil then
    self.animRoot = self.gameObject:GetComponent("Animator")
    sAnimName = "GunStormPanel_in1"
    sSoundName = "Mode_Maoyan_activity_01"
  end
  self.animRoot = self.gameObject:GetComponent("Animator")
  self.animRoot:Play(sAnimName, 0, 0)
  CS.WwiseAudioManager.Instance:PlaySound(sSoundName)
  local nAnimLength = NovaAPI.GetAnimClipLength(self.animRoot, {sAnimName})
  self:AddTimer(1, nAnimLength, function()
    for k, v in pairs(self._mapNode.btnEntrance_) do
      v.interactable = true
    end
  end, true, true, true)
end

function GunStormCtrl:OnEnable()
  self:RefreshPanel()
  for i = 1, 5 do
    local actData = self.GunStormData:GetActivityDataByIndex(i)
    if i == AllEnum.ActivityThemeFuncIndex.Task then
      local nActId = actData.ActivityId
      local state = self.tbActState[nActId]
      if state == ActivityState.Closed then
        self._mapNode.redDotEntrance2:SetActive(false)
      else
        RedDotManager.RegisterNode(RedDotDefine.Activity_Group_Task, {
          self.nActId,
          nActId
        }, self._mapNode.redDotEntrance2)
      end
    elseif i == AllEnum.ActivityThemeFuncIndex.Level then
      local nActId = actData.ActivityId
      RedDotManager.RegisterNode(RedDotDefine.ActivityLevel, {
        self.nActId,
        nActId
      }, self._mapNode.reddotLevel)
    elseif i == AllEnum.ActivityThemeFuncIndex.Story then
      local nActId = actData.ActivityId
      RedDotManager.RegisterNode(RedDotDefine.Activity_GroupNew_Avg_Group, {
        self.nActId,
        nActId
      }, self._mapNode.storyRedDot)
    elseif i == AllEnum.ActivityThemeFuncIndex.MiniGame then
      local nActId = actData.ActivityId
      RedDotManager.RegisterNode(RedDotDefine.Activity_GoldenSpy, {
        self.nActId
      }, self._mapNode.reddotMiniGame)
    end
  end
end

function GunStormCtrl:OnDisable()
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
  if nil ~= self.eatingAnimationTimer then
    TimerManager.Remove(self.eatingAnimationTimer)
    self.eatingAnimationTimer = nil
  end
end

function GunStormCtrl:RefreshPanel()
  if self.GunStormData == nil or self.ActivityGroupCfg == nil then
    return
  end
  self:RefreshTime()
  self:RefreshButtonState()
end

function GunStormCtrl:RefreshTime()
  local bOpen = self.GunStormData:CheckActivityGroupOpen()
  if bOpen then
    RefreshRemainTime(self.GunStormData:GetActGroupEndTime(), self._mapNode.txtActivityTime)
    if nil == self.remainTimer then
      self.remainTimer = self:AddTimer(0, 1, function()
        local remainTime = RefreshRemainTime(self.GunStormData:GetActGroupEndTime(), self._mapNode.txtActivityTime)
        if remainTime <= 0 then
          TimerManager.Remove(self.remainTimer)
          self.remainTimer = nil
        end
      end, true, true, false)
    end
  end
  self._mapNode.imgRemaineTime:SetActive(bOpen)
  self._mapNode.imgEnd:SetActive(not bOpen)
  local nOpenMonth, nOpenDay, nEndMonth, nEndDay, nOpenYear, nEndYear = self.GunStormData:GetActGroupDate()
  local strOpenDay = string.format("%d", nOpenDay)
  local strEndDay = string.format("%d", nEndDay)
  local dateStr = string.format("%s/%s/%s ~ %s/%s/%s", nOpenYear, nOpenMonth, strOpenDay, nEndYear, nEndMonth, strEndDay)
  NovaAPI.SetTMPText(self._mapNode.txtActivityDate, dateStr)
end

function GunStormCtrl:RefreshRemainOpenTime(openTime)
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

function GunStormCtrl:RefreshButtonState()
  self.tbActState = {}
  for i = 1, 5 do
    local actData = self.GunStormData:GetActivityDataByIndex(i)
    if i == AllEnum.ActivityThemeFuncIndex.MiniGame then
      self:RefreshMiniGameButtonState(actData)
    elseif i == AllEnum.ActivityThemeFuncIndex.Task then
      self:RefreshTaskButtonState(actData)
    elseif i == AllEnum.ActivityThemeFuncIndex.Level then
      self:RefreshLevelButtonState(actData)
    elseif i == AllEnum.ActivityThemeFuncIndex.Shop then
      self:RefreshShopButtonState(actData)
    elseif i == AllEnum.ActivityThemeFuncIndex.Story then
      self:RefreshStoryButtonState(actData)
    end
  end
end

function GunStormCtrl:RefreshButtonTimer(actData, timer, txtTrans, imgTrans, refreshFunc)
  local countDowmTimer
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
          if 0 < remainTime then
            local sTimeStr = self:RefreshRemainOpenTime(openTime)
            local txtUnlock = imgTrans:GetComponentInChildren(typeof(CS.TMPro.TMP_Text))
            if txtUnlock ~= nil then
              NovaAPI.SetTMPText(txtUnlock, sTimeStr)
            end
          else
            imgTrans:SetActive(false)
            TimerManager.Remove(countDowmTimer)
            countDowmTimer = nil
            self.tbActState[activityId] = ActivityState.Open
            refreshFunc(actData)
            self:RefreshActivityData()
          end
        end
        
        fcTimer()
        countDowmTimer = self:AddTimer(0, 1, fcTimer, true, true, false)
      end
    elseif state == ActivityState.Open and activityData.StartTime ~= "" and activityData.EndTime ~= "" then
      do
        local endTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.EndTime)
        if endTime > self.GunStormData:GetActGroupEndTime() then
          bShowCountDown = true
        elseif endTime < self.GunStormData:GetActGroupEndTime() then
          bShowCountDown = endTime - curTime <= 259200
        end
        if timer == nil and bShowCountDown then
          RefreshRemainTime(endTime, txtTrans)
          do
            local function fcTimer()
              local remainTime = RefreshRemainTime(endTime, txtTrans)
              
              if remainTime <= 0 then
                TimerManager.Remove(countDowmTimer)
                countDowmTimer = nil
                refreshFunc(actData)
              end
            end
            
            fcTimer()
            countDowmTimer = self:AddTimer(0, 1, fcTimer, true, true, false)
          end
        end
      end
    end
  end
  return state, bShowCountDown, countDowmTimer
end

function GunStormCtrl:RefreshMiniGameButtonState(actData)
  local activityId = actData.ActivityId
  local activityData = ConfigTable.GetData("Activity", activityId)
  if activityData ~= nil then
    local function refreshFunc(actData)
      self:RefreshMiniGameButtonState(actData)
    end
    
    local state, bShowCountDown, countDowmTimer = self:RefreshButtonTimer(actData, self.minigameRemainTimer, self._mapNode.txtMiniGameActivityTime, self._mapNode.imgMiniGameActivityUnlockTime, refreshFunc)
    if self.minigameRemainTimer == nil then
      self.minigameRemainTimer = countDowmTimer
    end
    self._mapNode.imgMiniGameActivityUnlockTime:SetActive(state == ActivityState.NotOpen)
    self._mapNode.imgMiniGameActivityTime.gameObject:SetActive(state == ActivityState.Open and bShowCountDown)
    self._mapNode.imgMiniGameEnd:SetActive(state == ActivityState.Closed)
    self._mapNode.txtMiniGame_End:SetActive(state == ActivityState.Closed)
    self._mapNode.txtMiniGameEnd.gameObject:SetActive(state == ActivityState.Closed)
    self._mapNode.goMiniGameEnd.gameObject:SetActive(state == ActivityState.Closed)
    if state ~= ActivityState.Open then
    end
    self.tbActState[activityId] = state
  end
end

function GunStormCtrl:RefreshTaskButtonState(actData)
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
    
    local state, bShowCountDown, countDowmTimer = self:RefreshButtonTimer(actData, self.taskRemainTimer, self._mapNode.txtTaskActivityTime, self._mapNode.imgTaskActivityUnlockTime, refreshFunc)
    if self.taskRemainTimer == nil then
      self.taskRemainTimer = countDowmTimer
    end
    if state == ActivityState.Closed and actInsData ~= nil then
      actInsData:RefreshTaskRedDot()
    end
    self._mapNode.imgTaskActivityTime:SetActive(state == ActivityState.Open and bShowCountDown)
    self._mapNode.txtTaskProgress_End:SetActive(state == ActivityState.Closed)
    self._mapNode.dbTaskEnd.gameObject:SetActive(state == ActivityState.Closed)
    self._mapNode.imgTaskEnd:SetActive(state == ActivityState.Closed)
    self._mapNode.txtTaskEnd.gameObject:SetActive(state == ActivityState.Closed)
    self._mapNode.imgTaskActivityUnlockTime:SetActive(state == ActivityState.NotOpen)
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

function GunStormCtrl:RefreshStoryButtonState(actData)
  local activityId = actData.ActivityId
  local activityData = ConfigTable.GetData("Activity", activityId)
  if activityData ~= nil then
    local function refreshFunc(actData)
      local avgData = PlayerData.Activity:GetActivityDataById(activityId)
      
      if nil ~= avgData then
        avgData:RefreshAvgRedDot()
      end
      self:RefreshStoryButtonState(actData)
    end
    
    local state, bShowCountDown, countDowmTimer = self:RefreshButtonTimer(actData, self.avgRemainTimer, self._mapNode.txtStoryActivityTime, self._mapNode.imgStoryActivityUnlockTime, refreshFunc)
    if self.avgRemainTimer == nil then
      self.avgRemainTimer = countDowmTimer
    end
    if state == ActivityState.Closed then
      local avgData = PlayerData.Activity:GetActivityDataById(activityId)
      if nil ~= avgData then
        avgData:RefreshAvgRedDot()
      end
    end
    self._mapNode.imgStoryActivityTime:SetActive(state == ActivityState.Open and bShowCountDown)
    self._mapNode.imgStoryActivityUnlockTime:SetActive(state == ActivityState.NotOpen)
    self._mapNode.goStoryEnd:SetActive(state == ActivityState.Closed)
    self._mapNode.imgStoryEnd:SetActive(state == ActivityState.Closed)
    self._mapNode.txtStory_End.gameObject:SetActive(state == ActivityState.Closed)
    self.tbActState[activityId] = state
  end
end

function GunStormCtrl:RefreshLevelButtonState(actData)
  local activityId = actData.ActivityId
  local activityData = ConfigTable.GetData("Activity", activityId)
  if activityData ~= nil then
    local function refreshFunc(actData)
      local activityLevelsData = PlayerData.Activity:GetActivityDataById(activityId)
      
      if nil ~= activityLevelsData then
        activityLevelsData:ChangeAllRedHot()
      end
      self:RefreshLevelButtonState(actData)
    end
    
    local state, bShowCountDown, countDowmTimer = self:RefreshButtonTimer(actData, self.levelRemainTimer, self._mapNode.txtLevelActivityTime, self._mapNode.imgLevelActivityUnlockTime, refreshFunc)
    if self.levelRemainTimer == nil then
      self.levelRemainTimer = countDowmTimer
    end
    if state == ActivityState.Closed then
      local activityLevelsData = PlayerData.Activity:GetActivityDataById(activityId)
      if nil ~= activityLevelsData then
        activityLevelsData:ChangeAllRedHot()
      end
    end
    self._mapNode.imgLevelActivityTime:SetActive(state == ActivityState.Open and bShowCountDown)
    self._mapNode.imgLevelActivityUnlockTime:SetActive(state == ActivityState.NotOpen)
    self._mapNode.imgLevelEnd:SetActive(state == ActivityState.Closed)
    self._mapNode.goLevelEnd:SetActive(state == ActivityState.Closed)
    self._mapNode.txtLevel_End.gameObject:SetActive(state == ActivityState.Closed)
    local animRoot = self._mapNode.btnEntrance_[5].transform:Find("AnimRoot"):GetComponent("Animator")
    animRoot.enabled = state == ActivityState.Open
    self.tbActState[activityId] = state
  end
end

function GunStormCtrl:RefreshShopButtonState(actData)
  local activityId = actData.ActivityId
  local activityData = ConfigTable.GetData("Activity", activityId)
  if activityData ~= nil then
    local function refreshFunc(actData)
      self:RefreshShopButtonState(actData)
    end
    
    local state, bShowCountDown, countDowmTimer = self:RefreshButtonTimer(actData, self.shopRemainTimer, self._mapNode.txtShopActivityTime, self._mapNode.imgShopActivityUnlockTime, refreshFunc)
    if self.shopRemainTimer == nil then
      self.shopRemainTimer = countDowmTimer
    end
    self._mapNode.imgShopActivityTime:SetActive(state == ActivityState.Open and bShowCountDown)
    self._mapNode.imgShopActivityUnlockTime:SetActive(state == ActivityState.NotOpen)
    self._mapNode.txtShopEnd.gameObject:SetActive(state == ActivityState.Closed)
    self._mapNode.imgShopEnd:SetActive(state == ActivityState.Closed)
    self._mapNode.txtShop_End:SetActive(state == ActivityState.Closed)
    self.tbActState[activityId] = state
  end
end

function GunStormCtrl:RequireActiviyData()
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

function GunStormCtrl:RefreshActivityData()
  if self.bRequiredActData then
    return
  end
  self:AddTimer(1, 3, self.RequireActiviyData, true, true, true)
end

function GunStormCtrl:OnBtn_ClickActivityEntrance(btn, nIndex)
  local actData = self.GunStormData:GetActivityDataByIndex(nIndex)
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
    local nTransitionIdx = self.ActivityGroupCfg.TransitionId
    if nTransitionIdx == nil or nTransitionIdx == 0 and nIndex == AllEnum.ActivityThemeFuncIndex.TrekkerVersus then
      nTransitionIdx = 30
    end
    if nTransitionIdx ~= 0 then
      EventManager.Hit(EventId.SetTransition, nTransitionIdx, function()
        EventManager.Hit(EventId.OpenPanel, actData.PanelId, actData.ActivityId)
      end)
    else
      EventManager.Hit(EventId.OpenPanel, actData.PanelId, actData.ActivityId)
    end
  end
end

return GunStormCtrl
