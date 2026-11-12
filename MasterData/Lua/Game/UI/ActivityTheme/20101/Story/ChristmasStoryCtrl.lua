local BaseCtrl = require("GameCore.UI.BaseCtrl")
local LocalData = require("GameCore.Data.LocalData")
local ChristmasStoryCtrl = class("ChristmasThemeCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
ChristmasStoryCtrl._mapNodeConfig = {
  tranContent = {
    sNodeName = "StoryContent",
    sComponentName = "RectTransform"
  },
  behindBG = {
    sNodeName = "behindBG",
    sComponentName = "RectTransform"
  },
  frontBG = {
    sNodeName = "frontBG",
    sComponentName = "RectTransform"
  },
  frontLeaf = {
    sNodeName = "frontLeaf",
    sComponentName = "RectTransform"
  },
  scrollRect = {
    sNodeName = "goStoryNode",
    sComponentName = "ScrollRect"
  },
  TopBarPanel = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  ctlAvgRoot = {
    sNodeName = "goAvgInfoRoot",
    sCtrlName = "Game.UI.ActivityTheme.ActivityAvgInfoExCtrl"
  },
  ctlgoEnemyInfo = {
    sNodeName = "goEnemyInfo",
    sCtrlName = "Game.UI.MainlineEx.MainlineMonsterInfoCtrl"
  },
  goChapterComplete = {},
  snapshot = {
    sComponentName = "UIButton",
    callback = "OnBtn_ClickCloseCompete"
  }
}
ChristmasStoryCtrl._mapEventConfig = {
  Story_Done = "OnEvent_Story_Done",
  SelectMainlineBattle = "OnEvent_SelectMainlineBattle",
  Story_RewardClosed = "OnEvent_Activity_Story_RewardClosed"
}
ChristmasStoryCtrl._mapRedDotConfig = {}
local UnlockConditionPriority = {
  [1] = "MustStoryIds",
  [2] = "OneofStoryIds",
  [3] = "MustEvIds",
  [4] = "OneofEvIds",
  [5] = "WorldLevel",
  [6] = "MustAchievementIds",
  [7] = "MustActivityLevel"
}
local BranchAnimName = {
  [1] = "btnStoryNode_in",
  [2] = "btnStoryNode_in4B",
  [3] = "btnStoryNode_in4C"
}
local BranchRefreshIndex = {
  [1] = 1,
  [2] = 3,
  [3] = 2
}

function ChristmasStoryCtrl:Awake()
  local tbParam = self:GetPanelParam()
  self.nActId = tbParam[1]
  self.bReview = tbParam[2] == true
  self.storyData = self.bReview and PlayerData.StoryReview or PlayerData.ActivityAvg
  self.nChapterId = self.storyData:GetChapterIdByActivityId(self.nActId)
  self.tbAvgIds = self.storyData:GetChapterStoryNumIds(self.nChapterId)
  self.nRefreshIndex = 1
  self.OpenStoryNodeIndex = 1
  self.parallaxSpeed = {
    behindBG = 0.3,
    frontBG = 3,
    frontLeaf = 1
  }
  self.lastContentPos = nil
end

function ChristmasStoryCtrl:FadeIn()
end

function ChristmasStoryCtrl:OnEnable()
  self:RefreshPanel()
end

function ChristmasStoryCtrl:OnDisable()
  self:RemoveParallaxScroll()
end

function ChristmasStoryCtrl:RefreshPanel()
  self.nRefreshIndex = 1
  self.OpenStoryNodeIndex = 1
  self.UnLockStoryNodeIndex = -1
  self:CacheStoryNode()
  self:RefreshNeedHideNode()
  self:RefreshStoryList()
  self:InitParallaxScroll()
  self:ScrollToRecentStory()
end

function ChristmasStoryCtrl:GetRemainTimeStr(nOpenTime, openDay)
  local timeStr = ""
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local openTime = CS.ClientManager.Instance:GetNextRefreshTime(nOpenTime) - 86400
  local nRemainTime = openTime + openDay * 86400 - curTime
  local day = math.floor(nRemainTime / 86400)
  local hour = math.floor(nRemainTime / 3600)
  local min = math.floor((nRemainTime - hour * 3600) / 60)
  local sec = nRemainTime - hour * 3600 - min * 60
  if 0 < day then
    timeStr = orderedFormat(ConfigTable.GetUIText("ActivityStory_Lock_Day_Color"), day)
  elseif 0 < hour then
    timeStr = orderedFormat(ConfigTable.GetUIText("ActivityStory_Lock_Hour_Color"), hour)
  elseif 0 < min then
    timeStr = orderedFormat(ConfigTable.GetUIText("ActivityStory_Lock_Min_Color"), min)
  elseif 0 < sec then
    timeStr = orderedFormat(ConfigTable.GetUIText("ActivityStory_Lock_Sec_Color"), sec)
  end
  return timeStr, 0 < nRemainTime
end

function ChristmasStoryCtrl:CacheStoryNode()
  self.tbStoryNode = {}
  self.tbBranch = {}
  self.tbLine = {}
  self.maxIndex = 0
  local index = 0
  for i = 1, self._mapNode.tranContent.childCount do
    local goChild = self._mapNode.tranContent:GetChild(i - 1)
    if IsStartsWith(goChild.name, "Line") then
      table.insert(self.tbLine, goChild)
    else
      index = index + 1
      if goChild.transform.childCount > 2 then
        for j = 1, goChild.transform.childCount - 1 do
          local goSubChild = goChild.transform:GetChild(j - 1)
          table.insert(self.tbStoryNode, {
            node = goSubChild,
            index = index,
            isBranch = true
          })
          self.tbBranch[goSubChild.name] = {
            refreshIndex = BranchRefreshIndex[j],
            animName = BranchAnimName[j]
          }
          local cfg = self.storyData:GetStoryCfgData(goSubChild.name)
          local isRead = self.storyData:IsStoryReaded(cfg.Id)
          if isRead then
            self.curReadedId = cfg.Id
          end
        end
      else
        table.insert(self.tbStoryNode, {node = goChild, index = index})
        local cfg = self.storyData:GetStoryCfgData(goChild.name)
        local isRead = self.storyData:IsStoryReaded(cfg.Id)
        if isRead then
          self.curReadedId = cfg.Id
        end
      end
      self.maxIndex = index
    end
  end
  table.sort(self.tbStoryNode, function(a, b)
    if a.index ~= b.index then
      return a.index < b.index
    end
    if a.isBranch and b.isBranch then
      local aRefreshIndex = self.tbBranch[a.node.name].refreshIndex
      local bRefreshIndex = self.tbBranch[b.node.name].refreshIndex
      return aRefreshIndex < bRefreshIndex
    end
    return false
  end)
end

function ChristmasStoryCtrl:RefreshStoryList()
  if self.nRefreshIndex > #self.tbStoryNode then
    return
  end
  local goNode = self.tbStoryNode[self.nRefreshIndex]
  local isBranch = goNode.isBranch or false
  if self.UnLockStoryNodeIndex ~= -1 and goNode.index > self.UnLockStoryNodeIndex + 1 then
    return
  end
  
  local function callback()
    if goNode.index <= #self.tbLine then
      local line = self.tbLine[goNode.index].transform:GetChild(0)
      line.gameObject:SetActive(self.UnLockStoryNodeIndex ~= nil and goNode.index <= self.UnLockStoryNodeIndex)
    end
    self:RefreshStoryList()
  end
  
  self:RefreshStoryNode(goNode.node, goNode.index, goNode.isBranch or false, callback)
end

function ChristmasStoryCtrl:RefreshStoryNode(goNode, index, isBranch, callback)
  if self.NotOpenStoryNodeIndex ~= nil and index > self.NotOpenStoryNodeIndex then
    return
  end
  local avgId = goNode.name
  local avgCfg = self.storyData:GetStoryCfgData(avgId)
  local btnStoryNode = goNode.transform:Find("btnStoryNode"):GetComponent("UIButton")
  local animRoot = goNode.transform:Find("btnStoryNode/AnimRoot")
  local animator = animRoot:GetComponent("Animator")
  local goOpen = animRoot.transform:Find("goOpen")
  local goUnOpen = isBranch == false and goNode.transform:Find("goUnOpen") or goNode.transform.parent:Find("goUnOpen")
  local bOpen, nOpenTime = self.storyData:IsOpen(avgId, self.nActId)
  btnStoryNode.gameObject:SetActive(true)
  goOpen.gameObject:SetActive(bOpen)
  goUnOpen.gameObject:SetActive(not bOpen)
  if not bOpen then
    local txtOpenCountDown = goUnOpen.transform:Find("txtOpenCountDown"):GetComponent("TMP_Text")
    local strTime = self:GetRemainTimeStr(nOpenTime, avgCfg.DayOpen)
    self:AddTimer(0, 1, function()
      local strTime, bLock = self:GetRemainTimeStr(nOpenTime, avgCfg.DayOpen)
      if bLock then
        NovaAPI.SetTMPText(txtOpenCountDown, strTime)
      else
        self:RefreshStoryList()
      end
    end, true, true, true)
    NovaAPI.SetTMPText(txtOpenCountDown, strTime)
    self.NotOpenStoryNodeIndex = index
  else
    self.OpenStoryNodeIndex = index
  end
  local isUnlock, tbResult = self.storyData:IsUnlock(avgCfg.ConditionId)
  local goUnLock = goOpen.transform:Find("goUnlock")
  local goLock = goOpen.transform:Find("goLock")
  local isBattle = avgCfg.IsBattle
  if not isBattle then
    local txtPlot = goUnLock.transform:Find("imgStoryTitleBg/txtPlot"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(txtPlot, ConfigTable.GetUIText("TowerDef_Story"))
  else
    local txtBattle = goUnLock.transform:Find("imgStoryTitleBg/txtBattle"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(txtBattle, ConfigTable.GetUIText("SelectTeam_StartBattle"))
  end
  local isReaded = self.storyData:IsStoryReaded(avgCfg.Id)
  goLock.gameObject:SetActive(not isUnlock)
  goUnLock.gameObject:SetActive(isUnlock)
  local txtTitle = goUnLock.transform:Find("txtTitle"):GetComponent("TMP_Text")
  local imgComplete = goUnLock.transform:Find("imgComplete").gameObject
  local txtLocked = goLock.transform:Find("txtLocked"):GetComponent("TMP_Text")
  imgComplete:SetActive(isReaded)
  NovaAPI.SetTMPText(txtTitle, avgCfg.Title)
  NovaAPI.SetTMPText(txtLocked, ConfigTable.GetUIText("Story_Unkown_Chapter"))
  local goRedDot = goOpen.transform:Find("redDot").gameObject
  if self.bReview then
    goRedDot:SetActive(false)
  else
    local bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(self.nActId)
    RedDotManager.RegisterNode(RedDotDefine.Activity_GroupNew_Avg_Group, {
      nActGroupId,
      self.nActId,
      avgCfg.Id
    }, goRedDot, nil, nil, true)
  end
  btnStoryNode.onClick:RemoveAllListeners()
  btnStoryNode.onClick:AddListener(function()
    if not bOpen then
      return
    end
    if isUnlock then
      local bNew = not isReaded
      self.avgId = avgId
      self._mapNode.ctlAvgRoot.gameObject:SetActive(true)
      self._mapNode.ctlAvgRoot:OpenLevelInfo(avgId, self.nActId, bNew, self.bReview)
      if bNew then
        self.curIndex = index
      end
      LocalData.SetPlayerLocalData(self.storyData:_GetLocalReadKey(self.nActId, avgCfg.Id), true)
      self.storyData:RefreshAvgRedDot()
    elseif tbResult ~= nil then
      local lockTxt = ""
      for i = 1, #tbResult do
        local value = tbResult[i]
        if value[1] == false then
          if UnlockConditionPriority[i] == "MustStoryIds" then
            local tbStoryIds = value[2]
            for k, v in pairs(tbStoryIds) do
              if v == false then
                local storyData = ConfigTable.GetData("ActivityStory", k)
                lockTxt = orderedFormat(ConfigTable.GetUIText("Story_UnlockPreId") or "", storyData.Title)
                break
              end
            end
          elseif UnlockConditionPriority[i] == "OneofStoryIds" then
            local tbStoryIds = value[2]
            for k, v in pairs(tbStoryIds) do
              if v == false then
                local storyData = ConfigTable.GetData("ActivityStory", k)
                if self.storyData:IsUnlock(storyData.Id) then
                  lockTxt = orderedFormat(ConfigTable.GetUIText("Story_UnlockPreId") or "", storyData.Title)
                  break
                end
              end
            end
          elseif UnlockConditionPriority[i] == "MustEvIds" then
            lockTxt = ConfigTable.GetUIText("Story_UnlockClueCondition")
          elseif UnlockConditionPriority[i] == "OneofEvIds" then
            lockTxt = ConfigTable.GetUIText("Story_UnlockClueCondition")
          elseif UnlockConditionPriority[i] == "WorldLevel" then
            local level = value[2]
            lockTxt = orderedFormat(ConfigTable.GetUIText("Story_UnlockWorldLv") or "", level)
          elseif UnlockConditionPriority[i] == "MustAchievementIds" then
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
          elseif UnlockConditionPriority[i] == "MustActivityLevel" then
            local levelId = value[2]
            if 0 < levelId then
              local levelData = ConfigTable.GetData("ActivityLevelsLevel", levelId)
              if levelData then
                lockTxt = orderedFormat(ConfigTable.GetUIText("ActivityStory_UnlockActivityLevel"), levelData.Name)
                break
              end
            end
          end
        end
      end
      local msg = {
        nType = AllEnum.MessageBox.Alert,
        sContent = lockTxt
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
    end
  end)
  local nTime = 0
  local animName = "btnStoryNode_in"
  if isBranch then
    local branchNode = self.tbBranch[avgId]
    animName = branchNode.animName
  end
  if isUnlock then
    local bPlayUnlockAnim = LocalData.GetPlayerLocalData("ActivityStory_AnimUnlock_" .. avgCfg.Id) ~= 1
    if bPlayUnlockAnim then
      nTime = 1
      animator:Play(animName)
      WwiseAudioMgr:PostEvent("ui_christmas_baubles_ani")
      LocalData.SetPlayerLocalData("ActivityStory_AnimUnlock_" .. avgCfg.Id, 1)
    end
  else
    local bPlayLockAnim = LocalData.GetPlayerLocalData("ActivityStory_AnimLock_" .. avgCfg.Id) ~= 1
    if bPlayLockAnim then
      nTime = isBranch and 0.14 or 1
      animator:Play(animName)
      WwiseAudioMgr:PostEvent("ui_christmas_baubles_ani")
      LocalData.SetPlayerLocalData("ActivityStory_AnimLock_" .. avgCfg.Id, 1)
    end
  end
  if isUnlock then
    self.UnLockStoryNodeIndex = index
  end
  self.nRefreshIndex = self.nRefreshIndex + 1
  if 0 < nTime then
    self:AddTimer(1, nTime, function()
      callback()
    end, true, true, true)
  else
    callback()
  end
end

function ChristmasStoryCtrl:RefreshNeedHideNode()
  local bSetNotOpenIndex = false
  local openIndex = 0
  for i = 1, #self.tbStoryNode do
    local goNode = self.tbStoryNode[i]
    local avgId = goNode.node.name
    local bOpen = self.storyData:IsOpen(avgId, self.nActId)
    local avgCfg = self.storyData:GetStoryCfgData(avgId)
    local isUnlock = self.storyData:IsUnlock(avgCfg.ConditionId)
    local bShowTimelock = false
    if not bOpen and not bSetNotOpenIndex then
      self.NotOpenStoryNodeIndex = goNode.index
      bSetNotOpenIndex = true
      bShowTimelock = true
    end
    if isUnlock then
      openIndex = goNode.index
    end
    goNode.node.gameObject:SetActive((bOpen or bShowTimelock) and (isUnlock or openIndex >= goNode.index - 1))
  end
  for i = 1, #self.tbLine do
    local line = self.tbLine[i]
    line.gameObject:SetActive(i <= openIndex)
    if self.NotOpenStoryNodeIndex ~= nil and i >= self.NotOpenStoryNodeIndex then
      line.gameObject:SetActive(false)
    end
  end
end

function ChristmasStoryCtrl:InitParallaxScroll()
  if self._mapNode.scrollRect == nil then
    return
  end
  if self._mapNode.behindBG == nil or self._mapNode.frontBG == nil or self._mapNode.frontLeaf == nil then
    return
  end
  if self.initialPositions == nil then
    self.initialPositions = {
      behindBG = self._mapNode.behindBG.anchoredPosition,
      frontBG = self._mapNode.frontBG.anchoredPosition,
      frontLeaf = self._mapNode.frontLeaf.anchoredPosition
    }
  end
  self.layerWidths = {
    behindBG = self._mapNode.behindBG.sizeDelta.x,
    frontBG = self._mapNode.frontBG.sizeDelta.x,
    frontLeaf = self._mapNode.frontLeaf.sizeDelta.x
  }
  CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.tranContent)
  local viewport = self._mapNode.scrollRect.viewport
  if viewport == nil then
    return
  end
  local scrollContent = self._mapNode.scrollRect.content
  if scrollContent == nil then
    return
  end
  local viewportWidth = viewport.rect.width
  local contentWidth = scrollContent.rect.width
  self.scrollableRange = contentWidth - viewportWidth
  self.lastNormalizedPos = self._mapNode.scrollRect.horizontalNormalizedPosition
  
  function self.onScrollValueChanged(value)
    self:OnScrollValueChanged(value)
  end
  
  self._mapNode.scrollRect.onValueChanged:AddListener(self.onScrollValueChanged)
end

function ChristmasStoryCtrl:RemoveParallaxScroll()
  if self._mapNode.scrollRect ~= nil and self.onScrollValueChanged ~= nil then
    self._mapNode.scrollRect.onValueChanged:RemoveListener(self.onScrollValueChanged)
    self.onScrollValueChanged = nil
  end
end

function ChristmasStoryCtrl:OnScrollValueChanged(_value)
  if self.scrollableRange == nil or self.initialPositions == nil then
    return
  end
  local currentNormalizedPos = self._mapNode.scrollRect.horizontalNormalizedPosition
  local boundaryThreshold = 0.001
  local isAtStart = currentNormalizedPos <= boundaryThreshold
  local isAtEnd = currentNormalizedPos >= 1 - boundaryThreshold
  local currentContentPos = self._mapNode.tranContent.anchoredPosition.x
  local actualScrollOffset = -currentContentPos
  if isAtStart or isAtEnd then
    local boundaryScrollOffset
    if isAtStart then
      boundaryScrollOffset = 0
    else
      boundaryScrollOffset = self.scrollableRange
    end
    if self._mapNode.behindBG ~= nil then
      local newX = self.initialPositions.behindBG.x - boundaryScrollOffset * self.parallaxSpeed.behindBG
      self._mapNode.behindBG.anchoredPosition = Vector2(newX, self.initialPositions.behindBG.y)
    end
    if self._mapNode.frontBG ~= nil then
      local newX = self.initialPositions.frontBG.x - boundaryScrollOffset * self.parallaxSpeed.frontBG
      self._mapNode.frontBG.anchoredPosition = Vector2(newX, self.initialPositions.frontBG.y)
    end
    if self._mapNode.frontLeaf ~= nil then
      local newX = self.initialPositions.frontLeaf.x - boundaryScrollOffset * self.parallaxSpeed.frontLeaf
      self._mapNode.frontLeaf.anchoredPosition = Vector2(newX, self.initialPositions.frontLeaf.y)
    end
    return
  end
  if self._mapNode.behindBG ~= nil then
    local newX = self.initialPositions.behindBG.x - actualScrollOffset * self.parallaxSpeed.behindBG
    self._mapNode.behindBG.anchoredPosition = Vector2(newX, self.initialPositions.behindBG.y)
  end
  if self._mapNode.frontBG ~= nil then
    local newX = self.initialPositions.frontBG.x - actualScrollOffset * self.parallaxSpeed.frontBG
    self._mapNode.frontBG.anchoredPosition = Vector2(newX, self.initialPositions.frontBG.y)
  end
  if self._mapNode.frontLeaf ~= nil then
    local newX = self.initialPositions.frontLeaf.x - actualScrollOffset * self.parallaxSpeed.frontLeaf
    self._mapNode.frontLeaf.anchoredPosition = Vector2(newX, self.initialPositions.frontLeaf.y)
  end
end

function ChristmasStoryCtrl:OnEvent_Story_Done(bHasReward)
  if not bHasReward then
    self:RefreshPanel()
  end
end

function ChristmasStoryCtrl:OnEvent_SelectMainlineBattle(bConfirm)
  local function OpenPanel()
    EventManager.Hit(EventId.OpenPanel, PanelId.RegionBossFormation, AllEnum.RegionBossFormationType.ActivityStory, 0, self.avgId, self.nActId, self.bReview)
  end
  
  if bConfirm then
    EventManager.Hit(EventId.SetTransition, 2, OpenPanel)
  end
end

function ChristmasStoryCtrl:OnEvent_Activity_Story_RewardClosed()
  self:RefreshPanel()
  if self.maxIndex == self.curIndex then
    self._mapNode.goChapterComplete:SetActive(true)
    EventManager.Hit("ActivityStoryReceive_SetVisible", false)
  end
end

function ChristmasStoryCtrl:OnBtn_ClickCloseCompete()
  self._mapNode.goChapterComplete:SetActive(false)
  EventManager.Hit("ActivityStoryReceive_SetVisible", true)
end

function ChristmasStoryCtrl:ScrollToRecentStory()
  if self._mapNode.scrollRect == nil then
    return
  end
  local nRecentStoryId = self.curReadedId
  if nRecentStoryId == nil or nRecentStoryId == 0 then
    return
  end
  local storyCfg = ConfigTable.GetData("ActivityStory", nRecentStoryId)
  if storyCfg == nil then
    return
  end
  local targetStoryId = storyCfg.StoryId
  local targetNodeData
  for _, nodeData in ipairs(self.tbStoryNode) do
    if nodeData.node.name == targetStoryId then
      targetNodeData = nodeData
      break
    end
  end
  if targetNodeData == nil then
    return
  end
  local targetNode, nextNodeData
  local targetIndex = targetNodeData.index
  for _, nodeData in ipairs(self.tbStoryNode) do
    if nodeData.index == targetIndex + 1 then
      nextNodeData = nodeData
      break
    end
  end
  if nextNodeData ~= nil then
    if nextNodeData.isBranch then
      targetNode = nextNodeData.node.transform.parent
    else
      targetNode = nextNodeData.node
    end
  else
    targetNode = targetNodeData.node
  end
  CS.UnityEngine.Canvas.ForceUpdateCanvases()
  local scrollContent = self._mapNode.scrollRect.content
  local viewport = self._mapNode.scrollRect.viewport
  if scrollContent == nil or viewport == nil then
    return
  end
  local targetRectTransform = targetNode:GetComponent("RectTransform")
  if targetRectTransform == nil then
    return
  end
  local viewportWidth = viewport.rect.width
  local contentWidth = scrollContent.rect.width
  if viewportWidth >= contentWidth then
    return
  end
  local targetAnchoredPos = targetRectTransform.anchoredPosition
  local scrollableRange = contentWidth - viewportWidth
  local targetScrollPos = targetAnchoredPos.x - viewportWidth * 0.5
  targetScrollPos = math.max(0, math.min(targetScrollPos, scrollableRange))
  local normalizedPos = targetScrollPos / scrollableRange
  self._mapNode.scrollRect.horizontalNormalizedPosition = normalizedPos
  self.lastNormalizedPos = normalizedPos
  if self.scrollableRange ~= nil and 0 >= self.scrollableRange then
    self.lastContentPos = self._mapNode.tranContent.anchoredPosition.x
  end
  CS.UnityEngine.Canvas.ForceUpdateCanvases()
  if self.initialPositions ~= nil then
    local currentContentPos = self._mapNode.tranContent.anchoredPosition.x
    local actualScrollOffset = -currentContentPos
    if self._mapNode.behindBG ~= nil then
      local newX = self.initialPositions.behindBG.x - actualScrollOffset * self.parallaxSpeed.behindBG
      self._mapNode.behindBG.anchoredPosition = Vector2(newX, self.initialPositions.behindBG.y)
    end
    if self._mapNode.frontBG ~= nil then
      local newX = self.initialPositions.frontBG.x - actualScrollOffset * self.parallaxSpeed.frontBG
      self._mapNode.frontBG.anchoredPosition = Vector2(newX, self.initialPositions.frontBG.y)
    end
    if self._mapNode.frontLeaf ~= nil then
      local newX = self.initialPositions.frontLeaf.x - actualScrollOffset * self.parallaxSpeed.frontLeaf
      self._mapNode.frontLeaf.anchoredPosition = Vector2(newX, self.initialPositions.frontLeaf.y)
    end
  end
end

return ChristmasStoryCtrl
