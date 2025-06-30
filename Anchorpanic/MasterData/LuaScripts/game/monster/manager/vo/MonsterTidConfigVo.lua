--[[    
    怪物唯一tid配置
    @author Jacob
]]
module("monster.MonsterTidConfigVo", Class.impl())

function parseData(self, cusUniqueTid, cusData)
    self.uniqueTid = cusUniqueTid
    self.tid = cusData.tid
    self.lvl = cusData.level
    self.evolutionLvl = cusData.star
end

function getBaseConfig(self)
    return monster.MonsterManager:getMonsterVo01(self.tid)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
