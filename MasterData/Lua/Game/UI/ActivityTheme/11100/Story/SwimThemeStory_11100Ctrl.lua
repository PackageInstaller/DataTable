local BaseCtrl = require("GameCore.UI.BaseCtrl")
local LocalData = require("GameCore.Data.LocalData")
local SwimThemeStory_11100Ctrl = class("SwimThemeStory_11100Ctrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
SwimThemeStory_11100Ctrl._mapNodeConfig = {
  goActTime = {},
  txtYear = {sComponentName = "TMP_Text"},
  txtActivityDate = {sComponentName = "TMP_Text"},
  svStory = {
    sComponentName = "LoopScrollView"
  },
  imgHead = {sComponentName = "Image"},
  txtPersonality = {sComponentName = "TMP_Text"},
  ctlAvgRoot = {
    sNodeName = "goAvgInfoRoot",
    sCtrlName = "Game.UI.ActivityTheme.ActivityAvgInfoExCtrl"
  },
  t_fullscreen_blur_black = {},
  btnsnapshot = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtn_ClickCloseLevelInfoPanel"
  },
  goPersonalityRoot = {
    sNodeName = "---Personality---"
  },
  goPersonality = {
    sNodeName = "goPersonality",
    sComponentName = "GameObject"
  },
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  goChapterComplete = {}
}
SwimThemeStory_11100Ctrl._mapEventConfig = {
  Story_Done = "OnEvent_Story_Done",
  SelectMainlineBattle = "OnEvent_SelectMainlineBattle",
  Story_RewardClosed = "OnEvent_Activity_Story_RewardClosed",
  StoryDialog_DialogEnd = "OnEvent_StoryDialog_DialogEnd"
}
local UnlockConditionPriority = {
  [1] = "MustStoryIds",
  [2] = "OneofStoryIds",
  [3] = "MustEvIds",
  [4] = "OneofEvIds",
  [5] = "WorldLevel",
  [6] = "MustAchievementIds",
  [7] = "MustActivityLevel"
}

function SwimThemeStory_11100Ctrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
    self.bReview = param[2] == true
  end
  self.storyData = self.bReview and PlayerData.StoryReview or PlayerData.ActivityAvg
  self.storyNodePos = {27, -30}
  self.tbGridTimer = {}
  self.tbPlayedAnim = {}
  self.nScrollTime = 0.5
  self.bInit = false
end

function SwimThemeStory_11100Ctrl:OnEnable()
  self._mapNode.goActTime.gameObject:SetActive(false)
  self:RefreshPanel()
end

function SwimThemeStory_11100Ctrl:OnDisable()
end

function SwimThemeStory_11100Ctrl:RefreshPanel()
  self:RefreshDate()
  self:RefreshStoryList()
  self:RefreshPersonality()
end

function SwimThemeStory_11100Ctrl:RefreshDate()
  local nOpenTime, nEndTime = self.storyData:GetActivityOpenTime(self.nActId)
  local nYear = tonumber(os.date("%Y", nOpenTime))
  local nOpenMonth = tonumber(os.date("%m", nOpenTime))
  local nOpenDay = tonumber(os.date("%d", nOpenTime))
  local nEndDay = tonumber(os.date("%d", nEndTime))
  local nEndMonth = tonumber(os.date("%m", nEndTime))
  NovaAPI.SetTMPText(self._mapNode.txtYear, nYear)
  local strOpenDay = string.format("%d", nOpenDay)
  local strEndDay = string.format("%d", nEndDay)
  local dateStr = string.format("%s/%s ~ %s/%s", nOpenMonth, strOpenDay, nEndMonth, strEndDay)
  NovaAPI.SetTMPText(self._mapNode.txtActivityDate, dateStr)
end

function SwimThemeStory_11100Ctrl:RefreshPersonality()
  local cfg = ConfigTable.GetData("ActivityStoryChapter", self.nActId)
  local personalityId = cfg.PersonalityId
  self._mapNode.goPersonalityRoot:SetActive(0 < personalityId)
  if personalityId <= 0 then
    return
  end
  local tbRetPercent, sTitle, sFace, tbPData, nTotalCount, sHead = self.storyData:CalcPersonality(personalityId)
  NovaAPI.SetPersonalityRing(self._mapNode.goPersonality, tbRetPercent)
  NovaAPI.SetTMPText(self._mapNode.txtPersonality, sTitle)
  local sIcon = "Icon/PlayerHead/" .. sHead
  self:SetPngSprite(self._mapNode.imgHead, sIcon)
end

function SwimThemeStory_11100Ctrl:RefreshStoryList()
  self.tbPlayedAnim = {}
  self.tbAllStory, self.nChapterId = self.storyData:GetStoryIdListByActivityId(self.nActId)
  if self.tbAllStory == nil or #self.tbAllStory <= 0 then
    return
  end
  local recentStoryId = self.storyData:GetRecentStoryId(self.nChapterId)
  local recentIndex = 1
  for i = 1, #self.tbAllStory do
    if self.tbAllStory[i] == recentStoryId then
      recentIndex = i
      break
    end
  end
  self.curIndex = recentIndex
  local time = self.bInit and 0 or self.nScrollTime
  self._mapNode.svStory:Init(#self.tbAllStory, self, self.OnRefreshGrid)
  self:AddTimer(1, 0.1, function()
    self._mapNode.svStory:SetScrollGridPos(recentIndex, time, 0)
    self.bInit = true
  end, true, true, true)
end

function SwimThemeStory_11100Ctrl:OnRefreshGrid(grid, index)
  local gridIndex = index + 1
  local storyId = self.tbAllStory[gridIndex]
  local avgcfg = ConfigTable.GetData("ActivityStory", storyId)
  local goInstanceID = grid:GetInstanceID()
  local RootNode = grid.transform:Find("btnGrid/AnimRoot/RootNode"):GetComponent("RectTransform")
  local pos = RootNode.anchoredPosition
  pos.y = gridIndex % 2 == 0 and self.storyNodePos[1] or self.storyNodePos[2]
  RootNode.anchoredPosition = pos
  local goUnlock = RootNode:Find("goUnlock")
  local goComplete = RootNode:Find("goComplete")
  local goLock = RootNode:Find("goLock")
  local reddot = RootNode:Find("RedDot")
  local isUnlock, tbResult = self.storyData:IsUnlock(avgcfg.ConditionId)
  local isReaded = self.storyData:IsStoryReaded(storyId)
  local bOpen, nOpenTime = self.storyData:IsOpen(avgcfg.StoryId, self.nActId)
  local isFullUnlock = isUnlock and bOpen
  goUnlock.gameObject:SetActive(isFullUnlock)
  goComplete.gameObject:SetActive(isReaded and bOpen)
  goLock.gameObject:SetActive(not isFullUnlock)
  if self.bReview then
    reddot.gameObject:SetActive(false)
  else
    local _bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(self.nActId)
    RedDotManager.RegisterNode(RedDotDefine.Activity_GroupNew_Avg_Group, {
      nActGroupId,
      self.nActId,
      avgcfg.Id
    }, reddot, nil, nil, true)
  end
  local imgStory = RootNode:Find("imgStory"):GetComponent("Image")
  local txtIndex = goUnlock:Find("txtIndex"):GetComponent("TMP_Text")
  local txtTitle = goUnlock:Find("txtTitle"):GetComponent("TMP_Text")
  local txtComplete = goComplete:Find("imgBg/txtComplete"):GetComponent("TMP_Text")
  if bOpen then
    self:SetPngSprite(imgStory, avgcfg.Icon)
  else
    self:SetPngSprite(imgStory, "Icon/ActivityStory/ep_event07_00")
  end
  NovaAPI.SetTMPText(txtIndex, avgcfg.Index)
  NovaAPI.SetTMPText(txtTitle, avgcfg.Title)
  NovaAPI.SetTMPText(txtComplete, ConfigTable.GetUIText("RoguelikeBuild_Manage_FilterPass"))
  if not isFullUnlock then
    local goLockBg = goLock:Find("goLockBg")
    local goTime = goLock:Find("imgTime")
    local txtTime = goTime:Find("txtTime"):GetComponent("TMP_Text")
    local goLockState = goLock:Find("goLockState")
    local blueMask = goLockState:Find("blueMask")
    local curTime = CS.ClientManager.Instance.serverTimeStamp
    local remainTime = curTime - (nOpenTime + avgcfg.DayOpen * 86400)
    if not bOpen or remainTime < 0 then
      goLockBg.gameObject:SetActive(true)
      goTime.gameObject:SetActive(true)
      goLockState.gameObject:SetActive(false)
      local strTime = self:GetRemainTimeStr(nOpenTime, avgcfg.DayOpen)
      if self.tbGridTimer[goInstanceID] ~= nil then
        self.tbGridTimer[goInstanceID]:Cancel()
        self.tbGridTimer[goInstanceID] = nil
      end
      self.tbGridTimer[goInstanceID] = self:AddTimer(0, 1, function()
        local strTimeNew, bLock = self:GetRemainTimeStr(nOpenTime, avgcfg.DayOpen)
        if bLock then
          NovaAPI.SetTMPText(txtTime, strTimeNew)
        else
          self:RefreshStoryList()
        end
      end, true, true, true)
      NovaAPI.SetTMPText(txtTime, strTime)
    else
      goLockBg.gameObject:SetActive(false)
      goTime.gameObject:SetActive(false)
      goLockState.gameObject:SetActive(true)
      blueMask.gameObject:SetActive(true)
    end
  end
  
  local function clickFuc()
    if not bOpen or self.bCantClick then
      return
    end
    if isFullUnlock then
      local bNew = not isReaded
      self.avgId = avgcfg.StoryId
      self._mapNode.ctlAvgRoot.gameObject:SetActive(true)
      self._mapNode.ctlAvgRoot:OpenLevelInfo(avgcfg.StoryId, self.nActId, bNew, self.bReview)
      self.curIndex = gridIndex
      LocalData.SetPlayerLocalData("Act_Story_New" .. self.nActId .. avgcfg.Id, true)
      self.storyData:RefreshAvgRedDot()
    elseif tbResult ~= nil then
      local lockTxt = ""
      for i = 1, #tbResult do
        local value = tbResult[i]
        if value[1] == false then
          if UnlockConditionPriority[i] == "MustStoryIds" then
            do
              local tbStoryIds = value[2]
              for k, v in pairs(tbStoryIds) do
                if v == false then
                  local storyData = ConfigTable.GetData("ActivityStory", k)
                  lockTxt = orderedFormat(ConfigTable.GetUIText("Story_UnlockPreId") or "", storyData.Title)
                  break
                end
              end
            end
            break
          end
          if UnlockConditionPriority[i] == "OneofStoryIds" then
            do
              local tbStoryIds = value[2]
              for k, v in pairs(tbStoryIds) do
                if v == false then
                  local storyData = ConfigTable.GetData("ActivityStory", k)
                  if self.storyData:IsUnlock(storyData.ConditionId) then
                    lockTxt = orderedFormat(ConfigTable.GetUIText("Story_UnlockPreId") or "", storyData.Title)
                    break
                  end
                end
              end
              if lockTxt == "" then
                for k, _v in pairs(tbStoryIds) do
                  local storyData = ConfigTable.GetData("ActivityStory", k)
                  lockTxt = orderedFormat(ConfigTable.GetUIText("Story_UnlockPreId") or "", storyData.Title)
                  break
                end
              end
            end
            break
          end
          if UnlockConditionPriority[i] == "MustEvIds" then
            lockTxt = ConfigTable.GetUIText("Story_UnlockClueCondition")
            break
          end
          if UnlockConditionPriority[i] == "OneofEvIds" then
            lockTxt = ConfigTable.GetUIText("Story_UnlockClueCondition")
            break
          end
          if UnlockConditionPriority[i] == "WorldLevel" then
            do
              local level = value[2]
              lockTxt = orderedFormat(ConfigTable.GetUIText("Story_UnlockWorldLv") or "", level)
            end
            break
          end
          if UnlockConditionPriority[i] == "MustAchievementIds" then
            if self.bHasAchievementData == true then
              local tbAchievementList = value[2]
              for k, v in pairs(tbAchievementList) do
                if v == false then
                  local achievementId = k
                  local achievement = ConfigTable.GetData("Achievement", achievementId)
                  lockTxt = orderedFormat(ConfigTable.GetUIText("Story_UnlockAchievement") or "", achievement.Title) .. "\n" .. "(" .. achievement.Desc .. ")"
                  break
                end
              end
            end
            break
          end
          if UnlockConditionPriority[i] == "MustActivityLevel" then
            local levelId = value[2]
            if 0 < levelId then
              local levelData = ConfigTable.GetData("ActivityLevelsLevel", levelId)
              if levelData then
                lockTxt = orderedFormat(ConfigTable.GetUIText("ActivityStory_UnlockActivityLevel"), levelData.Name)
              end
            end
          end
          break
        end
      end
      local msg = {
        nType = AllEnum.MessageBox.Alert,
        sContent = lockTxt
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
    end
  end
  
  local btnGrid = grid.transform:Find("btnGrid"):GetComponent("UIButton")
  btnGrid.onClick:RemoveAllListeners()
  btnGrid.onClick:AddListener(clickFuc)
  local anim = grid:GetComponent("Animator")
  anim:Play("go")
end

function SwimThemeStory_11100Ctrl:GetRemainTimeStr(nOpenTime, openDay)
  local timeStr = ""
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local openTime = CS.ClientManager.Instance:GetNextRefreshTime(nOpenTime) - 86400
  local nRemainTime = openTime + openDay * 86400 - curTime
  local day = math.floor(nRemainTime / 86400)
  local hour = math.floor(nRemainTime / 3600)
  local min = math.floor((nRemainTime - hour * 3600) / 60)
  local sec = nRemainTime - hour * 3600 - min * 60
  if 0 < day then
    timeStr = orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Day_Color_Common"), "08d3d4", day)
  elseif 0 < hour then
    timeStr = orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Hour_Color_Common"), "08d3d4", hour)
  elseif 0 < min then
    timeStr = orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Min_Color_Common"), "08d3d4", min)
  elseif 0 < sec then
    timeStr = orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Sec_Color_Common"), "08d3d4", sec)
  end
  return timeStr, 0 < nRemainTime
end

function SwimThemeStory_11100Ctrl:OnBtn_ClickBack()
  EventManager.Hit(EventId.ClosePanel, PanelId.SwimThemeStory_11100)
end

function SwimThemeStory_11100Ctrl:OnBtn_ClickHome()
  PanelManager.Home()
end

function SwimThemeStory_11100Ctrl:OnBtn_ClickCloseLevelInfoPanel()
  self._mapNode.t_fullscreen_blur_black:SetActive(false)
  self._mapNode.ctlAvgRoot.gameObject:SetActive(false)
  self._mapNode.goChapterComplete:SetActive(false)
  EventManager.Hit("ActivityStoryReceive_SetVisible", true)
end

function SwimThemeStory_11100Ctrl:OnEvent_StoryDialog_DialogEnd()
  WwiseAudioMgr:SetState("menuTransition", "open")
end

function SwimThemeStory_11100Ctrl:OnEvent_Story_Done(bHasReward)
  self:RefreshPanel()
  if bHasReward then
    self.bCantClick = true
  end
end

function SwimThemeStory_11100Ctrl:OnEvent_SelectMainlineBattle(bConfirm)
  local function OpenPanel()
    EventManager.Hit(EventId.OpenPanel, PanelId.RegionBossFormation, AllEnum.RegionBossFormationType.ActivityStory, 0, self.avgId, self.nActId, self.bReview)
  end
  
  if bConfirm then
    EventManager.Hit(EventId.SetTransition, 2, OpenPanel)
  end
end

function SwimThemeStory_11100Ctrl:OnEvent_Activity_Story_RewardClosed()
  self.bCantClick = false
  if self.curIndex == #self.tbAllStory then
    self._mapNode.goChapterComplete:SetActive(true)
    EventManager.Hit("ActivityStoryReceive_SetVisible", false)
  end
end

return SwimThemeStory_11100Ctrl
