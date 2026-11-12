local PlayerFriendData = class("PlayerFriendData")
local TimerManager = require("GameCore.Timer.TimerManager")
local EnergyState = {
  None = 0,
  Able = 1,
  Received = 2
}

function PlayerFriendData:Init()
  self._tbFriendList = {}
  self._tbFriendRequest = {}
  self._nFriendListNum = 0
  self._nFriendRequestNum = 0
  self._nEnergyCount = 0
  self._nPerReceiveEnergyConfig = ConfigTable.GetConfigNumber("FriendReceiveEnergyCount")
  self._nMaxReceiveEnergyConfig = ConfigTable.GetConfigNumber("FriendReceiveEnergyMax")
  self.bAddStrangerWarning = true
end

function PlayerFriendData:CacheFriendData(mapMsgData)
  self._tbFriendList = {}
  self._nFriendListNum = 0
  if mapMsgData.ReceiveEnergyCnt then
    self._nEnergyCount = mapMsgData.ReceiveEnergyCnt
  end
  for _, mapFriendInfo in pairs(mapMsgData.Friends) do
    local nId = mapFriendInfo.Base and mapFriendInfo.Base.Id or mapFriendInfo.Id
    self._tbFriendList[nId] = {}
    self:ParseFriendData(self._tbFriendList[nId], mapFriendInfo)
    self._nFriendListNum = self._nFriendListNum + 1
  end
  self._tbFriendRequest = {}
  self._nFriendRequestNum = 0
  for nIndex, mapFriendInfo in pairs(mapMsgData.Invites) do
    self._tbFriendRequest[nIndex] = {}
    self:ParseFriendData(self._tbFriendRequest[nIndex], mapFriendInfo)
    self._nFriendRequestNum = self._nFriendRequestNum + 1
  end
  self:UpdateFriendApplyRedDot()
  self:UpdateFriendEnergyRedDot()
end

function PlayerFriendData:ParseFriendData(tbData, tbServer)
  if tbServer.Base then
    self:ParseFriendDetail(tbData, tbServer.Base)
    tbData.nGetEnergy = tbServer.GetEnergy
    tbData.bSendEnergy = tbServer.SendEnergy
    tbData.bStar = tbServer.Star
  else
    self:ParseFriendDetail(tbData, tbServer)
  end
end

function PlayerFriendData:ParseFriendDetail(tbData, tbServer)
  tbData.nHashtag = tbServer.Hashtag
  tbData.nHeadIconId = tbServer.HeadIcon
  tbData.nUId = tbServer.Id
  tbData.nLogin = tbServer.LastLoginTime
  tbData.sName = tbServer.NickName
  tbData.nTitlePrefix = tbServer.TitlePrefix
  tbData.nTitleSuffix = tbServer.TitleSuffix
  tbData.sName = tbServer.NickName
  tbData.nWorldClass = tbServer.WorldClass
  tbData.tbChar = tbServer.CharShows
  tbData.sSign = tbServer.Signature
  tbData.tbHonorTitle = tbServer.Honors
end

function PlayerFriendData:GetFriendListData()
  local tbList = {}
  if not self._tbFriendList then
    return tbList
  end
  for _, v in pairs(self._tbFriendList) do
    table.insert(tbList, v)
  end
  table.sort(tbList, function(a, b)
    if a.bStar ~= b.bStar then
      return a.bStar and not b.bStar
    else
      return a.nUId < b.nUId
    end
  end)
  return tbList
end

function PlayerFriendData:GetFriendDetailData(nUid)
  return self._tbFriendList[nUid]
end

function PlayerFriendData:GetFriendListNum()
  return self._nFriendListNum
end

function PlayerFriendData:GetFriendRequestData()
  return self._tbFriendRequest
end

function PlayerFriendData:GetFriendRequestNum()
  return self._nFriendRequestNum
end

function PlayerFriendData:JudgeIsFriend(nUId)
  return self._tbFriendList and self._tbFriendList[nUId]
end

function PlayerFriendData:GetEnergyCount()
  return self._nEnergyCount
end

function PlayerFriendData:CacheFriendAddStranger(mapFriend)
  self.mapStrangerFriend = mapFriend
end

function PlayerFriendData:TryOpenFriendAddStranger()
  if not self.mapStrangerFriend or not self.bAddStrangerWarning then
    return
  end
  local mapFriend = clone(self.mapStrangerFriend)
  self.mapStrangerFriend = nil
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    EventManager.Hit(EventId.OpenPanel, PanelId.FriendAddStranger, mapFriend)
  end
  
  cs_coroutine.start(wait)
end

function PlayerFriendData:SetAddStrangerWarning(bAble)
  self.bAddStrangerWarning = bAble
end

function PlayerFriendData:JudgeEnergyGetAble()
  if not self._tbFriendList then
    return false
  end
  for _, v in pairs(self._tbFriendList) do
    if v.nGetEnergy == EnergyState.Able then
      return true
    end
  end
  return false
end

function PlayerFriendData:JudgeEnergySendAble()
  if not self._tbFriendList then
    return false
  end
  for _, v in pairs(self._tbFriendList) do
    if not v.bSendEnergy then
      return true
    end
  end
  return false
end

function PlayerFriendData:JudgeLogin(nNanoTime)
  local nTime = math.floor(nNanoTime / 1.0E9)
  local nYear = tonumber(os.date("%Y", nTime))
  local nMonth = tonumber(os.date("%m", nTime))
  local nDay = tonumber(os.date("%d", nTime))
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  if nCurTime - nTime <= 86400 then
    return ConfigTable.GetUIText("Friend_Today"), AllEnum.LoginTime.Today
  else
    return nYear .. "." .. nMonth .. "." .. nDay
  end
end

function PlayerFriendData:DeleteFriend(nUId)
  if not self._tbFriendList then
    return
  end
  if self._tbFriendList[nUId] then
    self._tbFriendList[nUId] = nil
    self._nFriendListNum = self._nFriendListNum - 1
  end
  self:UpdateFriendEnergyRedDot()
end

function PlayerFriendData:AddFriend(mapMainData)
  if not self._tbFriendList then
    self._tbFriendList = {}
  end
  if self._tbFriendList[mapMainData.Friend.Id] then
    return
  end
  local tab = {}
  table.insert(tab, {
    "role_id",
    tostring(PlayerData.Base._nPlayerId)
  })
  NovaAPI.UserEventUpload("add_friend", tab)
  self._tbFriendList[mapMainData.Friend.Id] = {}
  self:ParseFriendData(self._tbFriendList[mapMainData.Friend.Id], mapMainData.Friend)
  self._nFriendListNum = self._nFriendListNum + 1
  self:UpdateFriendEnergyRedDot()
end

function PlayerFriendData:DeleteRequest(nUId)
  if not self._tbFriendRequest then
    return
  end
  for nIndex, mapFriendInfo in pairs(self._tbFriendRequest) do
    if nUId == mapFriendInfo.nUId then
      table.remove(self._tbFriendRequest, nIndex)
      self._nFriendRequestNum = self._nFriendRequestNum - 1
      break
    end
  end
  self:UpdateFriendApplyRedDot()
end

function PlayerFriendData:UpdateFriendState(mapFriendState)
  local nAction = mapFriendState.Action
  local nUId = mapFriendState.Id
  if nAction == 2 then
    self:DeleteRequest(nUId)
    EventManager.Hit("FriendRefreshRequest")
    local tab = {}
    table.insert(tab, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    NovaAPI.UserEventUpload("add_friend", tab)
  elseif nAction == 3 then
    self:DeleteFriend(nUId)
    EventManager.Hit("FriendRefreshList")
  end
  if nAction == 1 then
    RedDotManager.SetValid(RedDotDefine.Friend_Apply, nil, true)
  end
end

function PlayerFriendData:UpdateFriendEnergy(mapData)
  RedDotManager.SetValid(RedDotDefine.Friend_Energy, nil, mapData.State)
end

function PlayerFriendData:SetTimer(nTime)
  if nTime <= 0 then
    return
  end
  self.bCD = true
  if self.timer ~= nil then
    self.timer:Cancel(false)
    self.timer = nil
  end
  self.nCd = nTime
  self.timer = TimerManager.Add(1, nTime, self, function()
    self.bCD = false
  end, true, true, false)
end

function PlayerFriendData:SendFriendListGetReq(callback)
  if self.bCD then
    callback()
    return
  end
  
  local function successCallback(_, mapMainData)
    self:SetTimer(2)
    self:CacheFriendData(mapMainData)
    callback(mapMainData)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.friend_list_get_req, {}, nil, successCallback)
end

function PlayerFriendData:SendFriendDeleteReq(nUId, callback)
  local msgData = {UId = nUId}
  
  local function successCallback(_, mapMainData)
    self:DeleteFriend(nUId)
    callback(mapMainData)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.friend_delete_req, msgData, nil, successCallback)
end

function PlayerFriendData:SendFriendAddAgreeReq(nUId, callback)
  local msgData = {UId = nUId}
  
  local function successCallback(_, mapMainData)
    self:AddFriend(mapMainData)
    self:DeleteRequest(nUId)
    callback(mapMainData)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.friend_add_agree_req, msgData, nil, successCallback)
end

function PlayerFriendData:SendFriendAllAgreeReq(callback)
  local function successCallback(_, mapMainData)
    self:CacheFriendData(mapMainData)
    
    callback(mapMainData)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.friend_all_agree_req, {}, nil, successCallback)
end

function PlayerFriendData:SendFriendInvitesDeleteReq(tbUId, callback)
  local msgData = {UIds = tbUId}
  
  local function successCallback(_, mapMainData)
    for _, nUId in pairs(tbUId) do
      self:DeleteRequest(nUId)
    end
    callback(mapMainData)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.friend_invites_delete_req, msgData, nil, successCallback)
end

function PlayerFriendData:SendAddFriendReq(nUId, callback)
  local msgData = {UId = nUId}
  
  local function successCallback(_, mapMainData)
    callback(mapMainData)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.friend_add_req, msgData, nil, successCallback)
end

function PlayerFriendData:SendFriendNameSearchReq(sName, callback)
  local msgData = {Name = sName}
  
  local function successCallback(_, mapMainData)
    if not mapMainData.Friends or #mapMainData.Friends == 0 then
      EventManager.Hit(EventId.OpenMessageBox, {
        nType = AllEnum.MessageBox.Alert,
        sContent = ConfigTable.GetUIText("Friend_SearchNone")
      })
    else
      local tbSearch = {}
      for nIndex, mapFriendInfo in pairs(mapMainData.Friends) do
        tbSearch[nIndex] = {}
        self:ParseFriendData(tbSearch[nIndex], mapFriendInfo)
      end
      callback(tbSearch)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.friend_name_search_req, msgData, nil, successCallback)
end

function PlayerFriendData:SendFriendUIdSearchReq(nUId, callback)
  local msgData = {Id = nUId}
  
  local function successCallback(_, mapMainData)
    if not mapMainData.Friend then
      EventManager.Hit(EventId.OpenMessageBox, {
        nType = AllEnum.MessageBox.Alert,
        sContent = ConfigTable.GetUIText("Friend_SearchNone")
      })
    else
      local tbSearch = {}
      tbSearch[1] = {}
      self:ParseFriendData(tbSearch[1], mapMainData.Friend)
      callback(tbSearch)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.friend_uid_search_req, msgData, nil, successCallback)
end

function PlayerFriendData:SendFriendReceiveEnergyReq(tbUId, callback)
  local msgData = {UIds = tbUId}
  
  local function successCallback(_, mapMainData)
    local nBefore = self._nEnergyCount
    for _, nId in pairs(mapMainData.UIds) do
      if self._tbFriendList[nId] then
        self._tbFriendList[nId].nGetEnergy = EnergyState.Received
      end
    end
    self._nEnergyCount = mapMainData.ReceiveEnergyCnt
    EventManager.Hit(EventId.OpenPanel, PanelId.ReceivePropsTips, {
      {
        id = AllEnum.CoinItemId.Energy,
        count = self._nEnergyCount - nBefore
      }
    })
    callback(mapMainData.UIds)
    self:UpdateFriendEnergyRedDot()
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.friend_receive_energy_req, msgData, nil, successCallback)
end

function PlayerFriendData:SendFriendSendEnergyReq(tbUId, callback)
  local msgData = {UIds = tbUId}
  
  local function successCallback(_, mapMainData)
    for _, nId in pairs(mapMainData.UIds) do
      if self._tbFriendList[nId] then
        self._tbFriendList[nId].bSendEnergy = true
      end
    end
    callback(mapMainData.UIds)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.friend_send_energy_req, msgData, nil, successCallback)
end

function PlayerFriendData:SendFriendStarSetReq(tbUId, bStar, callback)
  local msgData = {UIds = tbUId, Star = bStar}
  
  local function successCallback(_, mapMainData)
    for _, nId in pairs(tbUId) do
      if self._tbFriendList[nId] then
        self._tbFriendList[nId].bStar = bStar
      end
    end
    callback(mapMainData)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.friend_star_set_req, msgData, nil, successCallback)
end

function PlayerFriendData:SendFriendRecommendationGetReq(callback)
  local function successCallback(_, mapMainData)
    if not mapMainData.Friends or #mapMainData.Friends == 0 then
      EventManager.Hit(EventId.OpenMessageBox, {
        nType = AllEnum.MessageBox.Alert,
        
        sContent = ConfigTable.GetUIText("Friend_NoneRecommend")
      })
    else
      local tbSearch = {}
      for nIndex, mapFriendInfo in pairs(mapMainData.Friends) do
        tbSearch[nIndex] = {}
        self:ParseFriendData(tbSearch[nIndex], mapFriendInfo)
      end
      callback(tbSearch)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.friend_recommendation_get_req, {}, nil, successCallback)
end

function PlayerFriendData:UpdateFriendApplyRedDot()
  RedDotManager.SetValid(RedDotDefine.Friend_Apply, nil, self._nFriendRequestNum > 0)
end

function PlayerFriendData:UpdateFriendEnergyRedDot()
  local bCheck = false
  local bMax = PlayerData.Friend:GetEnergyCount() >= self._nMaxReceiveEnergyConfig
  if self._tbFriendList and not bMax then
    for _, v in pairs(self._tbFriendList) do
      if v.nGetEnergy == EnergyState.Able then
        bCheck = true
        break
      end
    end
  end
  RedDotManager.SetValid(RedDotDefine.Friend_Energy, nil, bCheck)
end

return PlayerFriendData
