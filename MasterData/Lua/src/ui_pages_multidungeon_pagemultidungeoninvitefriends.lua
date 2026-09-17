local this = class("pageMultiDungeonInviteFriends", G_UIPageBase)

function this.bind()
  return {
    isOn_empty = false,
    list_friend = {
      moduleName = "pages/multiDungeon/cellMultiDungeonInviteFriend"
    }
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    list_friend = {
      onClick_invite = function(self, bind)
        L_UI:close(self.pageName)
        L_MultiDungeonManager:invitePlayer(bind.playerUid, self._pos, false)
      end
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self._pos = options.pos
  self:initPage()
end

function this:initPage()
  local friendList = L_FriendStore:getFriendList()
  local players = {}
  for _, v in pairs(friendList) do
    table.insert(players, v:getPlayerUid())
  end
  local types = {
    L_Const.PlayerBasicQueryType.PBQT_NAME,
    L_Const.PlayerBasicQueryType.PBQT_FACE_MINI,
    L_Const.PlayerBasicQueryType.PBQT_OFFLINE_TIME,
    L_Const.PlayerBasicQueryType.PBQT_LEVEL
  }
  L_FriendManager:requestBaseInfo(types, players, function()
    self:initFriendList()
  end)
end

function this:initFriendList()
  local friendList = L_FriendStore:getFriendList()
  local tmp = {}
  for i, v in pairs(friendList) do
    local baseInfo = L_FriendStore:getPlayerBaseInfo(v.playerUid)
    if L_FriendStore:getPlayerIsOnline(baseInfo) then
      local teamMember = L_MultiDungeonStore:getMatchTeamDataMemberByPid(v.playerUid)
      local inviteMember = L_MultiDungeonStore:getInviteWaitByPid(v.playerUid)
      if not teamMember and not inviteMember then
        table.insert(tmp, {
          playerUid = v.playerUid
        })
      end
    end
  end
  self.bind.list_friend:clear()
  self.bind.list_friend:insert_array(tmp)
  self.bind.isOn_empty = table.isEmpty(tmp)
end

return this
