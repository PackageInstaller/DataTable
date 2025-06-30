module("doundless.DoundlessManager", Class.impl(Manager))

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:__initData()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__initData()
end

function __initData(self)
    self.mViewList = {}
end

-- 析构函数
function dtor(self)
end

-- function getDoundlessEndTime(self)
--     local year = os.date("%Y")
--     local month = os.date("%m")
--     local day = os.date("%d")
--     local weekday = os.date("%w")
--     local currentHour = os.date("%H")
--     local hour = 5
--     local min = 0
--     local sec = 0

--     if tonumber(weekday) ~= 1 then --等于1表示周一 无需运算
--         day = day + ((7 - weekday) + 1) % 7
--     elseif tonumber( currentHour) >= hour then --如果大于5小时则变成下一周
--         day = day + 7
--     end

--     local timestamp = os.time({
--         year = year,
--         month = month,
--         day = day,
--         hour = hour,
--         min = min,
--         sec = sec
--     })
--     return timestamp
-- end

function updateRed(self,msg)
    self.isFlag = msg.is_red == 1
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_ADVENTURE,self.isFlag, funcopen.FuncOpenConst.FUNC_ID_BOUNDLESS)
end

function getRedFlag(self)
    return self.isFlag == nil and false or self.isFlag
end

function onDoundlessSettleInfo(self, msg)
    self.mBattleRound = msg.battle_round
    self.mHeroDieNum = msg.hero_die_num
    self.mFinalPoint = msg.final_point
    self.mFinishTargetList = msg.finish_target_list
end

function getDoundlessSettleInfoRound(self)
    return self.mBattleRound
end

function getDoundlessSettleInfoDie(self)
    return self.mHeroDieNum
end

function getDoundlessSettleInfoPoint(self)
    return self.mFinalPoint
end

function getDoundlessSettleInfoTarget(self)
    return self.mFinishTargetList
end

function setCanOpenView(self,type)
    self.canOpenType = type
end

function onUpdateDoundlessInfo(self,msg)
    self.mRank = msg.rank
    self.mPoint = msg.point
    self.mSettleState = msg.settle_state
    self.mDoundlessCityHistoryList = msg.boundless_city_history_list
    self.mDoundlessCityPlayerList = msg.boundless_city_player_list

    table.sort(self.mDoundlessCityPlayerList, function(vo1, vo2)
        return vo1.rank < vo2.rank
    end)

    GameDispatcher:dispatchEvent(EventName.UPDATE_DOUNDLESS_PANEL)
    if self.canOpenType == doundless.CanOpenType.Award then
        GameDispatcher:dispatchEvent(EventName.OPEN_DOUNDLESS_REWARD_PANEL)
    elseif self.canOpenType == doundless.CanOpenType.Rank then
        GameDispatcher:dispatchEvent(EventName.OPEN_DOUNDLESS_RANK_PANEL)
    end
end

function onDoundlessInfo(self, msg)
    self.mCityId = msg.city_id
    self.mWarId = msg.war_id
    self.mRoundId = msg.round_id

    self.mMaxDup = msg.max_dup
    self.mCanOpen = msg.can_open

    

    self.mDisturbanceId= msg.disturbance_id
    self.mRoundSkillId = msg.round_skill_id

    self.mRank = msg.rank
    self.mPoint = msg.point
    self.mSettleState = msg.settle_state
    self.mDoundlessCityHistoryList = msg.boundless_city_history_list
    self.mDoundlessCityPlayerList = msg.boundless_city_player_list

    self.mDupList = msg.dup_list
    table.sort(self.mDoundlessCityPlayerList, function(vo1, vo2)
        return vo1.rank < vo2.rank
    end)

    if self.mCanOpen == 1 then
        GameDispatcher:dispatchEvent(EventName.OPEN_DOUNDLESS_PANEL)
    else
        gs.Message.Show(_TT(97062))
    end
end

function getDistubanceId(self)
    return self.mDisturbanceId
end

function getDupList(self)
    return self.mDupList
end

function getDupLayer(self, dupId)
    local list =self.mDupList -- self:getDoundlessRoundData(self.mRoundId, self.mWarId, self.mCityId).mDupList
    local layer = 0
    for i = 1, #list do
        if list[i] <= dupId then
            layer = layer + 1
        end
    end
    return layer
end

function getCanOpenDupId(self)
    local maxDup = 0
    local list =self.mDupList -- self:getDoundlessRoundData(self.mRoundId, self.mWarId, self.mCityId).mDupList
    if self.mMaxDup == 0 then
        maxDup = list[1]
    else
        for i = 1, #list do
            if self.mMaxDup == list[i] then
                if list[i+1] == nil then
                    maxDup  = list[i]
                else
                    maxDup = list[i+1]
                end
              
            end
        end
        --maxDup = self.mMaxDup + 1
    end
    return maxDup
end

function getServerSettleState(self)
    return self.mSettleState
end

function getServerRank(self)
    return self.mRank
end

function getServerPoint(self)
    return self.mPoint
end

function getServerScoreByStageId(self, dupId)
    local score = 0
    for k, v in pairs(self.mDoundlessCityHistoryList) do
        if v.dup_id == dupId then
            score = v.point
        end
    end
    return score
end

function getMyPlayerInfo(self)
    for k, v in pairs(self.mDoundlessCityPlayerList) do
        if v.player_id == role.RoleManager:getRoleVo().playerId then
            return v
        end
    end
    return nil
end

function getMaxDupPlayerList(self,dupId)
    local list = {}
    for k, v in pairs(self.mDoundlessCityPlayerList) do
        if v.dup_id == dupId then
            table.insert(list, v)
        end
    end
    return list
end


function getPlayerScoreList(self, dupId)
    local list = {}
    for k, v in pairs(self.mDoundlessCityPlayerList) do
        if v.dup_id >= dupId then
            local s = 0
            for i, kv in pairs(v.history_point) do
                if kv.dup_id == dupId then
                    s = kv.point
                end
            end
            v.curPoint = s
            table.insert(list, v)
        end
    end
    -- table.sort(list,function (vo1,vo2)
    --     return vo1.
    -- end)
    return list
end

function getServerPlayerInfo(self)
    return self.mDoundlessCityPlayerList
end

function getServerMyScoreAll(self)
    local allScore = 0
    for k, v in pairs(self.mDoundlessCityHistoryList) do
        allScore = allScore + v.point
    end
    return allScore
end

function getServerMaxDup(self)
    return self.mMaxDup
end

function getServerCityId(self)
    return self.mCityId
end

function getServeRoundId(self)
    return self.mRoundId
end

function getServerWayId(self)
    return self.mWarId
end

function parseDoundlessCityData(self)
    self.mDoundlessData = {}
    local baseData = RefMgr:getData("boundless_city_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(doundless.DoundlessCityVo)
        vo:parseData(id, data)
        self.mDoundlessData[id] = vo
    end
end

function getDoundlessCityData(self)
    if self.mDoundlessData == nil then
        self:parseDoundlessCityData()
    end
    return self.mDoundlessData
end

function getDoundlessCityDataByWar(self, way)
    if self.mDoundlessData == nil then
        self:parseDoundlessCityData()
    end
    return self.mDoundlessData[way]
end

function parseDoundlessRoundData(self)
    self.mDoundlessRoundData = {}
    local baseData = RefMgr:getData("boundless_city_round_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(doundless.DoundlessRoundDataVo)
        vo:parseData(id, data)
        self.mDoundlessRoundData[id] = vo
    end
end

function getDoundlessRoundData(self, roundId, warId, cityId)
    if self.mDoundlessRoundData == nil then
        self:parseDoundlessRoundData()
    end
    for id, vo in ipairs(self.mDoundlessRoundData) do
        if vo.mRoundId == roundId and vo.mWarId == warId and vo.mCityId == cityId then
            return vo
        end
    end
    return nil
end

function parseDoundlessCityStageData(self)
    self.mDoundlessStageData = {}
    local baseData = RefMgr:getData("boundless_city_stage_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(doundless.DoundlessCityStageVo)
        vo:parseData(id, data)
        self.mDoundlessStageData[id] = vo
    end
end

function getDoundlessCityStageData(self)
    if self.mDoundlessStageData == nil then
        self:parseDoundlessCityStageData()
    end
    return self.mDoundlessStageData
end

function getDoundlessCityStageDataByWarAndCity(self, warId, cityId)
    if self.mDoundlessStageData == nil then
        self:parseDoundlessCityStageData()
    end
    local list = {}
    for id, vo in pairs(self.mDoundlessStageData) do
        if vo.warId == warId and vo.cityId == cityId then
            table.insert(list, vo)
        end
    end
    table.sort(list, function(vo1, vo2)
        return vo1.sort > vo2.sort
    end)
    return list
end

function getDoundlessCityStageDataById(self, id)
    if self.mDoundlessStageData == nil then
        self:parseDoundlessCityStageData()
    end
    return self.mDoundlessStageData[id]
end

function getExtraHeros(self, cusId)
    local stageVo = self:getDoundlessCityStageDataById(cusId)
    return stageVo.extraHeros
end

-- 获取副本章节名和副本名
function getDupName(self, cusId)
    local stageVo = self:getDoundlessCityStageDataById(cusId)
    return "", stageVo:getName()
end

function getRecommandFight(self, cusId)
    return 0
end

function parseDoundlessCityTargetData(self)
    self.mDoundlessTargetData = {}
    local baseData = RefMgr:getData("boundless_city_target_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(doundless.DoundlessCityTargetVo)
        vo:parseData(id, data)
        self.mDoundlessTargetData[id] = vo
    end
end

function getDoundlessCityTargetData(self, id)
    if self.mDoundlessTargetData == nil then
        self:parseDoundlessCityTargetData()
    end
    return self.mDoundlessTargetData[id]
end

function parseDoundlessDisturbanceData(self)
    self.mDoundlessDisturbanceData = {}
    local baseData = RefMgr:getData("boundless_city_disturbance_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(doundless.DoundlessDisturbanceVo)
        vo:parseData(id, data)
        self.mDoundlessDisturbanceData[id] = data
    end
end

function getDoundlessDisturbanceData(self, id)
    if self.mDoundlessDisturbanceData == nil then
        self:parseDoundlessDisturbanceData()
    end
    return self.mDoundlessDisturbanceData[id]
end

return _M
