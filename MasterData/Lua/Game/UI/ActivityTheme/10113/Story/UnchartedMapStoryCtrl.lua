local BaseCtrl = require("GameCore.UI.BaseCtrl")
local LocalData = require("GameCore.Data.LocalData")
local UnchartedMapStoryCtrl = class("UnchartedMapStoryCtrl", BaseCtrl)
UnchartedMapStoryCtrl._mapNodeConfig = {
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
    callback = "OnBtn_ClickCloseComplete"
  },
  ctlgoEnemyInfo = {
    sNodeName = "goEnemyInfo",
    sCtrlName = "Game.UI.MainlineEx.MainlineMonsterInfoCtrl"
  }
}
UnchartedMapStoryCtrl._mapEventConfig = {
  Story_Done = "OnEvent_Story_Done",
  SelectMainlineBattle = "OnEvent_SelectMainlineBattle",
  Story_RewardClosed = "OnEvent_Activity_Story_RewardClosed"
}

function UnchartedMapStoryCtrl:Awake()
  local tbParam = self:GetPanelParam()
  self._nActId = tbParam[1]
  self._bReview = tbParam[2] == true
  self._objStoryData = self._bReview and PlayerData.StoryReview or PlayerData.ActivityAvg
  self._tbAllStory = {}
  self._mapGridTimer = {}
  self._bInit = false
  self._bCantClick = false
end

function UnchartedMapStoryCtrl:OnEnable()
  self._bCantClick = false
  self:OnBtn_ClickCloseLevelInfoPanel()
  self:RefreshPanel()
end

function UnchartedMapStoryCtrl:FadeIn()
  EventManager.Hit(EventId.SetTransition)
end

function UnchartedMapStoryCtrl:OnPreExit()
  self._mapGridTimer = {}
  self._objScrollTimer = nil
end

function UnchartedMapStoryCtrl:RefreshPanel()
  self:RefreshStoryList()
end

function UnchartedMapStoryCtrl:RefreshStoryList()
  for _, objTimer in pairs(self._mapGridTimer) do
    objTimer:Cancel()
  end
  self._mapGridTimer = {}
  if self._objScrollTimer then
    self._objScrollTimer:Cancel()
    self._objScrollTimer = nil
  end
  self._tbAllStory, self._nChapterId = self._objStoryData:GetStoryIdListByActivityId(self._nActId)
  self._tbAllStory = self._tbAllStory or {}
  self._mapNode.svStory:SetAnim(0.07)
  self._mapNode.svStory:Init(#self._tbAllStory, self, self.OnRefreshGrid)
  if #self._tbAllStory == 0 then
    return
  end
  local nRecentStoryId = self._objStoryData:GetRecentStoryId(self._nChapterId)
  local nRecentIndex = 1
  for nIndex, nStoryId in ipairs(self._tbAllStory) do
    if nStoryId == nRecentStoryId then
      nRecentIndex = nIndex
      break
    end
  end
  local nScrollTime = self._bInit and 0 or 0.5
  self._objScrollTimer = self:AddTimer(1, 0.1, function()
    self._objScrollTimer = nil
    self._mapNode.svStory:SetScrollGridPos(nRecentIndex, nScrollTime, 0)
    self._bInit = true
  end, true, true, true)
end

function UnchartedMapStoryCtrl:OnRefreshGrid(goGrid, nIndex)
  local trNormal = goGrid.transform:Find("Normal")
  trNormal.gameObject:SetActive(true)
  goGrid.transform:Find("Branch").gameObject:SetActive(false)
  self:RefreshGridInfo(trNormal.gameObject, nIndex + 1)
end

function UnchartedMapStoryCtrl:RefreshGridInfo(goGrid, nIndex)
  local nStoryId = self._tbAllStory[nIndex]
  local mapStoryCfg = ConfigTable.GetData("ActivityStory", nStoryId)
  local nInstanceId = goGrid:GetInstanceID()
  if self._mapGridTimer[nInstanceId] then
    self._mapGridTimer[nInstanceId]:Cancel()
    self._mapGridTimer[nInstanceId] = nil
  end
  local btnGrid = goGrid.transform:Find("btnGrid"):GetComponent("UIButton")
  local trRoot = goGrid.transform:Find("btnGrid/AnimRoot/RootNode")
  local trTextRoot = goGrid.transform:Find("btnGridText/scale_on_click")
  local imgStory = trRoot:Find("rtBg/imgStory"):GetComponent("Image")
  local txtIndex = trRoot:Find("txtIndex"):GetComponent("TMP_Text")
  local trStoryTitle = trRoot:Find("imgStoryTitle")
  local trBattleTitle = trRoot:Find("imgBattleTitle")
  local trTitle = trTextRoot:Find("grpTitle")
  local txtTitle = trTitle:Find("tmpGroupDone"):GetComponent("TMP_Text")
  local trComplete = trTextRoot:Find("goComplete")
  local txtComplete = trComplete:Find("imgBg/txtComplete"):GetComponent("TMP_Text")
  local trTime = trTextRoot:Find("imgTime")
  local txtTime = trTime:Find("txtTime"):GetComponent("TMP_Text")
  local goRedDot = trRoot:Find("RedDot").gameObject
  local bUnlock = self._objStoryData:IsUnlock(mapStoryCfg.ConditionId)
  local bRead = self._objStoryData:IsStoryReaded(nStoryId)
  local bOpen, nOpenTime = self._objStoryData:IsOpen(mapStoryCfg.StoryId, self._nActId)
  local bAvailable = bOpen and bUnlock
  self:SetPngSprite(imgStory, bAvailable and mapStoryCfg.Icon or "Icon/ActivityStory/ep_event_13_00")
  NovaAPI.SetTMPText(txtIndex, mapStoryCfg.Index)
  NovaAPI.SetTMPText(txtTitle, mapStoryCfg.Title)
  NovaAPI.SetTMPText(txtComplete, ConfigTable.GetUIText("RoguelikeBuild_Manage_FilterPass"))
  NovaAPI.SetTMPText(trStoryTitle:Find("txtPlot"):GetComponent("TMP_Text"), ConfigTable.GetUIText("Story_StoryTitle"))
  NovaAPI.SetTMPText(trBattleTitle:Find("txtPlot"):GetComponent("TMP_Text"), ConfigTable.GetUIText("Story_BattleTitle"))
  trStoryTitle.gameObject:SetActive(bAvailable and not mapStoryCfg.IsBattle)
  trBattleTitle.gameObject:SetActive(bAvailable and mapStoryCfg.IsBattle)
  trRoot:Find("goNotOpen").gameObject:SetActive(not bOpen)
  trRoot:Find("goLockState").gameObject:SetActive(bOpen and not bUnlock)
  trTextRoot:Find("goLocktxtState").gameObject:SetActive(bOpen and not bUnlock)
  trTitle.gameObject:SetActive(bAvailable)
  trComplete.gameObject:SetActive(bAvailable and bRead)
  trTime.gameObject:SetActive(not bOpen)
  if not bOpen then
    NovaAPI.SetTMPText(txtTime, self:GetRemainTimeStr(nOpenTime, mapStoryCfg.DayOpen))
    self._mapGridTimer[nInstanceId] = self:AddTimer(0, 1, function()
      if self._objStoryData:IsOpen(mapStoryCfg.StoryId, self._nActId) then
        self:RefreshStoryList()
      else
        NovaAPI.SetTMPText(txtTime, self:GetRemainTimeStr(nOpenTime, mapStoryCfg.DayOpen))
      end
    end, true, true, true)
  end
  if self._bReview then
    goRedDot:SetActive(false)
  else
    local bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(self._nActId)
    if bInActGroup then
      RedDotManager.RegisterNode(RedDotDefine.Activity_GroupNew_Avg_Group, {
        nActGroupId,
        self._nActId,
        nStoryId
      }, goRedDot, nil, nil, true)
    else
      goRedDot:SetActive(false)
    end
  end
  btnGrid.onClick:RemoveAllListeners()
  btnGrid.onClick:AddListener(function()
    self:OnClickStory(nStoryId)
  end)
  local objAnimator = goGrid:GetComponent("Animator")
  if objAnimator ~= nil then
    objAnimator:Play(bAvailable and "svStory_in" or "svStoryNotOpen_in")
  end
end

function UnchartedMapStoryCtrl:OnClickStory(nStoryId)
  if self._bCantClick then
    return
  end
  local mapStoryCfg = ConfigTable.GetData("ActivityStory", nStoryId)
  if not self._objStoryData:IsOpen(mapStoryCfg.StoryId, self._nActId) then
    return
  end
  local bUnlock, tbResult = self._objStoryData:IsUnlock(mapStoryCfg.ConditionId)
  if not bUnlock then
    local sLockText = self:GetUnlockTip(tbResult)
    if sLockText ~= "" then
      EventManager.Hit(EventId.OpenMessageBox, {
        nType = AllEnum.MessageBox.Alert,
        sContent = sLockText
      })
    end
    return
  end
  self._nSelectedStoryId = nStoryId
  self._sAvgId = mapStoryCfg.StoryId
  self._mapNode.ctlAvgRoot.gameObject:SetActive(true)
  self._mapNode.ctlAvgRoot:OpenLevelInfo(self._sAvgId, self._nActId, not self._objStoryData:IsStoryReaded(nStoryId), self._bReview)
  LocalData.SetPlayerLocalData(self._objStoryData:_GetLocalReadKey(self._nActId, nStoryId), true)
  self._objStoryData:RefreshAvgRedDot()
end

function UnchartedMapStoryCtrl:GetUnlockTip(tbResult)
  for nConditionIndex, tbCondition in ipairs(tbResult or {}) do
    if tbCondition[1] == false then
      local conditionValue = tbCondition[2]
      if nConditionIndex == 1 or nConditionIndex == 2 then
        do
          local mapFallbackCfg
          for nStoryId, bRead in pairs(conditionValue) do
            if not bRead then
              local mapStoryCfg = ConfigTable.GetData("ActivityStory", nStoryId)
              mapFallbackCfg = mapFallbackCfg or mapStoryCfg
              if nConditionIndex == 1 or self._objStoryData:IsUnlock(mapStoryCfg.ConditionId) then
                return orderedFormat(ConfigTable.GetUIText("Story_UnlockPreId") or "", mapStoryCfg.Title)
              end
            end
          end
          if mapFallbackCfg then
            return orderedFormat(ConfigTable.GetUIText("Story_UnlockPreId") or "", mapFallbackCfg.Title)
          end
        end
        break
      end
      if nConditionIndex == 3 or nConditionIndex == 4 then
        do return ConfigTable.GetUIText("Story_UnlockClueCondition") end
        break
      end
      if nConditionIndex == 5 then
        do return orderedFormat(ConfigTable.GetUIText("Story_UnlockWorldLv") or "", conditionValue) end
        break
      end
      if nConditionIndex == 6 then
        for nAchievementId, bComplete in pairs(conditionValue) do
          if not bComplete then
            local mapAchievementCfg = ConfigTable.GetData("Achievement", nAchievementId)
            return orderedFormat(ConfigTable.GetUIText("Story_UnlockAchievement") or "", mapAchievementCfg.Title) .. [[

(]] .. mapAchievementCfg.Desc .. ")"
          end
        end
        break
      end
      if nConditionIndex == 7 and 0 < conditionValue then
        local mapLevelCfg = ConfigTable.GetData("ActivityLevelsLevel", conditionValue)
        if mapLevelCfg then
          return orderedFormat(ConfigTable.GetUIText("ActivityStory_UnlockActivityLevel"), mapLevelCfg.Name)
        end
      end
      break
    end
  end
  return ""
end

function UnchartedMapStoryCtrl:GetRemainTimeStr(nOpenTime, nOpenDay)
  local nRefreshTime = CS.ClientManager.Instance:GetNextRefreshTime(nOpenTime) - 86400
  local nRemainTime = nRefreshTime + nOpenDay * 86400 - CS.ClientManager.Instance.serverTimeStamp
  local tbUnits = {
    {
      86400,
      "ActivityLevels_Lock_Day_Color_Common"
    },
    {
      3600,
      "ActivityLevels_Lock_Hour_Color_Common"
    },
    {
      60,
      "ActivityLevels_Lock_Min_Color_Common"
    },
    {
      1,
      "ActivityLevels_Lock_Sec_Color_Common"
    }
  }
  for _, tbUnit in ipairs(tbUnits) do
    local nCount = math.floor(nRemainTime / tbUnit[1])
    if 0 < nCount then
      return orderedFormat(ConfigTable.GetUIText(tbUnit[2]), "FFF0DB", nCount)
    end
  end
  return ""
end

function UnchartedMapStoryCtrl:OnBtn_ClickBack()
  EventManager.Hit(EventId.ClosePanel, PanelId.UnchartedMapStory_10113)
end

function UnchartedMapStoryCtrl:OnBtn_ClickHome()
  PanelManager.Home()
end

function UnchartedMapStoryCtrl:OnBtn_ClickCloseLevelInfoPanel()
  self._mapNode.t_fullscreen_blur_black:SetActive(false)
  self._mapNode.ctlAvgRoot.gameObject:SetActive(false)
  self._mapNode.goChapterComplete:SetActive(false)
  EventManager.Hit("ActivityStoryReceive_SetVisible", true)
end

function UnchartedMapStoryCtrl:OnEvent_Story_Done(bHasReward)
  self._bCantClick = bHasReward == true
  self:RefreshPanel()
end

function UnchartedMapStoryCtrl:OnEvent_SelectMainlineBattle(bConfirm)
  if bConfirm and self._sAvgId then
    EventManager.Hit(EventId.SetTransition, 2, function()
      EventManager.Hit(EventId.OpenPanel, PanelId.RegionBossFormation, AllEnum.RegionBossFormationType.ActivityStory, 0, self._sAvgId, self._nActId, self._bReview)
    end)
  end
end

function UnchartedMapStoryCtrl:OnEvent_Activity_Story_RewardClosed()
  self._bCantClick = false
  if self._nSelectedStoryId and self._nSelectedStoryId == self._tbAllStory[#self._tbAllStory] and self._objStoryData:IsStoryReaded(self._nSelectedStoryId) then
    self._mapNode.goChapterComplete:SetActive(true)
    EventManager.Hit("ActivityStoryReceive_SetVisible", false)
  end
end

function UnchartedMapStoryCtrl:OnBtn_ClickCloseComplete()
  self._mapNode.goChapterComplete:SetActive(false)
  EventManager.Hit("ActivityStoryReceive_SetVisible", true)
end

return UnchartedMapStoryCtrl
