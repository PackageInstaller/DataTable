module("area.AreaController", Class.impl(Controller))

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
    -- 打开竞技场
    GameDispatcher:addEventListener(EventName.OPEN_ARENA_PANEL, self.onOpenArenaPanelHandler, self)
    -- 赛季更新竞技场
    GameDispatcher:addEventListener(EventName.REASON_UPDATE_ARENA, self.onReasonUpdateArenaHandler, self)
    -- 打开竞技场挑战面板
    GameDispatcher:addEventListener(EventName.OPEN_ARENA_CHALLENGE_PANEL, self.onOpenArenaChallengePanelHandler, self)
    -- 打开竞技场奖励面板
    GameDispatcher:addEventListener(EventName.OPEN_ARENA_AWARD_PANEL, self.onOpenArenaAwardPanelHandler, self)
    -- 打开竞技场记录面板
    --  GameDispatcher:addEventListener(EventName.OPEN_ARENA_LOG_PANEL, self.onOpenArenaLogPanelHandler, self)
    -- 关闭竞技场记录面板
    GameDispatcher:addEventListener(EventName.CLOSE_ARENA_LOG_PANEL, self.onCloseArenaLogPanelHandler, self)
    -- 打开竞技场排行榜面板
    GameDispatcher:addEventListener(EventName.OPEN_ARENA_RANK_PANEL, self.onOpenArenaRankPanelHandler, self)
    -- 打开竞技场敌方防守信息面板
    GameDispatcher:addEventListener(EventName.OPEN_ARENA_ENEMY_DEFENSE_PANEL, self.onOpenArenaEnemyDefensePanelHandler, self)
    --打开竞技场段位面板
    GameDispatcher:addEventListener(EventName.OPEN_ARENA_DAN_PANEL, self.openArenaDanPanel, self)
    -- 请求竞技场面板内容
    GameDispatcher:addEventListener(EventName.REQ_ARENA_PANEL_INFO, self.onReqArenaInfoHandler, self)
    -- 请求刷新竞技场敌人玩家数据
    GameDispatcher:addEventListener(EventName.REQ_ARENA_ENEMY, self.onReqRefreshArenaEnemyHandler, self)
    -- 请求竞技场日志
    GameDispatcher:addEventListener(EventName.REQ_ARENA_LOG, self.onReqArenaLogHandler, self)
    -- 请求竞技场敌方防守阵容
    GameDispatcher:addEventListener(EventName.REQ_ARENA_PLAYER_DEFENSE, self.onReqArenaPlayerDefenseHandler, self)
    -- 请求竞技场排行榜
    GameDispatcher:addEventListener(EventName.REQ_ARENA_RANK, self.onReqArenaRankHandler, self)
    --- 请求竞技场是否在重置期
    GameDispatcher:addEventListener(EventName.REQ_ARENA_OK, self.onReqArenaOKHanlder, self)
    --- 请求竞技场信息
    GameDispatcher:addEventListener(EventName.REQ_ARENA_ALL_INFO, self.onReqArenaAllInfoHandler, self)
    --竞技场更新段位页面数据
    GameDispatcher:addEventListener(EventName.UPDATE_ARENA_FIGHT_INFO, self.updateFightInfo, self)
    --竞技场更新段位页面数据
    GameDispatcher:addEventListener(EventName.OPEN_ARENA_RESULT, self.onShowPreviewHanlder, self)
    -- 每日不再提示重置
    remind.RemindManager:addEventListener(remind.RemindManager.TODAY_REMIND_INIT, self.onTodayRemindUpdate, self)

    GameDispatcher:addEventListener(EventName.REQ_LOCK_DEF_STATE, self.onLockDefStateHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 竞技场面板内容 19021
        SC_ARENA_INFO = self.onResArenaHallInfoHandler,
        --- *s2c* 竞技场面板内容 19023
        SC_ARENA_PANEL = self.onResArenaInfoHandler,
        --- *s2c* 刷新对手 19027
        SC_REFRESH_ENEMY = self.onResArenaEnemyHandler,
        --- *s2c* 查看日志 19029
        SC_SHOW_ARENA_LOG = self.onResArenaLogHandler,
        --- *s2c* 查看玩家防守阵容 19031
        SC_SHOW_PLAYER_DEFEND = self.onResArenaPlayerDefenseHandler,
        --- *s2c* 查看前100名 19025
        SC_SHOW_TOP_100_PLAYER = self.onResArenaRankHandler,
        --- *s2c* 是否赛季重置期间 19033
        SC_IS_ARENA_RESET = self.onResArenaResultHandler,
        --- *s2c* 切换防守阵型同步状态结果 19035
        SC_ARENA_SWITCH_DEF_FORMATION_STATE = self.onArenaSwitchDefStateHandler,
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------
--- *s2c* 竞技场面板内容 19023
function onResArenaInfoHandler(self, msg)
    arena.ArenaManager:parseArenaPanelInfo(msg)
end

--- *s2c* 刷新对手 19027
function onResArenaEnemyHandler(self, msg)
    arena.ArenaManager:updateArenaEnemyList(msg.enemy_list)
    self:openArenaInfoPanel()
end

--- *s2c* 查看日志 19029
function onResArenaLogHandler(self, msg)
    arena.ArenaManager:updateArenaLogList(msg.arena_log_list)
    self:onOpenArenaLogPanelHandler()
end

--- *s2c* 查看玩家防守阵容 19031
function onResArenaPlayerDefenseHandler(self, msg)
    arena.ArenaManager:parsePlayerDefense(msg.enemy_info, msg.defend_formation)
end

--- *s2c* 查看前100名 19025
function onResArenaRankHandler(self, msg)
    arena.ArenaManager:parseRankList(msg.top_enemy_list)
end

-- 今日不再提示更新
function onTodayRemindUpdate(self)
    arena.ArenaManager:updateRed()
end


function onResArenaResultHandler(self, msg)
    arena.ArenaManager:updateReset(msg)
    if msg.is_reset == 1 then
        gs.Message.Show(_TT(176))
    else
        if (self.lastReqType == 1) then
            GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_PANEL)
        elseif self.lastReqType == 2 then
            GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_CHALLENGE)
        end
    end
end

-- 切换防守阵型同步状态结果
function onArenaSwitchDefStateHandler(self, msg)
    local str = msg.result == 1 and _TT(1427) or _TT(1428)
    gs.Message.Show(str)
    arena.ArenaManager.lockDefState = msg.result
end

-- *s2c* 竞技场大厅面板内容 19021
function onResArenaHallInfoHandler(self, msg)
    arena.ArenaManager:parseArenaHallPanelInfo(msg)
end

---------------------------------------------------------------请求------------------------------------------------------------------
--- *c2s* 竞技场面板内容 19022
function onReqArenaInfoHandler(self, args)
    SOCKET_SEND(Protocol.CS_ARENA_PANEL, {})
end

--- *c2s* 竞技场面板内容 19020
function onReqArenaAllInfoHandler(self)
    SOCKET_SEND(Protocol.CS_ARENA_INFO)
end

--- *c2s* 刷新对手 19026
function onReqRefreshArenaEnemyHandler(self, args)
    SOCKET_SEND(Protocol.CS_REFRESH_ENEMY, {})
end

--- *c2s* 查看日志 19028
function onReqArenaLogHandler(self, args)
    --SOCKET_SEND(Protocol.CS_SHOW_ARENA_LOG, {})
    SOCKET_SEND(Protocol.CS_SHOW_ARENA_LOG)
end

--- *c2s* 查看玩家防守阵容 19030
function onReqArenaPlayerDefenseHandler(self, args)
    SOCKET_SEND(Protocol.CS_SHOW_PLAYER_DEFEND, { player_id = args.playerId })
end

--- *c2s* 查看前100名排行榜 19024
function onReqArenaRankHandler(self, args)
    SOCKET_SEND(Protocol.CS_SHOW_TOP_100_PLAYER, {})
end

--- *c2s* 是否赛季重置期间 19032
function onReqArenaOKHanlder(self, args)
    self.lastReqType = args.type
    SOCKET_SEND(Protocol.CS_IS_ARENA_RESET, {})
end


-- 更新防守队伍锁定状态
function onLockDefStateHandler(self)
    SOCKET_SEND(Protocol.CS_ARENA_SWITCH_DEF_FORMATION_STATE)
end


--刷新竞技场战斗信息  是否弹出段位提升界面
function updateFightInfo(self, args)
    arena.ArenaManager:updateFightInfo(args)
end

------------------------------------------------------------------------ 打开竞技场 ------------------------------------------------------------------------
function onOpenArenaPanelHandler(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_PVP_ARENA, true) == false then
        return
    end

    -- 不再提醒红点，仅提醒一次
    GameDispatcher:dispatchEvent(EventName.REQ_ADD_NOT_REMIND, { moduleId = RemindConst.ARENA_REDPOINT_TIPS })
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_PVP, false, funcopen.FuncOpenConst.FUNC_ID_PVP_ARENA)

    if self.mArenaPanel == nil then
        self.mArenaPanel = arena.ArenaPanel.new()
        self.mArenaPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaPanelHandler, self)
        self:addViewToPool(self.mArenaPanel)
    end
    self.mArenaPanel:open()
end

function onDestroyArenaPanelHandler(self)
    self:removeViewToPool(self.mArenaPanel)
    self.mArenaPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaPanelHandler, self)
    self.mArenaPanel = nil
end

function onReasonUpdateArenaHandler(self, args)
    self:closeAllArenaPanel()
    --gs.PopPanelManager.CloseAll()
    gs.Message.Show(_TT(177))
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
    self.mMgr.mViewList = {}
end

------------------------------------------------------------------------ 打开竞技场挑战面板 ------------------------------------------------------------------------
function onOpenArenaChallengePanelHandler(self, args)
    if self.mArenaChallengePanel == nil then
        self.mArenaChallengePanel = arena.ArenaChallengePanel.new()
        self.mArenaChallengePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaChallengePanelHandler, self)
        self:addViewToPool(self.mArenaChallengePanel)
    end
    self.mArenaChallengePanel:open()


end

function onDestroyArenaChallengePanelHandler(self)
    self:removeViewToPool(self.mArenaChallengePanel)
    self.mArenaChallengePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaChallengePanelHandler, self)
    self.mArenaChallengePanel = nil
end

------------------------------------------------------------------------ 打开竞技场奖励面板 ------------------------------------------------------------------------
function onOpenArenaAwardPanelHandler(self, args)

    if not args then
        args = {}
    end
    if not args.type then
        args.type = arena.ArenaAwardType.SEASON -- 页签索引
    end

    if self.mArenaAwardPanel == nil then
        self.mArenaAwardPanel = arena.ArenaAwardPanel.new()
        self.mArenaAwardPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaAwardPanelHandler, self)
        self:addViewToPool(self.mArenaAwardPanel)
    end
    self.mArenaAwardPanel:open(args)
end

function onDestroyArenaAwardPanelHandler(self)
    self:removeViewToPool(self.mArenaAwardPanel)
    self.mArenaAwardPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaAwardPanelHandler, self)
    self.mArenaAwardPanel = nil
end

------------------------------------------------------------------------ 打开竞技场记录面板 ------------------------------------------------------------------------
function onOpenArenaLogPanelHandler(self, args)
    if self.mArenaLogPanel == nil then
        self.mArenaLogPanel = arena.ArenaLogPanel.new()
        self.mArenaLogPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaLogPanelHandler, self)
        self:addViewToPool(self.mArenaLogPanel)
    end
    self.mArenaLogPanel:open()
end

function onCloseArenaLogPanelHandler(self)
    if self.mArenaLogPanel ~= nil then
        self.mArenaLogPanel:close()
    end
end

function onDestroyArenaLogPanelHandler(self)
    self:removeViewToPool(self.mArenaLogPanel)
    self.mArenaLogPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaLogPanelHandler, self)
    self.mArenaLogPanel = nil
end

------------------------------------------------------------------------ 打开竞技场排行榜面板 ------------------------------------------------------------------------
function onOpenArenaRankPanelHandler(self, args)
    if self.mArenaRankPanel == nil then
        self.mArenaRankPanel = arena.ArenaRankPanel.new()
        self.mArenaRankPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaRankPanelHandler, self)
        self:addViewToPool(self.mArenaRankPanel)
    end
    self.mArenaRankPanel:open()
end

function onDestroyArenaRankPanelHandler(self)
    self:removeViewToPool(self.mArenaRankPanel)
    self.mArenaRankPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaRankPanelHandler, self)
    self.mArenaRankPanel = nil
end

------------------------------------------------------------------------ 打开竞技场敌方防守信息面板 ------------------------------------------------------------------------
function onOpenArenaEnemyDefensePanelHandler(self, args)
    if self.mArenaEnemyDefensePanel == nil then
        self.mArenaEnemyDefensePanel = arena.ArenaEnemyDefensePanel.new()
        self.mArenaEnemyDefensePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaEnemyDefensePanelHandler, self)
        self:addViewToPool(self.mArenaEnemyDefensePanel)
    end
    self.mArenaEnemyDefensePanel:open()
    self.mArenaEnemyDefensePanel:setData(args.playerId)
end

function onDestroyArenaEnemyDefensePanelHandler(self)
    self:removeViewToPool(self.mArenaEnemyDefensePanel)
    self.mArenaEnemyDefensePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaEnemyDefensePanelHandler, self)
    self.mArenaEnemyDefensePanel = nil
end
------------------------------------------------------------------------ 打开竞技场对战信息面板 ------------------------------------------------------------------------
function openArenaInfoPanel(self)
    if self.mArenaPanel and self.mArenaPanel.isPop then
        self.mArenaPanel:close()
    end

    if self.mArenaInfoPanel == nil then
        self.mArenaInfoPanel = arena.ArenaInfoPanel.new()
        self.mArenaInfoPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaInfoPanelHandler, self)
        self:addViewToPool(self.mArenaInfoPanel)
    end
    self.mArenaInfoPanel:open()

end

function onDestroyArenaInfoPanelHandler(self)
    self:removeViewToPool(self.mArenaInfoPanel)
    self.mArenaInfoPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaInfoPanelHandler, self)
    self.mArenaInfoPanel = nil
end
------------------------------------------------------------------------ 打开竞技场段位面板 ------------------------------------------------------------------------
function openArenaDanPanel(self, args)
    if self.mArenaDanPanel == nil then
        self.mArenaDanPanel = arena.ArenaSettlementView.new()
        self.mArenaDanPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaDanPanelHandler, self)
        self:addViewToPool(self.mArenaDanPanel)
    end
    self.mArenaDanPanel:open(args)
end

function onDestroyArenaDanPanelHandler(self)
    self:removeViewToPool(self.mArenaDanPanel)
    self.mArenaDanPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyArenaDanPanelHandler, self)
    self.mArenaDanPanel = nil
end


function onShowPreviewHanlder(self, args)
    if self.mPreview == nil then
        self.mPreview = arena.ArenaResultDataPanel.new()
        self.mPreview:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPreview, self)
        self:addViewToPool(self.mPreview)
    end
    self.mPreview:open(args)
end

function onDestroyPreview(self)
    self:removeViewToPool(self.mPreview)
    self.mPreview:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPreview, self)
    self.mPreview = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]