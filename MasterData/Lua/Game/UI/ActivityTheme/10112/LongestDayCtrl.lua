local BaseCtrl = require("GameCore.UI.BaseCtrl")
local LongestDayCtrl = class("LongestDayCtrl", BaseCtrl)
local ClientManager = CS.ClientManager.Instance
local TimerManager = require("GameCore.Timer.TimerManager")
local LocalData = require("GameCore.Data.LocalData")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
LongestDayCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  goBg = {sNodeName = "---Bg---"},
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
  imgMiniGameEnd = {},
  txtMiniGame = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Mini_Game_10112"
  },
  txtMiniGameEnd = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Mini_Game_10112"
  },
  txtMiniGame_End = {},
  txtMiniGameEndState = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_End"
  },
  imgMiniGameActivityUnlockTime = {},
  txtMiniGameActivityUnlockTime = {sComponentName = "TMP_Text"},
  imgMiniGameActivityTime = {},
  txtMiniGameActivityTime = {sComponentName = "TMP_Text"},
  dbMiniGame = {},
  dbMiniGameEnd = {},
  txtTask = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Task"
  },
  txtTaskProgress = {sComponentName = "TMP_Text"},
  imgTaskActivityTime = {},
  txtTaskActivityTime = {sComponentName = "TMP_Text"},
  txtTaskEndState = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_End"
  },
  imgTaskEnd = {},
  txtTaskEnd = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Task"
  },
  txtTaskProgress_End = {},
  imgTaskActivityUnlockTime = {},
  txtTaskActivityUnlockTime = {sComponentName = "TMP_Text"},
  txtTaskProgressEnd = {sComponentName = "TMP_Text"},
  dbTask = {},
  dbTaskEnd = {},
  txtStory1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Story1_10112"
  },
  txtStory1_End = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Story1_10112"
  },
  txtStory2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Story2_10112"
  },
  txtStory2_End = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Story2_10112"
  },
  goStoryEnd = {},
  txtStoryEnd = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_End"
  },
  imgStoryActivityTime = {},
  txtStoryActivityTime = {sComponentName = "TMP_Text"},
  imgStoryActivityUnlockTime = {},
  txtStoryActivityUnlockTime = {sComponentName = "TMP_Text"},
  dbStory = {},
  dbStoryEnd = {},
  txtShopEndState = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_End"
  },
  txtShop = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Shop"
  },
  txtShopEnd = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Shop"
  },
  imgShopEnd = {},
  txtShop_End = {},
  imgShopActivityTime = {},
  txtShopActivityTime = {sComponentName = "TMP_Text"},
  imgShopActivityUnlockTime = {},
  txtShopActivityUnlockTime = {sComponentName = "TMP_Text"},
  dbShop = {},
  dbShopEnd = {},
  txtLevel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Level"
  },
  txtLevelShadow = {
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
  imgLevelActivityTime = {},
  txtLevelActivityTime = {sComponentName = "TMP_Text"},
  grpBg = {},
  imgLevelEnd = {},
  miniGameRedDot = {},
  redDotEntrance2 = {},
  storyRedDot = {},
  reddotLevel = {},
  goMiniGameEnd = {},
  imgStoryEnd = {}
}
LongestDayCtrl._mapEventConfig = {}
local ActivityState = {
  NotOpen = 1,
  Open = 2,
  Closed = 3
}

function LongestDayCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
  end
  self.ActData = PlayerData.Activity:GetActivityGroupDataById(self.nActId)
  if self.ActData ~= nil then
    self.ActivityGroupCfg = self.ActData.actGroupConfig
  end
end

function LongestDayCtrl:OnEnable()
  self:RefreshPanel()
  for i = 1, 5 do
    local actData = self.ActData:GetActivityDataByIndex(i)
    local nActId = actData ~= nil and actData.ActivityId or 0
    local state = self.tbActState[nActId]
    if 0 < nActId and state ~= nil then
      if i == AllEnum.ActivityThemeFuncIndex.Task then
        if state == ActivityState.Closed then
          self._mapNode.redDotEntrance2:SetActive(false)
        else
          RedDotManager.RegisterNode(RedDotDefine.Activity_Group_Task, {
            self.nActId,
            nActId
          }, self._mapNode.redDotEntrance2)
        end
      elseif i == AllEnum.ActivityThemeFuncIndex.Level then
        RedDotManager.RegisterNode(RedDotDefine.ActivityLevel, {
          self.nActId,
          nActId
        }, self._mapNode.reddotLevel)
      elseif i == AllEnum.ActivityThemeFuncIndex.MiniGame then
        RedDotManager.RegisterNode(RedDotDefine.Activity_GoldenSpy, {
          self.nActId
        }, self._mapNode.miniGameRedDot)
      end
    end
  end
  self:SetEnterState()
end

function LongestDayCtrl:OnDisable()
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
  self:RedDotUnRegister()
end

function LongestDayCtrl:RedDotUnRegister()
  for i = 1, 5 do
    local actData = self.ActData:GetActivityDataByIndex(i)
    local nActId = actData ~= nil and actData.ActivityId or 0
    local state = self.tbActState[nActId]
    if 0 < nActId and state ~= nil then
      if i == AllEnum.ActivityThemeFuncIndex.Task then
        RedDotManager.UnRegisterNode(RedDotDefine.Activity_Group_Task, {
          self.nActId,
          nActId
        }, self._mapNode.redDotEntrance2)
      elseif i == AllEnum.ActivityThemeFuncIndex.Level then
        RedDotManager.UnRegisterNode(RedDotDefine.ActivityLevel, {
          self.nActId,
          nActId
        }, self._mapNode.reddotLevel)
      elseif i == AllEnum.ActivityThemeFuncIndex.MiniGame then
        RedDotManager.UnRegisterNode(RedDotDefine.Activity_GroupNew_MiniGame, {
          self.nActId
        }, self._mapNode.miniGameRedDot)
      end
    end
  end
end

function LongestDayCtrl:SetEnterState()
  local sAnimName = "LongestDayPanel_Full"
  local sAudioName = "Mode_10112_activity"
  if self.bFirstEnter then
    sAnimName = "LongestDayPanel_Pullback"
    sAudioName = "Mode_10112_activity_01"
  end
  self.bFirstEnter = true
  self.animRoot = self.gameObject:GetComponent("Animator")
  self.animRoot:Play(sAnimName, 0, 0)
  WwiseAudioMgr:PostEvent(sAudioName)
end

function LongestDayCtrl:RefreshPanel()
  if self.ActData == nil or self.ActivityGroupCfg == nil then
    return
  end
  self:RefreshTime()
  self:RefreshButtonState()
end

function LongestDayCtrl:RefreshTime()
  local bOpen = self.ActData:CheckActivityGroupOpen()
  if bOpen then
    self:RefreshRemainTime(self.ActData:GetActGroupEndTime(), self._mapNode.txtActivityTime)
    if nil == self.remainTimer then
      self.remainTimer = self:AddTimer(0, 1, function()
        local remainTime = self:RefreshRemainTime(self.ActData:GetActGroupEndTime(), self._mapNode.txtActivityTime)
        if remainTime <= 0 then
          TimerManager.Remove(self.remainTimer)
          self.remainTimer = nil
        end
      end, true, true, false)
    end
  end
  self._mapNode.imgRemaineTime:SetActive(bOpen)
  self._mapNode.imgEnd:SetActive(not bOpen)
  local nOpenMonth, nOpenDay, nEndMonth, nEndDay, nOpenYear, nEndYear = self.ActData:GetActGroupDate()
  local strOpenDay = string.format("%d", nOpenDay)
  local strEndDay = string.format("%d", nEndDay)
  local dateStr = string.format("%s/%s/%s ~ %s/%s/%s", nOpenYear, nOpenMonth, strOpenDay, nEndYear, nEndMonth, strEndDay)
  NovaAPI.SetTMPText(self._mapNode.txtActivityDate, dateStr)
end

function LongestDayCtrl:RefreshRemainTime(endTime, txtComp)
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

function LongestDayCtrl:RefreshRemainOpenTime(openTime)
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

function LongestDayCtrl:RefreshButtonState()
  self.tbActState = {}
  for i = 1, 5 do
    local actData = self.ActData:GetActivityDataByIndex(i)
    if i == AllEnum.ActivityThemeFuncIndex.MiniGame then
      self:RefreshMiniGameButtonState(actData)
    elseif i == AllEnum.ActivityThemeFuncIndex.Task then
      self:RefreshTaskButtonState(actData)
    elseif i == AllEnum.ActivityThemeFuncIndex.Level then
      self:RefreshLevelButtonState(actData)
    elseif i == AllEnum.ActivityThemeFuncIndex.Shop then
      self:RefreshShopButtonState(actData)
    end
  end
  self:RefreshStoryButtonState()
end

function LongestDayCtrl:RefreshButtonTimer(actData, timer, txtTrans, imgTrans, refreshFunc)
  local countDownTimer
  local activityId = actData.ActivityId
  local state, bShowCountDown, openTime, endTime = self.ActData:GetActivityEntranceTimerData(activityId)
  if state == ActivityState.NotOpen then
    if nil == timer and openTime ~= nil then
      local function fcTimer()
        local curTime = ClientManager.serverTimeStamp
        
        local remainTime = openTime - curTime
        if 0 < remainTime then
          local sTimeStr = self:RefreshRemainOpenTime(openTime)
          local txtUnlock = imgTrans:GetComponentInChildren(typeof(CS.TMPro.TMP_Text))
          if txtUnlock ~= nil then
            NovaAPI.SetTMPText(txtUnlock, sTimeStr)
          end
        else
          imgTrans:SetActive(false)
          TimerManager.Remove(countDownTimer)
          countDownTimer = nil
          self.tbActState[activityId] = ActivityState.Open
          refreshFunc(actData)
          self:RefreshActivityData()
        end
      end
      
      fcTimer()
      countDownTimer = self:AddTimer(0, 1, fcTimer, true, true, false)
    end
  elseif state == ActivityState.Open and endTime ~= nil and timer == nil and bShowCountDown then
    self:RefreshRemainTime(endTime, txtTrans)
    
    local function fcTimer()
      local remainTime = self:RefreshRemainTime(endTime, txtTrans)
      if remainTime <= 0 then
        TimerManager.Remove(countDownTimer)
        countDownTimer = nil
        refreshFunc(actData)
      end
    end
    
    fcTimer()
    countDownTimer = self:AddTimer(0, 1, fcTimer, true, true, false)
  end
  return state, bShowCountDown, countDownTimer
end

function LongestDayCtrl:RefreshMiniGameButtonState(actData)
  local activityId = actData.ActivityId
  local activityData = ConfigTable.GetData("Activity", activityId)
  if activityData ~= nil then
    local function refreshFunc(actData)
      self:RefreshMiniGameButtonState(actData)
    end
    
    local state, bShowCountDown, countDownTimer = self:RefreshButtonTimer(actData, self.minigameRemainTimer, self._mapNode.txtMiniGameActivityTime, self._mapNode.imgMiniGameActivityUnlockTime, refreshFunc)
    if self.minigameRemainTimer == nil then
      self.minigameRemainTimer = countDownTimer
    end
    self._mapNode.imgMiniGameActivityUnlockTime:SetActive(state == ActivityState.NotOpen)
    self._mapNode.imgMiniGameActivityTime.gameObject:SetActive(state == ActivityState.Open and bShowCountDown)
    self._mapNode.imgMiniGameEnd:SetActive(state == ActivityState.Closed)
    self._mapNode.txtMiniGame_End:SetActive(state == ActivityState.Closed)
    self._mapNode.txtMiniGameEnd.gameObject:SetActive(state == ActivityState.Closed)
    self._mapNode.goMiniGameEnd.gameObject:SetActive(state == ActivityState.Closed)
    self._mapNode.dbMiniGame.gameObject:SetActive(state ~= ActivityState.Closed)
    self._mapNode.dbMiniGameEnd.gameObject:SetActive(state == ActivityState.Closed)
    self.tbActState[activityId] = state
  end
end

function LongestDayCtrl:RefreshTaskButtonState(actData)
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
    
    local state, bShowCountDown, countDownTimer = self:RefreshButtonTimer(actData, self.taskRemainTimer, self._mapNode.txtTaskActivityTime, self._mapNode.imgTaskActivityUnlockTime, refreshFunc)
    if self.taskRemainTimer == nil then
      self.taskRemainTimer = countDownTimer
    end
    if state == ActivityState.Closed and actInsData ~= nil then
      actInsData:RefreshTaskRedDot()
    end
    self._mapNode.imgTaskActivityTime:SetActive(state == ActivityState.Open and bShowCountDown)
    self._mapNode.txtTaskProgress_End:SetActive(state == ActivityState.Closed)
    self._mapNode.imgTaskEnd.gameObject:SetActive(state == ActivityState.Closed)
    self._mapNode.txtTaskEnd.gameObject:SetActive(state == ActivityState.Closed)
    self._mapNode.imgTaskActivityUnlockTime:SetActive(state == ActivityState.NotOpen)
    self._mapNode.dbTask.gameObject:SetActive(state ~= ActivityState.Closed)
    self._mapNode.dbTaskEnd.gameObject:SetActive(state == ActivityState.Closed)
    self._mapNode.txtTaskProgressEnd.gameObject:SetActive(state == ActivityState.Closed)
    self.tbActState[activityId] = state
    local nDone, nTotal = 0, 0
    if actInsData ~= nil then
      nDone, nTotal = actInsData:CalcTotalProgress()
    end
    local progress = string.format("%d/%d", nDone, nTotal)
    NovaAPI.SetTMPText(self._mapNode.txtTaskProgress, progress)
    NovaAPI.SetTMPText(self._mapNode.txtTaskProgressEnd, progress)
  end
end

function LongestDayCtrl:RefreshLevelButtonState(actData)
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
    
    local state, bShowCountDown, countDownTimer = self:RefreshButtonTimer(actData, self.levelRemainTimer, self._mapNode.txtLevelActivityTime, self._mapNode.imgLevelActivityUnlockTime, refreshFunc)
    if self.levelRemainTimer == nil then
      self.levelRemainTimer = countDownTimer
    end
    if state == ActivityState.Closed then
      local activityLevelsData = PlayerData.Activity:GetActivityDataById(activityId)
      if nil ~= activityLevelsData then
        activityLevelsData:ChangeAllRedHot()
      end
    end
    self._mapNode.imgLevelActivityTime:SetActive(state == ActivityState.Open and bShowCountDown)
    self._mapNode.imgLevelActivityUnlockTime:SetActive(state == ActivityState.NotOpen)
    self._mapNode.goLevelEnd:SetActive(state == ActivityState.Closed)
    self._mapNode.txtLevel_End.gameObject:SetActive(state == ActivityState.Closed)
    self._mapNode.grpBg:SetActive(state ~= ActivityState.Closed)
    self._mapNode.imgLevelEnd:SetActive(state == ActivityState.Closed)
    self.tbActState[activityId] = state
    local anim = self._mapNode.btnEntrance_[AllEnum.ActivityThemeFuncIndex.Level].transform:GetChild(0):GetComponent("Animator")
    anim.enabled = state == ActivityState.Open
  end
end

function LongestDayCtrl:RefreshShopButtonState(actData)
  local activityId = actData.ActivityId
  local activityData = ConfigTable.GetData("Activity", activityId)
  if activityData ~= nil then
    local function refreshFunc(actData)
      self:RefreshShopButtonState(actData)
    end
    
    local state, bShowCountDown, countDownTimer = self:RefreshButtonTimer(actData, self.shopRemainTimer, self._mapNode.txtShopActivityTime, self._mapNode.imgShopActivityUnlockTime, refreshFunc)
    if self.shopRemainTimer == nil then
      self.shopRemainTimer = countDownTimer
    end
    self._mapNode.imgShopActivityTime:SetActive(state == ActivityState.Open and bShowCountDown)
    self._mapNode.imgShopActivityUnlockTime:SetActive(state == ActivityState.NotOpen)
    self._mapNode.txtShopEnd.gameObject:SetActive(state == ActivityState.Closed)
    self._mapNode.imgShopEnd:SetActive(state == ActivityState.Closed)
    self._mapNode.txtShop_End:SetActive(state == ActivityState.Closed)
    self._mapNode.dbShop:SetActive(state ~= ActivityState.Closed)
    self._mapNode.dbShopEnd:SetActive(state == ActivityState.Closed)
    self.tbActState[activityId] = state
  end
end

function LongestDayCtrl:RefreshStoryButtonState()
  self._mapNode.storyRedDot:SetActive(false)
  self._mapNode.imgStoryActivityTime:SetActive(false)
  self._mapNode.imgStoryActivityUnlockTime:SetActive(false)
  self._mapNode.goStoryEnd:SetActive(false)
  self._mapNode.imgStoryEnd:SetActive(false)
  self._mapNode.txtStory1_End.gameObject:SetActive(false)
  self._mapNode.txtStory2_End.gameObject:SetActive(false)
  self._mapNode.dbStory.gameObject:SetActive(true)
  self._mapNode.dbStoryEnd.gameObject:SetActive(false)
end

function LongestDayCtrl:RequireActivityData()
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

function LongestDayCtrl:RefreshActivityData()
  if self.bRequiredActData then
    return
  end
  self:AddTimer(1, 3, function()
    self:RequireActivityData()
  end, true, true, true)
end

function LongestDayCtrl:OnBtn_ClickActivityEntrance(btn, nIndex)
  if nIndex == AllEnum.ActivityThemeFuncIndex.Story then
    local chapterId = 10
    local isUnlock = PlayerData.Avg:IsStoryChapterUnlock(chapterId)
    if isUnlock then
      EventManager.Hit(EventId.OpenPanel, PanelId.MainlineEx, chapterId)
    else
      local sLockReadTipsKey = "Mainline_Preview_Lock_Read_" .. chapterId
      if LocalData.GetPlayerLocalData(sLockReadTipsKey) then
        EventManager.Hit(EventId.OpenPanel, PanelId.MainlineEx, chapterId)
        return
      end
      local sTip = ConfigTable.GetUIText("Mainline_Preview_Lock_Read")
      local msg = {
        nType = AllEnum.MessageBox.Confirm,
        sContent = sTip,
        callbackConfirm = function()
          LocalData.SetPlayerLocalData(sLockReadTipsKey, true)
          EventManager.Hit(EventId.OpenPanel, PanelId.MainlineEx, chapterId)
        end
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
    end
    return
  end
  local actData = self.ActData:GetActivityDataByIndex(nIndex)
  if actData == nil then
    return
  end
  local bOpen, _state, _sTips, bNeedRefreshData = self.ActData:CheckActivityEntranceOpen(actData.ActivityId, actData.PanelId, true, self.bRequiredActData)
  if not bOpen then
    if bNeedRefreshData then
      self:RequireActivityData()
    end
    return
  end
  self.ActData:OpenActivityEntrance(actData.ActivityId, actData.PanelId)
end

return LongestDayCtrl
