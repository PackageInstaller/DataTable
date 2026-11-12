local LocalData = require("GameCore.Data.LocalData")
local PhoneChatCtrl = class("PhoneChatCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
PhoneChatCtrl._mapNodeConfig = {
  goChatHistory = {},
  btnHistoryList = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_HistoryList"
  },
  txtHistoryBtn = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Phone_Chat_History_List"
  },
  btnNormal = {},
  btnSelect = {},
  goHistoryList = {},
  animHistoryList = {
    sNodeName = "goHistoryList",
    sComponentName = "Animator"
  },
  chatHistoryLSV = {
    sComponentName = "LoopScrollView"
  },
  trLSV = {
    sNodeName = "chatHistoryLSV",
    sComponentName = "Transform"
  },
  btnHistoryMask = {
    sComponentName = "Button",
    callback = "OnBtnClick_HistoryMask"
  },
  goPhone = {
    sCtrlName = "Game.UI.Avg.Avg_5_PhoneCtrl"
  },
  btnMask = {},
  goChatEmpty = {},
  animChatBgEmpty = {
    sNodeName = "imgChatBgEmpty",
    sComponentName = "Animator"
  },
  animChatBgActive = {
    sNodeName = "imgChatBgActive",
    sComponentName = "Animator"
  },
  txtChatEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "Phone_Chat_None_Selection"
  }
}
PhoneChatCtrl._mapEventConfig = {
  [EventId.AvgShowNextPhoneMessage] = "OnEvent_AvgShowNextPhoneMessage",
  [EventId.AvgSelectPhoneMsgChoice] = "OnEvent_AvgSelectPhoneMsgChoice",
  [EventId.AvgSetToPhoneMsgChoiceEnd] = "OnEvent_AvgSetToPhoneMsgChoiceEnd",
  RecordChatProcessSuccess = "OnEvent_RecordChatProcessSuccess",
  ReceiveChatReward = "OnEvent_ReceiveChatReward"
}

function PhoneChatCtrl:SetChatContent(addressData, nSelectChatId, bRestart)
  local bSameChat = nSelectChatId ~= nil and nSelectChatId == self.nSelectChatId
  if bSameChat == true then
    self:RefreshChatContent(nSelectChatId, false, false, true)
    return
  end
  local sCharId = tostring(nSelectChatId):sub(1, 3)
  LocalData.SetPlayerLocalData("LastPhoneChatId" .. sCharId, nSelectChatId)
  self._mapNode.btnHistoryList.gameObject:SetActive(true)
  self._mapNode.animChatBgActive.gameObject:SetActive(true)
  self._mapNode.goChatEmpty.gameObject:SetActive(false)
  self._mapNode.animChatBgActive:Play("Phone_chaticon_in")
  self.nAddressId = addressData.nAddressId
  self:RefreshChatContent(nSelectChatId, nil, bRestart)
end

function PhoneChatCtrl:RefreshChatHistory()
  self.tbChatHistory = PlayerData.Phone:GetChatHistoryList(self.nAddressId)
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self._mapNode.chatHistoryLSV:Init(#self.tbChatHistory, self, self.OnGridRefresh, self.OnGridBtnClick)
end

function PhoneChatCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.Phone.Chat.ChatHistoryItemCtrl")
  end
  local chatData = self.tbChatHistory[nIndex]
  self.tbGridCtrl[nInstanceID]:SetData(chatData)
  if chatData.nChatId == self.nSelectChatId then
    self.tbGridCtrl[nInstanceID]:SetSelect(true)
  end
end

function PhoneChatCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local chatData = self.tbChatHistory[nIndex]
  local bSameChat = chatData.nChatId == self.nSelectChatId
  self.bHistoryOpen = false
  if not bSameChat then
    self:ResetPhone()
  end
  local sCharId = tostring(chatData.nChatId):sub(1, 3)
  LocalData.SetPlayerLocalData("LastPhoneChatId" .. sCharId, chatData.nChatId)
  self:OpenHistoryList(not bSameChat, chatData.nChatId)
end

function PhoneChatCtrl:RefreshChatContent(nSelectChatId, bReset, bRestart, bCountinue)
  local bSameChat = not bCountinue and nSelectChatId ~= nil and nSelectChatId == self.nSelectChatId
  if bSameChat == true then
    return
  end
  self.bRestart = bRestart
  if bReset and nil ~= self.nSelectChatId then
    self:ResetPhone()
  end
  self:RecordServerProcess()
  self.nSelectChatId = nSelectChatId
  self.chatData = PlayerData.Phone:GetChatData(self.nAddressId, self.nSelectChatId)
  if self.bHistoryOpen then
    self.bHistoryOpen = false
    self:OpenHistoryList()
  end
  if nil ~= self.chatData then
    if not PlayerData.Phone:EnsureChatAvgLoaded(self.chatData) then
      return
    end
    if bRestart and self.chatData.nStatus ~= AllEnum.PhoneChatState.Complete then
      self.nChatProcess = 0
      self.nInitProcess = 0
      self.tbSelection = {}
    else
      self.nChatProcess = self.chatData.nProcess
      self.nInitProcess = self.chatData.nProcess
      if self.chatData.tbSelection ~= nil then
        self.tbSelection = self.chatData.tbSelection
      end
    end
    if self.nChatProcess == 0 then
      self.nChatProcess = 1
      self:RecordProcess()
    end
    self._mapNode.goPhone:SetPhoneContacts(self.nAddressId)
    self:ResetPhone()
    self._mapNode.goPhone:_SetAutoPlayState(false)
    if self.nChatProcess > 1 then
      PlayerData.Phone:EnsureChatHistoryParsed(self.chatData)
      self:RevertHistoryList()
    else
      self:RefreshContent()
    end
  end
end

function PhoneChatCtrl:RefreshContent()
  local nCurIndex = self.nChatProcess
  local data = self.chatData.avgMsg[self.nChatProcess]
  if nil ~= data then
    local nextData = self:GetNextData(nCurIndex, data)
    local bManual
    if nextData ~= nil then
      bManual = nextData.param[1] == 1 or nextData.param[1] == 4
      self._mapNode.goPhone:_SetAutoPlayState(not bManual)
    end
    if data.cmd == "SetPhoneMsg" then
      self._mapNode.goPhone:SetPhoneMsg(data.param, false, self.nChatProcess)
      self.nMsgDuration = self._mapNode.goPhone:_CalcTextAnimDuration(data.param[3])
      self:CheckNextMessage(nCurIndex, 1)
    elseif data.cmd == "SetPhoneMsgChoiceBegin" then
      self._mapNode.goPhone:SetPhoneMsgChoiceBegin(data.param, false, self.nChatProcess)
    elseif data.cmd == "SetPhoneMsgChoiceJumpTo" then
      self._mapNode.goPhone:SetPhoneMsgChoiceJumpTo(data.param)
    elseif data.cmd == "SetPhoneMsgChoiceEnd" then
      self._mapNode.goPhone:SetPhoneMsgChoiceEnd(data.param)
    end
  end
end

function PhoneChatCtrl:CheckNextMessage(nCurProcess, index)
  while true do
    local data = self.chatData.avgMsg[nCurProcess + index]
    if data == nil then
      return
    end
    local state = self._mapNode.goPhone:GetNextDataState(data)
    if state < 0 then
      self._mapNode.goPhone:ShowNextInputingPhoneMsg(state)
      return
    elseif state == 0 then
      index = index + 1
    else
      return
    end
  end
end

function PhoneChatCtrl:RevertHistoryList()
  local selectionData = PlayerData.Phone:GetHistoryPhoneSelectionData(self.nSelectChatId, self.chatData)
  local historyData = PlayerData.Phone:GetHistoryPhoneMsgData(self.nSelectChatId, self.chatData)
  if historyData ~= nil then
    self._mapNode.goPhone:SetHistoryPhoneMsg(historyData, selectionData)
  end
  local nextData = self.chatData.avgMsg[self.nChatProcess + 1]
  local bManual
  if nextData ~= nil then
    bManual = nextData.param[1] == 1 or nextData.param[1] == 4
    self._mapNode.goPhone:_SetAutoPlayState(not bManual)
  end
  self:CheckNextMessage(self.nChatProcess, 1)
end

function PhoneChatCtrl:OpenHistoryList(bRefreshAddress, nChatId)
  self._mapNode.btnHistoryMask.gameObject:SetActive(self.bHistoryOpen)
  if self.bHistoryOpen then
    self._mapNode.goHistoryList.gameObject:SetActive(true)
    self._mapNode.animHistoryList:Play("t_window_05_t_in")
  else
    self._mapNode.animHistoryList:Play("t_window_05_t_out")
    EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
    self:AddTimer(1, 0.3, function()
      self._mapNode.goHistoryList.gameObject:SetActive(false)
      if bRefreshAddress then
        EventManager.Hit("RefreshPhoneAddress", nChatId, true)
      end
    end, true, true, true, false)
  end
  self._mapNode.btnNormal.gameObject:SetActive(not self.bHistoryOpen)
  self._mapNode.btnSelect.gameObject:SetActive(self.bHistoryOpen)
end

function PhoneChatCtrl:RecordProcess()
  if nil ~= self.chatData then
    self.nChatProcess = self.nChatProcess > self.chatData.nAllProcess and self.chatData.nAllProcess or self.nChatProcess
    if self.nChatProcess > self.chatData.nProcess and self.chatData.nStatus ~= AllEnum.PhoneChatState.Complete then
      PlayerData.Phone:RefreshChatProcess(self.nAddressId, self.nSelectChatId, self.nChatProcess, self.tbSelection)
    end
  end
end

function PhoneChatCtrl:RecordServerProcess(callback)
  if nil ~= self.chatData and self.nInitProcess ~= self.nChatProcess then
    local bEnd = self.nChatProcess >= self.chatData.nAllProcess
    if bEnd then
      self._mapNode.btnMask.gameObject:SetActive(true)
    end
    if self.bRestart then
      PlayerData.Phone:ClearHistoryPhoneMsgData(self.nSelectChatId)
    end
    PlayerData.Phone:SendChatProcess(self.nAddressId, self.nSelectChatId, self.nChatProcess, self.tbSelection, bEnd, callback)
  end
end

function PhoneChatCtrl:CheckChatComplete()
  local nNextProcess = PlayerData.Phone:GetNextProcess(self.nAddressId, self.nSelectChatId, self.nChatProcess)
  if nNextProcess >= self.chatData.nAllProcess and self.nChatProcess ~= self.nInitProcess then
    self.nChatProcess = self.chatData.nAllProcess
    self:RecordProcess()
    self:RecordServerProcess()
  end
end

function PhoneChatCtrl:ResetPhone()
  self._mapNode.goPhone:ResetPhoneMsgData()
end

function PhoneChatCtrl:GetNextData(nCurIndex, tbCurData)
  if tbCurData.cmd ~= "SetPhoneMsgChoiceJumpTo" then
    return self.chatData.avgMsg[nCurIndex + 1]
  end
  local sDataGroupID = tbCurData.param[1]
  local sIndex = tbCurData.param[2]
  local tbSelection = self._mapNode.goPhone.tbChoiceDecision[self._mapNode.goPhone.curContactsId]
  local curSelection
  for k, v in pairs(tbSelection) do
    local sCurGroupId = v.groupID
    if sCurGroupId == sDataGroupID then
      curSelection = v
      break
    end
  end
  if curSelection ~= nil then
    local sSelectedGroupId = curSelection.groupID
    local sChoiceIndex = curSelection.choiceIndex
    if sSelectedGroupId ~= nil and sSelectedGroupId == sDataGroupID and sChoiceIndex ~= nil then
      local nEndCmdId, nStartCmdId
      if sChoiceIndex == sIndex then
        nEndCmdId = PlayerData.Phone:SetPhoneMsgChoiceJumpTo(self.nSelectChatId, sSelectedGroupId, sChoiceIndex)
        nStartCmdId = PlayerData.Phone:GetAvgStartCmdId(self.nSelectChatId)
      elseif sChoiceIndex ~= sIndex then
        nEndCmdId = PlayerData.Phone:SetPhoneMsgChoiceEnd(self.nSelectChatId, sDataGroupID)
        nStartCmdId = PlayerData.Phone:GetAvgStartCmdId(self.nSelectChatId)
      end
      if nEndCmdId ~= nil and nStartCmdId ~= nil then
        local nNextIndex = nEndCmdId - nStartCmdId + 1
        return self.chatData.avgMsg[nNextIndex]
      end
    end
  end
  return self.chatData.avgMsg[nCurIndex + 1]
end

function PhoneChatCtrl:Awake()
end

function PhoneChatCtrl:OnEnable()
  self.bHistoryOpen = false
  self.tbGridCtrl = {}
  self.nChatProcess = 0
  self.nInitProcess = 0
  self.tbSelection = {}
  self.nSelectChatId = nil
  self.waitNextMsgTime = 3
  self.nContentTextInterval = 0.3
  self._mapNode.btnNormal.gameObject:SetActive(true)
  self._mapNode.btnSelect.gameObject:SetActive(false)
  self._mapNode.btnMask.gameObject:SetActive(false)
  self._mapNode.btnHistoryList.gameObject:SetActive(false)
  self._mapNode.goChatEmpty.gameObject:SetActive(true)
  self._mapNode.animChatBgEmpty:Play("Phone_chaticon_in")
  self._mapNode.animChatBgActive.gameObject:SetActive(false)
  self._mapNode.goPhone:SetPhone({0, 1})
end

function PhoneChatCtrl:OnDisable()
  self:RecordServerProcess()
  self.bHistoryOpen = false
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
  self.nChatProcess = 0
  self.nInitProcess = 0
  self.tbSelection = {}
  self.nSelectChatId = nil
  self.receiveRewardCb = nil
end

function PhoneChatCtrl:OnDestroy()
end

function PhoneChatCtrl:OnBtnClick_HistoryList()
  self.bHistoryOpen = not self.bHistoryOpen
  self:OpenHistoryList()
  self:RefreshChatHistory()
end

function PhoneChatCtrl:OnBtnClick_HistoryMask()
  self.bHistoryOpen = false
  self:OpenHistoryList()
end

function PhoneChatCtrl:OnEvent_ReceiveChatReward()
  if self.receiveRewardCb ~= nil then
    self.receiveRewardCb()
    self.receiveRewardCb = nil
  end
end

function PhoneChatCtrl:OnEvent_AvgShowNextPhoneMessage()
  if self.chatData == nil then
    return
  end
  if self.chatData.nStatus ~= AllEnum.PhoneChatState.Complete then
    self.nChatProcess = self.nChatProcess + 1
    self:RefreshContent()
    self:RecordProcess()
    self:CheckChatComplete()
  end
end

function PhoneChatCtrl:OnEvent_AvgSelectPhoneMsgChoice(groupID, choiceIndex)
  if self.nSelectChatId == nil then
    return
  end
  local nEndCmdId = PlayerData.Phone:SetPhoneMsgChoiceJumpTo(self.nSelectChatId, groupID, choiceIndex)
  local nStartCmdId = PlayerData.Phone:GetAvgStartCmdId(self.nSelectChatId)
  self.nChatProcess = nEndCmdId - nStartCmdId + 1
  table.insert(self.tbSelection, choiceIndex)
  self:RefreshContent()
  self:RecordProcess()
  self:CheckChatComplete()
end

function PhoneChatCtrl:OnEvent_AvgSetToPhoneMsgChoiceEnd(groupID, bAuto)
  if self.nSelectChatId == nil then
    return
  end
  local nEndCmdId = PlayerData.Phone:SetPhoneMsgChoiceEnd(self.nSelectChatId, groupID)
  local nStartCmdId = PlayerData.Phone:GetAvgStartCmdId(self.nSelectChatId)
  self.nChatProcess = nEndCmdId - nStartCmdId
  if self.nChatProcess >= self.chatData.nAllProcess then
    self:RecordProcess()
    self:CheckChatComplete()
  elseif bAuto then
    self.nChatProcess = self.nChatProcess + 1
    self:RefreshContent()
  else
    self._mapNode.goPhone:_SetBtnEnable(true)
  end
end

function PhoneChatCtrl:OnEvent_RecordChatProcessSuccess(mapChangeInfo)
  self.chatData = PlayerData.Phone:GetChatData(self.nAddressId, self.nSelectChatId)
  self.nChatProcess = self.chatData.nProcess
  self.nInitProcess = self.chatData.nProcess
  self.tbSelection = {}
  if self.chatData.tbSelection ~= nil then
    self.tbSelection = self.chatData.tbSelection
  end
  if self.receiveRewardCb ~= nil then
    return
  end
  if self.chatData.nStatus == AllEnum.PhoneChatState.Complete then
    local tbPlot = CacheTable.GetData("_PlotChat", self.nSelectChatId)
    local bPlotLock = true
    if nil ~= tbPlot then
      bPlotLock = PlayerData.Char:IsPlotUnlock(tbPlot.nCharId, tbPlot.nPlotId)
    end
    local bHasNewChat = PlayerData.Phone:CheckHasNewChat()
    
    local function callback()
      if not bPlotLock then
        EventManager.Hit(EventId.ClosePanel, self._panel._nPanelId)
        PlayerData.Char:EnterCharPlotAvg(tbPlot.nCharId, tbPlot.nPlotId)
      else
        PlayerData.Phone:CheckNewChat(self.nAddressId)
      end
    end
    
    if bPlotLock and (mapChangeInfo.Props == nil or #mapChangeInfo.Props < 1) then
      self._mapNode.btnMask.gameObject:SetActive(false)
    elseif mapChangeInfo.Props ~= nil and #mapChangeInfo.Props > 0 and self.receiveRewardCb == nil then
      EventManager.Hit("EnableReceiveChatReward", true)
      self._mapNode.goPhone:_SetBtnEnable(false)
      
      function self.receiveRewardCb()
        self._mapNode.btnMask.gameObject:SetActive(false)
        UTILS.OpenReceiveByChangeInfo(mapChangeInfo, callback)
        if not bHasNewChat then
          EventManager.Hit("RefreshChatRedDot")
        end
        EventManager.Hit("EnableReceiveChatReward", false)
        self._mapNode.goPhone:_SetBtnEnable(true)
      end
    end
  end
end

return PhoneChatCtrl
