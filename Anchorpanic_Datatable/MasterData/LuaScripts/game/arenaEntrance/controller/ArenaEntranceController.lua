module("arenaEntrance.ArenaEntranceController", Class.impl(Controller))

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

    self.mMgr:setLastClickRefresh(GameManager:getClientTime())
    self:onReqArenaHellPanelInfoHandle()
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_ARENA_ENTRANCE_PANEL, self.onOpenEntranceHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_ARENA_HELL_INFO, self.onReqArenaHellInfoHandle, self)
    GameDispatcher:addEventListener(EventName.REQ_ARENA_HELL_PANEL_INFO, self.onReqArenaHellPanelInfoHandle, self)
    GameDispatcher:addEventListener(EventName.REQ_ARENA_HELL_TOP_PLAYER, self.onReqArenaHellTopPlayerHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_ARENA_HELL_PLAYER_REFRESH, self.onReqArenaHellPlayerHandle, self)
    GameDispatcher:addEventListener(EventName.REQ_ARENA_HELL_LOG, self.onReqArenaHellLogHandle, self)
    GameDispatcher:addEventListener(EventName.REQ_ARENA_HELL_TIMES, self.onReqArenaHellTimesHandle, self)

    GameDispatcher:addEventListener(EventName.OPEN_ARENA_HELL_PANEL, self.onOpenAranaHellHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_ARENA_HELL_OTHER_PANEL, self.onOpenArenaHellOtherInfoPanel, self)
    --关闭敌方战员信息面板
    GameDispatcher:addEventListener(EventName.CLOSE_ARENA_HELL_OTHER_PANEL, self.onCloseArenaHellOtherInfoPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_ARENA_HELL_AWARD_PANEL, self.onOpenArenaHellAwardPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_ARENA_HELL_HIS_PANEL, self.onOpenArenaHellLogPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_ARENA_HELL_RESULT_PANEL, self.onOpenArenaHellResultPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_ARENA_HELL_RESULT_DATA_PANEL, self.onOpenArenaHellResultDataPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_ARENA_HELL_VS_VIEW, self.onOpenArenaHellVsView, self)
    GameDispatcher:addEventListener(EventName.CLOSE_ARENA_HELL_VS_VIEW, self.onCloseArenaHellVsView, self)

    GameDispatcher:addEventListener(EventName.CLOSE_ARENA_HELL_ALL_PANEL, self.closeAllArenaPanel, self)

    -- 每日不再提示重置
    remind.RemindManager:addEventListener(remind.RemindManager.TODAY_REMIND_INIT, self.onTodayRemindUpdate, self)

    -- 断线重连
    GameDispatcher:addEventListener(EventName.ACCOUNT_RELOGIN_SUC, self.onReConnect, self)
    GameDispatcher:addEventListener(EventName.REQ_LOCK_HELL_DEF_STATE, self.onLockDefStateHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_COMPETITION_INFO = self.onCompetitionInfoHandler,
        SC_COMPETITION_PANEL = self.onCompetitionPanelInfoHandler,
        SC_SHOW_TOP_COMPETITION_PLAYER = self.onCompetitionTopPlayerHandler,
        SC_REFRESH_COMPETITION_ENEMY = self.onCompetitionPlayerRefreshHandler,

        SC_SHOW_COMPETITION_LOG = self.onCompetitionLogHandler,
        SC_IS_COMPETITION_RESET = self.onUpdateResetHandler,

        SC_MULTI_TEAM_REPLAY_STATISTIC = self.onMultiRePlayStatisticHandler,
        SC_COMPETITION_BATTLE_FAIL = self.onCompetitionBattleFailHandler,
        SC_COMPETITION_SWITCH_DEF_FORMATION_STATE = self.onArenaSwitchDefStateHandler
    }
end

-- 断线重连
function onReConnect(self)
    self.mMgr:setLastClickRefresh(GameManager:getClientTime())
    self:onReqArenaHellPanelInfoHandle()
    if arenaEntrance.ArenaEntranceManager.isSkipFighting then
        -- 断线重连判断是否在跳过战斗结算前断线，重新请求结果展示
        GameDispatcher:dispatchEvent(EventName.REQ_FIGHT_OUTSIDE_SKIP_RECHECK)
    end
end

function onCompetitionInfoHandler(self, msg)
    arenaEntrance.ArenaEntranceManager:parseArenaHellInfo(msg)
end

function onCompetitionPanelInfoHandler(self, msg)
    arenaEntrance.ArenaEntranceManager:paseArenaHellPanelInfo(msg)
end

function onCompetitionTopPlayerHandler(self, msg)
    arenaEntrance.ArenaEntranceManager:paseArenaHellTopPlayer(msg)
end

function onCompetitionPlayerRefreshHandler(self, msg)
    arenaEntrance.ArenaEntranceManager:paseArenaHellPlayerRefesh(msg)
end

function onCompetitionLogHandler(self, msg)
    arenaEntrance.ArenaEntranceManager:paseArenaHellLog(msg)
end

function onUpdateResetHandler(self, msg)
    arenaEntrance.ArenaEntranceManager:updateReset(msg)
end

function onMultiRePlayStatisticHandler(self, msg)
    arenaEntrance.ArenaEntranceManager:updateReplayInfo(msg)
end

function onCompetitionBattleFailHandler(self, msg)
    arenaEntrance.ArenaEntranceManager:battleFailHandler(msg)
end

-- 切换防守阵型同步状态结果
function onArenaSwitchDefStateHandler(self, msg)
    local str = msg.result == 1 and _TT(1427) or _TT(1428)
    gs.Message.Show(str)
    arenaEntrance.ArenaEntranceManager.lockDefState = msg.result
end

-----===========================================================-----

-- 更新防守队伍锁定状态
function onLockDefStateHandler(self)
    SOCKET_SEND(Protocol.CS_COMPETITION_SWITCH_DEF_FORMATION_STATE)
end

function onReqArenaHellInfoHandle(self)
    SOCKET_SEND(Protocol.CS_COMPETITION_INFO)
end

function onReqArenaHellPanelInfoHandle(self)
    SOCKET_SEND(Protocol.CS_COMPETITION_PANEL)
end

function onReqArenaHellTopPlayerHandler(self)
    SOCKET_SEND(Protocol.CS_SHOW_TOP_COMPETITION_PLAYER)
end

function onReqArenaHellPlayerHandle(self)
    SOCKET_SEND(Protocol.CS_REFRESH_COMPETITION_ENEMY)
end

function onReqArenaHellLogHandle(self)
    SOCKET_SEND(Protocol.CS_SHOW_COMPETITION_LOG)
end

function onReqArenaHellTimesHandle(self)
    SOCKET_SEND(Protocol.CS_COMPETITION_BUY_TIMES, { times = 1 })
end

-- 今日不再提示更新
function onTodayRemindUpdate(self)
    arenaEntrance.ArenaEntranceManager:updateRed()
end

function addViewToPool(self, cusView)
    table.insert(self.mMgr.mViewList, cusView)
end

function removeViewToPool(self, cusView)
    table.removebyvalue(self.mMgr.mViewList, cusView)
end

function closeAllArenaPanel(self)
    for i = 1, #self.mMgr.mViewList do
        self.mMgr.mViewList[i]:close()
    end
    -- if self.mAranaHellOtherInfoPanel then
    --     self.mAranaHellOtherInfoPanel:onClickClose()
    -- end
    self.mMgr.mViewList = {}
    --GameDispatcher:dispatchEvent(EventName.CLOSE_ARENA_HELL_OTHER_PANEL)
end

function onOpenEntranceHandler(self, args)
    if self.mArenaEntrancePanel == nil then
        self.mArenaEntrancePanel = arenaEntrance.ArenaEntrancePanel.new()
        self.mArenaEntrancePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaEntranceHandler, self)
    end
    self.mArenaEntrancePanel:open(args)
end

function onDestroyArenaEntranceHandler(self)
    self.mArenaEntrancePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyAreanEntranceHandler, self)
    self.mArenaEntrancePanel = nil
end

function onOpenAranaHellHandler(self, args)
    -- 不再提醒红点，仅提醒一次
    GameDispatcher:dispatchEvent(EventName.REQ_ADD_NOT_REMIND, { moduleId = RemindConst.ARENA_HELL_REDPOINT_TIPS })
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_PVP, false, funcopen.FuncOpenConst.FUNC_ID_PVP_ARENA_HELL)

    if self.mArenaHellPanel == nil then
        self.mArenaHellPanel = arenaEntrance.ArenaHellPanel.new()
        self.mArenaHellPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaHellHandler, self)
        self:addViewToPool(self.mArenaHellPanel)
    end
    self.mArenaHellPanel:open(args)
end

function onDestroyArenaHellHandler(self)
    self:removeViewToPool(self.mArenaHellPanel)
    self.mArenaHellPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaHellHandler, self)
    self.mArenaHellPanel = nil
end

function onOpenArenaHellOtherInfoPanel(self, args)
    if self.mAranaHellOtherInfoPanel == nil then
        self.mAranaHellOtherInfoPanel = arenaEntrance.ArenaOtheInfoPanel.new()
        self.mAranaHellOtherInfoPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaHellOtherInfoHandler, self)
        self:addViewToPool(self.mAranaHellOtherInfoPanel)
    end
    self.mAranaHellOtherInfoPanel:open(args)
end

function onDestroyArenaHellOtherInfoHandler(self)
    self:removeViewToPool(self.mAranaHellOtherInfoPanel)
    self.mAranaHellOtherInfoPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaHellOtherInfoHandler, self)
    self.mAranaHellOtherInfoPanel = nil
end

function onCloseArenaHellOtherInfoPanel(self)
    if self.mAranaHellOtherInfoPanel and self.mAranaHellOtherInfoPanel.isPop then
        self.mAranaHellOtherInfoPanel:close()
    end
end



function onOpenArenaHellAwardPanel(self, args)
    if not args then
        args = {}
    end
    if not args.type then
        args.type = arenaEntrance.ArenaEntaceAwadType.SEASON_RANK -- 页签索引
    end

    if self.mAranaHellAwardPanel == nil then
        self.mAranaHellAwardPanel = arenaEntrance.ArenaHellAwardPanel.new()
        self.mAranaHellAwardPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaHellAwardHandler, self)
        self:addViewToPool(self.mAranaHellAwardPanel)
    end
    self.mAranaHellAwardPanel:open(args)
end

function onDestroyArenaHellAwardHandler(self)
    self:removeViewToPool(self.mAranaHellAwardPanel)
    self.mAranaHellAwardPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaHellAwardHandler, self)
    self.mAranaHellAwardPanel = nil
end


function onOpenArenaHellLogPanel(self, args)
    if not args then
        args = {}
    end
    if not args.type then
        args.type = arenaEntrance.ArenaEntaceLogType.TypeAttack
    end

    if self.mArenaHellLogPanel == nil then
        self.mArenaHellLogPanel = arenaEntrance.ArenaHellLogPanel.new()
        self.mArenaHellLogPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaHellLogHandler, self)
        self:addViewToPool(self.mArenaHellLogPanel)
    end
    self.mArenaHellLogPanel:open(args)
end

function onDestroyArenaHellLogHandler(self)
    self:removeViewToPool(self.mArenaHellLogPanel)
    self.mArenaHellLogPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaHellLogHandler, self)
    self.mArenaHellLogPanel = nil
end

function onOpenArenaHellResultPanel(self, args)
    if not args then
        args = {}
    end
    if not args.state then
        args.state = arenaEntrance.ResultState.WIN
    end

    if self.mResultPanel == nil then
        self.mResultPanel = arenaEntrance.ArenaHellResultPanel.new()
        self.mResultPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaResultHandler, self)
    end
    self.mResultPanel:open(args)
end

function onDestroyArenaResultHandler(self)
    self.mResultPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaResultHandler, self)
    self.mResultPanel = nil
end

function onOpenArenaHellResultDataPanel(self, args)
    if self.mResultDataPanel == nil then
        self.mResultDataPanel = arenaEntrance.ArenaHellResultDataPanel.new()
        self.mResultDataPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaResultDataHandler, self)
    end
    self.mResultDataPanel:open(args)
end

function onDestroyArenaResultDataHandler(self)
    self.mResultDataPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaResultDataHandler, self)
    self.mResultDataPanel = nil
end

-- 加载过程的vs显示
function onOpenArenaHellVsView(self, args)
    if self.mArenaHellVsView == nil then
        self.mArenaHellVsView = arenaEntrance.ArenaHellVsView.new()
        self.mArenaHellVsView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaHellVsViewHandler, self)
    end
    self.mArenaHellVsView:open(args)
end

function onCloseArenaHellVsView(self)
    if self.mArenaHellVsView and self.mArenaHellVsView.isPop then
        self.mArenaHellVsView:close()
    end
end

function onDestroyArenaHellVsViewHandler(self)
    self.mArenaHellVsView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaHellVsViewHandler, self)
    self.mArenaHellVsView = nil
end


return _M