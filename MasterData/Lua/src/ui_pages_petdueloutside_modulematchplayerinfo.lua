local this = class("moduleMatchPlayerInfo", G_UIModuleBase)

function this.bind()
  return {
    active_root = false,
    txt_playerName = "",
    cellHeadPic = {
      moduleName = "pages/headPic/cellHeadPic"
    }
  }
end

function this.methods()
  return {}
end

function this:setPlayerName(name)
  self.bind.txt_playerName = name
end

function this:initModule(playerId)
  self.bind.active_root = true
  self.modules.cellHeadPic:setInfoByPlayerId(playerId, function(baseInfo)
    if playerId == L_PlayerStore:getPlayerId() then
      self.bind.txt_playerName = L_PlayerStore:getPlayerName()
    else
      self.bind.txt_playerName = L_FriendStore:getPlayerName(baseInfo)
    end
  end)
end

return this
