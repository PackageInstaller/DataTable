module("hero.HeroStarManager", Class.impl(Manager))

-- 英雄升星界面材料选择更改
HERO_STARUP_MATERIAL_SELECT = "HERO_STARUP_MATERIAL_SELECT"

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
    self.m_heroStarDic = nil

    -- 英雄升星材料需要的数量
    self.needMaterialCount = 0
    -- 当前英雄升星材料选择的英雄id列表
    self.materialHeroIdList = {}
end

-- 初始化配置表
function parseConfigData(self)
    self.m_heroStarDic = {}
    local baseData = RefMgr:getData("hero_star_data")
    for tid, data in pairs(baseData) do
        for key, voData in pairs(data.hero_star) do
            local vo = hero.HeroStarConfigVo.new()
            vo:parseConfigData(tid, voData)
            if (not self.m_heroStarDic[tid]) then
                self.m_heroStarDic[tid] = {}
            end
            self.m_heroStarDic[tid][vo.star] = vo
        end
    end
end

-- 取配置数据字典
function getHeroStarDic(self, cusTid)
    if(not self.m_heroStarDic)then
        self:parseConfigData()
    end
    return self.m_heroStarDic[cusTid]
end

-- 取配置数据Vo
function getHeroStarConfigVo(self, cusTid, cusStar)
    local starDic = self:getHeroStarDic(cusTid)
    if(starDic)then
        return starDic[cusStar]
    end
end

-- 判断英雄是否可以升星
function isCanStarUp(self, cusTid, cusStar, cusColor)
    local starConfigVo = self:getHeroStarConfigVo(cusTid, cusStar)
    if(starConfigVo)then
        return true
    else
        return false
    end
end

-- 获取最大星级
function getHeroMaxStarLvl(self, cusTid)
    local maxStarLvl = nil
    if(cusTid ~= nil)then
        local starDic = self:getHeroStarDic(cusTid)
        for starLvl, vo in pairs(starDic) do
            if (maxStarLvl == nil or starLvl >= maxStarLvl) then
                maxStarLvl = starLvl
            end
        end
    else
        for tid, starDic in pairs(self.m_heroStarDic) do
            for starLvl, vo in pairs(starDic) do
                if (maxStarLvl == nil or starLvl >= maxStarLvl) then
                    maxStarLvl = starLvl
                end
            end
        end
    end
    return maxStarLvl or 0
end

-- 获取最小星级
function getHeroMinStarLvl(self, cusTid)
    local minStarLvl = nil
    if(cusTid ~= nil)then
        local starDic = self:getHeroStarDic(cusTid)
        for starLvl, vo in pairs(starDic) do
            if (minStarLvl == nil or starLvl <= minStarLvl) then
                minStarLvl = starLvl
            end
        end
    else
        for tid, starDic in pairs(self.m_heroStarDic) do
            for starLvl, vo in pairs(starDic) do
                if (minStarLvl == nil or starLvl <= minStarLvl) then
                    minStarLvl = starLvl
                end
            end
        end
    end
    return minStarLvl or 0
end

-- 根据英雄id和技能id获取所需星级
function getHeroSkillStarLvl(self, cusTid, cusSkillId)
    local starDic = self:getHeroStarDic(cusTid)
    for starLvl, vo in pairs(starDic) do
        if (vo.passiveSkillId == cusSkillId) then
            return starLvl
        end
    end
    return nil
end

-- 获取英雄列表
function getHeroList(self, needColor, needHeroTid, exceptHeroId)
    local heroList = {}
    local heroDic = hero.HeroManager:getHeroDic()
    for k, heroVo in pairs(heroDic) do
        if((needColor == nil or needColor <= 0 or needColor and needColor == heroVo.color) and (needHeroTid == nil or needHeroTid <= 0 or needHeroTid == heroVo.tid) and exceptHeroId ~= heroVo.id)then
            table.insert(heroList, heroVo)
        end
    end
    table.sort(heroList, hero.descendingColorFun)
    return heroList
end

-- 根据id获取英雄列表
function getHeroScrollList(self, cusTid, cusColor, exceptHeroId)
    local heroScrollList = {}
    local heroDic = hero.HeroManager:getHeroDic()
    for id, heroVo in pairs(heroDic) do
        if ((cusTid <= 0 or heroVo.tid == cusTid) and heroVo.color == cusColor and heroVo.id ~= exceptHeroId) then
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

-- 获取第几个潜能技能对应的星级
function getStarByPassSkillIndex(self, cusTid, passiveSkillIndex)
    local star = nil
    local index = 0
    local minStarLvl = hero.HeroStarManager:getHeroMinStarLvl(cusTid)
    local maxStarLvl = hero.HeroStarManager:getHeroMaxStarLvl(cusTid)
    local starDic = self:getHeroStarDic(cusTid)
    for starLvl = minStarLvl, maxStarLvl do
        local skillId = starDic[starLvl].passiveSkillId
        if(skillId > 0)then
            local skillVo = fight.SkillManager:getSkillRo(skillId)
            if (skillVo and skillVo:getType() == fight.FightDef.SKILL_TYPE_PASSIVE_SKILL) then
                index = index + 1
                if(index == passiveSkillIndex)then
                    star = starLvl
                    break
                end
            end
        end
    end
    return star
end

--析构函数
function dtor(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
