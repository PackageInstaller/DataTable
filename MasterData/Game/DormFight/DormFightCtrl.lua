local DormFightCtrl = class("DormFightCtrl", ControllerBase)
local base = ControllerBase
local util = require("XLua.Common.xlua_util")
local DormEnum = require("Game.Dorm.DormEnum")
local cs_P3_PvpFight = CS.P3.PvpFight
local cs_QualitySettings = CS.UnityEngine.QualitySettings
local CS_pvpFightManager_ins = CS.PvpFightManager.Instance
local cs_ProtoPvpfight_MSGID = CS.ProtoPvpfight.MSG_ID
local cs_ProtoPvpfight = CS.ProtoPvpfight
local CS_PvpFightHeroPropertyName_hp = CS.P3.PvpFight.Enum.PvpFightHeroPropertyName.hp
local cs_MessageCommon = CS.MessageCommon
local DormFightUICtrl = require("Game.DormFight.Ctrl.DormFightUICtrl")
local DormFightAudioCtrl = require("Game.DormFight.Audio.DormFightAudioCtrl")
local DormFightEffectCtrl = require("Game.DormFight.Ctrl.DormFightEffectCtrl")
local DormFightFormationCtrl = require("Game.DormFight.Ctrl.DormFightFormationCtrl")
local DormFightInvitedData = require("Game.DormFight.Data.DormFightInvitedData")
local DormFightMvpData = require("Game.DormFight.Data.DormFightMvpData")
local DormFightFighterEntity = require("Game.DormFight.Ctrl.DormFightFighterEntity")
local MSGID_MsgS2CFightOver = 5048
local MSGID_MsgS2CFightCloseNtf = 5046

function DormFightCtrl:OnInit()
  self.ctrls = {}
  self._fightNetwork = NetworkManager:GetNetwork(NetworkTypeID.DormFight)
  self.dormFightUICtrl = DormFightUICtrl.New(self)
  self.dormFightAudioCtrl = DormFightAudioCtrl.New(self)
  self.dormFightAudioCtrl:InitDormFightAudioCtrl()
  self.effectCtrl = DormFightEffectCtrl.New(self)
  self:ClearAllInvited()
end

function DormFightCtrl:TestEnterPvpEntry()
  self._fightNetwork:CS_PVP_Test_CreateRoom(1)
  self.isSingle = false
end

function DormFightCtrl:TestEnterPvpEntrySingle()
  self:EnterDormFightFormation(true)
end

function DormFightCtrl:GetCurrentDuelId()
  return self.currentDuelId
end

function DormFightCtrl:GetRoomInfo()
  return self.roomInfo
end

function DormFightCtrl:GetSelfFighterList()
  if self.isSingle then
    return self.singleFighterList
  end
  return self.selfFighterList
end

function DormFightCtrl:GetOtherFighterList()
  if self.isSingle then
    return self.singleFighterList
  end
  return self.otherFighterList
end

function DormFightCtrl:GetSelfUserData()
  return PlayerDataCenter.inforData
end

function DormFightCtrl:GetOtherUserData()
  if self.isSingle then
    return PlayerDataCenter.inforData
  end
  return self.currentAttackerInfo
end

function DormFightCtrl:GetInviteDataList()
  return self.inviteDataList
end

function DormFightCtrl:AddInviteData(msg, userInfoData)
  for index, inviteData in pairs(self.inviteDataList) do
    if inviteData.otherUserInfoData ~= nil and userInfoData ~= nil and inviteData.otherUserInfoData:GetUserUID() == userInfoData:GetUserUID() then
      inviteData.isCancel = true
    end
  end
  local inviteData = DormFightInvitedData.New(msg, userInfoData)
  table.insert(self.inviteDataList, inviteData)
end

function DormFightCtrl:GetEarliestInviteDataIndex()
  if self.inviteDataList == nil then
    return
  end
  if #self.inviteDataList == 0 then
    return
  end
  local timeStamp = 0
  local index = -1
  for i = 1, #self.inviteDataList do
    local inviteData = self.inviteDataList[i]
    if inviteData:IsLegal() then
      if timeStamp == 0 then
        timeStamp = inviteData.inviteExpiredTimeStamp
        index = i
      end
      if timeStamp > inviteData.inviteExpiredTimeStamp then
        timeStamp = inviteData.inviteExpiredTimeStamp
        index = i
      end
    end
  end
  return index
end

function DormFightCtrl:IsExistLegalInvited()
  for i = 1, #self.inviteDataList do
    if self.inviteDataList[i]:IsLegal() then
      return true
    end
  end
  return false
end

function DormFightCtrl:GetLegalInviteDataCount()
  local count = 0
  for i = 1, #self.inviteDataList do
    if self.inviteDataList[i]:IsLegal() then
      count = count + 1
    end
  end
  return count
end

function DormFightCtrl:CheckHaveInvited()
  for index, inviteData in ipairs(self.inviteDataList) do
    if inviteData:IsLegal() then
      return true
    end
  end
end

function DormFightCtrl:ClearAllInvited()
  self.inviteDataList = {}
end

function DormFightCtrl:InviteUserToDormFight(userId, roomType, callback)
  self.invittingCallback = callback
  self._fightNetwork:CS_FIGHT_DuelInvitation(userId, roomType, nil)
end

function DormFightCtrl:OnInviteCallback(duelId, expireTm)
  self.invitingDuelId = duelId
  if self.invittingCallback ~= nil then
    self.invittingCallback(duelId, expireTm)
    self.invittingCallback = nil
  end
end

function DormFightCtrl:InvitedDormFight(msg)
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_DormFight) then
    return
  end
  PlayerDataCenter:GetUserInfoByUID(msg.attacker, function(userInfoData)
    if userInfoData == nil then
      return
    end
    self:AddInviteData(msg, userInfoData)
    MsgCenter:Broadcast(eMsgEventId.OnReciveDormFightInvited, self, userInfoData)
  end)
end

function DormFightCtrl:CancelInvite(duelId, callback)
  self._fightNetwork:CS_FIGHT_DuelCancel(duelId, function()
    if callback ~= nil then
      callback(duelId)
    end
  end)
end

function DormFightCtrl:OnOtherCancelInvite(duelId)
  local cancelInviteData
  for index, inviteData in ipairs(self.inviteDataList) do
    if inviteData.duelId == duelId then
      inviteData.isRefuse = true
      cancelInviteData = inviteData
    end
  end
  local BeInvitedWindow = UIManager:GetWindow(UIWindowTypeID.DormFightBeInvited)
  if BeInvitedWindow ~= nil then
    BeInvitedWindow:OnInviteCancel()
  end
end

function DormFightCtrl:RefuseInviteDormFight(duelId, callback)
  self._fightNetwork:CS_FIGHT_DuelDecline(duelId, function()
    local refuseInviteData
    for index, inviteData in ipairs(self.inviteDataList) do
      if inviteData.duelId == duelId then
        inviteData.isRefuse = true
        refuseInviteData = inviteData
      end
    end
    if callback ~= nil then
      callback(refuseInviteData)
    end
  end)
end

function DormFightCtrl:UpdateInviteFail(duelId)
  local InvitingWindow = UIManager:GetWindow(UIWindowTypeID.DormFightFriendInviting)
  if InvitingWindow ~= nil then
    InvitingWindow:OnInviteFail()
  end
end

function DormFightCtrl:AcceptInvitedDormFight(duelId, attacker, roomType, callback)
  self:ClearAllInvited()
  local successCallback = BindCallback(self, function()
    self.currentDuelId = duelId
    self.currentRoomType = roomType
    self.currentFightUserId = attacker
    PlayerDataCenter:GetUserInfoByUID(attacker, function(userInfoData)
      self.currentAttackerInfo = userInfoData
      if callback ~= nil then
        callback()
      end
    end)
  end)
  local failCallback = BindCallback(self, function()
    local BeInvitedWindow = UIManager:GetWindow(UIWindowTypeID.DormFightBeInvited)
    if BeInvitedWindow ~= nil then
      BeInvitedWindow:CloseWindow()
    end
  end)
  self._fightNetwork:CS_FIGHT_DuelAccept(duelId, attacker, roomType, successCallback, failCallback)
end

function DormFightCtrl:MarkRejectInvitation(value, callback)
  self._fightNetwork:CS_FIGHT_FriendInvitationToggle(value, callback)
end

function DormFightCtrl:OtherAcceptInvited(msg)
  if isGameDev then
    print("对方接受邀请")
  end
  self.currentDuelId = msg.duelId
  self.currentFightUserId = msg.defender
  PlayerDataCenter:GetUserInfoByUID(msg.defender, function(userInfoData)
    self.currentAttackerInfo = userInfoData
  end)
end

function DormFightCtrl:EnterSelectHeroState(msg)
  self.selectHeroEndTm = msg.endTm
  local InvitingWindow = UIManager:GetWindow(UIWindowTypeID.DormFightFriendInviting)
  if self.currentAttackerInfo == nil then
    if msg.endTm - PlayerDataCenter.timestamp < 5 or self.currentFightUserId == nil then
      self.selectHeroEndTm = nil
      local BeInvitedWindow = UIManager:GetWindow(UIWindowTypeID.DormFightBeInvited)
      if BeInvitedWindow ~= nil then
        BeInvitedWindow:Refresh()
      end
      if InvitingWindow ~= nil then
        InvitingWindow:OnClose()
      end
      return
    else
      PlayerDataCenter:GetUserInfoByUID(self.currentFightUserId, function(userInfoData)
        self.currentAttackerInfo = userInfoData
        self.currentFightUserId = nil
        if InvitingWindow ~= nil then
          InvitingWindow:OnInviteSucess()
        end
        self:EnterDormFightFormation(false, msg.roomType, msg.endTm)
      end)
      return
    end
  end
  if InvitingWindow ~= nil then
    InvitingWindow:OnInviteSucess()
  end
  self:EnterDormFightFormation(false, msg.roomType, msg.endTm)
end

function DormFightCtrl:EnterDormFightFormation(isSingle, roomType, endTime)
  if isSingle == nil then
    isSingle = false
  end
  self.isSingle = isSingle
  if self.formationCtrl ~= nil then
    self.formationCtrl:Delete()
    self.formationCtrl = nil
  end
  self.formationCtrl = DormFightFormationCtrl.New(self)
  self.formationCtrl:EnterDormFightFormation(roomType, endTime)
end

function DormFightCtrl:ConfirmDormFightFormation(heroIds, skinIds, callback)
  if self.isSingle then
    self.singleHeroIds = heroIds
    self.singleSkinIds = skinIds
    self.singleFighterList = {}
    for i = 1, #self.singleHeroIds do
      local fighter = {}
      fighter.heroId = self.singleHeroIds[i]
      fighter.skinId = self.singleSkinIds[i]
      table.insert(self.singleFighterList, fighter)
    end
    self.currentDuelId = PlayerDataCenter.timestamp
    self._fightNetwork:CS_PVP_Test_CreateRoom(0)
  else
    self._fightNetwork:CS_FIGHT_PickHero(heroIds, self.currentDuelId, 1, function()
      if callback ~= nil then
        callback(heroIds, self.currentDuelId)
      end
    end)
  end
end

function DormFightCtrl:OnOtherSelectEnd(msg)
  self.otherPickHeroInfo = msg.info
  if self.formationCtrl ~= nil then
    self.formationCtrl:OtherSelectReady()
  end
end

function DormFightCtrl:RecvPvpCreateRoom(msg)
  if isGameDev then
    print("pvp server:" .. msg.PvpAddr)
    print(serpent.block(msg))
  end
  local result = string.split(msg.PvpAddr, ":")
  if #result ~= 2 then
    error("pvp fight addr format error:" .. msg.PvpAddr)
  end
  local ip = result[1]
  local port = tostring(result[2])
  local isError = false
  if self.isSingle then
    self.currentDuelId = msg.roomInfo.duelId
  else
    if self.currentDuelId ~= msg.roomInfo.duelId then
      error("房间id不正确,无法连接")
      isError = true
    end
    if self.selectHeroEndTm == nil then
      error("没有选人无法链接服务器")
      isError = true
    end
    if PlayerDataCenter.timestamp - self.selectHeroEndTm > 3 then
      error("从选人到链接服务器超时")
      isError = true
    end
    if self.currentAttackerInfo == nil then
      error("对战者数据不存在")
      isError = true
    end
  end
  if isError == true then
    if self.formationCtrl ~= nil then
      self.formationCtrl:ExitDormFightFormation()
      self.formationCtrl = nil
    end
    return
  end
  self:UpdatePvpRoomInfo(msg.roomId, msg.roomInfo, msg.token)
  self:StartDormFightConnectPvpServer(ip, port)
end

function DormFightCtrl:UpdatePvpRoomInfo(roomId, roomInfo, token)
  self.roomId = roomId
  self.roomInfo = roomInfo
  self._token = token
  if self.roomInfo == nil then
    return
  end
  for i, player in pairs(self.roomInfo.players) do
    if self.roomInfo.userId == player.uid then
      self.selfFighterList = player.fighterList
    else
      self.otherFighterList = player.fighterList
    end
  end
  local selfFighterList = self:GetSelfFighterList()
  local otherFighterList = self:GetOtherFighterList()
  local selfUserData = self:GetSelfUserData()
  local otherUserData = self:GetOtherUserData()
  local selfUserId = selfUserData:GetUserUID()
  local otherUserId = otherUserData:GetUserUID()
  self.fightData = {}
  self.fightData[selfUserId] = {}
  self.fightData[otherUserId] = {}
  for i = 1, #selfFighterList do
    self.fightData[selfUserId][selfFighterList[i].heroId] = DormFightMvpData.New(selfFighterList[i].heroId, i)
    self.fightData[otherUserId][otherFighterList[i].heroId] = DormFightMvpData.New(otherFighterList[i].heroId, i)
  end
end

function DormFightCtrl:StartDormFightConnectPvpServer(ip, port)
  CS_pvpFightManager_ins:ClearCurPvpFight()
  self.CS_pvpFightController = CS_pvpFightManager_ins:StartNewPvpFight()
  self.CS_pvpFightController:InitDormFight(self)
  local cs_netCtrl = CS_pvpFightManager_ins.PvpFightNetCtrl
  cs_netCtrl:CreatePvpTcpChannel(ip, port)
  cs_netCtrl:ConnectTcpChannel(function(result, ex)
    if result == CS.ConnectResults.Success then
      if IsNull(cs_netCtrl:GetNetworkCtrl(cs_P3_PvpFight.PvpNetworkCtrlID.Fight)) then
        cs_netCtrl:AddNetworkCtrl(cs_P3_PvpFight.PvpFightNetworkCtrl())
        self.__OnTcpClose = BindCallback(self, self.OnTcpClose)
        cs_netCtrl:onTcpClose("+", self.__OnTcpClose)
        self._fightNetwork:RegisterDormFightNetwork(MSGID_MsgS2CFightOver, self._fightNetwork, cs_ProtoPvpfight.S2C_FIGHT_CloseNtf, self._fightNetwork.SC_FIGHT_Over)
        self._fightNetwork:RegisterDormFightNetwork(MSGID_MsgS2CFightCloseNtf, self._fightNetwork, cs_ProtoPvpfight.S2C_FIGHT_CloseNtf, self._fightNetwork.S2C_FIGHT_CloseNtf)
      end
      self:OnDormPvpServerConnected()
    else
      error("Connect to Pvp Server fail, ex = " .. tostring(ex))
      if self.formationCtrl ~= nil then
        self.formationCtrl:ExitDormFightFormation()
        self.formationCtrl = nil
      end
      local text = ConfigData:GetTipContent(9356)
      cs_MessageCommon.ShowMessageTips(text)
    end
  end)
end

function DormFightCtrl:OnTcpClose()
  local text = ConfigData:GetTipContent(1008)
  cs_MessageCommon.ShowMessageTips(text)
  self:ExitDormFightScene()
  CS.GSceneManager.Instance:LoadSceneAsyncByAB(Consts.SceneName.Main, function(ok)
    ControllerManager:GetController(ControllerTypeId.HomeController, true):OnEnterHome()
    UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(window)
      if window == nil then
        return
      end
      window:SetFrom2Home(AreaConst.Sector, true)
    end)
    if self.dormFightUICtrl ~= nil then
      self.dormFightUICtrl:Delete()
    end
    CS_pvpFightManager_ins:ClearCurPvpFight()
    self:Delete()
  end)
end

function DormFightCtrl:OnDormPvpServerConnected()
  self.CS_pvpFightController:StartEnterSelectFighterState()
  local RoomInfo = self:CreateCSRoomInfo()
  self.CS_pvpFightController:InitRoomInfo(RoomInfo)
  self.CS_pvpFightController:ConfirmFighters()
  self:LoadDormFightScene()
end

function DormFightCtrl:CreateCSRoomInfo()
  local roomInfo = cs_P3_PvpFight.RoomInfo()
  roomInfo.selfUserId = self.roomInfo.userId
  roomInfo.roomTypeId = self.roomInfo.roomType
  roomInfo.roomId = self.roomId
  roomInfo.roomToken = self._token
  if self.isSingle then
    local testUserId = self.roomInfo.userId
    roomInfo.masterUserId = testUserId
    local csPlayer = cs_P3_PvpFight.RoomPlayer(testUserId, 2)
    csPlayer.userName = "测试玩家x"
    local csPlayer2 = cs_P3_PvpFight.RoomPlayer(testUserId + 1, 1)
    csPlayer2.userName = "测试玩家y"
    local heroIds = self.singleHeroIds
    local skinIds = self.singleSkinIds
    for i = 1, #heroIds do
      local skinId = skinIds[i]
      if skinId == 0 then
        skinId = (heroIds[i] + 2000) * 100 + 1
      end
      csPlayer.fighterInfos:Add(cs_P3_PvpFight.FighterInfo(heroIds[i], skinId))
      csPlayer2.fighterInfos:Add(cs_P3_PvpFight.FighterInfo(heroIds[i], skinId))
    end
    roomInfo.userList:Add(csPlayer)
    roomInfo.userList:Add(csPlayer2)
  else
    for i, player in pairs(self.roomInfo.players) do
      if player.isMaster then
        roomInfo.masterUserId = player.uid
      end
      local csPlayer = cs_P3_PvpFight.RoomPlayer(player.uid, player.bornPos)
      local userInfoData = self.roomInfo.userId == player.uid and self:GetSelfUserData() or self:GetOtherUserData()
      csPlayer.userName = userInfoData:GetUserName()
      for j, fighterData in pairs(player.fighterList) do
        local skinId = fighterData.skinId
        if skinId == 0 then
          skinId = (fighterData.heroId + 2000) * 100 + 1
        end
        csPlayer.fighterInfos:Add(cs_P3_PvpFight.FighterInfo(fighterData.heroId, skinId))
      end
      roomInfo.userList:Add(csPlayer)
    end
  end
  return roomInfo
end

function DormFightCtrl:LoadDormFightScene()
  local function preLoadFunc()
    self.dormFightUICtrl:OnPrepareDormFightUI(self)
  end
  
  if self.formationCtrl ~= nil then
    self.formationCtrl:ExitDormFightFormation()
    self.formationCtrl = nil
  end
  UIManager:DeleteAllWindow()
  CS.RenderManager.Instance:SetUnityShadow(true)
  self.__oldShadowDistance = cs_QualitySettings.shadowDistance
  cs_QualitySettings.shadowDistance = DormEnum.DormShadowDistance
  self.__oldLoadBias = cs_QualitySettings.lodBias
  cs_QualitySettings.lodBias = DormEnum.DormLodBias
  local __OnLoadSceneOver = BindCallback(self, self.OnLoadSceneOver)
  CS.GSceneManager.Instance:LoadSceneAsyncByABEx("009_Fight_003", true, false, __OnLoadSceneOver, util.cs_generator(preLoadFunc))
end

function DormFightCtrl:OnLoadSceneOver()
  AudioManager:PlayAudioById(ConfigData.dorm_fight_config.fightBGMAudioId)
  self.CS_pvpFightController:InitScene(function()
    self.CS_pvpFightController:SendIsReady()
    self.dormFightUICtrl:OnEnterDormFightScene()
  end)
end

function DormFightCtrl:OnSyncNetStart()
end

function DormFightCtrl:OnOtherUserOffline(userId)
  for index, inviteData in pairs(self.inviteDataList) do
    if inviteData.otherUserInfoData ~= nil and inviteData.otherUserInfoData:GetUserUID() == userId then
      inviteData.isCancel = true
    end
  end
  local BeInvitedWindow = UIManager:GetWindow(UIWindowTypeID.DormFightBeInvited)
  if BeInvitedWindow ~= nil then
    BeInvitedWindow:Refresh()
  end
  local InvitingWindow = UIManager:GetWindow(UIWindowTypeID.DormFightFriendInviting)
  if InvitingWindow ~= nil then
    InvitingWindow:OnClose()
  end
  local text = ConfigData:GetTipContent(10716)
  cs_MessageCommon.ShowMessageTips(text)
end

function DormFightCtrl:ExitDormFightScene()
  CS.RenderManager.Instance:SetUnityShadow(false)
  if self.__oldShadowDistance ~= nil then
    cs_QualitySettings.shadowDistance = self.__oldShadowDistance
    self.__oldShadowDistance = nil
  end
  if self.__oldLoadBias ~= nil then
    cs_QualitySettings.lodBias = self.__oldLoadBias
    self.__oldLoadBias = nil
  end
  AudioManager:RemoveCueSheet(eAuCueSheet.DormFight)
  UIUtil.SetGlobalHideTopStatus(false)
  UIUtil.SetGlobalIsBlockEsc(false)
end

function DormFightCtrl:CurrentFighterDie(fighterController)
  if not IsNull(fighterController) and self.dormFightUICtrl ~= nil and self.dormFightUICtrl.fightUI ~= nil then
    self.dormFightUICtrl.fightUI:CurrentFighterDie(fighterController.NetCharacter.IsOwnedBySelf)
  end
end

function DormFightCtrl:ForceEndGame(winerUserId)
  if self.endDuelId == self.currentDuelId then
    return
  end
  if self.currentAttackerInfo == nil then
    return
  end
  self:RemoveTcpAction()
  if self.CS_pvpFightController ~= nil then
    local selfUserData = self:GetSelfUserData()
    local selfUserId = selfUserData:GetUserUID()
    local isSelfWin = selfUserId == winerUserId
    self:PlayEndEffect(winerUserId)
    if isSelfWin then
      self.CS_pvpFightController.fsm:BroadcastEvent(CS.DormFightInGameState.eDormFightInGameState.Stop2Lost.value__)
    else
      self.CS_pvpFightController.fsm:BroadcastEvent(CS.DormFightInGameState.eDormFightInGameState.Stop2Win.value__)
    end
  end
end

function DormFightCtrl:OnShowResult(winnerUserId)
  if IsGameDev then
    print("客户端显示结果")
  end
  if self.fightData == nil or self.fightData[winnerUserId] == nil then
    self:Delete()
    if self.dormFightUICtrl ~= nil then
      self.dormFightUICtrl:Delete()
    end
    return
  end
  local selfUserData = self:GetSelfUserData()
  local selfUserId = selfUserData:GetUserUID()
  local isSelfWin = selfUserId == winnerUserId
  local winnerFighterList = isSelfWin and self:GetSelfFighterList() or self:GetOtherFighterList()
  local winnerUserData = isSelfWin and self:GetSelfUserData() or self:GetOtherUserData()
  local winnerFightData = self.fightData[winnerUserId]
  local mvpKillCount = 0
  local mvpIndex = 1
  for heroId, heroFightdata in pairs(winnerFightData) do
    if mvpKillCount < heroFightdata.killCount then
      mvpKillCount = heroFightdata.killCount
      mvpIndex = heroFightdata.fightIndex
    end
    if heroFightdata.killCount == mvpKillCount and 0 < mvpKillCount and mvpIndex < heroFightdata.fightIndex then
      mvpIndex = heroFightdata.fightIndex
    end
  end
  self.dormFightUICtrl:OnFightEnd(winnerUserData, winnerFighterList[mvpIndex], mvpKillCount, function()
    self:ExitDormFightScene()
    self:Delete()
    if self.dormFightUICtrl ~= nil then
      self.dormFightUICtrl:Delete()
    end
  end)
end

function DormFightCtrl:TryGetWinnerUserId(pvpFightController)
  local selfUserData = self:GetSelfUserData()
  local otherUserData = self:GetOtherUserData()
  local selfUserId = selfUserData:GetUserUID()
  local otherUserId = otherUserData:GetUserUID()
  local selfFighterIndex = 0
  local otherFighterIndex = 0
  local winerUserId
  local userList = pvpFightController.RoomInfo.userList
  for i = 0, userList.Count - 1 do
    if userList[i].userId == selfUserId then
      selfFighterIndex = userList[i].CurrentFighterIndex
    else
      otherFighterIndex = userList[i].CurrentFighterIndex
    end
  end
  if selfFighterIndex > otherFighterIndex then
    winerUserId = otherUserId
  elseif selfFighterIndex < otherFighterIndex then
    winerUserId = selfUserId
  else
    local selfCurrentFighter, otherCurrentFighter
    for instanceId, fighterEntity in pairs(self.DormFightFighterEntityTable) do
      if fighterEntity.fighterController.NetCharacter.NetId.userId == selfUserId then
        selfCurrentFighter = fighterEntity.fighterController
      end
      if fighterEntity.fighterController.NetCharacter.NetId.userId == otherUserId then
        otherCurrentFighter = fighterEntity.fighterController
      end
    end
    local selfCurrentHp = selfCurrentFighter.NetCharacter.roleEntity.hp
    local otherCurrentHp = otherCurrentFighter.NetCharacter.roleEntity.hp
    if not IsNull(selfCurrentFighter) and not IsNull(otherCurrentFighter) then
      if selfCurrentHp > otherCurrentHp then
        winerUserId = selfUserId
      elseif selfCurrentHp < otherCurrentHp then
        winerUserId = otherUserId
      elseif pvpFightController.IsMaster then
        winerUserId = otherUserId
      else
        winerUserId = selfUserId
      end
    elseif pvpFightController.IsMaster then
      winerUserId = otherUserId
    else
      winerUserId = selfUserId
    end
  end
  return winerUserId
end

function DormFightCtrl:OnFightStateChange(pvpFightController, stateId)
end

function DormFightCtrl:DormFightStartSelectFighter(pvpFightController)
end

function DormFightCtrl:LoadingSceneCompleted(pvpFightController)
end

function DormFightCtrl:DormFightLoadReady(pvpFightController)
end

function DormFightCtrl:OnDormFightStart(pvpFightController)
end

function DormFightCtrl:FightSecondsChanged(pvpFightController, dormFightInGameState, seconds)
  seconds = seconds + 1
  local value = dormFightInGameState.fightTimeLimit - seconds
  if value <= 0 and self.endDuelId ~= self.currentDuelId then
    local winerUserId = self:TryGetWinnerUserId(pvpFightController)
    local selfUserData = self:GetSelfUserData()
    local selfUserId = selfUserData:GetUserUID()
    local isSelfWin = winerUserId == selfUserId
    if IsGameDev then
      print("超时，客户端发起结束")
    end
    self._fightNetwork:CS_FIGHT_Over(isSelfWin, function(serverWinerUserId)
      if serverWinerUserId ~= nil then
        self:ForceEndGame(serverWinerUserId)
      else
        self:ForceEndGame(winerUserId)
      end
    end)
    self.endDuelId = self.currentDuelId
  end
  self.dormFightUICtrl:FightSecondsChanged(pvpFightController, dormFightInGameState, seconds)
end

function DormFightCtrl:PlayEndEffect(winnerUserId)
  for instanceId, fighterEntity in pairs(self.DormFightFighterEntityTable) do
    if fighterEntity.fighterController.NetCharacter.NetId.userId == winnerUserId then
      local winEffectId = 6
      fighterEntity:PlayEffect(winEffectId)
    end
  end
  self.dormFightUICtrl.fightUI:OnFightEnd()
end

function DormFightCtrl:OnDormFightEnd(battleEndState, eventId, dealBattleEndEvent)
  local isSelfWin = eventId == 1
  local winnerUserData = isSelfWin and self:GetSelfUserData() or self:GetOtherUserData()
  local winnerUserId = winnerUserData:GetUserUID()
  self:PlayEndEffect(winnerUserId)
  if self.endDuelId ~= self.currentDuelId then
    self._fightNetwork:CS_FIGHT_Over(isSelfWin, function(serverWinerUserId)
    end)
  else
  end
  dealBattleEndEvent(eventId)
  self.endDuelId = self.currentDuelId
  if IsGameDev then
    print("客户端确认结束")
  end
end

function DormFightCtrl:ReqDormFightSettle(battleEndState, requestData)
end

function DormFightCtrl:VictoryDormFightEndCoroutine(battleEndState)
  local function battleEndCoroutine()
  end
  
  return util.cs_generator(battleEndCoroutine)
end

function DormFightCtrl:ReqGiveUpFight(pvpFightController)
end

function DormFightCtrl:OnCreateFighter(pvpFightController, fighterController)
  if IsNull(pvpFightController) then
    return
  end
  if IsNull(fighterController) then
    return
  end
  self.dormFightUICtrl:OnCreateFighter(fighterController)
  self.dormFightAudioCtrl:OnCreateFighter(fighterController)
  if self.DormFightFighterEntityTable == nil then
    self.DormFightFighterEntityTable = {}
  end
  local instanceId = fighterController.NetCharacter.InstanceId
  self.DormFightFighterEntityTable[instanceId] = DormFightFighterEntity.New(fighterController, self, pvpFightController)
end

function DormFightCtrl:OnDestroyFighter(pvpFightController, fighterController)
  if IsNull(pvpFightController) then
    return
  end
  if IsNull(fighterController) then
    return
  end
  self:CollectfightData(fighterController, pvpFightController)
  self.effectCtrl:ClearFighterEffect(fighterController)
  self.dormFightUICtrl:OnDestroyFighter(pvpFightController, fighterController)
  self.dormFightAudioCtrl:OnDestroyFighter(fighterController)
  local instanceId = fighterController.NetCharacter.InstanceId
  local dormFightFighterEntity = self.DormFightFighterEntityTable[instanceId]
  if dormFightFighterEntity ~= nil then
    dormFightFighterEntity:OnDestroyFighter()
    self.DormFightFighterEntityTable[instanceId] = nil
  end
end

function DormFightCtrl:CollectfightData(fighterController, pvpFightController)
  if self.fightData == nil then
    return
  end
  local netCharacter = fighterController.NetCharacter
  local retiredUserId = netCharacter.NetId.userId
  local killerRoomPlayer, retiredRoomPlayer
  local userList = pvpFightController.RoomInfo.userList
  for i = 0, userList.Count - 1 do
    if userList[i].userId == retiredUserId then
      retiredRoomPlayer = userList[i]
    else
      killerRoomPlayer = userList[i]
    end
  end
  local killerUserId = killerRoomPlayer.userId
  if self.fightData[killerUserId] == nil then
    return
  end
  local killerFighterList = netCharacter.IsOwnedBySelf and self:GetOtherFighterList() or self:GetSelfFighterList()
  local killerHeroId = killerFighterList[killerRoomPlayer.CurrentFighterIndex + 1].heroId
  if self.fightData[killerUserId][killerHeroId] == nil then
    return
  end
  self.fightData[killerUserId][killerHeroId].killCount = self.fightData[killerUserId][killerHeroId].killCount + 1
end

function DormFightCtrl:OnUpdateBtnWeapon(pvpFightController, netCharacter)
  self.dormFightUICtrl:OnUpdateBtnWeapon(netCharacter)
end

function DormFightCtrl:OnUpdateBtnRun(pvpFightController, netCharacter)
  self.dormFightUICtrl:OnUpdateBtnRun(netCharacter)
end

function DormFightCtrl:OnNetObjectLoadComplete(netId)
end

function DormFightCtrl:OnNetObjectDestroy(netId)
end

function DormFightCtrl:RemoveTcpAction()
  local cs_netCtrl = CS_pvpFightManager_ins.PvpFightNetCtrl
  if not IsNull(cs_netCtrl) and self.__OnTcpClose ~= nil then
    cs_netCtrl:onTcpClose("-", self.__OnTcpClose)
    self.__OnTcpClose = nil
  end
end

function DormFightCtrl:Delete()
  if self.DormFightFighterEntityTable ~= nil then
    for instanceId, fighterEntity in pairs(self.DormFightFighterEntityTable) do
      fighterEntity:OnDestroyFighter()
    end
  end
  self:RemoveTcpAction()
  local cs_netCtrl = CS_pvpFightManager_ins.PvpFightNetCtrl
  if not IsNull(cs_netCtrl) then
    cs_netCtrl:RemoveListener(MSGID_MsgS2CFightOver)
    cs_netCtrl:RemoveListener(MSGID_MsgS2CFightCloseNtf)
  end
  CS_pvpFightManager_ins:ClearCurPvpFight()
  if not IsNull(self.CS_pvpFightController) and not IsNull(self.CS_pvpFightController.fsm) then
    self.CS_pvpFightController:Dispose()
    self.CS_pvpFightController = nil
  end
  self.__SC_FIGHT_Over = nil
  self.DormFightFighterEntityTable = nil
end

return DormFightCtrl
