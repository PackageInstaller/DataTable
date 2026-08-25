local MAX_NEWFANS_COUNT = 100
local BATCH_ATTENTION_LIMIT = 20
local ATTENTION_SYNC_DELAY = 1
local SocialData = DataCenter.socialData
local SocialDataUtils = {}

function SocialDataUtils.ResetAll()
  SocialData.myPlayer = {}
  SocialData.relationListMap = {}
  SocialData.relationListUidMap = {}
  SocialData.followListUid2facadeMap = {}
  SocialData.onlineState = ""
  SocialData.strangerMap = {}
  SocialData.inviteList = {}
  SocialData.increase = 10
  SocialData.relationCacheMap = {}
  SocialData.facadeMap = {}
  SocialData.previewAwakerData = {}
  SocialData.pendingFollowCount = 0
  SocialData.pendingUnfollowCount = 0
  SocialData.attentionOperatingUidMap = {}
  SocialData.attentionNumDirtyTs = nil
  SocialData.attentionNumSyncTimerRunning = false
  SocialData.attentionNumSyncRequesting = false
end

function SocialDataUtils.OpenSocialRelationMainPanel()
  if SocialDataUtils.GetMyPlayer() and not table.next(SocialDataUtils.GetMyPlayer()) then
    SocialDataUtils.ReqOnGetSocialBasicInfo(function()
      UIManager.Instance:Reopen(Urls.SocialRelationMainPanel)
    end)
    return
  end
  SocialDataUtils.ReqOnGetSocialBasicInfo()
  UIManager.Instance:Reopen(Urls.SocialRelationMainPanel)
end

function SocialDataUtils.OpenSocialRelationNewFansPanel()
  UIManager.Instance:Reopen(Urls.SocialRelationNewFansPanel, MAX_NEWFANS_COUNT)
end

function SocialDataUtils.OpenPlayerInfoPanel(page, playerUid, playerPanelType)
  page = page or SocialDefine.PlayerInfoPage.Overview
  playerUid = playerUid or DataCenter.playerData.DRole.uid
  local isMyInfo = playerUid == DataCenter.playerData.DRole.uid
  local initData = {
    page = page,
    targetPlayerUid = playerUid,
    playerPanelType = playerPanelType
  }
  local panelUrl = isMyInfo and Urls.SocialPlayerInfoPanel or Urls.SocialOtherPlayerInfoPanel
  UIManager.Instance:Reopen(panelUrl, initData)
end

function SocialDataUtils.GetIsNoCache(relateType)
  return SocialData.relationCacheMap[relateType] and 0 or 1
end

function SocialDataUtils.MarkSocialListCached(relateType)
  SocialData.relationCacheMap[relateType] = true
end

function SocialDataUtils.MarkSocialListDirty(relateType)
  SocialData.relationCacheMap[relateType] = nil
end

function SocialDataUtils.ClearSocialListCache()
  table.clear(SocialData.relationCacheMap)
end

function SocialDataUtils.SetAssetAwakerCount(count)
  SocialData.assetAwakerCount = count
end

function SocialDataUtils.GetAssetAwakerCount()
  return SocialData.assetAwakerCount
end

function SocialDataUtils.ReqOnSocialQueryList(listType, s, e, _, callback, queryCliParam)
  local param
  if queryCliParam then
    param = {
      sortType = SocialDefine.SocialFollowSortParam[queryCliParam].param
    }
  end
  if not e or 0 == e then
    e = 1
  end
  if s > e then
    return
  end
  local noCache = SocialDataUtils.GetIsNoCache(listType)
  ProtoManager.Instance:ReqServer("GameRequest", "OnSocialQueryList", function(data)
    SocialDataUtils.MarkSocialListCached(listType)
    Logger.Info("OnSocialQueryList Successful", table.tostring(data or {}))
    if data.socialData then
      SocialDataUtils.UpdateMyPlayer(data.socialData)
    end
    if data.sortedList then
      SocialDataUtils.SetRelationListByType(listType, data.sortedList, s, e)
    end
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("OnSocialQueryList Failed", table.tostring(data or {}))
  end, listType, s, e, noCache, param)
end

function SocialDataUtils.ReqStarAssistRelationList(start, tail, callback)
  local listType = SocialDefine.RelationListType.StarAssist
  if not tail or 0 == tail then
    tail = 1
  end
  if start > tail then
    return
  end
  SocialDataUtils.ResetRelationListByType(listType)
  ProtoManager.Instance:ReqServer("GameRequest", "OnSocialQueryList", function(data)
    Logger.Info("ReqStarAssistRelationList Successful", table.tostring(data or {}))
    if data.socialData then
      SocialDataUtils.UpdateMyPlayer(data.socialData)
    end
    if data.sortedList then
      SocialDataUtils.SetRelationListByType(listType, data.sortedList, start, tail)
    end
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("ReqStarAssistRelationList Failed", table.tostring(data or {}))
  end, listType, start, tail, 1)
end

function SocialDataUtils.ReqOnSocialVisit(targetUid, callback, failCb)
  ProtoManager.Instance:ReqServer("GameRequest", "OnSocialVisit", function(data)
    Logger.Info("========== 社交查看详情成功 ==========\n", table.tostring(data or {}))
    if callback then
      callback(data)
    end
  end, function(data)
    Logger.Info("========== 社交查看详情失败 ==========\n", table.tostring(data or {}))
    if failCb then
      failCb()
    end
  end, targetUid)
end

function SocialDataUtils.ReqOnGetSocialBasicInfo(callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnGetSocialBasicInfo", function(data)
    Logger.Info("========== 请求社交基础信息成功 ==========\n", table.tostring(data or {}))
    SocialData.attentionNumSyncRequesting = false
    SocialData.attentionNumDirtyTs = nil
    SocialDataUtils.UpdateMyPlayer(data)
    if callback then
      callback(data)
    end
  end, function(data)
    Logger.Info("========== 请求社交基础信息失败 ==========\n", table.tostring(data or {}))
    SocialData.attentionNumSyncRequesting = false
  end)
end

function SocialDataUtils.ReqOnSocialGood(targetUid, num, goodReason, callback)
  Logger.Info("OnSocialGood targetUid, num, goodReason ", targetUid, num, goodReason)
  ProtoManager.Instance:ReqServer("GameRequest", "OnSocialGood", function(data)
    Logger.Info("========== 点赞成功 ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 点赞失败 ==========\n", table.tostring(data or {}))
  end, targetUid, num, goodReason)
end

function SocialDataUtils.ReqOnSocialAttention(targetUid, callback)
  if not SocialDataUtils.TryBeginAttentionOperation(targetUid) then
    return
  end
  if SocialDataUtils.TryBlockAttentionFull() then
    SocialDataUtils.EndAttentionOperation(targetUid)
    return
  end
  SocialDataUtils.AddPendingFollowCount(1)
  ProtoManager.Instance:ReqServer("GameRequest", "OnSocialAttention", function(data)
    Logger.Info("========== 关注成功 ==========\n", table.tostring(data or {}))
    SocialDataUtils.AddPendingFollowCount(-1)
    SocialDataUtils.EndAttentionOperation(targetUid)
    local newRelation = data.relation
    if 0 == SocialDataUtils.GetPendingUnfollowCount() then
      SocialDataUtils.AddAttentionNum(1)
    end
    SocialDataUtils.SetAttentionNumFromData(data)
    if callback then
      callback(newRelation)
    end
    EventMgr.Instance.SocialAttention:Dispatch(targetUid, newRelation)
    SocialDataUtils.OnAttentionOperationSettled()
  end, function(data)
    Logger.Info("========== 关注失败 ==========\n", table.tostring(data or {}))
    SocialDataUtils.AddPendingFollowCount(-1)
    SocialDataUtils.EndAttentionOperation(targetUid)
    SocialDataUtils.OnAttentionOperationSettled()
  end, targetUid)
end

function SocialDataUtils.OnSocialBatchAttentionComplete(targetUidList, attentResult, allRelationMap, data, callback, allCallback)
  local successCount = 0
  for _, targetUid in ipairs(targetUidList) do
    if 1 == attentResult[targetUid] then
      successCount = successCount + 1
      local newRelation = allRelationMap[targetUid]
      if callback then
        callback(targetUid, newRelation)
      end
      EventMgr.Instance.SocialAttention:Dispatch(targetUid, newRelation)
    end
    SocialDataUtils.EndAttentionOperation(targetUid)
  end
  SocialDataUtils.AddPendingFollowCount(-#targetUidList)
  if 0 == SocialDataUtils.GetPendingUnfollowCount() and successCount > 0 then
    SocialDataUtils.AddAttentionNum(successCount)
  end
  SocialDataUtils.SetAttentionNumFromData(data)
  SocialDataUtils.OnAttentionOperationSettled()
  WaitingView.Instance:Hide(targetUidList, WaitingView.Flag_SocialBatch)
  if allCallback then
    allCallback()
  end
end

function SocialDataUtils.ReqOnSocialBatchAttention(targetUidList, callback, allCallback)
  if not targetUidList or #targetUidList <= 0 then
    if SocialDataUtils.IsAttentionFull() then
      Alert.Show(10744)
    end
    if allCallback then
      allCallback()
    end
    return
  end
  if SocialDataUtils.TryBlockAttentionFull() then
    if allCallback then
      allCallback()
    end
    return
  end
  local canFollowCount = SocialDataUtils.GetCanFollowCount()
  if canFollowCount < #targetUidList then
    local trimmedList = {}
    for i = 1, canFollowCount do
      trimmedList[i] = targetUidList[i]
    end
    targetUidList = trimmedList
  end
  local lockedUids = {}
  for _, uid in ipairs(targetUidList) do
    if not SocialDataUtils.TryBeginAttentionOperation(uid) then
      for _, lockedUid in ipairs(lockedUids) do
        SocialDataUtils.EndAttentionOperation(lockedUid)
      end
      if allCallback then
        allCallback()
      end
      return
    end
    lockedUids[#lockedUids + 1] = uid
  end
  SocialDataUtils.AddPendingFollowCount(#targetUidList)
  local requestList = {}
  for i = 1, #targetUidList, BATCH_ATTENTION_LIMIT do
    local chunk = {}
    for j = i, math.min(i + BATCH_ATTENTION_LIMIT - 1, #targetUidList) do
      chunk[#chunk + 1] = targetUidList[j]
    end
    requestList[#requestList + 1] = chunk
  end
  local attentResult = {}
  local allRelationMap = {}
  WaitingView.Instance:Show(targetUidList, WaitingView.Flag_SocialBatch)
  local finishDict = {}
  for index, uidList in ipairs(requestList) do
    finishDict[index] = true
    ProtoManager.Instance:ReqServer("GameRequest", "OnSocialBatchAttention", function(data)
      for uid, suc in pairs(data.attentResult or {}) do
        attentResult[uid] = suc
      end
      for uid, relation in pairs(data.ret and data.ret.relationMap or {}) do
        allRelationMap[uid] = relation
      end
      finishDict[index] = nil
      if 0 == table.length(finishDict) then
        SocialDataUtils.OnSocialBatchAttentionComplete(targetUidList, attentResult, allRelationMap, data, callback, allCallback)
      end
    end, function(data)
      Logger.Info("========== 批量关注失败 ==========\n", table.tostring(data or {}))
      finishDict[index] = nil
      if 0 == table.length(finishDict) then
        SocialDataUtils.OnSocialBatchAttentionComplete(targetUidList, attentResult, allRelationMap, data, callback, allCallback)
      end
    end, uidList)
  end
end

function SocialDataUtils.ReqOnSocialCancelAttention(targetUidList, callback)
  if type(targetUidList) == "number" then
    targetUidList = {targetUidList}
  end
  local lockedUids = {}
  for _, uid in ipairs(targetUidList) do
    if not SocialDataUtils.TryBeginAttentionOperation(uid) then
      for _, lockedUid in ipairs(lockedUids) do
        SocialDataUtils.EndAttentionOperation(lockedUid)
      end
      return
    end
    lockedUids[#lockedUids + 1] = uid
  end
  SocialDataUtils.AddPendingUnfollowCount(#targetUidList)
  ProtoManager.Instance:ReqServer("GameRequest", "OnSocialCancelAttention", function(data)
    Logger.Info("========== 取关成功 ==========\n", table.tostring(data or {}))
    SocialDataUtils.AddPendingUnfollowCount(-#targetUidList)
    for _, targetUid in ipairs(targetUidList) do
      SocialDataUtils.EndAttentionOperation(targetUid)
    end
    local relationMap = data.relationMap
    local myPlayer = SocialDataUtils.GetMyPlayer()
    if 0 == SocialDataUtils.GetPendingFollowCount() then
      SocialDataUtils.AddAttentionNum(-#targetUidList)
    end
    SocialDataUtils.SetAttentionNumFromData(data)
    for _, targetUid in ipairs(targetUidList) do
      if myPlayer and myPlayer.uid2NickName and myPlayer.uid2NickName[targetUid] then
        myPlayer.uid2NickName[targetUid] = nil
      end
      local newRelation = relationMap[targetUid]
      SocialDataUtils.RemoveFromSocialList(targetUid, SocialDefine.RelationListType.StarAssist)
      EventMgr.Instance.SocialSetStarAssist:Dispatch({
        assistUid = targetUid,
        playerInfo = {uid = targetUid}
      }, false)
      if callback then
        callback(targetUid, newRelation)
      end
      EventMgr.Instance.SocialAttention:Dispatch(targetUid, newRelation)
    end
    SocialDataUtils.OnAttentionOperationSettled()
  end, function(data)
    Logger.Info("========== 取关失败 ==========\n", table.tostring(data or {}))
    SocialDataUtils.AddPendingUnfollowCount(-#targetUidList)
    for _, targetUid in ipairs(targetUidList) do
      SocialDataUtils.EndAttentionOperation(targetUid)
    end
    SocialDataUtils.OnAttentionOperationSettled()
  end, targetUidList)
end

function SocialDataUtils.RemoveFromSocialList(uid, type)
  local socialList = SocialData.relationListMap[type]
  for i, info in ipairs(socialList or {}) do
    if info.uid == uid then
      table.remove(socialList, i)
      break
    end
  end
end

function SocialDataUtils.IsBanned(uid)
  local banList = SocialData.relationCacheMap[SocialDefine.RelationListType.Bans]
  for i, info in ipairs(banList or {}) do
    if info.uid == uid then
      return true
    end
  end
end

function SocialDataUtils.Ban(targetUid, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnSocialBan", function(data)
    Logger.Info("========== 拉黑成功 ==========\n", table.tostring(data or {}))
    local newRelation = SocialDefine.SocialRelationType.Ban
    SocialDataUtils.RemoveFromSocialList(targetUid, SocialDefine.RelationListType.Attention)
    SocialDataUtils.RemoveFromSocialList(targetUid, SocialDefine.RelationListType.Fans)
    SocialDataUtils.RemoveFromSocialList(targetUid, SocialDefine.RelationListType.Follow)
    if callback then
      callback(newRelation)
    end
    EventMgr.Instance.SocialAttention:Dispatch(targetUid, newRelation)
  end, function(data)
    Logger.Info("========== 拉黑失败 ==========\n", table.tostring(data or {}))
  end, targetUid)
end

function SocialDataUtils.CancelBan(targetUid, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnCancelSocialBan", function(data)
    Logger.Info("========== 取消拉黑成功 ==========\n", table.tostring(data or {}))
    local newRelation = data.relation
    if SocialData.myPlayer and data.banNum then
      SocialData.myPlayer.banNum = data.banNum
    end
    SocialDataUtils.RemoveFromSocialList(targetUid, SocialDefine.RelationListType.Bans)
    if callback then
      callback(newRelation)
    end
    EventMgr.Instance.SocialAttention:Dispatch(targetUid, newRelation)
  end, function(data)
    Logger.Info("========== 取消拉黑失败 ==========\n", table.tostring(data or {}))
  end, targetUid)
end

function SocialDataUtils.ReqOnSocialNote(targetUid, nickName, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnSocialNote", function(data)
    Logger.Info("========== 备注成功 ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
    EventMgr.Instance.SocialNickName:Dispatch(targetUid, nickName)
  end, function(data)
    Logger.Info("========== 备注失败 ==========\n", table.tostring(data or {}))
  end, targetUid, nickName)
end

function SocialDataUtils.ReqOnQueryStranger(num, refresh, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnQueryStranger", function(data)
    Logger.Info("========== 请求陌生人列表成功 ==========\n", table.tostring(data or {}))
    SocialDataUtils.SetStrangerMap(data)
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 请求陌生人列表失败 ==========\n", table.tostring(data or {}))
  end, num, refresh)
end

function SocialDataUtils.ReqOnCancelNote(targetUid, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnCancelNote", function(data)
    Logger.Info("========== 取消备注成功 ==========\n", table.tostring(data or {}))
    local myPlayer = SocialDataUtils.GetMyPlayer()
    if myPlayer and myPlayer.uid2NickName and myPlayer.uid2NickName[targetUid] then
      myPlayer.uid2NickName[targetUid] = nil
    end
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 取消备注失败 ==========\n", table.tostring(data or {}))
  end, targetUid)
end

SocialDataUtils.isFirstReqParams = nil

function SocialDataUtils.GetIsFirstReq(params)
  if not SocialDataUtils.isFirstReqParams then
    return 1
  end
  local sameMap = params.awakerMapFilter == SocialDataUtils.isFirstReqParams.awakerMapFilter and params.school == SocialDataUtils.isFirstReqParams.school and params.sort == SocialDataUtils.isFirstReqParams.sort and params.sortType == SocialDataUtils.isFirstReqParams.sortType
  if not sameMap then
  else
    for k, v in pairs(params.awakerMap or {}) do
      if SocialDataUtils.isFirstReqParams.awakerMap[k] ~= v then
        sameMap = false
        break
      end
    end
    for k, v in pairs(SocialDataUtils.isFirstReqParams.awakerMap or {}) do
      if params.awakerMap[k] ~= v then
        sameMap = false
        break
      end
    end
  end
  return sameMap and 0 or 1
end

function SocialDataUtils.QueryAllAssistAwaker(params, sortOrder, callback)
  local funcMap = {}
  local datalist = {}
  local totalCnt = DT.GetConstant("AwakerAssistNumber") or 100
  local increase = totalCnt < SocialData.increase and totalCnt or SocialData.increase
  for i = 1, totalCnt, increase do
    local startIdx = i
    local endIdx = i + increase - 1
    local refresh = 1 == i and 1 or 0
    
    local function queryFunc()
      params.sort = sortOrder == CommonDefine.SortOrder.Descend and 1 or -1
      params.isFirstReq = SocialDataUtils.GetIsFirstReq(params)
      if 1 == params.isFirstReq then
        SocialDataUtils.isFirstReqParams = params
      end
      SocialDataUtils.QueryAssistAwaker(refresh, startIdx, endIdx, params, function(serverData)
        if serverData.assistFilterAwakers then
          AssistFilterModel.Instance:ReqFilter(serverData.assistFilterAwakers)
        end
        if serverData.retAssistList then
          for _, singleData in ipairs(serverData.retAssistList) do
            table.insert(datalist, singleData)
          end
          callback(datalist, startIdx, endIdx)
          table.clear(datalist)
        end
      end)
    end
    
    if 1 == i then
      queryFunc()
    else
      funcMap[startIdx - 1] = queryFunc
    end
  end
  return funcMap
end

function SocialDataUtils.QueryAssistAwaker(refresh, startIdx, endIdx, params, callback)
  EventMgr.Instance.QueryAssistAwaker:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "QueryAssistAwaker", function(data)
    Logger.Info("========== 请求助战列表成功 ==========\n", table.tostring(data))
    SocialDataUtils.SetAssetAwakerCount(data.count)
    if callback then
      callback(data)
    end
  end, function(data)
    Logger.Info("========== 请求助战列表失败 ==========\n")
  end, refresh, startIdx, endIdx, params)
end

function SocialDataUtils.ReqSetStarAssist(assistData, set, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "SetStarAssist", function(data)
    Logger.Info("========== 设置常用助战成功 ==========\n", assistData.playerInfo.uid, set, table.tostring(data))
    EventMgr.Instance.SocialSetStarAssist:Dispatch(assistData, set)
    if callback then
      callback(data)
    end
  end, function(data)
    Logger.Info("========== 设置常用助战失败 ==========\n", assistData.playerInfo.uid, set, table.tostring(data))
  end, assistData.playerInfo.uid, set)
end

function SocialDataUtils.OpenBattleAssistPanel(model)
  model:GetAssistSuggestSchoolId()
  UIManager.Instance:Reopen(Urls.BattleAssistPanel, model)
end

function SocialDataUtils.OpenAssistStarPanel(model)
  local maxCount = DT.GetConstant("CommonUseBattleHelpNumLimit")
  SocialDataUtils.ReqStarAssistRelationList(1, maxCount, function()
    model:UpdateStarAssist()
  end)
  UIManager.Instance:Reopen(Urls.AssistStarPanel, model)
end

function SocialDataUtils.ReqOnSetState(state, callback)
  if not state or state == SocialDataUtils.GetOnlineState() then
    return
  end
  SocialDataUtils.SetOnlineState(state)
  print("ReqOnSetState SendState ", "---" .. state .. "---")
  ProtoManager.Instance:ReqServer("GameRequest", "OnSetState", function(data)
    Logger.Info("========== 设置玩家状态成功 ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 设置玩家状态失败 ==========\n", table.tostring(data or {}))
  end, state)
end

function SocialDataUtils.ReqOnClearNewFanNum(callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnClearNewFanNum", function(data)
    Logger.Info("========== 清除新增粉丝数量成功 ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 清除新增粉丝数量失败 ==========\n", table.tostring(data or {}))
  end)
end

function SocialDataUtils.ReqSetBirthday(month, day, callback)
  if not month or not day then
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnSetBirthday", function(data)
    Logger.Info("========== 设置生日成功 ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 设置生日失败 ==========\n", table.tostring(data or {}))
  end, month, day)
end

function SocialDataUtils.SetPlayerNote(note, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnSetNote", function(data)
    Logger.Info("========== 设置简介成功 ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
    EventMgr.Instance.SocialSetNote:Dispatch(note)
  end, function(data)
    Logger.Info("========== 设置简介失败 ==========\n", table.tostring(data or {}))
  end, note)
end

function SocialDataUtils.SetPlayerAvatar(avatar, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnSetAvatar", function(data)
    Logger.Info("========== 设置头像成功 ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
    EventMgr.Instance.SocialSetAvatar:Dispatch(avatar)
  end, function(data)
    Logger.Info("========== 设置头像失败 ==========\n", table.tostring(data or {}))
  end, avatar)
end

function SocialDataUtils.SetPlayerAvatarFrame(frameItemTid, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnSetAvatarFrame", function(data)
    Logger.Info("========== 设置头像框成功 ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
    EventMgr.Instance.SocialSetAvatarFrame:Dispatch(frameItemTid)
  end, function(data)
    Logger.Info("========== 设置头像框失败 ==========\n", table.tostring(data or {}))
  end, frameItemTid)
end

local function _CleanBoundTrinketUids(trinkets)
  if not trinkets then
    return
  end
  for pos, uid in pairs(trinkets) do
    if 0 ~= uid and AwakerDataUtils.IsTrinketBoundByAnyAwaker(uid) then
      trinkets[pos] = 0
    end
  end
end

function SocialDataUtils.ChangeAssistAwaker(tid, awakerEquipData, callback)
  if not tid then
    return
  end
  local sendData = {
    [tid] = table.deepclone(awakerEquipData)
  }
  local sendTrinkets = sendData[tid] and sendData[tid].trinkets
  _CleanBoundTrinketUids(sendTrinkets)
  ProtoManager.Instance:ReqServer("GameRequest", "OnChangeAssistAwaker", function(data)
    Logger.Info("========== 设置助战唤醒体成功 ==========\n", table.tostring(data or {}))
    local echoTrinkets = data and data.awaker and data.awaker.trinkets
    _CleanBoundTrinketUids(echoTrinkets)
    SocialDataUtils.SetPreviewAwakerData(data)
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 设置助战唤醒体失败 ==========\n", table.tostring(data or {}))
  end, sendData)
end

function SocialDataUtils.ChangeShowAwaker(tids, callback)
  if not tids then
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "UpdateTeam", function(data)
    Logger.Info("========== 设置展示唤醒体成功 ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 设置展示唤醒体失败 ==========\n", table.tostring(data or {}))
  end, CommonDefine.TeamType.Social, {}, 0, "", 0, tids)
end

function SocialDataUtils.ReqGainAssistReward(callback)
  if not SocialDataUtils.HasAssisReward() then
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnGainAssistReward", function(data)
    Logger.Info("========== 领取助战奖励成功 ==========\n", table.tostring(data or {}))
    if callback then
      callback(data)
    end
  end, function(data)
    Logger.Info("========== 领取助战奖励失败 ==========\n", table.tostring(data or {}))
  end)
end

function SocialDataUtils.ReqClearNewGood(callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnClearNewGood", function(data)
    Logger.Info("========== 移除点赞列表的新红点成功 ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 移除点赞列表的新红点失败 ==========\n", table.tostring(data or {}))
  end)
end

function SocialDataUtils.ReqQueryAwaker(playerUid, awakerTid, callback)
  if not playerUid or not awakerTid then
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnQueryAwaker", function(data)
    Logger.Info("========== 获取唤醒体详细数据成功 ==========\n", table.tostring(data or {}))
    if callback then
      callback(data)
    end
  end, function(data)
    Logger.Info("========== 获取唤醒体详细数据失败 ==========\n", table.tostring(data or {}))
  end, playerUid, awakerTid)
end

function SocialDataUtils.ReqQueryAwakerList(playerUid, callback, isForce)
  if not playerUid then
    return
  end
  if not isForce then
    local cachedFacade = SocialData.facadeMap[playerUid]
    local now = TimeUtils.GetServerTime()
    local expireTime = cachedFacade and cachedFacade.expireTime or 0
    if cachedFacade and now < expireTime then
      if callback then
        callback(cachedFacade)
      end
      return
    end
  end
  ProtoManager.Instance:ReqServer("GameRequest", "QueryFacadeDetail", function(data)
    Logger.Info("========== 获取唤醒体详列表细数据成功 ==========\n", table.tostring(data or {}))
    data.expireTime = TimeUtils.GetServerTime() + 60
    SocialData.facadeMap[playerUid] = data
    if callback then
      callback(data)
    end
  end, function(data)
    Logger.Info("========== 获取唤醒体列表详细数据失败 ==========\n", table.tostring(data or {}))
  end, playerUid)
end

function SocialDataUtils.ReqQueryFacadeFields(playerUid, params)
  if not playerUid then
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnQueryFacadeFields", function(data)
    GlobalDispatcher:Dispatch(NotifyId.OnFacadeFieldDataChanged, playerUid, params.Type, data)
  end, function(data)
    Logger.Info("========== 查询Facade指定字段数据失败 ==========\n", table.tostring(data or {}))
  end, playerUid, params)
end

function SocialDataUtils.OnSyncSocialData(syncData)
  local myData = SocialDataUtils.GetMyPlayer()
  if myData then
    for k, v in pairs(syncData) do
      myData[k] = v
    end
  end
end

function SocialDataUtils.GetFirstRequestStranger()
  return SocialData.firstRequestStranger
end

function SocialDataUtils.GetStrangerMap()
  return SocialData.strangerMap
end

function SocialDataUtils.GetOnlineState(state)
  return SocialData.onlineState
end

function SocialDataUtils.GetMyPlayer()
  return SocialData.myPlayer
end

function SocialDataUtils.GetMyPlayerField(fieldName)
  return SocialData.myPlayer and SocialData.myPlayer[fieldName]
end

function SocialDataUtils.GetAttentionLimit()
  do return DT.GetConstant end
  return DT.GetConstant, "FollowersNumberLimit"
end

function SocialDataUtils.GetAttentionNum()
  local myPlayerData = SocialDataUtils.GetMyPlayer()
  return myPlayerData and myPlayerData.attentionNum or 0
end

function SocialDataUtils.GetPendingFollowCount()
  return SocialData.pendingFollowCount or 0
end

function SocialDataUtils.GetPendingUnfollowCount()
  return SocialData.pendingUnfollowCount or 0
end

function SocialDataUtils.GetEffectiveAttentionNum()
  return SocialDataUtils.GetAttentionNum() + SocialDataUtils.GetPendingFollowCount() - SocialDataUtils.GetPendingUnfollowCount()
end

function SocialDataUtils.GetCanFollowCount()
  return SocialDataUtils.GetAttentionLimit() - SocialDataUtils.GetEffectiveAttentionNum()
end

function SocialDataUtils.IsAttentionFull()
  return SocialDataUtils.GetCanFollowCount() <= 0
end

function SocialDataUtils.TryBlockAttentionFull()
  if SocialDataUtils.IsAttentionFull() then
    Alert.Show(10744)
    return true
  end
  return false
end

function SocialDataUtils.TryBeginAttentionOperation(uid)
  if not uid then
    return true
  end
  SocialData.attentionOperatingUidMap = SocialData.attentionOperatingUidMap or {}
  if SocialData.attentionOperatingUidMap[uid] then
    return false
  end
  SocialData.attentionOperatingUidMap[uid] = true
  return true
end

function SocialDataUtils.EndAttentionOperation(uid)
  if not uid or not SocialData.attentionOperatingUidMap then
    return
  end
  SocialData.attentionOperatingUidMap[uid] = nil
end

function SocialDataUtils.AddPendingFollowCount(delta)
  if not delta or 0 == delta then
    return
  end
  SocialData.pendingFollowCount = (SocialData.pendingFollowCount or 0) + delta
  if SocialData.pendingFollowCount < 0 then
    SocialData.pendingFollowCount = 0
  end
end

function SocialDataUtils.AddPendingUnfollowCount(delta)
  if not delta or 0 == delta then
    return
  end
  SocialData.pendingUnfollowCount = (SocialData.pendingUnfollowCount or 0) + delta
  if SocialData.pendingUnfollowCount < 0 then
    SocialData.pendingUnfollowCount = 0
  end
end

function SocialDataUtils.OnAttentionOperationSettled()
  if 0 == SocialDataUtils.GetPendingFollowCount() and 0 == SocialDataUtils.GetPendingUnfollowCount() then
    SocialData.attentionNumDirtyTs = TimeUtils.GetServerTime()
    SocialDataUtils.ForceRefreshAttentionNum()
  end
end

function SocialDataUtils.AddAttentionNum(delta)
  local myPlayer = SocialDataUtils.GetMyPlayer()
  if not (myPlayer and delta) or 0 == delta then
    return
  end
  myPlayer.attentionNum = (myPlayer.attentionNum or 0) + delta
  if myPlayer.attentionNum < 0 then
    myPlayer.attentionNum = 0
  end
end

function SocialDataUtils.SetAttentionNumFromData(data)
  if not data then
    return false
  end
  local attentionNum = data.attentionNum
  if nil == attentionNum and data.socialData then
    attentionNum = data.socialData.attentionNum
  end
  if nil == attentionNum and data.ret then
    attentionNum = data.ret.attentionNum
  end
  if nil == attentionNum then
    return false
  end
  local myPlayer = SocialDataUtils.GetMyPlayer()
  if myPlayer then
    myPlayer.attentionNum = attentionNum
  end
  return true
end

function SocialDataUtils.ForceRefreshAttentionNum()
  if SocialDataUtils.GetPendingFollowCount() > 0 or SocialDataUtils.GetPendingUnfollowCount() > 0 then
    return
  end
  if SocialData.attentionNumSyncRequesting then
    return
  end
  local dirtyTs = SocialData.attentionNumDirtyTs
  if not dirtyTs then
    dirtyTs = TimeUtils.GetServerTime()
    SocialData.attentionNumDirtyTs = dirtyTs
  end
  local waitTime = ATTENTION_SYNC_DELAY - (TimeUtils.GetServerTime() - dirtyTs)
  if waitTime > 0 then
    if SocialData.attentionNumSyncTimerRunning then
      return
    end
    SocialData.attentionNumSyncTimerRunning = true
    TimerManager.Instance:CreateTimer(waitTime, 0, nil, function()
      SocialData.attentionNumSyncTimerRunning = false
      SocialDataUtils.ForceRefreshAttentionNum()
    end)
    return
  end
  SocialData.attentionNumSyncRequesting = true
  SocialDataUtils.ReqOnGetSocialBasicInfo()
end

function SocialDataUtils.GetRelationListByType(type)
  return SocialData.relationListMap[type]
end

function SocialDataUtils.GetFollowFacadeByUid(uid)
  return SocialData.followListUid2facadeMap[uid]
end

function SocialDataUtils.GetRelationListUidMap(type)
  return SocialData.relationListUidMap[type]
end

function SocialDataUtils.HasAssisReward()
  if not SocialData.myPlayer or not SocialData then
    return false
  end
  local CanGainTimes = SocialData.myPlayer.assistRewardTimes or 0
  return CanGainTimes > 0
end

function SocialDataUtils.SetFirstRequestStranger(boolVal)
  SocialData.firstRequestStranger = boolVal
end

function SocialDataUtils.SetStrangerMap(svrData)
  if not svrData then
    return
  end
  SocialData.strangerMap = svrData
end

function SocialDataUtils.SetOnlineState(state)
  if not state or type(state) ~= "string" then
    return
  end
  SocialData.onlineState = state
end

function SocialDataUtils.SetMyPlayer(data)
  if not data then
    return
  end
  SocialData.myPlayer = data
end

function SocialDataUtils.SetPreviewAwakerData(data)
  if not data then
    return
  end
  SocialData.previewAwakerData = data
end

function SocialDataUtils.GetPreviewAwakerData()
  return SocialData.previewAwakerData
end

function SocialDataUtils.ResetPreviewAwakerData()
  SocialData.previewAwakerData = {}
end

function SocialDataUtils.GetPreviewAwakerWeaponUids()
  local rst = {0, 0}
  local previewAwakerData = SocialDataUtils.GetPreviewAwakerData()
  if not previewAwakerData or not table.next(previewAwakerData) then
    return rst
  end
  local weaponSlotsData = AwakerDataUtils.GetWeaponSlotData(previewAwakerData.awaker)
  if weaponSlotsData then
    for idx, slotData in pairs(weaponSlotsData) do
      rst[idx] = slotData.weaponUid
    end
  end
  return rst
end

function SocialDataUtils.GetPreviewAwakerTrinketUids()
  local rst = {
    0,
    0,
    0,
    0,
    0,
    0
  }
  local previewAwakerData = SocialDataUtils.GetPreviewAwakerData()
  if previewAwakerData and previewAwakerData.awaker and previewAwakerData.awaker.trinkets then
    rst = previewAwakerData.awaker.trinkets
  end
  return rst
end

function SocialDataUtils.UpdateMyPlayer(data)
  if not data then
    return
  end
  if SocialData.myPlayer == nil or not table.next(SocialData.myPlayer) then
    SocialData.myPlayer = SocialDataUtils.CreateMyPlayer()
  end
  for key, value in pairs(data) do
    SocialData.myPlayer[key] = value
  end
  SocialRedUtils.UpdateSocialRed(data)
end

function SocialDataUtils.UpdateMyPlayerFacade(tbl)
  local myPlayer = SocialDataUtils.GetMyPlayer()
  if not myPlayer or not myPlayer.facade then
    return
  end
  for key, value in pairs(tbl) do
    myPlayer.facade[key] = value
  end
end

function SocialDataUtils.CreateMyPlayer()
  return {
    todayGoodRecord = {},
    uid2NickName = {},
    assistAwaker = 0,
    goodRecordNum = 0,
    gainAssistRewardTime = 0,
    assistRewardTimes = 0,
    facade = {},
    assistNum = 0,
    followerNum = 0,
    attentionNum = 0,
    visiterNum = 0,
    goodNum = 0,
    newFansNum = 0,
    invitorStartTime = 0
  }
end

function SocialDataUtils.SetRelationListByType(type, svrData, s, e)
  if not svrData then
    return
  end
  if not SocialData.relationListMap[type] then
    SocialData.relationListMap[type] = {}
  end
  if not SocialData.relationListUidMap[type] then
    SocialData.relationListUidMap[type] = {}
  end
  for i = #svrData, 1, -1 do
    local facade = svrData[i]
    if SocialData.relationListUidMap[type][facade.uid] then
      table.remove(svrData, i)
      e = e - 1
    end
  end
  local tempList = table.clone(SocialData.relationListMap[type])
  local serverIdx = 1
  for clientIdx = s, e do
    local facade = svrData[serverIdx]
    tempList[clientIdx] = facade
    if facade then
      SocialData.relationListUidMap[type][facade.uid] = true
      if type == SocialDefine.RelationListType.Attention then
        SocialData.followListUid2facadeMap[facade.uid] = facade
      end
    end
    serverIdx = serverIdx + 1
  end
  SocialData.relationListMap[type] = tempList
end

function SocialDataUtils.ResetRelationListByType(type)
  SocialData.relationListMap[type] = {}
  SocialData.relationListUidMap[type] = {}
end

function SocialDataUtils.GetRelationByindex(type, index)
  if not type or not index then
    return
  end
  return SocialData.relationListMap and SocialData.relationListMap[type] and SocialData.relationListMap[type][index]
end

function SocialDataUtils.CheckRelationUidExist(type, uid)
  if not type or not uid then
    return
  end
  return SocialData.relationListUidMap and SocialData.relationListUidMap[type] and SocialData.relationListUidMap[type][uid]
end

function SocialDataUtils.CheckIsAttentionRelation(relation)
  if not relation then
    return false
  end
  do return table.contains, {
    SocialDefine.SocialRelationType.Cor,
    SocialDefine.SocialRelationType.Atten
  } end
  return table.contains, {
    SocialDefine.SocialRelationType.Cor,
    SocialDefine.SocialRelationType.Atten
  }, relation, SocialDefine.SocialRelationType.Atten
end

function SocialDataUtils.GetPlayerName(targetFacade, noColor)
  if not targetFacade or not targetFacade.uid then
    return
  end
  if targetFacade.uid == DataCenter.playerData.DRole.uid then
    if targetFacade.name then
      return targetFacade.name
    else
      return DataCenter.playerData.DRole.name
    end
  else
    local nickName = SocialDataUtils.GetPlayerNameByUid(targetFacade.uid)
    if nickName then
      if noColor then
        return nickName
      else
        do return nickName.color, nickName end
        return nickName.color, nickName, "#5EF2FF"
      end
    end
  end
  return targetFacade.name
end

function SocialDataUtils.GetPlayerNameAndNickName(targetFacade)
  if not targetFacade or not targetFacade.uid then
    return
  end
  local realName, nickName
  if targetFacade.name then
    realName = targetFacade.name
  else
    realName = DataCenter.playerData.DRole.name
  end
  nickName = SocialDataUtils.GetPlayerNameByUid(targetFacade.uid)
  return {
    realName = realName or "",
    nickName = nickName or ""
  }
end

function SocialDataUtils.GetPlayerNameByUid(uid, defaultName)
  if SocialData.myPlayer and SocialData.myPlayer.uid2NickName then
    local nickName = SocialData.myPlayer.uid2NickName[uid]
    if nickName then
      return nickName
    end
  end
  return defaultName
end

function SocialDataUtils.ParseFacadeStateStr(stateStr)
  if not stateStr or type(stateStr) ~= "string" then
    return
  end
  local pattern = "[^|]+"
  local result = {}
  for match in string.gmatch(stateStr, pattern) do
    table.insert(result, match)
  end
  local stateKey = table.remove(result, 1)
  return stateKey, result
end

function SocialDataUtils.CreateFacadeStateStr(statekey, params)
  if not statekey then
    return
  end
  local rst = statekey
  if params then
    for _, param in pairs(params) do
      rst = rst .. "|" .. param
    end
  end
  return rst
end

function SocialDataUtils.SortAssistListByLevel(a, b, order)
  do return AwakerDataUtils.Compare, a.awakerData.level, b.awakerData.level end
  return AwakerDataUtils.Compare, a.awakerData.level, b.awakerData.level, order
end

function SocialDataUtils.SortByPotencyLv(a, b, order)
  do return AwakerDataUtils.Compare, a.awakerData.potencyLevel, b.awakerData.potencyLevel end
  return AwakerDataUtils.Compare, a.awakerData.potencyLevel, b.awakerData.potencyLevel, order
end

function SocialDataUtils.CheckOffLineState(stateStr)
  local stateKey, _ = SocialDataUtils.ParseFacadeStateStr(stateStr)
  return stateKey == SocialDefine.OnlineState.Offline
end

function SocialDataUtils.GetPlayerStateDesc(stateStr)
  local stateKey, params = SocialDataUtils.ParseFacadeStateStr(stateStr)
  if not stateKey then
    do return LT.Text end
    return LT.Text, "SocialSystemStrollingAround", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  if stateKey == SocialDefine.OnlineState.Offline then
    local ts = tonumber(params[1])
    local d, h, m, y, M = TimeUtils.GetSocialTime(ts)
    if not d or not ts then
      d, h, m, y, M = 0, 0, 0, 99, 0
    end
    if y >= 1 then
      do return LT.Textf, "SocializeOnLineTime_Year", math.floor(y) end
      return LT.Textf, "SocializeOnLineTime_Year", math.floor(y)
    elseif M >= 1 then
      do return LT.Textf, "SocializeOnLineTime_Month", math.floor(M) end
      return LT.Textf, "SocializeOnLineTime_Month", math.floor(M)
    elseif d >= 1 then
      do return LT.Textf, "SocializeOnLineTime_Day", math.min(math.floor(d)) end
      return LT.Textf, "SocializeOnLineTime_Day", math.min(math.floor(d))
    elseif h >= 1 then
      do return LT.Textf, "SocializeOnLineTime_Hour", math.floor(h) end
      return LT.Textf, "SocializeOnLineTime_Hour", math.floor(h)
    end
    do return LT.Textf, "SocializeOnLineTime_Minute", math.floor(math.max(1, m)) end
    return LT.Textf, "SocializeOnLineTime_Minute", math.floor(math.max(1, m))
  end
  do return SocialStateUtils.GetStateDesc end
  return SocialStateUtils.GetStateDesc, stateKey, TimeUtils.GetSocialTime(ts)
end

function SocialDataUtils.CreateAttentionBtnCom(binder, assistData, uiBtn_Attention, RefreshCall, attentionCb, socialNoteSuccess)
  local facade = assistData.playerInfo
  local isCorrelations = facade.relation == SocialDefine.SocialRelationType.Cor
  local isMyAttention = facade.relation == SocialDefine.SocialRelationType.Atten
  binder:BindZ1Button(uiBtn_Attention, function()
    if isCorrelations or isMyAttention then
      local dropGroupData = {
        dropList = {
          {
            text = LT.Text("FriendGame"),
            callback = function()
              FriendMatchMgr.Instance:LaunchFriendGame(facade)
            end,
            checkUnlockFunc = function()
              do return FriendMatchMgr.Instance.IsCanFriendGame, FriendMatchMgr.Instance end
              return FriendMatchMgr.Instance.IsCanFriendGame, FriendMatchMgr.Instance, facade
            end
          },
          {
            text = LT.Text("SocialSystemModifyRemarks"),
            callback = function()
              SocialDataUtils.ChangeRemark(facade, socialNoteSuccess, RefreshCall)
            end
          },
          {
            text = LT.Text("SocialSystemCancelFollow"),
            callback = function()
              SocialDataUtils.CancelFollow(facade, attentionCb, RefreshCall)
            end
          },
          {
            text = SocialDataUtils.GetStarAssistText(assistData),
            callback = function()
              SocialDataUtils.SetStarAssist(assistData, RefreshCall)
            end
          }
        },
        parentNode = uiBtn_Attention,
        maskClickFunc = function()
        end
      }
      binder:BindNewComponentWithMask(UIManager.GetTipPopRoot(), SocialPlayerListDropItem, UI_Social_Dropdown_GroupResource, dropGroupData)
      return
    end
    SocialDataUtils.ReqOnSocialAttention(facade.uid, function(newRelation)
      if attentionCb then
        attentionCb(newRelation)
      end
      if RefreshCall then
        RefreshCall()
      end
    end)
  end, function()
    if isCorrelations then
      return CommonDefine.Z1ButtonState.Unclickable
    elseif isMyAttention then
      return CommonDefine.Z1ButtonState.High
    end
    return CommonDefine.Z1ButtonState.Normal
  end)
end

function SocialDataUtils.ChangeRemark(facade, socialNoteSuccess, RefreshCall)
  local panelData = {
    title = LT.Text("SocialSystemSetRemarks"),
    tips = LT.Textf("SocialSystemLeaveNoteName", SocialDataUtils.GetPlayerName(facade)),
    oriName = LT.Text(SocialDataUtils.GetPlayerName(facade, true)),
    confirmFunc = function(nickName, cb)
      if "" == nickName then
        SocialDataUtils.ReqOnCancelNote(facade.uid, function()
          if RefreshCall then
            RefreshCall()
          end
          if cb then
            cb()
          end
        end)
      else
        SocialDataUtils.ReqOnSocialNote(facade.uid, nickName, function()
          if socialNoteSuccess then
            socialNoteSuccess(nickName)
          end
          local myPlayer = SocialDataUtils.GetMyPlayer()
          if myPlayer and myPlayer.uid2NickName then
            myPlayer.uid2NickName[facade.uid] = nickName
            if RefreshCall then
              RefreshCall()
            end
          end
          if cb then
            cb()
          end
        end)
      end
    end,
    inputFieldDefaultStr = LT.Text("SocialSystemEnterNoteName")
  }
  UIManager.Instance:Reopen(Urls.SocialRenamePanel, panelData)
end

function SocialDataUtils.CancelFollow(facade, attentionCb, RefreshCall)
  local tipsId = 20102
  local tipsCfg = DT.TipsType[tipsId]
  Alert.Show(tipsId, nil, function()
    SocialDataUtils.ReqOnSocialCancelAttention(facade.uid, function(_, newRelation)
      print("ReqOnSocialCancelAttention : ", newRelation)
      if attentionCb then
        attentionCb(newRelation)
      end
      if RefreshCall then
        RefreshCall()
      end
    end)
  end, nil, LT.Textf(tipsCfg.Desc, LT.Text(SocialDataUtils.GetPlayerName(facade))))
end

function SocialDataUtils.GetStarAssistText(assistData)
  local set = assistData.isStarAssist
  return set and LT.Text("SocialSystemCancelCommonUseBattleHelp") or LT.Text("SocialSystemCommonUseBattleHelp")
end

function SocialDataUtils.SetStarAssist(assistData, RefreshCall)
  local set = not assistData.isStarAssist
  SocialDataUtils.ReqSetStarAssist(assistData, set, RefreshCall)
end

local relationListType2LimitMap = {
  [SocialDefine.RelationListType.Attention] = DT.GetConstant("FollowersNumberLimit"),
  [SocialDefine.RelationListType.Fans] = DT.GetConstant("FanListLimit"),
  [SocialDefine.RelationListType.Visiter] = DT.GetConstant("VisitorListLimit"),
  [SocialDefine.RelationListType.Follow] = DT.GetConstant("FanGrowthListLimit")
}

function SocialDataUtils.GetRelationListLimitByType(type)
  return relationListType2LimitMap[type] or math.maxinteger
end

local TownStateGroup = {
  SocialDefine.OnlineState.MainPanel,
  SocialDefine.OnlineState.Shop,
  SocialDefine.OnlineState.Summon,
  SocialDefine.OnlineState.Activity,
  SocialDefine.OnlineState.MainCopy,
  SocialDefine.OnlineState.Awaker,
  SocialDefine.OnlineState.Challenge,
  SocialDefine.OnlineState.Manual,
  SocialDefine.OnlineState.Battlepass,
  SocialDefine.OnlineState.Bag,
  SocialDefine.OnlineState.Alchemy,
  SocialDefine.OnlineState.Dispatch
}
local BattleStateGroup = {
  SocialDefine.OnlineState.MainCopyInvestigate,
  SocialDefine.OnlineState.DailyCopy,
  SocialDefine.OnlineState.Copy,
  SocialDefine.OnlineState.WeekChallenge,
  SocialDefine.OnlineState.DailyChallenge,
  SocialDefine.OnlineState.WeeklyBoss
}

function SocialDataUtils.GetPlayerStateIcon(stateStr)
  if not stateStr then
    return SocialDefine.SocialOnlineStateIconPath.OnLineTownIcon
  end
  local stateKey, _ = SocialDataUtils.ParseFacadeStateStr(stateStr)
  if table.contains(TownStateGroup, stateKey) then
    return SocialDefine.SocialOnlineStateIconPath.OnLineTownIcon
  elseif table.contains(BattleStateGroup, stateKey) then
    return SocialDefine.SocialOnlineStateIconPath.OnLineBattleIcon
  end
  return SocialDefine.SocialOnlineStateIconPath.OnLineTownIcon
end

function SocialDataUtils.HasOfferLike(targetPlayerUid)
  if not targetPlayerUid or type(targetPlayerUid) ~= "number" then
    return false
  end
  local myPlayerData = SocialDataUtils.GetMyPlayer()
  local goodRecord = myPlayerData.todayGoodRecord and myPlayerData.todayGoodRecord[targetPlayerUid]
  return goodRecord and goodRecord > 0
end

function SocialDataUtils.AddLikeRecord(targetPlayerUid, addLikeNum, timestamp)
  local myPlayerData = SocialDataUtils.GetMyPlayer()
  if myPlayerData and myPlayerData.todayGoodRecord then
    if not myPlayerData.todayGoodRecord[targetPlayerUid] then
      myPlayerData.todayGoodRecord[targetPlayerUid] = addLikeNum
    else
      myPlayerData.todayGoodRecord[targetPlayerUid] = myPlayerData.todayGoodRecord[targetPlayerUid] + addLikeNum
    end
  end
end

function SocialDataUtils.ToggleUnfollow(clientId)
  if SocialData.unfollowingList[clientId] then
    SocialData.unfollowingList[clientId] = nil
  else
    SocialData.unfollowingList[clientId] = true
  end
  return SocialData.unfollowingList[clientId]
end

function SocialDataUtils.SetUnfollow(unf, cb, cancelCb)
  local function callback()
    SocialData.isUnfollowing = unf
    
    SocialData.unfollowingList = {}
    if cb then
      cb()
    end
    EventMgr.Instance.SocialUnfollow:Dispatch()
  end
  
  if not unf then
    if SocialDataUtils.GetUnfollowListLen() > 0 then
      print("soc check unfollow1", unf, SocialDataUtils.GetUnfollowListLen())
      Alert.SetMaskClickClose(true)
      Alert.Show(20358, cancelCb, callback)
    else
      callback()
    end
  else
    callback()
  end
end

function SocialDataUtils.GetUnfollowListLen()
  local len = 0
  for key, _ in pairs(SocialData.unfollowingList) do
    if key then
      len = len + 1
    end
  end
  return len
end

function SocialDataUtils.CheckUnfollowing(cb, cancelCb)
  print("soc check unfollow", SocialData.isUnfollowing, SocialDataUtils.GetUnfollowListLen())
  if SocialData.isUnfollowing and SocialDataUtils.GetUnfollowListLen() > 0 then
    SocialDataUtils.SetUnfollow(false, cb, cancelCb)
  else
    SocialData.isUnfollowing = false
    SocialData.unfollowingList = {}
    EventMgr.Instance.SocialUnfollow:Dispatch()
    if cb then
      cb()
    end
  end
end

function SocialDataUtils.ExecuteUnfollow(cb)
  local function callback()
    local unfollowingTidList = {}
    
    for clientId, _ in pairs(SocialData.unfollowingList) do
      table.insert(unfollowingTidList, clientId)
    end
    SocialDataUtils.ReqOnSocialCancelAttention(unfollowingTidList, function(targetUid, newRelation)
      local facadeData = SocialDataUtils.GetFollowFacadeByUid(targetUid)
      if facadeData then
        facadeData.relation = newRelation
      end
      EventMgr.Instance.SocialUnfollow:Dispatch()
    end)
    SocialData.isUnfollowing = false
    SocialData.unfollowingList = {}
    cb()
  end
  
  local desc = LT.Textf(DT.TipsType[20357].Desc, SocialDataUtils.GetUnfollowListLen())
  Alert.SetMaskClickClose(true)
  Alert.Show(20357, nil, callback, nil, desc)
end

function SocialDataUtils.HasFollowableInList(followList)
  for _, userData in pairs(followList or {}) do
    if userData.relation == SocialDefine.SocialRelationType.UnAtten or userData.relation == SocialDefine.SocialRelationType.MyFans then
      return true
    end
  end
  return false
end

function SocialDataUtils.ExecuteFollowAll(followList, isAlert, cb)
  local MAX_FAN_LIMIT = SocialDataUtils.GetAttentionLimit()
  local canFollowCount = SocialDataUtils.GetCanFollowCount()
  if canFollowCount <= 0 then
    Alert.Show(10744)
    return
  end
  local followTidList = {}
  local unfollowCount = 0
  local indexMap = {}
  for ind, userData in pairs(followList or {}) do
    if userData.relation == SocialDefine.SocialRelationType.UnAtten or userData.relation == SocialDefine.SocialRelationType.MyFans then
      if canFollowCount > #followTidList then
        table.insert(followTidList, userData.uid)
        indexMap[userData.uid] = ind
      end
      unfollowCount = unfollowCount + 1
    end
  end
  
  local function confirmFunc()
    SocialDataUtils.ReqOnSocialBatchAttention(followTidList, function(targetUid, newRelation)
      EventMgr.Instance.SocialAttention:Dispatch(targetUid, newRelation)
      followList[indexMap[targetUid]].relation = newRelation
    end, cb)
  end
  
  if isAlert then
    local tipId = "FollowBackConfirm"
    local desc = LT.Textf(DT.TipsType[tipId].Desc, unfollowCount, SocialDataUtils.GetAttentionNum(), MAX_FAN_LIMIT)
    Alert.SetMaskClickClose(true)
    Alert.Show(tipId, nil, confirmFunc, nil, desc)
  else
    confirmFunc()
  end
end

return SocialDataUtils
