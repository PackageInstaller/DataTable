--[[ 
-----------------------------------------------------
@filename       : HeroFileCaseVo
@Description    : 战员资料数据
@date           : 2021-08-23 14:46:22
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.heroFile.manager.vo.HeroFileCaseVo', Class.impl())

function parseData(self, key, cusData, heroTid)
    self.id = key
    self.heroTid = heroTid
    self.describe = cusData.describe
    self.relationLv = cusData.relation_lv
    self.title = cusData.title
    self.dropId = cusData.drop_id
end

function getDesc(self)
    if self.title == 47011 then
        local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.heroTid)
        return heroConfigVo.life
    end
    return _TT(self.describe)
end

function getTitle(self)
    return _TT(self.title)
end

-- 解锁奖励
function rewardList(self)
    return AwardPackManager:getAwardListById(self.dropId)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]