module("arenaEntrance.ArenaEntranceManager", Class.impl(Manager))
------------------------------------------------------------
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
    self.mRemainFreeTimes = 0

    -- vs显示的回合数
    self.roundTime = 1

    self.IsSelfAttack = true

    -- 当前选中需要重新唤起的敌人信息
    self.selectEnemyData = nil

    self.mRefeshTime = 0

    self.mViewList = {}

    -- 是否发起跳过战斗
    self.isSkipFighting = false

    --锁定防守阵型属性0-关(同步),1-开（不同步）
    self.lockDefState = 0
end

-- 析构函数
function dtor(self)
end

--请求战斗失败
function battleFailHandler(self, msg)

end

function setLastClickRefresh(self, times)
    self.lastClickTime = times
end

function getLstClickRefresh(self)
    return self.lastClickTime == nil and 0 or self.lastClickTime
end

-- 初始机器人配置表
function parseRobotData(self)
    self.m_robotDict = {}
    local baseData = RefMgr:getData("competition_robot_data")
    for refID, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(arenaEntrance.ArenaHellRobotDataRo)
        ro:parseData(refID, data)
        self.m_robotDict[refID] = ro
    end

end

function getRobotData(self, refID)
    if self.m_robotDict == nil then
        self:parseRobotData()
    end
    return self.m_robotDict[tonumber(refID)]
end


function parseArenaHellInfo(self, msg)
    self.season = msg.season
    self.seasonEndTime = msg.season_end_time
    self.isReset = msg.is_reset

    if self.isReset == 1 then
        arenaEntrance.ArenaEntranceManager.selectEnemyData = nil
        GameDispatcher:dispatchEvent(EventName.CLOSE_ARENA_HELL_ALL_PANEL)
    end
    -- if self.isReset == 0 then
    GameDispatcher:dispatchEvent(EventName.UPDATE_ARENA_HELL_INFO)
    --     GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_HELL_PANEL)
    -- end
    self:updateRed()
end

function getSeasonEndTime(self)
    return self.seasonEndTime
end

function getIsReset(self)
    return self.isReset
end

function paseArenaHellPanelInfo(self, msg)
    self.mSeasonRank = msg.my_season_rank
    self.mScore = msg.my_score
    self.mSegment = msg.my_segment
    self.mWinCount = msg.win_count
    self.mRemainFreeTimes = msg.remain_free_times
    self.mEnemyList = msg.enemy_list
    self.mRefeshTime = msg.refresh_time
    self.mBuyTimes = msg.buy_times
    self.mBoughtTimes = msg.bought_times
    self.lockDefState = msg.sync_def_formation_state
    self.warId = msg.war_id
    GameDispatcher:dispatchEvent(EventName.UPDATE_ARENAHELL_PANELINFO)
    self:updateRed()
end


function getArenaWarTxt(self)
    local text = _TT(104025)
    if self.warId == 2 then
        text = _TT(104025)
    elseif self.warId == 3 then
        text = _TT(104026)
    elseif self.warId == 4 then
        text = _TT(104027)
    end
    return text
end
-- 更新红点
function updateRed(self)
    -- 有免费次数，每日首次提示
    local isNotRemind = remind.RemindManager:isTodayNotRemain(RemindConst.ARENA_HELL_REDPOINT_TIPS)
    if not isNotRemind and self.mRemainFreeTimes > 0 and self:getIsReset() ~= 1 then
        mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_PVP, true, funcopen.FuncOpenConst.FUNC_ID_PVP_ARENA_HELL)
    else
        mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_PVP, false, funcopen.FuncOpenConst.FUNC_ID_PVP_ARENA_HELL)
    end
end

--获取已购买次数
function getBoughtTimes(self)
    return self.mBoughtTimes
end

--获取可购买次数
function getBuyTimes(self)
    return self.mBuyTimes == nil and 0 or self.mBuyTimes
end

--免费剩余次数
function getRemainFreeTimes(self)
    return self.mRemainFreeTimes
end

function getRefeshTime(self)
    return self.mRefeshTime
end

--获取排名
function getMySeasonRank(self)
    return self.mSeasonRank == nil and 777 or self.mSeasonRank
end

--获取分数
function getMyScore(self)
    return self.mScore == nil and 777 or self.mScore
end

--段位
function getMySegment(self)
    return self.mSegment == nil and 777 or self.mSegment
end
--胜场
function getMyWinCount(self)
    return self.mWinCount == nil and 777 or self.mWinCount
end
--剩余免费刷新次数
function getMyRemainTimes(self)
    return self.mRemainFreeTimes == nil and 777 or self.mRemainFreeTimes
end
--刷新时间
function getMyRefreshTime(self)
    return self.mRefeshTime == nil and 777 or self.mRefeshTime
end

--获取对手
function getEnemyList(self)
    return self.mEnemyList
end


function paseArenaHellTopPlayer(self, msg)
    self.mTopEnemyList = msg.top_enemy_list

    GameDispatcher:dispatchEvent(EventName.UPDATE_ARENA_HELL_RANK_PANEL)
end

function getArenaHellTopPlayer(self)
    return self.mTopEnemyList
end

function paseArenaHellPlayerRefesh(self, msg)
    self.mEnemyList = msg.enemy_list
    self.mRefeshTime = msg.refresh_time
    arenaEntrance.ArenaEntranceManager.selectEnemyData = nil
    GameDispatcher:dispatchEvent(EventName.UPDATE_ARENAHELL_PANELINFO)
end

function paseArenaHellLog(self, msg)
    self.logList = {}
    for i = 1, #msg.log_list do
        local vo = arenaEntrance.ArenaHellLogVo.new()
        vo:parseMsgData(msg.log_list[i])
        table.insert(self.logList, vo)
    end

    --self.mArenaLogList = msg.log_list
    GameDispatcher:dispatchEvent(EventName.UPDATE_ARENA_HELL_LOG)
end

function getArenaLogList(self)
    return self.logList
end

function updateReset(self, msg)
    self.isReset = msg.is_reset
    if self.isReset == 1 then
        arenaEntrance.ArenaEntranceManager.selectEnemyData = nil
        GameDispatcher:dispatchEvent(EventName.CLOSE_ARENA_HELL_ALL_PANEL)
    end
    self:updateRed()
end

function updateReplayInfo(self, msg)
    self.statistic = msg.statistic
    GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_HELL_RESULT_DATA_PANEL)
    --TODO
end

function getArenaHellResultData(self, index)
    for i = 1, #self.statistic do
        if self.statistic[i].team_id == index then
            return self.statistic[i]
        end
    end
    return nil
end


function parseArenaRewardData(self)
    self.mRankAwardList = {}
    local baseData = RefMgr:getData("competition_reward_data")
    for type, data in pairs(baseData[3].reward_region) do
        local ro = LuaPoolMgr:poolGet(arenaEntrance.ArenaHellRankRewardDataVo)
        ro:parseData(data)
        table.insert(self.mRankAwardList, ro)
    end
end

function getSegmentAwardList(self, style)
    local list = {}
    -- if not self.mAwardList then
    --     self:parseConfigData()
    -- end
    -- for i, v in pairs(self.mAwardList) do
    --     table.insert(list, v)
    -- end
    if not self.mRankAwardList then
        self:parseArenaRewardData()
    end

    table.sort(list, function(vo1, vo2) return vo1.needScore > vo2.needScore end)
    if style == arenaEntrance.ArenaEntaceAwadType.SEASON_AWARD or style == arenaEntrance.ArenaEntaceAwadType.WEEK_AWARD then
        table.sort(self.mRankAwardList, function(vo1, vo2) return vo1.leftRank < vo2.leftRank end)
        return self.mRankAwardList
    end
    return list
end

function getRankAwardList(self, rank)
    if not self.mRankAwardList then
        self:parseArenaRewardData()
    end
    if rank <= 0 then
        return {}
    end
    for i = 1, #self.mRankAwardList do
        if self.mRankAwardList[i].leftRank <= rank and rank <= self.mRankAwardList[i].rightRank then
            return self.mRankAwardList[i]:getAwardlist()
        end
    end
    return {}
end

function getWeekAwardList(self, rank)
    if not self.mRankAwardList then
        self:parseArenaRewardData()
    end
    if rank <= 0 then
        return {}
    end
    for i = 1, #self.mRankAwardList do
        if self.mRankAwardList[i].leftRank <= rank and rank <= self.mRankAwardList[i].rightRank then
            return self.mRankAwardList[i]:getWeekAwardlist()
        end
    end
    return {}
end

function setLastClickPlayerData(self, data)
    self.lastPlayerInfo = data
end

function getLastClickEnemyInfo(self)
    return self.lastPlayerInfo
    -- for i = 1 ,#self.mEnemyList do
    --     if self.mEnemyList[i].player_id == self.lastPlayerId then
    --         return self.mEnemyList[i]
    --     end
    -- end
    -- return nil
end

return _M