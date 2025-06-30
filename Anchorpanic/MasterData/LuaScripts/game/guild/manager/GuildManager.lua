module("guild.GuildManager", Class.impl(Manager))

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
    self.mGuildBossViewList = {}

    self.mGuildBossFightDamage = 0

    self.mSweepViewList = {}
end

-- 析构函数
function dtor(self)
end

function guildAwardPanelInfo(self, msg)
    self.mAwardInfo = msg.award_panel
    self:updateRedInfo()
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_PREPARATION_PANEL)
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_SUPPLY_PANEL)
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_MAIN_PANEL)
end

-- 更新弹劾状态
function updateImpeachMsgInfo(self, msg)
    self.mGuildInfo.leader_impeach = 1
    self.mGuildInfo.leader_impeach_time = msg.leader_impeach_time
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_MEMBER_PANEL)
end

function getGuildAllMembers(self)
    local retList = {} 
    local members = self.mGuildInfo.members
    local robotList = self.mGuildInfo.robot_members

    for i = 1, #members, 1 do
        table.insert(retList, members[i])
    end

    for i = 1, #robotList, 1 do
        table.insert(retList, robotList[i])
    end
    return retList
end

--是否建筑已经入驻机器人
function getGuildRobotHas(self,buildId)
    for i = 1,#self.mGuildInfo.robot_members do
        if buildId == self.mGuildInfo.robot_members[i].build_info.build_id then
            return true
        end
    end
    return false
end

function getImpeachMsgTime(self)
    return self.mGuildInfo.leader_impeach_time
end

function getImpeaching(self)
    return self.mGuildInfo.leader_impeach == 1
end

function getAwardPanelInfo(self)
    return self.mAwardInfo
end

function getIsJoinGuildWar(self)
    return self.mGuildInfo.is_join_guild_war == 1
end

function doPrepareInfo(self, msg)
    self:updateGuidInfo(msg.guild_info)
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_PREPARATION_PANEL)
end

function openSupplyHandler(self, msg)
    self:updateGuidInfo(msg.guild_info)
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_SUPPLY_PANEL)
end

function gainSupplyHandler(self, msg)
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_SUPPLY_PANEL)
end

function updateRequestInfo(self, msg, errorType)
    self:updateGuidInfo(msg.guild_info)
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_REQUEST_PANEL)
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_MAIN_PANEL)
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_MANAGER_TAB_VIEW)
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_MANAGER_PANEL)

    if msg.result == 0 then
        if errorType == 1 then
            gs.Message.Show(_TT(94570))
        elseif errorType == 2 then
            gs.Message.Show(_TT(94574))
        end
    elseif msg.result == 2 then
        if errorType == 1 then
            gs.Message.Show(_TT(94585))
        end
    elseif msg.result == 3 then
        gs.Message.Show(_TT(94594))
    end
end

function updateMemberInfo(self, msg)
    cusLog("更新成员信息")
    self:updateGuidInfo(msg.guild_info)
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_MANAGER_TAB_VIEW)
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_MAIN_PANEL)
end

function updateCommissionJob(self, msg)
    for k, v in pairs(self.mGuildInfo.members) do
        if v.player_id == msg.member_info.player_id then
            self.mGuildInfo.members[k] = msg.member_info
        end
    end
    table.sort(self.mGuildInfo.members, self.sortMember)
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_MANAGER_TAB_VIEW)
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_MAIN_PANEL)
end

function transferLeaderInfo(self, msg)
    self:updateGuidInfo(msg.guild_info)
    GameDispatcher:dispatchEvent(EventName.CLOSE_GUILD_MANAGER_PANEL)
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_MAIN_PANEL)
end

function updateRequestSetting(self, msg)
    self:updateGuidInfo(msg.guild_info)
    gs.Message.Show("修改成功")
    GameDispatcher:dispatchEvent(EventName.CLOSE_REQUEST_SETTING_PANEL)
end

function leaveGuildInfo(self, msg)
    if self.mGuildInfo then
        self.mGuildInfo.uid = "0"
    end
    self:updateRedInfo()
    gs.Message.Show(_TT(94580))
    GameDispatcher:dispatchEvent(EventName.CLOSE_ALL_GUILD_PANEL)
end

function gainPrepareInfo(self, msg)
    table.insert(self.mAwardInfo.gained_prepare_award_list, msg.id)
    self:updateRedInfo()
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_MAIN_PANEL)
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_PREPARATION_PANEL)

end

function guildInfoOption(self, msg)
    -- self.mGuildInfo = msg.guild_info
    self.mLeaveTime = msg.leave_time
    self:updateGuidInfo(msg.guild_info)
    -- if self.mGuildInfo.uid == "0" then
    --     GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_JOIN_PANEL)
    -- else
    --     GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_MAIN_PANEL)
    -- end
    GameDispatcher:dispatchEvent(EventName.WAIT_GUILD_APPLY, msg)
end

-- 获取离开公会的时间
function getLeaveTime(self)
    return self.mLeaveTime
end

function guildCreateOption(self, msg)
    -- self.mGuildInfo = msg.guild_info
    self:updateGuidInfo(msg.guild_info)
    GameDispatcher:dispatchEvent(EventName.CLOSE_GUILD_JOIN_PANEL)
    GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_MAIN_PANEL)
    gs.Message.Show(_TT(94569))
end

function getChairmanNum(self)
    local num = 0
    for i = 1, #self.mGuildInfo.members do
        if self.mGuildInfo.members[i].job == guild.GuildJobType.Chairman then
            num = num + 1
        end
    end
    return num
end

function getGuildIconId(self)
    return self.mGuildInfo.icon and self.mGuildInfo.icon or 1
end

function getGuildInfo(self)
    return self.mGuildInfo
end

-- 取自己的联盟名
function getGuildName(self)
    return self.mGuildInfo.name
end

function getGuildCoin(self)
    return self.mGuildInfo.coin
end

function getJoinGuilded(self)
    return self.mGuildInfo and self.mGuildInfo.uid ~= "0"
end

function getGuildLv(self)
    return self.mGuildInfo.lv
end

function getGuildNotice(self)
    return self.mGuildInfo.notice
end

function getGuildImpeach(self)
    return self.mGuildInfo.leader_impeach
end

function getGuildImapeachTime(self)
    return self.mGuildInfo.leader_impeach_time
end

function getSelfIsGuildLeader(self)
    local roleId = role.RoleManager:getRoleVo().playerId
    return self.mGuildInfo.leader_id == roleId
end

function getSelfIsChairman(self)
    local roleId = role.RoleManager:getRoleVo().playerId
    for i = 1, #self.mGuildInfo.members do
        if self.mGuildInfo.members[i].player_id == roleId then
            return self.mGuildInfo.members[i].job == guild.GuildJobType.Chairman
        end
    end
end

function refreshGuilds(self, msg)
    if msg.uid ~= "0" then
        gs.Message.Show(_TT(94568))
        GameDispatcher:dispatchEvent(EventName.CLOSE_GUILD_JOIN_PANEL)
        GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_MAIN_PANEL)
        return
    end

    self.mGuildList = msg.guild_list
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_JOIN_TAB_PANEL)
end

function getGuilds(self)
    return self.mGuildList
end

function setLastChangeName(self, guildName)
    self.needGuildName = guildName
end

function renameGuild(self, msg)
    self.mGuildInfo.name = self.needGuildName
    gs.Message.Show("修改成功")
    GameDispatcher:dispatchEvent(EventName.CLOSE_GUILD_CHANGE_NAME_PANEL)
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_MAIN_PANEL)
end

function changeNotice(self, msg)
    self.mGuildInfo.notice = self.needNotice
    gs.Message.Show("修改成功")
    GameDispatcher:dispatchEvent(EventName.CLOSE_GUILD_CHANGE_NOTICE_PANEL)
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_MAIN_PANEL)
end

function setLasetChangeNotice(self, notice)
    self.needNotice = notice
end

function applySuccessHandler(self, msg)
    -- self.mGuildInfo = msg.guild_info
    self:updateGuidInfo(msg.guild_info)
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_JOIN_TAB_PANEL)
    if self.mGuildInfo.uid ~= "0" then

        GameDispatcher:dispatchEvent(EventName.CLOSE_GUILD_JOIN_PANEL)
        GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_MAIN_PANEL)
        gs.Message.Show(_TT(94568))
    end
end

function updateGuidInfo(self, guildInfo)
    self.mGuildInfo = guildInfo
    table.sort(self.mGuildInfo.members, self.sortMember)
    table.sort(self.mGuildInfo.apply_list, self.sortApply)
    self:updateRedInfo()
    GameDispatcher:dispatchEvent(EventName.MONEY_BAR_UPDATE, MoneyTid.GUILD_FUND_TID)
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_MAIN_PANEL)
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_MEMBER_PANEL)
end

function updateRedInfo(self)
    local red = false
    if self.mGuildInfo ~= nil and self.mGuildInfo.uid ~= "0" then
        red = self:checkIsRed()
    else
        red = false
    end
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_GUILD, red)
end

function checkIsRed(self)
    local isRed = false
    isRed = isRed or self:canApplyRed()
    isRed = isRed or self:canPreparationRed()
    isRed = isRed or self:canOpenSupplyRed()
    isRed = isRed or self:canGetSupplyRed()
    isRed = isRed or self:isShowToDayGuildBossRed()
    isRed = isRed or self:canUpSkillRed()
    isRed = isRed or self:canGetSweepRewardRed()
    isRed = isRed or self:canChallengeSweepRed()
    isRed = isRed or guildWar.GuildWarManager:getGuildWarDefFormationRed()
    isRed = isRed or guildWar.GuildWarManager:getGuildWarFightRed()
    isRed = isRed or guildWar.GuildWarManager:getGuildWarCanJunRed()
    return isRed
end

function canApplyRed(self)
    local isRed = false
    isRed =#self.mGuildInfo.apply_list > 0 and (self:getSelfIsGuildLeader() or self:getSelfIsChairman()) 
    return isRed
end

function canPreparationRed(self)
    local isRed = false
    local defVo = self:getGuildPrepareData()[1]
    local result, tips = MoneyUtil.judgeNeedMoneyCountByTid(defVo.prepareCost[1], defVo.prepareCost[2], true, true)
    local isPre = self.mAwardInfo ~= nil and table.indexof01(self.mAwardInfo.today_is_prepare, 1) > 0
    isRed = result and isPre == false
    isRed = isRed or self:canGetAwardRed()
    return isRed
end

function canGetAwardRed(self)
    local isRed = false
    local awardList = guild.GuildManager:getGuildAwardData()
    for i = 1, #awardList do
        isRed = isRed or self:canGetSingleAward(awardList[i])
    end
    return isRed
end

function canGetSingleAward(self, vo)
    local isPass = false
    if self.mAwardInfo and self.mAwardInfo.gained_prepare_award_list then
        isPass = table.indexof01(self.mAwardInfo.gained_prepare_award_list, vo.id) > 0
    end

    return self.mGuildInfo.prepare_times >= vo.needTimes and isPass == false
end

function canOpenSupplyRed(self)
    local isRed = false
    local localData = self:getGuildData(self.mGuildInfo.lv)
    local result, tips = MoneyUtil.judgeNeedMoneyCountByTid(MoneyTid.GUILD_FUND_TID, localData.supplyCost, true, true)
    local isNoOpen = self.mGuildInfo.is_open_supply == 0

    isRed = self:getSelfIsGuildLeader() and isNoOpen and result
    return isRed
end

function canGetSupplyRed(self)
    local isRed = false
    local isOpen = self.mGuildInfo.is_open_supply == 1
    local isNoGet = self.mAwardInfo ~= nil and self.mAwardInfo.gained_supply == 0 and isOpen
    isRed = isNoGet
    return isRed
end

function canUpSkillRed(self)
    local isRed = false
    for i = 0, 5 do
        isRed = isRed or self:canUpSkillSingle(i)
    end
    return isRed
end

function canUpSkillSingle(self, eleType)
    if self.mSkillInfoList == nil then
        return false
    else
        local vo = nil
        for k, v in pairs(self.mSkillInfoList) do
            if v.id == eleType then
                vo = v
            end
        end
        local lv = vo.lv
        local curData = self:getGuildSkillData(eleType, vo.lv)
        local maxLv = guild.GuildManager:getGuildSkillMaxLv(eleType)
        if maxLv > lv and
            MoneyUtil.judgeNeedMoneyCountByTid(curData.needStuff[1][1], curData.needStuff[1][2], true, true) and
            MoneyUtil.judgeNeedMoneyCountByTid(curData.needStuff[2][1], curData.needStuff[2][2], true, true) then
            return true
        end
        return false
    end
end

function sortMember(a, b)
    -- if a.job > b.job then
    --     return true
    -- end
    -- if a.job < b.job then
    --     return false

    if a.job ~= b.job then
        -- end
        if a.job == 1 and b.job == 2 then
            return true
        end
        if a.job == 1 and b.job == 0 then
            return true
        end
        if a.job == 2 and b.job == 0 then
            return true
        end
        if a.job == 2 and b.job == 1 then
            return false
        end
        if a.job == 0 and b.job == 1 then
            return false
        end

        if a.job == 0 and b.job == 2 then
            return false
        end
    end

    if a.is_online > b.is_online then
        return true
    end
    if a.is_online < b.is_online then
        return false
    end

    if a.offline_time > b.offline_time then
        return true
    end
    if a.offline_time < b.offline_time then
        return false
    end

    if a.player_lv > b.player_lv then
        return true
    end
    if a.player_lv < b.player_lv then
        return false
    end
    if a.player_id < b.player_id then
        return true
    end
    if a.player_id > b.player_id then
        return false
    end
end

function sortApply(a, b)
    if a.player_lv > b.player_lv then
        return true
    end
    if a.player_lv < b.player_lv then
        return false
    end
    if a.player_id < b.player_id then
        return true
    end
    if a.player_id > b.player_id then
        return false
    end
end

function skillMsgInfo(self, msg)
    self.mSkillInfoList = msg.science_info_list
    self:updateRedInfo()
end

function updateSkillMsgInfo(self, msg)
    for k, v in pairs(self.mSkillInfoList) do
        if v.id == msg.science_info.id then
            self.mSkillInfoList[k] = msg.science_info
        end
    end
    self:updateRedInfo()
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_SKILL_PANEL)
end

function getSkillInfo(self)
    return self.mSkillInfoList
end

function setLastClickRefreshTime(self, time)
    self.lastClickTime = time
end

function getLastClickRefreshTime(self)
    return self.lastClickTime == nil and 0 or self.lastClickTime
end

function parseGuildData(self)
    self.mGuildDataDic = {}
    self.mMaxLv = 0
    local baseData = RefMgr:getData("guild_lv_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(guild.GuildExpDataVo)
        vo:parseData(id, data)
        if self.mMaxLv < vo.lv then
            self.mMaxLv = vo.lv
        end
        self.mGuildDataDic[id] = vo
    end
end

function getGuildData(self, lv)
    if self.mGuildDataDic == nil then
        self:parseGuildData()
    end
    return self.mGuildDataDic[lv]
end

function getMaxGuildLv(self)
    if self.mMaxLv == nil then
        self:parseGuildData()
    end
    return self.mMaxLv
end

function parseGuildPrepareData(self)
    self.mGuildPrepareDataDic = {}
    local baseData = RefMgr:getData("guild_prepare_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(guild.GuildPrepareDataVo)
        vo:parseData(id, data)
        self.mGuildPrepareDataDic[id] = vo
    end
end

function getGuildPrepareData(self)
    if self.mGuildPrepareDataDic == nil then
        self:parseGuildPrepareData()
    end
    return self.mGuildPrepareDataDic
end

function parseGuildAwardData(self)
    self.mGuildAwardList = {}
    self.mMaxTimes = 0
    local baseData = RefMgr:getData("guild_award_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(guild.GuildAwardDataVo)
        vo:parseData(id, data)
        if vo.needTimes > self.mMaxTimes then
            self.mMaxTimes = vo.needTimes
        end
        table.insert(self.mGuildAwardList, vo)
        -- self.mGuildAwardDic[id] = vo
    end
end

function getGuildAwardData(self)
    if self.mGuildAwardList == nil then
        self:parseGuildAwardData()
    end
    return self.mGuildAwardList
end

function getGuildAwardDataById(self,id)
    if self.mGuildAwardList == nil then
        self:parseGuildAwardData()
    end

    for i=1,#self.mGuildAwardList do
        if self.mGuildAwardList[i].id == id then
            return self.mGuildAwardList[i]
        end
    end
end

function getGuildAwardMaxTimes(self)
    if self.mMaxTimes == 0 or self.mMaxTimes == nil then
        self:parseGuildAwardData()
    end
    return self.mMaxTimes
end

function parseGuildSkillData(self)
    self.mGuildSkillData = {}
    local baseData = RefMgr:getData("guild_science_data")

    for k, v in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(guild.GuildSkillVo)
        vo:parseData(v)
        if self.mGuildSkillData[vo.id] == nil then
            self.mGuildSkillData[vo.id] = {}
        end
        self.mGuildSkillData[vo.id][vo.level] = vo
    end
end

function getGuildSkillMaxLv(self, id)
    if self.mGuildSkillData == nil then
        self:parseGuildSkillData()
    end
    local maxLv = 0
    for k, v in pairs(self.mGuildSkillData[id]) do
        if maxLv < k then
            maxLv = k
        end
    end
    return maxLv
end

function getGuildSkillData(self, id, level)
    if self.mGuildSkillData == nil then
        self:parseGuildSkillData()
    end
    return self.mGuildSkillData[id][level]
end

function parseGuildSkillEffData(self)
    self.mGuildSkillEffData = {}
    local baseData = RefMgr:getData("guild_science_eff_data")
    for k, v in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(guild.GuildSkillEffVo)
        vo:parseData(k, v)
        table.insert(self.mGuildSkillEffData, vo)
        -- self.mGuildSkillEffData[k] = vo
    end
    table.sort(self.mGuildSkillEffData, function(vo1, vo2)
        return vo1.needLv < vo2.needLv
    end)
end

function getGuildEffData(self)
    if self.mGuildSkillEffData == nil then
        self:parseGuildSkillEffData()
    end
    return self.mGuildSkillEffData
end

------------------------工会Boss------------------
function praseGuildBossConfig(self)
    self.mGuildBossStageConfig = {}

    local baseData = RefMgr:getData("guild_raid_data")
    for stage, config in pairs(baseData) do
        if not self.mGuildBossStageConfig[stage] then
            self.mGuildBossStageConfig[stage] = {}
        end

        for bossDupId, dupConfig in pairs(config.boss_list_data) do
            local vo = LuaPoolMgr:poolGet(guild.GuildBossStageDupConfigVo)
            vo:parseData(bossDupId, dupConfig)

            self.mGuildBossStageConfig[stage][dupConfig.pos] = vo
        end
    end

    self.mGuildBossSeasonReward = {}
    baseData = RefMgr:getData("guild_rank_award_data")
    for id, reward in ipairs(baseData) do
        local vo = LuaPoolMgr:poolGet(guild.GuildBossSeasonRewardConfigVo)
        vo:parseData(id, reward)
        table.insert(self.mGuildBossSeasonReward, vo)
    end
end

function getGuildBossStageConfig(self, stage)
    if not self.mGuildBossStageConfig then
        self:praseGuildBossConfig()
    end
    if not stage then
        local guildBossInfo = guild.GuildManager:getGuildBossAllInfo()
        if guildBossInfo then
            stage = guildBossInfo.round
        end

        if not stage then
            stage = stage or 1
        end

        local maxStage = self:getGuildBossMaxStage()
        stage = stage > maxStage and maxStage or stage
    end

    return self.mGuildBossStageConfig[stage]
end

function getGuildBossDupIdConfig(self, stage, dupId)
    if not self.mGuildBossStageConfig then
        self:praseGuildBossConfig()
    end

    local stageDupList = self:getGuildBossStageConfig(stage)
    for pos, dupConfigVo in pairs(stageDupList) do
        if dupConfigVo.dupId == dupId then
            return dupConfigVo
        end
    end
end

function getGuildBossMaxStage(self)
    if not self.mGuildBossStageConfig then
        self:praseGuildBossConfig()
    end

    local stage = 0
    for _stage, dupConfig in pairs(self.mGuildBossStageConfig) do
        if _stage > stage then
            stage = _stage
        end
    end

    return stage
end

function getGuildBossSeasonRewardConfigList(self)
    if not self.mGuildBossSeasonReward then
        self:praseGuildBossConfig()
    end

    return self.mGuildBossSeasonReward or {}
end

-- "状态：0- 未开始，1-开始，2-结算中"
function setSeasonState(self, state)
    self.mGuildBossSeasonState = state
end

function getSeasonState(self)
    return self.mGuildBossSeasonState
end

function setGuildBossInfo(self, msg)
    if self.mGuildBossAllInfo then
        if msg.round > self.mGuildBossAllInfo.round then
            gs.Message.Show(_TT(94598))
        end
    end

    local boss_list = {}
    for i = 1, #msg.boss_list do
        local data = msg.boss_list[i]
        boss_list[data.id] = {
            now_hp = tonumber(data.now_hp),
            max_hp = tonumber(data.max_hp),
            can_fight = data.can_fight == 1
        }
    end

    self.mGuildBossAllInfo = {
        challenge_time = msg.challenge_time,
        round = msg.round,
        guild_rank = msg.guild_rank,
        boss_list = boss_list,
        lock_hero_list = msg.lock_hero_list
    }
    self:updateRedInfo()
end

function getGuildBossAllInfo(self)
    return self.mGuildBossAllInfo
end

function getGuildBossInfo(self, dupId)
    if not self.mGuildBossAllInfo then
        return nil
    end

    return self.mGuildBossAllInfo.boss_list[dupId]
end

function setGuildBossRankInfo(self, msg)
    self.mGuildBossRankInfo = {}
    self.mGuildBossRankInfo.selfRank = {
        guild_name = msg.guild_rank.guild_name,
        rank = msg.guild_rank.rank,
        damage = msg.guild_rank.damage
    }
    self.mGuildBossRankInfo.allRank = {}
    local allRankList = msg.all_guild_tank
    for i = 1, #allRankList do
        local tab = {
            guild_name = allRankList[i].guild_name,
            rank = allRankList[i].rank,
            damage = allRankList[i].damage
        }
        table.insert(self.mGuildBossRankInfo.allRank, tab)
    end
end

-- boss战斗记录
function setGuildBossFightLog(self, maxPage, page, logList)
    if not self.mGuildBossFightLogList then
        self.mGuildBossFightLogList = {}
    end

    self.mGuildBossFightLogList.maxPage = maxPage

    local list = {}
    for i = 1, #logList do
        local log = {}
        log.player_name = logList[i].player_name
        log.round = logList[i].round
        log.boss_name = logList[i].boss_name
        log.damage = logList[i].damage
        log.time = logList[i].time

        table.insert(list, log)
    end

    if not self.mGuildBossFightLogList.logList then
        self.mGuildBossFightLogList.logList = {}
    end

    self.mGuildBossFightLogList.logList[page] = list
end

function getGuildBossFightLog(self)
    return self.mGuildBossFightLogList or {}
end

function clearGuildBossFightLog(self)
    self.mGuildBossFightLogList = nil
end

---Boss伤害记录
function setGuildBossDamageLog(self, dupId, maxPage, page, logList)
    if not self.mGuildBossDamageLogList then
        self.mGuildBossDamageLogList = {}
    end

    if not self.mGuildBossDamageLogList[dupId] then
        self.mGuildBossDamageLogList[dupId] = {}
    end

    self.mGuildBossDamageLogList[dupId].maxPage = maxPage

    if not self.mGuildBossDamageLogList[dupId].logLis then
        self.mGuildBossDamageLogList[dupId].logList = {}
    end

    local list = {}
    for i = 1, #logList do
        local log = {}
        log.player_name = logList[i].player_name
        log.round = logList[i].round
        log.boss_name = logList[i].boss_name
        log.damage = logList[i].damage
        log.time = logList[i].time

        table.insert(list, log)
    end
    self.mGuildBossDamageLogList[dupId].logList[page] = list
end

function getGuildBossDamageLog(self, dupId)
    if not self.mGuildBossDamageLogList then
        return {}
    end

    return self.mGuildBossDamageLogList[dupId] or {}
end

function clearGuildBossDamageLog(self)
    self.mGuildBossDamageLogList = nil
end

---Boss成员战斗信息
function setGuildBossMemberInfoRecord(self, record)
    if not self.mGuildBossMemberFightRecord then
        self.mGuildBossMemberFightRecord = {}
    end

    local damage_record = {}
    for k, v in pairs(record) do
        table.insert(damage_record, v)
    end

    table.sort(damage_record, function (a, b)
        return a.rank < b.rank
    end)

    local maxPage = math.ceil(#damage_record / 10)
    for i = 1, maxPage do
        if not self.mGuildBossMemberFightRecord[i] then
            self.mGuildBossMemberFightRecord[i] = {}
        end

        for j = 1, 10 do
            local index = ((i - 1) * 10) + j

            if record[index] then
                table.insert(self.mGuildBossMemberFightRecord[i], record[index])
            end
        end
    end
    self.mGuildBossMemberFightRecord.maxPage = maxPage
end

function getGuildBossMemberInfoRecord(self, page)
    if not self.mGuildBossMemberFightRecord then
        return {}
    end
    return self.mGuildBossMemberFightRecord[page] or {}, self.mGuildBossMemberFightRecord.maxPage
end

function clearGuildBossMemberInfoRecord(self)
    self.mGuildBossMemberFightRecord = nil
end

function getGuildBossRankInfo(self)
    return self.mGuildBossRankInfo or {}
end

function clearGuildBossFightDamage(self)
    self.mGuildBossFightDamage = 0
end

-- 获取工会boss的开启跟结束时间
function getGuildBossOpenEndTimeDt(self)
    local refreshTime = function()
        self.mGuildBossOpenDt = nil
        self.mGuilBossEndDt = nil

        local systemParamConfig = sysParam.SysParamManager:getValue(SysParamType.GUILDBOSS_OPENTIME)

        local curClientDt = GameManager:getClientTime()
        local openData, endData, openDt, endDt = 0, 0, 0, 0
        for i = 1, #systemParamConfig do
            openData = systemParamConfig[i][1]
            endData = systemParamConfig[i][2]
            openDt = os.time({
                year = openData[1],
                month = openData[2],
                day = openData[3],
                hour = 9,
                min = 0,
                sec = 0
            })
            endDt = os.time({
                year = endData[1],
                month = endData[2],
                day = endData[3],
                hour = 23,
                min = 59,
                sec = 0
            })

            if curClientDt < endDt then
                self.mGuildBossOpenDt = openDt
                self.mGuilBossEndDt = endDt
                break
            end
        end
    end

    if self.mGuildBossOpenDt ~= nil and self.mGuilBossEndDt ~= nil then
        if GameManager:getClientTime() > self.mGuilBossEndDt then
            refreshTime()
        end
    else
        refreshTime()
    end

    return self.mGuildBossOpenDt, self.mGuilBossEndDt
end

function getGuildBossIsOpen(self)

    local guildBossSeasonState = self:getSeasonState()
    if guildBossSeasonState == nil then
        local bossOpenDt, bossEndDt = guild.GuildManager:getGuildBossOpenEndTimeDt()
        if bossOpenDt == nil or bossEndDt == nil then
            return false
        end

        local curClientDt = GameManager:getClientTime()
        if curClientDt < bossOpenDt then
            return false
        end

        if curClientDt > bossEndDt then
            return false
        end

        return true
    else
        return guildBossSeasonState ~= 0
    end
end

function isShowToDayGuildBossRed(self)
    local isShowGuildBossRed = false
    if guild.GuildManager:getGuildBossIsOpen() then
        local guildBossInfo = guild.GuildManager:getGuildBossAllInfo()
        if guildBossInfo and guildBossInfo.challenge_time > 0 then
            -- if not remind.RemindManager:isTodayNotRemain(RemindConst.GUILDBOSS_REDPOINT_TIPS) then
            isShowGuildBossRed = true
            -- end
        end
    end

    return isShowGuildBossRed
end

-------------------------------------------------sweep--------------------------------

function parseGuildSweepInfo(self, msg)
    -- 状态：0- 开启状态，1-锁定状态
    self.guildSweepState = msg.state
    -- 下次状态改变的时间
    self.guildSweepChangeTime = msg.change_time
    -- 当前选择的难度
    self.guildSweepNowLevel = msg.now_level
    -- 可选择的最高难度
    self.guildSweepMaxLevel = msg.max_level
    -- 本周的轮换id
    self.guildRoundId = msg.round_id
    -- 剩余血量百分比
    self.guildHpRate = msg.hp_rate
    -- 已经领取的奖励列表
    self.guildRewardList = msg.had_reward_list
    -- 剩余挑战次数
    self.guildChallengeTime = msg.challenge_time

    self:updateRedInfo()
    GameDispatcher:dispatchEvent(EventName.ON_GUILD_SWEEP_INFO_CHANGE)
    if self.guildSweepState == 1 then
        GameDispatcher:dispatchEvent(EventName.CLOSE_ALL_GUILD_SWEEP_PANEL)
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_MAIN_PANEL)
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_SWEEP_BOSS_PANEL)
end

function updateGuildSweepInfo(self, msg)
    -- 下次状态改变的时间
    self.guildChallengeTime = msg.challenge_time
    -- 剩余血量百分比
    self.guildHpRate = msg.hp_rate
    self:updateRedInfo()
    GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_SWEEP_BOSS_PANEL)
end

function updateGuildSweepReard(self, msg)
    table.insert(self.guildRewardList, msg.id)
    self:updateRedInfo()
    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_SWEEP_BOSS_PANEL)
end

function updateGuildSweepLogInfo(self, msg)
    self.mLogList = msg.record

    table.sort(self.mLogList, function (vo1, vo2)
        return vo1.rank < vo2.rank
    end)

    GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_SWEEP_LOG_PANEL)
end

function getGuildSweepLogInfo(self)
    return self.mLogList
end

function getGuildSweepState(self)
    return self.guildSweepState == nil and 0 or self.guildSweepState
end

function getGuildSweepChangeTime(self)
    return self.guildSweepChangeTime == nil and 0 or self.guildSweepChangeTime
end

function getGuildSweepNowLevel(self)
    return self.guildSweepNowLevel == nil and 1 or self.guildSweepNowLevel
end

function getGuildSweepMaxLevel(self)
    return self.guildSweepMaxLevel == nil and 3 or self.guildSweepMaxLevel
end

function getGuildSweepRoundId(self)
    return self.guildRoundId == nil and 1 or self.guildRoundId
end

function getGuildSweepHpRate(self)
    return self.guildHpRate == nil and 100 or self.guildHpRate
end

function getGuildSweepRewardGeted(self, id)
    if self.guildRewardList then
        return table.indexof01(self.guildRewardList, id) > 0
    end
    return false
end

function getGuildSweepChallengeTimes(self)
    return self.guildChallengeTime == nil and 1 or self.guildChallengeTime
end

function canGetSweepRewardRed(self)
    if self.guildSweepState == nil or self.guildSweepState == 1 then
        return false
    end

    local level = self:getGuildSweepNowLevel()
    if level == 0 then
        return false
    end

    local diffVo = self:getSweepDifficultyDataByDifId(level)
    local awardList = diffVo.mStepList
    local isRed = false
    for i = 1, #awardList do
        isRed = isRed or self:canGetSingleRewardRed(awardList[i])
    end
    return isRed
end

function canChallengeSweepRed(self)
    if self.guildSweepState == nil or self.guildSweepState == 1 then
        return false
    end

    local level = self:getGuildSweepNowLevel()
    if level == 0 then
        return false
    end

    if self.guildHpRate > 0 and self.guildChallengeTime > 0 then
        return true
    else
        return false
    end
end

function canGetSingleRewardRed(self, vo)
    if self.guildRewardList == nil then
        return false
    end
    return self.guildHpRate <= vo.remainingHp and table.indexof01(self.guildRewardList, vo.id) == 0
end

function parseSweepDifficultyData(self)
    self.mGuildSweepDic = {}
    local baseData = RefMgr:getData("sweep_difficulty_data")
    for id, data in ipairs(baseData) do
        local vo = LuaPoolMgr:poolGet(guild.GuildSweepDifficultyVo)
        vo:parseData(id, data)
        self.mGuildSweepDic[id] = vo
    end
end

function getSweepDifficultyData(self)
    if self.mGuildSweepDic == nil then
        self:parseSweepDifficultyData()
    end
    return self.mGuildSweepDic
end

function getSweepDifficultyDataByDifId(self, id)
    if self.mGuildSweepDic == nil then
        self:parseSweepDifficultyData()
    end
    return self.mGuildSweepDic[id]
end

function parseSweepMapData(self)
    self.mGuildMapDic = {}
    local baseData = RefMgr:getData("sweep_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(guild.GuildSweepVo)
        vo:parseData(id, data)
        self.mGuildMapDic[id] = vo
    end
end

function getSweepMapData(self)
    if self.mGuildMapDic == nil then
        self:parseSweepMapData()
    end
    return self.mGuildMapDic
end

function getSweepMapDataByRoundId(self, roundId)
    if self.mGuildMapDic == nil then
        self:parseSweepMapData()
    end
    return self.mGuildMapDic[roundId]
end

function parseSweepDupData(self)
    self.mGuildSweepDupDic = {}
    local baseData = RefMgr:getData("sweep_dup_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(guild.GuildSweepDupVo)
        vo:parseData(id, data)
        self.mGuildSweepDupDic[id] = vo
    end
end

function getSweepDupDataByDupId(self, dupId)
    if self.mGuildSweepDupDic == nil then
        self:parseSweepDupData()
    end
    return self.mGuildSweepDupDic[dupId]
end

function parseGuildIconData(self)
    self.mGuildIconData = {}
    local baseData = RefMgr:getData("guild_icon_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(guild.GuildIconVo)
        vo:parseData(id, data)
        --table.insert(self.mGuildIconData, vo)
        self.mGuildIconData[id] = vo
    end
end

function getIconData(self)
    if self.mGuildIconData == nil then
        self:parseGuildIconData()
    end
    return self.mGuildIconData
end

function getIconDataById(self,id)
    if self.mGuildIconData == nil then
        self:parseGuildIconData()
    end

    if id == 0 then
        id = 1
    end
    return self.mGuildIconData[id]
end

function setSweepBossName(self, name)
    self.mBossName = name
end

function getSweepBossName(self)
    return self.mBossName
end

function setClickVo(self, vo)
    self.lastVo = vo
end

function getClickVo(self)
    return self.lastVo
end

function setTempIconId(self,tempId)
    self.tempId = tempId
end

function getTempId(self)
    return self.tempId and self.tempId or 1
end


return _M
