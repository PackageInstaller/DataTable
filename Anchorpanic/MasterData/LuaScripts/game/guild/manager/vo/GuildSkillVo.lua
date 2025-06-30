module('guild.GuildSkillVo', Class.impl())

function parseData(self,cusData)
    self.id = cusData.id
    self.level = cusData.level
    self.needStuff = cusData.need_stuff
end


return _M