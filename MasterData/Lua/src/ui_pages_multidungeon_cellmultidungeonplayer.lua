local this = class("cellMultiDungeonPlayer", G_UIModuleBase)
local WaitTime = L_GameConstTpl:getData("MULIT_DUNGEON_FRIEND_READYTIME", L_Const.GameTplType.int)
local PageNameFunc = {
  pageMultiDungeonPrepare = "refreshView_prepare",
  pageMultiDungeonSettle = "refreshView_settle",
  pageMultiDungeonMatching = "refreshView_matching"
}

function this.bind()
  return {
    txt_playerName = nil,
    txt_playerLevel = nil,
    go_leader = false,
    isOn_empty = false,
    go_invite = false,
    isOn_wait = false,
    txt_waitCountdown = nil,
    go_btnKickOut = false,
    go_accept = false,
    go_mvp = false,
    txt_contribution = nil
  }
end

function this.methods()
  return {
    onClick_invite = function(self)
      self:emit("onClick_invite", self.bind)
    end,
    onClick_cancel = function(self)
      self:emit("onClick_cancel", self.bind)
    end,
    onClick_kickOut = function(self)
      self:emit("onClick_kickOut", self.bind)
    end,
    onClick_select = function(self)
      self:emit("onClick_select", self.bind)
    end
  }
end

function this:open()
  self:_refreshView()
end

function this:close()
  L_PhotoManager:clearPhotoEntity(self)
  L_TimerManager:clearTimer(self)
end

function this:_refreshView()
  self[PageNameFunc[self.bind.pageName]](self, self.bind.position)
end

function this:refreshView_prepare()
  if not self.isBind then
    return
  end
  local position = self.bind.position
  local teamData = L_MultiDungeonStore:getMatchTeamData()
  local isLeader = self.bind.position == 1
  local isSelfLeader = L_PlayerStore:getPlayerId() == teamData.leader_id
  self.bind.playerUid = isLeader and teamData.leader_id or L_MultiDungeonStore:getMatchTeamMemberByPos(position)
  self.bind.go_leader = isLeader
  local isEmpty = math.isEmpty(self.bind.playerUid)
  self.bind.isOn_empty = isEmpty
  L_TimerManager:stopTimer(self, "refreshView_prepare_update")
  if not isEmpty then
    self:showPlayerInfo()
    self.bind.go_btnKickOut = not isLeader
  else
    local curPosPid = L_MultiDungeonStore:getInviteWaitDic()[position]
    local isWaiting = not math.isEmpty(curPosPid)
    self.bind.go_invite = isSelfLeader
    self.bind.isOn_wait = isWaiting
    if isWaiting then
      local inviteMember = L_MultiDungeonStore:getInviteWaitDic()[position]
      self.bind.playerUid = inviteMember.pid
      self._endTime = inviteMember.start_time + WaitTime
      self._refreshCountdownHandle = handler(self, self.refreshCountdown)
      L_TimerManager:newOrResetTimer(self, "refreshView_prepare_update", self._refreshCountdownHandle, 0.5, -1)
      self:refreshCountdown()
    end
  end
end

function this:refreshView_matching()
  if not self.isBind then
    return
  end
  local position = self.bind.position
  local matchStatus = L_MultiDungeonStore:getMatchStatus()
  if matchStatus == L_MultiDungeonConst.MatchStatus.Prepare or matchStatus == L_MultiDungeonConst.MatchStatus.Matching then
    local teamData = L_MultiDungeonStore:getMatchTeamData()
    local isLeader = self.bind.position == 1
    self.bind.playerUid = isLeader and teamData.leader_id or L_MultiDungeonStore:getMatchTeamMemberByPos(position)
    self.bind.go_leader = isLeader
  elseif matchStatus == L_MultiDungeonConst.MatchStatus.Matched then
    local readyMembers = L_MultiDungeonStore:getMatchedReadyDataMembers()
    local readyMember = readyMembers[position] or {}
    self.bind.playerUid = readyMember.pid
    self.bind.go_accept = readyMember.ready == true
    self.bind.go_leader = false
  end
  local isEmpty = math.isEmpty(self.bind.playerUid)
  self.bind.isOn_empty = isEmpty
  if not isEmpty then
    self:showPlayerInfo()
  end
end

function this:refreshView_settle()
  if not self.isBind then
    return
  end
  local position = self.bind.position
end

function this:showPlayerInfo()
  local isSelf = self.bind.playerUid == L_PlayerStore:getPlayerId()
  
  local function callback()
    local baseInfo = L_FriendStore:getPlayerBaseInfo(self.bind.playerUid)
    self.bind.txt_playerName = L_FriendStore:getPlayerName(baseInfo)
    self.bind.txt_playerLevel = string.format("LV%s", L_FriendStore:getPlayerLevel(baseInfo))
    L_PhotoManager:newOrBindPhotoEntity(self, self.bindComponents.img_painting, L_FriendStore:getPlayerAvatars(baseInfo, L_Const.avatarTextureIndex.head))
  end
  
  if isSelf then
    callback()
  else
    local types = {
      L_Const.PlayerBasicQueryType.PBQT_NAME,
      L_Const.PlayerBasicQueryType.PBQT_FACE_MINI,
      L_Const.PlayerBasicQueryType.PBQT_LEVEL
    }
    L_FriendManager:requestBaseInfo(types, {
      self.bind.playerUid
    }, callback)
  end
end

function this:refreshCountdown()
  local nowTime = L_TimeUtil.getServerTime()
  if nowTime >= self._endTime then
    self:_refreshView()
    L_TimerManager:stopTimer(self, "refreshView_prepare_update")
  else
    self.bind.txt_waitCountdown = tostring(self._endTime - L_TimeUtil.getServerTime())
  end
end

return this
