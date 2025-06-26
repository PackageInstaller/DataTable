-- @FileName:   FieldExplorationManager.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.manager.FieldExplorationManager', Class.impl(Manager))

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
    self.mDupRecordList = {}
    self.mStarAwardStateList = {}
end

function parseConfigData(self)
    self.mSceneConfigVoDic = {}
    local baseData = RefMgr:getData("parkour_scene_data")
    for key, data in pairs(baseData) do
        local baseVo = fieldExploration.FieldExplorationSceneConfigVo.new()
        baseVo:parseCogfigData(key, data)
        self.mSceneConfigVoDic[key] = baseVo
    end

    self.mEventConfigDic = {}
    local baseData = RefMgr:getData("parkour_event_data")
    for key, data in pairs(baseData) do
        local eventConfigVo = fieldExploration.FieldExplorationEventConfigVo.new()
        eventConfigVo:parseCogfigData(key, data)

        self.mEventConfigDic[key] = eventConfigVo
    end

    self.mEventSkillConfigDic = {}
    local baseData = RefMgr:getData("parkour_event_skill_data")
    for key, data in pairs(baseData) do
        local eventSkillConfigVo = fieldExploration.FieldExplorationEventSkillConfigVo.new()
        eventSkillConfigVo:parseCogfigData(key, data)

        self.mEventSkillConfigDic[key] = eventSkillConfigVo
    end

    self.mHeroConfigDic = {}
    local baseData = RefMgr:getData("parkour_hero_data")
    for key, data in pairs(baseData) do
        local heroConfigVo = fieldExploration.FieldExplorationHeroConfigVo.new()
        heroConfigVo:parseCogfigData(key, data)

        self.mHeroConfigDic[key] = heroConfigVo
    end

    self.mHeroSkillConfigDic = {}
    local baseData = RefMgr:getData("parkour_hero_skill_data")
    for key, data in pairs(baseData) do
        local heroSkillConfigVo = fieldExploration.FieldExplorationHeroSkillConfigVo.new()
        heroSkillConfigVo:parseCogfigData(key, data)

        self.mHeroSkillConfigDic[key] = heroSkillConfigVo
    end

    self.mBuffConfigDic = {}
    local baseData = RefMgr:getData("parkour_buff_data")
    for key, data in pairs(baseData) do
        local buffConfigVo = fieldExploration.FieldExplorationBuffConfigVo.new()
        buffConfigVo:parseCogfigData(key, data)

        self.mBuffConfigDic[key] = buffConfigVo
    end

    self.mMapConfigDic = {}
    local baseData = RefMgr:getData("parkour_map_data")
    for activity_id, maplist in pairs(baseData) do
        if not self.mMapConfigDic[activity_id] then
            self.mMapConfigDic[activity_id] = {}
        end

        for key, data in pairs(maplist.area_data) do
            local mapConfigVo = fieldExploration.FieldExplorationMapConfigVo.new()
            mapConfigVo:parseCogfigData(activity_id, key, data)

            self.mMapConfigDic[activity_id][key] = mapConfigVo
        end
    end

    self.mDupConfigDic = {}
    local baseData = RefMgr:getData("parkour_dup_data")
    for key, data in pairs(baseData) do
        local dupConfigVo = fieldExploration.FieldExplorationDupConfigVo.new()
        dupConfigVo:parseCogfigData(key, data)

        self.mDupConfigDic[key] = dupConfigVo
    end

    self.mStarConfigDic = {}
    local baseData = RefMgr:getData("parkour_star_data")
    for key, data in pairs(baseData) do
        local starConfigVo = fieldExploration.FieldExplorationStarConfigVo.new()
        starConfigVo:parseCogfigData(key, data)

        self.mStarConfigDic[key] = starConfigVo
    end

    self.mStarAwardConfigDic = {}
    local baseData = RefMgr:getData("parkour_reward_data")
    for key, data in pairs(baseData) do
        if not self.mStarAwardConfigDic[data.activity_id] then
            self.mStarAwardConfigDic[data.activity_id] = {}
        end
        local starAwardConfigVo = fieldExploration.FieldExplorationStarAwardConfigVo.new()
        starAwardConfigVo:parseCogfigData(key, data)

        if not self.mStarAwardConfigDic[data.activity_id][starAwardConfigVo.map_id] then
            self.mStarAwardConfigDic[data.activity_id][starAwardConfigVo.map_id] = {}
        end

        table.insert(self.mStarAwardConfigDic[data.activity_id][starAwardConfigVo.map_id], starAwardConfigVo)
    end

end

--------------------------------------------配置数据
--获取星级奖励配置
function getStarAward(self, activity_id, map_id)
    activity_id = activity_id or self:getActivityId()
    if not self.mStarAwardConfigDic then
        self:parseConfigData()
    end

    if not self.mStarAwardConfigDic[activity_id] then
        return nil
    end

    return self.mStarAwardConfigDic[activity_id][map_id]
end

function getStarAwardByAwardId(self, activity_id, awardId)
    for map_id, list in pairs(self.mStarAwardConfigDic[activity_id]) do
        for _, starAwardConfigVo in pairs(list) do
            if starAwardConfigVo.id == awardId then
                return starAwardConfigVo
            end
        end
    end
end

--获取场景事件技能buff配置
function getEventSkillConfig(self, skillTid)
    if not self.mEventSkillConfigDic then
        self:parseConfigData()
    end

    return self.mEventSkillConfigDic[skillTid]
end

--获取战员技能配置
function getHeroSkillConfigVo(self, skillTid)
    if not self.mHeroSkillConfigDic then
        self:parseConfigData()
    end
    return self.mHeroSkillConfigDic[skillTid]
end
--获取副本场景配置
function getSceneConfigVo(self, id)
    if not self.mSceneConfigVoDic then
        self:parseConfigData()
    end

    return self.mSceneConfigVoDic[id]
end

--获取事件配置
function getEventConfigVo(self, eventId)
    if not self.mEventConfigDic then
        self:parseConfigData()
    end
    return self.mEventConfigDic[eventId]
end

--获取buff配置
function getBuffConfigVo(self, buffId)
    if not self.mBuffConfigDic then
        self:parseConfigData()
    end
    return self.mBuffConfigDic[buffId]
end

--获取区域地图
function getMapConfigDic(self, activity_id)
    activity_id = activity_id or self:getActivityId()
    if not self.mMapConfigDic or not self.mMapConfigDic[activity_id] then
        self:parseConfigData()
    end

    return self.mMapConfigDic[activity_id]
end

--获取区域地图
function getMapConfigVO(self, activity_id, map_id)
    activity_id = activity_id or self:getActivityId()

    if not self.mMapConfigDic or not self.mMapConfigDic[activity_id] then
        self:parseConfigData()
    end

    return self.mMapConfigDic[activity_id][map_id]
end

--获取关卡配置
function getDupConfigVO(self, dup_id)
    if not self.mDupConfigDic then
        self:parseConfigData()
    end

    return self.mDupConfigDic[dup_id]
end

--获取星星配置
function getStarConfigVO(self, star_id)
    if not self.mStarConfigDic then
        self:parseConfigData()
    end

    return self.mStarConfigDic[star_id]
end

---------------------------------------------服务器数据
--解析服务器面板数据
function parseInfoMsg(self, msg)
    if not self.mDupRecordList then
        self.mDupRecordList = {}
    end

    local point = msg.point
    self.mDupRecordList[msg.id] = point
    GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_REQ_SCORE_UPDATE)
end

--解析服务器奖励领取列表
function parseAwardMsg(self, msg)
    if not self.mStarAwardStateList then
        self.mStarAwardStateList = {}
    end

    for _, starAward_id in pairs(msg) do
        self.mStarAwardStateList[starAward_id] = 1
    end

    GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_REQGETSTARAWARD_UPDATA)
end

function setActivityId(self, activity_id)
    self.mCurOnActivityId = activity_id
end
function getActivityId(self)
    return self.mCurOnActivityId
end

--当前所在副本
function setDupId(self, dup_id)
    self.mCurOnDup_id = dup_id
end

function getDupId(self)
    return self.mCurOnDup_id
end

function getMap_id(self)
    local dup_id = self:getDupId()
    if dup_id then
        local mapDic = self:getMapConfigDic(self:getActivityId())
        for map_id, mapConfigVo in pairs(mapDic) do
            for _, dupid in pairs(mapConfigVo.stage_list) do
                if dup_id == dupid then
                    return map_id
                end
            end
        end
    end

    return 0
end

function getPlayerDupStar(self, dup_id, record)
    local star = 0
    dup_id = dup_id or self:getDupId()
    local dupConfigVo = self:getDupConfigVO(dup_id)
    if dupConfigVo then
        record = record or self:getPlayerDupRecord(dup_id)

        if dupConfigVo.settlement_type == FieldExplorationConst.Settlement_Type.Push_Box then
            for i = 1, #dupConfigVo.star_list do
                local starConfigVo = self:getStarConfigVO(dupConfigVo.star_list[i])

                if record <= starConfigVo.point and record ~= 0 then
                    star = i
                end
            end
        elseif dupConfigVo.settlement_type == FieldExplorationConst.Settlement_Type.Time_Over then
            for i = 1, #dupConfigVo.star_list do
                local starConfigVo = self:getStarConfigVO(dupConfigVo.star_list[i])

                if record >= starConfigVo.point then
                    star = i
                end
            end
        end
    end

    return star
end

function getPlayerDupRecord(self, dup_id)
    if not self.mDupRecordList then
        return 0
    end
    return self.mDupRecordList[dup_id] or 0
end

function getStarAwardState(self, starAward_id)
    if not self.mStarAwardStateList then
        return false
    end
    return self.mStarAwardStateList[starAward_id] ~= nil
end

--获取当前的战员id
function getCurHeroId(self)
    local dupConfigVo = self:getDupConfigVO(self:getDupId())
    if dupConfigVo then
        return dupConfigVo.leader_id
    end
end

function getCurHeroConfigVo(self)
    if not self.mHeroConfigDic then
        self:parseConfigData()
    end
    local hero_id = self:getCurHeroId()
    return self.mHeroConfigDic[hero_id]
end

function getDupIsOpen(self, lastDup_id, dup_id)
    local dupConfigVo = self:getDupConfigVO(dup_id)

    local isOpen = true
    if not table.empty(dupConfigVo.begin_time) then
        local openDt = os.time(dupConfigVo.begin_time)
        isOpen = GameManager:getClientTime() > openDt
    end

    if isOpen then
        if lastDup_id ~= 0 then
            local lastRecord = self:getPlayerDupRecord(lastDup_id)
            isOpen = lastRecord > 0
        end
    end

    return isOpen
end

function getMapHaveAward(self, activity_id, map_id)
    local mapConfigVo = self:getMapConfigVO(activity_id, map_id)

    local curStar = 0
    for _, dup_id in pairs(mapConfigVo.stage_list) do
        curStar = curStar + self:getPlayerDupStar(dup_id)
    end

    local isHaveAward = false
    local starAwardConfig = self:getStarAward(activity_id, map_id)
    if starAwardConfig then
        for i = 1, #starAwardConfig do
            local isGet = self:getStarAwardState(starAwardConfig[i].id)
            if curStar >= starAwardConfig[i].star_num and isGet == false then
                isHaveAward = true
                break
            end
        end
    end

    return isHaveAward
end

function getIsShowRed(self, activity_id)
    local mapConfig = self:getMapConfigDic(activity_id)
    for map_id, mapConfig in pairs(mapConfig) do
        local isFlag, redType = self:getIsMapShowRed(activity_id, map_id)
        if isFlag then
            return isFlag, redType
        end
    end

    return false, 0
end

function getIsMapShowRed(self, activity_id, map_id)
    local mapConfig_dic = self:getMapConfigDic(activity_id)
    if not mapConfig_dic then
        return false, 0
    end

    local mapConfig = mapConfig_dic[map_id]
    if not mapConfig then
        return false, 0
    end

    for i = 1, #mapConfig.stage_list do
        local dup_id = mapConfig.stage_list[i]
        local lastDup_id = 0
        if i > 1 then
            lastDup_id = mapConfig.stage_list[i - 1]
        end

        if self:getPlayerDupRecord(dup_id) == 0 and self:getDupIsOpen(lastDup_id, dup_id) and not StorageUtil:getBool1(FieldExplorationConst.DupNewOpenStr .. dup_id) then
            return true, 1
        end
    end

    if self:getMapHaveAward(activity_id, map_id) then
        return true, 2
    end

    return false, 0
end

return _M
