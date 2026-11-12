local TimerManager = require("GameCore.Timer.TimerManager")
local NewTutorialsActCtrl = class("NewTutorialsActCtrl", BaseCtrl)
NewTutorialsActCtrl._mapNodeConfig = {
  goBaseGuide = {},
  goAdvanceGuide = {},
  trTabOff = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_TrTab"
  },
  trTabOn = {nCount = 2},
  txtTabOn = {nCount = 2, sComponentName = "TMP_Text"},
  txtTabOff = {nCount = 2, sComponentName = "TMP_Text"},
  goCountDownTab = {},
  txtCountDownTab = {sComponentName = "TMP_Text"},
  btn_GoGuideQusetPanel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoGuideQusetPanel"
  },
  btn_GoGuideQusetPanelGray = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoGuideQusetPanel"
  },
  txt_Title1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "QuestPanel_Tab_1"
  },
  txt_Plan1 = {sNodeName = "txt_Plan1", sComponentName = "TMP_Text"},
  txt_Complete1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Complete"
  },
  txt_Locked1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "StorySet_Chapter_Lock"
  },
  txtBtnGo1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_JumpTo"
  },
  txtBtnGoGray1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_JumpTo"
  },
  btn_GoTutorialPanel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoTutorialPanel"
  },
  btn_GoTutorialPanelGray = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoTutorialPanel"
  },
  txt_Title2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "NewTutorialsAct_Tutorial"
  },
  txt_Plan2 = {sNodeName = "txt_Plan2", sComponentName = "TMP_Text"},
  txt_Complete2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Complete"
  },
  txt_Locked2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "StorySet_Chapter_Lock"
  },
  txtBtnGo2 = {
    sNodeName = "txtBtnGo2",
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_JumpTo"
  },
  txtBtnGoGray2 = {
    sNodeName = "txtBtnGoGray2",
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_JumpTo"
  },
  btn_GoTeamFormationPanel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoTeamFormationPanel"
  },
  btn_GoTeamFormationPanelGray = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoTeamFormationPanel"
  },
  txt_Title3 = {
    sComponentName = "TMP_Text",
    sLanguageId = "QuestNewbiePanel_Tab_1"
  },
  txt_Plan3 = {sComponentName = "TMP_Text"},
  txt_Complete3 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Complete"
  },
  txt_Locked3 = {
    sComponentName = "TMP_Text",
    sLanguageId = "StorySet_Chapter_Lock"
  },
  txtBtnGo3 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_JumpTo"
  },
  txtBtnGoGray3 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_JumpTo"
  },
  btn_GoVampireSurvivorPanel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoVampireSurvivorPanel"
  },
  btn_GoVampireSurvivorPanelGray = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoVampireSurvivorPanel"
  },
  txt_AdvanceTitle1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "LevelMenu_Vampire"
  },
  goProgress1 = {},
  goCountDown1 = {},
  txt_AdvanceProgress1 = {sComponentName = "TMP_Text"},
  txt_AdvanceComplete1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Complete"
  },
  txt_AdvanceLocked1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "StorySet_Chapter_Lock"
  },
  txtCountDown1 = {sComponentName = "TMP_Text"},
  txtBtnAdvanceGo1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_JumpTo"
  },
  txtBtnAdvanceGoGray1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_JumpTo"
  },
  btn_GoScoreBossPanel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoScoreBossPanel"
  },
  btn_GoScoreBossPanelGray = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoScoreBossPanel"
  },
  txt_AdvanceTitle2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "LevelMenu_ScoreBoss"
  },
  goProgress2 = {},
  goCountDown2 = {},
  txt_AdvanceProgress2 = {sComponentName = "TMP_Text"},
  txt_AdvanceComplete2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Complete"
  },
  txt_AdvanceLocked2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "StorySet_Chapter_Lock"
  },
  txtCountDown2 = {sComponentName = "TMP_Text"},
  txtBtnAdvanceGo2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_JumpTo"
  },
  txtBtnAdvanceGoGray2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_JumpTo"
  },
  btn_GoWeekBossPanel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoWeekBossPanel"
  },
  btn_GoWeekBossPanelGray = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoWeekBossPanel"
  },
  txt_AdvanceTitle3 = {
    sComponentName = "TMP_Text",
    sLanguageId = "LevelMenu_WeeklyCopies"
  },
  goProgress3 = {},
  goCountDown3 = {},
  txt_AdvanceProgress3 = {sComponentName = "TMP_Text"},
  txt_AdvanceComplete3 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Complete"
  },
  txt_AdvanceLocked3 = {
    sComponentName = "TMP_Text",
    sLanguageId = "StorySet_Chapter_Lock"
  },
  txtCountDown3 = {sComponentName = "TMP_Text"},
  txt_AdvancePlan3 = {sComponentName = "TMP_Text"},
  txtBtnAdvanceGo3 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_JumpTo"
  },
  txtBtnAdvanceGoGray3 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_JumpTo"
  }
}
NewTutorialsActCtrl._mapEventConfig = {
  [EventId.TransAnimInClear] = "OnEvent_TransAnimInClear"
}

function NewTutorialsActCtrl:InitActData(actData)
  self.actData = actData
  self.nActId = actData:GetActId()
  self.AdConfig = ConfigTable.GetData("AdControl", self.nActId)
  self:Init()
end

function NewTutorialsActCtrl:Init()
  self.bAllAdvanceLocked = true
  self.bAllBaseComplete = false
  self.tbCountDownTimers = {}
  self.tbCountDownEndTimes = {}
  self:RefreshGuideQuset()
  self:RefreshTutorial()
  self:RefreshTeamFormation()
  self:RefreshVampireSurvivor()
  self:RefreshScoreBoss()
  self:RefreshWeekBoss()
  self:RefreshTab()
  self:RefreshTabCountDown()
  self:StartAllCountDownTimers()
end

function NewTutorialsActCtrl:RefreshTabCountDown()
  local bActive = false
  self._mapNode.goCountDownTab.gameObject:SetActive(false)
  if self.nShortestTime ~= nil and self.nTabIndex == 1 then
    self._mapNode.goCountDownTab.gameObject:SetActive(true)
    bActive = true
    NovaAPI.SetTMPText(self._mapNode.txtCountDownTab, self.sShortestTime)
  end
  if self.bAllAdvanceLocked then
    self._mapNode.goCountDownTab.gameObject:SetActive(false)
    bActive = false
  end
  return bActive
end

function NewTutorialsActCtrl:RefreshTab()
  if self.nTabIndex == nil then
    self.nTabIndex = 1
  end
  if self.bAllBaseComplete then
    self.nTabIndex = 2
  end
  self._mapNode.goBaseGuide.gameObject:SetActive(self.nTabIndex == 1)
  self._mapNode.goAdvanceGuide.gameObject:SetActive(self.nTabIndex == 2)
  for i = 1, #self._mapNode.txtTabOn do
    self._mapNode.goCountDownTab.gameObject:SetActive(self.nTabIndex == 1)
    self._mapNode.trTabOff[i].gameObject:SetActive(self.nTabIndex ~= i)
    self._mapNode.trTabOn[i].gameObject:SetActive(self.nTabIndex == i)
    NovaAPI.SetTMPText(self._mapNode.txtTabOn[i], ConfigTable.GetUIText("NewTutorialsAct_Tab" .. i))
    NovaAPI.SetTMPText(self._mapNode.txtTabOff[i], ConfigTable.GetUIText("NewTutorialsAct_Tab" .. i))
  end
end

function NewTutorialsActCtrl:RefreshGuideQuset()
  local bPlayCond = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Quest, false)
  self._mapNode.txt_Plan1.gameObject:SetActive(bPlayCond)
  self._mapNode.txt_Complete1.gameObject:SetActive(false)
  self._mapNode.btn_GoGuideQusetPanelGray.gameObject:SetActive(not bPlayCond)
  self._mapNode.btn_GoGuideQusetPanel.gameObject:SetActive(bPlayCond)
  self._mapNode.txt_Locked1.gameObject:SetActive(not bPlayCond)
  local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.Quest) or {}
  local sLockTip = UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData)
  NovaAPI.SetTMPText(self._mapNode.txt_Locked1, sLockTip)
  if not bPlayCond then
    return
  end
  local nReceivedCount = 0
  local nTotalCount = PlayerData.Quest:GetMaxTourGroupOrderIndex()
  local nCurTourGroupOrder = PlayerData.Quest:GetCurTourGroupOrder()
  if PlayerData.Quest:CheckTourGroupReward(nTotalCount) then
    self._mapNode.btn_GoGuideQusetPanel.gameObject:SetActive(false)
    self._mapNode.txt_Complete1.gameObject:SetActive(true)
    nReceivedCount = nTotalCount
  else
    nReceivedCount = nCurTourGroupOrder - 1
    self.bAllBaseComplete = false
  end
  local sPanel = orderedFormat(ConfigTable.GetUIText("NewTutorialsAct_Complete") or "", nReceivedCount, nTotalCount)
  NovaAPI.SetTMPText(self._mapNode.txt_Plan1, sPanel)
end

function NewTutorialsActCtrl:RefreshTutorial()
  local bPlayCond = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.TutorialLevel, false)
  self._mapNode.txt_Plan2.gameObject:SetActive(bPlayCond)
  self._mapNode.txt_Complete2.gameObject:SetActive(false)
  self._mapNode.btn_GoTutorialPanelGray.gameObject:SetActive(not bPlayCond)
  self._mapNode.btn_GoTutorialPanel.gameObject:SetActive(bPlayCond)
  self._mapNode.txt_Locked2.gameObject:SetActive(not bPlayCond)
  local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.TutorialLevel) or {}
  local sLockTip = UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData)
  NovaAPI.SetTMPText(self._mapNode.txt_Locked2, sLockTip)
  if not bPlayCond then
    return
  end
  local nTotalCount, nReceivedCount = PlayerData.TutorialData:GetProgress()
  local sPanel = orderedFormat(ConfigTable.GetUIText("NewTutorialsAct_Complete") or "", nReceivedCount, nTotalCount)
  NovaAPI.SetTMPText(self._mapNode.txt_Plan2, sPanel)
  if nTotalCount == nReceivedCount then
    self._mapNode.btn_GoTutorialPanel.gameObject:SetActive(false)
    self._mapNode.txt_Complete2.gameObject:SetActive(true)
  else
    self._mapNode.btn_GoTutorialPanel.gameObject:SetActive(true)
    self._mapNode.txt_Complete2.gameObject:SetActive(false)
    self.bAllBaseComplete = false
  end
end

function NewTutorialsActCtrl:RefreshTeamFormation()
  local bPlayCond = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.QuestNewbie, false)
  self._mapNode.txt_Plan3.gameObject:SetActive(bPlayCond)
  self._mapNode.txt_Complete3.gameObject:SetActive(false)
  self._mapNode.btn_GoTeamFormationPanelGray.gameObject:SetActive(not bPlayCond)
  self._mapNode.btn_GoTeamFormationPanel.gameObject:SetActive(bPlayCond)
  self._mapNode.txt_Locked3.gameObject:SetActive(not bPlayCond)
  local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.QuestNewbie) or {}
  local sLockTip = UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData)
  NovaAPI.SetTMPText(self._mapNode.txt_Locked3, sLockTip)
  if not bPlayCond then
    return
  end
  local nAttrQuestCount = #PlayerData.Quest.tbTeamFormationAttr or 1
  local nReceivedCount, nTotalCount = 0, 0
  for i = 1, nAttrQuestCount do
    local bComplete = PlayerData.Quest:CheckTeamFormationAttributeCompleted(i)
    local nThisReceivedCount, nThisTotalCount = PlayerData.Quest:GetTeamFormationAttributeProgress(i)
    nReceivedCount = nReceivedCount + nThisReceivedCount
    nTotalCount = nTotalCount + nThisTotalCount
  end
  if nTotalCount == nReceivedCount then
    self._mapNode.btn_GoTeamFormationPanel.gameObject:SetActive(false)
    self._mapNode.txt_Complete3.gameObject:SetActive(true)
  else
    self._mapNode.btn_GoTeamFormationPanel.gameObject:SetActive(true)
    self._mapNode.txt_Complete3.gameObject:SetActive(false)
    self.bAllBaseComplete = false
  end
  local sPanel = orderedFormat(ConfigTable.GetUIText("NewTutorialsAct_Complete") or "", nReceivedCount, nTotalCount)
  NovaAPI.SetTMPText(self._mapNode.txt_Plan3, sPanel)
end

function NewTutorialsActCtrl:RefreshWeekBoss()
  local bPlayCond = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.WeeklyCopies, false)
  self._mapNode.txt_AdvancePlan3.gameObject:SetActive(bPlayCond)
  self._mapNode.txt_AdvanceComplete3.gameObject:SetActive(false)
  self._mapNode.btn_GoWeekBossPanelGray.gameObject:SetActive(not bPlayCond)
  self._mapNode.btn_GoWeekBossPanel.gameObject:SetActive(bPlayCond)
  self._mapNode.goCountDown3.gameObject:SetActive(bPlayCond)
  local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.WeeklyCopies) or {}
  local sLockTip = UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData)
  self._mapNode.txt_AdvanceLocked3.gameObject:SetActive(not bPlayCond)
  NovaAPI.SetTMPText(self._mapNode.txt_AdvanceLocked3, sLockTip)
  if not bPlayCond then
    return
  end
  self.bAllAdvanceLocked = false
  local nRemainTicket = PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.RogueHardCoreTick)
  local nMaxTicket = ConfigTable.GetConfigNumber("RegionBossChallengeTicker")
  local sPanel = orderedFormat(ConfigTable.GetUIText("WeeklyBoss_RewardCount") or "", nRemainTicket, nMaxTicket)
  NovaAPI.SetTMPText(self._mapNode.txt_AdvancePlan3, sPanel)
  local nNextWeekRefreshTime = GetNextWeekRefreshTime()
  self:RefreshRemainTime(nNextWeekRefreshTime, self._mapNode.txtCountDown3)
end

function NewTutorialsActCtrl:RefreshVampireSurvivor()
  local bPlayCond = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.VampireSurvivor, false)
  self._mapNode.txt_AdvanceTitle1.gameObject:SetActive(true)
  self._mapNode.txt_AdvanceComplete1.gameObject:SetActive(false)
  self._mapNode.btn_GoVampireSurvivorPanelGray.gameObject:SetActive(not bPlayCond)
  self._mapNode.btn_GoVampireSurvivorPanel.gameObject:SetActive(bPlayCond)
  self._mapNode.goCountDown1.gameObject:SetActive(bPlayCond)
  self._mapNode.goProgress1.gameObject:SetActive(bPlayCond)
  local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.VampireSurvivor) or {}
  local sLockTip = UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData)
  self._mapNode.txt_AdvanceLocked1.gameObject:SetActive(not bPlayCond)
  NovaAPI.SetTMPText(self._mapNode.txt_AdvanceLocked1, sLockTip)
  if not bPlayCond then
    return
  end
  self.bAllAdvanceLocked = false
  local nCurSeasonId, nLevelId = PlayerData.VampireSurvivor:GetCurSeason()
  local bSeasonUnlocked = nCurSeasonId ~= 0
  if bSeasonUnlocked then
    local sTitle = ConfigTable.GetUIText("LevelMenu_Vampire") or ""
    local sSeason = orderedFormat(ConfigTable.GetUIText("Level_Season_Count"), nCurSeasonId)
    NovaAPI.SetTMPText(self._mapNode.txt_AdvanceTitle1, sTitle .. " " .. sSeason)
  end
  local tbHardUnlock = PlayerData.VampireSurvivor:GetHardUnlock()
  if bSeasonUnlocked == false or tbHardUnlock[3] == false then
    self._mapNode.goProgress1.gameObject:SetActive(false)
    self._mapNode.txt_AdvanceLocked1.gameObject:SetActive(true)
    local sLockedTip = ""
    if bSeasonUnlocked == false then
      self._mapNode.goCountDown1.gameObject:SetActive(false)
      sLockedTip = ConfigTable.GetUIText("NewTutorialsAct_WaitSeasonOpen") or ""
    elseif tbHardUnlock[3] == false then
      sLockedTip = ConfigTable.GetUIText("NewTutorialsAct_PreLevelSeasonOpen") or ""
    end
    NovaAPI.SetTMPText(self._mapNode.txt_AdvanceLocked1, sLockedTip)
  end
  local nSeasonId = PlayerData.VampireSurvivor:GetCurSeason()
  if nSeasonId ~= 0 then
    local mapSeasonCfgData = ConfigTable.GetData("VampireRankSeason", nSeasonId)
    if mapSeasonCfgData ~= nil then
      local nEndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapSeasonCfgData.EndTime)
      if nEndTime > CS.ClientManager.Instance.serverTimeStamp then
        self:RefreshRemainTime(nEndTime, self._mapNode.txtCountDown1)
      end
    end
  end
  local cur, total = PlayerData.VampireSurvivor:GetSeasonQuestCount(GameEnum.vampireSurvivorType.Turn)
  NovaAPI.SetTMPText(self._mapNode.txt_AdvanceProgress1, string.format("%d/%d", cur, total))
end

function NewTutorialsActCtrl:RefreshScoreBoss()
  local bPlayCond = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.ScoreBoss, false)
  self._mapNode.txt_AdvanceTitle2.gameObject:SetActive(true)
  self._mapNode.txt_AdvanceComplete2.gameObject:SetActive(false)
  self._mapNode.btn_GoScoreBossPanelGray.gameObject:SetActive(not bPlayCond)
  self._mapNode.btn_GoScoreBossPanel.gameObject:SetActive(bPlayCond)
  self._mapNode.goCountDown2.gameObject:SetActive(bPlayCond)
  self._mapNode.goProgress2.gameObject:SetActive(bPlayCond)
  self._mapNode.txt_AdvanceLocked2.gameObject:SetActive(not bPlayCond)
  local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.ScoreBoss) or {}
  local sLockTip = UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData)
  NovaAPI.SetTMPText(self._mapNode.txt_AdvanceLocked2, sLockTip)
  if not bPlayCond then
    return
  end
  self.bAllAdvanceLocked = false
  
  local function openScoreBossCallback()
    if PlayerData.ScoreBoss.EndTime ~= 0 and PlayerData.ScoreBoss.EndTime > CS.ClientManager.Instance.serverTimeStamp and PlayerData.ScoreBoss.isGetScInfo then
      self:RefreshRemainTime(PlayerData.ScoreBoss.EndTime, self._mapNode.txtCountDown2)
    else
      self._mapNode.goProgress2.gameObject:SetActive(false)
      self._mapNode.goCountDown2.gameObject:SetActive(false)
      self._mapNode.txt_AdvanceLocked2.gameObject:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txt_AdvanceLocked2, ConfigTable.GetUIText("ScoreBoss_Settlement") or "")
    end
    local sTitle = ConfigTable.GetUIText("LevelMenu_ScoreBoss") or ""
    local nSeasonId = PlayerData.ScoreBoss.ControlId
    if nSeasonId ~= 0 then
      local sSeason = orderedFormat(ConfigTable.GetUIText("Level_Season_Count"), nSeasonId)
      NovaAPI.SetTMPText(self._mapNode.txt_AdvanceTitle2, sTitle .. " " .. sSeason)
    end
    NovaAPI.SetTMPText(self._mapNode.txt_AdvanceProgress2, PlayerData.ScoreBoss.Star .. "/" .. PlayerData.ScoreBoss.maxStarNeed)
  end
  
  if not PlayerData.ScoreBoss:GetInitInfoState() then
    PlayerData.ScoreBoss:GetScoreBossInstanceData(openScoreBossCallback)
  else
    openScoreBossCallback()
  end
end

function NewTutorialsActCtrl:RefreshRemainTime(endTime, txtComp)
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local remainTime = endTime - curTime
  if remainTime <= 0 then
    NovaAPI.SetTMPText(txtComp, "")
    return 0
  end
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
  if self.nShortestTime == nil then
    self.sShortestTime = sTimeStr
    self.nShortestTime = remainTime
  elseif remainTime < self.nShortestTime and 0 < remainTime then
    self.sShortestTime = sTimeStr
    self.nShortestTime = remainTime
  end
  return remainTime
end

function NewTutorialsActCtrl:OnBtnClick_TrTab(goBtn, nIndex)
  if self.nTabIndex == nIndex then
    return
  end
  self.nTabIndex = nIndex
  self._mapNode.goBaseGuide.gameObject:SetActive(nIndex == 1)
  self._mapNode.goAdvanceGuide.gameObject:SetActive(nIndex == 2)
  local bActive = self:RefreshTabCountDown()
  self._mapNode.goCountDownTab.gameObject:SetActive(self.nTabIndex == 1 and bActive)
  for k, v in pairs(self._mapNode.trTabOff) do
    v.gameObject:SetActive(k ~= nIndex)
  end
  for k, v in pairs(self._mapNode.trTabOn) do
    v.gameObject:SetActive(k == nIndex)
  end
end

function NewTutorialsActCtrl:OnBtnClick_GoGuideQusetPanel()
  EventManager.Hit(EventId.OpenPanel, PanelId.Quest, AllEnum.QuestPanelTab.GuideQuest)
end

function NewTutorialsActCtrl:OnBtnClick_GoTutorialPanel()
  local bPlayCond = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.TutorialLevel, true)
  if not bPlayCond then
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.QuestNewbie, 2)
end

function NewTutorialsActCtrl:OnBtnClick_GoTeamFormationPanel()
  local bPlayCond = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.QuestNewbie, true)
  if not bPlayCond then
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.QuestNewbie, 1)
end

function NewTutorialsActCtrl:OnBtnClick_GoVampireSurvivorPanel()
  local function stateCallback(bReEnter)
    if not bReEnter then
      local animLen = 1.2
      
      CS.WwiseAudioManager.Instance:PlaySound("ui_level_select")
      self.nTransType = 13
      EventManager.Hit(EventId.SetTransition, 13)
      EventManager.Hit(EventId.TemporaryBlockInput, animLen)
    end
  end
  
  local function callbackCheck()
    PlayerData.State:CheckVampireState(stateCallback)
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.VampireSurvivor, callbackCheck, "ui_systerm_locked")
end

function NewTutorialsActCtrl:OnBtnClick_GoScoreBossPanel(btn)
  local function openScoreBossPanel()
    local function callbackCheck()
      local animLen = 1.2
      
      self.nTransType = 24
      CS.WwiseAudioManager.Instance:PlaySound("ui_level_select")
      EventManager.Hit(EventId.SetTransition, 24)
      EventManager.Hit(EventId.TemporaryBlockInput, animLen)
    end
    
    PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.ScoreBoss, callbackCheck, "ui_systerm_locked")
  end
  
  local bFuncUnlock = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.ScoreBoss, true)
  if bFuncUnlock then
    if not PlayerData.ScoreBoss:GetInitInfoState() then
      PlayerData.ScoreBoss:GetScoreBossInstanceData(openScoreBossPanel)
    else
      openScoreBossPanel()
    end
  else
    openScoreBossPanel()
  end
end

function NewTutorialsActCtrl:OnBtnClick_GoWeekBossPanel()
  local function callbackCheck()
    CS.WwiseAudioManager.Instance:PlaySound("ui_level_select")
    
    self.nTransType = 23
    EventManager.Hit(EventId.SetTransition, 23)
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.WeeklyCopies, callbackCheck, "ui_systerm_locked")
end

function NewTutorialsActCtrl:OnEvent_TransAnimInClear()
  if self.nTransType == 13 then
    local function success(bSuccess)
      if bSuccess then
        EventManager.Remove("GetTalentDataVampire", self, success)
        
        EventManager.Hit(EventId.OpenPanel, PanelId.VampireSurvivorLevelSelectPanel)
      else
        EventManager.Hit(EventId.SetTransition)
      end
    end
    
    EventManager.Add("GetTalentDataVampire", self, success)
    local ret, _, _ = PlayerData.VampireSurvivor:GetTalentData()
    if ret ~= nil then
      success(true)
    end
    EventManager.Hit(EventId.BlockInput, false)
  elseif self.nTransType == 24 then
    EventManager.Hit(EventId.BlockInput, false)
    EventManager.Hit(EventId.OpenPanel, PanelId.ScoreBossSelectPanel)
  elseif self.nTransType == 23 then
    EventManager.Hit(EventId.OpenPanel, PanelId.WeeklyCopiesPanel)
    EventManager.Hit(EventId.BlockInput, false)
  end
end

function NewTutorialsActCtrl:ClearActivity()
  self:StopAllCountDownTimers()
end

function NewTutorialsActCtrl:StartAllCountDownTimers()
  self:StopAllCountDownTimers()
  local timer = self:AddTimer(0, 1, "UpdateAllCountDown", true, false, false)
  if timer ~= nil then
    table.insert(self.tbCountDownTimers, timer)
  end
end

function NewTutorialsActCtrl:StopAllCountDownTimers()
  if self.tbCountDownTimers ~= nil then
    for _, timer in ipairs(self.tbCountDownTimers) do
      TimerManager.Remove(timer)
    end
    self.tbCountDownTimers = {}
  end
end

function NewTutorialsActCtrl:UpdateAllCountDown()
  self.nShortestTime = nil
  self.sShortestTime = nil
  local bNeedRefresh = false
  if self.nVSSeasonId == nil then
    self.nVSSeasonId = PlayerData.VampireSurvivor:GetCurSeason()
  end
  if self.nVSSeasonId ~= 0 and self._mapNode.goCountDown1.gameObject.activeSelf then
    local mapSeasonCfgData = ConfigTable.GetData("VampireRankSeason", self.nVSSeasonId)
    if mapSeasonCfgData ~= nil then
      local nEndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapSeasonCfgData.EndTime)
      local nRemainTime = self:RefreshRemainTime(nEndTime, self._mapNode.txtCountDown1)
      if self.tbCountDownEndTimes.VampireSurvivor ~= false and nRemainTime <= 0 then
        self.tbCountDownEndTimes.VampireSurvivor = false
        bNeedRefresh = true
        printLog("NewTutorialsActCtrl: VampireSurvivor countdown ended, refreshing page...")
        self.nVSSeasonId = PlayerData.VampireSurvivor:GetCurSeason()
      elseif 1 < nRemainTime then
        self.tbCountDownEndTimes.VampireSurvivor = true
      end
    end
  else
    self._mapNode.goCountDown1.gameObject:SetActive(false)
  end
  if PlayerData.ScoreBoss.EndTime ~= 0 and PlayerData.ScoreBoss.isGetScInfo and self._mapNode.goCountDown2.gameObject.activeSelf then
    local nRemainTime = self:RefreshRemainTime(PlayerData.ScoreBoss.EndTime, self._mapNode.txtCountDown2)
    if self.tbCountDownEndTimes.ScoreBoss ~= false and nRemainTime <= 0 then
      self.tbCountDownEndTimes.ScoreBoss = false
      bNeedRefresh = true
      printLog("NewTutorialsActCtrl: ScoreBoss countdown ended, refreshing page...")
    elseif 0 < nRemainTime then
      self.tbCountDownEndTimes.ScoreBoss = true
    end
  end
  if self._mapNode.goCountDown3.gameObject.activeSelf then
    local nNextWeekRefreshTime = GetNextWeekRefreshTime()
    local nRemainTime = self:RefreshRemainTime(nNextWeekRefreshTime, self._mapNode.txtCountDown3)
    if self.tbCountDownEndTimes.WeekBoss ~= false and nRemainTime <= 0 then
      self.tbCountDownEndTimes.WeekBoss = false
      bNeedRefresh = true
      printLog("NewTutorialsActCtrl: WeekBoss countdown ended, refreshing page...")
    elseif 0 < nRemainTime then
      self.tbCountDownEndTimes.WeekBoss = true
    end
  end
  if self.nTabIndex == 1 and self.nShortestTime ~= nil and not self.bAllAdvanceLocked then
    self._mapNode.goCountDownTab.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtCountDownTab, self.sShortestTime)
  end
  if bNeedRefresh then
    self:RefreshAllContent()
  end
end

function NewTutorialsActCtrl:RefreshAllContent()
  printLog("NewTutorialsActCtrl: Refreshing all content...")
  self.bAllAdvanceLocked = true
  self.bAllBaseComplete = false
  self.nShortestTime = nil
  self.sShortestTime = nil
  self:RefreshGuideQuset()
  self:RefreshTutorial()
  self:RefreshTeamFormation()
  self:RefreshVampireSurvivor()
  self:RefreshScoreBoss()
  self:RefreshWeekBoss()
  self:RefreshTab()
  self:RefreshTabCountDown()
end

return NewTutorialsActCtrl
