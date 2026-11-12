local BaseCtrl = require("GameCore.UI.BaseCtrl")
local LocalData = require("GameCore.Data.LocalData")
local MainlineEx_SolodanceStoryCtrl = class("MainlineEx_SolodanceStoryCtrl", BaseCtrl)
local AvgData = PlayerData.Avg
MainlineEx_SolodanceStoryCtrl._mapNodeConfig = {
  goStoryNode = {
    sComponentName = "LoopScrollView"
  },
  ctlAvgRoot = {
    sNodeName = "goAvgInfoRoot",
    sCtrlName = "Game.UI.MainlineEx.MainlineAvgInfoExCtrl"
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
  imgCharHead = {
    sNodeName = "imgCharHead",
    sComponentName = "Image"
  },
  txtCharName = {
    sNodeName = "txtCharName",
    sComponentName = "TMP_Text"
  },
  txtPersonalityPercent1 = {
    sNodeName = "txtPersonalityPercent1",
    sComponentName = "TMP_Text"
  },
  txtPersonalityPercent2 = {
    sNodeName = "txtPersonalityPercent2",
    sComponentName = "TMP_Text"
  },
  txtPersonalityPercent3 = {
    sNodeName = "txtPersonalityPercent3",
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
  },
  gogoPersonality = {
    sNodeName = "goPersonality",
    sComponentName = "GameObject"
  },
  txtChapter = {sNodeName = "txtChapter", sComponentName = "TMP_Text"},
  txtChapterTitle = {
    sNodeName = "txtChapterTitle",
    sComponentName = "TMP_Text"
  },
  txtChapterTimeStamp = {
    sNodeName = "txtChapterTimeStamp",
    sComponentName = "TMP_Text"
  },
  behindBG = {sNodeName = "behindBG", sComponentName = "Transform"}
}
MainlineEx_SolodanceStoryCtrl._mapEventConfig = {
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
  [6] = "MustAchievementIds"
}
local Storys = {
  6503,
  6504,
  6505,
  6506,
  6507,
  6508,
  6501,
  6509,
  6502,
  6510,
  6511,
  6512
}
local BG_SCROLL_SPEED = 1.0

function MainlineEx_SolodanceStoryCtrl:Awake()
  local tbParam = self:GetPanelParam()
  self.nChapterId = tbParam[1] ~= nil and tbParam[1] or 0
  self.bInit = false
  self.nScrollTime = 0.5
  self.tbLockedOnEnter = {}
  for _, storyNumId in ipairs(Storys) do
    local storyData = ConfigTable.GetData_Story(storyNumId)
    local bUnlock = AvgData:IsUnlock(storyData.ConditionId, storyData.StoryId)
    if not bUnlock then
      self.tbLockedOnEnter[storyNumId] = true
    end
  end
end

function MainlineEx_SolodanceStoryCtrl:OnEnable()
  if self.bEnterBattle then
    if self.curIndex == nil then
      self.curIndex = 1
    end
    if self.curIndex < #self.tbChapterStoryNumIds then
      local storyNumId = self.tbChapterStoryNumIds[self.curIndex + 1]
      if self.tbLockedOnEnter ~= nil and self.tbLockedOnEnter[storyNumId] then
        local cfg = ConfigTable.GetData_Story(storyNumId)
        local bUnlock = AvgData:IsUnlock(cfg.ConditionId, cfg.StoryId)
        if bUnlock then
          self.bRefreshAfterReward = true
        end
      end
    end
    self.bEnterBattle = false
  end
  self:RefreshPanel()
end

function MainlineEx_SolodanceStoryCtrl:FadeIn()
  EventManager.Hit(EventId.SetTransition)
end

function MainlineEx_SolodanceStoryCtrl:OnDisable()
  self:RemoveBGScroll()
end

function MainlineEx_SolodanceStoryCtrl:RefreshPanel()
  self:RefreshChapterInfo()
  self:RefreshStoryList()
  self:RefreshPersonality()
end

function MainlineEx_SolodanceStoryCtrl:RefreshPersonality()
  local tbPersonality, sTitle, sFace, tbPData, nTotalCount, sHead = AvgData:CalcPersonality(1)
  NovaAPI.SetPersonalityRing(self._mapNode.gogoPersonality, tbPersonality)
  NovaAPI.SetTMPText(self._mapNode.txtPersonalityPercent1, math.floor(tbPersonality[1] * 100) .. "%")
  NovaAPI.SetTMPText(self._mapNode.txtPersonalityPercent2, math.floor(tbPersonality[2] * 100) .. "%")
  NovaAPI.SetTMPText(self._mapNode.txtPersonalityPercent3, math.floor(tbPersonality[3] * 100) .. "%")
  NovaAPI.SetTMPText(self._mapNode.txtCharName, sTitle)
  local sIcon = "Icon/PlayerHead/" .. sHead
  self:SetPngSprite(self._mapNode.imgCharHead, sIcon)
end

function MainlineEx_SolodanceStoryCtrl:RefreshChapterInfo()
  local config = ConfigTable.GetData("StoryChapter", self.nChapterId)
  NovaAPI.SetTMPText(self._mapNode.txtChapter, config.Name)
  NovaAPI.SetTMPText(self._mapNode.txtChapterTitle, config.Desc)
  NovaAPI.SetTMPText(self._mapNode.txtChapterTimeStamp, config.ChapterYear)
end

function MainlineEx_SolodanceStoryCtrl:RefreshStoryList()
  self.tbChapterStoryNumIds = Storys
  self._mapNode.goStoryNode:Init(#self.tbChapterStoryNumIds, self, self.OnRefreshGrid)
  local recentStoryId = AvgData:GetRecentStoryId(self.nChapterId)
  if recentStoryId ~= 0 then
    for i = 1, #self.tbChapterStoryNumIds do
      if self.tbChapterStoryNumIds[i] == recentStoryId then
        self:AddTimer(1, 0.1, function()
          local time = self.bInit and 0 or self.nScrollTime
          self._mapNode.goStoryNode:SetScrollGridPos(i, time, 0)
          self.bInit = true
        end)
        break
      end
    end
  end
  self:InitBGScroll()
end

function MainlineEx_SolodanceStoryCtrl:InitBGScroll()
  self:RemoveBGScroll()
  local content = self._mapNode.goStoryNode.content
  if content == nil then
    return
  end
  self.bgScrollContent = content
  local bgRect = self._mapNode.behindBG
  if self.bgInitX == nil then
    self.bgInitX = bgRect.anchoredPosition.x
  end
  bgRect.anchoredPosition = Vector2(self.bgInitX, bgRect.anchoredPosition.y)
  self:SyncBehindBG()
  
  function self.onBGScrollValueChanged(_value)
    self:SyncBehindBG()
  end
  
  self._mapNode.goStoryNode.onValueChanged:AddListener(self.onBGScrollValueChanged)
end

function MainlineEx_SolodanceStoryCtrl:RemoveBGScroll()
  if self.onBGScrollValueChanged == nil then
    return
  end
  self._mapNode.goStoryNode.onValueChanged:RemoveListener(self.onBGScrollValueChanged)
  self.onBGScrollValueChanged = nil
  self.bgScrollContent = nil
end

function MainlineEx_SolodanceStoryCtrl:SyncBehindBG()
  if self.bgScrollContent == nil then
    return
  end
  local bgRect = self._mapNode.behindBG
  local offset = self.bgScrollContent.anchoredPosition.x * BG_SCROLL_SPEED
  bgRect.anchoredPosition = Vector2(self.bgInitX + offset, bgRect.anchoredPosition.y)
end

function MainlineEx_SolodanceStoryCtrl:OnRefreshGrid(grid, index)
  index = index + 1
  local storyNumId = self.tbChapterStoryNumIds[index]
  local storyData = ConfigTable.GetData_Story(storyNumId)
  local bUnlock, tbResult = AvgData:IsUnlock(storyData.ConditionId, storyData.StoryId)
  local bReaded = AvgData:IsStoryReaded(storyData.Id)
  local goDecorate1 = grid.transform:Find("grpZs/imgLamp").gameObject
  local goDecorate2 = grid.transform:Find("grpZs/grpUmbrella").gameObject
  local btnStoryNode = grid.transform:Find("btnStoryNode")
  local animRoot = btnStoryNode:Find("AnimRoot")
  local goOpen = animRoot:Find("goOpen")
  local goUnOpen = grid.transform:Find("goUnOpen")
  local txtStoryTitle = goOpen:Find("goUnlock/txtStoryTitle"):GetComponent("TMP_Text")
  local txtBattleTitle = goOpen:Find("goUnlock/txtBattleTitle"):GetComponent("TMP_Text")
  local txtTitle = goOpen:Find("goUnlock/txtTitle"):GetComponent("TMP_Text")
  local imgComplete = goOpen:Find("goUnlock/imgComplete").gameObject
  local btnGroupGo = goOpen:Find("goUnlock/btnGroupGo"):GetComponent("UIButton")
  local btnGroupTxt = btnGroupGo.transform:Find("scale_on_click/tmpGroupDone"):GetComponent("TMP_Text")
  local txtIndex = goOpen:Find("imgNumDb/txtIndex"):GetComponent("TMP_Text")
  local redDot = goOpen:Find("redDot").gameObject
  local txtLocked = goUnOpen:Find("grpLockPlate/txtLocked"):GetComponent("TMP_Text")
  local txtLockIndex = goUnOpen:Find("imgNumDb/txtIndex"):GetComponent("TMP_Text")
  local animOpen = goOpen:GetComponent("Animator")
  NovaAPI.SetTMPText(txtStoryTitle, ConfigTable.GetUIText("Story_StoryTitle"))
  NovaAPI.SetTMPText(txtBattleTitle, ConfigTable.GetUIText("Story_BattleTitle"))
  txtStoryTitle.gameObject:SetActive(storyData.IsBattle == false)
  txtBattleTitle.gameObject:SetActive(storyData.IsBattle == true)
  imgComplete:SetActive(bReaded)
  goOpen.gameObject:SetActive(bUnlock)
  goUnOpen.gameObject:SetActive(not bUnlock)
  goDecorate1:SetActive(index % 2 == 1)
  goDecorate2:SetActive(index % 2 == 0)
  if bUnlock then
    NovaAPI.SetTMPText(txtTitle, storyData.Title)
    NovaAPI.SetTMPText(btnGroupTxt, ConfigTable.GetUIText("Story_Enter"))
    NovaAPI.SetTMPText(txtIndex, storyData.Index)
  else
    local sLockDesc = self:GetLockTxt(tbResult)
    NovaAPI.SetTMPText(txtLocked, sLockDesc)
    NovaAPI.SetTMPText(txtLockIndex, storyData.Index)
  end
  redDot:SetActive(bUnlock and not bReaded)
  if bUnlock then
    if self.bRefreshAfterReward then
      local bNewlyUnlocked = self.tbLockedOnEnter and self.tbLockedOnEnter[storyNumId]
      if bNewlyUnlocked then
        print("Play unlock animation for storyNumId:", storyNumId, self.tbLockedOnEnter[storyNumId])
        animOpen:Play("goOpen_in")
        self.tbLockedOnEnter[storyNumId] = nil
        self.bRefreshAfterReward = false
      else
        animOpen:Play("goOpen_idle")
      end
    else
      animOpen:Play("goOpen_in")
    end
  else
    animOpen:Play("goOpen_idle")
  end
  btnGroupGo.onClick:RemoveAllListeners()
  btnGroupGo.onClick:AddListener(function()
    if self.bCantClick then
      return
    end
    if bUnlock then
      self.avgId = storyData.StoryId
      self._mapNode.ctlAvgRoot.gameObject:SetActive(true)
      self._mapNode.ctlAvgRoot:OpenLevelInfo(storyData.StoryId, not bReaded)
      self._mapNode.t_fullscreen_blur_black:SetActive(true)
      self.curIndex = index
    end
  end)
end

function MainlineEx_SolodanceStoryCtrl:GetLockTxt(tbResult)
  local lockTxt = ""
  for i = 1, #tbResult do
    local value = tbResult[i]
    if value[1] == false then
      if UnlockConditionPriority[i] == "MustStoryIds" then
        do
          local tbStoryIds = value[2]
          for k, v in pairs(tbStoryIds) do
            if v == false then
              local storyData = ConfigTable.GetData_Story(AvgData.CFG_Story[k])
              lockTxt = orderedFormat(ConfigTable.GetUIText("Activity_Story_UnlockPreId") or "", storyData.Title)
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
              local storyData = ConfigTable.GetData_Story(AvgData.CFG_Story[k])
              lockTxt = orderedFormat(ConfigTable.GetUIText("Activity_Story_UnlockPreId") or "", storyData.Title)
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
      if UnlockConditionPriority[i] == "TimeUnlock" then
        local curTime = CS.ClientManager.Instance.serverTimeStamp
        local openTime = value[2]
        local remainTime = openTime - curTime
        if remainTime <= 60 then
          do
            local sec = math.floor(remainTime)
            lockTxt = orderedFormat(ConfigTable.GetUIText("Mainline_Open_Time_Sec") or "", sec)
          end
          break
        end
        if 60 < remainTime and remainTime <= 3600 then
          do
            local min = math.floor(remainTime / 60)
            local sec = math.floor(remainTime - min * 60)
            if sec == 0 then
              min = min - 1
              sec = 60
            end
            lockTxt = orderedFormat(ConfigTable.GetUIText("Mainline_Open_Time_Min") or "", min, sec)
          end
          break
        end
        if 3600 < remainTime and remainTime <= 86400 then
          do
            local hour = math.floor(remainTime / 3600)
            local min = math.floor((remainTime - hour * 3600) / 60)
            if min == 0 then
              hour = hour - 1
              min = 60
            end
            lockTxt = orderedFormat(ConfigTable.GetUIText("Mainline_Open_Time_Hour") or "", hour, min)
          end
          break
        end
        if 86400 < remainTime then
          local day = math.floor(remainTime / 86400)
          local hour = math.floor((remainTime - day * 86400) / 3600)
          if hour == 0 then
            day = day - 1
            hour = 24
          end
          lockTxt = orderedFormat(ConfigTable.GetUIText("Mainline_Open_Time_Day") or "", day, hour)
        end
      end
      break
    end
  end
  return lockTxt
end

function MainlineEx_SolodanceStoryCtrl:OnBtn_ClickBack()
  EventManager.Hit(EventId.ClosePanel, PanelId.SolodanceStory)
end

function MainlineEx_SolodanceStoryCtrl:OnBtn_ClickHome()
  PanelManager.Home()
end

function MainlineEx_SolodanceStoryCtrl:OnBtn_ClickCloseLevelInfoPanel()
  self._mapNode.t_fullscreen_blur_black:SetActive(false)
  self._mapNode.ctlAvgRoot.gameObject:SetActive(false)
  self._mapNode.goChapterComplete:SetActive(false)
end

function MainlineEx_SolodanceStoryCtrl:OnEvent_Story_Done(bHasReward)
  if bHasReward then
    self.bCantClick = true
  else
    self:RefreshPanel()
  end
end

function MainlineEx_SolodanceStoryCtrl:OnEvent_SelectMainlineBattle(bConfirm)
  local function OpenPanel()
    self.bEnterBattle = true
    
    EventManager.Hit(EventId.OpenPanel, PanelId.RegionBossFormation, AllEnum.RegionBossFormationType.Story, 0, self.avgId)
  end
  
  if bConfirm then
    EventManager.Hit(EventId.SetTransition, 2, OpenPanel)
  end
end

function MainlineEx_SolodanceStoryCtrl:OnEvent_Activity_Story_RewardClosed()
  self.bCantClick = false
  self.bRefreshAfterReward = true
  self:RefreshPanel()
  if self.curIndex == #self.tbChapterStoryNumIds then
    self._mapNode.goChapterComplete:SetActive(true)
  end
end

function MainlineEx_SolodanceStoryCtrl:OnBtn_ClickCloseCompete()
  self._mapNode.goChapterComplete:SetActive(false)
end

return MainlineEx_SolodanceStoryCtrl
