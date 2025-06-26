module("hero.HeroFightSkillVo", Class.impl(hero.HeroConfigVo))

function ctor(self)
end

function parseData(self, cusMsg)
    self.skillId = cusMsg.id
    self.pos = cusMsg.pos
    self.isUnlock = cusMsg.is_unlock
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
