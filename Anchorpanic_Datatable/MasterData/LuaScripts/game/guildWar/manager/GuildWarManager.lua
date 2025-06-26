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
end

-- 析构函数
function dtor(self)
end

function parseGuildWar()

end

function parseChallengeInfo(self, msg)
    local function fightCall()
        fight.FightManager:reqBattleEnter(PreFightBattleType.GuildWar, self.lastPlayerId)
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
            log = msg.log
        })
    end

end

function parseGuildWarSeason(self, msg)
    self.warSeasonId = msg.season_info.season_id -- 赛季id
    self.warNextStepStartTime = msg.season_info.next_step_start_time -- 开始时间
    self.warState = msg.season_info.state -- 状态
    self.warEndTime = msg.season_info.end_time
    self.warStartTime = msg.season_info.start_time
    self.lockDefState = msg.sync_def_formation_state

    -- 状态切换时重置敌方数据
    self.mEnemyGuildInfo = nil

    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_WAR_STATE)

    cusLog("最新团战状态" .. self.warState)
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
    return self.warState
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
    return (#teamHeroList == 0 or teamHeroList == nil) and (self.warState == guildWar.GuildWarState.GuildWarSignUp or self.warState == guildWar.GuildWarState.GuildWarMatchAndSettle)
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
return _M
