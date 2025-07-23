-- 战员信息
module("rogueLike.RogueLikeHeroVo", Class.impl())

function parseData(self, cusData)
    -- 战员id
    self.heroId = cusData.hero_id
    -- 当前血量
    self.nowHp = cusData.hp_now
    -- 最大血量
    self.maxHp = cusData.hp_max
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
