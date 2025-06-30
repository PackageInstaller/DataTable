--[[ 
-----------------------------------------------------
@filename       : MainExploreHeroVo
@Description    : 英雄信息
@date           : 2021-08-07 14:16:01
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreHeroVo", Class.impl())

function setData(self, cusData)
    -- 战员id
    self.heroId = cusData.hero_id
    -- 战员类型 0：自己 1：支援
    self.sourceType = cusData.type
    -- 剩余血量百分比 0-100（没有发的默认满血）
    self.nowHp = cusData.now_hp_ratio
    -- -- 怪物Id(怪物表id)
    -- self.monsterId = cusData.mon_id
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
