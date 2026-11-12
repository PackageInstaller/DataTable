local BaseCtrl = require("GameCore.UI.BaseCtrl")
local LocalData = require("GameCore.Data.LocalData")
local SwimThemeStoryCtrl = class("SwimThemeStoryCtrl", BaseCtrl)
SwimThemeStoryCtrl._mapNodeConfig = {
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
SwimThemeStoryCtrl._mapEventConfig = {
  CloseActivityAvgInfo = "OnEvent_CloseAvgInfoRoot",
  Activity_Story_Done = "OnEvent_Activity_Story_Done",
  ActivityStory_All_Complate = "OnEvent_ActivityStory_All_Complate",
  Activity_Story_RewardClosed = "OnEvent_Activity_Story_RewardClosed"
}

function SwimThemeStoryCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
    self.bReview = param[2] == true
  end
  self.storyData = self.bReview and PlayerData.StoryReview or PlayerData.ActivityAvg
  self.tbAllStory, self.nChapterId = self.storyData:GetStoryIdListByActivityId(self.nActId)
  self.storyNodePos = {27, -30}
end

function SwimThemeStoryCtrl:OnEnable()
  self._mapNode.goActTime.gameObject:SetActive(false)
  self:RefreshPanel()
end

function SwimThemeStoryCtrl:OnDisable()
end

function SwimThemeStoryCtrl:RefreshPanel()
  self:RefreshDate()
  self:RefreshStoryList()
  self:RefreshPersonality()
end

function SwimThemeStoryCtrl:RefreshDate()
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

function SwimThemeStoryCtrl:RefreshPersonality()
  if self.tbAllStory == nil or #self.tbAllStory <= 0 then
    return
  end
  local cfg = ConfigTable.GetData("ActivityAvgLevel", self.tbAllStory[1])
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

function SwimThemeStoryCtrl:RefreshStoryList()
  if self.tbAllStory == nil or #self.tbAllStory <= 0 then
    return
  end
  self._mapNode.svStory:SetAnim(0.07)
  self._mapNode.svStory:Init(#self.tbAllStory, self, self.OnRefreshGrid, self.OnClickGrid)
  local recentIndex = self.storyData:GetRecentAcvitityIndex(self.nActId)
  if 2 < recentIndex then
    recentIndex = recentIndex - 3
  else
    recentIndex = 0
  end
  self._mapNode.svStory:SetScrollGridPos(recentIndex, 1)
end

function SwimThemeStoryCtrl:OnRefreshGrid(grid, index)
  local gridIndex = index + 1
  local storyId = self.tbAllStory[gridIndex]
  local avgCfg = ConfigTable.GetData("ActivityAvgLevel", storyId)
  local RootNode = grid.transform:Find("btnGrid/AnimRoot/RootNode"):GetComponent("RectTransform")
  local pos = RootNode.anchoredPosition
  pos.y = gridIndex % 2 == 0 and self.storyNodePos[1] or self.storyNodePos[2]
  RootNode.anchoredPosition = pos
  local goUnlock = RootNode:Find("goUnlock")
  local goComplete = RootNode:Find("goComplete")
  local goLock = RootNode:Find("goLock")
  local reddot = RootNode:Find("RedDot")
  local isTimeUnlock, isPreReaded, nOpenTime = self.storyData:IsActivityAvgUnlock(self.nActId, storyId)
  local isReaded = self.storyData:IsActivityAvgReaded(self.nActId, storyId)
  local isNew = self.storyData:IsNew(self.nActId, storyId)
  local isUnlock = isTimeUnlock and isPreReaded
  goUnlock.gameObject:SetActive(isUnlock)
  goComplete.gameObject:SetActive(isReaded)
  goLock.gameObject:SetActive(not isUnlock)
  if self.bReview then
    reddot:SetActive(false)
  else
    local bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(self.nActId)
    RedDotManager.RegisterNode(RedDotDefine.Activity_GroupNew_Avg_Group, {
      nActGroupId,
      self.nActId,
      storyId
    }, reddot, nil, nil, true)
  end
  local imgStory = RootNode:Find("imgStory"):GetComponent("Image")
  local txtIndex = goUnlock:Find("txtIndex"):GetComponent("TMP_Text")
  local txtTitle = goUnlock:Find("txtTitle"):GetComponent("TMP_Text")
  local txtComplete = goComplete:Find("imgBg/txtComplete"):GetComponent("TMP_Text")
  local sFullPath = Settings.AB_ROOT_PATH .. avgCfg.IconRes .. ".png"
  NovaAPI.SetImageSprite(imgStory, sFullPath)
  NovaAPI.SetTMPText(txtIndex, avgCfg.Index)
  NovaAPI.SetTMPText(txtTitle, avgCfg.Name)
  if isReaded then
    NovaAPI.SetTMPText(txtComplete, ConfigTable.GetUIText("RoguelikeBuild_Manage_FilterPass"))
  end
  if not isUnlock then
    local goLockBg = goLock:Find("goLockBg")
    local goTime = goLock:Find("imgTime")
    local txtTime = goLock:Find("imgTime/txtTime"):GetComponent("TMP_Text")
    local goLockState = goLock:Find("goLockState")
    local curTime = CS.ClientManager.Instance.serverTimeStamp
    local remainTime = curTime - (nOpenTime + avgCfg.DayOpen * 86400)
    local blueMask = goLockState:Find("blueMask")
    if remainTime < 0 then
      goLockBg.gameObject:SetActive(true)
      goTime.gameObject:SetActive(true)
      local bPreTimeUnlock = true
      if avgCfg.PreLevelId ~= 0 then
        bPreTimeUnlock = self.storyData:IsActivityAvgUnlock(self.nActId, avgCfg.PreLevelId)
      end
      if not bPreTimeUnlock then
        goTime.gameObject:SetActive(false)
        goLockState.gameObject:SetActive(true)
        blueMask.gameObject:SetActive(false)
      else
        goLockState.gameObject:SetActive(false)
        local strTime = self:GetRemainTimeStr(nOpenTime, avgCfg.DayOpen)
        self:AddTimer(0, 1, function()
          local strTime, bLock = self:GetRemainTimeStr(nOpenTime, avgCfg.DayOpen)
          if bLock then
            NovaAPI.SetTMPText(txtTime, strTime)
          else
            self:RefreshStoryList()
          end
        end, true, true, true)
        NovaAPI.SetTMPText(txtTime, strTime)
      end
    else
      goLockBg.gameObject:SetActive(false)
      goTime.gameObject:SetActive(false)
      goLockState.gameObject:SetActive(true)
      blueMask.gameObject:SetActive(true)
    end
  end
end

function SwimThemeStoryCtrl:OnClickGrid(grid, index)
  local gridIndex = index + 1
  local storyId = self.tbAllStory[gridIndex]
  local isTimeUnlock, isPreReaded, nOpenTime = self.storyData:IsActivityAvgUnlock(self.nActId, storyId)
  local isUnlock = isTimeUnlock and isPreReaded
  local avgcfg = ConfigTable.GetData("ActivityAvgLevel", storyId)
  if not isUnlock then
    if isTimeUnlock and not isPreReaded then
      local cfg = ConfigTable.GetData("ActivityAvgLevel", avgcfg.PreLevelId)
      local lockTxt = orderedFormat(ConfigTable.GetUIText("Story_UnlockPreId") or "", cfg.Name)
      local msg = {
        nType = AllEnum.MessageBox.Alert,
        sContent = lockTxt
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
    elseif not isTimeUnlock then
      local remainTimeStr = self:GetRemainTimeStr(nOpenTime, avgcfg.DayOpen)
      EventManager.Hit(EventId.OpenMessageBox, remainTimeStr)
    end
    return
  end
  self._mapNode.ctlAvgRoot.gameObject:SetActive(true)
  self._mapNode.ctlAvgRoot:OpenLevelInfo(storyId, self.nActId, nil, self.bReview)
  self._mapNode.t_fullscreen_blur_black:SetActive(true)
  LocalData.SetPlayerLocalData(self.storyData:_GetLocalReadKey(self.nActId, storyId), true)
  self.storyData:RefreshAvgRedDot()
end

function SwimThemeStoryCtrl:GetRemainTimeStr(nOpenTime, openDay)
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

function SwimThemeStoryCtrl:OnBtn_ClickBack()
  EventManager.Hit(EventId.ClosePanel, PanelId.SwimThemeStory)
end

function SwimThemeStoryCtrl:OnBtn_ClickHome()
  PanelManager.Home()
end

function SwimThemeStoryCtrl:OnBtn_ClickCloseLevelInfoPanel()
  self._mapNode.t_fullscreen_blur_black:SetActive(false)
  self._mapNode.ctlAvgRoot.gameObject:SetActive(false)
  self._mapNode.goChapterComplete:SetActive(false)
  EventManager.Hit("ActivityStoryReceive_SetVisible", true)
end

function SwimThemeStoryCtrl:OnEvent_CloseAvgInfoRoot()
  self._mapNode.t_fullscreen_blur_black:SetActive(false)
  self._mapNode.ctlAvgRoot.gameObject:SetActive(false)
  self._mapNode.goChapterComplete:SetActive(false)
  EventManager.Hit("ActivityStoryReceive_SetVisible", true)
end

function SwimThemeStoryCtrl:OnEvent_Activity_Story_Done()
  self._mapNode.t_fullscreen_blur_black:SetActive(false)
  self._mapNode.ctlAvgRoot.gameObject:SetActive(false)
  self._mapNode.goChapterComplete:SetActive(false)
  EventManager.Hit("ActivityStoryReceive_SetVisible", true)
  self:RefreshPanel()
end

function SwimThemeStoryCtrl:OnEvent_ActivityStory_All_Complate()
  self.bAllComplate = true
end

function SwimThemeStoryCtrl:OnEvent_Activity_Story_RewardClosed()
  if self.bAllComplate then
    self._mapNode.t_fullscreen_blur_black:SetActive(true)
    self._mapNode.goChapterComplete:SetActive(true)
    EventManager.Hit("ActivityStoryReceive_SetVisible", false)
    self.bAllComplate = false
  end
end

return SwimThemeStoryCtrl
