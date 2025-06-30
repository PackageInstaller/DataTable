--[[
    CD冷却数据vo
]]
module('fight.CdDicVo', Class.impl())

function ctor(self)
    self:__init()
end

function __init(self)
    self.livethingId = -1
    self.skillId = -1
    self.isAttacker = false
    self.skillCd = 0
end

function setData(self, cusLivethingVo, cusSkillVo)
    self.livethingId = cusLivethingVo.id
    self.isAttacker = cusLivethingVo:isAttacker()
    self.skillId = cusSkillVo.id
    self.skillCd = cusSkillVo.skillCd
end

function reset(self)
    self:__init()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
