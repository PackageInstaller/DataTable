local BaseCtrl = require("GameCore.UI.BaseCtrl")
local LocalData = require("GameCore.Data.LocalData")
local TechStoryCtrl = class("TechStoryCtrl", BaseCtrl)
TechStoryCtrl._mapNodeConfig = {
  svStory = {
    sComponentName = "LoopScrollView"
  },
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
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  goChapterComplete = {},
  snapshot_complete = {
    sComponentName = "UIButton",
    callback = "OnBtn_ClickCloseCompete"
  },
  ctlgoEnemyInfo = {
    sNodeName = "goEnemyInfo",
    sCtrlName = "Game.UI.MainlineEx.MainlineMonsterInfoCtrl"
  },
  imgCharHead = {sComponentName = "Image"},
  txtCharName = {sComponentName = "TMP_Text"},
  goPersonalityRoot = {
    sNodeName = "grpUnderBar"
  },
  goPersonality = {
    sNodeName = "goPersonality",
    sComponentName = "GameObject"
  },
  txtPersonalityPercent = {
    nCount = 3,
    sNodeName = "txtPersonalityPercent",
    sComponentName = "TMP_Text"
  },
  txtPersonality1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Personality_Instinct"
  },
  txtPersonality2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Personality_Analyze"
  },
  txtPersonality3 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Personality_Chaos"
  }
}
TechStoryCtrl._mapEventConfig = {
  Story_Done = "OnEvent_Story_Done",
  SelectMainlineBattle = "OnEvent_SelectMainlineBattle",
  Story_RewardClosed = "OnEvent_Activity_Story_RewardClosed"
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

function TechStoryCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
    self.bReview = param[2] == true
  end
  self.storyData = self.bReview and PlayerData.StoryReview or PlayerData.ActivityAvg
  self.storyNodePos = {-23.7, -107}
  self.tbGridTimer = {}
  self.tbPlayedAnim = {}
  self.nScrollTime = 0.5
  self.bInit = false
end

function TechStoryCtrl:OnEnable()
  self:RefreshPanel()
end

function TechStoryCtrl.FadeIn()
  EventManager.Hit(EventId.SetTransition)
end

function TechStoryCtrl.OnDisable()
end

function TechStoryCtrl:RefreshPanel()
  self:RefreshStoryList()
  self:RefreshPersonality()
end

function TechStoryCtrl:RefreshPersonality()
  local cfg = ConfigTable.GetData("ActivityStoryChapter", self.nActId)
  local personalityId = cfg.PersonalityId
  self._mapNode.goPersonalityRoot:SetActive(0 < personalityId)
  if personalityId <= 0 then
    return
  end
  local tbRetPercent, sTitle, sFace, tbPData, nTotalCount, sHead = self.storyData:CalcPersonality(personalityId, self.nChapterId)
  NovaAPI.SetPersonalityRing(self._mapNode.goPersonality, tbRetPercent)
  NovaAPI.SetTMPText(self._mapNode.txtCharName, sTitle)
  NovaAPI.SetTMPText(self._mapNode.txtPersonalityPercent[1], math.floor(tbRetPercent[1] * 100) .. "%")
  NovaAPI.SetTMPText(self._mapNode.txtPersonalityPercent[2], math.floor(tbRetPercent[2] * 100) .. "%")
  NovaAPI.SetTMPText(self._mapNode.txtPersonalityPercent[3], math.floor(tbRetPercent[3] * 100) .. "%")
  local sIcon = "Icon/PlayerHead/" .. sHead
  self:SetPngSprite(self._mapNode.imgCharHead, sIcon)
end

function TechStoryCtrl:RefreshStoryList()
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
  self._mapNode.svStory:SetAnim(0.07)
  self._mapNode.svStory:Init(#self.tbAllStory, self, self.OnRefreshGrid)
  local time = self.bInit and 0 or self.nScrollTime
  self:AddTimer(1, 0.1, function()
    self._mapNode.svStory:SetScrollGridPos(recentIndex, time, 0)
    self.bInit = true
  end, true, true, true)
end

function TechStoryCtrl:RefreshGridInfo(grid, gridIndex)
  local storyId = self.tbAllStory[gridIndex]
  local avgcfg = ConfigTable.GetData("ActivityStory", storyId)
  local goInstanceID = grid:GetInstanceID()
  local btnGrid = grid.transform:Find("btnGrid"):GetComponent("UIButton")
  local RootNode = grid.transform:Find("btnGrid/AnimRoot/RootNode")
  RootNode.gameObject:SetActive(true)
  local newRoot = RootNode:Find("imgZs5")
  local dotweenGear = newRoot:Find("imgZs4").gameObject
  if gridIndex == #self.tbAllStory then
    RootNode.gameObject:SetActive(false)
    RootNode = grid.transform:Find("btnGrid/AnimRoot/RootNode2")
    RootNode.gameObject:SetActive(true)
    newRoot = RootNode
    dotweenGear = newRoot:Find("imgZs3").gameObject
  else
    local RootNode2 = grid.transform:Find("btnGrid/AnimRoot/RootNode2")
    RootNode2.gameObject:SetActive(false)
  end
  local imgStory = newRoot:Find("imgStory"):GetComponent("Image")
  local goNotOpen = newRoot:Find("goNotOpen").gameObject
  local txtLevel = newRoot:Find("txtLevel"):GetComponent("TMP_Text")
  local txtLevelLock = goNotOpen.transform:Find("txtLevelLock"):GetComponent("TMP_Text")
  local imgStoryTitleBg = newRoot:Find("imgStoryTitleBg")
  local imgBattleTitleBg = newRoot:Find("imgBattleTitleBg")
  local RedDot = RootNode:Find("RedDot").gameObject
  local goLock = RootNode:Find("goLockState").gameObject
  local goComplete = txtLevel.transform:Find("goComplete").gameObject
  local goImgTime = RootNode.transform:Find("imgTime")
  local txtTime = goImgTime:Find("txtTime"):GetComponent("TMP_Text")
  local txtTitle = RootNode:Find("tmpGroupDone"):GetComponent("TMP_Text")
  local txtComplete = goComplete.transform:Find("imgBg/txtComplete"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtComplete, ConfigTable.GetUIText("RoguelikeBuild_Manage_FilterPass"))
  local isUnlock, tbResult = self.storyData:IsUnlock(avgcfg.ConditionId)
  local isReaded = self.storyData:IsStoryReaded(storyId)
  local bOpen, nOpenTime = self.storyData:IsOpen(avgcfg.StoryId, self.nActId)
  NovaAPI.CtrlDotweenAnimation(dotweenGear, isUnlock and bOpen and 1 or 0)
  imgStory.gameObject:SetActive(true)
  if bOpen and isUnlock then
    self:SetPngSprite(imgStory, avgcfg.Icon)
  else
    self:SetPngSprite(imgStory, string.format("Icon/ActivityStory/ep_event08_00"))
  end
  NovaAPI.SetTMPText(txtTitle, avgcfg.Title)
  NovaAPI.SetTMPText(txtLevel, avgcfg.Index)
  NovaAPI.SetTMPText(txtLevelLock, avgcfg.Index)
  txtTitle.gameObject:SetActive(isUnlock and bOpen)
  goImgTime.gameObject:SetActive(not bOpen)
  goComplete.gameObject:SetActive(isUnlock and isReaded and bOpen)
  goLock.gameObject:SetActive(not isUnlock and bOpen)
  goNotOpen.gameObject:SetActive(not bOpen)
  imgBattleTitleBg.gameObject:SetActive(avgcfg.IsBattle and isUnlock and bOpen)
  imgStoryTitleBg.gameObject:SetActive(not avgcfg.IsBattle and isUnlock and bOpen)
  if avgcfg.IsBattle == true then
    local txtPlot = imgBattleTitleBg:Find("txtPlot"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(txtPlot, ConfigTable.GetUIText("SelectTeam_StartBattle"))
  else
    local txtPlot = imgStoryTitleBg:Find("txtPlot"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(txtPlot, ConfigTable.GetUIText("TowerDef_Story"))
  end
  if not bOpen then
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
  end
  if self.bReview then
    RedDot:SetActive(false)
  else
    local _bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(self.nActId)
    RedDotManager.RegisterNode(RedDotDefine.Activity_GroupNew_Avg_Group, {
      nActGroupId,
      self.nActId,
      avgcfg.Id
    }, RedDot, nil, nil, true)
  end
  
  local function clickFuc()
    if not bOpen or self.bCantClick then
      return
    end
    if isUnlock then
      local bNew = not isReaded
      self.avgId = avgcfg.StoryId
      self._mapNode.ctlAvgRoot.gameObject:SetActive(true)
      self._mapNode.ctlAvgRoot:OpenLevelInfo(avgcfg.StoryId, self.nActId, bNew, self.bReview)
      self.curIndex = gridIndex
      LocalData.SetPlayerLocalData(self.storyData:_GetLocalReadKey(self.nActId, avgcfg.Id), true)
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
  
  btnGrid.onClick:RemoveAllListeners()
  btnGrid.onClick:AddListener(clickFuc)
end

function TechStoryCtrl:OnRefreshGrid(grid, index)
  local gridIndex = index + 1
  local rectTransform = grid.transform:GetComponent("RectTransform")
  local pos = rectTransform.anchoredPosition
  pos.y = gridIndex % 2 == 0 and pos.y + self.storyNodePos[1] or pos.y + self.storyNodePos[2]
  rectTransform.anchoredPosition = pos
  local normalRoot = grid.transform:Find("Normal")
  self:RefreshGridInfo(normalRoot.gameObject, gridIndex)
  normalRoot.gameObject:SetActive(true)
  if not self.tbPlayedAnim[gridIndex] then
    self.tbPlayedAnim[gridIndex] = true
    local animRoot = grid.transform:Find("Normal/btnGrid/AnimRoot")
    local anim = animRoot and animRoot:GetComponent("Animator")
    if anim then
      anim:Play("TechStoryPanel_Story_in")
    end
  end
end

function TechStoryCtrl:GetRemainTimeStr(nOpenTime, openDay)
  local timeStr = ""
  local clientMgr = CS.ClientManager.Instance
  local curTime = clientMgr.serverTimeStamp
  local openTime = clientMgr:GetNextRefreshTime(nOpenTime) - 86400
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

function TechStoryCtrl.OnBtn_ClickBack()
  EventManager.Hit(EventId.ClosePanel, PanelId.TechStory)
end

function TechStoryCtrl.OnBtn_ClickHome()
  PanelManager.Home()
end

function TechStoryCtrl:OnBtn_ClickCloseLevelInfoPanel()
  self._mapNode.t_fullscreen_blur_black:SetActive(false)
  self._mapNode.ctlAvgRoot.gameObject:SetActive(false)
  self._mapNode.goChapterComplete:SetActive(false)
  EventManager.Hit("ActivityStoryReceive_SetVisible", true)
end

function TechStoryCtrl:OnEvent_Story_Done(bHasReward)
  self:RefreshPanel()
  if bHasReward then
    self.bCantClick = true
  end
end

function TechStoryCtrl:OnEvent_SelectMainlineBattle(bConfirm)
  local function OpenPanel()
    EventManager.Hit(EventId.OpenPanel, PanelId.RegionBossFormation, AllEnum.RegionBossFormationType.ActivityStory, 0, self.avgId, self.nActId, self.bReview)
  end
  
  if bConfirm then
    EventManager.Hit(EventId.SetTransition, 2, OpenPanel)
  end
end

function TechStoryCtrl:OnEvent_Activity_Story_RewardClosed()
  self.bCantClick = false
  if self.curIndex == #self.tbAllStory then
    self._mapNode.goChapterComplete:SetActive(true)
    EventManager.Hit("ActivityStoryReceive_SetVisible", false)
  end
end

function TechStoryCtrl:OnBtn_ClickCloseCompete()
  self._mapNode.goChapterComplete:SetActive(false)
  EventManager.Hit("ActivityStoryReceive_SetVisible", true)
end

return TechStoryCtrl
