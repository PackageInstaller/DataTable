module("hero.HeroLvlUpManager", Class.impl(Manager))

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

--析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    self.m_heroLvlUpDic = nil
end

-- 初始化配置表
function parseConfigData(self)
    self.m_heroLvlUpDic = {}
    local baseData = RefMgr:getData("hero_levelup_data")
    for tid, data in pairs(baseData) do
        for key, voData in pairs(data.hero_levelup) do
            local vo = hero.HeroLvlUpConfigVo.new()
            vo:parseConfigData(tid, voData)
            if (not self.m_heroLvlUpDic[tid]) then
                self.m_heroLvlUpDic[tid] = {}
            end
            self.m_heroLvlUpDic[tid][vo.lvl] = vo
        end
    end
end

-- 取配置数据
function getHeroLvlUpDic(self, cusTid)
    if (not self.m_heroLvlUpDic) then
        self:parseConfigData()
    end
    return self.m_heroLvlUpDic[cusTid] or {}
end

-- 取配置数据
function getHeroLvlUpConfigVo(self, cusTid, cusLvl)
    return self:getHeroLvlUpDic(cusTid)[cusLvl] or {}
end

-- 获取指定英雄最大等级
function getHeroMaxLvl(self, cusTid)
    local maxLvl = 0
    local lvlDic = self:getHeroLvlUpDic(cusTid)
    for lvl, vo in pairs(lvlDic) do
        if (lvl >= maxLvl) then
            maxLvl = lvl
        end
    end
    return maxLvl
end

-- 获取指定英雄当前等级的经验上限
function getHeroMaxExp(self, cusTid, cusLvl)
    local lvlUpConfigVo = self:getHeroLvlUpConfigVo(cusTid, cusLvl)
    return lvlUpConfigVo.exp or 0
end

-- 获取等级间需要的经验总值
function getHeroLvlGapAllExp(self, cusHeroVo, cusMaxLvl)
    local allExp = 0
    for i = cusHeroVo.lvl, cusMaxLvl - 1 do
        local exp = self:getHeroMaxExp(cusHeroVo.tid, i)
        allExp = allExp + exp
    end
    return allExp
end

-- 获取一键升级最高数量
function getLvlUpMaxPropsCount(self, heroVo)
    local costTid = MoneyTid.HERO_GLOBAL_EXP_TID
    local propsConfigVo = props.PropsManager:getPropsConfigVo(costTid)
    if (propsConfigVo.effectType == UseEffectType.CONVERT_HERO_EXP) then
        local maxExp = self:getHeroLvlGapAllExp(heroVo, heroVo:getMaxMilitaryLvl())
        local convertExp = propsConfigVo.effectList[1]
        local needExp = maxExp - heroVo.exp
        if (needExp < 0) then
            needExp = 0
        end
        local ownCount = MoneyUtil.getMoneyCountByTid(costTid)
        local needCount = math.ceil(needExp / convertExp)
        local canGoLvl = heroVo:getMaxMilitaryLvl()
        local useExpCount = 0
        if ownCount < needCount then
            canGoLvl, useExpCount = self:getCanGoLvl(heroVo, ownCount)
            needCount = useExpCount
        end

        return propsConfigVo, needCount, canGoLvl
    end
    return nil, nil
end
-- 获取授予经验能升到的最大等级和需要经验（刚好升级）
function getCanGoLvl(self, cusHeroVo, allExp)
    local canGoLvl = 0
    local useExp = 0
    local remaidExp = allExp + cusHeroVo.exp
    for i = cusHeroVo.lvl, cusHeroVo:getMaxMilitaryLvl() - 1 do
        local exp = self:getHeroMaxExp(cusHeroVo.tid, i)
        remaidExp = remaidExp - exp
        if remaidExp >= 0 then
            useExp = useExp + exp
            canGoLvl = i + 1
        else
            break
        end
    end
    if cusHeroVo.exp > useExp then
        useExp = useExp
    else
        useExp = useExp - cusHeroVo.exp
    end

    return canGoLvl, useExp
end

--获取等级重置消耗配置
function getHeroResetLvCostCfg(self)
    local costCfg = sysParam.SysParamManager:getValue(SysParamType.HERO_RESET_LV_COST)
    return costCfg[1]
end

--析构函数
function dtor(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
