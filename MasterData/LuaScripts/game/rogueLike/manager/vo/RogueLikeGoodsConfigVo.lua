--[[ 
-----------------------------------------------------
@filename       : RogueLikeGoodsConfigVo
@Description    : 肉鸽buff数据
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] 
module("maze.RogueLikeGoodsConfigVo", Class.impl())

function parseData(self, cusId, cusData)
    self.id = cusId
    -- 技能id
    self.skillId = cusData.skill_id
    -- 作战效率
    self.efficiency = cusData.combat_eff
    -- 图标
    self.icon = cusData.icon
    -- buff类型
    self.type = cusData.type
    -- 购买价格
    self.payPrice = cusData.pay_price
    -- 出售价格
    self.sellPrice = cusData.sell_price
    -- 是否是收藏品
    self.collectionShow = cusData.collection_show

    --2 3 4分别是蓝 紫 橙
    self.collectionLevel = cusData.collection_level

    --1 攻击 2 防御 3治疗 4异常 
    self.collectionType = cusData.collection_type

    -- 适用于战员类型
    self.heroList = cusData.hero_type
end

-- 技能名
function getName(self)
    local skillVo = fight.SkillManager:getSkillRo(self.skillId)
    return skillVo:getName()
end

-- 技能描述
function getDes(self)
    local skillVo = fight.SkillManager:getSkillRo(self.skillId)
    return skillVo:getDesc()
end

function getIcon(self)
    local skillVo = fight.SkillManager:getSkillRo(self.skillId)
    return skillVo:getIcon()
end

-- 获取购买价格 [1]消耗物品 [2]消耗数量
function getBuyCost(self)
    return self.payPrice
end

-- 获取出售价格 [1]消耗物品 [2]消耗数量
function getSellCost(self)
    return self.sellPrice
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
