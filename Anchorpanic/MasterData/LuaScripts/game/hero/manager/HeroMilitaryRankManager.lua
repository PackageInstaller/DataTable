module("hero.HeroMilitaryRankManager", Class.impl(Manager))

-- 英雄军衔界面材料选择更改
HERO_MILITARY_RANK_MATERIAL_SELECT = "HERO_MILITARY_RANK_MATERIAL_SELECT"

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
    self.m_heroMiliatryRankDic = nil

    -- 英雄晋升材料需要的数量
    self.needMaterialCount = 0
    -- 当前英雄晋升材料选择的英雄id列表
    self.materialHeroIdList = {}
end

-- 初始化配置表
function parseConfigData(self)
    self.m_heroMiliatryRankDic = {}
    local baseData = RefMgr:getData("hero_military_rank_data")
    for tid, data in pairs(baseData) do
        for key, voData in pairs(data.military_rank) do
            local vo = hero.HeroMilitaryRankConfigVo.new()
            vo:parseConfigData(tid, voData)
            if (not self.m_heroMiliatryRankDic[tid]) then
                self.m_heroMiliatryRankDic[tid] = {}
            end
            self.m_heroMiliatryRankDic[tid][vo.lvl] = vo
        end
    end
end

-- 取配置数据字典
function getMilitaryRankDic(self, cusTid)
    if (not self.m_heroMiliatryRankDic) then
        self:parseConfigData()
    end
    return self.m_heroMiliatryRankDic[cusTid] or {}
end

-- 取配置数据Vo
function getMilitaryRankConfigVo(self, cusTid, militaryRankLvl)
    if (not self.m_heroMiliatryRankDic) then
        self:parseConfigData()
    end
    return self:getMilitaryRankDic(cusTid)[militaryRankLvl] or {}
end

-- 获取最大军衔等级（军衔阶数）
function getMaxMilitaryRankLvl(self, cusTid)
    local maxLvl = 0
    local data = self:getMilitaryRankDic(cusTid)
    for lvl, vo in pairs(data) do
        if (lvl >= maxLvl) then
            maxLvl = lvl
        end
    end
    return maxLvl
end

-- 根据等级获取英雄列表
function getHeroScrollList(self, cusLvl, exceptHeroId)
    local heroScrollList = {}
    local heroDic = hero.HeroManager:getHeroDic()
    for id, heroVo in pairs(heroDic) do
        if (heroVo.lvl >= cusLvl and heroVo.id ~= exceptHeroId) then
            local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
            scrollVo:setDataVo(heroVo)
            table.insert(heroScrollList, scrollVo)
        end
    end

    local function _heroSort(a, b)
        local a_canUse = hero.HeroUseCodeManager:getIsCanUse(a.m_dataVo.id)
        local b_canUse = hero.HeroUseCodeManager:getIsCanUse(b.m_dataVo.id)

        if a_canUse == false and b_canUse == true then
            return false
        elseif a_canUse == b_canUse then
            if a.m_dataVo.lvl > b.m_dataVo.lvl then
                return false
            else
                return a.m_dataVo.id < b.m_dataVo.id
            end
        end
        return true
    end

    table.sort(heroScrollList, _heroSort)

    return heroScrollList
end

-- 根据技能id获取
function getVoByHeroTidAndSkillId(self, cusHeroTid, cusSkillId)
    local militaryRankDic = self:getMilitaryRankDic(cusHeroTid)
    if (militaryRankDic) then
        for lvl, configVo in pairs(militaryRankDic) do
            if (configVo.unlockSkillId == cusSkillId) then
                return configVo
            end
        end
    end
end

-- 根据解锁的技能id获取
function getVoByHeroTidAndUnLockSkillId(self, cusHeroTid, cusSkillId)
    local militaryRankDic = self:getMilitaryRankDic(cusHeroTid)
    if (militaryRankDic) then
        for lvl, configVo in pairs(militaryRankDic) do
            if (configVo.unlockSkillId == cusSkillId) then
                return configVo
            end
        end
    end
end

-- 获取战员是否有军阶技能
function getHeroHasMilitaryRankSkill(self, cusHeroTid)
    local data = self:getMilitaryRankDic(cusHeroTid)
    for _, vo in pairs(data) do
        if vo.unlockSkillId > 0 then
            return true
        end
    end
    return false
end

--析构函数
function dtor(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
