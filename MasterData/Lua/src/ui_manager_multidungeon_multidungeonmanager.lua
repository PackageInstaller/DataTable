local this = class("multiDungeonManager", G_EventManagerBase)
table.merge(this, require("ui.manager.multiDungeon.multiDungeonManager_request"))
local WaitTime = L_GameConstTpl:getData("MULIT_DUNGEON_FRIEND_READYTIME", L_Const.GameTplType.int)
local ReadyCountDown = L_GameConstTpl:getData("MULIT_DUNGEON_MATCHTIME", L_Const.GameTplType.int)

function this:initialize()
  self._lastMembers = {}
  self._lastLeader = {}
  self._onEvent_specialMultiCoopEntrustGetHandle = self._onEvent_specialMultiCoopEntrustGetHandle or handler(self, self.onSpecialMultiCoopEntrustRefresh)
  C_MultiEvent.instance:Listen(C_EMultiEvent.MultiLimitChange, self._onEvent_specialMultiCoopEntrustGetHandle)
end

function this:dispose()
  L_TimerManager:clearTimer(self)
  if self._onEvent_specialMultiCoopEntrustGetHandle ~= nil then
    C_MultiEvent.instance:Cancel(C_EMultiEvent.MultiLimitChange, self._onEvent_specialMultiCoopEntrustGetHandle)
  end
end

function this:onSpecialMultiCoopEntrustRefresh(_, data)
  if not data then
    return
  end
  local dungeonId = data:GetInt(1)
  if not dungeonId then
    return
  end
  local isActive = data:GetBool(0)
  local _dungeonCrisisCrusadeTpl = L_GameTpl:getDungeonCrisisCrusadeTpl()
  local levelId = _dungeonCrisisCrusadeTpl:getLevelIdByDungeonId(dungeonId)
  if isActive then
    L_ReddotManager:markNew(L_ReddotManager.DotDef.EntrustMultiTaskDifficulty, levelId)
  else
    L_ReddotManager:clearNew(L_ReddotManager.DotDef.EntrustMultiTaskDifficulty, levelId)
  end
end

function this:onEvent_syncMatchTeamData()
  if self:getIsInMultiDungeon() then
    return
  end
  self:refreshTeamMembers()
  self:refreshMatchStatus()
end

function this:onEvent_syncMatchTeamInviteData()
  if self:getIsInMultiDungeon() then
    return
  end
  self._isDealInvite = false
  local inviteData = L_MultiDungeonStore:getMatchTeamInviteData()
  if table.isEmpty(inviteData) then
    return
  end
  local leftTime = inviteData.start_time + WaitTime - L_TimeUtil.getServerTime()
  if leftTime <= 0 then
    return
  end
  L_FlyMsgManager:showMultiDungeonInvite()
  L_TimerManager:newOrResetTimer(self, "autoDealWithInvite", function()
    self:replyInvite(false)
  end, leftTime)
end

function this:onEvent_syncMatchedReadyData()
  if self:getIsInMultiDungeon() then
    return
  end
  self:refreshTeamMembers()
  self:refreshMatchStatus()
  local matchData = L_MultiDungeonStore:getMatchedReadyData()
  local leftTime = matchData.matched_time + ReadyCountDown - L_TimeUtil.getServerTime()
  if leftTime <= 0 then
    return
  end
  local selfReady = L_MultiDungeonStore:getMatchedReadyMemberByPid(L_PlayerStore:getPlayerId())
  if not selfReady.ready then
    self._isDealReady = false
  end
  L_TimerManager:newOrResetTimer(self, "autoDealWithReady", function()
    self:readyMatch(false)
  end, leftTime)
end

function this:onEvent_rejectInviteJoinMatchTeam(pid)
  if self:getIsInMultiDungeon() then
    return
  end
  self:showTip(L_MultiDungeonConst.TipType.FriendRejectInvite, pid)
end

function this:onEvent_pageClose(pageName)
  if self:getIsInMultiDungeon() then
    return
  end
  if pageName == "loading" then
    self:refreshMatchStatus()
  end
end

function this:refreshTeamMembers()
  local teamData = L_MultiDungeonStore:getMatchTeamData()
  local reason = L_MultiDungeonStore:getMatchTeamDataSyncReason()
  if table.isEmpty(teamData) then
    self._lastMembers = {}
    if not math.isEmpty(self._lastLeader) and self._lastLeader ~= L_PlayerStore:getPlayerId() then
      if reason == L_Const.MatchTeamOptionType.DESTROY_TEAM then
        self:showTip(L_MultiDungeonConst.TipType.LeaderDestroyTeam, self._lastLeader)
      elseif reason == L_Const.MatchTeamOptionType.KICKOUT_TEAM then
        self:showTip(L_MultiDungeonConst.TipType.LeaderKickOutYou, self._lastLeader)
      end
    end
    self._lastLeader = nil
    return
  end
  local isLeader = teamData.leader_id == L_PlayerStore:getPlayerId()
  if isLeader and (reason == L_Const.MatchTeamOptionType.LEAVE_TEAM or reason == L_Const.MatchTeamOptionType.KICKOUT_TEAM) then
    for i, v in pairs(self._lastMembers) do
      local node, index = table.ipairsFind(L_MultiDungeonStore:getMatchTeamDataMembers(), function(item)
        return item.pid == v.pid
      end)
      if not index then
        if reason == L_Const.MatchTeamOptionType.LEAVE_TEAM then
          self:showTip(L_MultiDungeonConst.TipType.MemberLeave, v.pid)
        elseif reason == L_Const.MatchTeamOptionType.KICKOUT_TEAM then
          self:showTip(L_MultiDungeonConst.TipType.YouKickOutMember, v.pid)
        end
      end
    end
  end
  self._lastMembers = table.clone(L_MultiDungeonStore:getMatchTeamDataMembers())
  self._lastLeader = teamData.leader_id
end

function this:refreshMatchStatus()
  if L_LoadingManager:isLoading() then
    return
  end
  local teamData = L_MultiDungeonStore:getMatchTeamData()
  local isLeader = teamData.leader_id == L_PlayerStore:getPlayerId()
  local reason = L_MultiDungeonStore:getMatchTeamDataSyncReason()
  printf("multiDungeonManager_refreshMatchStatus:%d", reason)
  local matchStatus = L_MultiDungeonStore:getMatchStatus()
  if matchStatus == L_MultiDungeonConst.MatchStatus.None then
    L_UI:close("pageMultiDungeonPrepare")
    L_UI:close("pageMultiDungeonMatching")
  elseif matchStatus == L_MultiDungeonConst.MatchStatus.Prepare then
    if isLeader then
      L_UI:close("pageMultiDungeonMatching")
      L_UI:open("pageMultiDungeonPrepare")
    else
      self:_tryOpenPageMultiDungeonMatching()
    end
  elseif matchStatus == L_MultiDungeonConst.MatchStatus.Matching then
    L_UI:close("pageMultiDungeonPrepare")
    self:_tryOpenPageMultiDungeonMatching()
  elseif matchStatus == L_MultiDungeonConst.MatchStatus.Matched then
    L_UI:close("pageMultiDungeonPrepare")
    self:_tryOpenPageMultiDungeonMatching()
  end
end

function this:_tryOpenPageMultiDungeonMatching()
  local page = L_UI:getPage("pageMultiDungeonMatching")
  if page and not page.gameObject then
    return
  end
  L_UI:open("pageMultiDungeonMatching")
end

function this:showTip(type, pid)
  L_FriendManager:requestBaseInfo({
    L_Const.PlayerBasicQueryType.PBQT_NAME
  }, {pid}, function()
    local baseInfo = L_FriendStore:getPlayerBaseInfo(pid)
    L_FlyMsgManager:showNormalMsgByKey(L_MultiDungeonConst.TipTypeDesc[type], {
      [0] = L_FriendStore:getPlayerName(baseInfo)
    })
  end)
end

function this:getIsInMultiDungeon()
  local sceneId = AzurWorldInstance.CurWorldId
  if sceneId == nil then
    return false
  end
  local cityTpl = L_GameTpl:getWorldCityTpl()
  local tpl = cityTpl:getTplById(sceneId)
  return cityTpl:getType(tpl) == 12
end

function this:_stopAutoDealWithInviteTimer()
  L_TimerManager:stopTimer(self, "autoDealWithInvite")
end

function this:_stopAutoDealWithReadyTimer()
  L_TimerManager:stopTimer(self, "autoDealWithReady")
end

return this
