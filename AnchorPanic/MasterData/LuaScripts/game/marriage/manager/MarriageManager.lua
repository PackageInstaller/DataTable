module("marriage.MarriageManager", Class.impl(Manager))

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:__initData()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__initData()
    self.isSucceed = false
end

function __initData(self)
end


function setMarriageHeroId(self,heroId)
    self.heroId = heroId
end

function getMarriageHeroId(self)
    return self.heroId
end

function setMarriageSucceed(self,isSucceed)
    self.isSucceed = isSucceed
end

function getMarriageSucceed(self)
    local isSucceed = self.isSucceed
    self.isSucceed = false
    return isSucceed 
end

function getReadIsMarriage(self,heroVo)
    local favorableVo = favorable.FavorableManager:getHeroFavorableData(heroVo.tid)
    local propsTid = sysParam.SysParamManager:getValue(SysParamType.MARRIAGE_PROPS_TID)
    local hasCount = MoneyUtil.getMoneyCountByTid(propsTid)
   
    return favorableVo.isPromise and hasCount > 0 and  heroVo.isPromise == 0
end

return _M