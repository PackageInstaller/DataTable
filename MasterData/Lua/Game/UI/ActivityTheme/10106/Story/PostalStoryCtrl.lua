local BaseCtrl = require("GameCore.UI.BaseCtrl")
local LocalData = require("GameCore.Data.LocalData")
local PostalStoryCtrl = class("PostalStoryCtrl", BaseCtrl)
PostalStoryCtrl._mapNodeConfig = {
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
  }
}
PostalStoryCtrl._mapEventConfig = {
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
local BRANCH_GRID_INDEX = 2
local BRANCH_COUNT = 3

function PostalStoryCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
    self.bReview = param[2] == true
  end
  self.storyData = self.bReview and PlayerData.StoryReview or PlayerData.ActivityAvg
  self.storyNodePos = {0, -66.1}
  self.tbGridTimer = {}
  self.tbPlayedAnim = {}
  self.nScrollTime = 0.5
  self.bInit = false
end

function PostalStoryCtrl:OnEnable()
  self:RefreshPanel()
end

function PostalStoryCtrl:FadeIn()
  EventManager.Hit(EventId.SetTransition)
end

function PostalStoryCtrl:OnDisable()
end

function PostalStoryCtrl:RefreshPanel()
  self:RefreshStoryList()
end

function PostalStoryCtrl:RefreshStoryList()
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
  local scrollIndex = recentIndex
  local branchEnd = BRANCH_GRID_INDEX + BRANCH_COUNT - 1
  if recentIndex >= BRANCH_GRID_INDEX and recentIndex <= branchEnd then
    scrollIndex = BRANCH_GRID_INDEX
  elseif recentIndex > branchEnd then
    scrollIndex = recentIndex - (BRANCH_COUNT - 1)
  end
  self.curIndex = recentIndex
  self._mapNode.svStory:SetAnim(0.07)
  self._mapNode.svStory:Init(#self.tbAllStory - (BRANCH_COUNT - 1), self, self.OnRefreshGrid)
  local time = self.bInit and 0 or self.nScrollTime
  self:AddTimer(1, 0.1, function()
    self._mapNode.svStory:SetScrollGridPos(scrollIndex, time, 0)
    self.bInit = true
  end, true, true, true)
end

function PostalStoryCtrl:RefreshGridInfo(grid, gridIndex, bBranch, nBranchIndex)
  local storyId = self.tbAllStory[gridIndex]
  local avgcfg = ConfigTable.GetData("ActivityStory", storyId)
  local goInstanceID = grid:GetInstanceID()
  local btnGrid = grid.transform:Find("btnGrid"):GetComponent("UIButton")
  local RootNode = grid.transform:Find("btnGrid/AnimRoot/RootNode")
  local imgStory = bBranch and RootNode:Find("imgStory/imgBg2"):GetComponent("Image") or RootNode:Find("imgStory"):GetComponent("Image")
  local goNotOpen = RootNode:Find("goNotOpen").gameObject
  local txtLevel = RootNode:Find("txtLevel"):GetComponent("TMP_Text")
  local txtLevelLock = bBranch and grid.transform:Find("btnGridText/scale_on_click/goLockState/txtLevelLock"):GetComponent("TMP_Text") or goNotOpen.transform:Find("txtLevelLock"):GetComponent("TMP_Text")
  local imgStoryTitleBg = RootNode:Find("imgStoryTitleBg")
  local imgBattleTitleBg = RootNode:Find("imgBattleTitleBg")
  local RedDot = RootNode:Find("RedDot").gameObject
  local goLock = grid.transform:Find("btnGridText/scale_on_click/goLockState").gameObject
  local goComplete = grid.transform:Find("btnGridText/scale_on_click/goComplete").gameObject
  local goImgTime = RootNode.transform:Find("imgTime")
  local txtTime = goImgTime:Find("txtTime"):GetComponent("TMP_Text")
  local txtTitle = bBranch and RootNode:Find("tmpGroupDone"):GetComponent("TMP_Text") or grid.transform:Find("btnGridText/scale_on_click/tmpGroupDone"):GetComponent("TMP_Text")
  local txtComplete = goComplete.transform:Find("imgBg/txtComplete"):GetComponent("TMP_Text")
  local btnGridText = grid.transform:Find("btnGridText").gameObject
  NovaAPI.SetTMPText(txtComplete, ConfigTable.GetUIText("RoguelikeBuild_Manage_FilterPass"))
  local isUnlock, tbResult = self.storyData:IsUnlock(avgcfg.ConditionId)
  local isReaded = self.storyData:IsStoryReaded(storyId)
  local bOpen, nOpenTime = self.storyData:IsOpen(avgcfg.StoryId, self.nActId)
  local nIndex = 0
  if isUnlock then
    nIndex = bBranch and BRANCH_GRID_INDEX or gridIndex
    if nIndex > BRANCH_GRID_INDEX then
      nIndex = nIndex - (BRANCH_COUNT - 1)
    end
  end
  local branchSuffix = bBranch and string.char(string.byte("a") + nBranchIndex - 1) or ""
  local bShowImgStory = not bBranch or not not isUnlock
  imgStory.gameObject:SetActive(bShowImgStory)
  if bShowImgStory then
    if bOpen then
      self:SetPngSprite(imgStory, string.format("Icon/ActivityStory/ep_event05_%02d", nIndex) .. branchSuffix)
    else
      self:SetPngSprite(imgStory, string.format("Icon/ActivityStory/ep_event05_00"))
    end
  end
  NovaAPI.SetTMPText(txtTitle, avgcfg.Title)
  NovaAPI.SetTMPText(txtLevel, avgcfg.Index)
  txtLevel.gameObject:SetActive(not bBranch or not not isUnlock)
  NovaAPI.SetTMPText(txtLevelLock, bBranch and ConfigTable.GetUIText("Story_Unkown_Chapter") or avgcfg.Index)
  txtTitle.gameObject:SetActive(isUnlock and bOpen)
  goImgTime.gameObject:SetActive(not bOpen)
  goComplete.gameObject:SetActive(isUnlock and isReaded and bOpen)
  goLock.gameObject:SetActive(not isUnlock and bOpen)
  goNotOpen.gameObject:SetActive(not bOpen or bBranch and not isUnlock)
  imgBattleTitleBg.gameObject:SetActive(avgcfg.IsBattle and isUnlock and bOpen)
  imgStoryTitleBg.gameObject:SetActive(not avgcfg.IsBattle and isUnlock and bOpen)
  btnGridText.gameObject:SetActive(bOpen)
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
      local strTime, bLock = self:GetRemainTimeStr(nOpenTime, avgcfg.DayOpen)
      if bLock then
        NovaAPI.SetTMPText(txtTime, strTime)
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
                for k, v in pairs(tbStoryIds) do
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

function PostalStoryCtrl:OnRefreshGrid(grid, index)
  local gridIndex = index + 1
  local rectTransform = grid.transform:GetComponent("RectTransform")
  local pos = rectTransform.anchoredPosition
  pos.y = gridIndex % 2 == 0 and pos.y + self.storyNodePos[1] or pos.y + self.storyNodePos[2]
  if gridIndex == 2 then
    pos.y = pos.y + self.storyNodePos[2]
  end
  rectTransform.anchoredPosition = pos
  local normalRoot = grid.transform:Find("Normal")
  local branchRoot = grid.transform:Find("Branch")
  if gridIndex == BRANCH_GRID_INDEX then
    for i = 1, BRANCH_COUNT do
      local branchGrid = branchRoot:Find("tog" .. i)
      self:RefreshGridInfo(branchGrid.gameObject, gridIndex + i - 1, true, i)
    end
    normalRoot.gameObject:SetActive(false)
    branchRoot.gameObject:SetActive(true)
    if not self.tbPlayedAnim[gridIndex] then
      self.tbPlayedAnim[gridIndex] = true
      local anim = branchRoot:GetComponent("Animator")
      if anim then
        anim:Play("PostalStoryPanel_Story_in_02")
      end
    end
  else
    if gridIndex > BRANCH_GRID_INDEX - 1 then
      gridIndex = gridIndex + (BRANCH_COUNT - 1)
    end
    self:RefreshGridInfo(normalRoot.gameObject, gridIndex)
    normalRoot.gameObject:SetActive(true)
    branchRoot.gameObject:SetActive(false)
    if not self.tbPlayedAnim[gridIndex] then
      self.tbPlayedAnim[gridIndex] = true
      local animRoot = grid.transform:Find("Normal/btnGrid/AnimRoot")
      local anim = animRoot and animRoot:GetComponent("Animator")
      if anim then
        anim:Play("PostalStoryPanel_Story_in_01")
      end
    end
  end
end

function PostalStoryCtrl:GetRemainTimeStr(nOpenTime, openDay)
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

function PostalStoryCtrl:OnBtn_ClickBack()
  EventManager.Hit(EventId.ClosePanel, PanelId.PostalStory)
end

function PostalStoryCtrl:OnBtn_ClickHome()
  PanelManager.Home()
end

function PostalStoryCtrl:OnBtn_ClickCloseLevelInfoPanel()
  self._mapNode.t_fullscreen_blur_black:SetActive(false)
  self._mapNode.ctlAvgRoot.gameObject:SetActive(false)
  self._mapNode.goChapterComplete:SetActive(false)
  EventManager.Hit("ActivityStoryReceive_SetVisible", true)
end

function PostalStoryCtrl:OnEvent_Story_Done(bHasReward)
  self:RefreshPanel()
  if bHasReward then
    self.bCantClick = true
  end
end

function PostalStoryCtrl:OnEvent_SelectMainlineBattle(bConfirm)
  local function OpenPanel()
    EventManager.Hit(EventId.OpenPanel, PanelId.RegionBossFormation, AllEnum.RegionBossFormationType.ActivityStory, 0, self.avgId, self.nActId, self.bReview)
  end
  
  if bConfirm then
    EventManager.Hit(EventId.SetTransition, 2, OpenPanel)
  end
end

function PostalStoryCtrl:OnEvent_Activity_Story_RewardClosed()
  self.bCantClick = false
  if self.curIndex == #self.tbAllStory then
    self._mapNode.goChapterComplete:SetActive(true)
    EventManager.Hit("ActivityStoryReceive_SetVisible", false)
  end
end

function PostalStoryCtrl:OnBtn_ClickCloseCompete()
  self._mapNode.goChapterComplete:SetActive(false)
  EventManager.Hit("ActivityStoryReceive_SetVisible", true)
end

return PostalStoryCtrl
