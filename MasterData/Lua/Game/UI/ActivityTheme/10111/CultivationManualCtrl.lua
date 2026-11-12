local BaseCtrl = require("GameCore.UI.BaseCtrl")
local CultivationManualCtrl = class("CultivationManualCtrl", BaseCtrl)
local ClientManager = CS.ClientManager.Instance
local TimerManager = require("GameCore.Timer.TimerManager")
local LocalData = require("GameCore.Data.LocalData")
local typeof = _ENV.typeof
local Animator = CS.UnityEngine.Animator
CultivationManualCtrl._mapNodeConfig = {
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
  txtMiniGame = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Mini_Game_Cookie"
  },
  imgMiniGameEnd = {},
  txtMiniGameEnd = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Mini_Game_Cookie"
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
  imgFateCardActivityUnlockTime = {},
  txtFateCardActivityUnlockTime = {sComponentName = "TMP_Text"},
  imgFateCardActivityTime = {},
  txtFateCardActivityTime = {sComponentName = "TMP_Text"},
  txtShopEnd = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Btn_Shop"
  },
  imgShopEnd = {},
  txtShop_End = {},
  txtTaskProgressEnd = {sComponentName = "TMP_Text"},
  dbTaskEnd = {},
  miniGameRedDot = {},
  redDotEntrance2 = {},
  storyRedDot = {},
  reddotLevel = {},
  reddotFatecard = {},
  goMiniGameEnd = {},
  imgStoryEnd = {}
}
CultivationManualCtrl._mapEventConfig = {}
local ActivityState = {
  NotOpen = 1,
  Open = 2,
  Closed = 3
}

function CultivationManualCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
  end
  self.ActData = PlayerData.Activity:GetActivityGroupDataById(self.nActId)
  if self.ActData ~= nil then
    self.ActivityGroupCfg = self.ActData.actGroupConfig
  end
end

function CultivationManualCtrl:OnEnable()
  self:RefreshPanel()
  for i = 1, 5 do
    local actData = self.ActData:GetActivityDataByIndex(i)
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
      elseif i == AllEnum.ActivityThemeFuncIndex.MiniGame then
        local bOld = LocalData.GetPlayerLocalData("Activity_MiniGame_10111_New") or state ~= ActivityState.Open
        RedDotManager.SetValid(RedDotDefine.Activity_GroupNew_MiniGame, {
          self.nActId
        }, not bOld)
        RedDotManager.RegisterNode(RedDotDefine.Activity_GroupNew_MiniGame, {
          self.nActId
        }, self._mapNode.miniGameRedDot)
      end
    end
  end
  local sAnimName = "CultivationManualPanel_Full"
  local sSoundName = "mode_10111_activity"
  if self.animRoot ~= nil then
    self.animRoot = self.gameObject:GetComponent(typeof(Animator))
    sAnimName = "CultivationManualPanel_Pullback"
    sSoundName = "mode_10111_activity_1"
  end
  self.animRoot = self.gameObject:GetComponent(typeof(Animator))
  if self.animRoot ~= nil then
    self.animRoot:Play(sAnimName, 0, 0)
  end
  CS.WwiseAudioManager.Instance:PlaySound(sSoundName)
end

function CultivationManualCtrl:OnDisable()
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

function CultivationManualCtrl:RefreshPanel()
  if self.ActData == nil or self.ActivityGroupCfg == nil then
    return
  end
  self:RefreshTime()
  self:RefreshButtonState()
end

function CultivationManualCtrl:RefreshTime()
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

function CultivationManualCtrl:RefreshRemainTime(endTime, txtComp)
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

function CultivationManualCtrl:RefreshRemainOpenTime(openTime)
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

function CultivationManualCtrl:RefreshButtonState()
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
    elseif i == AllEnum.ActivityThemeFuncIndex.Story then
      self:RefreshStoryButtonState(actData)
    end
  end
end

function CultivationManualCtrl:RefreshButtonTimer(actData, timer, txtTrans, imgTrans, refreshFunc)
  local countDowmTimer
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
  elseif state == ActivityState.Open and endTime ~= nil and timer == nil and bShowCountDown then
    self:RefreshRemainTime(endTime, txtTrans)
    
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
  return state, bShowCountDown, countDowmTimer
end

function CultivationManualCtrl:RefreshMiniGameButtonState(actData)
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

function CultivationManualCtrl:RefreshTaskButtonState(actData)
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

function CultivationManualCtrl:RefreshStoryButtonState(actData)
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
    local nDotweenStatus = state == ActivityState.Closed and 0 or 1
    NovaAPI.CtrlDotweenAnimation(self._mapNode.btnEntrance_[AllEnum.ActivityThemeFuncIndex.Story].gameObject, nDotweenStatus)
    self._mapNode.imgStoryActivityTime:SetActive(state == ActivityState.Open and bShowCountDown)
    self._mapNode.imgStoryActivityUnlockTime:SetActive(state == ActivityState.NotOpen)
    self._mapNode.goStoryEnd:SetActive(state == ActivityState.Closed)
    self._mapNode.imgStoryEnd:SetActive(state == ActivityState.Closed)
    self._mapNode.txtStory_End.gameObject:SetActive(state == ActivityState.Closed)
    self.tbActState[activityId] = state
  end
end

function CultivationManualCtrl:RefreshLevelButtonState(actData)
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
    local nDotweenStatus = state == ActivityState.Closed and 0 or 1
    NovaAPI.CtrlDotweenAnimation(self._mapNode.btnEntrance_[AllEnum.ActivityThemeFuncIndex.Level].gameObject, nDotweenStatus)
    self._mapNode.imgLevelActivityTime:SetActive(state == ActivityState.Open and bShowCountDown)
    self._mapNode.imgLevelActivityUnlockTime:SetActive(state == ActivityState.NotOpen)
    self._mapNode.imgLevelEnd:SetActive(state == ActivityState.Closed)
    self._mapNode.goLevelEnd:SetActive(state == ActivityState.Closed)
    self._mapNode.txtLevel_End.gameObject:SetActive(state == ActivityState.Closed)
    self.tbActState[activityId] = state
  end
end

function CultivationManualCtrl:RefreshShopButtonState(actData)
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

function CultivationManualCtrl:RefreshFateCardButtonState(actData)
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

function CultivationManualCtrl:RequireActiviyData()
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

function CultivationManualCtrl:RefreshActivityData()
  if self.bRequiredActData then
    return
  end
  self:AddTimer(1, 3, self.RequireActiviyData, true, true, true)
end

function CultivationManualCtrl:OnBtn_ClickActivityEntrance(btn, nIndex)
  local actData = self.ActData:GetActivityDataByIndex(nIndex)
  if actData == nil then
    return
  end
  local bOpen, _state, _sTips, bNeedRefreshData = self.ActData:CheckActivityEntranceOpen(actData.ActivityId, actData.PanelId, true, self.bRequiredActData)
  if not bOpen then
    if bNeedRefreshData then
      self:RequireActiviyData()
    end
    return
  end
  local nRandomTransitionId = math.random(50, 51)
  self.ActData:OpenActivityEntrance(actData.ActivityId, actData.PanelId, nRandomTransitionId)
end

return CultivationManualCtrl
