module("hero.HeroColorUpConfigVo", Class.impl(hero.HeroConfigVo))

function ctor(self)
    self:__init()
end

function __init(self)
    self.color = nil
    -- 需要消耗的英雄tid（0：任意tid英雄）
    self.needHeroTid = nil
    -- 需要消耗的英雄数量
    self.needHeroNum = nil
    -- 需要消耗的英雄品质
    self.needHeroColor = nil
    -- 主动技能id
    self.skillId = nil
    -- 消耗的货币
    self.cost = nil
    -- 对应变化的属性key列表
    self.keyList = {}
end

function parseConfigData(self, cusData)
    self.color = cusData.hero_color
    self.needHeroTid = cusData.tid
    self.needHeroNum = cusData.num
    self.needHeroColor = cusData.color
    self.skillId = cusData.skill
    self.cost = {cusData.pay_id, cusData.pay_num}
    for k, v in pairs(cusData.attr) do
        table.insert(self.keyList, v.key)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
