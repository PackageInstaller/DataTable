
module('guildWar.GuildWarRobotVo', Class.impl())

function parseData(self,id,cusData)
    self.id = id 
    self.buildId = cusData.build_id 
    self.battleArray1 = cusData.btaaleArray1 
    self.battleArray2 = cusData.btaaleArray2
    self.formationTid = cusData.formation_id
    self.avatarId = cusData.avatar_id
    self.avatarFrameId = cusData.avatar_frame_id
    self.playerName = cusData.player_name
    self.playerLv = cusData.player_lv
end

return _M