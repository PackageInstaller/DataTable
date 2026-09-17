local this = class("pageBlackList", G_UIPageBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {}
end

function this.bind()
  return {
    go_none = false,
    txt_blackListNum = "",
    scrollList_blackList = {
      moduleName = "pages/Friend/cellBlackPlayer"
    }
  }
end

function this.methods()
  return {
    onClick_mask = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    scrollList_blackList = {
      onClick_head = function(self, uid, position)
        L_FriendManager:viewPlayerCard(uid)
      end,
      onClick_remove = function(self, uid)
        L_FriendManager:operationPlayer(L_Const.friendOpType.blackList, L_Const.friendOp.delete, uid, function()
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pageBlackList"))
        end)
      end
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  L_FriendStore:listenCallFunc(L_FriendStore.event.refreshIdList, self.onEvent_refreshIdList, self)
  self:reqDataBeforeOpen()
end

function this:close(options)
  this.super.close(self, options)
  L_FriendStore:unListenCallFunc(L_FriendStore.event.refreshIdList, self.onEvent_refreshIdList)
end

function this:reqDataBeforeOpen()
  local blackList = L_FriendStore:getBlackList()
  local players = {}
  for _, v in pairs(blackList) do
    table.insert(players, v:getPlayerUid())
  end
  local types = {
    L_Const.PlayerBasicQueryType.PBQT_NAME,
    L_Const.PlayerBasicQueryType.PBQT_FACE_MINI
  }
  L_FriendManager:requestBaseInfo(types, players, function()
    self:initPage()
  end)
end

function this:initPage()
  self:initBlackList()
  self.bind.txt_blackListNum = string.format("%s/%s", table.count(L_FriendStore:getBlackList()), L_GameTpl:getGameConstTpl():getBlackListLimit())
  self.bind.go_none = table.isEmpty(L_FriendStore:getBlackList())
end

function this:initBlackList()
  local tmp = {}
  local blackList = L_FriendStore:getBlackList()
  for _, v in pairs(blackList) do
    local baseInfo = L_FriendStore:getPlayerBaseInfo(v:getPlayerUid())
    table.insert(tmp, {
      uid = v:getPlayerUid(),
      txt_name = L_FriendStore:getPlayerName(baseInfo),
      url_defaultHero = L_FriendStore:getPlayerAvatarsHead(baseInfo)
    })
  end
  table.sort(tmp, function(a, b)
    local friendItemA = L_FriendStore:getPlayerItem(L_FriendStore:getBlackList(), a.uid)
    local friendItemB = L_FriendStore:getPlayerItem(L_FriendStore:getBlackList(), b.uid)
    local timeA = friendItemA:getInsertTime()
    local timeB = friendItemB:getInsertTime()
    return timeA < timeB
  end)
  self.bind.scrollList_blackList:clear()
  self.bind.scrollList_blackList:insert_array(tmp)
end

function this:onEvent_refreshIdList()
  self:reqDataBeforeOpen()
end

return this
