-- @FileName:   SandPlayManager.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-11-28 15:28:41
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.manager.SandPlayManager', Class.impl(Manager))

--构造
function ctor(self)
    super.ctor(self)
    self:init()
end

--析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:init()
end

--初始化
function init(self)
    self.mCurBait = nil
    self.mFishingGetAwardDic = nil
    self.mFishingFishDic = nil
    self.mFishingTaskDic = nil
    self.mCurFishingFishResult = nil

    self.mMapEventInfoDic = {}

    self.mNextMapId = nil
    self.mCurDupId = nil
    self.mPlayerThingScenePos = nil

    self.mHappyFarmEventInfoDic = nil
end

function getSceneConfigVo(self, scene_id)
    if not self.mSceneConfigVoDic then
        self.mSceneConfigVoDic = {}
        local baseData = RefMgr:getData("sandplay_scene_data")
        for key, data in pairs(baseData) do
            local baseVo = sandPlay.SandPlaySceneConfigVo.new()
            baseVo:parseCogfigData(key, data)
            self.mSceneConfigVoDic[key] = baseVo
        end
    end

    return self.mSceneConfigVoDic[scene_id]
end

function getNPCConfigVo(self, npc_id)
    if not self.mNPCConfigVoDic then
        self.mNPCConfigVoDic = {}
        local baseData = RefMgr:getData("sandplay_npc_data")
        for key, data in pairs(baseData) do
            local baseVo = sandPlay.SandPlayNPCConfigVo.new()
            baseVo:parseCogfigData(key, data)
            self.mNPCConfigVoDic[key] = baseVo
        end
    end

    return self.mNPCConfigVoDic[npc_id]
end

function getEventConfigVo(self, event_id)
    if not self.mEventConfigVoDic then
        self.mEventConfigVoDic = {}
        local baseData = RefMgr:getData("sandplay_event_data")
        for key, data in pairs(baseData) do
            local baseVo = sandPlay.SandPlayEventConfigVo.new()
            baseVo:parseCogfigData(key, data)
            self.mEventConfigVoDic[key] = baseVo
        end
    end

    return self.mEventConfigVoDic[event_id]
end

function getHeroConfigVo(self, hero_id)
    if not self.mHeroConfigVoDic then
        self.mHeroConfigVoDic = {}
        local baseData = RefMgr:getData("sandplay_hero_data")
        for key, data in pairs(baseData) do
            local baseVo = sandPlay.SandPlayHeroConfigVo.new()
            baseVo:parseCogfigData(key, data)
            self.mHeroConfigVoDic[key] = baseVo
        end
    end

    return self.mHeroConfigVoDic[hero_id]
end

function getHeroSkillConfigVo(self, skill_id)
    if not self.mHeroSkillConfigVoDic then
        self.mHeroSkillConfigVoDic = {}
        local baseData = RefMgr:getData("sandplay_hero_skill_data")
        for key, data in pairs(baseData) do
            local baseVo = sandPlay.SandPlayHeroSkillConfigVo.new()
            baseVo:parseCogfigData(key, data)
            self.mHeroSkillConfigVoDic[key] = baseVo
        end
    end

    return self.mHeroSkillConfigVoDic[skill_id]
end

function getStageConfigVo(self, stage_id)
    if not self.mStageConfigDic then
        self.mStageConfigDic = {}

        local baseData = RefMgr:getData("sandplay_stage_data")

        for key, data in pairs(baseData) do
            local baseVo = sandPlay.SandPlayStageConfigVo.new()
            baseVo:parseCogfigData(key, data)
            self.mStageConfigDic[key] = baseVo
        end
    end

    return self.mStageConfigDic[stage_id]
end

-----------------------------------------数据缓存-----------------------------------------
--设置重新进来打开哪个界面
function setLinkCode(self, link_code)
    self.m_linkCode = link_code
end

function getLinkCode(self)
    return self.m_linkCode
end

--当前所在哪个副本
function setMapId(self, dupId)
    self.mCurDupId = dupId
end

function getMapId(self)
    return self.mCurDupId
end

--设置传送地图id
function setNextMapId(self, map_id)
    self.mNextMapId = map_id
end

function getNextMapId(self)
    return self.mNextMapId
end

--当前玩家的出生点
function setPlayerThingScenePos(self, pos)
    self.mPlayerThingScenePos = pos
end

function getPlayerThingScenePos(self, pos)
    return self.mPlayerThingScenePos
end

function initMapEventInfo(self, map_list)
    self.mMapEventInfoDic = {}
    for _, mapInfo in pairs(map_list) do
        for _, eventInfo in pairs(mapInfo.npc_event_list) do
            self:refreshMapEvent(mapInfo.map_id, eventInfo.npc_id, eventInfo.event_id)
        end
    end
end

function refreshMapEvent(self, map_id, npc_id, event_id)
    local mapEventList = self.mMapEventInfoDic[map_id]
    if not mapEventList then
        mapEventList = {}
        self.mMapEventInfoDic[map_id] = mapEventList
    end

    local npcEventList = mapEventList[npc_id]
    if not npcEventList then
        npcEventList = {}
        mapEventList[npc_id] = npcEventList
    end

    npcEventList[event_id] = 1
end

--场景事件是否触发过
function getMapEventIsPass(self, map_id, npc_id, event_id)
    if self.mMapEventInfoDic then
        map_id = map_id or self:getMapId()

        if self.mMapEventInfoDic[map_id] then
            if self.mMapEventInfoDic[map_id][npc_id] then
                if self.mMapEventInfoDic[map_id][npc_id][event_id] then
                    return true
                end
            end
        end
    end

    return false
end

------------------------------------------开心农场------------------------------------------

function parseHappyFarmSeedCogfigData(self)
    self.mHappyFarmSeedConfigDic = {}

    local baseData = RefMgr:getData("happy_farm_data")
    for key, data in pairs(baseData) do
        if not self.mHappyFarmSeedConfigDic[data.type] then
            self.mHappyFarmSeedConfigDic[data.type] = {}
        end

        local baseVo = sandPlay.SandPlayHappyFarmSeedConfigVo.new()
        baseVo:parseCogfigData(key, data)

        self.mHappyFarmSeedConfigDic[data.type][key] = baseVo
    end
end

function getHappyFarmSeedConfigVoListByType(self, type)
    if not self.mHappyFarmSeedConfigDic then
        self:parseHappyFarmSeedCogfigData()
    end

    return self.mHappyFarmSeedConfigDic[type]
end

function getHappyFarmSeedConfigVo(self, seed_id)
    if not self.mHappyFarmSeedConfigDic then
        self:parseHappyFarmSeedCogfigData()
    end

    for type, seedConfigVoDic in pairs(self.mHappyFarmSeedConfigDic) do
        for seedId, seedConfigVo in pairs(seedConfigVoDic) do
            if seedConfigVo.id == seed_id then
                return seedConfigVo
            end
        end
    end
end

function parseHappyFarmTaskConfigVo(self)
    if not self.mHappyFarmTaskConfigDic then
        self.mHappyFarmTaskConfigDic = {}

        local baseData = RefMgr:getData("farm_order_data")
        for id, config in pairs(baseData) do
            local baseVo = sandPlay.SandPlayHappyFarmTaskConfigVo.new()
            baseVo:parseCogfigData(id, config)

            self.mHappyFarmTaskConfigDic[id] = baseVo
        end
    end

    return self.mHappyFarmTaskConfigDic
end

function getHappyFarmTaskConfigVoDic(self)
    if not self.mHappyFarmTaskConfigDic then
        self:parseHappyFarmTaskConfigVo()
    end

    return self.mHappyFarmTaskConfigDic
end

function getHappyFarmTaskConfigVo(self, task_id)
    if not self.mHappyFarmTaskConfigDic then
        self:parseHappyFarmTaskConfigVo()
    end

    return self.mHappyFarmTaskConfigDic[task_id]
end

function parseHappyFarmEventInfoDic(self, infoList)
    if not self.mHappyFarmEventInfoDic then
        self.mHappyFarmEventInfoDic = {}
    end

    for k, eventInfo in pairs(infoList) do
        local fieldVo = self.mHappyFarmEventInfoDic[eventInfo.field_id]
        if fieldVo == nil then
            fieldVo = sandPlay.SandPlayHappyFarmFieldVo:create(eventInfo)
        end

        fieldVo:setData(eventInfo)

        self.mHappyFarmEventInfoDic[fieldVo.field_id] = fieldVo
        GameDispatcher:dispatchEvent(EventName.SANDPLAY_HAPPYFARM_EVENT_REFRESH, fieldVo.field_id)
    end
end

function getHappyFarmEventInfoDic(self)
    return self.mHappyFarmEventInfoDic or {}
end

function getHappyFarmEventInfo(self, field_id)
    if not self.mHappyFarmEventInfoDic then
        return nil
    end

    return self.mHappyFarmEventInfoDic[field_id] or nil
end

function parseHappyFarmTaskData(self, task_list)
    self.mHappyFarmFinishTaskDic = {}
    for k, task_id in pairs(task_list) do
        self.mHappyFarmFinishTaskDic[task_id] = 1
    end
end

function isHappyFarmFinishTask(self, task_id)
    if not self.mHappyFarmFinishTaskDic then
        return false
    end

    return self.mHappyFarmFinishTaskDic[task_id] == 1
end

function getHappyFarmRedState(self)
    if self:getHappayFarmPoultryRedState() then
        return true
    end

    if self:getHappyFarmCropRedState() then
        return true
    end

    if self:getHappyFarmTaskRedState() then
        return true
    end

    return false
end

function getHappayFarmPoultryRedState(self)
    local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.HappyFarm)
    if not activityVo:getIsCanOpen() then
        return
    end

    return self:getHappyFarmFieldRedState(SandPlayConst.HappyFarm_Seed_Type.Poultry)
end

function getHappyFarmCropRedState(self)
    local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.HappyFarm)
    if not activityVo:getIsCanOpen() then
        return
    end

    return self:getHappyFarmFieldRedState(SandPlayConst.HappyFarm_Seed_Type.Crop)
end

function getHappyFarmFieldRedState(self, type, subType)
    local fieldDic = self:getHappyFarmEventInfoDic()

    local fieldList = {}
    for _, fieldVo in pairs(fieldDic) do
        if fieldVo.configVo and fieldVo.configVo.type == type then
            if subType then
                if fieldVo.configVo.subtype == subType then
                    table.insert(fieldList, fieldVo)
                end
            else
                table.insert(fieldList, fieldVo)
            end
        end
    end

    for _, fieldVo in pairs(fieldList) do
        if fieldVo.configVo.type == SandPlayConst.HappyFarm_Seed_Type.Poultry then
            if fieldVo.configVo.subtype == SandPlayConst.HappyFarm_Poultry_Type.Chicken then
                if fieldVo:getStage() == 2 then
                    return true
                end
            elseif fieldVo.configVo.subtype == SandPlayConst.HappyFarm_Poultry_Type.Sheep then
                if fieldVo:getStage() == 3 then
                    return true
                end
            end
        elseif fieldVo.configVo.type == SandPlayConst.HappyFarm_Seed_Type.Crop then
            if fieldVo:getStage() == SandPlayConst.HappyFarm_FieldState.grow_up4 then
                return true
            end
        end
    end

    return false
end

function getHappyFarmTaskRedState(self)
    local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.HappyFarm)
    if not activityVo:getIsCanOpen() then
        return
    end

    local taskConfigVoDic = self:getHappyFarmTaskConfigVoDic()

    for task_id, taskConfigVo in pairs(taskConfigVoDic) do
        if self:getHappyFarmTaskRedStateById(taskConfigVo) then
            return true
        end
    end

    return false
end

function getHappyFarmTaskRedStateById(self, taskConfigVo)
    if sandPlay.SandPlayManager:isHappyFarmFinishTask(taskConfigVo.id) then
        return false
    end

    for _, cost in pairs(taskConfigVo.cost) do
        local costTid, costCount = cost[1], cost[2]
        if bag.BagManager:getPropsCountByTid(costTid, bag.BagType.HappyFarm) < costCount then
            return false
        end
    end

    return true
end

------------------------------------------钓鱼------------------------------------------
function parseFishTaskCogfigData(self)
    self.mFishTaskConfigVoDic = {}
    local baseData = RefMgr:getData("fishing_task_data")
    for key, data in pairs(baseData) do
        local baseVo = sandPlay.SandPlayFishTaskConfigVo.new()
        baseVo:parseCogfigData(key, data)
        self.mFishTaskConfigVoDic[key] = baseVo
    end
end

function getFishTaskConfigVoDic(self)
    if not self.mFishTaskConfigVoDic then
        self:parseFishTaskCogfigData()
    end

    return self.mFishTaskConfigVoDic
end

function parseFishRewardCogfigData(self)
    self.mFishRewardConfigVoDic = {}
    local baseData = RefMgr:getData("fishing_reward_data")
    for key, data in pairs(baseData) do
        local baseVo = sandPlay.SandPlayFishRewardConfigVo.new()
        baseVo:parseCogfigData(key, data)
        self.mFishRewardConfigVoDic[key] = baseVo
    end
end

function getFishRewardConfigVoDic(self)
    if not self.mFishRewardConfigVoDic then
        self:parseFishRewardCogfigData()
    end

    return self.mFishRewardConfigVoDic
end

function parseBaitCogfigData(self)
    self.mBaitConfigVoDic = {}
    local baseData = RefMgr:getData("bait_data")
    for key, data in pairs(baseData) do
        local baseVo = sandPlay.SandPlayFishBaitConfigVo.new()
        baseVo:parseCogfigData(key, data)
        self.mBaitConfigVoDic[key] = baseVo
    end
end

function getBaitConfigVo(self, bait_id)
    if not self.mBaitConfigVoDic then
        self:parseBaitCogfigData()
    end

    return self.mBaitConfigVoDic[bait_id]
end

function getBaitConfigVoDic(self)
    if not self.mBaitConfigVoDic then
        self:parseBaitCogfigData()
    end

    return self.mBaitConfigVoDic
end

function parseFishCogfigData(self)
    self.mFishConfigVoDic = {}
    local baseData = RefMgr:getData("fishing_data")
    for key, data in pairs(baseData) do
        local baseVo = sandPlay.SandPlayFishConfigVo.new()
        baseVo:parseCogfigData(key, data)
        self.mFishConfigVoDic[key] = baseVo
    end
end

function getFishConfigVo(self, fish_id)
    if not self.mFishConfigVoDic then
        self:parseFishCogfigData()
    end

    return self.mFishConfigVoDic[fish_id]
end

function getFishConfigDic(self)
    if not self.mFishConfigVoDic then
        self:parseFishCogfigData()
    end

    return self.mFishConfigVoDic
end

function getFishByCurBait(self)
    local curBait = self:getFishingBait()
    if not curBait then
        return
    end

    local baitConfig = self:getBaitConfigVo(curBait)
    if baitConfig then
        local fishList = {}
        local totalWeight = 0
        local clientTime = GameManager:getClientTime()
        for fish_id, showConfig in pairs(baitConfig.fishlist) do
            local weight = showConfig.weight

            local fishConfigVo = self:getFishConfigVo(fish_id)
            if fishConfigVo then
                local showStartDt, showEndDt = fishConfigVo:getShowDt()
                if showStartDt == 0 and showEndDt == 0 then
                    weight = weight + showConfig.haunt_weight
                else
                    if clientTime >= showStartDt and clientTime <= showEndDt then
                        weight = weight + showConfig.haunt_weight
                    end
                end
            end

            totalWeight = totalWeight + weight

            table.insert(fishList, {id = fish_id, weight = weight})
        end

        local fish_id = 0
        local random = math.random(1, totalWeight)
        for i = 1, #fishList do
            if random <= fishList[i].weight then
                fish_id = fishList[i].id
                break
            else
                random = random - fishList[i].weight
            end
        end

        local showConfig = baitConfig.fishlist[fish_id]
        if not showConfig then
            return nil
        end

        local minSize, maxSize = showConfig.length_interval[1], showConfig.length_interval[2]
        local size = math.random(minSize, maxSize)

        local speed = 10
        local fishConfigVo = self:getFishConfigVo(fish_id)
        for j = 1, #fishConfigVo.buoy_move_speed do
            local _range = fishConfigVo.buoy_move_speed[j][1]
            if size >= _range[1] and size <= _range[2] then
                speed = fishConfigVo.buoy_move_speed[j][2] * 0.01
                break
            end
        end
        return {fish_id = fish_id, size = size, bait_id = curBait, buoy_move_speed = speed}
    end
end

function parseFishingInitData(self, msg)
    self.mFishingGetAwardDic = {}
    for _, award_id in pairs(msg.collect_list) do
        self.mFishingGetAwardDic[award_id] = 1
    end

    self.mFishingFishDic = {}
    for _, fish_info in pairs(msg.unlock_list) do
        self:parseFishingFishData(fish_info)
    end

    self.mFishingTaskDic = {}
    for _, task_info in pairs(msg.task_list) do
        self:parseFishingTaskData(task_info)
    end
end

function parseFishingTaskData(self, task_info)
    self.mFishingTaskDic[task_info.id] = {id = task_info.id, count = task_info.count, state = task_info.state}
end

function parseFishingFishData(self, fish_info)
    self.mFishingFishDic[fish_info.fish_id] = {id = fish_info.fish_id, count = fish_info.amount, min_size = fish_info.min_size, max_size = fish_info.max_size}
end

function getFishingAchieveInfo(self, task_id)
    if not self.mFishingTaskDic then
        return nil
    end

    return self.mFishingTaskDic[task_id] or {id = task_id, count = 0, state = 1}
end

function getFishingFishInfo(self, fish_id)
    if not self.mFishingFishDic then
        return nil
    end
    return self.mFishingFishDic[fish_id] or {id = fish_id, count = 0, min_size = 0, max_size = 0}
end

function getFishingAwardState(self, collect_id)
    if not self.mFishingGetAwardDic then
        return nil
    end
    return self.mFishingGetAwardDic[collect_id]
end

--当前钓到的鱼的信息（服务端返回的信息）
function setCurFishingFishResult(self, fishResult)
    self.mCurFishingFishResult = fishResult
end

function getCurFishingFishResult(self)
    return self.mCurFishingFishResult
end

--当前装载的鱼饵
function setFishingBait(self, bait)
    self.mCurBait = bait

    GameDispatcher:dispatchEvent(EventName.SANDPLAY_FISHING_BAITSELECT)
end

function getFishingBait(self)
    return self.mCurBait
end

function canAutoFish(self)
    local lasteAutoFishDt = StorageUtil:getNumber1(gstor.SANDPLAY_PLAYER_FISHAUTO)

    local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.Fishing)
    if activityVo and lasteAutoFishDt < activityVo.startTime then
        return false
    end

    return true
end

function isAutoFish(self)
    if self:canAutoFish() then
        return StorageUtil:getBool1(gstor.SANDPLAY_PLAYER_FISHAUTOSTATE)
    else
        return false
    end
end

----------收集奖励是否有未领取奖励
function getFishingAwardRedState(self)
    local rewardDic = self:getFishRewardConfigVoDic()

    for id, config in pairs(rewardDic) do
        local getState = 0 --getState  2 已领取 1 未完成 0 可领取
        if self:getFishingAwardState(config.id) then
            getState = 2
        else
            for i = 1, #config.fish_list do
                local info = self:getFishingFishInfo(config.fish_list[i])
                if not info or info.count <= 0 then
                    getState = 1
                    break
                end
            end
        end

        if getState == 0 then
            return true
        end
    end
    return false
end

----------成就奖励是否有未领取奖励
function getFishingAchieveRedState(self)
    local taskDic = self:getFishTaskConfigVoDic()
    local data = {}

    for id, config in pairs(taskDic) do
        local achieveInfo = self:getFishingAchieveInfo(config.id)
        if achieveInfo and achieveInfo.state == 0 then
            return true
        end
    end

    return false
end

function getFishingRedState(self)
    if self:getFishingAwardRedState() then
        return true
    end

    if self:getFishingAchieveRedState() then
        return true
    end

    return false
end

function getFishingGuideRedState(self)
    if self:getFishingActivityOpenRedState() then
        return true
    end

    if self:getFishingAwardRedState() then
        return true
    end

    if self:getFishingAchieveRedState() then
        return true
    end

    return false
end

function getFishingActivityOpenRedState(self)
    local lasetClickRedDt = StorageUtil:getNumber1(gstor.SANDPLAY_FISHING_OPENRED)
    local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.Fishing)
    if activityVo and lasetClickRedDt < activityVo.startTime then
        return true
    end

    return false
end

-------------------------------------------------------------------钓鱼end---------------------------

function getHappyFarmActivityOpenRedState(self)
    local lasetClickRedDt = StorageUtil:getNumber1(gstor.SANDPLAY_HAPPYFARM_OPENRED)
    local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.HappyFarm)
    if activityVo and activityVo:getIsCanOpen() and lasetClickRedDt < activityVo.startTime then
        return true
    end

    return false
end

-- 获取副本章节名和副本名
function getDupName(self, cusId)
    local stageConfigVo = self:getStageConfigVo(cusId)
    if stageConfigVo then
        return _TT(stageConfigVo.name)
    end
end

return _M
