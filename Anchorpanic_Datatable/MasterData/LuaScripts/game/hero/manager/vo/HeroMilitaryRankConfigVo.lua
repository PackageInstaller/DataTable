module("hero.HeroMilitaryRankConfigVo", Class.impl(hero.HeroConfigVo))

function ctor(self)
    self:__init()
end

function __init(self)
    self.tid = nil
    -- 军衔等级
    self.lvl = nil
    -- 对应英雄的最大等级限制
    self.heroMaxLvl = nil
    -- 消耗的货币
    self.cost = nil
    -- 军衔icon
    self.icon = nil
    -- 需要消耗的道具材料
    self.costList = nil
    -- 需要消耗的英雄等级
    self.needHeroLvl = nil
    -- 需要消耗的英雄数量
    self.needHeroNum = nil
    -- 解锁的技能对应的原始技能id
    self.sourceSkillId = nil
    -- 解锁的技能id
    self.unlockSkillId = nil
    --基建技能
    self.warshipSkill = nil
    -- 军阶名字
    self.name = nil
    -- 需要通关的关卡id
    self.stageId = nil
end

function parseConfigData(self, cusTid, cusData)
    self.tid = cusTid
    self.lvl = cusData.rank
    self.heroMaxLvl = cusData.level_limit
    self.cost = {cusData.pay_id, cusData.pay_num}
    self.icon = cusData.icon
    self.costList = cusData.cost_tid_list
    self.needPlayerLvl = cusData.level
    self.needHeroLvl = cusData.hero_level
    self.needHeroNum = cusData.num
    self.name = cusData.name
    self.sourceSkillId = cusData.skill
    self.unlockSkillId = cusData.deblocking
    self.warshipSkill = cusData.warship_skill

    self.stageId = cusData.stage_id
end

function getName(self)
    return _TT(self.name)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
