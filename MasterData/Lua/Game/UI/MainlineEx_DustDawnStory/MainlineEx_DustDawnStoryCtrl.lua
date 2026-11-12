local BaseCtrl = require("GameCore.UI.BaseCtrl")
local LocalData = require("GameCore.Data.LocalData")
local MainlineEx_DustDawnStoryCtrl = class("MainlineEx_DustDawnStoryCtrl", BaseCtrl)
local AvgData = PlayerData.Avg
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
MainlineEx_DustDawnStoryCtrl._mapNodeConfig = {
  svStory = {
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
  behindBG = {sNodeName = "behindBG", sComponentName = "Transform"},
  zsBG = {sNodeName = "zsBG", sComponentName = "Transform"},
  DustDawnBg = {sNodeName = "DustDawnBg", sComponentName = "Transform"},
  grpUnderBar = {
    sNodeName = "grpUnderBar",
    sComponentName = "Canvas"
  }
}
MainlineEx_DustDawnStoryCtrl._mapEventConfig = {
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
  1101,
  1102,
  1103,
  1104,
  1105,
  1106,
  1107,
  1108,
  1109,
  1110,
  1111,
  1112,
  1113,
  1114,
  1115,
  1116,
  1117,
  1118,
  1119,
  1120,
  1121,
  1122,
  1123
}
local BG_SCROLL_SPEED = 1.0
local BEHIND_BG_SCROLL_SPEED = 0.15
local DUSTDAWN_BG_SCROLL_SPEED = 0.003

function MainlineEx_DustDawnStoryCtrl:Awake()
  local tbParam = self:GetPanelParam()
  self.nChapterId = tbParam[1] ~= nil and tbParam[1] or 0
  self.bInit = false
  self.nScrollTime = 0.5
  self.tbLockedOnEnter = {}
  self.bFadeInDone = false
  self.tbGridAnimRoot = {}
  self.ani = self.gameObject:GetComponent("Animator")
  for _, storyNumId in ipairs(Storys) do
    local storyData = ConfigTable.GetData_Story(storyNumId)
    local bUnlock = AvgData:IsUnlock(storyData.ConditionId, storyData.StoryId)
    if not bUnlock then
      self.tbLockedOnEnter[storyNumId] = true
    end
  end
end

function MainlineEx_DustDawnStoryCtrl:OnEnable()
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
  NovaAPI.SetCanvasSortingName(self._mapNode.grpUnderBar, AllEnum.SortingLayerName.UI)
  NovaAPI.SetCanvasSortingOrder(self._mapNode.grpUnderBar, self._nSortingOrder + 2)
end

function MainlineEx_DustDawnStoryCtrl:FadeIn()
  EventManager.Hit(EventId.SetTransition)
  self.bFadeInDone = false
  self.bSkipGridAnim = false
  self.bInAnimPlaying = true
  self:RemoveBGScroll()
  self.ani.enabled = true
  local nAnimTime = NovaAPI.GetAnimClipLength(self.ani, {
    "DustDawnStoryPanel_in"
  })
  self.ani:Play("DustDawnStoryPanel_in")
  self:AddTimer(1, nAnimTime + 0.1, function()
    self.ani.enabled = false
    self.bInAnimPlaying = false
    self:RebaseBGScroll()
    self:InitBGScroll()
  end, true, true, true)
  self:AddTimer(1, nAnimTime - 0.5, function()
    self.bFadeInDone = true
    for _, animRoot in pairs(self.tbGridAnimRoot) do
      if animRoot ~= nil and not animRoot:IsNull() then
        animRoot.enabled = true
      end
    end
  end, true, true, true)
end

function MainlineEx_DustDawnStoryCtrl:FadeOut()
  self.ani.enabled = true
  local nAnimTime = NovaAPI.GetAnimClipLength(self.ani, {
    "DustDawnStoryPanel_out"
  })
  self.ani:Play("DustDawnStoryPanel_out")
  return nAnimTime
end

function MainlineEx_DustDawnStoryCtrl:OnDisable()
  self:RemoveBGScroll()
end

function MainlineEx_DustDawnStoryCtrl:RefreshPanel()
  self:RefreshChapterInfo()
  self:RefreshStoryList()
  self:RefreshPersonality()
end

function MainlineEx_DustDawnStoryCtrl:RefreshPersonality()
  local tbPersonality, sTitle, sFace, tbPData, nTotalCount, sHead = AvgData:CalcPersonality(1)
  NovaAPI.SetPersonalityRing(self._mapNode.gogoPersonality, tbPersonality)
  NovaAPI.SetTMPText(self._mapNode.txtPersonalityPercent1, math.floor(tbPersonality[1] * 100) .. "%")
  NovaAPI.SetTMPText(self._mapNode.txtPersonalityPercent2, math.floor(tbPersonality[2] * 100) .. "%")
  NovaAPI.SetTMPText(self._mapNode.txtPersonalityPercent3, math.floor(tbPersonality[3] * 100) .. "%")
  NovaAPI.SetTMPText(self._mapNode.txtCharName, sTitle)
  local sIcon = "Icon/PlayerHead/" .. sHead
  self:SetPngSprite(self._mapNode.imgCharHead, sIcon)
end

function MainlineEx_DustDawnStoryCtrl:RefreshChapterInfo()
  local config = ConfigTable.GetData("StoryChapter", self.nChapterId)
  NovaAPI.SetTMPText(self._mapNode.txtChapter, config.Name)
  NovaAPI.SetTMPText(self._mapNode.txtChapterTitle, config.Desc)
  NovaAPI.SetTMPText(self._mapNode.txtChapterTimeStamp, config.ChapterYear)
end

function MainlineEx_DustDawnStoryCtrl:RefreshStoryList()
  self.tbChapterStoryNumIds = Storys
  self._mapNode.svStory:Init(#self.tbChapterStoryNumIds, self, self.OnRefreshGrid)
  local recentStoryId = AvgData:GetRecentStoryId(self.nChapterId)
  if recentStoryId ~= 0 then
    for i = 1, #self.tbChapterStoryNumIds do
      if self.tbChapterStoryNumIds[i] == recentStoryId then
        self:AddTimer(1, 0.1, function()
          local time = self.bInit and 0 or self.nScrollTime
          self._mapNode.svStory:SetScrollGridPos(i, time, 0)
          self.bInit = true
        end)
        break
      end
    end
  end
  self:InitBGScroll()
end

function MainlineEx_DustDawnStoryCtrl:RebaseBGScroll()
  local content = self._mapNode.svStory.content
  if content == nil or self.bgInitX == nil then
    return
  end
  local x = content.anchoredPosition.x
  self.bgInitX = self._mapNode.behindBG.anchoredPosition.x - x * BEHIND_BG_SCROLL_SPEED
  self.zsBGInitX = self._mapNode.zsBG.anchoredPosition.x - x * BG_SCROLL_SPEED
  self.dustDawnBgInitX = self._mapNode.DustDawnBg.anchoredPosition.x - x * DUSTDAWN_BG_SCROLL_SPEED
end

function MainlineEx_DustDawnStoryCtrl:InitBGScroll()
  self:RemoveBGScroll()
  if self.bInAnimPlaying then
    return
  end
  local content = self._mapNode.svStory.content
  if content == nil then
    return
  end
  self.bgScrollContent = content
  local bgRect = self._mapNode.behindBG
  if self.bgInitX == nil then
    self.bgInitX = bgRect.anchoredPosition.x
  end
  bgRect.anchoredPosition = Vector2(self.bgInitX, bgRect.anchoredPosition.y)
  local zsBGRect = self._mapNode.zsBG
  if self.zsBGInitX == nil then
    self.zsBGInitX = zsBGRect.anchoredPosition.x
  end
  zsBGRect.anchoredPosition = Vector2(self.zsBGInitX, zsBGRect.anchoredPosition.y)
  local dustDawnBgRect = self._mapNode.DustDawnBg
  if self.dustDawnBgInitX == nil then
    self.dustDawnBgInitX = dustDawnBgRect.anchoredPosition.x
  end
  dustDawnBgRect.anchoredPosition = Vector2(self.dustDawnBgInitX, dustDawnBgRect.anchoredPosition.y)
  self:SyncBehindBG()
  
  function self.onBGScrollValueChanged(_value)
    self:SyncBehindBG()
  end
  
  self._mapNode.svStory.onValueChanged:AddListener(self.onBGScrollValueChanged)
end

function MainlineEx_DustDawnStoryCtrl:RemoveBGScroll()
  if self.onBGScrollValueChanged == nil then
    return
  end
  self._mapNode.svStory.onValueChanged:RemoveListener(self.onBGScrollValueChanged)
  self.onBGScrollValueChanged = nil
  self.bgScrollContent = nil
end

function MainlineEx_DustDawnStoryCtrl:SyncBehindBG()
  if self.bgScrollContent == nil then
    return
  end
  local offset = self.bgScrollContent.anchoredPosition.x * BG_SCROLL_SPEED
  local behindOffset = self.bgScrollContent.anchoredPosition.x * BEHIND_BG_SCROLL_SPEED
  local bgRect = self._mapNode.behindBG
  bgRect.anchoredPosition = Vector2(self.bgInitX + behindOffset, bgRect.anchoredPosition.y)
  local zsBGRect = self._mapNode.zsBG
  zsBGRect.anchoredPosition = Vector2(self.zsBGInitX + offset, zsBGRect.anchoredPosition.y)
  local dustDawnOffset = self.bgScrollContent.anchoredPosition.x * DUSTDAWN_BG_SCROLL_SPEED
  local dustDawnBgRect = self._mapNode.DustDawnBg
  dustDawnBgRect.anchoredPosition = Vector2(self.dustDawnBgInitX + dustDawnOffset, dustDawnBgRect.anchoredPosition.y)
end

function MainlineEx_DustDawnStoryCtrl:OnRefreshGrid(grid, index)
  index = index + 1
  local storyNumId = self.tbChapterStoryNumIds[index]
  local storyData = ConfigTable.GetData_Story(storyNumId)
  local bUnlock, tbResult = AvgData:IsUnlock(storyData.ConditionId, storyData.StoryId)
  local bReaded = AvgData:IsStoryReaded(storyData.Id)
  local btnStoryNode = grid.transform:Find("Normal/btnGrid"):GetComponent("UIButton")
  local animRoot = grid.transform:Find("Normal/btnGrid/AnimRoot"):GetComponent("Animator")
  if animRoot ~= nil then
    local goInstanceIDForAnim = grid:GetInstanceID()
    self.tbGridAnimRoot[goInstanceIDForAnim] = animRoot
    animRoot.enabled = self.bFadeInDone and not self.bSkipGridAnim
  end
  local rootNode = grid.transform:Find("Normal/btnGrid/AnimRoot/RootNode")
  local goComplete = rootNode:Find("goComplete").gameObject
  local imgCheck = rootNode:Find("goComplete/imgBg/imgCheck").gameObject
  local txtComplete = rootNode:Find("goComplete/imgBg/txtComplete"):GetComponent("TMP_Text")
  local goNotOpen = rootNode:Find("goNotOpen").gameObject
  local imgLevelLock = rootNode:Find("goNotOpen/imgLevelLock").gameObject
  local nodeUnOpen = rootNode:Find("goNotOpen/txtUnOpen")
  local txtUnOpen = nodeUnOpen:GetComponent("TMP_Text")
  local canvasUnOpen = nodeUnOpen:GetComponent("Canvas")
  local imgStoryBg = rootNode:Find("imgStoryBg").gameObject
  local imgStoryTitle = rootNode:Find("imgStoryTitle").gameObject
  local storyTitle = rootNode:Find("imgStoryTitle/txtIndex"):GetComponent("TMP_Text")
  local imgBattleBg = rootNode:Find("imgBattleBg").gameObject
  local imgBattleTitle = rootNode:Find("imgBattleTitle").gameObject
  local battleTitle = rootNode:Find("imgBattleTitle/txtIndex"):GetComponent("TMP_Text")
  local imgCheckDone = rootNode:Find("imgCheck").gameObject
  local txtIndex = rootNode:Find("imgNumDb/txtIndex"):GetComponent("TMP_Text")
  local nodeGroupDone = rootNode:Find("tmpGroupDone")
  local btnGroupTxt = nodeGroupDone:GetComponent("TMP_Text")
  local canvasGroupDone = nodeGroupDone:GetComponent("Canvas")
  local goImgTime = rootNode:Find("imgTime").gameObject
  local imgTimeLevelLock = rootNode:Find("imgTime/imgLevelLock").gameObject
  local txtTime = rootNode:Find("imgTime/txtTime"):GetComponent("TMP_Text")
  local redDot = rootNode:Find("RedDot").gameObject
  local bTimeLocked = self:IsChapterStoryTimeLocked(index)
  NovaAPI.SetCanvasSortingName(canvasGroupDone, AllEnum.SortingLayerName.UI)
  NovaAPI.SetCanvasSortingOrder(canvasGroupDone, self._nSortingOrder + 1)
  NovaAPI.SetCanvasSortingName(canvasUnOpen, AllEnum.SortingLayerName.UI)
  NovaAPI.SetCanvasSortingOrder(canvasUnOpen, self._nSortingOrder + 1)
  if self.tbGridCanvas == nil then
    self.tbGridCanvas = {}
  end
  self.tbGridCanvas[grid:GetInstanceID()] = {canvasUnOpen, canvasGroupDone}
  canvasUnOpen.enabled = not self.bAvgRootOpen
  canvasGroupDone.enabled = not self.bAvgRootOpen
  NovaAPI.SetTMPText(btnGroupTxt, storyData.Title)
  NovaAPI.SetTMPText(storyTitle, ConfigTable.GetUIText("Story_StoryTitle") or "")
  NovaAPI.SetTMPText(battleTitle, ConfigTable.GetUIText("Story_BattleTitle") or "")
  imgStoryBg.gameObject:SetActive(storyData.IsBattle == false)
  imgStoryTitle.gameObject:SetActive(storyData.IsBattle == false and bUnlock and not bTimeLocked)
  imgBattleBg.gameObject:SetActive(storyData.IsBattle == true)
  imgBattleTitle.gameObject:SetActive(storyData.IsBattle == true and bUnlock and not bTimeLocked)
  local nodeStoryDeco = rootNode:Find("imgStoryBg/imgDeco1")
  if nodeStoryDeco ~= nil then
    nodeStoryDeco.gameObject:SetActive(bUnlock and not bTimeLocked)
  end
  local nodeBattleDeco = rootNode:Find("imgBattleBg/imgDeco1")
  if nodeBattleDeco ~= nil then
    nodeBattleDeco.gameObject:SetActive(bUnlock and not bTimeLocked)
  end
  btnGroupTxt.gameObject:SetActive(bUnlock and not bTimeLocked)
  imgCheck:SetActive(bReaded)
  txtComplete.gameObject:SetActive(bReaded)
  goComplete:SetActive(bUnlock and bReaded)
  imgCheckDone:SetActive(bUnlock and bReaded)
  goNotOpen:SetActive(not bUnlock and not bTimeLocked)
  redDot:SetActive(bUnlock and not bReaded and not bTimeLocked)
  rootNode.gameObject:SetActive(true)
  NovaAPI.SetTMPText(txtIndex, storyData.Index)
  if bUnlock then
    NovaAPI.SetTMPText(txtIndex, storyData.Index)
  elseif not bTimeLocked then
    local sLockDesc = self:GetLockTxt(tbResult)
    NovaAPI.SetTMPText(txtUnOpen, sLockDesc)
  end
  imgTimeLevelLock.gameObject:SetActive(bTimeLocked)
  goImgTime.gameObject:SetActive(bTimeLocked)
  if self.tbGridTimer == nil then
    self.tbGridTimer = {}
  end
  local goInstanceID = grid:GetInstanceID()
  if self.tbGridTimer[goInstanceID] ~= nil then
    self.tbGridTimer[goInstanceID]:Cancel()
    self.tbGridTimer[goInstanceID] = nil
  end
  if bTimeLocked then
    local openTime = self:GetStoryUnlockTime(storyData.StoryId)
    self.tbGridTimer[goInstanceID] = self:AddTimer(0, 1, function()
      local curTime = CS.ClientManager.Instance.serverTimeStamp
      if curTime >= openTime then
        self:RefreshStoryList()
      else
        NovaAPI.SetTMPText(txtTime, self:GetTimeUnlockLockText(openTime - curTime))
      end
    end, true, true, true)
    NovaAPI.SetTMPText(txtTime, self:GetTimeUnlockLockText(openTime - CS.ClientManager.Instance.serverTimeStamp))
  end
  btnStoryNode.onClick:RemoveAllListeners()
  btnStoryNode.onClick:AddListener(function()
    if self.bCantClick then
      return
    end
    if bTimeLocked then
      local sRemainTime = self:GetTimeUnlockLockText(self:GetStoryUnlockTime(storyData.StoryId) - CS.ClientManager.Instance.serverTimeStamp)
      EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("Story_Will_Unlock_In_Time") or "", sRemainTime))
      return
    end
    if bUnlock then
      self.avgId = storyData.StoryId
      self:SetGridCanvasVisible(false)
      self._mapNode.ctlAvgRoot.gameObject:SetActive(true)
      self._mapNode.ctlAvgRoot:OpenLevelInfo(storyData.StoryId, not bReaded)
      self._mapNode.t_fullscreen_blur_black:SetActive(true)
      self.curIndex = index
    end
  end)
end

function MainlineEx_DustDawnStoryCtrl:IsStoryTimeLocked(avgId)
  local configValue = ConfigTable.GetConfigValue("TimeUnlockStory", "")
  if configValue == nil or configValue ~= avgId then
    return false
  end
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local openTime = self:GetStoryUnlockTime(avgId)
  return curTime < openTime
end

function MainlineEx_DustDawnStoryCtrl:IsChapterStoryTimeLocked(index)
  local configValue = ConfigTable.GetConfigValue("TimeUnlockStory", "")
  if configValue == nil then
    return false
  end
  local nLockedIndex
  for i, storyNumId in ipairs(self.tbChapterStoryNumIds) do
    local storyData = ConfigTable.GetData_Story(storyNumId)
    if storyData.StoryId == configValue then
      nLockedIndex = i
      break
    end
  end
  if nLockedIndex == nil or index < nLockedIndex then
    return false
  end
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local openTime = self:GetStoryUnlockTime(configValue)
  return curTime < openTime
end

function MainlineEx_DustDawnStoryCtrl:GetStoryUnlockTime(avgId)
  local time = ConfigTable.GetConfigValue("StoryUnlockTime", "")
  return CS.ClientManager.Instance:ISO8601StrToTimeStamp(time)
end

function MainlineEx_DustDawnStoryCtrl:GetTimeUnlockLockText(remainTime)
  local lockTxt = ""
  if remainTime <= 60 then
    local sec = math.floor(remainTime)
    lockTxt = orderedFormat(ConfigTable.GetUIText("StarTower_Reward_Refresh_Remain_Time_Sec") or "", sec)
  elseif 60 < remainTime and remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    local sec = math.floor(remainTime - min * 60)
    if sec == 0 then
      min = min - 1
      sec = 60
    end
    lockTxt = orderedFormat(ConfigTable.GetUIText("StarTower_Reward_Refresh_Remain_Time_Min") or "", min, sec)
  elseif 3600 < remainTime and remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    local min = math.floor((remainTime - hour * 3600) / 60)
    if min == 0 then
      hour = hour - 1
      min = 60
    end
    lockTxt = orderedFormat(ConfigTable.GetUIText("StarTower_Reward_Refresh_Remain_Time_Hour") or "", hour, min)
  elseif 86400 < remainTime then
    local day = math.floor(remainTime / 86400)
    local hour = math.floor((remainTime - day * 86400) / 3600)
    if hour == 0 then
      day = day - 1
      hour = 24
    end
    lockTxt = orderedFormat(ConfigTable.GetUIText("StarTower_Reward_Refresh_Remain_Time_Day") or "", day, hour)
  end
  return lockTxt
end

function MainlineEx_DustDawnStoryCtrl:GetLockTxt(tbResult)
  local lockTxt = ""
  if tbResult == nil then
    return lockTxt
  end
  for i = 1, #tbResult do
    local value = tbResult[i]
    if value[1] == false then
      local sConditionKey = UnlockConditionPriority[i]
      if sConditionKey == "MustStoryIds" or sConditionKey == "OneofStoryIds" then
        local tbStoryIds = value[2]
        for nStoryId, bStoryUnlock in pairs(tbStoryIds) do
          if bStoryUnlock == false then
            local mapStory = ConfigTable.GetData_Story(AvgData.CFG_Story[nStoryId])
            if mapStory ~= nil then
              lockTxt = orderedFormat(ConfigTable.GetUIText("Story_UnlockPreId_Color_Common") or "", "d2c6a7", mapStory.Title)
            end
            break
          end
        end
      elseif sConditionKey == "MustEvIds" or sConditionKey == "OneofEvIds" then
        lockTxt = ConfigTable.GetUIText("Story_UnlockClueCondition")
      elseif sConditionKey == "WorldLevel" then
        local nNeedWorldLevel = value[2]
        lockTxt = orderedFormat(ConfigTable.GetUIText("Story_UnlockWorldLv") or "", nNeedWorldLevel)
      elseif sConditionKey == "MustAchievementIds" then
        local tbAchievementList = value[2]
        for nAchievementId, bAchievementUnlock in pairs(tbAchievementList) do
          if bAchievementUnlock == false then
            local mapAchievement = ConfigTable.GetData("Achievement", nAchievementId)
            if mapAchievement ~= nil then
              lockTxt = orderedFormat(ConfigTable.GetUIText("Story_UnlockPreId_Color_Common") or "", "d2c6a7", mapAchievement.Name)
            end
            break
          end
        end
      end
      if lockTxt ~= "" then
        break
      end
    end
  end
  return lockTxt
end

function MainlineEx_DustDawnStoryCtrl:OnBtn_ClickBack()
  EventManager.Hit(EventId.ClosePanel, PanelId.DustDawnStory)
end

function MainlineEx_DustDawnStoryCtrl:OnBtn_ClickHome()
  PanelManager.Home()
end

function MainlineEx_DustDawnStoryCtrl:SetGridCanvasVisible(bVisible)
  self.bAvgRootOpen = not bVisible
  if self.tbGridCanvas == nil then
    return
  end
  for _, tbCanvas in pairs(self.tbGridCanvas) do
    for _, canvas in ipairs(tbCanvas) do
      if canvas ~= nil and not canvas:IsNull() then
        canvas.enabled = bVisible
      end
    end
  end
end

function MainlineEx_DustDawnStoryCtrl:OnBtn_ClickCloseLevelInfoPanel()
  self:SetGridCanvasVisible(true)
  self._mapNode.t_fullscreen_blur_black:SetActive(false)
  self._mapNode.ctlAvgRoot.gameObject:SetActive(false)
  self._mapNode.goChapterComplete:SetActive(false)
end

function MainlineEx_DustDawnStoryCtrl:OnEvent_Story_Done(bHasReward)
  self.bSkipGridAnim = true
  for _, animRoot in pairs(self.tbGridAnimRoot) do
    if animRoot ~= nil and not animRoot:IsNull() then
      animRoot.enabled = false
    end
  end
  if bHasReward then
    self.bCantClick = true
  else
    self:RefreshPanel()
  end
end

function MainlineEx_DustDawnStoryCtrl:OnEvent_SelectMainlineBattle(bConfirm)
  self:SetGridCanvasVisible(true)
  
  local function OpenPanel()
    self.bEnterBattle = true
    EventManager.Hit(EventId.OpenPanel, PanelId.RegionBossFormation, AllEnum.RegionBossFormationType.Story, 0, self.avgId)
  end
  
  if bConfirm then
    EventManager.Hit(EventId.SetTransition, 2, OpenPanel)
  end
end

function MainlineEx_DustDawnStoryCtrl:OnEvent_Activity_Story_RewardClosed()
  self.bCantClick = false
  self.bRefreshAfterReward = true
  self:RefreshPanel()
  if self.curIndex == #self.tbChapterStoryNumIds then
    self._mapNode.goChapterComplete:SetActive(true)
  end
end

function MainlineEx_DustDawnStoryCtrl:OnBtn_ClickCloseCompete()
  self._mapNode.goChapterComplete:SetActive(false)
end

return MainlineEx_DustDawnStoryCtrl
