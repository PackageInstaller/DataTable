module('guildWar.GuildWarBuildVo', Class.impl())

function parseData(self,id,cusData)
    self.id = id 
    self.regionId = cusData.region_id 
    self.type = cusData.type 
    self.buildHp = cusData.build_hp
    self.destoryPoint = cusData.destoryPoint
end

return _M