local ReengagementTaskCtrl = class("ReengagementTaskCtrl", BaseCtrl)
local TimerManager = require("GameCore.Timer.TimerManager")
ReengagementTaskCtrl._mapNodeConfig = {
  txtActName = {
    sComponentName = "TMP_Text",
    sLanguageId = "Reengagement_Task_Title"
  },
  loopSv = {
    sNodeName = "srGuideQuest",
    sComponentName = "LoopScrollView"
  },
  rtDays = {},
  PerActGroupItem = {
    nCount = 7,
    sCtrlName = "Game.UI.Activity.Reengagement.ReengagementTaskGroupCtrl"
  },
  btnGroup = {
    sNodeName = "PerActGroupItem",
    nCount = 7,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Group"
  },
  btnGroupLock = {
    sNodeName = "btnGroupLock",
    nCount = 7,
    sComponentName = "UIButton",
    callback = "OnBtnClick_GroupLock"
  },
  btnActDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  txtBtnActDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Btn_Detail"
  },
  goActTime = {},
  txtActivityTime = {sComponentName = "TMP_Text"},
  txtActValue = {sComponentName = "TMP_Text"},
  rtActProgressFill = {
    sComponentName = "RectTransform"
  },
  btnNodeItem = {
    nCount = 7,
    sComponentName = "UIButton",
    callback = "OnBtnClick_NodeItem"
  },
  item = {
    nCount = 7,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  }
}
ReengagementTaskCtrl._mapEventConfig = {
  RefreshReengagementQuest = "RefreshQuestList",
  RefreshReengagementQuestPoint = "RefreshActivityNode",
  RefreshReengagementGroup = "OnRefreshGroup"
}

function ReengagementTaskCtrl:Refresh(nCurTog)
  if nCurTog ~= AllEnum.ReengagementTog.Task then
    return
  end
  self:InitActData()
  self:RefreshQuestList()
  self:RefreshActivityNode()
end

function ReengagementTaskCtrl:RefreshRemainTime()
  local endTime = PlayerData.Reengagement:GetReengagementCloseTime()
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local remainTime = endTime - curTime
  if remainTime < 0 then
    TimerManager.Remove(self.remainTimer)
    self.remainTimer = nil
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("Activity_Invalid_Tip_1"),
      callbackConfirm = function()
        EventManager.Hit(EventId.ClosePanel, PanelId.ReengagementPanel)
      end
    })
    return
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
  NovaAPI.SetTMPText(self._mapNode.txtActivityTime, orderedFormat(ConfigTable.GetUIText("PerActivity_Remain_Time") or "", sTimeStr))
end

local tbConvertStatus = {
  [0] = 1,
  [1] = 0,
  [2] = 2
}

function ReengagementTaskCtrl:RefreshQuestList()
  local nGroupId = 100 + (self._panel.nSelectGroup or 1)
  self.tbQuestList = PlayerData.Reengagement:GetQuestListByGroup(nGroupId)
  self.tbQuestData = PlayerData.Reengagement:GetQuestConfigDataByGroup(nGroupId)
  table.sort(self.tbQuestData, function(a, b)
    if not self.tbQuestList[a.Id] or not self.tbQuestList[b.Id] then
      return a.Id < b.Id
    end
    if self.tbQuestList[a.Id].nStatus == self.tbQuestList[b.Id].nStatus then
      return a.Id < b.Id
    end
    return tbConvertStatus[self.tbQuestList[a.Id].nStatus] < tbConvertStatus[self.tbQuestList[b.Id].nStatus]
  end)
  for k, v in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(v)
    self.tbGridCtrl[k] = nil
  end
  if #self.tbQuestData > 0 then
    self.nPageCount = 0
    self._mapNode.loopSv:SetAnim(0.06)
    self._mapNode.loopSv:Init(#self.tbQuestData, self, self.OnGridRefresh, nil, false, self.GetGridPageCount)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  end
  for k, v in ipairs(self._mapNode.PerActGroupItem) do
    local bAllReceived = PlayerData.Reengagement:IsQuestGroupAllReceived(k)
    v:RefreshStatus(bAllReceived)
  end
end

function ReengagementTaskCtrl:GetGridPageCount(pageCount)
  self.nPageCount = pageCount > #self.tbQuestList and #self.tbQuestList or pageCount
end

function ReengagementTaskCtrl:InitGroupList()
  self.nMaxOpenGroup = 0
  self.tbGroupList = {}
  
  local function foreachtabelline(mapData)
    if mapData.ReturneeId == self.nActId then
      table.insert(self.tbGroupList, mapData)
    end
  end
  
  ForEachTableLine(ConfigTable.Get("ActivityReturneeQuestGroup"), foreachtabelline)
  local tbNextOpenGroupList = {}
  local nEventOpenTime = PlayerData.Reengagement:GetReengagementOpenTime()
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  self.nCurDay = 0
  if nil ~= nEventOpenTime and 0 < nEventOpenTime and nEventOpenTime < nCurTime then
    local nOpenDayStartTime = CS.ClientManager.Instance:GetNextRefreshTime(nEventOpenTime) - 86400
    self.nCurDay = math.floor((nCurTime - nOpenDayStartTime) / 86400)
  end
  for _, v in ipairs(self.tbGroupList) do
    local nOpenDay = v.DayOpen
    if nOpenDay <= self.nCurDay then
      self.nMaxOpenGroup = math.max(self.nMaxOpenGroup, v.Id - 100)
    elseif nOpenDay == self.nCurDay + 1 then
      tbNextOpenGroupList[v.Id] = 1
    end
  end
  local nSelectGroup = self.nMaxOpenGroup
  local nSelectGroupId = self.nMaxOpenGroup + 100
  for _, v in ipairs(self.tbGroupList) do
    if nSelectGroupId >= v.Id then
      local tbQuestList = PlayerData.Reengagement:GetQuestListByGroup(v.Id)
      if nil ~= tbQuestList then
        for _, tbQuestData in pairs(tbQuestList) do
          if tbQuestData.nStatus == AllEnum.ActQuestStatus.Complete then
            if nSelectGroupId == 0 or nSelectGroupId > v.Id then
              nSelectGroupId = v.Id
              nSelectGroup = v.Id - 100
            end
            break
          end
        end
      end
    end
  end
  if 100 == nSelectGroupId then
    nSelectGroup = self.nMaxOpenGroup - 100
  end
  for k, v in ipairs(self._mapNode.PerActGroupItem) do
    local bAllReceived = PlayerData.Reengagement:IsQuestGroupAllReceived(k)
    v:Init(self.nActId, k, self.nMaxOpenGroup, bAllReceived)
    if nil ~= tbNextOpenGroupList[k + 100] then
      local nNextRefreshTime = CS.ClientManager.Instance:GetNextRefreshTime(nCurTime)
      local nHour = math.floor((nNextRefreshTime - nCurTime) / 3600)
      if nHour < 1 then
        v:SetTime(orderedFormat(ConfigTable.GetUIText("PerActivity_Quest_Open_Time_2") or "", 1))
      else
        v:SetTime(orderedFormat(ConfigTable.GetUIText("PerActivity_Quest_Open_Time_1") or "", nHour))
      end
    end
  end
  if nil == self._panel.nSelectGroup or self._panel.nSelectGroup > self.nMaxOpenGroup then
    self._panel.nSelectGroup = nSelectGroup
  end
  if nil ~= self._mapNode.PerActGroupItem[self._panel.nSelectGroup] then
    self._mapNode.PerActGroupItem[self._panel.nSelectGroup]:SetSelect(true)
  end
end

function ReengagementTaskCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceId] then
    self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.Activity.Reengagement.ReengagementQuestItemCtrl")
  end
  self.tbGridCtrl[nInstanceId]:SetData(self.nActId, self.tbQuestData[nIndex])
end

local totalLength = 816
local totalNodeLength = 136
local actNodeItemHeight = 152
local totalHeight = 20

function ReengagementTaskCtrl:RefreshActivityNode()
  self.tbQuestActive = {}
  self.nTotalActiveCount = 0
  
  local function ForeachActivity(mapData)
    if mapData.ReturneeId == self.nActId then
      table.insert(self.tbQuestActive, mapData)
    end
  end
  
  ForEachTableLine(ConfigTable.Get("ActivityReturneeQuestPoint"), ForeachActivity)
  table.sort(self.tbQuestActive, function(a, b)
    return a.Point < b.Point
  end)
  local nMaxAct = self.tbQuestActive[#self.tbQuestActive].Point
  self.nTotalActiveCount = nMaxAct
  self.nActiveCount = PlayerData.Reengagement:GetQuestPointInfo().Point or 0
  NovaAPI.SetTMPText(self._mapNode.txtActValue, self.nActiveCount)
  for k, v in ipairs(self.tbQuestActive) do
    if self._mapNode.btnNodeItem[k] ~= nil then
      local bReceived = PlayerData.Reengagement:CheckPointRewardReceived(v.Index)
      self._mapNode.item[k]:SetItem(v.Reward1Tid, nil, v.Reward1Qty, nil, bReceived)
      local node = self._mapNode.btnNodeItem[k]
      local nPosX = math.min(k / #self.tbQuestActive * totalNodeLength, totalNodeLength)
      node.gameObject:SetActive(true)
      local imgNodeAct1 = node.transform:Find("AnimRoot/goNodeItem/imgNumNml")
      local imgNodeAct2 = node.transform:Find("AnimRoot/goNodeItem/imgNumSel")
      local txtNodeAct1 = node.transform:Find("AnimRoot/goNodeItem/imgNumNml/txtNmlValue"):GetComponent("TMP_Text")
      local txtNodeAct2 = node.transform:Find("AnimRoot/goNodeItem/imgNumSel/txtSelValue"):GetComponent("TMP_Text")
      NovaAPI.SetTMPText(txtNodeAct1, v.Point)
      NovaAPI.SetTMPText(txtNodeAct2, v.Point)
      local anim = node.transform:Find("AnimRoot"):GetComponent("Animator")
      local goParticle1 = node.transform:Find("AnimRoot/goNodeItem/UIParticle1")
      local goParticle2 = node.transform:Find("AnimRoot/goNodeItem/UIParticle2")
      local bComplete = v.Point <= self.nActiveCount and not bReceived
      imgNodeAct1.gameObject:SetActive(not bReceived)
      imgNodeAct2.gameObject:SetActive(bReceived)
      goParticle1.gameObject:SetActive(not bReceived and bComplete)
      goParticle2.gameObject:SetActive(not bReceived and bComplete)
      if not bReceived and bComplete then
        anim:Play("Quest_btnNodeComplete_loop", 0, 0)
      else
        anim:Play("Empty")
      end
    end
  end
  local nWidth = math.min(self.nActiveCount / nMaxAct * totalLength, totalLength)
  self._mapNode.rtActProgressFill.sizeDelta = Vector2(nWidth, totalHeight)
end

function ReengagementTaskCtrl:InitActData(bResetGroup)
  if bResetGroup or self._panel.nSelectGroup == nil or self._panel.nSelectGroup == 0 then
    self._panel.nSelectGroup = 1
  end
  self.nActId = PlayerData.Reengagement:GetActId()
  self.bQuestAnim = false
  self:InitGroupList()
  if nil == PlayerData.Reengagement:GetQuestListByGroup(self._panel.nSelectGroup + 100) then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sContent = ConfigTable.GetUIText("Activity_Invalid_Tip_1")
    })
    return
  end
  self._mapNode.goActTime.gameObject:SetActive(true)
  self:RefreshRemainTime()
  if nil == self.remainTimer then
    self.remainTimer = self:AddTimer(0, 1, "RefreshRemainTime", true, true, false)
  end
end

function ReengagementTaskCtrl:Awake()
  self.tbGridCtrl = {}
  self.tbSequences = {}
end

function ReengagementTaskCtrl:FadeIn()
end

function ReengagementTaskCtrl:FadeOut()
end

function ReengagementTaskCtrl:OnEnable()
end

function ReengagementTaskCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function ReengagementTaskCtrl:OnDestroy()
end

function ReengagementTaskCtrl:OnRelease()
end

function ReengagementTaskCtrl:OnRefreshGroup()
  self:InitGroupList()
  self:RefreshRemainTime()
end

function ReengagementTaskCtrl:OnBtnClick_Group(_, nIndex)
  if self._panel.nSelectGroup == nIndex then
    return
  end
  if nIndex > self.nMaxOpenGroup then
    return
  end
  if nil == PlayerData.Reengagement:GetQuestConfigDataByGroup(nIndex + 100) or nil == next(PlayerData.Reengagement:GetQuestConfigDataByGroup(nIndex + 100)) then
    printError(string.format("当前任务组下没有任务!!! 活动id = %d, 任务组 = %s", self.nActId, nIndex))
    return
  end
  self._mapNode.PerActGroupItem[self._panel.nSelectGroup]:SetSelect(false)
  if nil ~= self._mapNode.PerActGroupItem[nIndex] then
    self._mapNode.PerActGroupItem[nIndex]:SetSelect(true)
  end
  self._panel.nSelectGroup = nIndex
  self.bQuestAnim = true
  self:RefreshQuestList()
end

function ReengagementTaskCtrl:OnBtnClick_GroupLock()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("PerActivity_Not_Open"))
end

function ReengagementTaskCtrl:OnBtnClick_Detail()
  local perQuestActCfg = PlayerData.Reengagement:GetActDetail(AllEnum.ReengagementTog.Task)
  local msg = {
    nType = AllEnum.MessageBox.Desc,
    sContent = perQuestActCfg.DesText,
    sTitle = ConfigTable.GetUIText("Activity_Btn_Detail")
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function ReengagementTaskCtrl:OnBtnClick_NodeItem(btn, index)
  if PlayerData.Reengagement:CheckPointRewardReceived(index) then
    UTILS.ClickItemGridWithTips(self.tbQuestActive[index].Reward1Tid, btn.transform, true, true, false)
    return
  end
  if self.nActiveCount >= self.tbQuestActive[index].Point then
    PlayerData.Reengagement:RequestReceiveQuestPointReward(index)
  else
    UTILS.ClickItemGridWithTips(self.tbQuestActive[index].Reward1Tid, btn.transform, true, true, false)
    return
  end
end

return ReengagementTaskCtrl
