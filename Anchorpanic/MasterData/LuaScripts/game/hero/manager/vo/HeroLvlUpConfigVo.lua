module("hero.HeroLvlUpConfigVo", Class.impl(hero.HeroConfigVo))

function ctor(self)
    self:__init()
end

function __init(self)
    self.tid = nil
    self.lvl = nil
    self.exp = nil
end

function parseConfigData(self, cusTid, cusData)
    self.tid = cusTid
    self.lvl = cusData.level
    self.exp = cusData.exp
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
