module('guild.GuildSkillEffVo', Class.impl())

function parseData(self,id,cusData)
    self.needLv = id
    self.arrName = cusData.arr_name
    self.arrShow = cusData.arr_show
end


return _M