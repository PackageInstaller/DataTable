local GuideQuestCtrl = class("GuideQuestCtrl", BaseCtrl)

local function appendOrStack(tbDst, mapItem, sIdKey, sQtyKey, sExtraKey)
  if mapItem == nil then
    return
  end
  for _, v in ipairs(tbDst) do
    if v[sIdKey] == mapItem[sIdKey] and v[sExtraKey] == mapItem[sExtraKey] then
      v[sQtyKey] = (v[sQtyKey] or 0) + (mapItem[sQtyKey] or 0)
      return
    end
  end
  table.insert(tbDst, mapItem)
end

GuideQuestCtrl._mapNodeConfig = {
  txtChapter = {sComponentName = "TMP_Text"},
  btnRewardItem = {
    nCount = 5,
    sComponentName = "UIButton",
    callback = "OnBtnClick_RewardItem"
  },
  rewardItem = {
    nCount = 5,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  imgEmpty = {nCount = 5},
  btnReceiveChapter = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ReceiveChapter"
  },
  txtBtnReceiveChapter = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Receive"
  },
  txtActComplete = {
    sComponentName = "TMP_Text",
    sLanguageId = "Daily_Quest_All_Received"
  },
  btnReceiveChapterGray = {sComponentName = "UIButton"},
  txtBtnReceiveChapterGray = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Receive"
  },
  BtnLeft = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Left"
  },
  BtnRight = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Right"
  },
  guideQuestLSV = {
    sComponentName = "LoopScrollView"
  },
  btnFastReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_FastReceive"
  },
  txtBtnFastReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Fast_Receive_Btn_Text"
  },
  btnFastReceiveGray = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_FastReceiveGray"
  },
  txtBtnFastReceiveGray = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Fast_Receive_Btn_Text"
  }
}
GuideQuestCtrl._mapEventConfig = {
  Guide_SelectTourGuideQuest = "OnEvent_SelectTourGuideQuest"
}
GuideQuestCtrl._mapRedDotConfig = {}
local statusOrder = {
  [0] = 1,
  [1] = 2,
  [2] = 0
}

function GuideQuestCtrl:Refresh(mapGuideQuest, nCurGroup)
  self.mapCurQuests = mapGuideQuest
  table.sort(self.mapCurQuests, function(a, b)
    if a.nStatus == b.nStatus then
      return a.nTid < b.nTid
    end
    return statusOrder[a.nStatus] > statusOrder[b.nStatus]
  end)
  self.nCurGroup = nCurGroup
  if self.nCurGroup == 0 then
    self.nCurGroup = self.tbAllGroup[#self.tbAllGroup].Id
  end
  if self.mapCurQuests == nil then
    self.mapCurQuests = {}
    for _, mapQuestCfgData in ipairs(self.mapAllGuideQuest[self.nCurGroup]) do
      table.insert(self.mapCurQuests, {
        nTid = mapQuestCfgData.Id,
        nGoal = 1,
        nCurProgress = 1,
        nStatus = 2,
        nExpire = 0
      })
    end
  end
  self.nCurPage = 0
  self.mapCurPageQuest = self.mapCurQuests
  self:RefreshShow(self.nCurGroup)
end

function GuideQuestCtrl:RefreshShow(nCurGroup)
  self.curShowGroup = nCurGroup
  local curShowGroupIdx = 0
  local curGroupIdx = 0
  for idx, mapGroupData in ipairs(self.tbAllGroup) do
    if nCurGroup == mapGroupData.Id then
      curShowGroupIdx = idx
    end
    if self.nCurGroup == mapGroupData.Id then
      curGroupIdx = idx
    end
  end
  local questGroupCfg = self.tbAllGroup[curShowGroupIdx]
  self.tbChapterReward = {}
  if questGroupCfg ~= nil then
    self.nCurOrder = questGroupCfg.Order
    for i = 1, 6 do
      if questGroupCfg["Reward" .. i] ~= 0 then
        table.insert(self.tbChapterReward, {
          nTid = questGroupCfg["Reward" .. i],
          nCount = questGroupCfg["RewardQty" .. i]
        })
      end
    end
    NovaAPI.SetTMPText(self._mapNode.txtChapter, string.format("%02d", questGroupCfg.Order))
  end
  for k, v in ipairs(self._mapNode.rewardItem) do
    v.gameObject:SetActive(k <= #self.tbChapterReward)
    if k <= #self.tbChapterReward then
      v:SetItem(self.tbChapterReward[k].nTid, nil, self.tbChapterReward[k].nCount, nil, nil, nil, nil, true)
    end
    if self._mapNode.imgEmpty[k] ~= nil then
      self._mapNode.imgEmpty[k].gameObject:SetActive(k > #self.tbChapterReward)
    end
  end
  local bFastReceive = false
  local bAllReceive = true
  if curGroupIdx == curShowGroupIdx then
    for _, mapData in pairs(self.mapCurPageQuest) do
      if mapData.nStatus == 1 then
        bFastReceive = true
      end
      if mapData.nStatus ~= 2 then
        bAllReceive = false
      end
    end
  end
  local bGroupReceived = PlayerData.Quest:CheckTourGroupReward(questGroupCfg.Order)
  local bCanReceive = bAllReceive and not bGroupReceived
  self._bListCanReceive = bFastReceive
  self._bChapterCanReceive = bCanReceive
  bFastReceive = bFastReceive or bCanReceive
  self._mapNode.btnReceiveChapter.gameObject:SetActive(bCanReceive)
  self._mapNode.btnReceiveChapterGray.gameObject:SetActive(not bCanReceive and not bGroupReceived)
  self._mapNode.txtActComplete.gameObject:SetActive(bGroupReceived)
  self._mapNode.btnFastReceive.gameObject:SetActive(bFastReceive)
  self._mapNode.btnFastReceiveGray.gameObject:SetActive(not bFastReceive)
  self._mapNode.BtnLeft.gameObject:SetActive(1 < curShowGroupIdx)
  self._mapNode.BtnRight.gameObject:SetActive(curShowGroupIdx < curGroupIdx)
  if self.nCurPage == 1 then
    self.nCurPage = 2
  else
    self.nCurPage = 1
  end
  self._mapNode.guideQuestLSV:SetAnim(0.08)
  self._mapNode.guideQuestLSV:Init(#self.mapCurPageQuest, self, self.OnQuestGridRefresh)
end

function GuideQuestCtrl:OnQuestGridRefresh(goGrid, gridIndex)
  if self.mapQuestsGrids[goGrid] == nil then
    self.mapQuestsGrids[goGrid] = self:BindCtrlByNode(goGrid, "Game.UI.Quest.GuideQuest.GuideQuestGridCtrl")
  end
  local nIdx = gridIndex + 1
  self.mapQuestsGrids[goGrid]:Refresh(self.mapCurPageQuest[nIdx])
end

function GuideQuestCtrl:OnBtnClick_Right()
  local curShowGroupIdx = 0
  for idx, mapGroupData in ipairs(self.tbAllGroup) do
    if self.curShowGroup == mapGroupData.Id then
      curShowGroupIdx = idx
    end
  end
  local nAfterGroupIdx = curShowGroupIdx + 1
  local nAfterGroup = self.tbAllGroup[nAfterGroupIdx].Id
  if nAfterGroup == self.nCurGroup then
    self.mapCurPageQuest = self.mapCurQuests
    self:RefreshShow(self.nCurGroup)
    return
  end
  self.mapCurPageQuest = {}
  for _, mapQuestCfgData in ipairs(self.mapAllGuideQuest[nAfterGroup]) do
    table.insert(self.mapCurPageQuest, {
      nTid = mapQuestCfgData.Id,
      nGoal = 1,
      nCurProgress = 1,
      nStatus = 2,
      nExpire = 0
    })
  end
  self:RefreshShow(nAfterGroup)
end

function GuideQuestCtrl:OnBtnClick_Left()
  local curShowGroupIdx = 0
  for idx, mapGroupData in ipairs(self.tbAllGroup) do
    if self.curShowGroup == mapGroupData.Id then
      curShowGroupIdx = idx
    end
  end
  local nAfterGroupIdx = curShowGroupIdx - 1
  local nAfterGroup = self.tbAllGroup[nAfterGroupIdx].Id
  self.mapCurPageQuest = {}
  for _, mapQuestCfgData in ipairs(self.mapAllGuideQuest[nAfterGroup]) do
    table.insert(self.mapCurPageQuest, {
      nTid = mapQuestCfgData.Id,
      nGoal = 1,
      nCurProgress = 1,
      nStatus = 2,
      nExpire = 0
    })
  end
  self:RefreshShow(nAfterGroup)
end

function GuideQuestCtrl:Awake()
  self.mapAllGuideQuest = {}
  
  local function foreachGuideQuest(mapData)
    if self.mapAllGuideQuest[mapData.Order] == nil then
      self.mapAllGuideQuest[mapData.Order] = {}
    end
    table.insert(self.mapAllGuideQuest[mapData.Order], mapData)
  end
  
  ForEachTableLine(ConfigTable.Get("TourGuideQuest"), foreachGuideQuest)
  
  local function sortQuest(a, b)
    return a.Id < b.Id
  end
  
  for _, tbGuideQuests in pairs(self.mapAllGuideQuest) do
    table.sort(tbGuideQuests, sortQuest)
  end
  self.tbAllGroup = {}
  
  local function foreachGuideGroup(mapData)
    table.insert(self.tbAllGroup, mapData)
  end
  
  ForEachTableLine(DataTable.TourGuideQuestGroup, foreachGuideGroup)
  
  local function sortQuestGroup(a, b)
    return a.Order < b.Order
  end
  
  table.sort(self.tbAllGroup, sortQuestGroup)
  self.mapQuestsGrids = {}
  self.mapCurPageQuest = {}
end

function GuideQuestCtrl:OnEnable()
end

function GuideQuestCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.mapQuestsGrids) do
    self:UnbindCtrlByNode(objCtrl)
    self.mapQuestsGrids[nInstanceId] = nil
  end
  self.mapQuestsGrids = {}
  self.mapCurPageQuest = {}
end

function GuideQuestCtrl:OnDestroy()
end

function GuideQuestCtrl:OnBtnClick_ReceiveChapter()
  local bReceived = PlayerData.Quest:CheckTourGroupReward(self.nCurOrder)
  if bReceived then
    return
  end
  PlayerData.Quest:ReceiveTourGroupReward()
end

function GuideQuestCtrl:OnBtnClick_FastReceive()
  local bListCanReceive = self._bListCanReceive == true
  local bChapterCanReceive = self._bChapterCanReceive == true
  if not bListCanReceive and not bChapterCanReceive then
    return
  end
  if bListCanReceive then
    PlayerData.Quest:ReceiveTourReward(0)
  else
    PlayerData.Quest:ReceiveTourGroupReward(nil)
  end
end

function GuideQuestCtrl:_CheckChapterUnlockedAfterList()
  if PlayerData.Quest:CheckTourGroupReward(self.nCurOrder) then
    return false
  end
  if self.mapCurQuests == nil then
    return false
  end
  for _, mapData in ipairs(self.mapCurQuests) do
    if mapData.nStatus ~= 2 then
      return false
    end
  end
  return true
end

function GuideQuestCtrl:_AccumulateTourReward(mapMsgData)
  if mapMsgData == nil then
    return
  end
  local mapTrans = PlayerData.Item:ProcessTransChangeInfo(mapMsgData.Change)
  local tbReward, tbSpReward = PlayerData.Item:ProcessRewardDisplayItem(mapMsgData.Rewards, mapTrans)
  if tbReward ~= nil then
    for _, v in ipairs(tbReward) do
      appendOrStack(self._mapMergedReward.tbReward, v, "id", "count", "rewardType")
    end
  end
  if tbSpReward ~= nil then
    for _, v in ipairs(tbSpReward) do
      table.insert(self._mapMergedReward.tbSpReward, v)
    end
  end
  if mapTrans ~= nil then
    for _, v in ipairs(mapTrans.tbSrc or {}) do
      appendOrStack(self._mapMergedReward.tbSrc, v, "Tid", "Qty")
    end
    for _, v in ipairs(mapTrans.tbDst or {}) do
      appendOrStack(self._mapMergedReward.tbDst, v, "Tid", "Qty")
    end
  end
end

function GuideQuestCtrl:_FlushBatchReceive()
  PlayerData.Quest:SetBatchReceiveFlag(false)
  local mapMerged = self._mapMergedReward or {
    tbReward = {},
    tbSpReward = {},
    tbSrc = {},
    tbDst = {}
  }
  self._mapMergedReward = nil
  
  local function refreshFunc()
    EventManager.Hit(EventId.QuestDataRefresh, "TourGuide")
  end
  
  UTILS.OpenReceiveByReward(mapMerged, refreshFunc)
end

function GuideQuestCtrl:OnBtnClick_FastReceiveGray()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("DoubleDrop_Reward_Receive_Tip"))
end

function GuideQuestCtrl:OnBtnClick_RewardItem(btn, nIndex)
  if self.tbChapterReward[nIndex] ~= nil then
    local nTid = self.tbChapterReward[nIndex].nTid
    UTILS.ClickItemGridWithTips(nTid, btn.transform, true, true, false)
  end
end

function GuideQuestCtrl:OnEvent_SelectTourGuideQuest(nQuestId)
  for i, v in ipairs(self.mapCurPageQuest) do
    if v.nTid == nQuestId then
      self._mapNode.guideQuestLSV:SetScrollGridPos(i - 1, 0, 0)
      EventManager.Hit("Guide_SelectGuideGroupGrid", nQuestId, i - 1)
      break
    end
  end
end

return GuideQuestCtrl
