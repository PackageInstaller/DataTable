local FriendDataCenter = class("FriendDataCenter")
local UserInfoData = require("Game.User.UserInfoData")

function FriendDataCenter:ctor()
  self.__IsFriendDataReceived = false
  self.friendDic = nil
  self.friendList = nil
  self.friendApplyDic = {}
  self.friendApplicationList = {}
  self.blackList = nil
  self.blackDic = nil
  self.recommandFriendDic = nil
  self.recommandFriendList = nil
  self.__appliedFriendDic = nil
  self.__lastFriendDataUpdateTm = nil
  self.__lastReportDesc = nil
  self.__lastRecommendUIDs = {}
  self.__nextRecommendFriendTm = nil
end

function FriendDataCenter:IsFriendDataCenterInited()
  return self.__IsFriendDataReceived
end

function FriendDataCenter:OnReceiveFriendInitData(msg)
  self.__appliedFriendDic = {}
  self.__IsFriendDataReceived = true
  if msg ~= nil then
    if msg.friend ~= nil then
      self.friendList = {}
      self.friendDic = {}
      for uid, avatarMsg in pairs(msg.friend) do
        local friendData = UserInfoData.CreateFriendDataWithAvatarMsg(avatarMsg)
        table.insert(self.friendList, friendData)
        self.friendDic[friendData:GetUserUID()] = friendData
      end
      self:SortFriendList()
    end
    local isReceiveApp = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):ReadIsReceiveFriendApplication()
    if msg.apply ~= nil and isReceiveApp then
      self.friendApplicationList = {}
      self.friendApplyDic = {}
      for uid, avatarMsg in pairs(msg.apply) do
        local friendData = UserInfoData.CreateStrangerDataWithAvatarMsg(avatarMsg)
        table.insert(self.friendApplicationList, friendData)
        self.friendApplyDic[friendData:GetUserUID()] = friendData
      end
      self:UpdateFriendApplyReddotNum()
    end
    if msg.black ~= nil then
      self.blackList = {}
      self.blackDic = {}
      for uid, avatarMsg in pairs(msg.black) do
        local friendData = UserInfoData.CreateStrangerDataWithAvatarMsg(avatarMsg)
        table.insert(self.blackList, friendData)
        self.blackDic[friendData:GetUserUID()] = friendData
      end
    end
    if msg.applyBrief ~= nil and isReceiveApp then
      for _, applyElem in pairs(msg.applyBrief) do
        local friendData = self.friendApplyDic[applyElem.uid]
        if friendData ~= nil then
          friendData:SetApplyTimestamp(applyElem.ts)
        end
      end
      table.sort(self.friendApplicationList, function(a, b)
        if a.__applyTimestamp ~= b.__applyTimestamp then
          return a.__applyTimestamp > b.__applyTimestamp
        end
        return a:GetUserUID() > b:GetUserUID()
      end)
    end
    if msg.aliases ~= nil then
      for uid, alias in pairs(msg.aliases) do
        local friendData = self.friendDic[uid]
        if friendData ~= nil then
          friendData:SetAlias(alias)
        end
      end
    end
    if msg.applyFromMe ~= nil then
      for _, applyElem in pairs(msg.applyFromMe) do
        self:Add2AppliedDic(applyElem.uid)
      end
    end
  end
  self.__lastFriendDataUpdateTm = PlayerDataCenter.timestamp
  local ok, userFriendNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.UserFriend)
  if ok then
    local applyNode = userFriendNode:AddChild(RedDotStaticTypeId.UserFriendApplyPath)
    applyNode:SetRedDotCount(#self.friendApplicationList)
  end
end

function FriendDataCenter:SortFriendList()
  table.sort(self.friendList, function(a, b)
    local aTs = a:GetOnlineState()
    local bTs = b:GetOnlineState()
    if aTs == 0 then
      aTs = math.maxinteger
    end
    if bTs == 0 then
      bTs = math.maxinteger
    end
    if aTs ~= bTs then
      return aTs > bTs
    end
    return a:GetUserUID() > b:GetUserUID()
  end)
end

function FriendDataCenter:UpadteFrendList(dataDic, isDelete)
  for uid, avatarMsg in pairs(dataDic) do
    if not isDelete then
      local friendData = UserInfoData.CreateFriendDataWithAvatarMsg(avatarMsg)
      table.insert(self.friendList, friendData)
      self.friendDic[friendData:GetUserUID()] = friendData
      if self.friendApplyDic[uid] ~= nil then
        local friendData = self.friendApplyDic[uid]
        table.removebyvalue(self.friendApplicationList, friendData)
        self.friendApplyDic[uid] = nil
        self:UpdateFriendApplyReddotNum()
      end
      self:SortFriendList()
    else
      self.friendDic[uid] = nil
      for index, friendData in ipairs(self.friendList) do
        if friendData:GetUserUID() == uid then
          table.remove(self.friendList, index)
          break
        end
      end
    end
  end
  self:RefreshFriendUI()
  MsgCenter:Broadcast(eMsgEventId.OnUserFriendListChange)
end

function FriendDataCenter:UpdateFriendBlackList(dataDic, isDelete)
  for uid, avatarMsg in pairs(dataDic) do
    if not isDelete then
      local friendData = UserInfoData.CreateFriendDataWithAvatarMsg(avatarMsg)
      table.insert(self.blackList, friendData)
      self.blackDic[friendData:GetUserUID()] = friendData
    else
      for index, friendData in ipairs(self.blackList) do
        if friendData:GetUserUID() == uid then
          table.remove(self.blackList, index)
          break
        end
      end
      if self.blackDic[uid] then
        self.blackDic[uid] = nil
      end
    end
  end
  self:RefreshFriendUI()
end

function FriendDataCenter:OnGetNewApplyNotice(msg)
  local isReceiveApp = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):ReadIsReceiveFriendApplication()
  if msg ~= nil then
    if isReceiveApp then
      if msg.applyAvatar == nil or msg.applyAvatar.biref.uid == nil then
        return
      end
      local friendData = self.friendApplyDic[msg.applyAvatar.biref.uid]
      if friendData == nil then
        friendData = UserInfoData.CreateStrangerDataWithAvatarMsg(msg.applyAvatar)
        table.insert(self.friendApplicationList, 1, friendData)
        self.friendApplyDic[friendData:GetUserUID()] = friendData
        if #self.friendApplicationList > ConfigData.game_config.friendApplicationListLimitNum then
          local removeFriendData = table.remove(self.friendApplicationList, 1)
          self.friendApplyDic[removeFriendData:GetUserUID()] = nil
        end
      end
      friendData:SetApplyTimestamp(msg.ts)
      self:UpdateFriendApplyReddotNum()
      self:RefreshFriendUI()
    else
      if msg.applyAvatar == nil or msg.applyAvatar.biref.uid == nil then
        return
      end
      if self.friendNetworkCtrl == nil then
        self.friendNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friend)
      end
      self.friendNetworkCtrl:CS_FRIEND_IgnoreApply(msg.applyAvatar.biref.uid)
    end
  end
end

function FriendDataCenter:UpdateHeroListData(dataDic)
  for uid, avatarMsg in pairs(dataDic) do
    local friendData = self.friendDic[uid]
    friendData:UpdateByAvatarMsg(avatarMsg)
  end
  self:SortFriendList()
  self:RefreshFriendUI()
  self.__lastFriendDataUpdateTm = PlayerDataCenter.timestamp
  MsgCenter:Broadcast(eMsgEventId.OnUserFriendListChange)
end

function FriendDataCenter:BroadCastFriendListChange()
  MsgCenter:Broadcast(eMsgEventId.OnUserFriendListChange)
end

function FriendDataCenter:DeleteApplyNotice(uid)
  local friendData = self.friendApplyDic[uid]
  if friendData ~= nil then
    table.removebyvalue(self.friendApplicationList, friendData)
    self.friendApplyDic[uid] = nil
    self:UpdateFriendApplyReddotNum()
  end
  self:RefreshFriendUI()
end

function FriendDataCenter:GetFreindList()
  return self.friendList
end

function FriendDataCenter:GetFreindNum()
  return #self.friendList
end

function FriendDataCenter:GetFriendApplicationList()
  for uid, friendData in pairs(self.friendApplyDic) do
    if friendData:GetIsApplicationTimeOut() then
      table.removebyvalue(self.friendApplicationList, friendData)
      self.friendApplyDic[uid] = nil
    end
  end
  self:UpdateFriendApplyReddotNum()
  return self.friendApplicationList
end

function FriendDataCenter:TryGetFriendData(uid)
  if self.friendDic == nil then
    return nil
  end
  return self.friendDic[uid]
end

function FriendDataCenter:TryGetFriendApplyData(uid)
  return self.friendApplyDic[uid]
end

function FriendDataCenter:GetIsFriendFull()
  return self:GetFreindNum() >= ConfigData.game_config.friendListLimitNum
end

function FriendDataCenter:GetLastFriendDataUpdateTm()
  return self.__lastFriendDataUpdateTm
end

function FriendDataCenter:IsExpireFriendData()
  local lastTm = self.__lastFriendDataUpdateTm or 0
  return PlayerDataCenter.timestamp - lastTm > ConfigData.game_config.userInfoRefreshTime
end

function FriendDataCenter:RefreshFriendUI()
  local friendWin = UIManager:GetWindow(UIWindowTypeID.UserFreined)
  if friendWin ~= nil then
    friendWin:OnFriendListRefresh()
  end
end

function FriendDataCenter:UpdateFriendUI()
  local friendWin = UIManager:GetWindow(UIWindowTypeID.UserFreined)
  if friendWin ~= nil then
    friendWin:UpdateHeroList()
  end
end

function FriendDataCenter:RefreshFriendApplyReddotNum()
  for uid, friendData in pairs(self.friendApplyDic) do
    if friendData:GetIsApplicationTimeOut() then
      table.removebyvalue(self.friendApplicationList, friendData)
      self.friendApplyDic[uid] = nil
    end
  end
  self:UpdateFriendApplyReddotNum()
end

function FriendDataCenter:UpdateFriendApplyReddotNum()
  local ok, applyNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.UserFriend, RedDotStaticTypeId.UserFriendApplyPath)
  if ok then
    applyNode:SetRedDotCount(#self.friendApplicationList)
  end
end

function FriendDataCenter:SetLastReportDesc(desc)
  self.__lastReportDesc = desc
end

function FriendDataCenter:GetLastReportDesc()
  return self.__lastReportDesc
end

function FriendDataCenter:GetBlackList()
  return self.blackList
end

function FriendDataCenter:GetBlackListNum()
  return #self.blackList
end

function FriendDataCenter:TryGetBlackListData(uid)
  if self.blackDic == nil then
    return nil
  end
  return self.blackDic[uid]
end

function FriendDataCenter:OnReceiveRecommendFriendData(msg)
  if msg.avatar ~= nil then
    self.recommandFriendList = {}
    self.recommandFriendDic = {}
    self.__lastRecommendUIDs = {}
    for uid, avatarMsg in pairs(msg.avatar) do
      local friendData = UserInfoData.CreateStrangerDataWithAvatarMsg(avatarMsg)
      table.insert(self.recommandFriendList, friendData)
      self.recommandFriendDic[friendData:GetUserUID()] = friendData
      table.insert(self.__lastRecommendUIDs, friendData:GetUserUID())
    end
    self:SortRecommendFriendList()
  end
  if msg.nextFreshTm ~= nil then
    self.__nextRecommendFriendTm = msg.nextFreshTm
  end
end

function FriendDataCenter:SortRecommendFriendList()
  table.sort(self.recommandFriendList, function(a, b)
    local aTs = a:GetOnlineState()
    local bTs = b:GetOnlineState()
    if aTs == 0 then
      aTs = math.maxinteger
    end
    if bTs == 0 then
      bTs = math.maxinteger
    end
    if aTs ~= bTs then
      return aTs > bTs
    end
    return a:GetUserLevel() > b:GetUserLevel()
  end)
end

function FriendDataCenter:GetRecommendFriendList()
  return self.recommandFriendList
end

function FriendDataCenter:GetNextRecommendFreshTime()
  return self.__nextRecommendFriendTm
end

function FriendDataCenter:GetLastRecommendUIDs()
  return self.__lastRecommendUIDs
end

function FriendDataCenter:Add2AppliedDic(uid)
  self.__appliedFriendDic[uid] = true
end

function FriendDataCenter:RemoveFromAppliedDic(uid)
  if self.__appliedFriendDic[uid] then
    self.__appliedFriendDic[uid] = nil
  end
end

function FriendDataCenter:HasAppliedUser(uid)
  return self.__appliedFriendDic[uid]
end

function FriendDataCenter:UpdateFriendApplyFromMeAdd(applyFromMeAdd)
  for _, applyElem in pairs(applyFromMeAdd) do
    self:Add2AppliedDic(applyElem.uid)
  end
end

function FriendDataCenter:UpdateFriendApplyFromMeDelete(applyeFromMeDelete)
  for uid, _ in pairs(applyeFromMeDelete) do
    self:RemoveFromAppliedDic(uid)
  end
end

function FriendDataCenter:Delete()
end

return FriendDataCenter
