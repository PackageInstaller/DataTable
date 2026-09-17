local this = class("pageMultiDungeonMatching", G_UIPageBase)
local TeamCount = L_GameConstTpl:getData("MULIT_DUNGEON_PLAYERNUM", L_Const.GameTplType.int)
local ReadyCountDown = L_GameConstTpl:getData("MULIT_DUNGEON_MATCHTIME", L_Const.GameTplType.int)

function this.bind()
  return {
    isOn_matched = false,
    go_matchedOp = false,
    list_player = {
      moduleName = "pages/multiDungeon/cellMultiDungeonPlayer"
    },
    txt_tip = nil,
    txt_countdown = nil
  }
end

function this.methods()
  return {
    onClick_cancel = function(self)
      local matchStatus = L_MultiDungeonStore:getMatchStatus()
      if matchStatus == L_MultiDungeonConst.MatchStatus.Prepare then
        if not self._isLeader then
          L_MultiDungeonManager:leaveTeam()
        end
      else
        L_MultiDungeonStore:req_CSProtoStopMatch()
      end
    end,
    onClick_accept = function(self)
      L_MultiDungeonManager:readyMatch(true)
    end,
    onClick_refuse = function(self)
      L_MultiDungeonManager:readyMatch(false)
    end,
    list_player = {
      onClick_select = function(self, bind)
        L_FriendManager:viewPlayerCard(bind.playerUid)
      end
    }
  }
end

function this:preOpen(options)
  L_MultiDungeonStore:listenCallFunc(L_MultiDungeonStore.event.syncMatchedReadyData, self.onEvent_syncMatchedReadyData, self)
  L_MultiDungeonStore:listenCallFunc(L_MultiDungeonStore.event.syncMatchTeamData, self.onEvent_syncMatchTeamData, self)
  self:initPage()
end

function this:close(options)
  L_MultiDungeonStore:unListenCallFunc(L_MultiDungeonStore.event.syncMatchedReadyData, self.onEvent_syncMatchedReadyData)
  L_MultiDungeonStore:unListenCallFunc(L_MultiDungeonStore.event.syncMatchTeamData, self.onEvent_syncMatchTeamData)
  L_TimerManager:clearTimer(self)
end

function this:escHandle()
end

function this:initPage()
  self:initPlayerList()
  self:refreshMatchStatus()
end

function this:initPlayerList()
  local tmp = {}
  for i = 1, TeamCount do
    table.insert(tmp, {
      position = i,
      pageName = self.pageName
    })
  end
  self.bind.list_player:clear()
  self.bind.list_player:insert_array(tmp)
end

function this:refreshMatchStatus()
  local matchStatus = L_MultiDungeonStore:getMatchStatus()
  local isMatched = matchStatus == L_MultiDungeonConst.MatchStatus.Matched
  self.bind.isOn_matched = isMatched
  local selfReady = L_MultiDungeonStore:getMatchedReadyMemberByPid(L_PlayerStore:getPlayerId())
  local isOp = isMatched and not selfReady.ready
  self.bind.go_matchedOp = isOp
  L_TimerManager:stopTimer(self, "acceptCountdown")
  if matchStatus == L_MultiDungeonConst.MatchStatus.Matching then
    self.bind.txt_tip = L_WordsTpl:getValue("notice_pageMultiDungeonMatching_01")
  elseif matchStatus == L_MultiDungeonConst.MatchStatus.Prepare then
    self.bind.txt_tip = L_WordsTpl:getValue("notice_pageMultiDungeonMatching_02")
  elseif matchStatus == L_MultiDungeonConst.MatchStatus.Matched then
    local readyData = L_MultiDungeonStore:getMatchedReadyData()
    local matchedTime = readyData.matched_time
    self._endTime = matchedTime + ReadyCountDown
    self._refreshCountdownHandle = self._refreshCountdownHandle or handler(self, self.refreshCountdown)
    L_TimerManager:newOrResetTimer(self, "acceptCountdown", self._refreshCountdownHandle, 0.5, -1)
    self:refreshCountdown()
  end
end

function this:refreshPlayerList()
  for i, v in pairs(self.modules.list_player) do
    local cell = v
    cell:refreshView_matching()
  end
end

function this:onEvent_syncMatchedReadyData()
  self:refreshMatchStatus()
  self:refreshPlayerList()
end

function this:onEvent_syncMatchTeamData()
  self:refreshPlayerList()
  self:refreshMatchStatus()
end

function this:refreshCountdown()
  if self._endTime <= L_TimeUtil.getServerTime() then
    L_TimerManager:stopTimer(self, "acceptCountdown")
  else
    self.bind.txt_countdown = tostring(self._endTime - L_TimeUtil.getServerTime())
  end
end

return this
