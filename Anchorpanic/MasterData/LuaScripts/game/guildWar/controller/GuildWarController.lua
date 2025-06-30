module("guildWar.GuildWarController", Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_GUILD_WAR_MAIN_PANEL, self.onOpenGuildWarMainPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_GUILD_WAR_CHILD_PANEL, self.onOpenGuildWarChildPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_GUILD_WAR_PLAYER_INFO,self.onOpenGuildWarPlayerInfoPanel,self)
    GameDispatcher:addEventListener(EventName.OPEN_GUILD_WAR_RESULT_PANEL,self.onOpenGuildWarResultPanel,self)
    GameDispatcher:addEventListener(EventName.OPEN_GUILD_WAR_MEMBER_PANEL,self.onOpenGuildWarMemberPanel,self)
    GameDispatcher:addEventListener(EventName.OPEN_GUILD_WAR_ALL_LOG_PANEL,self.onOpenGuildWarLogPanel,self)
    GameDispatcher:addEventListener(EventName.OPEN_GUILD_WAR_GUILD_LOG_PANEL,self.onOpenGuildWarGuildLogPanel,self)
    GameDispatcher:addEventListener(EventName.OPEN_GUILD_WAR_RANK_PANEL,self.onOpenGuildWarRankPanel,self)

    GameDispatcher:addEventListener(EventName.OPEN_GUILD_WAR_CURRENT_DAY_LOG_PANEL,self.onOpenGuildWarCurrentDayLogPanel,self)
    GameDispatcher:addEventListener(EventName.OPEN_GUILD_WAR_FIGHT_INFO_PANEL,self.onOpenGuildWarFightInfoPanel,self)
    
    GameDispatcher:addEventListener(EventName.OPEN_GUILD_WAR_FIGHT_RESULT_INFO_PANEL,self.onOpenGuildWarFightResultPanel,self)

    GameDispatcher:addEventListener(EventName.REQ_GUILD_WAR_ENEMY_PANEL,self.onReqGuildWarEnemy,self)
    GameDispatcher:addEventListener(EventName.REQ_GUILD_WAR_SINGUP,self.onReqGuildWarSignUp,self)
    GameDispatcher:addEventListener(EventName.REQ_GUILD_WAR_PLAYER_INFO,self.onReqGuildWarDefFormation,self)
    GameDispatcher:addEventListener(EventName.REQ_GUILD_WAR_BATTLE_LOG,self.onReqGuildBattleLog,self)
    GameDispatcher:addEventListener(EventName.REQ_GUILD_WAR_CHANGE_DEF_STATE,self.onReqGuildWarDefState,self)
    GameDispatcher:addEventListener(EventName.REQ_GUILD_WAR_GUILD_LOG,self.onReqGuildWarDayLog,self)
    GameDispatcher:addEventListener(EventName.REQ_GUILD_WAR_RANK_DATA,self.onReqGuildWarRankData,self)
    GameDispatcher:addEventListener(EventName.REQ_GUILD_WAR_CURRENT_DAY_LOG,self.onReqGuildWarCurrentDayLog,self)
    GameDispatcher:addEventListener(EventName.REQ_GUILD_WAR_CURRENT_FIGHT_INFO,self.onReqGuildWarCurrentFightInfo,self)
    GameDispatcher:addEventListener(EventName.REQ_GUILD_WAR_AUTO,self.onReqGuildWarAuto,self)
    
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        -------联盟团战-------
        ----- *s2c* 展示人员情报 23045
        SC_GUILD_WAR_DEF_FORMATION = self.onGuildWarDefFormationHandler,
        --- *s2c* 联盟团战报名 23047
        SC_GUILD_WAR_SIGN_UP = self.onGuildWarSignUpHandler,
        --- *s2c* 联盟历史排行榜 23049
        SC_GUILD_WAR_RANK = self.onGuildWarRankHandler,
        --- *s2c* 联盟团战日志 23051
        SC_GUILD_WAR_DAY_LOG = self.onGuildWarDayLogHandler,
        --- *s2c* 联盟团战玩家日志 23053
        SC_GUILD_WAR_BATTLE_LOG = self.onGuildWarBattleLogHandler,
        --- *s2c* 赛季信息 23054
        SC_GUILD_WAR_SEASON_INFO = self.onGuildWarSeasonHandler,
       
        --- *s2c* 敌人公会面板信息 23057
        SC_ENEMY_GUILD_PANEL = self.onGuildWarEnemyPanelHandler,
        --- *s2c* 切换防守阵型同步状态结果 23061
        SC_GUILD_WAR_SWITCH_DEF_FORMATION_STATE = self.onGuildWarDefSwitchHandler,
        --- *s2c* 最近一次战斗日志 23065
        SC_GUILD_WAR_CURRENT_DAY_LOG = self.onGuildWarCurrentDayLogHandler,

        SC_GUILD_WAR_CHALLENGE_INFO = self.onGuildWarChallengeInfoHandler,

        SC_GUILD_WAR_AUTO_SIGN_UP = self.onGuildWarAutoSignUpHandler,
    }
    
end

--- *c2s* 展示人员情报 23044
function onReqGuildWarDefFormation(self,args)
    SOCKET_SEND(Protocol.CS_GUILD_WAR_DEF_FORMATION,{player_id = args.playerId},Protocol.SC_GUILD_WAR_DEF_FORMATION)
end

--- *c2s* 联盟团战报名 23046
function onReqGuildWarSignUp(self,args)
    SOCKET_SEND(Protocol.CS_GUILD_WAR_SIGN_UP,{sign_up_info = args.info},Protocol.SC_GUILD_WAR_SIGN_UP)
end

-- --- *c2s* 联盟历史排行榜 23048
-- function onReqGuildWarHistoryRank(self,args)
--     SOCKET_SEND(Protocol.CS_GUILD_WAR_SIGN_UP,{season_id = args.seasonId},Protocol.SC_GUILD_WAR_RANK)
-- end

--- *c2s* 联盟团战日志 23050
function onReqGuildWarDayLog(self,args)
    SOCKET_SEND(Protocol.CS_GUILD_WAR_DAY_LOG,{page = args.page},Protocol.SC_GUILD_WAR_DAY_LOG)
end

--- *c2s* 联盟团战玩家日志 23052
function onReqGuildBattleLog(self,args)
    SOCKET_SEND(Protocol.CS_GUILD_WAR_BATTLE_LOG,{build_id = args.buildId,page = args.page,is_atk = args.isAtk},Protocol.SC_GUILD_WAR_BATTLE_LOG)
end

--- *c2s* 敌人公会面板信息 23056
function onReqGuildWarEnemy(self,args)
    SOCKET_SEND(Protocol.CS_ENEMY_GUILD_PANEL,{},Protocol.SC_ENEMY_GUILD_PANEL)
end

--- *c2s* 切换防守阵型同步状态 23060
function onReqGuildWarDefState(self,args)
    SOCKET_SEND(Protocol.CS_GUILD_WAR_SWITCH_DEF_FORMATION_STATE,{},Protocol.SC_GUILD_WAR_SWITCH_DEF_FORMATION_STATE)
end

--- *c2s* 联盟历史排行榜 23048
function onReqGuildWarRankData(self,args)
    SOCKET_SEND(Protocol.CS_GUILD_WAR_HISTORY_RANK,{season_id = args.seasonId},Protocol.SC_GUILD_WAR_RANK)
end

-- *c2s* 请求当天未查看的日志
function onReqGuildWarCurrentDayLog(self,args)
    SOCKET_SEND(Protocol.CS_GUILD_WAR_CURRENT_DAY_LOG,{},Protocol.SC_GUILD_WAR_CURRENT_DAY_LOG)
end

--- *c2s* 正在被挑战的建筑信息 23058
function onReqGuildWarCurrentFightInfo(self,args)
    SOCKET_SEND(Protocol.CS_GUILD_WAR_CHALLENGE_INFO,{build_id = args.buildId},Protocol.SC_GUILD_WAR_CHALLENGE_INFO)
end

function onReqGuildWarAuto(self)
    SOCKET_SEND(Protocol.CS_GUILD_WAR_AUTO_SIGN_UP,{},Protocol.SC_GUILD_WAR_AUTO_SIGN_UP)
end

--- *s2c* 展示人员情报 23045
function onGuildWarDefFormationHandler(self,msg)
    guildWar.GuildWarManager:parseGuildWarDefFormation(msg)
end



--- *s2c* 联盟团战报名 23047
function onGuildWarSignUpHandler(self,msg)
    if msg.result == 1 then
        GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_WAR_SINGUP)
    elseif msg.result == 2 then
        gs.Message.Show(_TT(149105))
    else
        gs.Message.Show(_TT(149122))
    end
end

--- *s2c* 联盟历史排行榜 23049
function onGuildWarRankHandler(self,msg)
    guildWar.GuildWarManager:parseGuildWarRankData(msg)
end

--- *s2c* 联盟团战日志 23051
function onGuildWarDayLogHandler(self,msg)
    guildWar.GuildWarManager:parseGuildWarGuildLog(msg)
end

--- *s2c* 联盟团战玩家日志 23053
function onGuildWarBattleLogHandler(self,msg)
    guildWar.GuildWarManager:parseGuildWarBattleLog(msg)
end

--- *s2c* 赛季信息 23054
function onGuildWarSeasonHandler(self,msg)
    guildWar.GuildWarManager:parseGuildWarSeason(msg)
end

--- *s2c* 敌人公会面板信息 23057
function onGuildWarEnemyPanelHandler(self,msg)
    guildWar.GuildWarManager:parseEnemyPanel(msg)
end

--- *s2c* 切换防守阵型同步状态结果 23061
function onGuildWarDefSwitchHandler(self,msg)
    guildWar.GuildWarManager:updateGuildDefSwitch(msg.result)
end

--- *s2c* 当天的战斗历史结果 23061
function onGuildWarCurrentDayLogHandler(self,msg)
    guildWar.GuildWarManager:parseCurrentDayLog(msg)    
end

function onGuildWarChallengeInfoHandler(self,msg)
    guildWar.GuildWarManager:parseChallengeInfo(msg)
end

function onGuildWarAutoSignUpHandler(self,msg)
    if msg.result == 1 then
        GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_WAR_AUTO)
    elseif msg.result == 2 then
        gs.Message.Show(_TT(149123))
    elseif msg.result == 3 then
        gs.Message.Show(_TT(149124))
    end
end

function addGuildWarViewToPool(self,cusView)
    table.insert(self.mMgr.mGuildWarViewList,cusView)
end

function removeGuildWarViewToPool(self,cusView)
    table.removebyvalue(self.mMgr.mGuildWarViewList, cusView)
end


function onOpenGuildWarMainPanel(self,args)
    if self.mGuildWarMainPanel == nil then
        self.mGuildWarMainPanel = guildWar.GuildWarMainPanel.new()
        self.mGuildWarMainPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildWarMainPanel,self)
        --self:addGuildWarViewToPool(self.mGuildWarMainPanel)
    end
    self.mGuildWarMainPanel:open(args)
end

function onDestoryGuildWarMainPanel(self)
    --self:removeGuildWarViewToPool(self.mGuildWarMainPanel)
    self.mGuildWarMainPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildWarMainPanel,self)
    self.mGuildWarMainPanel = nil
end


function onOpenGuildWarChildPanel(self,args)
    if self.mGuildWarChildPanel == nil then
        self.mGuildWarChildPanel = guildWar.GuildWarChildPanel.new()
        self.mGuildWarChildPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildWarChildPanel,self)
        self:addGuildWarViewToPool(self.mGuildWarChildPanel)
    end
    self.mGuildWarChildPanel:open(args)
end

function onDestoryGuildWarChildPanel(self)
    self:removeGuildWarViewToPool(self.mGuildWarChildPanel)
    self.mGuildWarChildPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildWarChildPanel,self)
    self.mGuildWarChildPanel = nil
end

function onOpenGuildWarPlayerInfoPanel(self,args)
    if self.mGuildWarInfoPanel == nil then
        self.mGuildWarInfoPanel = guildWar.GuildWarInfoPanel.new()
        self.mGuildWarInfoPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildWarPlayerInfoPanel,self)
        self:addGuildWarViewToPool(self.mGuildWarInfoPanel)
    end
    self.mGuildWarInfoPanel:open(args)
end

function onDestoryGuildWarPlayerInfoPanel(self)
    self:removeGuildWarViewToPool(self.mGuildWarInfoPanel)
    self.mGuildWarInfoPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildWarPlayerInfoPanel,self)
    self.mGuildWarInfoPanel = nil
end

function onOpenGuildWarResultPanel(self,args)
    if self.mGuildWarResultPanel == nil then
        self.mGuildWarResultPanel = guildWar.GuildWarResultPanel.new()
        self.mGuildWarResultPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildWarResultPanel,self)
        self:addGuildWarViewToPool(self.mGuildWarResultPanel)
    end
    self.mGuildWarResultPanel:open(args)
end


function onDestoryGuildWarResultPanel(self)
    self:removeGuildWarViewToPool(self.mGuildWarResultPanel)
    self.mGuildWarResultPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildWarResultPanel,self)
    self.mGuildWarResultPanel = nil
end

function onOpenGuildWarMemberPanel(self,args)
    if self.mGuildWarMemberPanel == nil then
        self.mGuildWarMemberPanel = guildWar.GuildWarMemberPanel.new()
        self.mGuildWarMemberPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildWarMemberPanel,self)
        self:addGuildWarViewToPool(self.mGuildWarMemberPanel)
    end
    self.mGuildWarMemberPanel:open(args)
end

function onDestoryGuildWarMemberPanel(self)
    self:removeGuildWarViewToPool(self.mGuildWarMemberPanel)
    self.mGuildWarMemberPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildWarMemberPanel,self)
    self.mGuildWarMemberPanel = nil
end

function onOpenGuildWarLogPanel(self,args)
    if self.mGuildWarLogPanel == nil then
        self.mGuildWarLogPanel = guildWar.GuildWarLogPanel.new()
        self.mGuildWarLogPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildWarLogPanel,self)
        self:addGuildWarViewToPool(self.mGuildWarLogPanel)
    end
    self.mGuildWarLogPanel:open(args)
end

function onDestoryGuildWarLogPanel(self)
    self:removeGuildWarViewToPool(self.mGuildWarLogPanel)
    self.mGuildWarLogPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildWarLogPanel,self)
    self.mGuildWarLogPanel = nil
end

function onOpenGuildWarGuildLogPanel(self,args)
    if self.mGuildWarGuildLogPanel == nil then
        self.mGuildWarGuildLogPanel = guildWar.GuildWarGuildLogPanel.new()
        self.mGuildWarGuildLogPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildWarGuildLogPanel,self)
        self:addGuildWarViewToPool(self.mGuildWarGuildLogPanel)
    end
    self.mGuildWarGuildLogPanel:open(args)
end


function onDestoryGuildWarGuildLogPanel(self)
    self:removeGuildWarViewToPool(self.mGuildWarGuildLogPanel)
    self.mGuildWarGuildLogPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildWarGuildLogPanel,self)
    self.mGuildWarGuildLogPanel = nil
end

function onOpenGuildWarRankPanel(self,args)
    if self.mGuildWarTabPanel == nil then
        self.mGuildWarTabPanel = guildWar.GuildWarTabPanel.new()
        self.mGuildWarTabPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildWarTabPanel,self)
        self:addGuildWarViewToPool(self.mGuildWarTabPanel)
    end
    self.mGuildWarTabPanel:open(args)
end

function onDestoryGuildWarTabPanel(self)
    self:removeGuildWarViewToPool(self.mGuildWarTabPanel)
    self.mGuildWarTabPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildWarTabPanel,self)
    self.mGuildWarTabPanel = nil
end

function onOpenGuildWarCurrentDayLogPanel(self,args)
    if self.mGuildWarCurrentDayLogPanel == nil then
        self.mGuildWarCurrentDayLogPanel = guildWar.GuildWarGuildResultPanel.new()
        self.mGuildWarCurrentDayLogPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildWarCurrentDayLogPanel,self)
        self:addGuildWarViewToPool(self.mGuildWarCurrentDayLogPanel)
    end
    self.mGuildWarCurrentDayLogPanel:open(args)
end

function onDestoryGuildWarCurrentDayLogPanel(self)
    self:removeGuildWarViewToPool(self.mGuildWarCurrentDayLogPanel)
    self.mGuildWarCurrentDayLogPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildWarCurrentDayLogPanel,self)
    self.mGuildWarCurrentDayLogPanel = nil
end

function onOpenGuildWarFightInfoPanel(self,args)
    if self.mGuildWarFightInfoPanel == nil then
        self.mGuildWarFightInfoPanel = guildWar.GuildWarFightInfoPanel.new()
        self.mGuildWarFightInfoPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildWarFightInfoPanel,self)
        self:addGuildWarViewToPool(self.mGuildWarFightInfoPanel)
    end
    self.mGuildWarFightInfoPanel:open(args)
end

function onDestoryGuildWarFightInfoPanel(self)
    self:removeGuildWarViewToPool(self.mGuildWarFightInfoPanel)
    self.mGuildWarFightInfoPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildWarFightInfoPanel,self)
    self.mGuildWarFightInfoPanel = nil
end

function onOpenGuildWarFightResultPanel(self,args)
    if self.mGuildWarFightResultInfoPanel == nil then
    self.mGuildWarFightResultInfoPanel = guildWar.GuildWarFightResultInfoPanel.new()
        self.mGuildWarFightResultInfoPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildWarFightResultInfoPanel,self)
        self:addGuildWarViewToPool(self.mGuildWarFightResultInfoPanel)
    end
    self.mGuildWarFightResultInfoPanel:open(args)
end

function onDestoryGuildWarFightResultInfoPanel(self)
    self:removeGuildWarViewToPool(self.mGuildWarFightResultInfoPanel)
    self.mGuildWarFightResultInfoPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryGuildWarFightResultInfoPanel,self)
    self.mGuildWarFightResultInfoPanel = nil
end


return _M