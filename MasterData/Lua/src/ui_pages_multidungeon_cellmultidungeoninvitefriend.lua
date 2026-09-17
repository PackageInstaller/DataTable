local this = class("cellMultiDungeonInviteFriend", G_UIModuleBase)

function this.bind()
  return {txt_playerName = nil, txt_playerLevel = nil}
end

function this.methods()
  return {
    onClick_invite = function(self)
      self:emit("onClick_invite", self.bind)
    end
  }
end

function this:open()
  self:refreshView(self.bind.playerUid)
end

function this:close()
  L_PhotoManager:clearPhotoEntity(self)
end

function this:refreshView(playerUid)
  self.bind.playerUid = playerUid
  if not self.isBind then
    return
  end
  local baseInfo = L_FriendStore:getPlayerBaseInfo(self.bind.playerUid)
  self.bind.txt_playerName = L_FriendStore:getPlayerName(baseInfo)
  self.bind.txt_playerLevel = string.format("LV%s", L_FriendStore:getPlayerLevel(baseInfo))
  L_PhotoManager:newOrBindPhotoEntity(self, self.bindComponents.img_head, L_FriendStore:getPlayerAvatars(baseInfo, L_Const.avatarTextureIndex.head))
end

return this
