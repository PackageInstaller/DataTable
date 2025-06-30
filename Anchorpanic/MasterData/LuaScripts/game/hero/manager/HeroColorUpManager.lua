module("hero.HeroColorUpManager", Class.impl(Manager))

-- 英雄升品界面材料选择更改
HERO_COLOR_UP_MATERIAL_SELECT = "HERO_COLOR_UP_MATERIAL_SELECT"

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
    self.m_heroColorUpDic = nil

    -- 英雄晋升材料需要的数量
    self.needMaterialCount = 0
    -- 当前英雄晋升材料选择的英雄id列表
    self.materialHeroIdList = {}
end

-- 初始化配置表
function parseConfigData(self)
    self.m_heroColorUpDic = {}
    local baseData = RefMgr:getData("hero_color_upgrade_data")
    for tid, data in pairs(baseData) do
        for key, voData in pairs(data.upgrade_attr) do
            local vo = hero.HeroColorUpConfigVo.new()
            vo:parseConfigData(voData)
            if (not self.m_heroColorUpDic[tid]) then
                self.m_heroColorUpDic[tid] = {}
            end
            self.m_heroColorUpDic[tid][vo.color] = vo
        end
    end
end

-- 取配置数据
function getHeroColorUpDic(self, cusTid)
    if (not self.m_heroColorUpDic) then
        self:parseConfigData()
    end
    return self.m_heroColorUpDic[cusTid]
end

-- 取配置数据
function getHeroColorUpConfigVo(self, cusTid, cusColor)
    local colorDic = self:getHeroColorUpDic(cusTid)
    if(colorDic)then
        return colorDic[cusColor]
    else
        return {}
    end
end

-- 获取指定英雄可达到最大品质
function getHeroMaxColor(self, cusTid)
    local maxColor = -1
    local colorDic = self:getHeroColorUpDic(cusTid)
    if(colorDic)then
        for color, vo in pairs(colorDic) do
            if (color >= maxColor) then
                maxColor = color
            end
        end
    end
    return maxColor
end

-- 判断英雄是否可以升品
function isCanColorUp(self, cusTid)
    return self:getHeroColorUpDic(cusTid) ~= nil
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

-- 根据英雄tid和激活的主动技能id获取对应应达品质
function getColorByHeroTidAndSkillId(self, heroTid, skillId)
    local colorDic = self:getHeroColorUpDic(heroTid)
    if(colorDic)then
        for color, vo in pairs(colorDic) do
            if (vo.skillId == skillId) then
                return color
            end
        end
    end
    return nil
end

function getDefaultMaterialHeroIdList(self, needHeroTid, newHeroLvl, needHeroColor, exceptHeroId)
    local heroList = hero.HeroColorUpManager:getHeroList(needHeroColor, needHeroTid, exceptHeroId)
    local heroIdList = {}
    for i= 1, #heroList do
        if (heroList[i].lvl == newHeroLvl) then
            table.insert(heroIdList, heroList[i])
        end
    end
    return heroIdList
end

--析构函数
function dtor(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
