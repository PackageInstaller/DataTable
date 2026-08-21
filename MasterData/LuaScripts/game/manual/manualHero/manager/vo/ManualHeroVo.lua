--[[ 
-----------------------------------------------------
@filename       : ManualHeroVo
@Description    : 战员Vo
@date           : 2023-3-27 14:58:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualHeroVo", Class.impl())

function parseData(self, index, cusData)
    self.index = index
    self.name = cusData.name
    self.camp = cusData.camp
    self.painting = cusData.painting
    self.tid = cusData.tid
    self.model = cusData.model
    self.data = cusData
end

--获取名字
function getName(self)
    return _TT(self.name)
end
--获取图片
function getHeroImg(self)
    return UrlManager:getHeroBodyImgUrl(self.model)
end

function getDataVo(self)
    local heroVo = hero.HeroManager:getHeroVoByTid(self.tid)
    if not heroVo then
        heroVo = hero.HeroManager:getHeroConfigVo(self.tid)
    end
    return heroVo
end

--获取是否已解锁
function getIsUnlock(self)
    return (hero.HeroManager:getIsObtain(self.tid) ~= false)
end

function getSort(self)
    local sort = self.index
    if self:getIsUnlock() then
        sort = sort + 10000
    end
    return sort
end

function getIsNew(self)
    return read.ReadManager:isModuleRead(ReadConst.MANUAL_HERO, self.tid)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]