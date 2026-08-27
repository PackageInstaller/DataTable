local ObjectNetworkCtrl = class("ObjectNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ObjectNetworkCtrl:ctor()
  self.uidMsg = {}
  self.uidListMsg = {}
  self.installSupportMsg = {}
  self.uninstallSupportMsg = {}
  self.sectorUnlockVideoMsg = {}
  self.reqRankDetail = {}
  self.reqRankPercent = {}
  self.op_sync_msg = {}
  self.clientRecordSetTab = {}
  self.avatarTitle = {
    title = {}
  }
  self.enterInterface = {}
end

function ObjectNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SyncUserData, self, proto_csmsg.SC_SyncUserData, self.SC_SyncUserData)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FUNCTION_SyncUpdateDiff, self, proto_csmsg.SC_FUNCTION_SyncUpdateDiff, self.SC_FUNCTION_SyncUpdateDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SyncUserBaseDiff, self, proto_csmsg.SC_SyncUserBaseDiff, self.SC_SyncUserBaseDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_RESOURCE_SyncUpdateDiff, self, proto_csmsg.SC_RESOURCE_SyncUpdateDiff, self.SC_RESOURCE_SyncUpdateDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_SyncUpdateDiff, self, proto_csmsg.SC_HERO_SyncUpdateDiff, self.SC_HERO_SyncUpdateDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_User_UserNameModify, self, proto_csmsg.SC_User_UserNameModify, self.SC_User_UserNameModify)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_GUIDE_TriggerComplete, self, proto_csmsg.SC_GUIDE_TriggerComplete, self.SC_GUIDE_TriggerComplete)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_User_ModifyShowGirl, self, proto_csmsg.SC_User_ModifyShowGirl, self.SC_User_ModifyShowGirl)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_User_ClientLastSectorMention, self, proto_csmsg.SC_User_ClientLastSectorMention, self.SC_User_ClientLastSectorMention)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_COUNTER_Detail, self, proto_csmsg.SC_COUNTER_Detail, self.SC_COUNTER_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_COUNTER_SyncUpdateDiff, self, proto_csmsg.SC_COUNTER_SyncUpdateDiff, self.SC_COUNTER_SyncUpdateDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BLITZ_Blitz, self, proto_csmsg.SC_BLITZ_Blitz, self.SC_BLITZ_Blitz)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_User_SystemOverDay, self, proto_csmsg.SC_User_SystemOverDay, self.SC_User_SystemOverDay)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_User_SyncDiff, self, proto_csmsg.SC_User_SyncDiff, self.SC_User_SyncDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_User_AvatarModify, self, proto_csmsg.SC_User_AvatarModify, self.SC_User_AvatarModify)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_User_SignatureMod, self, proto_csmsg.SC_User_SignatureMod, self.SC_User_SignatureMod)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_User_AvatarFrameMod, self, proto_csmsg.SC_User_AvatarFrameMod, self.SC_User_AvatarFrameMod)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_User_SetTitle, self, proto_csmsg.SC_User_SetTitle, self.SC_User_SetTitle)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_User_SexMod, self, proto_csmsg.SC_User_SexMod, self.SC_User_SexMod)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_User_BGPlateMod, self, proto_csmsg.SC_User_BGPlateMod, self.SC_User_BGPlateMod)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_AVATAR_Fetch, self, proto_csmsg.SC_AVATAR_Fetch, self.SC_AVATAR_Fetch)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_AVATAR_Fetch_Multi, self, proto_csmsg.SC_AVATAR_Fetch_Multi, self.SC_AVATAR_Fetch_Multi)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ASSISTANT_Install, self, proto_csmsg.SC_ASSISTANT_Install, self.SC_ASSISTANT_Install)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ASSISTANT_Uninstall, self, proto_csmsg.SC_ASSISTANT_Uninstall, self.SC_ASSISTANT_Uninstall)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ASSISTANT_FetchStranger, self, proto_csmsg.SC_ASSISTANT_FetchStranger, self.SC_ASSISTANT_FetchStranger)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_User_ModifySectorUnlockVideo, self, proto_csmsg.SC_User_ModifySectorUnlockVideo, self.SC_User_ModifySectorUnlockVideo)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Rank_Detail, self, proto_csmsg.SC_Rank_Detail, self.SC_Rank_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Rank_Percent, self, proto_csmsg.SC_Rank_Percent, self.SC_Rank_Percent)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ResourceDecryptionNtf, self, proto_csmsg.SC_ResourceDecryptionNtf, self.SC_ResourceDecryptionNtf)
end

function ObjectNetworkCtrl:WaitUserPreData()
  CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_SC_SyncUserData, function(listObj)
    PlayerDataCenter:OnPreDataRecvComplete()
  end, proto_csmsg_MSG_ID.MSG_SC_SyncUserData, proto_csmsg_MSG_ID.MSG_SC_BUILDING_Detail, proto_csmsg_MSG_ID.MSG_SC_SECTOR_Detail, proto_csmsg_MSG_ID.MSG_SC_EFFECTOR_ResourceGenerator, proto_csmsg_MSG_ID.MSG_SC_ENDLESS_Detail, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Detail, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Detail, proto_csmsg_MSG_ID.MSG_SC_MainInterface_Detail, proto_csmsg_MSG_ID.MSG_SC_INTIMACY_Detail)
end

function ObjectNetworkCtrl:AddNewWaitUserPreData(waitMsgId)
  local waitUtil = CS.WaitNetworkResponse.Instance
  if not waitUtil:ContainWait(proto_csmsg_MSG_ID.MSG_SC_SyncUserData) then
    return
  end
  waitUtil:StartOrAddWait(proto_csmsg_MSG_ID.MSG_SC_SyncUserData, waitMsgId)
end

function ObjectNetworkCtrl:SC_SyncUserData(msg)
  PlayerDataCenter:SyncUserData(msg)
  CS.NetworkManager.Instance:SetTimeHeartActive(true)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ObjectNetworkCtrl:SC_FUNCTION_SyncUpdateDiff(msg)
  for k, v in pairs(msg.updates) do
    local openCfg = ConfigData.system_open[k]
    if openCfg ~= nil and openCfg.screening then
    else
      FunctionUnlockMgr:AddUnlockFunction(k)
    end
  end
  for k, v in pairs(msg.deletes) do
    FunctionUnlockMgr:RemoveUnlockFunction(k)
  end
end

function ObjectNetworkCtrl:userBaseDiff(diffMsg)
  if diffMsg.level ~= nil then
    PlayerDataCenter.playerLevel:UpdatePlayerLevelData(diffMsg.level.level, diffMsg.level.exp)
  end
  if diffMsg.doc ~= nil then
    PlayerDataCenter.inforData:UpdateUserDoc(diffMsg.doc)
  end
  if diffMsg.point ~= nil then
    PlayerDataCenter.inforData:SetSupportPointData(diffMsg.point)
  end
end

function ObjectNetworkCtrl:SC_SyncUserBaseDiff(msg)
  if msg.level ~= nil then
    PlayerDataCenter.playerLevel:UpdatePlayerLevelData(msg.level.level, msg.level.exp)
  end
end

function ObjectNetworkCtrl:ItemDiff(diffMsg)
  PlayerDataCenter:SyncItemUpdateDiff(diffMsg)
end

function ObjectNetworkCtrl:SC_RESOURCE_SyncUpdateDiff(msg)
  PlayerDataCenter:SyncItemUpdateDiff(msg)
end

function ObjectNetworkCtrl:SC_HERO_SyncUpdateDiff(msg)
  PlayerDataCenter:SyncHeroUpdateDiff(msg)
end

function ObjectNetworkCtrl:CS_User_UserNameModify(name, successAction)
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_ChangeName) then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(393))
    return
  end
  local createMsg = {name = name}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_UserNameModify, proto_csmsg.CS_User_UserNameModify, createMsg)
  CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_CS_User_UserNameModify, function()
    PlayerDataCenter:UpdateUserNameData(name)
    if successAction ~= nil then
      successAction()
    end
  end, proto_csmsg_MSG_ID.MSG_SC_User_UserNameModify)
end

function ObjectNetworkCtrl:SC_User_UserNameModify(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
  elseif msg.ret == proto_csmsg_ErrorCode.INVALID_CHARACTER_INPUT then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.name_Illegal))
    CS.WaitNetworkResponse.Instance:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_UserNameModify)
  else
    local err = "ObjectNetworkCtrl:SC_User_UserNameModify error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    CS.WaitNetworkResponse.Instance:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_UserNameModify)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ObjectNetworkCtrl:CS_User_SexMod(sex, successAction)
  local createMsg = {sex = sex}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_SexMod, proto_csmsg.CS_User_SexMod, createMsg)
  CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_CS_User_SexMod, function()
    PlayerDataCenter.inforData:SetSex(sex)
    if successAction ~= nil then
      successAction()
    end
  end, proto_csmsg_MSG_ID.MSG_SC_User_SexMod)
end

function ObjectNetworkCtrl:SC_User_SexMod(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ObjectNetworkCtrl:SC_User_SexMod error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    CS.WaitNetworkResponse.Instance:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_SexMod)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ObjectNetworkCtrl:CS_User_AvatarModify(id, successAction)
  local createMsg = {id = id}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_AvatarModify, proto_csmsg.CS_User_AvatarModify, createMsg)
  CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_CS_User_AvatarModify, function()
    PlayerDataCenter.inforData.avatarId = id
    if successAction ~= nil then
      successAction()
    end
  end, proto_csmsg_MSG_ID.MSG_SC_User_AvatarModify)
end

function ObjectNetworkCtrl:SC_User_AvatarModify(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ObjectNetworkCtrl:SC_User_AvatarModify error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    CS.WaitNetworkResponse.Instance:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_AvatarModify)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ObjectNetworkCtrl:CS_User_AvatarFrameMod(id, successAction)
  local createMsg = {id = id}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_AvatarFrameMod, proto_csmsg.CS_User_AvatarFrameMod, createMsg)
  CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_CS_User_AvatarFrameMod, function()
    PlayerDataCenter.inforData.avatarFrameId = id
    if successAction ~= nil then
      successAction()
    end
  end, proto_csmsg_MSG_ID.MSG_SC_User_AvatarFrameMod)
end

function ObjectNetworkCtrl:SC_User_AvatarFrameMod(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ObjectNetworkCtrl:SC_User_AvatarFrameMod error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    CS.WaitNetworkResponse.Instance:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_AvatarFrameMod)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ObjectNetworkCtrl:CS_User_SetTitle(titlePrefix, titlePostfix, titleBackGround, successAction)
  self.avatarTitle.title = {}
  self.avatarTitle.title.titlePrefix = titlePrefix or 0
  self.avatarTitle.title.titlePostfix = titlePostfix or 0
  self.avatarTitle.title.titleBackGround = titleBackGround or 0
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_SetTitle, proto_csmsg.CS_User_SetTitle, self.avatarTitle)
  CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_CS_User_SetTitle, successAction, proto_csmsg_MSG_ID.MSG_SC_User_SetTitle)
end

function ObjectNetworkCtrl:SC_User_SetTitle(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ObjectNetworkCtrl:SC_User_SetTitle error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    CS.WaitNetworkResponse.Instance:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_SetTitle)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ObjectNetworkCtrl:CS_User_SignatureMod(signature, successAction)
  local createMsg = {sign = signature}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_SignatureMod, proto_csmsg.CS_User_SignatureMod, createMsg)
  CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_CS_User_SignatureMod, function()
    PlayerDataCenter.inforData.signature = signature
    if successAction ~= nil then
      successAction()
    end
  end, proto_csmsg_MSG_ID.MSG_SC_User_SignatureMod)
end

function ObjectNetworkCtrl:SC_User_SignatureMod(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
  elseif msg.ret == proto_csmsg_ErrorCode.USER_SIGN_LEN_LIMIT then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Signature_Illegal))
    CS.WaitNetworkResponse.Instance:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_SignatureMod)
  elseif msg.ret == proto_csmsg_ErrorCode.INVALID_CHARACTER_INPUT then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Signature_Illegal))
    CS.WaitNetworkResponse.Instance:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_SignatureMod)
  elseif msg.ret == proto_csmsg_ErrorCode.FUNCTION_NOT_OPEN then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(393))
    CS.WaitNetworkResponse.Instance:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_SignatureMod)
  else
    local err = "ObjectNetworkCtrl:SC_User_SignatureMod error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    CS.WaitNetworkResponse.Instance:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_SignatureMod)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ObjectNetworkCtrl:CS_User_BGPlateMod(id, successAction)
  local createMsg = {id = id}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_BGPlateMod, proto_csmsg.CS_User_BGPlateMod, createMsg)
  CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_CS_User_BGPlateMod, function()
    PlayerDataCenter.inforData.backgroudPlateId = id
    if successAction ~= nil then
      successAction()
    end
  end, proto_csmsg_MSG_ID.MSG_SC_User_BGPlateMod)
end

function ObjectNetworkCtrl:SC_User_BGPlateMod(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ObjectNetworkCtrl:SC_User_BGPlateMod error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    CS.WaitNetworkResponse.Instance:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_BGPlateMod)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ObjectNetworkCtrl:CS_User_ModifyShowGirl(id)
  local msg = {id = id}
  PlayerDataCenter.showGirlId = id
  if PlayerDataCenter.inforData ~= nil then
    PlayerDataCenter.inforData.showGirlId = id
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_ModifyShowGirl, proto_csmsg.CS_User_ModifyShowGirl, msg)
  CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_CS_User_ModifyShowGirl, proto_csmsg_MSG_ID.MSG_SC_User_ModifyShowGirl)
end

function ObjectNetworkCtrl:SC_User_ModifyShowGirl(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ObjectNetworkCtrl:SC_User_ModifyShowGirl error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    CS.WaitNetworkResponse.Instance:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_ModifyShowGirl)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ObjectNetworkCtrl:CS_GUIDE_TriggerComplete(guideId, action)
  local sendMsg = {id = guideId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_GUIDE_TriggerComplete, proto_csmsg.CS_GUIDE_TriggerComplete, sendMsg)
  if action ~= nil then
    CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_CS_GUIDE_TriggerComplete, action, proto_csmsg_MSG_ID.MSG_SC_GUIDE_TriggerComplete)
  end
end

function ObjectNetworkCtrl:SC_GUIDE_TriggerComplete(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ObjectNetworkCtrl:CS_User_ClientLastSectorMention(sectorMentionId, callback)
  local msg = {id = sectorMentionId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_ClientLastSectorMention, proto_csmsg.CS_User_ClientLastSectorMention, msg)
  CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_CS_User_ClientLastSectorMention, callback, proto_csmsg_MSG_ID.MSG_SC_User_ClientLastSectorMention)
end

function ObjectNetworkCtrl:SC_User_ClientLastSectorMention(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ObjectNetworkCtrl:SC_User_ClientLastSectorMention error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    CS.WaitNetworkResponse.Instance:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_ClientLastSectorMention)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ObjectNetworkCtrl:CS_COUNTER_Detail(callback)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_COUNTER_Detail, proto_csmsg.CS_COUNTER_Detail, table.emptytable)
  CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_CS_COUNTER_Detail, callback, proto_csmsg_MSG_ID.MSG_SC_COUNTER_Detail)
end

function ObjectNetworkCtrl:SC_COUNTER_Detail(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ObjectNetworkCtrl:SC_COUNTER_Detail error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    CS.WaitNetworkResponse.Instance:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_COUNTER_Detail)
  else
    CS.WaitNetworkResponse.Instance:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_COUNTER_Detail, msg.data)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ObjectNetworkCtrl:SC_COUNTER_SyncUpdateDiff(msg)
  ControllerManager:GetController(ControllerTypeId.TimePass, true):OnUpdateTimePassData(msg)
end

function ObjectNetworkCtrl:CS_User_SystemOverDay()
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_SystemOverDay, proto_csmsg.CS_User_SystemOverDay, table.emptytable)
  CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_CS_User_SystemOverDay, proto_csmsg_MSG_ID.MSG_SC_User_SystemOverDay)
end

function ObjectNetworkCtrl:SC_User_SystemOverDay(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ObjectNetworkCtrl:SC_User_SystemOverDay error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    CS.WaitNetworkResponse.Instance:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_SystemOverDay)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ObjectNetworkCtrl:CS_BLITZ_Blitz(dungeonId, count)
  count = count or 1
  local sendMsg = {cnt = count, dungeonId = dungeonId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BLITZ_Blitz, proto_csmsg.CS_BLITZ_Blitz, sendMsg)
  CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_CS_BLITZ_Blitz, callback, proto_csmsg_MSG_ID.MSG_SC_BLITZ_Blitz)
end

function ObjectNetworkCtrl:SC_BLITZ_Blitz(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ObjectNetworkCtrl:SC_BLITZ_Blitz error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    CS.WaitNetworkResponse.Instance:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BLITZ_Blitz)
    return
  end
  if #msg.rewards == 0 then
    return
  end
  local reward = msg.rewards[1]
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    if window == nil then
      return
    end
    local rewardIds = {}
    local rewardNums = {}
    for _, data in pairs(reward.data) do
      table.insert(rewardIds, data.id)
      table.insert(rewardNums, data.num * data.stacking)
    end
    local CommonRewardData = require("Game.CommonUI.CommonRewardData")
    local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums):SetCRRewardTips(ConfigData:GetTipContent(291))
    window:AddAndTryShowReward(CRData)
  end)
end

function ObjectNetworkCtrl:CS_AVATAR_Fetch(uid, callback)
  self.uidMsg.uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_AVATAR_Fetch, proto_csmsg.CS_AVATAR_Fetch, self.uidMsg)
  CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_CS_AVATAR_Fetch, callback, proto_csmsg_MSG_ID.MSG_SC_AVATAR_Fetch)
end

function ObjectNetworkCtrl:SC_AVATAR_Fetch(msg)
  if msg.avatar == nil then
    CS.WaitNetworkResponse.Instance:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_AVATAR_Fetch, false)
  else
    CS.WaitNetworkResponse.Instance:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_AVATAR_Fetch, msg.avatar)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ObjectNetworkCtrl:CS_AVATAR_Fetch_Multi(userIdList, callback)
  self.uidListMsg.uids = userIdList
  self.CS_AVATAR_Fetch_MultiCallback = callback
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_AVATAR_Fetch_Multi, proto_csmsg.CS_AVATAR_Fetch_Multi, self.uidListMsg)
  CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_CS_AVATAR_Fetch_Multi, nil, proto_csmsg_MSG_ID.MSG_SC_AVATAR_Fetch_Multi)
end

function ObjectNetworkCtrl:SC_AVATAR_Fetch_Multi(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ObjectNetworkCtrl:SC_BLITZ_Blitz error:" .. tostring(msg.ret)
    error(err)
    CS.MessageCommon.ShowMessageTips(err)
    CS.WaitNetworkResponse.Instance:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_AVATAR_Fetch_Multi)
  end
  if self.CS_AVATAR_Fetch_MultiCallback ~= nil then
    self.CS_AVATAR_Fetch_MultiCallback(msg.avatar)
    self.CS_AVATAR_Fetch_MultiCallback = nil
  end
end

function ObjectNetworkCtrl:CS_User_ModifySectorUnlockVideo(secId)
  self.sectorUnlockVideoMsg.secId = secId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_User_ModifySectorUnlockVideo, proto_csmsg.CS_User_ModifySectorUnlockVideo, self.sectorUnlockVideoMsg)
  CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_CS_User_ModifySectorUnlockVideo, proto_csmsg_MSG_ID.MSG_SC_User_ModifySectorUnlockVideo)
end

function ObjectNetworkCtrl:SC_User_ModifySectorUnlockVideo(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ObjectNetworkCtrl:SC_User_ModifySectorUnlockVideo error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    CS.WaitNetworkResponse.Instance:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_User_ModifySectorUnlockVideo)
    return
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ObjectNetworkCtrl:CS_ASSISTANT_Install(heroId, index, callback)
  self.installSupportMsg.heroId = heroId
  self.installSupportMsg.idx = index - 1
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ASSISTANT_Install, proto_csmsg.CS_ASSISTANT_Install, self.installSupportMsg)
  CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_CS_ASSISTANT_Install, callback, proto_csmsg_MSG_ID.MSG_SC_ASSISTANT_Install)
end

function ObjectNetworkCtrl:SC_ASSISTANT_Install(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ObjectNetworkCtrl:SC_ASSISTANT_Install error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    CS.WaitNetworkResponse.Instance:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ASSISTANT_Install)
    return
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ObjectNetworkCtrl:CS_ASSISTANT_Uninstall(heroId, callback)
  self.uninstallSupportMsg.heroId = heroId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ASSISTANT_Uninstall, proto_csmsg.CS_ASSISTANT_Uninstall, self.uninstallSupportMsg)
  CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_CS_ASSISTANT_Uninstall, callback, proto_csmsg_MSG_ID.MSG_SC_ASSISTANT_Uninstall)
end

function ObjectNetworkCtrl:SC_ASSISTANT_Uninstall(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ObjectNetworkCtrl:SC_ASSISTANT_Uninstall error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    CS.WaitNetworkResponse.Instance:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ASSISTANT_Uninstall)
    return
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ObjectNetworkCtrl:CS_ASSISTANT_FetchStranger(callback, isFactorCard)
  local msg = {assistantFactorCard = isFactorCard}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ASSISTANT_FetchStranger, proto_csmsg.CS_ASSISTANT_FetchStranger, msg)
  CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_CS_ASSISTANT_FetchStranger, callback, proto_csmsg_MSG_ID.MSG_SC_ASSISTANT_FetchStranger)
end

function ObjectNetworkCtrl:SC_ASSISTANT_FetchStranger(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ObjectNetworkCtrl:SC_ASSISTANT_FetchStranger error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    CS.WaitNetworkResponse.Instance:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ASSISTANT_FetchStranger)
    return
  else
    CS.WaitNetworkResponse.Instance:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ASSISTANT_FetchStranger, msg)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ObjectNetworkCtrl:SC_User_SyncDiff(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ObjectNetworkCtrl:CS_Rank_Detail(rankId, pageId, callback)
  self.reqRankDetail.rankId = rankId
  self.reqRankDetail.pageId = pageId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Rank_Detail, proto_csmsg.CS_Rank_Detail, self.reqRankDetail)
  CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_CS_Rank_Detail, callback, proto_csmsg_MSG_ID.MSG_SC_Rank_Detail)
end

function ObjectNetworkCtrl:SC_Rank_Detail(msg)
  CS.WaitNetworkResponse.Instance:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Rank_Detail, msg)
  local commonRankWindwow = UIManager:GetWindow(UIWindowTypeID.CommonRank)
  if commonRankWindwow ~= nil then
    commonRankWindwow:ReceiveRankFromServer(msg)
  end
end

function ObjectNetworkCtrl:CS_Rank_Percent(rankId, startNum, endNum, callback)
  self.reqRankPercent.rankId = rankId
  self.reqRankPercent.IntervalStart = startNum
  self.reqRankPercent.IntervalEnd = endNum
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Rank_Percent, proto_csmsg.CS_Rank_Percent, self.reqRankPercent)
  CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_CS_Rank_Percent, callback, proto_csmsg_MSG_ID.MSG_SC_Rank_Percent)
end

function ObjectNetworkCtrl:SC_Rank_Percent(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ObjectNetworkCtrl:SC_Rank_Percent error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    CS.WaitNetworkResponse.Instance:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Rank_Percent)
    return
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  CS.WaitNetworkResponse.Instance:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Rank_Percent, msg)
end

function ObjectNetworkCtrl:CS_CLIENT_OP_SYNC(buttonClickDic)
  self.op_sync_msg.buttonClick = buttonClickDic
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_CLIENT_OP_SYNC, proto_csmsg.CS_CLIENT_OP_SYNC, self.op_sync_msg)
end

function ObjectNetworkCtrl:ReqRecordActLongIdEnter(actFrameId)
  self:CS_Client_Record_Set({actLongIdEnter = actFrameId})
end

function ObjectNetworkCtrl:CS_Client_Record_Set(recordDic)
  self.clientRecordSetTab.describes = recordDic.describes
  self.clientRecordSetTab.setting = recordDic.setting
  self.clientRecordSetTab.newTitleRead = recordDic.newTitleRead
  self.clientRecordSetTab.ActivityAnswerOpId = recordDic.ActivityAnswerOpId
  self.clientRecordSetTab.actLongIdEnter = recordDic.actLongIdEnter
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Client_Record_Set, proto_csmsg.CS_Client_Record_Set, self.clientRecordSetTab)
end

function ObjectNetworkCtrl:CS_Client_Enter_Interface(interfaceId, dungeonId)
  self.enterInterface.interfaceId = interfaceId
  self.enterInterface.dungeonId = dungeonId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Client_Enter_Interface, proto_csmsg.CS_Client_Enter_Interface, self.enterInterface)
end

function ObjectNetworkCtrl:SC_ResourceDecryptionNtf(msg)
  HotResDecryptManager.TryDecryptHotRes(msg.data)
end

function ObjectNetworkCtrl:Reset()
end

return ObjectNetworkCtrl
