module("arena.ArenaManager", Class.impl(Manager))

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
    -- 我的每日排名
    self.myDailyRank = 0
    -- 我的赛季排名
    self.mySeasonRank = 0
    -- 我的分数
    self.myScore = 0
    -- 我的战力
    self.myFightNum = 0
    -- 剩余免费挑战次数
    self.remainChallengeTimes = 0
    -- 随机推荐的对手榜
    self.enemyList = {}
    -- 日志列表
    self.logList = {}
    -- 排行榜列表
    self.rankList = {}
    -- 机器人配置表
    self.m_robotDict = nil
    --我的排行榜段位
    self.mysegment = 0
    --锁定防守阵型属性0-关(同步),1-开（不同步）
    self.lockDefState = 0
    --我的上一次段位
    self.myLastSegment = 0
    --我的竞技场战斗数据
    self.myFightInfo = nil
    self:parseRobotData()
    --是否播放初始动画
    self.mIsActionAni = true
    --
    self.IsSelfAttack = true

    self.mViewList = {}
end

-- 初始机器人配置表
function parseRobotData(self)
    self.m_robotDict = {}
    local baseData = RefMgr:getData("arena_robot_data")
    for refID, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(arena.ArenaRobotDataVo)
        ro:parseData(refID, data)
        self.m_robotDict[refID] = ro
    end

end

function getRobotData(self, refID)
    return self.m_robotDict[tonumber(refID)]
end

-- 初始化奖励配置表
function parseConfigData(self)
    self.mAwardList = {}
    self.mAwardDic = {}
    local baseData = RefMgr:getData("arena_rank_data")
    for type, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(arena.ArenaRewardDataVo)
        ro:parseData(data)
        self.mAwardDic[type] = ro
        table.insert(self.mAwardList, ro)
    end
end

-- 初始化奖励配置表
function parseConfigRankAwardData(self)
    self.mRankAwardList = {}
    local baseData = RefMgr:getData("arena_reward_data")
    for type, data in pairs(baseData[4].reward_region) do
        local ro = LuaPoolMgr:poolGet(arena.ArenaRankRewardDataVo)
        ro:parseData(data)
        table.insert(self.mRankAwardList, ro)
    end
end

-- 根据奖励类型获取奖励数据
function getAwardConfigVo(self)
    if (not self.mAwardList) then
        self:parseConfigData()
    end
    return self.mAwardList
end
--获取排行奖励
function getSegmentAwardList(self, style)
    local list = {}
    if not self.mAwardList then
        self:parseConfigData()
    end
    if not self.mRankAwardList then
        self:parseConfigRankAwardData()
    end
    for i, v in pairs(self.mAwardList) do
        table.insert(list, v)
    end
    table.sort(list, function(vo1, vo2) return vo1.needScore > vo2.needScore end)
    if style == arena.ArenaAwardType.RANKAWARD then
        table.sort(self.mRankAwardList, function(vo1, vo2) return vo1.leftRank < vo2.leftRank end)
        return self.mRankAwardList
    end
    return list
end

-- 解析竞技面板数据
function parseArenaPanelInfo(self, msg)
    self.myDailyRank = msg.my_daily_rank
    self.mySeasonRank = msg.my_season_rank --我的排名
    self.zonePlayerNum = msg.zone_player_num -- 赛区总人数
    self.myScore = msg.my_score
    self.myFightNum = msg.power
    self.remainChallengeTimes = msg.remain_free_times
    self.mysegment = msg.my_segment
    self.lockDefState = msg.sync_def_formation_state
    self.warId = msg.war_id
    self:updateArenaEnemyList(msg.enemy_list)
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

function updateReset(self, msg)
    self.isReset = msg.is_reset

    self:updateRed()
end

function updateRed(self)
    -- 有免费次数，每日首次提示
    local isNotRemind = remind.RemindManager:isTodayNotRemain(RemindConst.ARENA_REDPOINT_TIPS)
    if not isNotRemind and self.remainChallengeTimes > 0 and self.isReset ~= 1 then
        mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_PVP, true, funcopen.FuncOpenConst.FUNC_ID_PVP_ARENA)
    else
        mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_PVP, false, funcopen.FuncOpenConst.FUNC_ID_PVP_ARENA)
    end
end

-- 通过排行拿奖励掉落包
function getArenaRankAwardsByRanks(self, curRank)
    if not self.mRankAwardList then
        self:parseConfigRankAwardData()
    end

    for i, rankVo in ipairs(self.mRankAwardList) do
        if curRank <= rankVo.rightRank then
            if rankVo.leftRank <= curRank then
                return rankVo
            end
        end
    end
    return {}
end

-- 通过类型拿到对应掉落包的奖励列表
function getAwardListByStyle(self, style, isAll)
    if style ~= arena.ArenaAwardType.RANKAWARD then
        if style == arena.ArenaAwardType.DAILY then
            return AwardPackManager:getAwardListById(self:getAwardList(self.mysegment).dayReward)
        else
            return AwardPackManager:getAwardListById(self:getAwardList(self.mysegment).seasonReward)
        end
    else
        return AwardPackManager:getAwardListById(self:getArenaRankAwardsByRanks(self.mySeasonRank).rewards)
    end
end
-- 通过类型与掉落包id拿到对应掉落包的奖励列表
function getAwardListToStyle(self, awardId)
    return AwardPackManager:getAwardListById(awardId)
end

-- 获得本赛季排名
function getMyRank(self)
    if self.mySeasonRank ~= nil then
        return self.mySeasonRank
    else
        logError("后端发来的  my_season_rank 为空")
        self.mySeasonRank = 0
        return self.mySeasonRank
    end
end

-- 解析竞技大厅面板数据
function parseArenaHallPanelInfo(self, msg)
    self.mArenaSeasonEndTime = msg.season_end_time
    LoopManager:removeTimer(self, self.updateReasonTick)
    LoopManager:addTimer(1, 0, self, self.updateReasonTick)
    GameDispatcher:dispatchEvent(EventName.UPDATE_ARENA_HALL_INFO, {})
end

-- 竞技场赛季结束时间
function getSeasonEndTime(self)
    return tonumber(self.mArenaSeasonEndTime)
end

function updateReasonTick(self)
    local clientTime = GameManager:getClientTime()
    local remainTime = self:getSeasonEndTime() - clientTime
    if (remainTime < 0) then
        LoopManager:removeTimer(self, self.updateReasonTick)
        GameDispatcher:dispatchEvent(EventName.REASON_UPDATE_ARENA)
    end
end

-- 更新竞技场敌人玩家数据
function updateArenaEnemyList(self, cusEnemyList)
    self.enemyList = {}
    for i = 1, #cusEnemyList do
        local vo = arena.ArenaEnemyVo.new()
        vo:parseMsgData(cusEnemyList[i])
        table.insert(self.enemyList, vo)
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_ARENA_INFO, {})
end

-- 更新竞技场日志数据
function updateArenaLogList(self, cusLogList)
    self.logList = {}
    for i = 1, #cusLogList do
        local vo = arena.ArenaLogVo.new()
        vo:parseMsgData(cusLogList[i])
        table.insert(self.logList, vo)
    end
    --GameDispatcher:dispatchEvent(EventName.UPDATE_ARENA_LOG)
end

-- 解析竞技场玩家阵容数据
function parsePlayerDefense(self, pt_arena_enemy, pt_formation_hero_info)
    local arenaEnemyVo = arena.ArenaEnemyVo.new()
    arenaEnemyVo:parseMsgData(pt_arena_enemy)

    local formationVo = LuaPoolMgr:poolGet(formation.FormationVo)
    formationVo:parseMsgData(pt_formation_hero_info)

    GameDispatcher:dispatchEvent(EventName.UPDATE_ARENA_ENEMY_DEFENSE, { arenaEnemyVo = arenaEnemyVo, formationVo = formationVo })
end

-- 解析竞技场排行榜
function parseRankList(self, list)
    self.rankList = {}
    for i = 1, #list do
        local vo = arena.ArenaEnemyVo.new()
        vo:parseMsgData(list[i])
        table.insert(self.rankList, vo)
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_ARENA_RANK, {})
end

-- 根据段位获取列表数据
function getAwardList(self, CurRank)
    if not self.mAwardDic then
        self:parseConfigData()
    end
    return self.mAwardDic[CurRank]
end

-- 根据段位获取列表
function getRankList(self)
    table.sort(self.rankList, function(vo1, vo2) return vo1.rank < vo2.rank end)
    return self.rankList
end

-- 获取副本章节名和副本名
function getDupName(self, cusId)
    return _TT(62215), ""
end

-- 获取当前副本对应的阵型数据
function getFormationHeroList(self)
    local fightTeamId = formation.FormationArenaAttackManager:getFightTeamId2(formation.TYPE.ARENA_ATTACK, formation.FormationArenaAttackManager:getFightTeamId())
    local teamHeroList = formation.FormationArenaAttackManager:__getFormationHeroListByTeamId(fightTeamId)
    return teamHeroList
end

--更新竞技场战斗数据 
function updateFightInfo(self, args)
    self.myFightInfo = args
end
--获取竞技场战斗数据
function getFightInfo(self)
    if self.myFightInfo then
        return self.myFightInfo
    end
    return nil
end

--析构函数
function dtor(self)
end
--通过积分获取某个积分的段位
function getLastSegment(self, score)
    for i = #self:getSegmentAwardList(), 1, -1 do
        if score >= self:getMaxSegmentNeedScore() then
            return i
        elseif self:getSegmentAwardList()[i].needScore > score then
            return i + 1
        end
    end
end
--通过积分获取下一个段位的积分
function getNextSegment(self, score)
    for i = #self:getSegmentAwardList(), 1, -1 do
        if self:getSegmentAwardList()[i].needScore > score then
            return self:getSegmentAwardList()[i].needScore
        end
    end
end
--通过积分获取某个积分的数据
function getLastSegmentVo(self, score)
    for i = #self:getSegmentAwardList(), 1, -1 do
        if score >= self:getMaxSegmentNeedScore() then
            return self:getSegmentAwardList()[1]
        elseif self:getSegmentAwardList()[i].needScore > score then
            return self:getSegmentAwardList()[i + 1]
        end
    end
end
--通过段位对应获取配置数据
function getSegmentVo(self, segment)
    if not self.mAwardDic then
        self:parseConfigData()
    end
    return self.mAwardDic[segment]
end
--获取最大段位积分
function getMaxSegmentNeedScore(self)
    if not self.mAwardList then
        self:parseConfigData()
    end
    return self.mAwardList[1].needScore
end

function setActionAni(self, isActionAni)
    self.mIsActionAni = isActionAni
end

function getActionAni(self)
    return self.mIsActionAni
end
return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(62215):	"竞技场"
]]