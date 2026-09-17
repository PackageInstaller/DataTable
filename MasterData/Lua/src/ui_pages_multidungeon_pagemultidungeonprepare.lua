local this = class("pageMultiDungeonPrepare", G_UIPageBase)
local _multiDungeonTpl = L_GameTpl:getMultiDungeonTpl()
local TeamCount = L_GameConstTpl:getData("MULIT_DUNGEON_PLAYERNUM", L_Const.GameTplType.int)

function this.bind()
  return {
    txt_dungeonName = nil,
    img_boss = nil,
    list_player = {
      moduleName = "pages/multiDungeon/cellMultiDungeonPlayer"
    },
    go_btnMatching = false
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      self:closePage()
    end,
    onClick_start = function(self)
      L_MultiDungeonStore:req_CSProtoMultiCampaignCreate(self._dungeonId)
    end,
    onClick_matching = function(self)
      local inviteMembers = L_MultiDungeonStore:getInviteWaitDic()
      if not table.isEmpty(inviteMembers) then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pageMultiDungeonPrepare"))
        return
      end
      L_MultiDungeonStore:req_CSProtoStartMatch()
    end,
    list_player = {
      onClick_invite = function(self, bind)
        L_UI:open("pageMultiDungeonInviteFriends", {
          pos = bind.position
        })
      end,
      onClick_cancel = function(self, bind)
        L_MultiDungeonManager:invitePlayer(bind.playerUid, bind.position, true)
      end,
      onClick_kickOut = function(self, bind)
        L_MultiDungeonStore:req_CSProtoKickOutMatchTeam(bind.playerUid)
      end
    }
  }
end

function this:check(options, callback)
  local matchStatus = L_MultiDungeonStore:getMatchStatus()
  callback(matchStatus == L_MultiDungeonConst.MatchStatus.Prepare)
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self._dungeonId = L_MultiDungeonStore:getMatchTeamData().dungeon_id
  L_MultiDungeonStore:listenCallFunc(L_MultiDungeonStore.event.syncMatchTeamData, self.onEvent_syncMatchTeamData, self)
  L_MultiDungeonStore:listenCallFunc(L_MultiDungeonStore.event.syncMatchTeamInviteData, self.onEvent_syncMatchTeamData, self)
  L_MultiDungeonStore:listenCallFunc(L_MultiDungeonStore.event.rejectInviteJoinMatchTeam, self.onEvent_syncMatchTeamData, self)
  self:initPage()
end

function this:close(options)
  this.super.close(self, options)
  L_MultiDungeonStore:unListenCallFunc(L_MultiDungeonStore.event.syncMatchTeamData, self.onEvent_syncMatchTeamData)
  L_MultiDungeonStore:unListenCallFunc(L_MultiDungeonStore.event.syncMatchTeamInviteData, self.onEvent_syncMatchTeamData)
  L_MultiDungeonStore:unListenCallFunc(L_MultiDungeonStore.event.rejectInviteJoinMatchTeam, self.onEvent_syncMatchTeamData)
end

function this:escHandle()
  self:closePage()
end

function this:closePage()
  L_MultiDungeonStore:req_CSProtoLeaveMatchTeam()
  L_UI:close(self.pageName)
end

function this:initPage()
  local tpl_dungeon = _multiDungeonTpl:getTplById(self._dungeonId)
  self.bind.txt_dungeonName = _multiDungeonTpl:getName(tpl_dungeon)
  self.bind.img_boss = _multiDungeonTpl:getBossPic(tpl_dungeon)
  local members = L_MultiDungeonStore:getMatchTeamDataMembers()
  self.bind.go_btnMatching = #members + 1 < TeamCount
  self:initTeam()
end

function this:initTeam()
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

function this:refreshPlayerList()
  for i, v in pairs(self.modules.list_player) do
    local cell = v
    cell:refreshView_prepare()
  end
end

function this:onEvent_syncMatchTeamData()
  self:refreshPlayerList()
  local members = L_MultiDungeonStore:getMatchTeamDataMembers()
  self.bind.go_btnMatching = #members + 1 < TeamCount
end

return this
