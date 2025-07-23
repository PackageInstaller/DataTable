module("guild.GuildController", Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)


    GameDispatcher:addEventListener(EventName.REQ_GUILD_CHANGE_ICON,self.onReqGuildChangeIcon,self)
    GameDispatcher:addEventListener(EventName.REQ_GUILD_INFO, self.onReqGuldInfo, self)
    GameDispatcher:addEventListener(EventName.REQ_CREATE_GUILD, self.onReqCreateGuild, self)

    GameDispatcher:addEventListener(EventName.REQ_REFRESH_GUILDS, self.onReqRefreshGuilds, self)
    GameDispatcher:addEventListener(EventName.REQ_APPLY_GUILD, self.onReqApplyGuild, self)

    GameDispatcher:addEventListener(EventName.REQ_RANAME_GUILD, self.onReqReNameGuild, self)
    GameDispatcher:addEventListener(EventName.REQ_CHANGE_NOTICE, self.onReqChangeNotice, self)

    GameDispatcher:addEventListener(EventName.REQ_GUILD_ARGEE_APPLY, self.onReqAgreeApply, self)
    GameDispatcher:addEventListener(EventName.REQ_GUILD_REJECT_APPLY, self.onReqRejectApply, self)

    GameDispatcher:addEventListener(EventName.REQ_GUILD_REMOVE_MEMBER, self.onReqRemoveMember, self)
    GameDispatcher:addEventListener(EventName.REQ_GUILD_TRANSFER_LEADER, self.onReqTransferLeader, self)

    GameDispatcher:addEventListener(EventName.REQ_GUILD_PREPARE, self.onReqPrePare, self)
    GameDispatcher:addEventListener(EventName.REQ_GAIN_PREPARE_AWARD, self.onReqGainPreAward, self)
    GameDispatcher:addEventListener(EventName.REQ_OPEN_SUPPLY_AWARD, self.onReqOpenSupply, self)
    GameDispatcher:addEventListener(EventName.REQ_GAIN_SUPPLY_AWARD, self.onReqGainSupply, self)
    GameDispatcher:addEventListener(EventName.REQ_SET_APPLY_COND, self.onReqSetReuest, self)
    GameDispatcher:addEventListener(EventName.REQ_LEAVE_GUILD, self.onReqLeaveGuild, self)
    GameDispatcher:addEventListener(EventName.REQ_UPGRADE_GUILD_SKILL, self.onReqUpgradeGuild, self)

    GameDispatcher:addEventListener(EventName.REQ_IMPEACH_LEADER, self.onReqImpeachLeader, self)

    GameDispatcher:addEventListener(EventName.REQ_COMMISSION_JOB, self.onReqCommoissionJob, self)

    GameDispatcher:addEventListener(EventName.REQ_GAIN_OLD_PREPARE_AWARD,self.onReqGainOldPrepareAward,self)

    GameDispatcher:addEventListener(EventName.OPEN_GUILD_TIPS_PANEL, self.onOpenGuildTipsPanel, self)

    GameDispatcher:addEventListener(EventName.CAN_OPEN_GUILD, self.canOpenGuildInfo, self)
    GameDispatcher:addEventListener(EventName.OPEN_GUILD_JOIN_PANEL, self.onOpenJoinPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_GUILD_JOIN_PANEL, self.onCloseJoinPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_GUILD_MAIN_PANEL, self.onOpenGuildMainPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_GUILD_CHANGE_NAME_PANEL, self.onOpenChangeNamePanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_GUILD_CHANGE_NAME_PANEL, self.onCloseChangeNamePanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_GUILD_CHANGE_ICON_PANEL,self.onOpenChangeIconPanel,self)
    GameDispatcher:addEventListener(EventName.CLOSE_GUILD_CHANGE_ICON_PANEL,self.onCloseChangeIconPanel,self)

    

    GameDispatcher:addEventListener(EventName.OPEN_GUILD_CHANGE_NOTICE_PANEL, self.onOpenChangeNoticePanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_GUILD_CHANGE_NOTICE_PANEL, self.onCloseChangeNoticePanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_GUILD_SUPPLY_PANEL, self.onOpenGuildSupplyPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_GUILD_PREPARATION_PANEL, self.onOpenGuildPreparationPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_GUILD_PREPARATION_PANEL, self.onCloseGuildPreparationPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_GUILD_SKILL_PANEL, self.onOpenGuildSkillPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_GUILD_MANAGER_PANEL, self.onOpenGuildManagerPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_GUILD_MANAGER_PANEL, self.onClosGuildManagerPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_GUILD_CHAIRMAN_MANAGER_PANEL,self.onOpenGuildChairmanManagerPanel,self)
    GameDispatcher:addEventListener(EventName.CLOSE_GUILD_CHAIRMAN_MANAGER_PANEL,self.onClosGuildChairmanManagerPanel,self)
    
    GameDispatcher:addEventListener(EventName.OPEN_REQUEST_SETTING_PANEL, self.onOpenGuildRequestPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_REQUEST_SETTING_PANEL, self.onCloseGuildRequestPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_GUILD_MEMBER_PANEL, self.onOpenGuildMemberPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_GUILD_MEMBER_PANEL, self.onCloseGuildMemberPanel, self)

    GameDispatcher:addEventListener(EventName.CLOSE_ALL_GUILD_PANEL, self.closeAllGuildPanel, self)

    --GuildBoss
    GameDispatcher:addEventListener(EventName.OPEN_GUILDBOSS_MAINUI, self.openGuildBossMainUI, self)
    GameDispatcher:addEventListener(EventName.OPEN_GUILDBOSS_RANKPANEL, self.onOpenGuildBossRankPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_GUILDBOSS_FIGHTLOG_PANEL, self.onOpenGuildBossFightLogPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_GUILDBOSS_MEMBERFIGHTINFO, self.onOpenGuildBossMemberFightInfoPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_GUILDBOSS_DAMAGELOG_PANEL, self.onOpenGuildBossDamageLogPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_GUILDBOSS_DUPINFO_PANEL, self.onOpenGuildBossInfoPanel, self)

    GameDispatcher:addEventListener(EventName.ONREQ_GUILDBOSSTIME, self.onReqGuildBossTime, self)
    GameDispatcher:addEventListener(EventName.ONREQ_GUILDBOSS_INFO, self.onReqGuildBossInfo, self)
    GameDispatcher:addEventListener(EventName.ONREQ_GUILDBOSS_BATTLECOUNT, self.onReqGuildBossBattleCount, self)

    GameDispatcher:addEventListener(EventName.ONREQ_GUILDBOSS_RANK, self.onReqGuildBossRank, self)
    GameDispatcher:addEventListener(EventName.ONREQ_GUILDBOSS_FIGHTLOG, self.onReqGuildBossFightLog, self)
    GameDispatcher:addEventListener(EventName.ONREQ_GUILDBOSS_DAMAGELOG, self.onReqGuildBossDamageLog, self)
    GameDispatcher:addEventListener(EventName.ONREQ_GUILDBOSS_MEMBERFIGHTINFO, self.onReqGuildBossMemberFightInfo, self)

    GameDispatcher:addEventListener(EventName.OPEN_GUILDBOSS_RESULT_VIEW, self.onOpenGuildBossResultView, self)

    --GuildSweep
    GameDispatcher:addEventListener(EventName.CAN_OPEN_SWEEP_PANEL, self.onCanOpenGuildSweep, self)
    GameDispatcher:addEventListener(EventName.REQ_GUILD_SWEEP_SELECT_LEVEL,self.onReqGuildSweepSelectLevel,self)
    GameDispatcher:addEventListener(EventName.OPEN_GUILD_SWEEP_LEVEL_SELECT_PANEL, self.onOpenGuildSweepLevelSelectPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_GUILD_SWEEP_MAIN_PANEL, self.onOpenGuildSweepMainPanel, self)
    GameDispatcher:addEventListener(EventName.REQ_GUILD_SWEEP_INFO, self.onReqGuildSweepInfo, self)

    GameDispatcher:addEventListener(EventName.OPEN_GUILD_SWEEP_BOSS_PANEL, self.onOpenGuildSweepBossPanel, self)
    GameDispatcher:addEventListener(EventName.REQ_GUILD_SWEEP_REWARD, self.onReqGuildSweepAward, self)
    
    GameDispatcher:addEventListener(EventName.REQ_GUILD_SWEEP_LOG_INFO, self.onReqGuildSweepLog, self)
    
    GameDispatcher:addEventListener(EventName.OPEN_GUILD_SWEEP_LOG_PANEL, self.onOpenGuildSweepLogPanel, self)
    

    GameDispatcher:addEventListener(EventName.OPEN_GUILD_SEEEP_RESULT_VIEW, self.onOpenGuildSweepResultView, self)
    GameDispatcher:addEventListener(EventName.CLOSE_ALL_GUILD_SWEEP_PANEL, self.closeGuildSweepPanel, self)

    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_RED_INFO, self.updateGuildRed, self)
    
end



function addGuildSweepViewToPool(self,cusView)
    table.insert(self.mMgr.mSweepViewList,cusView)
end

function removeGuildSweepViewToPool(self,cusView)
    table.removebyvalue(self.mMgr.mSweepViewList, cusView)
end

function addGuildBossViewToPool(self, cusView)
    table.insert(self.mMgr.mGuildBossViewList, cusView)
end

function removeGuildBossViewToPool(self, cusView)
    table.removebyvalue(self.mMgr.mGuildBossViewList, cusView)
end

function addViewToPool(self, cusView)
    table.insert(self.mMgr.mViewList, cusView)
end

function removeViewToPool(self, cusView)
    table.removebyvalue(self.mMgr.mViewList, cusView)
end

function closeAllGuildPanel(self)
    for i = 1, #self.mMgr.mViewList do
        self.mMgr.mViewList[i]:close()
    end

    self.mMgr.mViewList = {}
    self.mMgr.mGuildBossViewList = {}
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
end

function closeAllGuildBossPanel(self)
    for k, v in pairs(self.mMgr.mGuildBossViewList) do
        v:close()
    end

    self.mMgr.mGuildBossViewList = {}
end

function closeGuildSweepPanel(self)
    for k, v in pairs(self.mMgr.mSweepViewList) do
        v:close()
    end

    self.mMgr.mSweepViewList = {}
end

function updateGuildRed(self)
    guild.GuildManager:updateRedInfo()
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_GUILD_CHANGE_COIN = self.onGuildChangeCoinHandler,
        SC_GUILD_PANEL = self.onGuildInfoHandler,
        SC_CREATE_GUILD = self.onGuildCreateHandler,
        SC_REFRESH_RECOMMEND_GUILDS = self.onRefreshGuildsHandler,
        --SC_APPLY_GUILD = self.onApplyGuildHandler,
        SC_GUILD_RENAME = self.onReNameGuildHandler,
        SC_GUILD_RENOTICE = self.onChangeNoticeHandler,

        SC_AWARD_PANEL = self.onGuildAwardHandler,
        SC_DO_PREPARE = self.onGuildDoPrepareHandler,
        SC_GAIN_PREPARE_AWARD = self.onGainPrepareHandler,

        SC_OPEN_SUPPLY = self.onOpenSupplyHandler,
        SC_GAIN_SUPPLY = self.onGainSupplyHandler,

        SC_AGREE_APPLY = self.onAgreeApplyHandler,
        SC_REJECT_APPLY = self.onRejectApplyHandler,

        SC_REMOVE_MEMBER = self.onRemoveMemberHandler,
        SC_TRANSFER_LEADER = self.onTransferLeaderHandler,

        SC_SET_APPLY_COND = self.onSetApplyCondHandler,

        SC_LEAVE_GUILD = self.onLeaveGuildHandler,

        SC_SCIENCE_PANEL = self.onGuildSkillHandler,

        SC_UPGRADE_SCIENCE = self.onGuildSkillUpgradeHandler,

        SC_IMPEACH_LEADER = self.onUpdateImpeachHandler,

        SC_COMMISSION_JOB = self.onUpdateCommissionJobHandler,
        -- -工会Boss
        SC_GUILD_FIGHT_TIME_INFO = self.onReceiveGuildBossTime,
        SC_GUILD_FIGHT_PANEL_INFO = self.onReceiveGuildBossInfo,
        SC_GUILD_FIGHT_RANK = self.onReceiveGuildBossRank,
        SC_GUILD_FIGHT_BATTLE_RECORD = self.onReceiveGuildBossFightLog,
        SC_GUILD_FIGHT_BOSS_RECORD = self.onReceiveGuildBossDamageLog,
        SC_GUILD_FIGHT_MEMBER_RECORD = self.onReceiveGuildMemberFightInfo,
        SC_GUILD_FIGHT_NOW_CHALLENGE_NUMBER = self.onReceiveGuildBossBattleCount,
    
        -- 联合扫地
        SC_GUILD_SWEEP_INFO = self.onGuildSweepInfoHandler,
        SC_GUILD_SWEEP_PANEL_INFO = self.onGuildSweepPanelHandler,

        SC_GUILD_SWEEP_REWARD = self.onGuildSweepRewardHandler,
        SC_GUILD_SWEEP_MEMBER_RECORD = self.onGuildSweepLogHandler,
        SC_GAIN_OLD_PREPARE_AWARD = self.onGuildGainOldPrepareAwardHandler,
    }
end

function onGuildChangeCoinHandler(self,msg)
    if msg.result == 1 then
        GameDispatcher:dispatchEvent(EventName.CLOSE_GUILD_CHANGE_ICON_PANEL)
        GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_MAIN_PANEL)
    elseif msg.result == 2 then
        gs.Message.Show(_TT(149213))
    elseif msg.result == 3 then
        gs.Message.Show(_TT(26313))
    elseif msg.result == 4 then
        gs.Message.Show(_TT(149217))
    end
end

function onGuildInfoHandler(self, msg)
    guild.GuildManager:guildInfoOption(msg)
end

function onGuildCreateHandler(self, msg)
    if msg.result == 1 then
        guild.GuildManager:guildCreateOption(msg)
    elseif msg.result == 2 then
        gs.Message.Show(_TT(94581))
    else
        gs.Message.Show("创建失败")
    end
end

function onRefreshGuildsHandler(self, msg)
    if msg.result == 1 then
        guild.GuildManager:refreshGuilds(msg)
    elseif msg.result == 0 then
        gs.Message.Show(_TT(94564))
    elseif msg.result == 2 then
        gs.Message.Show(_TT(94571))
    elseif msg.result == 3 then
        gs.Message.Show(_TT(94572))
    elseif msg.result == 4 then
        gs.Message.Show(_TT(94573))
    elseif msg.result == 5 then
        GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_JOIN_ERROR_TAB_PANEL)
        guild.GuildManager:refreshGuilds(msg)
        gs.Message.Show("联盟已解散")
    elseif msg.result == 6 then
        gs.Message.Show(_TT(149197))
    elseif msg.result == 7 then
        gs.Message.Show(_TT(94594))
    end
end

-- function onApplyGuildHandler(self,msg)
--     if msg.result == 1 then
--         guild.GuildManager:applySuccessHandler(msg)
--         gs.Message.Show("申请成功")
--     else
--         gs.Message.Show("申请失败")
--     end
-- end

function onReNameGuildHandler(self, msg)
    if msg.result == 1 then
        guild.GuildManager:renameGuild(msg)
    elseif msg.result == 2 then
        gs.Message.Show(_TT(94581))
    elseif msg.result == 3 then
        gs.Message.Show(_TT(149213))
    elseif msg.result == 4 then
        gs.Message.Show(_TT(26313))
    else
        gs.Message.Show("改名失败")
    end
end

function onChangeNoticeHandler(self, msg)
    if msg.result == 1 then
        guild.GuildManager:changeNotice(msg)
    else
        gs.Message.Show("改公告失败")
    end
end

function onGuildAwardHandler(self, msg)
    guild.GuildManager:guildAwardPanelInfo(msg)
end

function onGuildDoPrepareHandler(self, msg)
    if msg.result == 1 then
        guild.GuildManager:doPrepareInfo(msg)
    else
        gs.Message.Show("筹备失败")
    end
end

function onGainPrepareHandler(self, msg)
    if msg.result == 1 then
        guild.GuildManager:gainPrepareInfo(msg)
    else
        gs.Message.Show("领取失败")
    end
end

function onOpenSupplyHandler(self, msg)
    if msg.result == 1 then
        guild.GuildManager:openSupplyHandler(msg)
    else
        gs.Message.Show("开启失败")
    end
end

function onGainSupplyHandler(self, msg)
    if msg.result == 1 then
        guild.GuildManager:gainSupplyHandler(msg)
    else
        gs.Message.Show("领取失败")
    end
end

function onAgreeApplyHandler(self, msg)
    guild.GuildManager:updateRequestInfo(msg, 1)
end

function onRejectApplyHandler(self, msg)
    guild.GuildManager:updateRequestInfo(msg, 2)
end

function onRemoveMemberHandler(self, msg)
    if msg.result == 1 then
        guild.GuildManager:updateMemberInfo(msg)
    elseif msg.result == 2 then
        gs.Message.Show(_TT(149196))
    else
        gs.Message.Show("请求失败")
    end
end

function onTransferLeaderHandler(self, msg)
    if msg.result == 1 then
        guild.GuildManager:transferLeaderInfo(msg)
    else
        gs.Message.Show("请求失败")
    end
end

function onSetApplyCondHandler(self, msg)
    if msg.result == 1 then
        guild.GuildManager:updateRequestSetting(msg)
    else
        gs.Message.Show("设置失败")
    end
end

function onLeaveGuildHandler(self, msg)
    if msg.result == 1 then
        guild.GuildManager:leaveGuildInfo()
    elseif msg.result == 2 then
        gs.Message.Show(_TT(149195))
    else
        gs.Message.Show("退出失败")
    end

    GameDispatcher:dispatchEvent(EventName.RECEIVE_LEAVEGUILD)
end

function onGuildSkillHandler(self, msg)
    guild.GuildManager:skillMsgInfo(msg)
end

function onGuildSkillUpgradeHandler(self, msg)
    if msg.result == 1 then
        gs.Message.Show(_TT(1299))
        guild.GuildManager:updateSkillMsgInfo(msg)
    else
        gs.Message.Show("升级失败")
    end
end

function onUpdateImpeachHandler(self, msg)
    if msg.result == 1 then
        guild.GuildManager:updateImpeachMsgInfo(msg)
    elseif msg.result == 2 then
        gs.Message.Show(_TT(94613))
    elseif msg.result == 3 then
        gs.Message.Show(_TT(149212))
    elseif msg.result == 4 then
        gs.Message.Show(_TT(149211))
    end
end

function onUpdateCommissionJobHandler(self, msg)
    if msg.result == 1 then
        gs.Message.Show(_TT(94988))
        guild.GuildManager:updateCommissionJob(msg)
    else
        gs.Message.Show("任命职位失败")
    end
end

-------------------------------------------------req-----------------------------------------------

function onReqGuildChangeIcon(self,args)
    SOCKET_SEND(Protocol.CS_GUILD_CHANGE_COIN,{icon_id = args.iconId},Protocol.SC_GUILD_CHANGE_COIN)
end

function onReqGuldInfo(self)
    SOCKET_SEND(Protocol.CS_GUILD_PANEL)
end

function onReqCreateGuild(self, args)
    SOCKET_SEND(Protocol.CS_CREATE_GUILD, {name = args.name, notice = args.notice,icon_id = args.iconId})
end

function onReqRefreshGuilds(self, args)
    SOCKET_SEND(Protocol.CS_REFRESH_RECOMMEND_GUILDS, {uid = args.uid, is_refresh_all = args.all})
end

function onReqApplyGuild(self, args)
    SOCKET_SEND(Protocol.CS_APPLY_GUILD, {uid = args.uid})
end

function onReqReNameGuild(self, args)
    guild.GuildManager:setLastChangeName(args.name)
    SOCKET_SEND(Protocol.CS_GUILD_RENAME, {name = args.name})
end

function onReqChangeNotice(self, args)
    guild.GuildManager:setLasetChangeNotice(args.notice)
    SOCKET_SEND(Protocol.CS_GUILD_RENOTICE, {notice = args.notice})
end

function onReqAgreeApply(self, args)
    SOCKET_SEND(Protocol.CS_AGREE_APPLY, {apply_player_id = args.applyPlayerId})
end

function onReqRejectApply(self, args)
    SOCKET_SEND(Protocol.CS_REJECT_APPLY, {apply_player_id = args.applyPlayerId})
end

function onReqRemoveMember(self, args)
    SOCKET_SEND(Protocol.CS_REMOVE_MEMBER, {member_player_id = args.applyPlayerId})
end

function onReqTransferLeader(self, args)
    SOCKET_SEND(Protocol.CS_TRANSFER_LEADER, {transfer_player_id = args.applyPlayerId})
end

function onReqPrePare(self, args)
    SOCKET_SEND(Protocol.CS_DO_PREPARE, {prepare_type = args.prepareType})
end

function onReqGainPreAward(self, args)
    SOCKET_SEND(Protocol.CS_GAIN_PREPARE_AWARD, {id = args.id})
end

function onReqOpenSupply(self, args)
    SOCKET_SEND(Protocol.CS_OPEN_SUPPLY)
end

function onReqGainSupply(self)
    SOCKET_SEND(Protocol.CS_GAIN_SUPPLY)
end

function onReqSetReuest(self, args)
    SOCKET_SEND(Protocol.CS_SET_APPLY_COND, {apply_type = args.type, player_lv = args.lv})
end

function onReqLeaveGuild(self)
    SOCKET_SEND(Protocol.CS_LEAVE_GUILD)
end

function onReqUpgradeGuild(self, args)
    SOCKET_SEND(Protocol.CS_UPGRADE_SCIENCE, {id = args.id})
end

function onReqImpeachLeader(self)
    SOCKET_SEND(Protocol.CS_IMPEACH_LEADER)
end

function onReqCommoissionJob(self, args)
    SOCKET_SEND(Protocol.CS_COMMISSION_JOB, {member_player_id = args.applyPlayerId, job = args.job})
end

function onReqGainOldPrepareAward(self)
    SOCKET_SEND(Protocol.CS_GAIN_OLD_PREPARE_AWARD,{},Protocol.SC_GAIN_OLD_PREPARE_AWARD)
end

function onReqGuildSweepSelectLevel(self,args)
    SOCKET_SEND(Protocol.CS_GUILD_SWEEP_SELECT_LEVEL,{now_level = args.id})
end

function onReqGuildSweepInfo(self,args)
    SOCKET_SEND(Protocol.CS_GUILD_SWEEP_PANEL_INFO)
end

function onReqGuildSweepAward(self,args)
    SOCKET_SEND(Protocol.CS_GUILD_SWEEP_REWARD,{id = args.id},Protocol.SC_GUILD_SWEEP_REWARD)
end

function onReqGuildSweepLog(self,msg)
    SOCKET_SEND(Protocol.CS_GUILD_SWEEP_MEMBER_RECORD,{},Protocol.SC_GUILD_SWEEP_MEMBER_RECORD)
end

----------------------工会Boss Start --------------------------
function onReqGuildBossTime(self)
    -- logAll("请求公会Boss，时间信息" .. 19731)
    SOCKET_SEND(Protocol.CS_GUILD_FIGHT_TIME_INFO, {})
end

function onReceiveGuildBossTime(self, msg)
    -- logAll(msg, "收到公会Boss的时间信息")
    if msg.result == 0 then
        -- logAll("请求公会战时间信息错误")
        return
    end

    if msg.state ~= guild.GuildBossSeasonState.Start then
        self:closeAllGuildBossPanel()
    end

    guild.GuildManager:setSeasonState(msg.state)
    --"状态：0- 未开始，1-开始，2-结算中"
    GameDispatcher:dispatchEvent(EventName.ONRECEIVE_GUILDBOSSTIME, {seasonState = msg.state})
end

function onReqGuildBossInfo(self)
    -- logAll("请求公会boss面板信息" ..19733)
    SOCKET_SEND(Protocol.CS_GUILD_FIGHT_PANEL_INFO, {})
end

function onReceiveGuildBossInfo(self, msg)
    -- logAll(msg, "收到公会Boss的面板信息")
    if msg.result == 0 then
        -- logAll("请求公会Boss面板信息失败")
    end

    guild.GuildManager:setGuildBossInfo(msg)
    GameDispatcher:dispatchEvent(EventName.ONRECEIVE_GUILDBOSST_INFO)

    -- if guild.GuildManager:isShowToDayGuildBossRed() then
    --     mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_GUILD, true)
    -- else
    --     mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_GUILD, false)
    -- end
end

function onReqGuildBossBattleCount(self, dupId)
    -- logAll("请求公会Boss，当前副本挑战的认数" .. 19731)
    SOCKET_SEND(Protocol.CS_GUILD_FIGHT_NOW_CHALLENGE_NUMBER, {dup_id = dupId})
end

function onReceiveGuildBossBattleCount(self, msg)
    -- logAll(msg, "收到公会Boss的挑战人数")
    if msg.result == 0 then
        -- logAll("请求公会战时间信息错误")
        return
    end

    GameDispatcher:dispatchEvent(EventName.ONRECEIVE_GUILDBOSS_BATTLECOUNT, {dup_id = msg.dup_id, battleCount = msg.number})
end

--工会Boss排行榜
function onReqGuildBossRank(self)
    -- logAll("请求工会排行版 19739")
    SOCKET_SEND(Protocol.CS_GUILD_FIGHT_RANK, {})
end

function onReceiveGuildBossRank(self, msg)
    if msg.result == 0 then
        -- logAll("请求公会boss排行榜失败")
        return
    end
    -- logAll(msg, "收到工会Boss的排行榜信息")

    guild.GuildManager:setGuildBossRankInfo(msg)

    GameDispatcher:dispatchEvent(EventName.ONRECEIVE_GUILDBOSS_RANK)
end

function onReqGuildBossFightLog(self, page)
    -- logAll(page, "请求工会战斗记录 19737")
    SOCKET_SEND(Protocol.CS_GUILD_FIGHT_BATTLE_RECORD, {page = page})
end

function onReceiveGuildBossFightLog(self, msg)
    if msg.result == 0 then
        -- logAll("请求公会boss战斗记录失败")
        return
    end
    -- logAll(msg, "收到公会Bos战斗记录")
    guild.GuildManager:setGuildBossFightLog(msg.max_page, msg.page, msg.record)
    GameDispatcher:dispatchEvent(EventName.ONRECEIVE_GUILDBOSS_FIGHTLOG)

end

function onReqGuildBossDamageLog(self, args)
    local cmd = {round = args.stage, order = args.dupId, page = args.page}
    -- logAll(cmd, "请求工会战斗记录 19737")
    SOCKET_SEND(Protocol.CS_GUILD_FIGHT_BOSS_RECORD, cmd)
end

function onReceiveGuildBossDamageLog(self, msg)
    if msg.result == 0 then
        -- logAll("请求公会boss伤害记录失败")
        return
    end

    -- logAll(msg, "收到公会Bos伤害报告")
    guild.GuildManager:setGuildBossDamageLog(msg.order, msg.max_page, msg.page, msg.record)
    GameDispatcher:dispatchEvent(EventName.ONRECEIVE_GUILDBOSS_DAMAGELOG)
end

function onReqGuildBossMemberFightInfo(self, args)
    -- logAll("请求工会成员战斗统计")
    SOCKET_SEND(Protocol.CS_GUILD_FIGHT_MEMBER_RECORD)
end

function onReceiveGuildMemberFightInfo(self, msg)
    -- logAll(msg, "收到公会Boss成员信息")
    guild.GuildManager:setGuildBossMemberInfoRecord(msg.record)
    GameDispatcher:dispatchEvent(EventName.ONRECEIVE_GUILDBOSS_MEMBERFIGHTINFO)
end

----------------------工会Boss End ---------------------------

----------------------联合扫荡 ---------------------------
function onGuildSweepInfoHandler(self,msg)
    guild.GuildManager:parseGuildSweepInfo(msg)
end

function onGuildSweepPanelHandler(self,msg)
    if msg.result == 1 then
        guild.GuildManager:updateGuildSweepInfo(msg)
    else
        --gs.Message.Show("请求联合扫荡失败")
        return
    end
end

function onGuildSweepRewardHandler(self,msg)
    if msg.result == 1 then
        guild.GuildManager:updateGuildSweepReard(msg)
    else
        gs.Message.Show("请求领奖失败")
    end
end

function onGuildSweepLogHandler(self,msg)
    if msg.result == 1 then
        guild.GuildManager:updateGuildSweepLogInfo(msg)
    else
        gs.Message.Show("请求记录失败")
    end
end

function onGuildGainOldPrepareAwardHandler(self,msg)
    if msg.result == 1 then
        GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_PREPARATION_PANEL)
    else
        gs.Message.Show("请求领取昨日奖励失败")
    end
end

function onOpenGuildTipsPanel(self, args)
    if self.mGuildTipsPanel == nil then
        self.mGuildTipsPanel = guild.GuildTipsPanel.new()
        self.mGuildTipsPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildTipsPanelHandler, self)
        --self:addViewToPool(self.mJoinPanel)
    end
    self.mGuildTipsPanel:open(args)
end

function onDestoryGuildTipsPanelHandler(self)
    self.mGuildTipsPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildTipsPanelHandler, self)
    self.mGuildTipsPanel = nil
end

function canOpenGuildInfo(self)
    local info = guild.GuildManager:getGuildInfo()

    if info == nil then
        return
    end

    if info.uid == "0" then
        GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_JOIN_PANEL)
    else
        GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_MAIN_PANEL)
    end
end

function onOpenJoinPanel(self, args)
    if not args then
        args = {}
    end

    if not args.type then
        args.type = guild.GuildJoinType.Join
    end
    if self.mJoinPanel == nil then
        self.mJoinPanel = guild.GuildJoinPanel.new()
        self.mJoinPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryJoinPanelHandler, self)
        self:addViewToPool(self.mJoinPanel)
    end
    self.mJoinPanel:open(args)
end

function onDestoryJoinPanelHandler(self)
    self:removeViewToPool(self.mJoinPanel)
    self.mJoinPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryJoinPanelHandler, self)
    self.mJoinPanel = nil
end

function onCloseJoinPanel(self)
    if self.mJoinPanel then
        self.mJoinPanel:close()
    end
end

function onOpenGuildMainPanel(self, args)
    --GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_MAIN_PANEL)
    if self.mGuildMainPanel == nil then
        self.mGuildMainPanel = guild.GuildMainPanel.new()
        self.mGuildMainPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildMainPanelHandler, self)
        self:addViewToPool(self.mGuildMainPanel)
    end
    self.mGuildMainPanel:open(args)
end

function onDestoryGuildMainPanelHandler(self)
    self:removeViewToPool(self.mGuildMainPanel)
    self.mGuildMainPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildMainPanelHandler, self)
    self.mGuildMainPanel = nil
end

function onOpenChangeNamePanel(self, args)
    if self.mGuildChangeNamePanel == nil then
        self.mGuildChangeNamePanel = guild.GuildReNamePanel.new()
        self.mGuildChangeNamePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildChangeNamePanelHandler, self)
        self:addViewToPool(self.mGuildChangeNamePanel)
    end
    self.mGuildChangeNamePanel:open(args)
end

function onDestoryGuildChangeNamePanelHandler(self)
    self:removeViewToPool(self.mGuildChangeNamePanel)
    self.mGuildChangeNamePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildChangeNamePanelHandler, self)
    self.mGuildChangeNamePanel = nil
end

function onCloseChangeNamePanel(self)
    if self.mGuildChangeNamePanel then
        self.mGuildChangeNamePanel:close()
    end
end


function onOpenChangeIconPanel(self,args)
    if self.mGuildChangeIconPanel == nil then
        self.mGuildChangeIconPanel = guild.GuildChangeIconPanel.new()
        self.mGuildChangeIconPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildChangeIconPanelHandler, self)
        self:addViewToPool(self.mGuildChangeIconPanel)
    end
    self.mGuildChangeIconPanel:open(args)
end

function onDestoryGuildChangeIconPanelHandler(self)
    self:removeViewToPool(self.mGuildChangeIconPanel)
    self.mGuildChangeIconPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildChangeIconPanelHandler, self)
    self.mGuildChangeIconPanel = nil
end

function onCloseChangeIconPanel(self)
    if self.mGuildChangeIconPanel then
        self.mGuildChangeIconPanel:close()
    end
end

function onOpenChangeNoticePanel(self, args)
    if self.mGuildChangeNoticePanel == nil then
        self.mGuildChangeNoticePanel = guild.GuildChangeNoticePanel.new()
        self.mGuildChangeNoticePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildChangeNoticePanelHandler, self)
        self:addViewToPool(self.mGuildChangeNoticePanel)
    end
    self.mGuildChangeNoticePanel:open(args)
end

function onDestoryGuildChangeNoticePanelHandler(self)
    self:removeViewToPool(self.mGuildChangeNoticePanel)
    self.mGuildChangeNoticePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildChangeNoticePanelHandler, self)
    self.mGuildChangeNoticePanel = nil
end

function onCloseChangeNoticePanel(self)
    if self.mGuildChangeNoticePanel then
        self.mGuildChangeNoticePanel:close()
    end
end

function onOpenGuildSupplyPanel(self, args)
    if self.mGuildSupplyPanel == nil then
        self.mGuildSupplyPanel = guild.GuildSupplyPanel.new()
        self.mGuildSupplyPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildSupplyPanelHandler, self)
        self:addViewToPool(self.mGuildSupplyPanel)
    end
    self.mGuildSupplyPanel:open(args)
end

function onDestoryGuildSupplyPanelHandler(self)
    self:removeViewToPool(self.mGuildSupplyPanel)
    self.mGuildSupplyPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildSupplyPanelHandler, self)
    self.mGuildSupplyPanel = nil
end

function onOpenGuildPreparationPanel(self, args)
    if self.mGuildPreparationPanel == nil then
        self.mGuildPreparationPanel = guild.GuildPreparationPanel.new()
        self.mGuildPreparationPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildPrearationPanelHandler, self)
        self:addViewToPool(self.mGuildPreparationPanel)
    end
    self.mGuildPreparationPanel:open(args)
end

function onDestoryGuildPrearationPanelHandler(self)
    self:removeViewToPool(self.mGuildPreparationPanel)
    self.mGuildPreparationPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildPrearationPanelHandler, self)
    self.mGuildPreparationPanel = nil
end

function onCloseGuildPreparationPanel(self, args)
    if self.mGuildPreparationPanel then
        self.mGuildPreparationPanel:close()
    end
end

function onOpenGuildSkillPanel(self, args)
    if self.mGuildSkillPanel == nil then
        self.mGuildSkillPanel = guild.GuildSkillPanel.new()
        self.mGuildSkillPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildSkillPanelHandler, self)
        self:addViewToPool(self.mGuildSkillPanel)
    end
    self.mGuildSkillPanel:open()
end

function onDestoryGuildSkillPanelHandler(self)
    self:removeViewToPool(self.mGuildSkillPanel)
    self.mGuildSkillPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildSkillPanelHandler, self)
    self.mGuildSkillPanel = nil
end

function onOpenGuildManagerPanel(self, args)
    if not args then
        args = {}
    end

    if not args.type then
        args.type = guild.GuildManagerType.Manager
    end
    if self.mGuildManagerPanel == nil then
        self.mGuildManagerPanel = guild.GuildManagerPanel.new()
        self.mGuildManagerPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildManagerPanelHandler, self)
        self:addViewToPool(self.mGuildManagerPanel)
    end
    self.mGuildManagerPanel:open(args)
end

function onDestoryGuildManagerPanelHandler(self)
    self:removeViewToPool(self.mGuildManagerPanel)
    self.mGuildManagerPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildManagerPanelHandler, self)
    self.mGuildManagerPanel = nil
end

function onClosGuildManagerPanel(self)
    if self.mGuildManagerPanel then
        self.mGuildManagerPanel:close()
    end
end

function onOpenGuildChairmanManagerPanel(self, args)
    if not args then
        args = {}
    end

    if not args.type then
        args.type = guild.GuildChairmanType.Manager
    end
    if self.mGuildChairmanManagerPanel == nil then
        self.mGuildChairmanManagerPanel = guild.GuildChairmanPanel.new()
        self.mGuildChairmanManagerPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildChairmanManagerPanelHandler, self)
        self:addViewToPool(self.mGuildChairmanManagerPanel)
    end
    self.mGuildChairmanManagerPanel:open(args)
end

function onDestoryGuildChairmanManagerPanelHandler(self)
    self:removeViewToPool(self.mGuildChairmanManagerPanel)
    self.mGuildChairmanManagerPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildChairmanManagerPanelHandler, self)
    self.mGuildChairmanManagerPanel = nil
end

function onClosGuildChairmanManagerPanel(self)
    if self.mGuildChairmanManagerPanel then
        self.mGuildChairmanManagerPanel:close()
    end
end

function onOpenGuildRequestPanel(self, args)
    if self.mRequestSettingPanel == nil then
        self.mRequestSettingPanel = guild.GuildRequestSettingPanel.new()
        self.mRequestSettingPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildRequestPanelHandler, self)
        self:addViewToPool(self.mRequestSettingPanel)
    end
    self.mRequestSettingPanel:open(args)
end

function onDestoryGuildRequestPanelHandler(self)
    self:removeViewToPool(self.mRequestSettingPanel)
    self.mRequestSettingPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildRequestPanelHandler, self)
    self.mRequestSettingPanel = nil
end

function onCloseGuildRequestPanel(self)
    if self.mRequestSettingPanel then--
        self.mRequestSettingPanel:close()
    end
end

function onOpenGuildMemberPanel(self, args)
    if not args then
        args = {}
    end

    if not args.type then
        args.type = guild.GuildMemberType.Member
    end
    if self.mGuildMemberPanel == nil then
        self.mGuildMemberPanel = guild.GuildMemberPanel.new()
        self.mGuildMemberPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildMemberPanelHandler, self)
        self:addViewToPool(self.mGuildMemberPanel)
    end
    self.mGuildMemberPanel:open(args)
end

function onDestoryGuildMemberPanelHandler(self)
    self:removeViewToPool(self.mGuildMemberPanel)
    self.mGuildMemberPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildMemberPanelHandler, self)
    self.mGuildMemberPanel = nil
end

function onCloseGuildMemberPanel(self)
    if self.mGuildMemberPanel then
        self.mGuildMemberPanel:close()
    end
end

----------------------------工会Boss
function openGuildBossMainUI(self, args)
    if self.mGuildBossMainUI == nil then
        self.mGuildBossMainUI = guild.GuildBossMainUI.new()
        self.mGuildBossMainUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildBossMainUIHandler, self)
        self:addViewToPool(self.mGuildBossMainUI)
        self:addGuildBossViewToPool(self.mGuildBossMainUI)
    end
    self.mGuildBossMainUI:open(args)
end

function onDestoryGuildBossMainUIHandler(self)
    self:removeViewToPool(self.mGuildBossMainUI)
    self:removeGuildBossViewToPool(self.mGuildBossMainUI)

    self.mGuildBossMainUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildBossMainUIHandler, self)
    self.mGuildBossMainUI = nil
end

--排行界面
function onOpenGuildBossRankPanel(self, args)
    if not args then
        args = {}
    end
    if not args.type then
        args.type = 1 -- 页签索引
    end

    if self.mGuildBossRankPanel == nil then
        self.mGuildBossRankPanel = guild.GuildBossRankPanel.new()
        self.mGuildBossRankPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildBossRankPanelHandler, self)
        self:addViewToPool(self.mGuildBossRankPanel)
        self:addGuildBossViewToPool(self.mGuildBossRankPanel)

    end
    self.mGuildBossRankPanel:open(args)
end

function onDestoryGuildBossRankPanelHandler(self)
    self:removeViewToPool(self.mGuildBossRankPanel)
    self:removeGuildBossViewToPool(self.mGuildBossRankPanel)

    self.mGuildBossRankPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildBossRankPanelHandler, self)
    self.mGuildBossRankPanel = nil
end

--战斗记录
function onOpenGuildBossFightLogPanel(self, args)
    if self.mGuildBossFightLogPanel == nil then
        self.mGuildBossFightLogPanel = guild.GuildBossFightLogPanel.new()
        self.mGuildBossFightLogPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildBossFightLogPanelHandler, self)
        self:addViewToPool(self.mGuildBossFightLogPanel)
        self:addGuildBossViewToPool(self.mGuildBossFightLogPanel)

    end
    self.mGuildBossFightLogPanel:open(args)
end

function onDestoryGuildBossFightLogPanelHandler(self)
    self:removeViewToPool(self.mGuildBossFightLogPanel)
    self:removeGuildBossViewToPool(self.mGuildBossFightLogPanel)

    self.mGuildBossFightLogPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildBossFightLogPanelHandler, self)
    self.mGuildBossFightLogPanel = nil
end

--成员战斗信息
function onOpenGuildBossMemberFightInfoPanel(self, args)
    if self.mGuildBossMemberFightInfoPanel == nil then
        self.mGuildBossMemberFightInfoPanel = guild.GuildBossMemberFightInfoPanel.new()
        self.mGuildBossMemberFightInfoPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildBossMemberFightInfoPanelHandler, self)
        self:addViewToPool(self.mGuildBossMemberFightInfoPanel)
        self:addGuildBossViewToPool(self.mGuildBossMemberFightInfoPanel)

    end
    self.mGuildBossMemberFightInfoPanel:open(args)
end

function onDestoryGuildBossMemberFightInfoPanelHandler(self)
    self:removeViewToPool(self.mGuildBossMemberFightInfoPanel)
    self:removeGuildBossViewToPool(self.mGuildBossMemberFightInfoPanel)

    self.mGuildBossMemberFightInfoPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildBossMemberFightInfoPanelHandler, self)
    self.mGuildBossMemberFightInfoPanel = nil
end

--伤害记录
function onOpenGuildBossDamageLogPanel(self, args)
    if self.mGuildBossDamageLogPanel == nil then
        self.mGuildBossDamageLogPanel = guild.GuildBossDamageLogPanel.new()
        self.mGuildBossDamageLogPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildBossDamageLogPanelHandler, self)
        self:addViewToPool(self.mGuildBossDamageLogPanel)
        self:addGuildBossViewToPool(self.mGuildBossDamageLogPanel)

    end
    self.mGuildBossDamageLogPanel:open(args)
end

function onDestoryGuildBossDamageLogPanelHandler(self)
    self:removeViewToPool(self.mGuildBossDamageLogPanel)
    self:removeGuildBossViewToPool(self.mGuildBossDamageLogPanel)

    self.mGuildBossDamageLogPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildBossDamageLogPanelHandler, self)
    self.mGuildBossDamageLogPanel = nil
end

--副本信息
function onOpenGuildBossInfoPanel(self, args)
    if self.mGuildBossInfoPanel == nil then
        self.mGuildBossInfoPanel = guild.GuildBossInfoPanel.new()
        self.mGuildBossInfoPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildBossInfoPanelHandler, self)
        self:addViewToPool(self.mGuildBossInfoPanel)
        self:addGuildBossViewToPool(self.mGuildBossInfoPanel)

    end
    self.mGuildBossInfoPanel:open(args)
end

function onDestoryGuildBossInfoPanelHandler(self)
    self:removeViewToPool(self.mGuildBossInfoPanel)
    self:removeGuildBossViewToPool(self.mGuildBossInfoPanel)

    self.mGuildBossInfoPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildBossInfoPanelHandler, self)
    self.mGuildBossInfoPanel = nil
end

--结算
function onOpenGuildBossResultView(self, args)
    if self.mGuildBossResultView == nil then
        self.mGuildBossResultView = guild.GuildBossResultView.new()
        self.mGuildBossResultView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildBossResultViewHandler, self)
        self:addViewToPool(self.mGuildBossResultView)
        self:addGuildBossViewToPool(self.mGuildBossResultView)

    end
    self.mGuildBossResultView:open(args)
end

function onDestoryGuildBossResultViewHandler(self)
    self:removeViewToPool(self.mGuildBossResultView)
    self:removeGuildBossViewToPool(self.mGuildBossResultView)

    self.mGuildBossResultView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildBossResultViewHandler, self)
    self.mGuildBossResultView = nil
end

--------------公会Boss界面End

--------------公会围剿
function onCanOpenGuildSweep(self,args)
    local selectLv = guild.GuildManager:getGuildSweepNowLevel()
    local isOpen = guild.GuildManager:getGuildSweepState() == 0
    if isOpen then
        if selectLv > 0 then
            GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_SWEEP_MAIN_PANEL)
        else
            GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_SWEEP_LEVEL_SELECT_PANEL)
        end
    else
        gs.Message.Show(_TT(100013))
    end
end


function onOpenGuildSweepMainPanel(self,args)
    if self.mGuildSweepPanel == nil then
        self.mGuildSweepPanel = guild.GuildSweepMainPanel.new()
        self.mGuildSweepPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildSweepMainPanelHandler,self)
        self:addViewToPool(self.mGuildSweepPanel)
        self:addGuildSweepViewToPool(self.mGuildSweepPanel)
    end
    self.mGuildSweepPanel:open(args)
end

function onDestoryGuildSweepMainPanelHandler(self)
    self:removeViewToPool(self.mGuildSweepPanel)
    self:removeGuildSweepViewToPool(self.mGuildSweepPanel)
    self.mGuildSweepPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildSweepMainPanelHandler,self)
    self.mGuildSweepPanel = nil
end

function onOpenGuildSweepLevelSelectPanel(self,args)
    if self.mGuildSweepLevelSelectPanel == nil then
        self.mGuildSweepLevelSelectPanel = guild.GuildSweepLevelSelectPanel.new()
        self.mGuildSweepLevelSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildSweepLevelSelectPanelHandler,self)
        self:addViewToPool(self.mGuildSweepLevelSelectPanel)
        self:addGuildSweepViewToPool(self.mGuildSweepLevelSelectPanel)
    end
    self.mGuildSweepLevelSelectPanel:open(args)
end

function onDestoryGuildSweepLevelSelectPanelHandler(self)
    self:removeViewToPool(self.mGuildSweepLevelSelectPanel)
    self:removeGuildSweepViewToPool(self.mGuildSweepLevelSelectPanel)
    self.mGuildSweepLevelSelectPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildSweepLevelSelectPanelHandler,self)
    self.mGuildSweepLevelSelectPanel = nil
end


function onOpenGuildSweepBossPanel(self,args)
    if self.mGuildSweepBossPanel == nil then
        self.mGuildSweepBossPanel = guild.GuildSweepBossPanel.new()
        self.mGuildSweepBossPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildSweepBossPanelHandler,self)
        self:addViewToPool(self.mGuildSweepBossPanel)
        self:addGuildSweepViewToPool(self.mGuildSweepBossPanel)
    end
    self.mGuildSweepBossPanel:open(args)
end

function onDestoryGuildSweepBossPanelHandler(self)
    self:removeViewToPool(self.mGuildSweepBossPanel)
    self:removeGuildSweepViewToPool(self.mGuildSweepBossPanel)
    self.mGuildSweepBossPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildSweepBossPanelHandler,self)
    self.mGuildSweepBossPanel = nil
end

function onOpenGuildSweepLogPanel(self,args)
    if self.mGuildSweepLogPanel == nil then
        self.mGuildSweepLogPanel = guild.GuildSweepLogPanel.new()
        self.mGuildSweepLogPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildSweepLogPanel, self)
        self:addViewToPool(self.mGuildSweepLogPanel)
        self:addGuildSweepViewToPool(self.mGuildSweepLogPanel)
    end
    self.mGuildSweepLogPanel:open(args)
end

function onDestoryGuildSweepLogPanel(self)
    self:removeViewToPool(self.mGuildSweepLogPanel)
    self:removeGuildSweepViewToPool(self.mGuildSweepLogPanel)

    self.mGuildSweepLogPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildSweepLogPanel, self)
    self.mGuildSweepLogPanel = nil
end

--结算
function onOpenGuildSweepResultView(self, args)
    if self.mGuildSweepResultView == nil then
        self.mGuildSweepResultView = guild.GuildSweepResultView.new()
        self.mGuildSweepResultView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildSweepResultViewHandler, self)
        self:addViewToPool(self.mGuildSweepResultView)
        self:addGuildSweepViewToPool(self.mGuildSweepResultView)

    end
    self.mGuildSweepResultView:open(args)
end

function onDestoryGuildSweepResultViewHandler(self)
    self:removeViewToPool(self.mGuildSweepResultView)
    self:removeGuildSweepViewToPool(self.mGuildSweepResultView)

    self.mGuildSweepResultView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildSweepResultViewHandler, self)
    self.mGuildSweepResultView = nil
end




return _M
