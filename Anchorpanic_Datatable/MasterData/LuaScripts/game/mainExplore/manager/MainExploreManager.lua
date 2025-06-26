--[[ 
-----------------------------------------------------
@filename       : MainExploreManager
@Description    : 主线探索数据管理器
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreManager", Class.impl(Manager))

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
     super.resetData(self)
     self:__init()
end

function __init(self)
    -- 玩家的战员tid
    self.mPlayerHeroTid = nil
    -- 玩家英雄坐标
    self.mPlayerHeroPos = nil
    -- 当前正在指引中的事件字典
    self.mGuideEventDic = nil
    -- 返回地图后待效果表现的数据
    self.mWaitEventEffectList = nil
    -- 已完成的事件初始介绍id列表
    self.mFinishIntroduceEventIdList = nil
    -- 当前地图的事件列表
    self.mCurEventDic = nil
    -- 已完成的事件列表
    self.mFinishEventDic = nil
    -- 已获得的buffid列表
    self.mBuffIdList = nil
    -- 迷宫战员信息（包含自己的和支援的）
    self.mHeroListDic = nil

    -- 帧速率
    self.mRate = 1
    -- 是否在保护期
    self.mIsInProtecting = nil
    -- 指引显示状态
    self.mRemindVisible = nil

    -- 当前进入的地图配置
    self.mMapConfigVo = nil
    -- 挑战通过后计算用到的数据
    self.mCaculateData = nil
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- *s2c* 地图信息 22005
function setExploreMapInfo(self, msg)
    if(self.mFinishEventDic)then
        for eventId, eventVo in pairs(self.mFinishEventDic) do
            LuaPoolMgr:poolRecover(eventVo)
        end
        self.mFinishEventDic = {}
    end
    if(self.mCurEventDic)then
        for eventId, eventVo in pairs(self.mCurEventDic) do
            LuaPoolMgr:poolRecover(eventVo)
        end
        self.mCurEventDic = {}
    end

    self:recoveryWaitEventEffectList()
    self.mWaitEventEffectList = {}

    self:setGuideEventId(msg.map_id, msg.guide_event_id)
    self:setControlHeroPos(msg.pos)
    self:setControlHeroTid(msg.hero_tid)
    self:setGoodsList(msg.map_id, msg.buff_ids)
    self:parseMazeHeroList(msg.map_id, msg.hero_list)

    for i = 1, #msg.now_event_list do
        self:addEventVo(false, msg.now_event_list[i])
    end
    for i = 1, #msg.finish_event_list do
        self:addEventVo(true, msg.finish_event_list[i])
    end
    for i = 1, #msg.first_introduce_ids do
        self:addIntroduceId(msg.first_introduce_ids[i])
    end
    
    for i = 1, #msg.return_effect_list do
        local msgVo = msg.return_effect_list[i]
        local vo = LuaPoolMgr:poolGet(mainExplore.MainExploreWaitEffectVo)
        vo:setData(msgVo)
        table.insert(self.mWaitEventEffectList, vo)
    end
    table.sort(self.mWaitEventEffectList, self.sortWaitEventEffect)
end

-- 从小到大
function sortWaitEventEffect(data1, data2)
    if (data1.eventId < data2.eventId) then
        return true
    end
    if (data1.eventId > data2.eventId) then
        return false
    end
    return false
end

-- 返回战员信息（包含自己的和支援的）
function parseMazeHeroList(self, mapId, msgHeroList)
    if(not self.mHeroListDic)then
        self.mHeroListDic = {}
    end
    if(not self.mHeroListDic[mapId])then
        self.mHeroListDic[mapId] = {}
    end
    local heroList = self.mHeroListDic[mapId]
    for i = 1, #heroList do
        LuaPoolMgr:poolRecover(heroList[i])
    end
    heroList = {}
    self.mHeroListDic[mapId] = heroList

    for i = 1, #msgHeroList do
        local mainExploreHeroVo = LuaPoolMgr:poolGet(mainExplore.MainExploreHeroVo)
        mainExploreHeroVo:setData(msgHeroList[i])
        table.insert(heroList, mainExploreHeroVo)
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_MAIN_EXPLORE_HERO_LIST, {mapId = mapId})
end

--- 设置当前指引的事件id
function setGuideEventId(self, mapId, eventId)
    if(not self.mGuideEventDic)then
        self.mGuideEventDic = {}
    end
    local guideEventId = self.mGuideEventDic[mapId]
    self.mGuideEventDic[mapId] = eventId > 0 and eventId or nil

    -- 当前指引事件id变化，设置显示
    if(guideEventId ~= eventId)then
        self:setRemindVisible(nil)
    end
end

--- 获取当前指引的事件id
function getGuideEventId(self, mapId)
    if(self.mGuideEventDic)then
        return self.mGuideEventDic[mapId]
    end
    return nil
end

-- 根据探索地图id获取当前引导事件的对应阶段的引导事件id
function getStepRemindEventId(self, mapId)
    local stepEventId = nil
    local allCount = 0
    local finishCount = 0
    local guideEventId = self:getGuideEventId(mapId)
    if(guideEventId)then
        local eventConfigVo = mainExplore.MainExploreSceneManager:getEventConfigVo(mapId, guideEventId)
        if(eventConfigVo.eventType == mainExplore.EventType.REMIND_TIP)then
            local guideEventList = eventConfigVo:getEffecctList()
            allCount = #guideEventList
            for i = 1, allCount do
                local eventId = guideEventList[i]
                local isCanTrigger = self:getEventTriggerEnable(eventId)
                local isFinish = self:getEventVo(true, eventId)
                if(isFinish)then
                    finishCount = finishCount + 1
                elseif(not stepEventId and isCanTrigger)then
                    stepEventId = eventId
                end
            end
        end
    end
    return stepEventId, allCount, finishCount
end

--- 设置当前玩家操作的英雄坐标（只在刚进入地图初始使用，不做维护）
function setControlHeroPos(self, pos)
    self.mPlayerHeroPos = math.Vector3(tonumber(pos.x), tonumber(pos.y), tonumber(pos.z))
end

--- 获取当前玩家操作的英雄坐标（只在刚进入地图初始使用，不做维护）
function getControlHeroPos(self)
    return self.mPlayerHeroPos
end

--- 设置当前玩家操作的英雄tid
function setControlHeroTid(self, heroTid)
    if(self.mPlayerHeroTid ~= heroTid)then
        self.mPlayerHeroTid = heroTid
        GameDispatcher:dispatchEvent(EventName.MAIN_EXPLORE_PLAYER_UPDATE, heroTid)
    end
end

--- 获取当前玩家操作的英雄tid
function getControlHeroTid(self)
    return self.mPlayerHeroTid
end

-- 设置物资列表
function setGoodsList(self, mapId, list)
    if(not self.mBuffIdListDic)then
        self.mBuffIdListDic = {}
    end
    self.mBuffIdListDic[mapId] = list
end

-- 挑战通过后计算用到的数据
function setCaculateData(self, msg)
    if(msg)then
        self.mCaculateData = {buffIdList = msg.buff_id_list}
    else
        self.mCaculateData = nil
    end
end
-- 挑战通过后计算用到的数据
function getCaculateData(self)
    return self.mCaculateData
end

-- 设置通过所有副本后的数据
function setAllDupPassData(self, msg)
    -- 奖励(第二次通过为空)
    if(msg)then
        if(#msg.award_list > 0)then
            self.mAllDupPassData = {mapId = msg.map_id, awardMsgList = msg.award_list}
        else
            self.mAllDupPassData = {mapId = msg.map_id, awardMsgList = {}}
        end
    else
        self.mAllDupPassData = nil
    end
    -- 不在这里实时通知通关了
    -- GameDispatcher:dispatchEvent(EventName.UPDATE_MAIN_EXPORE_PASS)
end
-- 获取通过所有副本后的数据
function getAllDupPassData(self)
    return self.mAllDupPassData
end

-- 增加服务器对应事件数据
function addEventVo(self, isFinishType, msgVo)
    local eventDic = self:getEventDic(isFinishType)
    self:delEventVo(isFinishType, msgVo.event_id)
    local eventVo = LuaPoolMgr:poolGet(mainExplore.MainExploreEventVo)
    eventVo:setData(msgVo)
    eventDic[eventVo:getEventId()] = eventVo
    return eventVo
end

-- 删除服务器对应事件数据
function delEventVo(self, isFinishType, eventId)
    local eventDic = self:getEventDic(isFinishType)
    local eventVo = eventDic[eventId]
    if(eventVo)then
        LuaPoolMgr:poolRecover(eventVo)
    end
    eventDic[eventId] = nil
end

-- 获取服务器对应事件数据
function getEventVo(self, isFinishType, eventId)
    local eventDic = self:getEventDic(isFinishType)
    return eventDic[eventId]
end

-- 获取服务器对应事件数据
function getEventDic(self, isFinishType)
    local dic = nil
    if(isFinishType)then
        if(not self.mFinishEventDic)then
            self.mFinishEventDic = {}
        end
        dic = self.mFinishEventDic
    else
        if(not self.mCurEventDic)then
            self.mCurEventDic = {}
        end
        dic = self.mCurEventDic
    end
    return dic
end

-- 获取返回地图后待效果表现的数据
function getWaitEventEffectList(self)
    return self.mWaitEventEffectList
end

-- 清理返回地图后待效果表现的数据
function recoveryWaitEventEffectList(self)
    if(self.mWaitEventEffectList)then
        for _, waitEffectVo in pairs(self.mWaitEventEffectList) do
            LuaPoolMgr:poolRecover(waitEffectVo)
        end
    end
    self.mWaitEventEffectList = {}
end

function addIntroduceId(self, introduceId)
    if(not self:isIntroduceIdFinish(introduceId))then
        table.insert(self.mFinishIntroduceEventIdList, introduceId)
    end
end

-- 初次介绍id是否已完成
function isIntroduceIdFinish(self, introduceId)
    if(not self.mFinishIntroduceEventIdList)then
        self.mFinishIntroduceEventIdList = {}
        return false
    end
    return table.indexof(self.mFinishIntroduceEventIdList, introduceId) ~= false
end

-- 新增物资列表
function addGoods(self, mapId, goodsId)
    if(goodsId > 0)then
        if(not self.mBuffIdListDic)then
            self.mBuffIdListDic = {}
        end
        if(not self.mBuffIdListDic[mapId])then
            self.mBuffIdListDic[mapId] = {}
        end
        if(table.indexof(self.mBuffIdListDic[mapId], goodsId) == false)then
            table.insert(self.mBuffIdListDic[mapId], goodsId)
        end
    end
end

-- 获取物资列表
function getGoodsList(self, mapId)
    if(self.mBuffIdListDic)then
        return self.mBuffIdListDic[mapId]
    end
    return {}
end

-- 获取战员vo列表
function getMainExploreHeroVoList(self, mapId)
    if(self.mHeroListDic)then
        return self.mHeroListDic[mapId] or {}
    end
end

-- 获取战员列表
function getMainExploreHeroList(self, mapId, sourceType, isNeedHeroId)
    local list = {}
    local tempList = self:getMainExploreHeroVoList(mapId)
    if(tempList)then
        for i = 1, #tempList do
            local mazeHeroVo = tempList[i]
            if(sourceType == nil or mazeHeroVo.sourceType == sourceType)then
                table.insert(list, isNeedHeroId and mazeHeroVo.heroId or mazeHeroVo)
            end
        end
        return list
    end
    return list
end

-- 获取迷宫战员
function getMainExploreHero(self, mapId, heroId, sourceType)
    local heroList = self:getMainExploreHeroList(mapId, sourceType, false)
    if(heroList)then
        for i = 1, #heroList do
            local mainExploreHeroVo = heroList[i]
            if(mainExploreHeroVo.heroId == heroId)then
                return mainExploreHeroVo
            end
        end
    end
    local mazeHeroVo = maze.MazeHeroVo.new()
    mazeHeroVo.heroId = heroId
    mazeHeroVo.sourceType = sourceType
    mazeHeroVo.nowHp = 100
    return mazeHeroVo
end

-- 是否事件已激活触发能力
function getEventTriggerEnable(self, eventId)
    local mapId = mainExplore.MainExploreManager:getTriggerDupData().mapId
    local eventConfigVo = mainExplore.MainExploreSceneManager:getEventConfigVo(mapId, eventId)
    for i = 1, #eventConfigVo.frontEventIdList do
        if(not self:getEventVo(true, eventConfigVo.frontEventIdList[i]))then
            return false
        end
    end
    return true
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 设置当前进入的地图配置
function setTriggerDupData(self, dupMapConfigVo)
    self.mMapConfigVo = dupMapConfigVo
end

-- 获取当前进入的地图配置
function getTriggerDupData(self)
    return self.mMapConfigVo
end

-- 设置帧速率
function setRate(self, rate)
    rate = rate == nil and 1 or rate
    if(self.mRate ~= rate)then
        self.mRate = rate
        GameDispatcher:dispatchEvent(EventName.MAIN_EXPLORE_RATE_UPDATE)
    end
end

-- 获取速率
function getRate(self)
    return self.mRate
end

-- 获取当前副本对应的阵型数据
function getFormationHeroList(self)
    local fightTeamId = formation.FormationMainExploreManager:getFightTeamId2(formation.TYPE.MAIN_EXPLORE, self:getTriggerDupData().dupType)
    local teamHeroListDic = formation.FormationMainExploreManager:__getFormationHeroListByTeamId(fightTeamId)
    return teamHeroListDic
end

-- 设置是否正在保护期间
function setIsInProtecting(self, isInProtecting)
    self.mIsInProtecting = isInProtecting
end

-- 获取是否正在保护期间
function getIsInProtecting(self)
    return self.mIsInProtecting
end

-- 设置指引提示
function setRemindVisible(self, visible)
    self.mRemindVisible = visible
end

-- 获取指引提示
function getRemindVisible(self)
    return self.mRemindVisible == nil and true or self.mRemindVisible
end

-- 战斗结算界面用
function getDupName(self, tileId)
    return _TT(63025)
end

function resetExploreData(self)
    mainExplore.MainExploreManager:setRemindVisible(nil)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(63025):	"主线探索"
]]
