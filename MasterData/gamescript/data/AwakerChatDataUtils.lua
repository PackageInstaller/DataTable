local AwakerChatDataUtils = {}
local communicateData = DataCenter.communicateData

function AwakerChatDataUtils.ResetAll()
  communicateData.currList = {}
  communicateData.completeList = {}
  communicateData.dialogs = {}
  communicateData.isCurrListDirty = false
  communicateData.completedDialogCount = 0
  MobileFileDataManager.Instance:SetCommFileValue("AvgComTest", nil, true)
end

function AwakerChatDataUtils.OnNewDialog(data)
  if data.dialogID then
    if not table.contains(communicateData.currList, data.dialogID) then
      table.insert(communicateData.currList, data.dialogID)
    end
    communicateData.dialogs[data.dialogID] = {
      dialogId = data.dialogID,
      history = {},
      isCompleted = false,
      pushedTime = data.pushedTime,
      completedTime = 0
    }
    communicateData.isCurrListDirty = true
  end
end

function AwakerChatDataUtils.InsertServerData(data)
  for dialogId, dialogInfo in pairs(data) do
    communicateData.dialogs[dialogId] = {
      dialogId = dialogId,
      history = dialogInfo.history,
      isCompleted = 0 ~= (dialogInfo.completedTime or 0),
      completedTime = dialogInfo.completedTime
    }
  end
end

function AwakerChatDataUtils.IsGmTest()
  do return MobileFileDataManager.Instance.GetCommFileValue, MobileFileDataManager.Instance end
  return MobileFileDataManager.Instance.GetCommFileValue, MobileFileDataManager.Instance, "AvgComTest"
end

function AwakerChatDataUtils.ReqCurrentDialogs(callback)
  if AwakerChatDataUtils.IsGmTest() then
    if callback then
      callback()
    end
    return
  end
  ProtoManager.Instance:ReqServer("AvgCommunicateRequest", "OnGetCurrentDialogInfos", function(data)
    communicateData.completedDialogCount = data.completedDialogCount or 0
    local dialogInfos = data.dialogInfos or {}
    communicateData.isCurrListDirty = false
    local currList = {}
    for dialogId, dialogInfo in pairs(dialogInfos) do
      local isValidChat = AwakerChatDataUtils.IsValidChat(dialogId)
      if isValidChat then
        currList[dialogId] = dialogInfo
      end
    end
    communicateData.currList = table.keys(currList)
    AwakerChatDataUtils.InsertServerData(currList)
    if callback then
      callback()
    end
  end)
end

function AwakerChatDataUtils.ReqCompletedDialogs(callback)
  if AwakerChatDataUtils.IsGmTest() then
    if callback then
      callback()
    end
    return
  end
  ProtoManager.Instance:ReqServer("AvgCommunicateRequest", "OnGetCompletedDialogInfos", function(data)
    local dialogInfos = data.dialogInfos or {}
    communicateData.completeList = table.keys(dialogInfos)
    AwakerChatDataUtils.InsertServerData(dialogInfos)
    if callback then
      callback()
    end
  end)
end

function AwakerChatDataUtils.OpenCurrentMessagePanel()
  if not communicateData.isCurrListDirty and table.next(communicateData.currList) then
    UIManager.Instance:Reopen(Urls.AwakerMessageListPanel)
    return
  end
  AwakerChatDataUtils.ReqCurrentDialogs(function()
    UIManager.Instance:Reopen(Urls.AwakerMessageListPanel)
  end)
end

function AwakerChatDataUtils.OpenMainChatPanel()
  AwakerChatDataUtils.ReqCompletedDialogs(function()
    UIManager.Instance:Reopen(Urls.AwakerChatMainPanel)
  end)
end

function AwakerChatDataUtils.OnSendMessage(dialogId, history)
  if AwakerChatDataUtils.IsGmTest() then
    return
  end
  ProtoManager.Instance:ReqServer("AvgCommunicateRequest", "OnSendMessage", function(data)
    local dialog = communicateData.dialogs[dialogId]
    if dialog then
      dialog.history = history
    end
  end, nil, dialogId, history)
end

function AwakerChatDataUtils.OnDialogFinish(dialogId)
  if AwakerChatDataUtils.IsGmTest() then
    return
  end
  local dialog = communicateData.dialogs[dialogId]
  if dialog and dialog.isCompleted then
    return
  end
  ProtoManager.Instance:ReqServer("AvgCommunicateRequest", "OnDialogFinish", function(data)
    table.removeByValue(communicateData.currList, dialogId)
    if not table.contains(communicateData.completeList, dialogId) then
      table.insert(communicateData.completeList, dialogId)
    end
    if communicateData.dialogs[dialogId] then
      communicateData.dialogs[dialogId].isCompleted = true
      communicateData.dialogs[dialogId].completedTime = TimeUtils.GetServerTime()
    end
    EventMgr.Instance.OnFinishAwakerChat:Dispatch(dialogId)
    communicateData.completedDialogCount = communicateData.completedDialogCount + 1
  end, function()
  end, dialogId)
end

function AwakerChatDataUtils.IsValidChat(dialogId)
  local cfg = DT.AvgCommunicate[dialogId]
  return nil ~= cfg
end

function AwakerChatDataUtils.IsHaveDialogs()
  return table.next(communicateData.dialogs) ~= nil
end

function AwakerChatDataUtils.IsHaveUnreadDialog()
  return #communicateData.currList > 0
end

function AwakerChatDataUtils.GetCompleteDialogList()
  return communicateData.completeList
end

function AwakerChatDataUtils.GetDialog(dialogId)
  return communicateData.dialogs[dialogId]
end

function AwakerChatDataUtils.IsHaveCompletedDialogs()
  return communicateData.completedDialogCount and communicateData.completedDialogCount > 0
end

function AwakerChatDataUtils.GetRecentMessageList()
  return communicateData.currList
end

function AwakerChatDataUtils.GetAwakerCompleteDialogs(awakerTid)
  local completeList = AwakerChatDataUtils.GetCompleteDialogList()
  local list = {}
  local data, cfg
  for _, id in pairs(completeList) do
    cfg = DT.AvgCommunicate[id] or {}
    data = cfg and cfg.data_list and cfg.data_list[1]
    if data and data.Ascription == awakerTid then
      table.insert(list, id)
    end
  end
  return list
end

function AwakerChatDataUtils.IsChatFinished(chatId)
  local completeList = AwakerChatDataUtils.GetCompleteDialogList()
  do return table.contains, completeList end
  return table.contains, completeList, chatId
end

function AwakerChatDataUtils.GetSavedChatList(chatId)
  local dialog = communicateData.dialogs[chatId]
  local contentList = dialog and dialog.history or {}
  if not AwakerChatDataUtils.IsChatFinished(chatId) and AwakerChatDataUtils.IsWrongList(chatId, contentList) then
    contentList = {}
  end
  return contentList
end

function AwakerChatDataUtils.IsWrongList(chatId, contentList)
  local WRONG = true
  local index = 1
  local chatDataList = AwakerChatDataUtils.GetChatInfoList(chatId)
  while contentList[index] do
    local curLine = contentList[index]
    local nextLine = contentList[index + 1]
    local curInfo = chatDataList[curLine]
    local nextTagList = curInfo.NextChatID
    if not nextLine then
      if not nextTagList then
        return not WRONG
      end
      for _, chatTag in ipairs(nextTagList) do
        local lineIndex = AwakerChatDataUtils.GetLineIndexByTag(chatId, chatTag)
        if table.contains(contentList, lineIndex) then
          Logger.Warn("TXQ检查到最后一个选项的跳转已经播放过了")
          return WRONG
        end
      end
      return not WRONG
    end
    local nextInfo = chatDataList[nextLine]
    if not curInfo or not nextInfo then
      Logger.Warn("TXQ当前序号(数组顺序)找不到配置 %s : %s %s", chatId, curLine, nextLine)
      return WRONG
    end
    if curLine + 1 == nextLine then
      goto lbl_84
    elseif not nextTagList or not table.contains(nextTagList, nextInfo.ChatID) then
      Logger.Warn(string.format("TXQ没有配置跳转关系 %s %s", curInfo.Content, nextInfo.Content))
      return WRONG
    end
    ::lbl_84::
    index = index + 1
  end
  return not WRONG
end

function AwakerChatDataUtils.GetPushedTime(chatId)
  local dialog = communicateData.dialogs[chatId]
  return dialog and dialog.pushedTime or 0
end

function AwakerChatDataUtils.GetChatInfoList(chatId)
  local cfg = DT.AvgCommunicate[chatId]
  return cfg and cfg.data_list or {}
end

function AwakerChatDataUtils.GetFirstLineData(chatId)
  local list = AwakerChatDataUtils.GetChatInfoList(chatId)
  return list[1]
end

function AwakerChatDataUtils.GetLastLineData(chatId)
  local list = AwakerChatDataUtils.GetChatInfoList(chatId)
  local history = AwakerChatDataUtils.GetSavedChatList(chatId)
  if history and #history > 0 then
    return list[history[#history]]
  end
  return list[1]
end

function AwakerChatDataUtils.GetEndLineData(chatId)
  local list = AwakerChatDataUtils.GetChatInfoList(chatId)
  return list[#list]
end

function AwakerChatDataUtils.GetLineData(chatId, idx)
  local list = AwakerChatDataUtils.GetChatInfoList(chatId)
  return list[idx]
end

function AwakerChatDataUtils.GetNextLineIndex(chatId, idx)
  if 0 == idx or nil == idx then
    return 1
  end
  local list = AwakerChatDataUtils.GetChatInfoList(chatId)
  local curLineInfo = list[idx] or {}
  local nextChatIDList = curLineInfo.NextChatID
  local nextLineIndex
  if not nextChatIDList then
    if list[idx + 1] then
      nextLineIndex = idx + 1
    end
  elseif 1 == #nextChatIDList then
    nextLineIndex = AwakerChatDataUtils.GetLineIndexByTag(chatId, nextChatIDList[1])
  end
  if nextLineIndex then
    local contentData = AwakerChatDataUtils.GetLineData(chatId, nextLineIndex)
    if contentData.DialogType == cd.CommunicateType.Option then
      return {nextLineIndex}
    end
    return nextLineIndex
  end
  if nextChatIDList then
    local options = {}
    for _, tag in ipairs(nextChatIDList) do
      local lineIndex = AwakerChatDataUtils.GetLineIndexByTag(chatId, tag)
      if lineIndex then
        table.insert(options, lineIndex)
      end
    end
    return options
  end
end

function AwakerChatDataUtils.GetLineIndexByTag(chatId, tag)
  local list = AwakerChatDataUtils.GetChatInfoList(chatId)
  for index, lineInfo in ipairs(list) do
    if lineInfo.ChatID == tag then
      return index
    end
  end
end

function AwakerChatDataUtils.GetChatRoleId(chatId)
  local list = AwakerChatDataUtils.GetChatInfoList(chatId)
  if not list then
    return
  end
  for _, lineData in ipairs(list) do
    if lineData and lineData.TalkRole then
      local roleId = lineData.TalkRole[1]
      if roleId then
        local roleCfg = AwakerChatDataUtils.GetRoleCfg(roleId)
        if roleCfg and roleCfg.ID ~= CommonDefine.AvgDialogPlayerId and 1 ~= roleCfg.ShowAsPlayer then
          return table.unpack(lineData.TalkRole)
        end
      end
    end
  end
  local firstLine = AwakerChatDataUtils.GetFirstLineData(chatId)
  do return table.unpack end
  return table.unpack, firstLine and firstLine.TalkRole or {}, ipairs(list)
end

function AwakerChatDataUtils.GetChatIcon(chatId)
  local roleId, expression = AwakerChatDataUtils.GetChatRoleId(chatId)
  do return AwakerChatDataUtils.GetChatRoleIcon, roleId end
  return AwakerChatDataUtils.GetChatRoleIcon, roleId, expression
end

function AwakerChatDataUtils.GetRoleCfg(roleId)
  return DT.AvgRole[roleId or 0]
end

function AwakerChatDataUtils.GetChatRoleIcon(roleId, expression)
  local roleCfg = AwakerChatDataUtils.GetRoleCfg(roleId)
  if not roleCfg then
    return
  end
  local genderItem = GenderDataUtils.GetGenderCfgByRoleData()
  if (roleCfg.ID == CommonDefine.AvgDialogPlayerId or 1 == roleCfg.ShowAsPlayer) and nil ~= genderItem then
    if PlayerDataUtils.IsInAprileFool() then
      local replacementTid = DT.GetConstant(CommonDefine.AvatarReplacementItemIdKey)
      if replacementTid and ItemDataUtils.IsAvatarItem(replacementTid) then
        do return ItemDataUtils.GetAvatarIcon end
        return ItemDataUtils.GetAvatarIcon, replacementTid
      end
    end
    return genderItem.AVGAvatarRes
  else
    if roleCfg.AwakerResource then
      do return PortraitUtils.GetMiniHead, roleCfg.AwakerResource end
      return PortraitUtils.GetMiniHead, roleCfg.AwakerResource, expression
    end
    if roleCfg.HeadIcon then
      local headUrl = string.format("Portraits/Minihead/%s.png", roleCfg.HeadIcon)
      return headUrl
    end
  end
end

function AwakerChatDataUtils.GetChatName(roleId)
  local roleCfg = AwakerChatDataUtils.GetRoleCfg(roleId)
  if not roleCfg then
    return
  end
  local roleName = ""
  if roleCfg and roleCfg.RoleName then
    roleName = LT.Text(roleCfg.RoleName)
  end
  do return StrUtils.ReplaceAvgContent end
  return StrUtils.ReplaceAvgContent, roleName
end

function AwakerChatDataUtils.GetChatSign(roleId)
  local roleCfg = AwakerChatDataUtils.GetRoleCfg(roleId)
  if not roleCfg then
    return
  end
  do return LT.Text end
  return LT.Text, roleCfg.Sign
end

function AwakerChatDataUtils.TranslateContent(showText)
  showText = showText or ""
  local isTextToChoas = string.find(showText, "<Change>", 0, true)
  local content = StrUtils.ReplaceAvgContent(showText)
  content = StrUtils.SetWordEffectStr(content)
  content = LT.ReplaceUnicodeSpace(content)
  content = string.replace(content, "<Change>", "", true)
  return content, isTextToChoas
end

function AwakerChatDataUtils.GetChatAwakerList()
  local completeList = {}
  for _, info in pairs(communicateData.dialogs) do
    if info.isCompleted then
      table.insert(completeList, info)
    end
  end
  table.sort(completeList, function(a, b)
    return a.completedTime > b.completedTime
  end)
  local awakerList = {}
  local dialogId, data, cfg
  for _, dialogInfo in ipairs(completeList) do
    dialogId = dialogInfo.dialogId
    cfg = DT.AvgCommunicate[dialogId]
    data = cfg and cfg.data_list and cfg.data_list[1]
    if data and data.Ascription and not table.contains(awakerList, data.Ascription) then
      table.insert(awakerList, data.Ascription)
    end
  end
  return awakerList
end

return AwakerChatDataUtils
