local CookieGameCtrl = class("CookieGameCtrl", BaseCtrl)
local TimerManager = require("GameCore.Timer.TimerManager")
local ClientManager = CS.ClientManager.Instance
CookieGameCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  goDailyModeInfo = {},
  goNightmareModeInfo = {},
  goDailyOn = {},
  goNightmareOn = {},
  goDailyOff = {},
  goNightmareOff = {},
  goNightmareLock = {},
  iconNightmareLock = {},
  btnDaily = {
    sNodeName = "goDailyOff",
    sComponentName = "UIButton",
    callback = "OnBtnClick_DailyMode"
  },
  btnNightmare = {
    sNodeName = "goNightmareOff",
    sComponentName = "UIButton",
    callback = "OnBtnClick_NightmareMode"
  },
  txtDailyOn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Cookie_Act_DailyMode"
  },
  txtNightmareOn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Cookie_Act_NightmareMode"
  },
  txtDailyOff = {
    sComponentName = "TMP_Text",
    sLanguageId = "Cookie_Act_DailyMode"
  },
  txtNightmareOff = {
    sComponentName = "TMP_Text",
    sLanguageId = "Cookie_Act_NightmareMode"
  },
  imgModeIcon = {sComponentName = "Image"},
  txtLevelTitle = {sComponentName = "TMP_Text"},
  txtLevelTitleNM = {sComponentName = "TMP_Text"},
  txtLevelDesc = {sComponentName = "TMP_Text"},
  txtLevelDescNM = {sComponentName = "TMP_Text"},
  txtLabelLevelGoal = {
    sComponentName = "TMP_Text",
    sLanguageId = "Cookie_Act_Level_Goal"
  },
  txtLabelHighScore = {
    sComponentName = "TMP_Text",
    sLanguageId = "Cookie_Act_Level_HighScore"
  },
  txtNormalHighScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Cookie_Act_Level_HighScore"
  },
  txtNormalHighScoreNum = {sComponentName = "TMP_Text"},
  imgNormalHighScore = {},
  txtLabelLevelGoalDesc = {sComponentName = "TMP_Text"},
  txtLabelHighScoreNum = {sComponentName = "TMP_Text"},
  txtLabelLevelReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "Cookie_Act_Level_Reward"
  },
  imgNew = {},
  btnEnter = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Enter"
  },
  txtEnterDaily = {
    sComponentName = "TMP_Text",
    sLanguageId = "Cookie_Act_Level_Go"
  },
  txtEnterDailyGray = {sComponentName = "TMP_Text"},
  txtEnterNMGray = {sComponentName = "TMP_Text"},
  txtNM = {
    sComponentName = "TMP_Text",
    sLanguageId = "WeeklyBoss_Chanllenge"
  },
  item = {
    nCount = 3,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btnItem = {nCount = 3, sComponentName = "UIButton"},
  svLevel = {
    sComponentName = "LoopScrollView"
  },
  btnQuestDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_QuestDetail"
  },
  imgFill = {sComponentName = "Image"},
  txtProgress = {sComponentName = "TMP_Text"},
  txtQuestTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Cookie_Act_QuestTitle"
  },
  redDotQuest = {},
  animLevels = {sNodeName = "goLevels", sComponentName = "Animator"}
}
CookieGameCtrl._mapEventConfig = {
  CookieLevelUpdate = "OnEvent_CookieLevelUpdate",
  CookieLevelReward = "OnEvent_CookieLevelReward"
}

function CookieGameCtrl:Refresh()
  self._mapNode.svLevel.gameObject:SetActive(true)
  if self.nSelectedMode == GameEnum.CookiePackModel.CookiePackNormalModel then
    self.nCurSelectLevelIndex = self:GetLastesetLevelId()
  elseif self.nSelectedMode == GameEnum.CookiePackModel.CookiePackNightmareModel then
    self.nCurSelectLevelIndex = nil
    self._mapNode.svLevel.gameObject:SetActive(false)
  end
  self:RefreshLevelData()
  self:RefreshLevelInfoPage(self.nCurSelectLevelIndex)
  self:RefreshQuestInfo()
  local nPercent = self.nCompletedMiniGameQuest / self.nTotalMiniGameQuest or 1
  if 1 <= nPercent then
    nPercent = 1
  elseif nPercent <= 0 then
    nPercent = 0
  elseif nPercent < 0.08333333333333333 then
    nPercent = 0.08333333333333333
  end
  local v2Size = self._mapNode.imgFill.rectTransform.sizeDelta
  v2Size.x = 302 * nPercent
  self._mapNode.imgFill.rectTransform.sizeDelta = v2Size
  NovaAPI.SetTMPText(self._mapNode.txtProgress, string.format("%d/%d", self.nCompletedMiniGameQuest, self.nTotalMiniGameQuest))
end

function CookieGameCtrl:RefreshQuestInfo()
  self.tbQuestGroupId = 0
  local nQuestActId = tonumber(tostring(self.nMainActId) .. "03")
  
  local function func_Parse_ActivityTaskGroup(mapData)
    if mapData.ActivityId == nQuestActId and mapData.Order == 4 then
      self.tbQuestGroupId = mapData.Id
    end
  end
  
  ForEachTableLine(DataTable.ActivityTaskGroup, func_Parse_ActivityTaskGroup)
  self.nTotalMiniGameQuest = 0
  self.nCompletedMiniGameQuest = 0
  if self.tbQuestGroupId == 0 then
    return
  end
  local questActData = PlayerData.Activity:GetActivityDataById(nQuestActId)
  local mapActivityTaskDatas = questActData and questActData.mapActivityTaskDatas or nil
  
  local function func_Parse_ActivityTask(mapData)
    if mapData.ActivityTaskGroupId == self.tbQuestGroupId then
      self.nTotalMiniGameQuest = self.nTotalMiniGameQuest + 1
      local _nTaskId = mapData.Id
      local taskData = mapActivityTaskDatas and mapActivityTaskDatas[_nTaskId] or nil
      if taskData ~= nil and taskData.nStatus == AllEnum.ActQuestStatus.Received then
        self.nCompletedMiniGameQuest = self.nCompletedMiniGameQuest + 1
      end
    end
  end
  
  ForEachTableLine(DataTable.ActivityTask, func_Parse_ActivityTask)
end

function CookieGameCtrl:RefreshLevelInfoPage(nIndex)
  local levelData
  for k, v in pairs(self.tbComplexLevelData) do
    if v.PackModel == GameEnum.CookiePackModel.CookiePackComplexModel then
      levelData = v
      break
    end
  end
  if levelData ~= nil then
    local bTimeUnlock, bPreLevelUnlock = self.cookieData:IsLevelUnlocked(levelData.Id)
    self._mapNode.goNightmareLock:SetActive(not bPreLevelUnlock or not bTimeUnlock)
    self._mapNode.iconNightmareLock:SetActive(not bPreLevelUnlock or not bTimeUnlock)
    self._mapNode.btnEnter[2].gameObject:SetActive(bPreLevelUnlock and bTimeUnlock)
    self._mapNode.txtEnterNMGray.gameObject:SetActive(not bPreLevelUnlock or not bTimeUnlock)
    if not bPreLevelUnlock or not bTimeUnlock then
      local sText = ""
      if not bTimeUnlock then
        local sUnlockTime = os.date("%Y-%m-%d %H:%M", levelData.DayOpen * 86400 + self.nOpenTime)
        local sRemainTimeStr, bRemainTimeValid = self:GetRemainTimeStr(self.nOpenTime, levelData.DayOpen)
        sText = sRemainTimeStr
      elseif not bPreLevelUnlock then
        sText = ConfigTable.GetUIText("Cookie_Act_Level_Lock_PreLevel")
      end
      NovaAPI.SetTMPText(self._mapNode.txtEnterNMGray, sText)
    end
  end
  if nIndex == nil then
    self._mapNode.goDailyModeInfo:SetActive(false)
    self._mapNode.goNightmareModeInfo:SetActive(true)
    if levelData ~= nil then
      NovaAPI.SetTMPText(self._mapNode.txtLevelTitleNM, levelData.Name)
      NovaAPI.SetTMPText(self._mapNode.txtLevelDescNM, levelData.PackContent)
      local bNewDay = self.cookieData:GetNMHighScoreToday()
      self._mapNode.imgNew:SetActive(bNewDay)
      local nHighScore = self.cookieData:GetLevelDataById(levelData.Id).nMaxScore or 0
      NovaAPI.SetTMPText(self._mapNode.txtLabelHighScoreNum, nHighScore)
    end
    return
  end
  levelData = self.tbLevelData[nIndex]
  if levelData == nil then
    return
  end
  self._mapNode.svLevel:SetScrollGridPos(nIndex - 1, 0, 1)
  self._mapNode.goDailyModeInfo:SetActive(true)
  self._mapNode.goNightmareModeInfo:SetActive(false)
  local sIconPath = "UI_Activity/_" .. tostring(self.nActId)
  self:SetPngSprite(self._mapNode.imgModeIcon, sIconPath .. AllEnum.CookieModeIcon[levelData.PackModel] or sIconPath .. AllEnum.CookieModeIcon[1])
  NovaAPI.SetTMPText(self._mapNode.txtLevelTitle, levelData.Name)
  NovaAPI.SetTMPText(self._mapNode.txtLevelDesc, levelData.PackContent)
  local sGoal = ConfigTable.GetUIText("Cookie_Act_Level_Goal_Desc") or ""
  sGoal = orderedFormat(sGoal, levelData.FirstCompletionScore)
  NovaAPI.SetTMPText(self._mapNode.txtLabelLevelGoalDesc, sGoal)
  local nHighScore = self.cookieData:GetLevelDataById(levelData.Id).nMaxScore or 0
  NovaAPI.SetTMPText(self._mapNode.txtNormalHighScoreNum, nHighScore)
  for i = 1, 3 do
    local nItemId = levelData["FirstCompletionReward" .. i .. "Tid"]
    local nItemCount = levelData["FirstCompletionReward" .. i .. "Qty"]
    if nItemId ~= nil and 0 < nItemId then
      self._mapNode.item[i]:SetItem(nItemId, nil, nItemCount, nil, self.cookieData:GetLevelDataById(levelData.Id).bFirstComplete, true)
      self._mapNode.btnItem[i].gameObject:SetActive(true)
      self._mapNode.btnItem[i].onClick:RemoveAllListeners()
      self._mapNode.btnItem[i].onClick:AddListener(function()
        UTILS.ClickItemGridWithTips(nItemId, self._mapNode.btnItem[i].transform, true, true, false)
      end)
    else
      self._mapNode.btnItem[i].gameObject:SetActive(false)
    end
  end
  local bTimeUnlock, bPreLevelUnlock = self.cookieData:IsLevelUnlocked(levelData.Id)
  self._mapNode.btnEnter[1].gameObject:SetActive(bPreLevelUnlock and bTimeUnlock)
  self._mapNode.txtEnterDailyGray.gameObject:SetActive(not bPreLevelUnlock or not bTimeUnlock)
  if not bPreLevelUnlock or not bTimeUnlock then
    local sText = ""
    if not bTimeUnlock then
      local sRemainTimeStr, bRemainTimeValid = self:GetRemainTimeStr(self.nOpenTime, levelData.DayOpen)
      sText = sRemainTimeStr
    elseif not bPreLevelUnlock then
      sText = ConfigTable.GetUIText("Cookie_Act_Level_Lock_PreLevel")
    end
    NovaAPI.SetTMPText(self._mapNode.txtEnterDailyGray, sText)
  end
end

function CookieGameCtrl:RefreshLevelData()
  self.tbLevelData = {}
  self.tbComplexLevelData = {}
  
  local function fc(mapData)
    if mapData.ActivityId == self.nActId then
      if mapData.PackType == GameEnum.CookiePackType.Daily then
        table.insert(self.tbLevelData, mapData)
      else
        table.insert(self.tbComplexLevelData, mapData)
      end
    end
  end
  
  ForEachTableLine(ConfigTable.Get("CookieLevel"), fc)
  table.sort(self.tbLevelData, function(a, b)
    return a.Id < b.Id
  end)
  if self.nCurSelectLevelIndex ~= nil and self.nCurSelectLevelIndex > #self.tbLevelData then
    self.nCurSelectLevelIndex = #self.tbLevelData
  end
  if self.tbLevelGridCtrl ~= nil then
    for k, v in pairs(self.tbLevelGridCtrl) do
      if v ~= nil then
        self:UnbindCtrlByNode(v)
        self.tbLevelGridCtrl[k] = nil
      end
    end
  end
  self.tbLevelGridCtrl = {}
  self._mapNode.svLevel:Init(#self.tbLevelData, self, self.OnGridRefresh, self.OnGridBtnClick)
end

function CookieGameCtrl:OnGridRefresh(go, nIndex)
  local nDataIndex = nIndex + 1
  local levelData = self.tbLevelData[nDataIndex]
  if levelData == nil then
    return
  end
  local gridCtrl = self:BindCtrlByNode(go, "Game.UI.Play_Cookie.CookieLevelGridCtrl")
  if gridCtrl ~= nil then
    local bTimeUnlock, bPreLevelUnlock = self.cookieData:IsLevelUnlocked(levelData.Id)
    gridCtrl:Init(levelData, self.cookieData:GetLevelDataById(levelData.Id), bTimeUnlock, bPreLevelUnlock, nDataIndex)
    self.tbLevelGridCtrl[nDataIndex] = gridCtrl
    if self.nCurSelectLevelIndex == nDataIndex then
      self.lastSelectGridCtrl = gridCtrl
      gridCtrl:SetSelect(true)
    else
      gridCtrl:SetSelect(false)
    end
  end
end

function CookieGameCtrl:OnGridBtnClick(go, nIndex)
  local nDataIndex = nIndex + 1
  local gridCtrl = self.tbLevelGridCtrl[nDataIndex]
  if gridCtrl == nil then
    return
  end
  if gridCtrl == self.lastSelectGridCtrl then
    return
  end
  if self.lastSelectGridCtrl ~= nil then
    self.lastSelectGridCtrl:SetSelect(false)
  end
  self.lastSelectGridCtrl = gridCtrl
  gridCtrl:SetSelect(true)
  self.nCurSelectLevelIndex = nDataIndex
  self._mapNode.animLevels:Play("CookieGame_Daily_Next", 0, 0)
  if self.timerNext ~= nil then
    self.timerNext:Cancel()
    self.timerNext = nil
  end
  EventManager.Hit(EventId.TemporaryBlockInput, 0.25)
  self.timerNext = self:AddTimer(1, 0.25, function()
    self:RefreshLevelInfoPage(nDataIndex)
  end, true, true, true)
end

function CookieGameCtrl:GetLastesetLevelId()
  local tbLevelInfo = self.cookieData:GetLevelData()
  for k, v in ipairs(tbLevelInfo) do
    if v.bFirstComplete == false then
      return k
    end
  end
  return 1
end

function CookieGameCtrl:GetRemainTimeStr(nOpenTime, openDay)
  local timeStr = ""
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local openTime = CS.ClientManager.Instance:GetNextRefreshTime(nOpenTime) - 86400
  local nRemainTime = openTime + openDay * 86400 - curTime
  local day = math.floor(nRemainTime / 86400)
  local hour = math.floor(nRemainTime / 3600)
  local min = math.floor((nRemainTime - hour * 3600) / 60)
  local sec = nRemainTime - hour * 3600 - min * 60
  if 0 < day then
    timeStr = orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Day_Color"), day)
  elseif 0 < hour then
    timeStr = orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Hour_Color"), hour)
  elseif 0 < min then
    timeStr = orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Min_Color"), min)
  elseif 0 < sec then
    timeStr = orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Sec_Color"), sec)
  end
  return timeStr, 0 < nRemainTime
end

function CookieGameCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
    self.nMainActId = param[2] or 0
  end
  self.cookieData = PlayerData.Activity:GetActivityDataById(self.nActId)
  self.nOpenTime = self.cookieData:GetActOpenTime() or 0
  self.nSelectedMode = GameEnum.CookiePackModel.CookiePackNormalModel
  self._mapNode.goDailyOn:SetActive(true)
  self._mapNode.goNightmareOn:SetActive(false)
  self._mapNode.goDailyOff:SetActive(false)
  self._mapNode.goNightmareOff:SetActive(true)
  self._mapNode.btnDaily.gameObject:SetActive(false)
  self._mapNode.btnNightmare.gameObject:SetActive(true)
  self.tbLevelGridCtrl = {}
end

function CookieGameCtrl:OnEnable()
  EventManager.Hit(EventId.SetTransition)
  self:Refresh()
  local nQuestActId = tonumber(tostring(self.nMainActId) .. "03")
  local nQuestGroupId = tonumber("1" .. string.sub(tostring(self.nMainActId), 3, 4) .. "0304")
  RedDotManager.RegisterNode(RedDotDefine.Activity_Group_Task_Group, {
    self.nMainActId,
    nQuestActId,
    nQuestGroupId
  }, self._mapNode.redDotQuest)
end

function CookieGameCtrl:OnDisable()
  if self.tbLevelGridCtrl ~= nil then
    for k, v in pairs(self.tbLevelGridCtrl) do
      self:UnbindCtrlByNode(v)
      self.tbLevelGridCtrl[k] = nil
    end
  end
end

function CookieGameCtrl:OnBtnClick_Enter()
  local mapNormalModeData = self.nCurSelectLevelIndex ~= nil and self.tbLevelData[self.nCurSelectLevelIndex] or nil
  local mapComplexModeData = self.tbComplexLevelData[1] ~= nil and self.tbComplexLevelData[1] or nil
  local levelData = self.nSelectedMode == GameEnum.CookiePackModel.CookiePackNormalModel and mapNormalModeData or mapComplexModeData
  if levelData == nil then
    return
  end
  self.nLevelId = levelData.Id
  local bPipeLineMode = levelData.PackModel == GameEnum.CookiePackModel.CookiePackPathsModel
  local bRhythmlMode = levelData.PackModel == GameEnum.CookiePackModel.CookiePackRhythmlModel
  if levelData.PackModel == GameEnum.CookiePackModel.CookiePackComplexModel then
    bRhythmlMode = true
    bPipeLineMode = true
  end
  local nScoreNeedToPass = levelData.FirstCompletionScore
  
  local function openPanel()
    EventManager.Hit(EventId.OpenPanel, PanelId.CookieBoardPanel_400016, self.nLevelId, bRhythmlMode, bPipeLineMode, levelData.CountDownLimit, self.nActId, nScoreNeedToPass or 0)
  end
  
  local nRandom = math.random(50, 51)
  EventManager.Hit(EventId.SetTransition, nRandom, openPanel)
end

function CookieGameCtrl:OnBtnClick_Gray()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Cookie_Act_Level_Lock_PreLevel"))
end

function CookieGameCtrl:OnBtnClick_DailyMode()
  self.nSelectedMode = GameEnum.CookiePackModel.CookiePackNormalModel
  self._mapNode.goDailyOn:SetActive(true)
  self._mapNode.goNightmareOn:SetActive(false)
  self._mapNode.goDailyOff:SetActive(false)
  self._mapNode.goNightmareOff:SetActive(true)
  self._mapNode.btnDaily.gameObject:SetActive(false)
  self._mapNode.btnNightmare.gameObject:SetActive(true)
  self._mapNode.animLevels:Play("CookieGame_Daily_Switch", 0, 0)
  if self.timerSwitch ~= nil then
    self.timerSwitch:Cancel()
    self.timerSwitch = nil
  end
  self._mapNode.svLevel.gameObject:SetActive(false)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.35)
  self.timerSwitch = self:AddTimer(1, 0.35, function()
    self:Refresh()
  end, true, true, true)
end

function CookieGameCtrl:OnBtnClick_NightmareMode()
  self.nSelectedMode = GameEnum.CookiePackModel.CookiePackNightmareModel
  self._mapNode.goDailyOn:SetActive(false)
  self._mapNode.goNightmareOn:SetActive(true)
  self._mapNode.goDailyOff:SetActive(true)
  self._mapNode.goNightmareOff:SetActive(false)
  self._mapNode.btnDaily.gameObject:SetActive(true)
  self._mapNode.btnNightmare.gameObject:SetActive(false)
  self._mapNode.animLevels:Play("CookieGame_Nightmare_Switch", 0, 0)
  if self.timerSwitch ~= nil then
    self.timerSwitch:Cancel()
    self.timerSwitch = nil
  end
  EventManager.Hit(EventId.TemporaryBlockInput, 0.35)
  self.timerSwitch = self:AddTimer(1, 0.35, function()
    self:Refresh()
  end, true, true, true)
end

function CookieGameCtrl:OnBtnClick_QuestDetail()
  local actData = PlayerData.Activity:GetActivityGroupDataById(self.nMainActId):GetActivityDataByIndex(2)
  local activityId = actData.ActivityId
  local activityData = ConfigTable.GetData("Activity", activityId)
  local state = 1
  if activityData ~= nil then
    local curTime = ClientManager.serverTimeStamp
    if activityData.StartTime ~= "" and activityData.EndTime ~= "" then
      local openTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.StartTime)
      local endTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.EndTime)
      if curTime < openTime then
        state = 1
      elseif curTime >= openTime and curTime < endTime then
        state = 2
      else
        state = 3
      end
    elseif activityData.EndType == GameEnum.activityEndType.NoLimit then
      state = 2
      if activityData.StartTime ~= "" then
        local openTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.StartTime)
        if curTime < openTime then
          state = 1
        end
      end
    end
  end
  if actData.PanelId ~= nil and 2 == state then
    EventManager.Hit(EventId.OpenPanel, actData.PanelId, actData.ActivityId, 4)
  end
end

function CookieGameCtrl:OnEvent_CookieLevelUpdate()
end

function CookieGameCtrl:OnEvent_CookieLevelReward(mapChangeInfo)
  self.rewardChangeInfo = mapChangeInfo
end

return CookieGameCtrl
