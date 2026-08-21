module("guildWar.GuildWarManager", Class.impl(Manager))

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
    self.mGuildWarViewList = {}
    self.isSkipFighting = false
end

-- 析构函数
function dtor(self)
end

function parseGuildWar()

end

function setIsFight(self,isOn)
    self.isFightSkip = isOn
end

function parseChallengeInfo(self, msg)
    local function fightCall()
        if self.isFightSkip then
            fight.FightController:reqBattleOutsideSkip(PreFightBattleType.GuildWar, self.lastPlayerId)
            GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_WAR_SKIP_FIGHT)
        else
            fight.FightManager:reqBattleEnter(PreFightBattleType.GuildWar, self.lastPlayerId)
        end
      
    end

    if msg.result == 1 then
        UIFactory:alertMessge(_TT(149133), true, function()
            fightCall()
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
    else
        fightCall()
    end
end

-- 解析公会战防守阵型定义
-- 该函数用于解析并处理公会战防守阵型的定义信息。
-- 参数:
--   self: 对象实例
--   msg: 包含玩家ID和防守阵型信息的消息对象
-- 功能:
--   1. 设置显示的玩家ID和防守阵型。
--   2. 检查防守阵型是否存在且不为空，若不存在或为空则提示玩家暂未配置防守阵型。
--   3. 根据条件分发事件，更新或打开公会战敌方玩家信息界面。
function parseGuildWarDefFormation(self, msg)
    self.showPlayId = msg.player_id
    self.defFormation = msg.def_formation

    if self.defFormation == nil or #self.defFormation == 0 then
        gs.Message.Show(_TT(149105))
        return
    end

    if self.isCanShow then
        GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_WAR_ENEMY_PLAYER_INFO, {
            playerId = self.showPlayId,
            formation = self.defFormation
        })
    else
        GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_WAR_PLAYER_INFO, {
            playerId = self.showPlayId,
            formation = self.defFormation
        })
    end
end

-- 解析公会战战斗日志
-- 该函数用于解析从服务器接收到的公会战战斗日志消息，并更新本地的日志列表和日志数量。
-- 之后通过事件分发器通知相关模块更新公会战战斗日志。
-- @param self 当前对象实例
-- @param msg 从服务器接收到的公会战战斗日志消息
function parseGuildWarBattleLog(self, msg)
    self.logList = msg.log_list
    self.logNum = msg.log_num

    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_WAR_BATTLE_LOG, {
        logList = self.logList,
        logNum = self.logNum
    })
end

-- 解析公会战公会日志
-- 该函数用于解析从服务器接收到的公会战日志信息，并更新到本地。
-- @param self 当前对象实例
-- @param msg 包含公会战日志信息的消息对象
-- @return 无返回值
function parseGuildWarGuildLog(self, msg)
    self.guildLogList = msg.log_list
    self.guildLogNum = msg.log_num
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_WAR_GUILD_LOG_PANEL, {
        logList = self.guildLogList,
        logNum = self.guildLogNum
    })
end

-- 解析公会战排名数据
-- 该函数用于解析从服务器接收到的公会战排名信息，并更新相关的成员变量。
-- 同时，它会触发一个事件来通知其他模块更新公会战排名数据。
-- @param self 当前对象实例
-- @param msg 包含公会战排名信息的消息对象
-- @return 无返回值
function parseGuildWarRankData(self, msg)
    self.guildWarRank = msg.my_rank
    self.guildWarPoint = msg.my_point
    self.guildWarName = msg.guild_name
    self.guildLeaderName = msg.leader_name
    self.guildWarRankList = msg.rank_list

    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_WAR_RANK_DATA)
end

function getGuildWarRankList(self)
    return self.guildWarRankList
end

function getGuildWarRankInfoData(self)
    return self.guildWarRank, self.guildWarPoint, self.guildWarName,self.guildLeaderName
end

function setLastClickPlayerIdAndState(self, playerId, canShow)
    self.lastPlayerId = playerId
    self.isCanShow = canShow
end

function parseEnemyPanel(self, msg)
    self.mEnemyGuildInfo = msg.guild_info

    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_WAR_ENEMY_PANEL)
end

function getGuildWarEnemyPanelInfo(self)
    return self.mEnemyGuildInfo
end

function getGuildWarEnemyAllMembers(self)
    local retList = {} 
    local members = self.mEnemyGuildInfo.members
    local robotList = self.mEnemyGuildInfo.robot_members

    for i = 1, #members, 1 do
        table.insert(retList, members[i])
    end

    for i = 1, #robotList, 1 do
        table.insert(retList, robotList[i])
    end
    return retList
end

function parseCurrentDayLog(self, msg)
    if msg.is_send_guild_war_battle_result == 0 then
        GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_WAR_CURRENT_DAY_LOG_PANEL, {
            log = msg.log,
            isTop = false
        })
    end
end

function parseGuildWarSeason(self, msg)
    self.warSeasonId = msg.guild_war_season_info.season_id -- 赛季id
    self.warNextStepStartTime = msg.guild_war_season_info.next_step_start_time -- 开始时间
    self.warState = msg.guild_war_season_info.state -- 状态
    self.warEndTime = msg.guild_war_season_info.end_time
    self.warStartTime = msg.guild_war_season_info.start_time


    --巅峰团战
    self.warTopSeasonId = msg.guild_top_war_season_info.season_id -- 最高赛季id
    self.warTopNextStepStartTime = msg.guild_top_war_season_info.next_step_start_time -- 最高开始时间
    self.warTopState = msg.guild_top_war_season_info.state -- 最高状态
    
    self.warTopBetStartTime = msg.guild_top_war_season_info.bet_start_time -- 下注开始时间
    self.warTopBetEndTime = msg.guild_top_war_season_info.bet_end_time -- 下注结束时间
   

    --self.warTopFightEndTime = msg.guild_top_war_season_info.fight_end_time -- 战斗结束时间
    
    self.warTopEndTime = msg.guild_top_war_season_info.end_time
    self.warTopStartTime = msg.guild_top_war_season_info.start_time
    
    self.warTopDay = msg.guild_top_war_season_info.day -- 巅峰天数

    self.seasonType = msg.season_type -- 赛季类型 1-公会团战,2-巅峰团战

    self.lockDefState = msg.sync_def_formation_state
    -- 状态切换时重置敌方数据
    self.mEnemyGuildInfo = nil

    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_WAR_STATE)

    cusLog("最新团战状态" .. self.warState)
end

function getGuildWarTopSeasonId(self)
    return self.warTopSeasonId 
end

function getGuildWarTopEndTime(self)
    return self.warTopEndTime
end

function getGuildWarTopNextStartTime(self)
    return self.warTopNextStepStartTime
end

function getGuildWarStartTime(self)
    return self.warTopStartTime
end

function parseGuildBetRed(self,msg)
    self.betDay = msg.day
    self.result = msg.result
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_WAR_STATE)

    local red = self:getGuildBetRed()
    red = red or self:getGuildBetAwardRedAll()
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_GUILD_WAR_TOP_BET, red)
end

function getGuildBetRed(self)
    return self.result == 1 and self.betDay == self.warTopDay
end

function getWarTopBetTime(self)
    return self.warTopBetStartTime, self.warTopBetEndTime
end

function getTopDay(self)
    return self.warTopDay
end

function getGuildWarTopNextStartTime(self)
    return self.warTopNextStepStartTime
end

-- 赛季类型 1-公会团战,2-巅峰团战
function getSeasonType(self)
    return self.seasonType
end

function getGuildWarLockState(self)
    return self.lockDefState
end

function updateGuildDefSwitch(self, lockState)
    self.lockDefState = lockState
end

function getGuildWarSeasonId(self)
    return self.warSeasonId and self.warSeasonId or 1
end

function getGuildWarNextStartTime(self)
    return self.warNextStepStartTime
end

function getGuildWarEndTime(self)
    return self.warEndTime
end

function getGuildStartTime(self)
    return self.warStartTime
end

function getGuildWarState(self)
    return self:getSeasonType() == guildWar.GuildWarType.Normal and self.warState or self.warTopState
end

function parseGuildWarBuildData(self)
    self.guildWarBuildData = {}
    local baseData = RefMgr:getData("guild_war_build_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(guildWar.GuildWarBuildVo)
        vo:parseData(id, data)
        table.insert(self.guildWarBuildData, vo)
    end

    table.sort(self.guildWarBuildData, function(vo1, vo2)
        return vo1.id < vo2.id
    end)
end

function getGuildWarDefFormationRed(self)
    local teamHeroList = formation.FormationManager:__getFormationHeroListByTeamId(22001)
     local defRed  = false
    local type = guildWar.GuildWarManager:getSeasonType()
    if type == guildWar.GuildWarType.Normal then
        defRed = self.warState == guildWar.GuildWarState.GuildWarSignUp or self.warState == guildWar.GuildWarState.GuildWarMatchAndSettle
    else 
        defRed = self.warTopState == guildWar.GuildWarState.GuildWarTopMatch
    end
    
    return (#teamHeroList == 0 or teamHeroList == nil) and defRed
end

function getGuildWarFightRed(self)
    return self:getSelfPlayChallengeTimes() > 0 and self:getGuildWarState() == guildWar.GuildWarState.GuildWarStart
end

function getGuildWarCanJunRed(self)
    local isRed = false
    for i = 1, 4 do
        isRed = isRed or self:getNeedNumberCount(i)
    end
    return isRed
end

function getNeedNumberCount(self, id)
    if self.warState ~= guildWar.GuildWarState.GuildWarSignUp or guild.GuildManager:getSelfIsGuildLeader() == false then
        return false
    end

    if self:getSeasonType() == guildWar.GuildWarType.Top then
        return false
    end

    local list = self:getBuildWardBuildDataListByRegionId(id)

    self.membersList = guild.GuildManager:getGuildAllMembers()
    local hasBuildId = {}
    for i = 1, #self.membersList, 1 do
        if self.membersList[i].build_info.build_id ~= 0 then
            table.insert(hasBuildId, self.membersList[i].build_info.build_id)
        end
    end
    local allHave = true
    for i = 1, #list do
        if table.indexof01(hasBuildId,list[i].id) > 0 then
            allHave = allHave and true
        else
            allHave = false
        end
    end
    return not allHave
end

function getGuildWarAtkFormatioNot(self)
    local teamHeroList = formation.FormationManager:__getFormationHeroListByTeamId(23001)
    return #teamHeroList == 0 or teamHeroList == nil
end

function getGuildWarBuildData(self)
    if self.guildWarBuildData == nil then
        self:parseGuildWarBuildData()
    end
    return self.guildWarBuildData
end

function getGuildWarBuildDataById(self, id)
    if self.guildWarBuildData == nil then
        self:parseGuildWarBuildData()
    end
    return self.guildWarBuildData[id]
end

function getBuildWardBuildDataListByRegionId(self, regionId)
    if self.guildWarBuildData == nil then
        self:parseGuildWarBuildData()
    end
    local list = {}
    for i = 1, #self.guildWarBuildData do
        if self.guildWarBuildData[i].regionId == regionId then
            table.insert(list, self.guildWarBuildData[i])
        end
    end

    table.sort(list, function(vo1, vo2)
        return vo1.id < vo2.id
    end)
    return list
end

function getDupName(self, cusId)
    return ""
end

function parseGuildWarRobotData(self)
    self.guildWarRobotData = {}
    local baseData = RefMgr:getData("guild_war_robot_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(guildWar.GuildWarRobotVo)
        vo:parseData(id, data)
        table.insert(self.guildWarRobotData, vo)
    end
end

function getGuildWarRobotDataByBuildId(self,buildId)
    if self.guildWarRobotData == nil then
        self:parseGuildWarRobotData()
    end

    for i = 1, #self.guildWarRobotData, 1 do
        if self.guildWarRobotData[i].buildId == buildId then
            return self.guildWarRobotData[i]
        end
    end
    return nil
end

function parseGuildWarAwardData(self)
    self.guildWarAwardData = {}
    local baseData = RefMgr:getData("guild_war_rank_award_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(guildWar.GuildWarAwardVo)
        vo:parseData(id, data)
        table.insert(self.guildWarAwardData, vo)
    end

    table.sort(self.guildWarAwardData, function(vo1, vo2)
        return vo1.id < vo2.id
    end)
end

function getGuildWarAwardData(self)
    if self.guildWarAwardData == nil then
        self:parseGuildWarAwardData()
    end
    return self.guildWarAwardData
end

function setLastShowBuildIdAndPlayerId(self, buildId, playerId,enemyFormation)
    self.lastBuildId = buildId
    self.lastPlayerId = playerId
    self.enemyFormation = enemyFormation
end

function getLastShowBuildIdAndPlayerId(self)
    return self.lastBuildId, self.lastPlayerId,self.enemyFormation
end

function getSelfPlayChallengeTimes(self)
    local roleId = role.RoleManager:getRoleVo().playerId
    local members = guild.GuildManager:getGuildInfo().members
    for i = 1, #members do
        if members[i].player_id == roleId then
            return members[i].build_info.challenge_times
        end
    end
    return 0
end

function setLookIsSelf(self,isSelf)
    self.mLookIsSelf = isSelf
end

function getLookIsSelf(self)
    return self.mLookIsSelf
end

function setIsRepRet(self,isRep)
    self.isRep = isRep
end

function getIsRep(self)
    local retIs = self.isRep
    self.isRep = false
    return retIs
end

function parseGuildWarTopInfo(self,msg)
    self.detDay = msg.day
    self.betInfo = msg.bet_info
    self.firstDayGroup = msg.first_day_group
    self.winGroup = msg.win_group
    self.loseGroup = msg.lose_group

    table.sort(self.firstDayGroup, function(a, b) return a.group_id < b.group_id end)
    table.sort(self.betInfo, function(a, b) return a.group_id < b.group_id end)
    table.sort(self.winGroup, function(a, b) return a.group_id < b.group_id end)
    table.sort(self.loseGroup, function(a, b) return a.group_id < b.group_id end)
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_WAR_TOP_INFO)
end

function getGuildWarTopSelectDay(self)
    return self.detDay
end

function getFirstDayGroup(self)
    return self.firstDayGroup
end

function getWinGroup(self)
    return self.winGroup
end

function getLoseGroup(self)
    return self.loseGroup
end

function getBetInfo(self)
    return self.betInfo
end


function parseGuildWarTopBet(self,msg)
    if self.detDay ~= msg.day then
        return
    end
    for i = 1, #self.betInfo, 1 do
        if self.betInfo[i].group_id == msg.group_id then
            self.betInfo[i].bet_uid = msg.bet_uid
        end
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_WAR_TOP_INFO)
end

function parseGuildWarTopHistoryRank(self,msg)
    self.mWarTopRank = msg.my_rank 
    self.mWarTopPoint = msg.my_point
    self.mWarTopName = msg.guild_name
    self.mWarTopRankList = msg.rank_list
    self.mWarTopLeaderName = msg.leader_name

    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_WAR_TOP_HITSTORY_RANK)
end

function getGuildWarTopRankInfoData(self)
    return self.mWarTopRank, self.mWarTopPoint, self.mWarTopName,self.mWarTopLeaderName
end 

function getGuildWarTopRankList(self)
    return self.mWarTopRankList
end


function parseGuildWarTopLog(self,msg)
    self.mWarTopLogList = msg.log_list
    self.mWarTopLogNum = msg.log_num
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_WAR_GUILD_LOG_PANEL, {
        logList = self.mWarTopLogList,
        logNum = self.mWarTopLogNum
    })
end


function parseGuildWarTopCurrentLog(self,msg)
    -- self.mWarTopCurrentLog = msg.log
    -- self.mWarTopIsSendGuildWarBattleResult = msg.is_send_guild_war_battle_result

     if msg.is_send_guild_war_battle_result == 0 then
        GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_WAR_CURRENT_DAY_LOG_PANEL, {
            log = msg.log,
            isTop = true
        })
    end
end

function parseGuildWarTopBattleLog(self,msg)
    self.mWarTopBattleLogList = msg.log_list
    self.mWarTopBattleLogNum = msg.log_num

    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_WAR_BATTLE_LOG, {
        logList = self.mWarTopBattleLogList,
        logNum = self.mWarTopBattleLogNum
    })
end

function parseGuildWarBetReward(self)
    self.mWarTopBet = {}
    local baseData = RefMgr:getData("guild_top_war_bet_reward")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(guildWar.GuildWarBetAwardVo)
        vo:parseData(id, data)
        table.insert(self.mWarTopBet, vo)
    end
end

function getGuildAwardBetAward(self,id)
    if self.mWarTopBet == nil then
        self:parseGuildWarBetReward()
    end

    for i = 1, #self.mWarTopBet, 1 do
        if self.mWarTopBet[i].id == id then
            return self.mWarTopBet[i]
        end
    end
    return nil
end

function parseGuildWarTopAwardData(self)
    self.guildWarTopAwardData = {}
    self.guildWarMaxId = 0
    local baseData = RefMgr:getData("guild_top_war_rank_award_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(guildWar.GuildWarSeasonVo)
        vo:parseData(id, data)
        table.insert(self.guildWarTopAwardData, vo)
        if vo.id > self.guildWarMaxId then
            self.guildWarMaxId = vo.id
        end
    end

    table.sort(self.guildWarTopAwardData, function(vo1, vo2)
        return vo1.id < vo2.id
    end)
end

function getGuildWarTopAwardData(self)
    if self.guildWarTopAwardData == nil then
        self:parseGuildWarTopAwardData()
    end
    return self.guildWarTopAwardData
end

function getGuildWarTopAwardMaxId(self)
        if self.guildWarTopAwardData == nil then
        self:parseGuildWarTopAwardData()
    end
    return self.guildWarMaxId
end

--观战数据
function parseGuildWarTopOb(self,msg)
    self.obDay = msg.day 
    self.guildInfo1 = msg.guild_info_1
    self.guildInfo2 = msg.guild_info_2

    GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_WAR_TOP_OB_PANEL)
end

--获取观战数据
function getGuildWarTopObData(self)
    return self.obDay, self.guildInfo1, self.guildInfo2
end

function getObInfoAllMembers(self,team)
    local retList = {} 
    local members = team == 1 and self.guildInfo1.members or self.guildInfo2.members
    local robotList = team == 1 and self.guildInfo1.robot_members or self.guildInfo2.robot_members

    for i = 1, #members, 1 do
        table.insert(retList, members[i])
    end

    for i = 1, #robotList, 1 do
        table.insert(retList, robotList[i])
    end
    return retList
end

function parseGuildWarBetAward(self,msg)
    self.awardBetResult = msg.result --"0-失败,1-应援成功,2-应援失败,3-安慰奖励"
    self.awardGroupId = msg.group_id
    self.awardDay = msg.day
    self.betUid = msg.bet_uid

    if self.awardBetResult == 0 then
        gs.Message.Show("领取失败")
        return
    end

    GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_WAR_BET_AWARD_PANEL)
end

function getGuildWarBetAwardData(self)
    return self.awardBetResult, self.awardGroupId, self.awardDay,self.betUid
end

function parseGuildBetAwardRedPoint(self,msg)
    self.awardBetRedPoint = msg.bet_award_info
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_WAR_STATE)
end

function getGuildBetAwardRedAll(self)
    local red = false
    for i = 1, 6 do
        red = red or self:getGuildBetAwarRed(i)
    end
    return red
end

function getGuildBetAwarRed(self,i)
    if self.awardBetRedPoint == nil then
        return false
    end
    for k, v in pairs(self.awardBetRedPoint) do
        if v.day == i then
            return v.red_point == 1
        end
    end
end
 
return _M
