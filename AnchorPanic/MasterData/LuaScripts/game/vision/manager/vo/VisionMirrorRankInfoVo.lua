module('vision.VisionMirrorRankInfoVo', Class.impl())

function parseMsg(self, msg)
    self.rank = msg.rank
    self.playerId = msg.id
    self.playerName = msg.name
    self.avatarId = msg.avatar_id
    self.avatarFrame = msg.avatar_frame
    self.designation = msg.designation
    self.rankVal = msg.rank_val
    self.layer = msg.layer
    self.guildName = msg.guild_name
end

return _M
