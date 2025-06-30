--[[ 
-----------------------------------------------------
@filename       : HeroShowManager
@Description    : 英雄助战管理
@date           : 2022-3-1 14:54:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('hero.HeroAssistManager', Class.impl(Manager))

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
    self.mHeroAssistDic = nil
    self.mHeroAssistConfigDic = nil
end

-- 初始化助战配置表
function parseHeroAssistData(self)
    self.mHeroAssistConfigDic = {}
    local baseData = RefMgr:getData("hero_assist_data")
    for tid, data in pairs(baseData) do
        if(not self.mHeroAssistConfigDic[tid])then
            self.mHeroAssistConfigDic[tid] = {} 
        end
        for i = 1, #data.assist_skill do
            local vo = hero.HeroAssistConfigVo.new()
            vo:parseData(tid, data.assist_skill[i])
            table.insert(self.mHeroAssistConfigDic[tid], vo)
        end
    end
end

--获取助战配置信息
function getHeroAssistConfigList(self, tid)
    if(not self.mHeroAssistConfigDic)then
        self:parseHeroAssistData()
    end
    return self.mHeroAssistConfigDic[tid]
end

-- 解析英雄助战技能列表
function parseHeroAssistFightSkill(self, isInit, msgList)
    if(not self.mHeroAssistDic or isInit)then
        self.mHeroAssistDic = {}
    end
    for i = 1, #msgList do
        local vo = hero.HeroAssistVo.new()
        vo:parseMsgData(msgList[i])
        self.mHeroAssistDic[vo.heroId] = vo
    end
end

-- 判断指定英雄是否包含有激活了的助战技能
function isHeroAssistSkillActive(self, heroId)
    local heroVo = hero.HeroManager:getHeroVo(heroId)
    if(heroVo)then
        local assistConfigList = self:getHeroAssistConfigList(heroVo.tid)
        for i = 1, #assistConfigList do
            if (self:isAssistSkillActive(heroId, assistConfigList[i].skillId)) then
                return true
            end
        end
    end
    return false
end

-- 判断指定英雄的指定助战技能是否解锁
function isAssistSkillActive(self, heroId, skillId)
    if(self.mHeroAssistDic and self.mHeroAssistDic[heroId])then
        local vo = self.mHeroAssistDic[heroId]
        return table.indexof(vo.skillIdList, skillId) ~= false
    end
    return false
end

function isShowNew(self, heroId, skillId)
    if (read.ReadManager:isModuleRead(ReadConst.ASSIST_FIGHT, self:getReadModuleId(heroId, skillId))) then
        return true
    else
        return false
    end
end

function getReadModuleId(self, heroId, skillId)
    return heroId + skillId * 10000
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
