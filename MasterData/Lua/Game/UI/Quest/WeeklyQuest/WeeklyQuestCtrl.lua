local WeeklyQuestCtrl = class("WeeklyQuestCtrl", BaseCtrl)

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

WeeklyQuestCtrl._mapNodeConfig = {
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
  weeklyQuestLSV = {
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
  },
  txt_time = {sComponentName = "TMP_Text"}
}
WeeklyQuestCtrl._mapEventConfig = {}
WeeklyQuestCtrl._mapRedDotConfig = {}
local totalLength = 617
local totalNodeLength = 610
local totalHeight = 37
local actNodeItemHeight = -22.3

function WeeklyQuestCtrl:RefreshActivityNode()
  NovaAPI.SetTMPText(self._mapNode.txtActValue, self.nActiveCount)
  local bAllComplete = self.nActiveCount >= self.nTotalActiveCount
  self.tbQuestActive = {}
  
  local function ForeachActivity(mapData)
    table.insert(self.tbQuestActive, mapData)
  end
  
  ForEachTableLine(ConfigTable.Get("WeeklyQuestActive"), ForeachActivity)
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
      local bReceived = PlayerData.Quest:CheckWeeklyActiveReceive(v.Id)
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

function WeeklyQuestCtrl:Refresh(tbWeeklyQuest)
  self.tbWeeklyQuest = tbWeeklyQuest
  local WeeklyQuests = {}
  self.tbShowWeeklyQuest = {}
  self.nActiveCount = 0
  self.nTotalActiveCount = 0
  for _, mapWeeklyQuest in ipairs(tbWeeklyQuest) do
    local mapQuestData = ConfigTable.GetData("WeeklyQuest", mapWeeklyQuest.nTid)
    if mapQuestData ~= nil then
      if mapWeeklyQuest.nStatus == 2 then
        self.nActiveCount = self.nActiveCount + mapQuestData.Active
      end
      self.nTotalActiveCount = self.nTotalActiveCount + mapQuestData.Active
      WeeklyQuests[mapWeeklyQuest.nTid] = mapWeeklyQuest
    end
  end
  local mapItemCfg = ConfigTable.GetData_Item(AllEnum.CoinItemId.WeeklyQuestActive)
  if mapItemCfg ~= nil then
    self:SetPngSprite(self._mapNode.imgActive, mapItemCfg.Icon)
  end
  self:RefreshActivityNode()
  local bListCanReceive = false
  for _, mapData in ipairs(self.tbWeeklyQuest) do
    if mapData.nStatus == 1 then
      bListCanReceive = true
      break
    end
  end
  local bActCanReceive = self.tbCanReceiveAct ~= nil and 0 < #self.tbCanReceiveAct
  local bFastReceive = bListCanReceive or bActCanReceive
  for _, mapData in ipairs(self.tbWeeklyQuest) do
    local questConfig = ConfigTable.GetData("WeeklyQuest", mapData.nTid)
    if questConfig ~= nil then
      if 0 < #questConfig.Prerequisites then
        local bShow = true
        for _, questId in ipairs(questConfig.Prerequisites) do
          if WeeklyQuests[questId] ~= nil and WeeklyQuests[questId].nStatus == 0 then
            bShow = false
            break
          end
        end
        if bShow then
          table.insert(self.tbShowWeeklyQuest, mapData)
        end
      else
        table.insert(self.tbShowWeeklyQuest, mapData)
      end
    end
  end
  self._mapNode.weeklyQuestLSV.gameObject:SetActive(true)
  self._mapNode.btnFastReceive.gameObject:SetActive(bFastReceive)
  self._mapNode.btnFastReceiveGray.gameObject:SetActive(not bFastReceive)
  self._mapNode.weeklyQuestLSV:SetAnim(0.08)
  self._mapNode.weeklyQuestLSV:Init(#self.tbShowWeeklyQuest, self, self.OnGridQuestRefresh, nil, false)
  self:RefeshTime()
  if nil == self.remainTimer then
    self.remainTimer = self:AddTimer(0, 60, "RefeshTime", true, true, false)
  end
end

function WeeklyQuestCtrl:RefeshTime()
  local nEndTime = 0
  if 0 < #self.tbWeeklyQuest then
    nEndTime = self.tbWeeklyQuest[1].nExpire
  else
    return
  end
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local remainTime = nEndTime - curTime
  local sTimeStr = ""
  if 86400 <= remainTime then
    local day = math.floor(remainTime / 86400)
    local hour = math.floor((remainTime - day * 86400) / 3600)
    if hour == 0 then
      day = day - 1
      hour = 24
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Energy_LeftTime_Day"), day, hour)
  elseif 3600 <= remainTime then
    local hour = math.floor(remainTime / 3600)
    local min = math.floor((remainTime - hour * 3600) / 60)
    if min == 0 then
      hour = hour - 1
      min = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Energy_LeftTime_Hour"), hour, min)
  else
    sTimeStr = ConfigTable.GetUIText("Energy_LeftTime_LessThenHour")
  end
  local text = orderedFormat(ConfigTable.GetUIText("Weekly_Quest_Remain"), sTimeStr)
  NovaAPI.SetTMPText(self._mapNode.txt_time, text)
end

function WeeklyQuestCtrl:OnGridQuestRefresh(goGrid, gridIndex)
  if self.mapWeeklyGrid[goGrid] == nil then
    self.mapWeeklyGrid[goGrid] = self:BindCtrlByNode(goGrid, "Game.UI.Quest.WeeklyQuest.WeeklyQuestGridCtrl")
  end
  local nIdx = gridIndex + 1
  local mapQuest = self.tbShowWeeklyQuest[nIdx]
  self.mapWeeklyGrid[goGrid]:Refresh(mapQuest.nTid, mapQuest.nStatus, mapQuest.nCurProgress, mapQuest.nGoal)
end

function WeeklyQuestCtrl:Awake()
  self.mapWeeklyGrid = {}
end

function WeeklyQuestCtrl:OnEnable()
end

function WeeklyQuestCtrl:OnDisable()
  for go, mapCtrl in ipairs(self.mapWeeklyGrid) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self.mapWeeklyGrid = {}
  if self.remainTimer ~= nil then
    self.remainTimer:Cancel()
  end
  self.remainTimer = nil
end

function WeeklyQuestCtrl:OnDestroy()
end

function WeeklyQuestCtrl:OnBtnClick_ActReceive()
  PlayerData.Quest:ReceiveWeeklyActiveReward()
end

function WeeklyQuestCtrl:_RecalcCanReceiveAct()
  local nActiveCount = 0
  for _, mapWeeklyQuest in ipairs(self.tbWeeklyQuest or {}) do
    if mapWeeklyQuest.nStatus == 2 then
      local mapQuestData = ConfigTable.GetData("WeeklyQuest", mapWeeklyQuest.nTid)
      if mapQuestData ~= nil then
        nActiveCount = nActiveCount + mapQuestData.Active
      end
    end
  end
  self.nActiveCount = nActiveCount
  self.tbCanReceiveAct = {}
  for k, mapData in ipairs(self.tbQuestActive or {}) do
    local bComplete = nActiveCount >= mapData.Active
    local bReceived = PlayerData.Quest:CheckWeeklyActiveReceive(mapData.Id)
    if bComplete and not bReceived then
      table.insert(self.tbCanReceiveAct, k)
    end
  end
end

function WeeklyQuestCtrl:OnBtnClick_FastReceive()
  local bListCanReceive = false
  for _, mapData in ipairs(self.tbWeeklyQuest) do
    if mapData.nStatus == 1 then
      bListCanReceive = true
      break
    end
  end
  local bActCanReceive = self.tbCanReceiveAct ~= nil and #self.tbCanReceiveAct > 0
  if not bListCanReceive and not bActCanReceive then
    return
  end
  if bListCanReceive then
    PlayerData.Quest:ReceiveWeeklyReward(0)
  else
    PlayerData.Quest:ReceiveWeeklyActiveReward()
  end
end

function WeeklyQuestCtrl:_AccumulateListChange(mapMsgData)
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

function WeeklyQuestCtrl:_AccumulateDisplayReward(tbShowReward)
  if tbShowReward == nil then
    return
  end
  for _, v in ipairs(tbShowReward) do
    appendOrStack(self._mapMergedReward.tbReward, v, "id", "count", "rewardType")
  end
end

function WeeklyQuestCtrl:_FlushBatchReceive()
  PlayerData.Quest:SetBatchReceiveFlag(false)
  local mapMerged = self._mapMergedReward or {
    tbReward = {},
    tbSpReward = {},
    tbSrc = {},
    tbDst = {}
  }
  self._mapMergedReward = nil
  
  local function refreshFunc()
    EventManager.Hit(EventId.QuestDataRefresh, "Weekly")
  end
  
  local function tipCallback()
    local bOpen = PlayerData.Base:TryOpenWorldClassUpgrade(refreshFunc)
    if not bOpen then
      refreshFunc()
    end
  end
  
  UTILS.OpenReceiveByReward(mapMerged, tipCallback)
end

function WeeklyQuestCtrl:OnBtnClick_FastReceiveGray()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("DoubleDrop_Reward_Receive_Tip"))
end

function WeeklyQuestCtrl:OnBtnClick_NodeItem(btn, nIndex)
  local bCanReceive = false
  for _, v in ipairs(self.tbCanReceiveAct) do
    if v == nIndex then
      bCanReceive = true
      break
    end
  end
  if #self.tbCanReceiveAct > 0 and bCanReceive then
    PlayerData.Quest:ReceiveWeeklyActiveReward()
  elseif self.tbQuestActive[nIndex] ~= nil then
    local sTip = orderedFormat(ConfigTable.GetUIText("Weekly_Quest_Reward_Tip"), self.tbQuestActive[nIndex].Active)
    local tbItem = {}
    for i = 1, 2 do
      if self.tbQuestActive[nIndex]["ItemTid" .. i] ~= 0 then
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

return WeeklyQuestCtrl
