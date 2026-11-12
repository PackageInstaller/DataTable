local DailyQuestCtrl = class("DailyQuestCtrl", BaseCtrl)

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

DailyQuestCtrl._mapNodeConfig = {
  txtActValue = {sComponentName = "TMP_Text"},
  imgActive = {sComponentName = "Image"},
  rtImgActProgress = {
    sNodeName = "imgActProgress",
    sComponentName = "RectTransform"
  },
  rtActProgressFill = {
    sComponentName = "RectTransform"
  },
  btnNodeItem = {
    nCount = 5,
    sComponentName = "UIButton",
    callback = "OnBtnClick_NodeItem"
  },
  btnActReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ActReceive"
  },
  txtBtnActReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Receive_Btn_Text"
  },
  btnActReceiveGray = {sComponentName = "UIButton"},
  txtBtnActReceiveGray = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Receive_Btn_Text"
  },
  txtActComplete = {
    sComponentName = "TMP_Text",
    sLanguageId = "Daily_Quest_All_Received"
  },
  dailyQuestLSV = {
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
DailyQuestCtrl._mapEventConfig = {
  ChooseDailyGridByQuestId = "OnEvent_ChooseDailyGridByQuestId"
}
DailyQuestCtrl._mapRedDotConfig = {}
local totalLength = 617
local totalNodeLength = 610
local totalHeight = 37
local actNodeItemHeight = -22.3

function DailyQuestCtrl:RefreshActivityNode()
  NovaAPI.SetTMPText(self._mapNode.txtActValue, self.nActiveCount)
  local bAllComplete = self.nActiveCount >= self.nTotalActiveCount
  self.tbQuestActive = {}
  
  local function ForeachActivity(mapData)
    table.insert(self.tbQuestActive, mapData)
  end
  
  ForEachTableLine(ConfigTable.Get("DailyQuestActive"), ForeachActivity)
  table.sort(self.tbQuestActive, function(a, b)
    return a.Active < b.Active
  end)
  local nMaxAct = self.tbQuestActive[#self.tbQuestActive].Active
  self.tbCanReceiveAct = {}
  for k, v in ipairs(self.tbQuestActive) do
    if self._mapNode.btnNodeItem[k] ~= nil then
      local node = self._mapNode.btnNodeItem[k]
      local nPosX = math.min(k / #self.tbQuestActive * totalNodeLength, totalNodeLength)
      node.transform:GetComponent("RectTransform").anchoredPosition = Vector2(nPosX, actNodeItemHeight)
      node.gameObject:SetActive(true)
      local txtNodeAct = node.transform:Find("AnimRoot/goNodeItem/txtNodeAct"):GetComponent("TMP_Text")
      NovaAPI.SetTMPText(txtNodeAct, v.Active)
      local anim = node.transform:Find("AnimRoot"):GetComponent("Animator")
      local imgGift = node.transform:Find("AnimRoot/goNodeItem/imgGift")
      local imgComplete = node.transform:Find("AnimRoot/goNodeItem/imgComplete")
      local goParticle1 = node.transform:Find("AnimRoot/goNodeItem/UIParticle1")
      local goParticle2 = node.transform:Find("AnimRoot/goNodeItem/UIParticle2")
      local bReceived = PlayerData.Quest:CheckDailyActiveReceive(v.Id)
      local bComplete = v.Active <= self.nActiveCount
      imgGift.gameObject:SetActive(not bReceived)
      imgComplete.gameObject:SetActive(bReceived)
      goParticle1.gameObject:SetActive(not bReceived and bComplete)
      goParticle2.gameObject:SetActive(not bReceived and bComplete)
      if bComplete and not bReceived then
        table.insert(self.tbCanReceiveAct, k)
      end
      if not bReceived and bComplete then
        anim:Play("Quest_btnNodeComplete_loop", 0, 0)
      else
        anim:Play("Empty")
      end
    end
  end
  self._mapNode.btnActReceive.gameObject:SetActive(#self.tbCanReceiveAct > 0)
  self._mapNode.txtActComplete.gameObject:SetActive(bAllComplete and not (#self.tbCanReceiveAct > 0))
  self._mapNode.btnActReceiveGray.gameObject:SetActive(not bAllComplete and not (#self.tbCanReceiveAct > 0))
  local nWidth = math.min(self.nActiveCount / nMaxAct * totalLength, totalLength)
  self._mapNode.rtActProgressFill.sizeDelta = Vector2(nWidth, totalHeight)
end

function DailyQuestCtrl:Refresh(tbDailyQuest)
  self.tbDailyQuest = tbDailyQuest
  self.nActiveCount = 0
  self.nTotalActiveCount = 0
  for _, mapDailyQuest in ipairs(tbDailyQuest) do
    local mapQuestData = ConfigTable.GetData("DailyQuest", mapDailyQuest.nTid)
    if mapQuestData ~= nil then
      if mapDailyQuest.nStatus == 2 then
        self.nActiveCount = self.nActiveCount + mapQuestData.Active
      end
      self.nTotalActiveCount = self.nTotalActiveCount + mapQuestData.Active
    end
  end
  local mapItemCfg = ConfigTable.GetData_Item(AllEnum.CoinItemId.DailyQuestActive)
  if mapItemCfg ~= nil then
    self:SetPngSprite(self._mapNode.imgActive, mapItemCfg.Icon)
  end
  self:RefreshActivityNode()
  local bListCanReceive = false
  for _, mapData in ipairs(self.tbDailyQuest) do
    if mapData.nStatus == 1 then
      bListCanReceive = true
      break
    end
  end
  local bActCanReceive = self.tbCanReceiveAct ~= nil and 0 < #self.tbCanReceiveAct
  local bFastReceive = bListCanReceive or bActCanReceive
  self._mapNode.dailyQuestLSV.gameObject:SetActive(true)
  self._mapNode.btnFastReceive.gameObject:SetActive(bFastReceive)
  self._mapNode.btnFastReceiveGray.gameObject:SetActive(not bFastReceive)
  self._mapNode.dailyQuestLSV:SetAnim(0.08)
  self._mapNode.dailyQuestLSV:Init(#self.tbDailyQuest, self, self.OnGridQuestRefresh, nil, false)
end

function DailyQuestCtrl:OnGridQuestRefresh(goGrid, gridIndex)
  if self.mapDailyGrid[goGrid] == nil then
    self.mapDailyGrid[goGrid] = self:BindCtrlByNode(goGrid, "Game.UI.Quest.DailyQuest.DailyQuestGridCtrl")
  end
  local nIdx = gridIndex + 1
  local mapQuest = self.tbDailyQuest[nIdx]
  self.mapDailyGrid[goGrid]:Refresh(mapQuest.nTid, mapQuest.nStatus, mapQuest.nCurProgress, mapQuest.nGoal)
end

function DailyQuestCtrl:Awake()
  self.mapDailyGrid = {}
end

function DailyQuestCtrl:OnEnable()
end

function DailyQuestCtrl:OnDisable()
  for go, mapCtrl in ipairs(self.mapDailyGrid) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self.mapDailyGrid = {}
end

function DailyQuestCtrl:OnDestroy()
end

function DailyQuestCtrl:OnBtnClick_ActReceive()
  PlayerData.Quest:ReceiveDailyActiveReward()
end

function DailyQuestCtrl:_RecalcCanReceiveAct()
  local nActiveCount = 0
  for _, mapDailyQuest in ipairs(self.tbDailyQuest or {}) do
    if mapDailyQuest.nStatus == 2 then
      local mapQuestData = ConfigTable.GetData("DailyQuest", mapDailyQuest.nTid)
      if mapQuestData ~= nil then
        nActiveCount = nActiveCount + mapQuestData.Active
      end
    end
  end
  self.nActiveCount = nActiveCount
  self.tbCanReceiveAct = {}
  for k, mapData in ipairs(self.tbQuestActive or {}) do
    local bComplete = nActiveCount >= mapData.Active
    local bReceived = PlayerData.Quest:CheckDailyActiveReceive(mapData.Id)
    if bComplete and not bReceived then
      table.insert(self.tbCanReceiveAct, k)
    end
  end
end

function DailyQuestCtrl:OnBtnClick_FastReceive()
  local bListCanReceive = false
  for _, mapData in ipairs(self.tbDailyQuest) do
    if mapData.nStatus == 1 then
      bListCanReceive = true
      break
    end
  end
  local bActCanReceive = self.tbCanReceiveAct ~= nil and #self.tbCanReceiveAct > 0
  local tab = {}
  table.insert(tab, {
    "role_id",
    tostring(PlayerData.Base._nPlayerId)
  })
  NovaAPI.UserEventUpload("daily_mission_complete", tab)
  if not bListCanReceive and not bActCanReceive then
    return
  end
  if bListCanReceive then
    PlayerData.Quest:ReceiveDailyReward(0)
  else
    PlayerData.Quest:ReceiveDailyActiveReward()
  end
end

function DailyQuestCtrl:_AccumulateListChange(mapMsgData)
  if mapMsgData == nil then
    return
  end
  local mapReward = PlayerData.Item:ProcessRewardChangeInfo(mapMsgData)
  if mapReward == nil then
    return
  end
  for _, v in ipairs(mapReward.tbReward or {}) do
    appendOrStack(self._mapMergedReward.tbReward, v, "id", "count", "rewardType")
  end
  for _, v in ipairs(mapReward.tbSpReward or {}) do
    table.insert(self._mapMergedReward.tbSpReward, v)
  end
  for _, v in ipairs(mapReward.tbSrc or {}) do
    appendOrStack(self._mapMergedReward.tbSrc, v, "Tid", "Qty")
  end
  for _, v in ipairs(mapReward.tbDst or {}) do
    appendOrStack(self._mapMergedReward.tbDst, v, "Tid", "Qty")
  end
end

function DailyQuestCtrl:_AccumulateDisplayReward(tbShowReward)
  if tbShowReward == nil then
    return
  end
  for _, v in ipairs(tbShowReward) do
    appendOrStack(self._mapMergedReward.tbReward, v, "id", "count", "rewardType")
  end
end

function DailyQuestCtrl:_FlushBatchReceive()
  PlayerData.Quest:SetBatchReceiveFlag(false)
  local mapMerged = self._mapMergedReward or {
    tbReward = {},
    tbSpReward = {},
    tbSrc = {},
    tbDst = {}
  }
  self._mapMergedReward = nil
  
  local function refreshFunc()
    EventManager.Hit(EventId.QuestDataRefresh, "Daily")
  end
  
  local function tipCallback()
    local bOpen = PlayerData.Base:TryOpenWorldClassUpgrade(refreshFunc)
    if not bOpen then
      refreshFunc()
    end
  end
  
  UTILS.OpenReceiveByReward(mapMerged, tipCallback)
end

function DailyQuestCtrl:OnBtnClick_FastReceiveGray()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("DoubleDrop_Reward_Receive_Tip"))
end

function DailyQuestCtrl:OnBtnClick_NodeItem(btn, nIndex)
  local bCanReceive = false
  for _, v in ipairs(self.tbCanReceiveAct) do
    if v == nIndex then
      bCanReceive = true
      break
    end
  end
  if #self.tbCanReceiveAct > 0 and bCanReceive then
    PlayerData.Quest:ReceiveDailyActiveReward()
  elseif self.tbQuestActive[nIndex] ~= nil then
    local sTip = orderedFormat(ConfigTable.GetUIText("Daily_Quest_Reward_Tip"), self.tbQuestActive[nIndex].Active)
    local tbItem = {}
    for i = 1, 3 do
      if self.tbQuestActive[nIndex]["ItemTid" .. i] ~= nil and self.tbQuestActive[nIndex]["ItemTid" .. i] ~= 0 then
        table.insert(tbItem, {
          nTid = self.tbQuestActive[nIndex]["ItemTid" .. i],
          nCount = self.tbQuestActive[nIndex]["Number" .. i],
          bFullShow = true
        })
      end
    end
    local msg = {
      nType = AllEnum.MessageBox.Item,
      sTitle = ConfigTable.GetUIText("Daily_Quest_Reward_Tip_Title"),
      sContent = sTip,
      tbItem = tbItem
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
end

function DailyQuestCtrl:OnEvent_ChooseDailyGridByQuestId(questId)
  for i, v in pairs(self.mapDailyGrid) do
    if v.nQuestId == questId then
      EventManager.Hit("Guide_ChooseDailyGridObj", i.gameObject.name)
      break
    end
  end
end

return DailyQuestCtrl
