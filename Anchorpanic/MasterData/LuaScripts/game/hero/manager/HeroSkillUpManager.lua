--[[ 
-----------------------------------------------------
@filename       : HeroSkillUpManager
@Description    : 英雄技能升级配置管理
@date           : 2020-12-07 20:04:51
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('hero.HeroSkillUpManager', Class.impl(Manager))

-- 英雄技能升级界面材料选择更改
HERO_SKILL_UP_MATERIAL_SELECT = "HERO_SKILL_UP_MATERIAL_SELECT"
-- 英雄技能升级界面材料更新
HERO_SKILL_UP_MATERIAL_UPDATE = "HERO_SKILL_UP_MATERIAL_UPDATE"

--构造
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

--初始化
function __init(self)
    self.mConfigDic = nil

    -- 英雄技能升级材料需要的数量
    self.needMaterialCount = nil
    -- 当前英雄技能升级材料选择的英雄id列表
    self.materialHeroIdList = {}
end

-- 解析英雄技能升级配置管理
function parseConfigData(self)
    self.mConfigDic = {}
    local baseData = RefMgr:getData("hero_skill_data")
    for heroId, data in pairs(baseData) do
        if(not self.mConfigDic[heroId])then
            self.mConfigDic[heroId] = {}
        end
        for _, skillData in pairs(data.skill_data) do
            for __, lvlData in pairs(skillData.skill_levelup_data) do
                local configVo = hero.HeroSkillUpConfigVo.new()
                configVo:parseConfigData(heroId,skillData.skill_id, lvlData)
               
                if(not self.mConfigDic[heroId])then
                    self.mConfigDic[heroId] = {}
                end
                if(not self.mConfigDic[heroId][configVo.skillId])then
                    self.mConfigDic[heroId][configVo.skillId] = {}
                end
                self.mConfigDic[heroId][configVo.skillId][configVo.skillLvl] = configVo
            end
        end
    end
end

-- 获取英雄技能升级配置数据
function getSkillUpConfigVo(self, cusHeroTid, cusSkillId, cusSkillLvl)
    if not self.mConfigDic then
        self:parseConfigData()
    end
    if not cusSkillLvl then 
        cusSkillLvl = 1
    end
    local dic = self.mConfigDic[cusHeroTid]
    if(dic)then
        dic = dic[cusSkillId]
        if(dic)then
            return dic[cusSkillLvl]
        end
    end
 
    return nil
end

-- 获取指定英雄技能升级可达到最大等级
function getHeroMaxSkillLvl(self, cusHeroTid, cusSkillId)
    if not self.mConfigDic then
        self:parseConfigData()
    end
    local maxLvl = -1
    local LvlDic = self.mConfigDic[cusHeroTid][cusSkillId]
    if(LvlDic)then
        for skillLvl, vo in pairs(LvlDic) do
            if (skillLvl >= maxLvl) and vo.needHeroLv ~= 0 then
                maxLvl = skillLvl
            end
        end
    end
    return maxLvl
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

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
