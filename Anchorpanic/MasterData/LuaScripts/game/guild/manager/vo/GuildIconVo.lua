module('guild.GuildIconVo', Class.impl())

function parseData(self,id,cusData)
    self.id = id 
    self.icon = cusData.icon
end


return _M