local this = class("cellChatHead", G_UIModuleBase)
local _playerDressTpl = L_GameTpl:getPlayercardDressTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    txt_level = "",
    go_shield = false,
    cellHeadPic = {
      moduleName = "pages/headPic/cellHeadPic"
    }
  }
end

function this.methods()
  return {
    cellHeadPic = {
      onClick = function(self, bind)
        self:emit("onClick", self.bind)
      end
    }
  }
end

function this:refresh()
end

function this:refreshWithId(id, setHead)
  self._playerUid = id
  local baseInfo = self._isSelfPlayer and L_PlayerStore:getPlayerBaseInfo() or L_FriendStore:getPlayerBaseInfo(self._playerUid)
  baseInfo = baseInfo or L_FriendStore:getRecommandFriendBaseInfo(self._playerUid)
  if not baseInfo then
    return
  end
  local lv, isMaxLv = L_FriendStore:getPlayerLevel(baseInfo)
  self.bind.txt_level = tostring(lv)
  local cellHeadPic = self.modules.cellHeadPic
  cellHeadPic:updateInfoByPlayerInfo(baseInfo)
  self.bind.go_shield = L_FriendStore:getIsBlockChatList(self._playerUid)
  if setHead then
    local online = L_FriendStore:getPlayerIsOnline(baseInfo)
    self:refreshHeadIcon(online)
  end
  self:refreshShield()
end

function this:refreshShield()
  local friend = L_FriendStore:getPlayerItem(L_FriendStore:getFriendList(), self._playerUid)
  if friend and not string.isEmpty(friend:getFriendMark()) then
    self.bind.go_shield = L_FriendStore:getIsBlockChatList(self._playerUid)
  elseif friend then
    self.bind.go_shield = L_FriendStore:getIsBlockChatList(self._playerUid)
  else
    self.bind.go_shield = false
  end
end

function this:refreshHeadIcon(online)
  if online then
    self.bindComponents.dark:ResetColors()
  else
    self.bindComponents.dark:SetGray()
  end
end

function this:setDesaturate(active)
  self.modules.cellHeadPic:setDesaturate(active)
end

function this:setMask(active, color)
  self.modules.cellHeadPic:setMask(active, color)
end

return this
