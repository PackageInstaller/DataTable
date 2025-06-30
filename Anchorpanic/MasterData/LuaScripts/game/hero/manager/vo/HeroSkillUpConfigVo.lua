module("hero.HeroSkillUpConfigVo", Class.impl(hero.HeroConfigVo))

function ctor(self)
end

function parseConfigData(self, heroId, cusSkillId, cusData)
    self.heroId = heroId
    --self.heroColor = heroColor
    self.skillId = cusSkillId
    self.needHeroRank = cusData.hero_rank
    self.skillLvl = cusData.skill_lv
    -- 需要消耗的英雄tid（0：任意tid英雄）
    --self.needHeroTid = cusData.cost_tid
    -- 需要消耗的英雄数量
    --self.needHeroNum = cusData.cost_num
    -- 需要消耗的英雄品质
    --self.needHeroColor = cusData.cost_color
    -- 消耗的货币
    self.costItem = cusData.cost_item
    self.needStar = cusData.need_star

    self.cost = { cusData.pay_tid, cusData.pay_num }
    -- 技能描述
    self.skillDes = cusData.desc
    -- 技能描述（包含有下一级的显示，用于英雄技能界面显示）
    self.skillLvUpDes = cusData.skill_levelup_des
end

-- 技能描述
function getDesc(self)
    return self.skillDes
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
