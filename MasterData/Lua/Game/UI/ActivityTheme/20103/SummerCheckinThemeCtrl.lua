local BaseCtrl = require("GameCore.UI.BaseCtrl")
local SummerCheckinThemeCtrl = class("SummerCheckinThemeCtrl", BaseCtrl)
local ClientManager = CS.ClientManager.Instance
local TimerManager = require("GameCore.Timer.TimerManager")
local LocalData = require("GameCore.Data.LocalData")
SummerCheckinThemeCtrl._mapNodeConfig = {
  goBg = {sNodeName = "---Bg---"},
  btnEntrance_ = {
    nCount = 7,
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
    sLanguageId = "IceCreamTruck_PlayTitle"
  },
  imgMiniGameEnd = {},
  txtMiniGameEnd = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_PlayTitle"
  },
  txtMiniGame_End = {},
  txtTask = {
    sComponentName = "TMP_Text",
    sLanguageId = "Cookie_Act_QuestTitle"
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
    sLanguageId = "JointDrill_Btn_Shop"
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
    sLanguageId = "Cookie_Act_QuestTitle"
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
    sLanguageId = "JointDrill_Btn_Shop"
  },
  imgShopEnd = {},
  txtShop_End = {},
  txtTaskProgressEnd = {sComponentName = "TMP_Text"},
  txtShow = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_ChallengeTitle"
  },
  imgShowEnd = {},
  imgShowActivityTime = {},
  txtShowActivityTime = {sComponentName = "TMP_Text"},
  goShowEnd = {},
  txtShowEnd = {
    sNodeName = "txtShow_End",
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_ChallengeTitle"
  },
  imgShowActivityUnlockTime = {},
  txtShowActivityUnlockTime = {sComponentName = "TMP_Text"},
  imgShowLock = {},
  txtLock = {sComponentName = "TMP_Text"},
  imgFateCard = {sComponentName = "Image"},
  txtFateCard = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Fate_Card_20102"
  },
  imgFateCardEnd = {},
  txtFateCardEnd = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Fate_Card_20102"
  },
  txtFateCard_End = {},
  goFateCardEnd = {},
  txtFateCardEndState = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_End"
  },
  imgFateCardActivityUnlockTime = {},
  txtFateCardActivityUnlockTime = {sComponentName = "TMP_Text"},
  imgFateCardActivityTime = {},
  txtFateCardActivityTime = {sComponentName = "TMP_Text"},
  reddotShow = {},
  dbTaskEnd = {},
  dbFateCardEnd = {},
  miniGameRedDot = {},
  redDotEntrance2 = {},
  storyRedDot = {},
  reddotLevel = {},
  reddotFatecard = {},
  goMiniGameEnd = {},
  imgStoryEnd = {}
}
SummerCheckinThemeCtrl._mapEventConfig = {}
local ActivityState = {
  NotOpen = 1,
  Open = 2,
  Closed = 3
}

function SummerCheckinThemeCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
  end
  self.SummerCheckinData = PlayerData.Activity:GetActivityGroupDataById(self.nActId)
  if self.SummerCheckinData ~= nil then
    self.ActivityGroupCfg = self.SummerCheckinData.actGroupConfig
  end
  self.tbBtnAnimator = {}
end

function SummerCheckinThemeCtrl:OnEnable()
  if #self.tbBtnAnimator == 0 then
    for k, v in pairs(self._mapNode.btnEntrance_) do
      local anim = v.transform:GetChild(0):GetComponent("Animator")
      if anim ~= nil and anim:IsNull() == false then
        table.insert(self.tbBtnAnimator, anim)
        anim.enabled = false
      end
    end
  end
  self:RefreshPanel()
  self:RegisterReddot()
  local sAnimName = "SummerCheckinPanel_Pullback"
  local sSoundName = "mode_20103_activity"
  if self.animRoot ~= nil then
    self.animRoot = self.gameObject:GetComponent("Animator")
    sAnimName = "SummerCheckinPanel_Full"
    sSoundName = "mode_20103_activity_1"
  end
  self.animRoot = self.gameObject:GetComponent("Animator")
  self.animRoot.enabled = true
  local nAnimLength = NovaAPI.GetAnimClipLength(self.animRoot, {sAnimName})
  self.animRoot:Play(sAnimName, 0, 0)
  CS.WwiseAudioManager.Instance:PlaySound(sSoundName)
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimLength)
  self:AddTimer(1, nAnimLength, function()
    self.animRoot.enabled = false
    for k, v in pairs(self.tbBtnAnimator) do
      v.enabled = true
      v:Play("btnEntrance_idle")
    end
  end, true, true, true)
end

function SummerCheckinThemeCtrl:OnDisable()
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
  if nil ~= self.showRemainTimer then
    TimerManager.Remove(self.showRemainTimer)
    self.showRemainTimer = nil
  end
  for i = 1, #self.tbBtnAnimator do
    self.tbBtnAnimator[i] = nil
  end
end

function SummerCheckinThemeCtrl:RegisterReddot()
  for i = 1, 7 do
    local actData = self.SummerCheckinData:GetActivityDataByIndex(i)
    local nActId = actData ~= nil and actData.ActivityId or 0
    local state = self.tbActState[nActId]
    if nActId ~= nil and 0 < nActId and state ~= nil then
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
      elseif i == AllEnum.ActivityThemeFuncIndex.Story then
        RedDotManager.RegisterNode(RedDotDefine.Activity_GroupNew_Avg_Group, {
          self.nActId,
          nActId
        }, self._mapNode.storyRedDot)
      elseif i == AllEnum.ActivityThemeFuncIndex.TrekkerVersus then
        local activityData = ConfigTable.GetData("Activity", actData.ActivityId)
        local nNeedWorldLevel = tonumber(activityData.LimitParam) or 0
        if nNeedWorldLevel > PlayerData.Base:GetWorldClass() then
          self._mapNode.reddotShow:SetActive(false)
        else
          RedDotManager.RegisterNode(RedDotDefine.TrekkerVersus, {
            self.nActId,
            nActId
          }, self._mapNode.reddotShow)
        end
      elseif i == AllEnum.ActivityThemeFuncIndex.FateCard then
        RedDotManager.RegisterNode(RedDotDefine.Activity_Group_PenguinCard_Level, {
          self.nActId
        }, self._mapNode.reddotFatecard)
      elseif i == AllEnum.ActivityThemeFuncIndex.MiniGame then
        local nActId = actData.ActivityId
        RedDotManager.RegisterNode(RedDotDefine.Activity_IceCreamTruck_New, {nActId}, self._mapNode.miniGameRedDot)
      end
    end
  end
end

function SummerCheckinThemeCtrl:RefreshPanel()
  if self.SummerCheckinData == nil or self.ActivityGroupCfg == nil then
    return
  end
  self:RefreshTime()
  self:RefreshButtonState()
end

function SummerCheckinThemeCtrl:RefreshTime()
  local bOpen = self.SummerCheckinData:CheckActivityGroupOpen()
  if bOpen then
    self:RefreshRemainTime(self.SummerCheckinData:GetActGroupEndTime(), self._mapNode.txtActivityTime)
    if nil == self.remainTimer then
      self.remainTimer = self:AddTimer(0, 1, function()
        local remainTime = self:RefreshRemainTime(self.SummerCheckinData:GetActGroupEndTime(), self._mapNode.txtActivityTime)
        if remainTime <= 0 then
          TimerManager.Remove(self.remainTimer)
          self.remainTimer = nil
        end
      end, true, true, false)
    end
  end
  self._mapNode.imgRemaineTime:SetActive(bOpen)
  self._mapNode.imgEnd:SetActive(not bOpen)
  local nOpenMonth, nOpenDay, nEndMonth, nEndDay, nOpenYear, nEndYear = self.SummerCheckinData:GetActGroupDate()
  local strOpenDay = string.format("%d", nOpenDay)
  local strEndDay = string.format("%d", nEndDay)
  local dateStr = string.format("%s/%s/%s ~ %s/%s/%s", nOpenYear, nOpenMonth, strOpenDay, nEndYear, nEndMonth, strEndDay)
  NovaAPI.SetTMPText(self._mapNode.txtActivityDate, dateStr)
end

function SummerCheckinThemeCtrl:RefreshRemainTime(endTime, txtComp)
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

function SummerCheckinThemeCtrl:RefreshRemainOpenTime(openTime)
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

function SummerCheckinThemeCtrl:RefreshButtonState()
  self.tbActState = {}
  for i = 1, 7 do
    local actData = self.SummerCheckinData:GetActivityDataByIndex(i)
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
    elseif i == AllEnum.ActivityThemeFuncIndex.TrekkerVersus then
      self:RefreshOtherButtonState(actData)
    elseif i == AllEnum.ActivityThemeFuncIndex.FateCard then
      self:RefreshFateCardButtonState(actData)
    end
  end
end

function SummerCheckinThemeCtrl:RefreshButtonTimer(actData, timer, txtTrans, imgTrans, refreshFunc)
  local countDowmTimer
  local activityId = actData.ActivityId
  local activityData = ConfigTable.GetData("Activity", activityId)
  local sEndTime = activityData.EndTime
  if activityData ~= nil and (activityData.ActivityType == GameEnum.activityType.Story or activityData.ActivityType == GameEnum.activityType.HistoryStory) and activityData.MidGroupId ~= nil and activityData.MidGroupId > 0 then
    local activityGroupData = ConfigTable.GetData("ActivityGroup", activityData.MidGroupId)
    if activityGroupData ~= nil and activityGroupData.StoryShowTime ~= nil and activityGroupData.StoryShowTime ~= "" then
      sEndTime = activityGroupData.StoryShowTime
    end
  end
  local state = ActivityState.NotOpen
  local bShowCountDown = false
  if activityData ~= nil then
    local curTime = ClientManager.serverTimeStamp
    if activityData.StartTime ~= "" and sEndTime ~= "" then
      local openTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.StartTime)
      local endTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(sEndTime)
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
      if nil == timer and activityData.StartTime ~= "" and sEndTime ~= "" then
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
    elseif state == ActivityState.Open and activityData.StartTime ~= "" and sEndTime ~= "" then
      do
        local endTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(sEndTime)
        if endTime > self.SummerCheckinData:GetActGroupEndTime() then
          bShowCountDown = true
        elseif endTime < self.SummerCheckinData:GetActGroupEndTime() then
          bShowCountDown = endTime - curTime <= 259200
        elseif sEndTime ~= activityData.EndTime and sEndTime ~= "" then
          bShowCountDown = true
        end
        if timer == nil and bShowCountDown then
          self:RefreshRemainTime(endTime, txtTrans)
          do
            local function fcTimer()
              local remainTime = self:RefreshRemainTime(endTime, txtTrans)
              
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

function SummerCheckinThemeCtrl:RefreshMiniGameButtonState(actData)
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

function SummerCheckinThemeCtrl:RefreshTaskButtonState(actData)
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
    self._mapNode.imgTaskEnd.gameObject:SetActive(state == ActivityState.Closed)
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

function SummerCheckinThemeCtrl:RefreshStoryButtonState(actData)
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
    
    local state, bShowCountDown, countDowmTimer = self:RefreshButtonTimer(actData, self.avgRemainTimer, self._mapNode.txtStoryActivityTime, self._mapNode.imgStoryActivityTime, refreshFunc)
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

function SummerCheckinThemeCtrl:RefreshLevelButtonState(actData)
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
    self.tbActState[activityId] = state
  end
end

function SummerCheckinThemeCtrl:RefreshShopButtonState(actData)
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

function SummerCheckinThemeCtrl:RefreshOtherButtonState(actData)
  local activityId = actData.ActivityId
  local activityData = ConfigTable.GetData("Activity", activityId)
  if activityData ~= nil then
    local nNeedWorldLevel = tonumber(activityData.LimitParam) or 0
    local bNeedLv = nNeedWorldLevel <= PlayerData.Base:GetWorldClass()
    
    local function refreshFunc(actData)
      self:RefreshOtherButtonState(actData)
    end
    
    local state, bShowCountDown, countDowmTimer
    if bNeedLv then
      state, bShowCountDown, countDowmTimer = self:RefreshButtonTimer(actData, self.showRemainTimer, self._mapNode.txtShowActivityTime, self._mapNode.imgShowActivityUnlockTime, refreshFunc)
      if self.showRemainTimer == nil then
        self.showRemainTimer = countDowmTimer
      end
    else
      state = ActivityState.NotOpen
    end
    self._mapNode.imgShowActivityTime:SetActive(state == ActivityState.Open and bShowCountDown)
    self._mapNode.imgShowActivityUnlockTime:SetActive(state == ActivityState.NotOpen and bNeedLv)
    self._mapNode.imgShowEnd:SetActive(state == ActivityState.Closed or not bNeedLv)
    self._mapNode.txtShow.gameObject:SetActive(state ~= ActivityState.Closed and bNeedLv)
    self._mapNode.txtShowEnd.gameObject:SetActive(state == ActivityState.Closed or not bNeedLv)
    self._mapNode.goShowEnd:SetActive(state == ActivityState.Closed)
    self._mapNode.imgShowLock:SetActive(state == ActivityState.NotOpen and not bNeedLv)
    local txtLock = orderedFormat(ConfigTable.GetUIText("ActivityEnter_Lock"), nNeedWorldLevel)
    NovaAPI.SetTMPText(self._mapNode.txtLock, txtLock)
    self.tbActState[activityId] = state
  end
end

function SummerCheckinThemeCtrl:RefreshFateCardButtonState(actData)
  local activityId = actData.ActivityId
  local activityData = ConfigTable.GetData("Activity", activityId)
  if activityData ~= nil then
    local function refreshFunc(actData)
      self:RefreshFateCardButtonState(actData)
    end
    
    local state, bShowCountDown, countDowmTimer = self:RefreshButtonTimer(actData, self.fateCardRemainTimer, self._mapNode.txtFateCardActivityTime, self._mapNode.imgFateCardActivityUnlockTime, refreshFunc)
    if self.fateCardRemainTimer == nil then
      self.fateCardRemainTimer = countDowmTimer
    end
    self._mapNode.imgFateCardActivityUnlockTime:SetActive(state == ActivityState.NotOpen)
    self._mapNode.imgFateCardActivityTime.gameObject:SetActive(state == ActivityState.Open and bShowCountDown)
    self._mapNode.imgFateCardEnd:SetActive(state == ActivityState.Closed)
    self._mapNode.txtFateCard_End:SetActive(state == ActivityState.Closed)
    self._mapNode.txtFateCardEnd.gameObject:SetActive(state == ActivityState.Closed)
    self._mapNode.goFateCardEnd.gameObject:SetActive(state == ActivityState.Closed)
    self._mapNode.dbFateCardEnd:SetActive(state == ActivityState.Closed)
    self.tbActState[activityId] = state
  end
end

function SummerCheckinThemeCtrl:RequireActiviyData()
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

function SummerCheckinThemeCtrl:RefreshActivityData()
  if self.bRequiredActData then
    return
  end
  self:AddTimer(1, 3, self.RequireActiviyData, true, true, true)
end

function SummerCheckinThemeCtrl:OnBtn_ClickActivityEntrance(btn, nIndex)
  local actData = self.SummerCheckinData:GetActivityDataByIndex(nIndex)
  local state = self.tbActState[actData.ActivityId]
  if nil == state then
    return
  end
  if state == ActivityState.Closed then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_End_Notice"))
    return
  elseif state == ActivityState.NotOpen then
    if nIndex == AllEnum.ActivityThemeFuncIndex.TrekkerVersus then
      local activityData = ConfigTable.GetData("Activity", actData.ActivityId)
      if activityData ~= nil then
        local nNeedWorldLevel = tonumber(activityData.LimitParam) or 0
        local bNeedLv = nNeedWorldLevel <= PlayerData.Base:GetWorldClass()
        if not bNeedLv then
          local txtLock = orderedFormat(ConfigTable.GetUIText("ActivityEnter_Lock"), nNeedWorldLevel)
          EventManager.Hit(EventId.OpenMessageBox, txtLock)
          return
        end
      end
    end
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
      LocalData.SetPlayerLocalData("Activity_MiniGame_20103_New", true)
      RedDotManager.SetValid(RedDotDefine.Activity_GroupNew_MiniGame, {
        actData.ActivityId
      }, false)
      EventManager.Hit(EventId.OpenPanel, actData.PanelId, actData.ActivityId, self.nActId)
    else
      local nTransitionIdx = self.ActivityGroupCfg.TransitionId
      if (nTransitionIdx == nil or nTransitionIdx == 0) and nIndex == AllEnum.ActivityThemeFuncIndex.TrekkerVersus then
        nTransitionIdx = 30
      end
      if nTransitionIdx ~= nil and 0 < nTransitionIdx then
        EventManager.Hit(EventId.SetTransition, nTransitionIdx, function()
          EventManager.Hit(EventId.OpenPanel, actData.PanelId, actData.ActivityId)
        end)
      else
        EventManager.Hit(EventId.OpenPanel, actData.PanelId, actData.ActivityId)
      end
    end
  end
end

return SummerCheckinThemeCtrl
