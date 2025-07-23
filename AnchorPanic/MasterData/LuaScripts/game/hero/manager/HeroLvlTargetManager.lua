--[[ 
-----------------------------------------------------
@filename       : HeroLvlTargetManager
@Description    : 英雄等级目标管理
@date           : 2022-2-18 14:54:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("hero.HeroLvlTargetManager", Class.impl(Manager))

-- 等级目标列表数据更新
UPDATE_LVL_TARGET_lIST = "UPDATE_LVL_TARGET_lIST"
-- 等级目标数据更新
UPDATE_LVL_TARGET = "UPDATE_LVL_TARGET"

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
    self.mHasRecDic = nil
end

-- 解析英雄技能升级配置管理
function parseConfigData(self)
    self.mConfigDic = {}
    local baseData = RefMgr:getData("hero_lvl_target")
    for heroTid, data in pairs(baseData) do
        if (not self.mConfigDic[heroTid]) then
            self.mConfigDic[heroTid] = {}
        end
        for targetId, lvlAward in pairs(data.level_reward) do
            local configVo = hero.HeroLvlTargetConfigVo.new()
            configVo:parseConfigData(heroTid, targetId, lvlAward)
            table.insert(self.mConfigDic[heroTid], configVo)
        end
    end
end

-- 根据英雄tid获取等级目标列表
function getLvlTargetList(self, heroTid)
    if (not self.mConfigDic) then
        self:parseConfigData()
    end
    return self.mConfigDic[heroTid] or {}
end

-- 根据英雄tid获取等级目标数据vo
function getLvlTargetConfigVo(self, heroTid, targetId)
    local targetList = self:getLvlTargetList(heroTid)
    for i = 1, #targetList do
        if (targetList[i].id == targetId) then
            return targetList[i]
        end
    end
end

-- 根据英雄tid获取等级目标列表是否有可领取
function isHeroLvlTargetListBubble(self, heroVo)
    local isBubble = false
    local targetList = self:getLvlTargetList(heroVo.tid)
    for i = 1, #targetList do
        isBubble = self:isHeroLvlTargetBubble(heroVo, targetList[i])
        if (isBubble) then
            break
        end
    end
    return isBubble
end

-- 根据英雄数据获取等级目标列表是否已全部领取
function isHeroLvlTargetListAllBubble(self, heroVo)
    if(heroVo == nil) then 
        return false
    end
    local targetList = self:getLvlTargetList(heroVo.tid)
    return self:isHeroLvlTargetHasBubble(heroVo, targetList[#targetList])
     
end

-- 根据英雄tid获取等级目标是可领取
function isHeroLvlTargetBubble(self, heroVo, targetConfigVo)
    if (targetConfigVo and targetConfigVo:getState(heroVo) == task.AwardRecState.CAN_REC) then
        return true
    end
    return false
end

-- 根据英雄tid获取等级目标是已领取
function isHeroLvlTargetHasBubble(self, heroVo, targetConfigVo)
    if (targetConfigVo and targetConfigVo:getIsAllRec(heroVo) == true) then
        return true
    end
    return false
end

-- 解析已领取的目标列表
function parseRecTargetAwardList(self, allLvlList)
    for i = 1, #allLvlList do
        local heroTid = allLvlList[i].hero_tid
        local recIdList = allLvlList[i].received_ids
        for i = 1, #recIdList do
            self:parseRecTargetAward(heroTid, recIdList[i], false)
        end
    end
    self:dispatchEvent(self.UPDATE_LVL_TARGET_lIST, { heroTid = nil, targetId = nil })
end

-- 解析已领取的目标列表
function parseRecTargetAward(self, heroTid, recData, isDispatch)
    if (not self.mHasRecDic) then
        self.mHasRecDic = {}
    end
    if (not self.mHasRecDic[heroTid]) then
        self.mHasRecDic[heroTid] = {}
    end
    table.insert(self.mHasRecDic[heroTid], recData)
    if (isDispatch) then
        self:dispatchEvent(self.UPDATE_LVL_TARGET_lIST, { heroTid = heroTid, targetId = recData })
        -- self:dispatchEvent(self.UPDATE_LVL_TARGET, {heroTid = heroTid, targetId = recData})
    end
end

-- 获取已领取的目标列表
function getRecTargetList(self, heroTid)
    if (not self.mHasRecDic) then
        self.mHasRecDic = {}
    end
    local list = self.mHasRecDic[heroTid]
    return list or {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]