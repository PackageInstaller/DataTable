local TrekkerVersusQuestCtrl = class("TrekkerVersusQuestCtrl", BaseCtrl)
TrekkerVersusQuestCtrl._mapNodeConfig = {
  btn_Close = {sComponentName = "Button", callback = "ClosePanel"},
  btnClose_quest = {sComponentName = "UIButton", callback = "ClosePanel"},
  aniWindow = {sNodeName = "rtWindow", sComponentName = "Animator"},
  TMPReceiveAll = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Btn_ReceiveAll"
  },
  rtWindow = {},
  btnHeatQuestReceiveAll = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Receive"
  },
  btnHeatQuestUnReceiveAll = {},
  txtWindowTitleQuest = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_QusetTitle"
  },
  btnRewardTab = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_RewardTab"
  },
  txtTabHeat = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "TD_HeatQuestTab"
  },
  txtTabDuel = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "TD_DuelQuestTab"
  },
  txtTabGift = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "TD_GiftQuestTab"
  },
  txtTabBattle = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "TD_BattleQuestTab"
  },
  rtHeatQuest = {},
  lsvHeatQuest = {
    sComponentName = "LoopScrollView"
  },
  txtCurHeatTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_HeatQuestTitle"
  },
  txtCurHeatNum = {sComponentName = "TMP_Text"},
  rtDuelHistory = {},
  rtListHasCurDuel = {},
  rtListNoCurDuel = {},
  txtDuelHistoryTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_DuelHistoryTitle"
  },
  lsvDuelHistory = {
    sComponentName = "LoopScrollView"
  },
  lsvDuelHistoryNoCurDuel = {
    sComponentName = "LoopScrollView"
  },
  goHasCurDuel = {},
  goGridMain = {
    sCtrlName = "Game.UI.TrekkerVersus_600004.TrekkerVersusDuelHistoryGridCtrl"
  },
  txtNoDuelHistory = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_NoDuelHistory"
  },
  btnDuelHistoryReceiveAll = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_DuelHistoryReceiveAll"
  },
  btnDuelHistoryUnReceiveAll = {},
  TMPDuelHistoryReceiveAll = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Btn_ReceiveAll"
  },
  rtGiftQuest = {},
  lsvGiftQuest = {
    sComponentName = "LoopScrollView"
  },
  rtBattleQuest = {},
  lsvBattleQuest = {
    sComponentName = "LoopScrollView"
  },
  txtGetHighestReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_GetHighestReward"
  },
  btnReceiveAllQuest = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ReceiveAll"
  },
  btnUnReceiveAllQuest = {},
  TMPReceiveAllQuest = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Btn_ReceiveAll"
  },
  goRedDotRewardTab1 = {},
  goRedDotRewardTab2 = {},
  goRedDotRewardTab3 = {},
  goRedDotRewardTab4 = {}
}
TrekkerVersusQuestCtrl._mapEventConfig = {
  TrekkerVersusAffixJump = "OnEvent_TrekkerVersusAffixJump",
  TrekkerVersusHeatQuestRefresh = "OnEvent_TrekkerVersusHeatQuestRefresh",
  UpdateTrekkerVersusHotValue = "OnEvent_UpdateTrekkerVersusHotValue",
  TrekkerVersusQuestRefresh = "OnEvent_TrekkerVersusQuestRefresh",
  TrekkerVersusDuelQuestRefresh = "OnEvent_TrekkerVersusDuelQuestRefresh"
}
TrekkerVersusQuestCtrl._mapRedDotConfig = {}

function TrekkerVersusQuestCtrl:RefreshHeatQuestTab()
  if self.tbHeatQuest == nil then
    self.tbHeatQuest = {}
    
    local function foreachQuestData(mapQuestData)
      if mapQuestData.GroupId == self.nActId then
        table.insert(self.tbHeatQuest, mapQuestData)
      end
    end
    
    ForEachTableLine(DataTable.TravelerDuelHotValueRewards, foreachQuestData)
  end
  local mapHotValue = self._mapActData:GetCurHeatValue()
  local nSelfHotValue = mapHotValue.nSelfHotValue
  NovaAPI.SetTMPText(self._mapNode.txtCurHeatNum, nSelfHotValue)
  local tbHotValueRewardIds = self._mapActData:GetHotValueRewardTable() or {}
  table.sort(self.tbHeatQuest, function(a, b)
    local aStatus = 2
    local bStatus = 2
    if a.TargetValue <= nSelfHotValue then
      if table.indexof(tbHotValueRewardIds, a.Id) <= 0 then
        aStatus = 1
      else
        aStatus = 3
      end
    end
    if b.TargetValue <= nSelfHotValue then
      if table.indexof(tbHotValueRewardIds, b.Id) <= 0 then
        bStatus = 1
      else
        bStatus = 3
      end
    end
    if aStatus ~= bStatus then
      return aStatus < bStatus
    else
      return a.Id < b.Id
    end
  end)
  local bHasCom = false
  for k, v in ipairs(self.tbHeatQuest) do
    if nSelfHotValue >= v.TargetValue and table.indexof(tbHotValueRewardIds, v.Id) <= 0 then
      bHasCom = true
      break
    end
  end
  self._mapNode.btnHeatQuestUnReceiveAll.gameObject:SetActive(not bHasCom)
  self._mapNode.btnHeatQuestReceiveAll.gameObject:SetActive(bHasCom)
  self._mapNode.lsvHeatQuest:SetAnim(0.05)
  self._mapNode.lsvHeatQuest:Init(#self.tbHeatQuest, self, self.OnGridRefresh)
end

function TrekkerVersusQuestCtrl:RefreshDuelHistoryTab()
  self._mapNode.lsvDuelHistory:SetAnim(0.05)
  local mapCurDuelData = self._mapActData:GetCurHeatValue()
  self._mapNode.rtListHasCurDuel:SetActive(self.bOpen)
  self._mapNode.rtListNoCurDuel:SetActive(not self.bOpen)
  self._mapNode.goGridMain.gameObject:SetActive(self.bOpen)
  self._mapNode.goHasCurDuel:SetActive(self.bOpen)
  if self.bOpen == false then
    self._mapNode.lsvDuelHistoryNoCurDuel:Init(#self.tbDuelHistory, self, self.OnDuelHistoryGridRefresh)
    self:RefreshDuelHistoryBtn()
    return
  end
  local nCurDay = self._mapActData:GetCurDayNum()
  
  local function foreachDuelHistory(mapDuelHistoryData)
    if mapDuelHistoryData.GroupId == self.nActId and mapDuelHistoryData.DayNum == nCurDay then
      self.nCurDuelId = mapDuelHistoryData.Id
    end
  end
  
  ForEachTableLine(DataTable.TravelerDuelTarget, foreachDuelHistory)
  local mapInfo = {
    TargetId = self.nCurDuelId,
    SelfHotValue = mapCurDuelData.nSelfHotValue,
    RivalHotValue = mapCurDuelData.nRivalHotValue
  }
  self._mapNode.goGridMain:Refresh(mapInfo, true, self._mapActData, self.nActId)
  self._mapNode.lsvDuelHistory:Init(#self.tbDuelHistory, self, self.OnDuelHistoryGridRefresh)
  self._mapNode.lsvDuelHistory.gameObject:SetActive(#self.tbDuelHistory > 0)
  self._mapNode.txtNoDuelHistory.gameObject:SetActive(#self.tbDuelHistory <= 0)
  self:RefreshDuelHistoryBtn()
end

function TrekkerVersusQuestCtrl:RefreshDuelHistoryBtn()
  local nChallengeStartTime = self._mapActData:GetChallengeStartTime()
  local bStreamerDuelOpen = self._mapActData:IsOpenStreamerDuel(nChallengeStartTime)
  local nRivalCount = self._mapActData:GetRivalCount()
  local nDayNum = self._mapActData:GetCurDayNum()
  local nPassedDuelCount = bStreamerDuelOpen and nDayNum - 1 or nRivalCount
  if nDayNum == 0 then
    nPassedDuelCount = nRivalCount
  end
  local nReceivedDuelReward = #self._mapActData:GetDuelRewardTable()
  local bCanReceive = nPassedDuelCount > nReceivedDuelReward
  self._mapNode.btnDuelHistoryUnReceiveAll.gameObject:SetActive(not bCanReceive)
  self._mapNode.btnDuelHistoryReceiveAll.gameObject:SetActive(bCanReceive)
end

function TrekkerVersusQuestCtrl:OnDuelHistoryGridRefresh(goGrid, nIdx)
  local nIndex = nIdx + 1
  if self._mapGridCtrl[goGrid] ~= nil then
    self:UnbindCtrlByNode(self._mapGridCtrl[goGrid])
    self._mapGridCtrl[goGrid] = nil
  end
  local gridCtrl = self:BindCtrlByNode(goGrid, "Game.UI.TrekkerVersus_600004.TrekkerVersusDuelHistoryGridCtrl")
  self._mapGridCtrl[goGrid] = gridCtrl
  local mapDuelHistoryData = self.tbDuelHistory[nIndex]
  self._mapGridCtrl[goGrid]:Refresh(mapDuelHistoryData, false, self._mapActData, self.nActId)
end

function TrekkerVersusQuestCtrl:RefreshGiftQuestTab()
  self._mapNode.lsvGiftQuest:SetAnim(0.05)
  self._mapNode.lsvGiftQuest:Init(#self.tbGiftQuest, self, self.OnGiftQuestGridRefresh)
  self:RefreshReceiveAllQuestButton()
end

function TrekkerVersusQuestCtrl:OnGiftQuestGridRefresh(goGrid, nIdx)
  local nIndex = nIdx + 1
  if self._mapGridCtrl[goGrid] ~= nil then
    self:UnbindCtrlByNode(self._mapGridCtrl[goGrid])
    self._mapGridCtrl[goGrid] = nil
  end
  local gridCtrl = self:BindCtrlByNode(goGrid, "Game.UI.TrekkerVersus_600004.TrekkerVersusGiftQuestGridCtrl")
  self._mapGridCtrl[goGrid] = gridCtrl
  local mapGiftQuestData = self.tbGiftQuest[nIndex]
  self._mapGridCtrl[goGrid]:Refresh(mapGiftQuestData, self._mapActData, self.nActId)
end

function TrekkerVersusQuestCtrl:RefreshBattleQuestTab()
  self._mapNode.lsvBattleQuest:SetAnim(0.05)
  self._mapNode.lsvBattleQuest:Init(#self.tbBattleQuest, self, self.OnBattleQuestGridRefresh)
  self:RefreshReceiveAllQuestButton()
end

function TrekkerVersusQuestCtrl:OnBattleQuestGridRefresh(goGrid, nIdx)
  local nIndex = nIdx + 1
  if self._mapGridCtrl[goGrid] ~= nil then
    self:UnbindCtrlByNode(self._mapGridCtrl[goGrid])
    self._mapGridCtrl[goGrid] = nil
  end
  local gridCtrl = self:BindCtrlByNode(goGrid, "Game.UI.TrekkerVersus_600004.TrekkerVersusGiftQuestGridCtrl")
  self._mapGridCtrl[goGrid] = gridCtrl
  local mapBattleQuestData = self.tbBattleQuest[nIndex]
  self._mapGridCtrl[goGrid]:Refresh(mapBattleQuestData, self._mapActData, self.nActId)
end

function TrekkerVersusQuestCtrl:GetBattleGiftQuestTable()
  self.tbBattleQuest = {}
  self.tbGiftQuest = {}
  for k, mapQuestData in pairs(self._tbAllQuestData) do
    local mapQuestCfgData = ConfigTable.GetData("TravelerDuelChallengeQuest", mapQuestData.Id)
    if mapQuestCfgData ~= nil then
      if mapQuestCfgData.CompleteCond ~= GameEnum.questCompleteCond.TrekkerVersusFansWithSpecificLevel then
        table.insert(self.tbBattleQuest, mapQuestData)
      else
        table.insert(self.tbGiftQuest, mapQuestData)
      end
    end
  end
end

function TrekkerVersusQuestCtrl:Awake()
  self._mapGridCtrl = {}
end

function TrekkerVersusQuestCtrl:FadeIn()
end

function TrekkerVersusQuestCtrl:FadeOut()
end

function TrekkerVersusQuestCtrl:OnEnable()
  self._mapAllQuestCfgData = {}
  self._mapNode.rtWindow.gameObject:SetActive(false)
end

function TrekkerVersusQuestCtrl:OnDisable()
  if self._coroutineOpen ~= nil then
    cs_coroutine.stop(self._coroutineOpen)
    self._coroutineOpen = nil
  end
  self:UnbindAllGrids()
end

function TrekkerVersusQuestCtrl:OnDestroy()
end

function TrekkerVersusQuestCtrl:OnRelease()
end

function TrekkerVersusQuestCtrl:ClosePanel()
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  self:AddTimer(1, 0.3, function()
    self.gameObject:SetActive(false)
    self._mapNode.rtWindow.gameObject:SetActive(false)
  end, true, true, true, nil)
end

function TrekkerVersusQuestCtrl:UnbindAllGrids()
  for go, ctrl in pairs(self._mapGridCtrl) do
    self:UnbindCtrlByNode(ctrl)
  end
  self._mapGridCtrl = {}
end

function TrekkerVersusQuestCtrl:OpenPanel(mapActData, nTab, bOpen, nActId)
  self.gameObject:SetActive(true)
  self._mapActData = mapActData
  self.bOpen = bOpen
  self.nActId = nActId
  self._tbAllQuestData = self._mapActData:GetAllQuestData()
  if self._tbAllQuestData ~= nil then
    self:GetBattleGiftQuestTable()
  end
  self.tbDuelHistory = self._mapActData:GetDuelHistory()
  if self.tbDuelHistory == nil then
    self.tbDuelHistory = {}
  end
  local bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(nActId)
  if bInActGroup then
    RedDotManager.RegisterNode(RedDotDefine.TrekkerVersusHeatQuest, {nActGroupId, nActId}, self._mapNode.goRedDotRewardTab1)
    RedDotManager.RegisterNode(RedDotDefine.TrekkerVersusDuelQuest, {nActGroupId, nActId}, self._mapNode.goRedDotRewardTab2)
    RedDotManager.RegisterNode(RedDotDefine.TrekkerVersusGiftQuest, {nActGroupId, nActId}, self._mapNode.goRedDotRewardTab3)
    RedDotManager.RegisterNode(RedDotDefine.TrekkerVersusBattleQuest, {nActGroupId, nActId}, self._mapNode.goRedDotRewardTab4)
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.rtWindow.gameObject:SetActive(true)
    self._mapNode.aniWindow:Play("t_window_04_t_in")
    self:OnBtnClick_RewardTab(nil, nTab)
    if nTab == self.nRewardTabIndex then
      if nTab == 1 then
        self:RefreshHeatQuestTab()
      elseif nTab == 2 then
        self:RefreshDuelHistoryTab()
      elseif nTab == 3 then
        self:RefreshGiftQuestTab()
      elseif nTab == 4 then
        self:RefreshBattleQuestTab()
      end
    end
  end
  
  if nTab == 3 or nTab == 4 then
    self:RefreshReceiveAllQuestButton()
  else
    self._mapNode.btnReceiveAllQuest.gameObject:SetActive(false)
    self._mapNode.btnUnReceiveAllQuest.gameObject:SetActive(false)
  end
  self._coroutineOpen = cs_coroutine.start(wait)
end

function TrekkerVersusQuestCtrl:OnGridRefresh(goGrid, nIdx)
  local nIndex = nIdx + 1
  if self._mapGridCtrl[goGrid] ~= nil then
    self:UnbindCtrlByNode(self._mapGridCtrl[goGrid])
    self._mapGridCtrl[goGrid] = nil
  end
  local gridCtrl = self:BindCtrlByNode(goGrid, "Game.UI.TrekkerVersus_600004.TrekkerVersusQuestGridCtrl")
  self._mapGridCtrl[goGrid] = gridCtrl
  local mapQuestData = self.tbHeatQuest[nIndex]
  self._mapGridCtrl[goGrid]:Refresh(mapQuestData, self._mapActData, self.nActId)
end

function TrekkerVersusQuestCtrl:OnBtnClick_RewardTab(btn, index)
  if self.nRewardTabIndex == index then
    return
  end
  self.nRewardTabIndex = index
  for i = 1, #self._mapNode.btnRewardTab do
    local objAnimRoot = self._mapNode.btnRewardTab[i].transform:Find("AnimRoot")
    local imgOn = objAnimRoot:Find("imgTabOnBg")
    local imgOff = objAnimRoot:Find("imgTabOffBg")
    imgOn.gameObject:SetActive(i == index)
    imgOff.gameObject:SetActive(i ~= index)
  end
  self._mapNode.rtHeatQuest:SetActive(index == 1)
  self._mapNode.rtDuelHistory:SetActive(index == 2)
  self._mapNode.rtGiftQuest:SetActive(index == 3)
  self._mapNode.rtBattleQuest:SetActive(index == 4)
  if index == 3 or index == 4 then
    self:RefreshReceiveAllQuestButton()
  else
    self._mapNode.btnReceiveAllQuest.gameObject:SetActive(false)
    self._mapNode.btnUnReceiveAllQuest.gameObject:SetActive(false)
  end
  if index == 1 then
    self:RefreshHeatQuestTab()
  elseif index == 2 then
    self:RefreshDuelHistoryTab()
  elseif index == 3 then
    self:RefreshGiftQuestTab()
  elseif index == 4 then
    self:RefreshBattleQuestTab()
  end
end

function TrekkerVersusQuestCtrl:RefreshReceiveAllQuestButton()
  local bCanReceiveAllQuestReward = self._mapActData:GetCanReceiveAllQuestReward()
  self._mapNode.btnReceiveAllQuest.gameObject:SetActive(bCanReceiveAllQuestReward)
  self._mapNode.btnUnReceiveAllQuest.gameObject:SetActive(not bCanReceiveAllQuestReward)
end

function TrekkerVersusQuestCtrl:OnBtnClick_Receive()
  local mapCurHotValue = self._mapActData:GetCurHeatValue()
  local nCurSelfHotValue = mapCurHotValue.nSelfHotValue
  local tbHotValueRewardIds = self._mapActData:GetHotValueRewardTable()
  local bHeatQuestVisible = false
  
  local function foreachHeatReward(mapData)
    if mapData.TargetValue <= nCurSelfHotValue and table.indexof(tbHotValueRewardIds, mapData.Id) <= 0 then
      bHeatQuestVisible = true
    end
  end
  
  ForEachTableLine(DataTable.TravelerDuelHotValueRewards, foreachHeatReward)
  if bHeatQuestVisible then
    EventManager.Hit("TrekkerVersusReceiveHeatQuest", self.nActId, 1)
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Quest_ReceiveNone"))
  end
end

function TrekkerVersusQuestCtrl:OnBtnClick_DuelHistoryReceiveAll()
  local nChallengeStartTime = self._mapActData:GetChallengeStartTime()
  local bStreamerDuelOpen = self._mapActData:IsOpenStreamerDuel(nChallengeStartTime)
  local nRivalCount = self._mapActData:GetRivalCount()
  local nDayNum = self._mapActData:GetCurDayNum()
  local nPassedDuelCount = bStreamerDuelOpen and nDayNum - 1 or nRivalCount
  if nDayNum == 0 then
    nPassedDuelCount = nRivalCount
  end
  local nReceivedDuelReward = #self._mapActData:GetDuelRewardTable()
  local bCanReceive = nPassedDuelCount > nReceivedDuelReward
  if bCanReceive then
    EventManager.Hit("TrekkerVersusReceiveHeatQuest", self.nActId, 2)
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Quest_ReceiveNone"))
  end
end

function TrekkerVersusQuestCtrl:OnBtnClick_ReceiveAll()
  local bCanReceive = false
  for k, v in pairs(self._tbAllQuestData) do
    if v.Status == 1 then
      bCanReceive = true
      break
    end
  end
  if bCanReceive then
    self._mapActData:ReceiveQuestReward(self.nActId)
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Quest_ReceiveNone"))
  end
end

function TrekkerVersusQuestCtrl:OnEvent_TrekkerVersusAffixJump()
  self:ClosePanel()
end

function TrekkerVersusQuestCtrl:OnEvent_TrekkerVersusHeatQuestRefresh()
  if self._mapActData == nil then
    return
  end
  self:RefreshHeatQuestTab()
end

function TrekkerVersusQuestCtrl:OnEvent_UpdateTrekkerVersusHotValue(nSelfHotValue, nRivalHotValue)
  if self._mapActData == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtCurHeatNum, nSelfHotValue)
  local mapInfo = {
    TargetId = self.nCurDuelId,
    SelfHotValue = nSelfHotValue,
    RivalHotValue = nRivalHotValue
  }
  self._mapNode.goGridMain:Refresh(mapInfo, true, self._mapActData, self.nActId)
  self:RefreshHeatQuestTab()
end

function TrekkerVersusQuestCtrl:OnEvent_TrekkerVersusQuestRefresh()
  self._tbAllQuestData = self._mapActData:GetAllQuestData()
  self:GetBattleGiftQuestTable()
  self:RefreshGiftQuestTab()
  self:RefreshBattleQuestTab()
end

function TrekkerVersusQuestCtrl:OnEvent_TrekkerVersusDuelQuestRefresh()
  self:RefreshDuelHistoryTab()
end

return TrekkerVersusQuestCtrl
