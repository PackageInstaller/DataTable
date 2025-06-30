module('guild.GuildAwardDataVo', Class.impl())

function parseData(self,id,cusData)
    self.id = id 
    self.award = cusData.award
    self.needTimes = cusData.need_times
end


return _M