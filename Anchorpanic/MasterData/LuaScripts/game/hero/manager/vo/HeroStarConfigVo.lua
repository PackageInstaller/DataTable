module("hero.HeroStarConfigVo", Class.impl(hero.HeroConfigVo))

function ctor(self)
    self:__init()
end

function __init(self)
    self.tid = nil
    self.star = nil
    -- 被动技能id
    self.passiveSkillId = nil
    -- 需要消耗的道具
    self.needCostProps = nil
    -- 消耗的货币
    self.cost = nil
end

function parseConfigData(self, cusTid, cusData)
    self.tid = cusTid
    self.star = cusData.star
    self.needOwnColor = cusData.color
    self.passiveSkillId = cusData.skill
    self.needCostProps = cusData.cost_item
    self.cost = {cusData.pay_id, cusData.pay_num}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
