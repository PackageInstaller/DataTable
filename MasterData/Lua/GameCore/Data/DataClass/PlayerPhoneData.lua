local PlayerPhoneData = class("PlayerPhoneData")
local ModuleManager = require("GameCore.Module.ModuleManager")
local LocalData = require("GameCore.Data.LocalData")
local TimerManager = require("GameCore.Timer.TimerManager")
local PHONE_AVG_PRELOAD_TIMEOUT = 2

function PlayerPhoneData:Init()
  self.tbAddressBook = {}
  self.tbChatMsgCache = {}
  self.tbPhoneMsgChoiceTarget = {}
  self.tbPhoneMsgGroupData = {}
  self.tbPhoneMsgGroupMeta = {}
  self.tbPhoneMsgMetaParsed = {}
  self.tbHistoryMsg = {}
  self.tbHistorySelection = {}
  self.tbNewChatList = {}
  self.bInitChatData = false
  self:InitCfg()
  EventManager.Add(EventId.AfterEnterMain, self, self.OnEvent_AfterEnterMain)
end

function PlayerPhoneData:InitCfg()
  local function foreachPlot(mapData)
    if mapData.ConnectChatId ~= 0 then
      local tbData = {}
      
      tbData.sAvgId = mapData.AvgId
      tbData.nCharId = mapData.Char
      tbData.nPlotId = mapData.Id
      CacheTable.SetData("_PlotChat", mapData.ConnectChatId, tbData)
    end
  end
  
  ForEachTableLine(DataTable.Plot, foreachPlot)
end

function PlayerPhoneData:CachePhoneMsgCount(msgNetData)
  if nil ~= msgNetData then
    RedDotManager.SetValid(RedDotDefine.Phone_New, nil, msgNetData.NewMessage > 0)
    local bNewValue = RedDotManager.GetValid(RedDotDefine.Phone)
    RedDotManager.SetValid(RedDotDefine.Phone_UnComplete, nil, not bNewValue and 0 < msgNetData.ProgressMessage)
  end
end

function PlayerPhoneData:GetChatState(chatData)
  if chatData.nProcess == 0 then
    return AllEnum.PhoneChatState.New
  elseif chatData.nAllProcess == nil then
    return AllEnum.PhoneChatState.UnComplete
  elseif chatData.nProcess < chatData.nAllProcess then
    return AllEnum.PhoneChatState.UnComplete
  elseif chatData.nProcess >= chatData.nAllProcess then
    return AllEnum.PhoneChatState.Complete
  end
end

function PlayerPhoneData:CreateNewChat(mapMsgData)
  local chatData = {}
  chatData.nChatId = mapMsgData.Id
  chatData.nProcess = mapMsgData.Process or 0
  chatData.tbSelection = mapMsgData.Options or {}
  chatData.bHistoryParsed = false
  local chatCfg = ConfigTable.GetData("Chat", chatData.nChatId)
  if chatCfg == nil then
    return nil
  end
  if chatData.nProcess > 0 then
    if not self:EnsureChatAvgMetaLoaded(chatData) then
      return nil
    end
  else
    chatData.nStatus = self:GetChatState(chatData)
  end
  return chatData
end

function PlayerPhoneData:RefreshAddressStatus(nAddressId)
  local addressData = self.tbAddressBook[nAddressId]
  if nil ~= addressData then
    local bNew = false
    local bUnComplete = false
    for _, chat in pairs(addressData.tbChatList) do
      if chat.nStatus == AllEnum.PhoneChatState.UnComplete then
        bUnComplete = true
        break
      elseif chat.nStatus == AllEnum.PhoneChatState.New then
        bNew = true
      end
    end
    if bUnComplete then
      addressData.nStatus = AllEnum.PhoneChatState.UnComplete
    elseif bNew then
      addressData.nStatus = AllEnum.PhoneChatState.New
    else
      addressData.nStatus = AllEnum.PhoneChatState.Complete
    end
  end
end

function PlayerPhoneData:CacheAddressBookData(msgNetData)
  self.bInitChatData = true
  for _, v in ipairs(msgNetData) do
    local mapChar = ConfigTable.GetData_Character(v.CharId)
    if mapChar ~= nil and mapChar.Visible then
      if nil == self.tbAddressBook[v.CharId] then
        self.tbAddressBook[v.CharId] = {}
      end
      local tbChatList = {}
      for _, chat in ipairs(v.Chats) do
        local chatData = self:CreateNewChat(chat)
        if nil ~= chatData then
          tbChatList[chat.Id] = chatData
        end
      end
      self.tbAddressBook[v.CharId].tbChatList = tbChatList
      self.tbAddressBook[v.CharId].nTime = v.TriggerTime
      self.tbAddressBook[v.CharId].bTop = v.Top
      self.tbAddressBook[v.CharId].nOptTime = 0
      if v.nOptTime ~= nil then
        self.tbAddressBook[v.CharId].nOptTime = v.nOptTime
      end
      self:RefreshAddressStatus(v.CharId)
    end
  end
  self:RefreshRedDot()
end

function PlayerPhoneData:RefreshChatProcess(nAddressId, nChatId, nProcess, tbSelection)
  local addressData = self.tbAddressBook[nAddressId]
  if nil ~= addressData then
    local tbChatList = addressData.tbChatList
    if nil ~= tbChatList[nChatId] then
      local chatData = tbChatList[nChatId]
      local lastProcess = chatData.nProcess
      chatData.nProcess = nProcess
      if nil ~= tbSelection then
        chatData.tbSelection = tbSelection
        self:EnsureChatAvgLoaded(chatData)
        local data = chatData.avgMsg and chatData.avgMsg[lastProcess]
        if data ~= nil and data.cmd == "SetPhoneMsgChoiceBegin" then
          local nGroupId = tonumber(data.param[1]) or 0
          if nGroupId == #tbSelection then
            if self.tbHistorySelection[nChatId] == nil then
              self.tbHistorySelection[nChatId] = {}
            else
              for k, v in pairs(self.tbHistorySelection[nChatId]) do
                if v.groupID == data.param[1] then
                  table.remove(self.tbHistorySelection[nChatId], k)
                  break
                end
              end
            end
            local dataSelection = {
              groupID = data.param[1],
              choiceIndex = tostring(tbSelection[#tbSelection])
            }
            table.insert(self.tbHistorySelection[nChatId], dataSelection)
          end
        end
      end
      chatData.nStatus = self:GetChatState(chatData)
      chatData.bHistoryParsed = false
      self:ClearHistoryPhoneMsgData(nChatId)
    end
    self:RefreshAddressStatus(nAddressId)
  end
  self:RefreshRedDot()
end

function PlayerPhoneData:NewChatTrigger(mapMsgData)
  local nChatId = mapMsgData.Value
  local tbData = {
    Id = nChatId,
    Options = {},
    Process = 0
  }
  local chatCfg = ConfigTable.GetData("Chat", nChatId)
  if nil ~= chatCfg then
    local nAddressId = chatCfg.AddressBookId
    local mapChar = ConfigTable.GetData_Character(nAddressId)
    if mapChar ~= nil and mapChar.Visible then
      if nil == self.tbAddressBook[nAddressId] then
        self.tbAddressBook[nAddressId] = {}
        self.tbAddressBook[nAddressId].tbChatList = {}
      end
      local chatData = self:CreateNewChat(tbData)
      if nil ~= chatData then
        self.tbAddressBook[nAddressId].tbChatList[nChatId] = chatData
      end
      self.tbAddressBook[nAddressId].nTime = CS.ClientManager.Instance.serverTimeStampWithTimeZone
      self:RefreshAddressStatus(nAddressId)
      self:RefreshRedDot()
      local sCurModule = ModuleManager.GetCurModuleName()
      local bInGacha = PanelManager.CheckPanelOpen(PanelId.GachaSpin)
      local bPhoneOpen = PanelManager.CheckPanelOpen(PanelId.Phone)
      local bAffinityPanelOpen = PanelManager.CheckPanelOpen(PanelId.CharBgPanel)
      if bAffinityPanelOpen or bPhoneOpen or sCurModule ~= "MainMenuModuleScene" or bInGacha then
        local tbData = {
          nAddressId = nAddressId,
          nChatId = nChatId,
          nSortId = chatCfg.Priority
        }
        table.insert(self.tbNewChatList, tbData)
      elseif chatCfg.AutoPopUp then
        PopUpManager.PopUpEnQueue(GameEnum.PopUpSeqType.NewChat, nChatId)
      end
    end
  end
end

function PlayerPhoneData:PhoneContactReportSuc(mapMsgData)
  if nil ~= mapMsgData and nil ~= mapMsgData then
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  end
  EventManager.Hit("RecordChatProcessSuccess", mapMsgData)
end

function PlayerPhoneData:GetAddressBookList()
  local tbSortList = {}
  for addressId, v in pairs(self.tbAddressBook) do
    local tbChatList = {}
    for _, chat in pairs(v.tbChatList) do
      table.insert(tbChatList, chat)
    end
    if 0 < #tbChatList then
      local lastChat = LocalData.GetPlayerLocalData("LastPhoneChatId" .. addressId)
      table.sort(tbChatList, function(a, b)
        if a.nChatId == lastChat and a.nStatus == AllEnum.PhoneChatState.UnComplete then
          return true
        elseif b.nChatId == lastChat and b.nStatus == AllEnum.PhoneChatState.UnComplete then
          return false
        end
        if a.nStatus == b.nStatus then
          return a.nChatId > b.nChatId
        end
        return a.nStatus > b.nStatus
      end)
      local tbData = {
        nAddressId = addressId,
        tbChatList = tbChatList,
        nTime = v.nTime,
        nStatus = v.nStatus,
        bTop = v.bTop,
        nOptTime = v.nOptTime
      }
      table.insert(tbSortList, tbData)
    end
  end
  table.sort(tbSortList, function(a, b)
    if a.bTop and b.bTop then
      return a.nOptTime > b.nOptTime
    elseif not a.bTop and not b.bTop then
      if a.nStatus == b.nStatus then
        if a.nTime == b.nTime then
          return a.nAddressId < b.nAddressId
        end
        return a.nTime > b.nTime
      end
      return a.nStatus > b.nStatus
    end
    return a.bTop
  end)
  return tbSortList
end

function PlayerPhoneData:GetAddressBookData(nAddressId)
  if nil ~= self.tbAddressBook[nAddressId] then
    local addressData = self.tbAddressBook[nAddressId]
    return {
      nAddressId = nAddressId,
      tbChatList = addressData.tbChatList,
      nTime = addressData.nTime,
      nStatus = addressData.nStatus,
      bTop = addressData.bTop
    }
  end
end

function PlayerPhoneData:GetChatHistoryList(nAddressId)
  local tbSortChatList = {}
  if nil ~= self.tbAddressBook[nAddressId] then
    local tbChatList = self.tbAddressBook[nAddressId].tbChatList
    for _, v in pairs(tbChatList) do
      table.insert(tbSortChatList, v)
    end
    table.sort(tbSortChatList, function(a, b)
      if a.nStatus == b.nStatus then
        return a.nChatId > b.nChatId
      end
      return a.nStatus < b.nStatus
    end)
  else
    printError(string.format("获取聊天信息失败！！！addressId = [%s]", nAddressId))
  end
  return tbSortChatList
end

function PlayerPhoneData:GetChatData(nAddressId, nChatId)
  if nil ~= self.tbAddressBook[nAddressId] then
    local tbChatList = self.tbAddressBook[nAddressId].tbChatList
    if nil ~= tbChatList[nChatId] then
      return tbChatList[nChatId]
    end
  end
  traceback(string.format("获取聊天信息失败！！！addressId = [%s], chatId = [%s]", nAddressId, nChatId))
end

function PlayerPhoneData:RefreshRedDot()
  RedDotManager.SetValid(RedDotDefine.Phone_New, nil, false)
  RedDotManager.SetValid(RedDotDefine.Phone_UnComplete, nil, false)
  local bUnComplete = false
  for addressId, v in pairs(self.tbAddressBook) do
    RedDotManager.SetValid(RedDotDefine.Phone_New_Item, addressId, v.nStatus == AllEnum.PhoneChatState.New)
    bUnComplete = bUnComplete or v.nStatus == AllEnum.PhoneChatState.UnComplete
    RedDotManager.SetValid(RedDotDefine.Phone_UnComplete_Item, addressId, v.nStatus == AllEnum.PhoneChatState.UnComplete)
  end
  local bNew = RedDotManager.GetValid(RedDotDefine.Phone)
  RedDotManager.SetValid(RedDotDefine.Phone_UnComplete, nil, not bNew and bUnComplete)
end

function PlayerPhoneData:TrySendAddressListReq(callback)
  if not self.bInitChatData then
    self:SendAddressListReq(callback)
  elseif nil ~= callback then
    callback()
  end
end

function PlayerPhoneData:OpenPhonePanel(openCall, nTog)
  local function callback()
    local bChat = false
    
    for _, v in pairs(self.tbAddressBook) do
      for _, chat in pairs(v.tbChatList) do
        bChat = true
        break
      end
    end
    if not bChat then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Phone_Chat_Empty"))
    else
      if nil ~= openCall then
        openCall()
      end
      EventManager.Hit(EventId.OpenPanel, PanelId.Phone, nTog)
    end
  end
  
  self:TrySendAddressListReq(callback)
end

function PlayerPhoneData:CheckHasNewChat()
  return #self.tbNewChatList > 0
end

function PlayerPhoneData:CheckNewChat(nAddressId, callback)
  local bNewChat = false
  table.sort(self.tbNewChatList, function(a, b)
    if a.nSortId == b.nSortId then
      return a.nChatId < b.nChatId
    end
    return a.nSortId > b.nSortId
  end)
  if #self.tbNewChatList > 0 then
    bNewChat = true
    local tbData = self.tbNewChatList[#self.tbNewChatList]
    local chatCfg = ConfigTable.GetData("Chat", tbData.nChatId)
    local bPhoneOpen = PanelManager.CheckPanelOpen(PanelId.Phone)
    if chatCfg ~= nil then
      if chatCfg.AutoPopUp and not bPhoneOpen then
        PopUpManager.PopUpEnQueue(GameEnum.PopUpSeqType.NewChat, tbData.nChatId)
        if nil ~= callback then
          callback()
        end
      else
        self:RefreshRedDot()
        EventManager.Hit("NewChatTrigger", tbData.nAddressId, tbData.nChatId)
        if nil ~= callback then
          callback()
        end
      end
    end
  elseif nAddressId ~= nil then
    local tbHistoryChat = self:GetChatHistoryList(nAddressId)
    local tbNewChat = {}
    for k, v in pairs(tbHistoryChat) do
      if v.nStatus == AllEnum.PhoneChatState.New then
        table.insert(tbNewChat, v)
      end
    end
    if #tbNewChat < 1 then
      for k, v in pairs(tbHistoryChat) do
        if v.nStatus == AllEnum.PhoneChatState.UnComplete then
          table.insert(tbNewChat, v)
        end
      end
    end
    if 0 < #tbNewChat then
      self:RefreshRedDot()
      EventManager.Hit("NewChatTrigger", nAddressId, tbNewChat[1].nChatId)
    end
    if nil ~= callback then
      callback()
    end
  elseif nil ~= callback then
    callback()
  end
  self.tbNewChatList = {}
  return bNewChat
end

function PlayerPhoneData:GetNextProcess(nAddressId, nChatId, nProcess)
  local chatData = self:GetChatData(nAddressId, nChatId)
  if not self:EnsureChatAvgLoaded(chatData) then
    return nProcess
  end
  local nNextProcess = nProcess
  local tbMsg = chatData.avgMsg[nNextProcess]
  if nil ~= tbMsg and tbMsg.cmd == "SetPhoneMsgChoiceJumpTo" then
    local chatCfg = ConfigTable.GetData("Chat", nChatId)
    if chatCfg ~= nil then
      local sGroupId = tbMsg.param[1]
      local tbData = self.tbPhoneMsgChoiceTarget[chatCfg.AVGId .. chatCfg.AVGGroupId][sGroupId]
      if nNextProcess > tbData.nBeginCmdId then
        nNextProcess = self:SetPhoneMsgChoiceEnd(nChatId, sGroupId)
      end
    end
  end
  return nNextProcess > chatData.nAllProcess and chatData.nAllProcess or nNextProcess
end

function PlayerPhoneData:CheckChatComplete(nChatId)
  local chatCfg = ConfigTable.GetData("Chat", nChatId)
  if nil ~= chatCfg then
    local nAddressId = chatCfg.AddressBookId
    local dataAddress = self.tbAddressBook[nAddressId]
    if nil ~= dataAddress and nil ~= dataAddress.tbChatList then
      local chatData = dataAddress.tbChatList[nChatId]
      if self:EnsureChatAvgMetaLoaded(chatData) then
        return chatData.nProcess >= chatData.nAllProcess
      end
    end
  end
  printError(string.format("聊天未解锁，请检查配置！！chatId = [%s])", nChatId))
  return true
end

function PlayerPhoneData:ParseAvgContactsData()
  local nCurLanguageIdx = GetLanguageIndex(Settings.sCurrentTxtLanguage)
  self.sAvgContactsPath = GetAvgLuaRequireRoot(nCurLanguageIdx) .. "Preset/AvgContacts"
  local tbContacts = require(self.sAvgContactsPath)
  self.tbAvgContacts = {}
  for i, v in ipairs(tbContacts) do
    self.tbAvgContacts[v.id] = {
      name = v.name,
      signature = ProcAvgTextContent(v.signature),
      landmark = ProcAvgTextContent(v.landmark),
      icon = v.icon
    }
  end
end

function PlayerPhoneData:GetAvgContactsData(sContactsId)
  if self.tbAvgContacts == nil then
    self:ParseAvgContactsData()
  end
  local tbContacts = self.tbAvgContacts[sContactsId]
  if tbContacts == nil then
    return nil
  else
    return tbContacts
  end
end

function PlayerPhoneData:GetAVGPhoneMsg(nChatId, sLanguage)
  local chatCfg = ConfigTable.GetData("Chat", nChatId)
  if nil ~= chatCfg then
    local sAvgCfgPath = self:GetAVGPhoneCfgPath(chatCfg, sLanguage)
    if nil == self.tbChatMsgCache[sAvgCfgPath] then
      local tbAllAvgCfg = self:LoadAVGPhoneCfg(chatCfg, sLanguage)
      if tbAllAvgCfg ~= nil then
        self.tbChatMsgCache[sAvgCfgPath] = {}
        local sMsgGroup
        for i, v in ipairs(tbAllAvgCfg) do
          if v.cmd == "SetGroupId" then
            sMsgGroup = v.param[1]
            self.tbChatMsgCache[sAvgCfgPath][sMsgGroup] = {}
            self.tbPhoneMsgGroupData[chatCfg.AVGId .. sMsgGroup] = {}
            self.tbPhoneMsgGroupData[chatCfg.AVGId .. sMsgGroup].nStartCmdId = i
            self.tbPhoneMsgGroupMeta[chatCfg.AVGId .. sMsgGroup] = {nStartCmdId = i, nAllProcess = 0}
          elseif v.cmd ~= "End" then
            table.insert(self.tbChatMsgCache[sAvgCfgPath][sMsgGroup], v)
            local tbMeta = self.tbPhoneMsgGroupMeta[chatCfg.AVGId .. sMsgGroup]
            if tbMeta ~= nil then
              tbMeta.nAllProcess = tbMeta.nAllProcess + 1
            end
            if v.cmd == "SetPhoneMsgChoiceBegin" then
              if self.tbPhoneMsgChoiceTarget[chatCfg.AVGId .. sMsgGroup] == nil then
                self.tbPhoneMsgChoiceTarget[chatCfg.AVGId .. sMsgGroup] = {}
              end
              local sChoiceGroup = v.param[1]
              if self.tbPhoneMsgChoiceTarget[chatCfg.AVGId .. sMsgGroup][sChoiceGroup] == nil then
                self.tbPhoneMsgChoiceTarget[chatCfg.AVGId .. sMsgGroup][sChoiceGroup] = {
                  nBeginCmdId = 0,
                  nEndCmdId = 0,
                  tbTargetCmdId = {}
                }
              end
              self.tbPhoneMsgChoiceTarget[chatCfg.AVGId .. sMsgGroup][sChoiceGroup].nBeginCmdId = i
            elseif v.cmd == "SetPhoneMsgChoiceJumpTo" then
              if self.tbPhoneMsgChoiceTarget[chatCfg.AVGId .. sMsgGroup] == nil then
                self.tbPhoneMsgChoiceTarget[chatCfg.AVGId .. sMsgGroup] = {}
              end
              local sChoiceGroup = v.param[1]
              local nIndex = v.param[2]
              if self.tbPhoneMsgChoiceTarget[chatCfg.AVGId .. sMsgGroup][sChoiceGroup] == nil then
                self.tbPhoneMsgChoiceTarget[chatCfg.AVGId .. sMsgGroup][sChoiceGroup] = {
                  nBeginCmdId = 0,
                  nEndCmdId = 0,
                  tbTargetCmdId = {}
                }
              end
              self.tbPhoneMsgChoiceTarget[chatCfg.AVGId .. sMsgGroup][sChoiceGroup].tbTargetCmdId[nIndex] = i
            elseif v.cmd == "SetPhoneMsgChoiceEnd" then
              if self.tbPhoneMsgChoiceTarget[chatCfg.AVGId .. sMsgGroup] == nil then
                self.tbPhoneMsgChoiceTarget[chatCfg.AVGId .. sMsgGroup] = {}
              end
              local sChoiceGroup = v.param[1]
              if self.tbPhoneMsgChoiceTarget[chatCfg.AVGId .. sMsgGroup][sChoiceGroup] == nil then
                self.tbPhoneMsgChoiceTarget[chatCfg.AVGId .. sMsgGroup][sChoiceGroup] = {
                  nBeginCmdId = 0,
                  nEndCmdId = 0,
                  tbTargetCmdId = {}
                }
              end
              self.tbPhoneMsgChoiceTarget[chatCfg.AVGId .. sMsgGroup][sChoiceGroup].nEndCmdId = i
            end
          end
        end
        self.tbPhoneMsgMetaParsed[sAvgCfgPath] = true
      end
    end
    if nil ~= self.tbChatMsgCache[sAvgCfgPath] then
      return self.tbChatMsgCache[sAvgCfgPath][chatCfg.AVGGroupId]
    end
  end
end

function PlayerPhoneData:GetAVGPhoneCfgPath(chatCfg, sLanguage)
  if chatCfg == nil then
    return nil
  end
  if sLanguage == nil then
    sLanguage = Settings.sCurrentTxtLanguage
  end
  local nCurLanguageIdx = GetLanguageIndex(sLanguage)
  return GetAvgLuaRequireRoot(nCurLanguageIdx) .. "Config/" .. chatCfg.AVGId
end

function PlayerPhoneData:LoadAVGPhoneCfg(chatCfg, sLanguage)
  local sAvgCfgPath = self:GetAVGPhoneCfgPath(chatCfg, sLanguage)
  if sAvgCfgPath == nil then
    return nil
  end
  local ok, tbAllAvgCfg = pcall(require, sAvgCfgPath)
  if not ok then
    printError("AvgId对应的配置文件没有找到，path：" .. sAvgCfgPath .. ". error: " .. tbAllAvgCfg)
    return nil
  end
  return tbAllAvgCfg, sAvgCfgPath
end

function PlayerPhoneData:ParseAVGPhoneMeta(chatCfg, sLanguage)
  local tbAllAvgCfg, sAvgCfgPath = self:LoadAVGPhoneCfg(chatCfg, sLanguage)
  if tbAllAvgCfg == nil then
    return nil
  end
  if self.tbPhoneMsgMetaParsed[sAvgCfgPath] then
    return sAvgCfgPath
  end
  local sMsgGroup
  for i, v in ipairs(tbAllAvgCfg) do
    if v.cmd == "SetGroupId" then
      sMsgGroup = v.param[1]
      local sKey = chatCfg.AVGId .. sMsgGroup
      self.tbPhoneMsgGroupMeta[sKey] = {nStartCmdId = i, nAllProcess = 0}
    elseif v.cmd ~= "End" and sMsgGroup ~= nil then
      local sKey = chatCfg.AVGId .. sMsgGroup
      local tbMeta = self.tbPhoneMsgGroupMeta[sKey]
      if tbMeta ~= nil then
        tbMeta.nAllProcess = tbMeta.nAllProcess + 1
      end
    end
  end
  self.tbPhoneMsgMetaParsed[sAvgCfgPath] = true
  return sAvgCfgPath
end

function PlayerPhoneData:GetAVGPhoneMsgMeta(nChatId, sLanguage)
  local chatCfg = ConfigTable.GetData("Chat", nChatId)
  if chatCfg ~= nil then
    local sKey = chatCfg.AVGId .. chatCfg.AVGGroupId
    if self.tbPhoneMsgGroupMeta[sKey] == nil then
      self:ParseAVGPhoneMeta(chatCfg, sLanguage)
    end
    return self.tbPhoneMsgGroupMeta[sKey]
  end
end

function PlayerPhoneData:EnsureChatAvgMetaLoaded(chatData)
  if chatData == nil then
    return false
  end
  if chatData.nAllProcess ~= nil then
    return true
  end
  local tbMeta = self:GetAVGPhoneMsgMeta(chatData.nChatId)
  if tbMeta == nil then
    return false
  end
  chatData.nAllProcess = tbMeta.nAllProcess
  chatData.nStatus = self:GetChatState(chatData)
  return true
end

function PlayerPhoneData:EnsureChatAvgLoaded(chatData)
  if chatData == nil then
    return false
  end
  if chatData.avgMsg ~= nil then
    return true
  end
  chatData.avgMsg = self:GetAVGPhoneMsg(chatData.nChatId)
  if chatData.avgMsg == nil then
    return false
  end
  chatData.nAllProcess = #chatData.avgMsg
  chatData.nStatus = self:GetChatState(chatData)
  return true
end

function PlayerPhoneData:ParseAvgHistoryPhoneMsgData(nChatId, tbMsgData, nProcess, tbSelection)
  self:ClearHistoryPhoneMsgData(nChatId)
  if nil ~= tbMsgData then
    local choiceCount = 0
    local sCurChoiceIndex = "0"
    local sCurGroupId = "0"
    local bFindChoice = false
    local bStartChoice = false
    for i, v in ipairs(tbMsgData) do
      if i <= nProcess then
        if v.cmd == "SetPhoneMsg" then
          if bStartChoice then
            if bFindChoice then
              local data = {
                cmd = v.cmd,
                param = v.param,
                process = i
              }
              table.insert(self.tbHistoryMsg[nChatId], data)
            end
          else
            local data = {
              cmd = v.cmd,
              param = v.param,
              process = i
            }
            table.insert(self.tbHistoryMsg[nChatId], data)
          end
        elseif v.cmd == "SetPhoneMsgChoiceBegin" then
          if tbSelection ~= nil and choiceCount < #tbSelection then
            choiceCount = choiceCount + 1
            sCurChoiceIndex = tostring(tbSelection[choiceCount])
            sCurGroupId = v.param[1] or "0"
            bStartChoice = true
          elseif i == nProcess then
            local data = {
              cmd = v.cmd,
              param = v.param,
              process = i
            }
            table.insert(self.tbHistoryMsg[nChatId], data)
          end
        elseif v.cmd == "SetPhoneMsgChoiceJumpTo" then
          local sGroupId = v.param[1]
          if sGroupId == sCurGroupId then
            local sIndex = v.param[2]
            if sIndex == sCurChoiceIndex then
              bFindChoice = true
              local dataSelection = {groupID = sCurGroupId, choiceIndex = sIndex}
              table.insert(self.tbHistorySelection[nChatId], dataSelection)
            else
              bFindChoice = false
            end
          end
        elseif v.cmd == "SetPhoneMsgChoiceEnd" then
          bFindChoice = false
          bStartChoice = false
        end
      else
        break
      end
    end
  end
end

function PlayerPhoneData:EnsureChatHistoryParsed(chatData)
  if chatData == nil then
    return
  end
  if chatData.bHistoryParsed == true then
    return
  end
  if not self:EnsureChatAvgLoaded(chatData) then
    return
  end
  if chatData.nProcess ~= nil and chatData.nProcess > 0 then
    self:ParseAvgHistoryPhoneMsgData(chatData.nChatId, chatData.avgMsg, chatData.nProcess, chatData.tbSelection)
  else
    self:ClearHistoryPhoneMsgData(chatData.nChatId)
  end
  chatData.bHistoryParsed = true
end

function PlayerPhoneData:GetAvgStartCmdId(nChatId)
  local chatCfg = ConfigTable.GetData("Chat", nChatId)
  if chatCfg ~= nil then
    local sKey = chatCfg.AVGId .. chatCfg.AVGGroupId
    local tbData = self.tbPhoneMsgGroupData[sKey]
    if tbData == nil then
      tbData = self:GetAVGPhoneMsgMeta(nChatId)
    end
    if tbData ~= nil then
      return tbData.nStartCmdId
    end
  end
end

function PlayerPhoneData:ClearHistoryPhoneMsgData(nChatId)
  self.tbHistoryMsg[nChatId] = {}
  self.tbHistorySelection[nChatId] = {}
end

function PlayerPhoneData:UpdateHistoryPhoneMsgData(nChatId, tbMsgData, nProcess)
  if self.tbHistoryMsg[nChatId] == nil then
    self.tbHistoryMsg[nChatId] = {}
    local data = {
      cmd = tbMsgData.cmd,
      param = tbMsgData.param,
      process = nProcess
    }
    table.insert(self.tbHistoryMsg[nChatId], data)
    return
  end
  if nProcess <= self.tbHistoryMsg[nChatId][#self.tbHistoryMsg[nChatId]].process then
    return
  end
  if tbMsgData.cmd ~= "SetPhoneMsg" and tbMsgData.cmd ~= "SetPhoneMsgChoiceBegin" then
    return
  end
  local lastData = self.tbHistoryMsg[nChatId][#self.tbHistoryMsg[nChatId]]
  if lastData.cmd == "SetPhoneMsgChoiceBegin" then
    table.remove(self.tbHistoryMsg[nChatId], #self.tbHistoryMsg[nChatId])
  end
  local data = {
    cmd = tbMsgData.cmd,
    param = tbMsgData.param,
    process = nProcess
  }
  table.insert(self.tbHistoryMsg[nChatId], data)
end

function PlayerPhoneData:GetHistoryPhoneMsgData(nChatId, chatData)
  if chatData ~= nil then
    self:EnsureChatHistoryParsed(chatData)
  end
  if self.tbHistoryMsg[nChatId] == nil then
    self.tbHistoryMsg[nChatId] = {}
  end
  return self.tbHistoryMsg[nChatId]
end

function PlayerPhoneData:GetHistoryPhoneSelectionData(nChatId, chatData)
  if chatData ~= nil then
    self:EnsureChatHistoryParsed(chatData)
  end
  if self.tbHistorySelection[nChatId] == nil then
    self.tbHistorySelection[nChatId] = {}
  end
  return self.tbHistorySelection[nChatId]
end

function PlayerPhoneData:PreloadAllAddressBookChatAvg()
  for _, addressData in pairs(self.tbAddressBook) do
    if addressData.tbChatList ~= nil then
      for _, chatData in pairs(addressData.tbChatList) do
        self:EnsureChatAvgLoaded(chatData)
      end
    end
  end
end

function PlayerPhoneData:PreloadPhoneAvgDataBeforeMain(callback)
  if CS.ClientManager.Instance:GetMemoryType() then
    if callback ~= nil then
      callback()
    end
    return
  end
  local bCallbackDone = false
  local timerTimeout
  
  local function func_Done()
    if bCallbackDone then
      return
    end
    bCallbackDone = true
    if timerTimeout ~= nil then
      TimerManager.Remove(timerTimeout, false)
      timerTimeout = nil
    end
    if self.bInitChatData then
      self:PreloadAllAddressBookChatAvg()
    end
    if callback ~= nil then
      callback()
    end
  end
  
  if self.bInitChatData then
    func_Done()
    return
  end
  timerTimeout = TimerManager.Add(1, PHONE_AVG_PRELOAD_TIMEOUT, self, func_Done, true, true, true, nil)
  self:SendAddressListReq(func_Done)
end

function PlayerPhoneData:GetChatMsg(chatData, nIndex)
  self:EnsureChatAvgLoaded(chatData)
  local avgGroupMsg = chatData.avgMsg
  if nil ~= avgGroupMsg then
    if nIndex == 1 then
      return avgGroupMsg[nIndex]
    else
      self:EnsureChatHistoryParsed(chatData)
      local tbChatList = self.tbHistoryMsg[chatData.nChatId]
      if tbChatList ~= nil then
        return tbChatList[#tbChatList]
      end
    end
  end
end

function PlayerPhoneData:GetChatContent(chatData, nIndex)
  self:EnsureChatAvgLoaded(chatData)
  local avgGroupMsg = chatData.avgMsg
  if nil ~= avgGroupMsg then
    local tbAvgMsg = avgGroupMsg[nIndex]
    if nIndex == 1 then
      return ProcAvgTextContent(tbAvgMsg.param[3], GetLanguageIndex(Settings.sCurrentTxtLanguage))
    else
      self:EnsureChatHistoryParsed(chatData)
      local tbChatList = self.tbHistoryMsg[chatData.nChatId]
      local historyChatData = tbChatList and tbChatList[#tbChatList]
      if historyChatData ~= nil then
        return ProcAvgTextContent(historyChatData.param[3], GetLanguageIndex(Settings.sCurrentTxtLanguage))
      end
    end
  end
end

function PlayerPhoneData:SetPhoneMsgChoiceJumpTo(nChatId, nGroupId, nIndex)
  local chatCfg = ConfigTable.GetData("Chat", nChatId)
  if chatCfg ~= nil then
    local tbData = self.tbPhoneMsgChoiceTarget[chatCfg.AVGId .. chatCfg.AVGGroupId][tostring(nGroupId)]
    if tbData ~= nil then
      return tbData.tbTargetCmdId[tostring(nIndex)]
    end
  end
end

function PlayerPhoneData:SetPhoneMsgChoiceEnd(nChatId, nGroupId)
  local chatCfg = ConfigTable.GetData("Chat", nChatId)
  if chatCfg ~= nil then
    nGroupId = tostring(nGroupId)
    local tbData = self.tbPhoneMsgChoiceTarget[chatCfg.AVGId .. chatCfg.AVGGroupId][nGroupId]
    if tbData ~= nil then
      return tbData.nEndCmdId
    end
  end
end

function PlayerPhoneData:GetTopCount()
  local nTopCount = 0
  for k, v in pairs(self.tbAddressBook) do
    if v.bTop then
      nTopCount = nTopCount + 1
    end
  end
  return nTopCount
end

function PlayerPhoneData:SetPhoneTopStatus(nAddressId, bTop)
  local function callback(...)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.phone_contacts_top_req, {Value = nAddressId}, nil, callback)
  self.tbAddressBook[nAddressId].bTop = bTop
  if bTop then
    self.tbAddressBook[nAddressId].nOptTime = CS.ClientManager.Instance.serverTimeStampWithTimeZone
  end
end

function PlayerPhoneData:SendAddressListReq(callback)
  HttpNetHandler.SendMsg(NetMsgId.Id.phone_contacts_info_req, {}, nil, callback)
end

function PlayerPhoneData:SendChatProcess(nAddressId, nChatId, nProcess, tbSelection, bEnd, callback)
  local function httpCall(mapMsgData)
    self:RefreshChatProcess(nAddressId, nChatId, nProcess, tbSelection)
    
    if nil ~= callback then
      callback()
    end
  end
  
  local netMsg = {
    ChatId = nChatId,
    Options = tbSelection,
    Process = nProcess,
    End = bEnd
  }
  HttpNetHandler.SendMsg(NetMsgId.Id.phone_contacts_report_req, netMsg, nil, httpCall)
end

function PlayerPhoneData:OnEvent_AfterEnterMain()
end

return PlayerPhoneData
