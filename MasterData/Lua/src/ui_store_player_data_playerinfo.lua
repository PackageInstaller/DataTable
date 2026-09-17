local this = class("playerInfo")

function this:ctor(id)
  self.baseInfo = require(L_R.store .. "player.data.playerBaseInfo").new(id)
  self.mapInfo = require(L_R.store .. "player.data.playerMapInfo").new()
  self.modAvatar = nil
end

return this
