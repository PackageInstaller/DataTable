module("ghost.GhostController", Class.impl(Controller))
-- 构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

-- 析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

-- 游戏开始的回调
function gameStartCallBack(self)

end

-- 模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_GHOST_GAME_PANEL, self.onOpenGhostGamePanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_GHOST_GAME_PANEL, self.onCloseGhostGamePanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_GHOST_STAGEMAIN_UI, self.onOpenGhostStageMainUI, self)
    GameDispatcher:addEventListener(EventName.OPEN_GHOST_STAR_REWARD_PANEL, self.onOpenGhostStarRewardPanel,
        self)

    GameDispatcher:addEventListener(EventName.OPEN_GHOST_DUP_PANEL, self.onOpenGhostDupPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_GHOST_DUP_PANEL, self.onCloseGhostDupPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_GHOST_SETTLE_PANEL, self.onOpenGhostSettlePanel, self)

    GameDispatcher:addEventListener(EventName.REQ_GHOST_PASS_DUP, self.onReqGhostPassDupHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_GHOST_RECEIVE_STAR, self.onReqGhostReceiveHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_GHOST_TIPS_VIEW, self.onGhostTipsViewHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_GHOST_TASK_PANEL, self.onGhostTaskViewHandler, self)

    GameDispatcher:addEventListener(EventName.REQ_GHOST_TASK_RECEIVE, self.onReqGhostTaskHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_GHOST_RANK_PANEL, self.onOpenGhostRankPanel, self)

    GameDispatcher:addEventListener(EventName.REQ_GHOST_EVENT, self.onReqGhostEventHandler, self)
    
end

-- 注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_GHOST_PANEL = self.onGhostPanelHandler,
        SC_UPDATE_GHOST_INFO = self.onGhostPassDupHandler,
        SC_GHOST_TASK_GAIN_RETURN = self.onGhostTaskGainHandler,
        SC_GHOST_TASK_UPDATE = self.onGhostTaskUpdateHandler,
    }
end

function onGhostPanelHandler(self, msg)
    ghost.GhostManager:parseGhostPanelData(msg)
end

function onGhostPassDupHandler(self, msg)
    ghost.GhostManager:parseGhostPassDupData(msg.dup_info)
end

function onGhostTaskGainHandler(self, msg)
    if msg.result == 1 then
        ghost.GhostManager:updateGhostTaskData(msg)
    end
end

function onGhostTaskUpdateHandler(self,msg)
    ghost.GhostManager:updateGhostTaskDataCount(msg)
end

function onReqGhostPassDupHandler(self, args)
    SOCKET_SEND(Protocol.CS_PASS_GHOST, {
        dup_id = args.dupId,
        point = args.point
    }, Protocol.SC_UPDATE_GHOST_INFO)
end

function onReqGhostReceiveHandler(self, list)
    SOCKET_SEND(Protocol.CS_GHOST_RECEIVE_STAR, {
        star_reward_id = list
    })
end

function onReqGhostTaskHandler(self, args)
    SOCKET_SEND(Protocol.CS_GHOST_TASK_GAIN, {
        task_id_list = args.taskId
    }, Protocol.SC_GHOST_TASK_GAIN_RETURN)
end

function onReqGhostEventHandler(self,args)
    SOCKET_SEND(Protocol.CS_GHOST_EVENT,{event_id = args})
end

function onOpenGhostGamePanel(self, args)
    -- GM
    -- GameDispatcher:dispatchEvent(EventName.OPEN_GHOST_GAME_PANEL)
    if self.mGhostGamePanel == nil then
        self.mGhostGamePanel = ghost.GhostGamePanel.new()
        self.mGhostGamePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGhostGamePanel, self)
    end
    self.mGhostGamePanel:open(args)
end

function onDestoryGhostGamePanel(self)
    self.mGhostGamePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGhostGamePanel, self)
    self.mGhostGamePanel = nil
end

function onCloseGhostGamePanel(self)
    if self.mGhostGamePanel ~= nil then
        self.mGhostGamePanel:close()
    end
end

function onOpenGhostStageMainUI(self, args)
    if self.mGhostStageMainUI == nil then
        self.mGhostStageMainUI = ghost.GhostStageMainUI.new()
        self.mGhostStageMainUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyGhostStageMainUI, self)
    end
    self.mGhostStageMainUI:open(args)
end

-- ui销毁
function onDestroyGhostStageMainUI(self)
    self.mGhostStageMainUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyGhostStageMainUI, self)
    self.mGhostStageMainUI = nil
end

function onOpenGhostStarRewardPanel(self, args)
    if self.mGhostStarRewardPanel == nil then
        self.mGhostStarRewardPanel = ghost.GhostStarAwardView.new()
        self.mGhostStarRewardPanel:addEventListener(View.EVENT_VIEW_DESTROY,
            self.onDestroyGhostStarRewardPanel, self)
    end
    self.mGhostStarRewardPanel:open(args)
end

function onDestroyGhostStarRewardPanel(self)
    self.mGhostStarRewardPanel:removeEventListener(View.EVENT_VIEW_DESTROY,
        self.onDestroyGhostStarRewardPanel, self)
    self.mGhostStarRewardPanel = nil
end

function onOpenGhostDupPanel(self, args)
    if self.mGhostDupPanel == nil then
        self.mGhostDupPanel = ghost.GhostDupPanel.new()
        self.mGhostDupPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyGhostDupPanel, self)
    end
    self.mGhostDupPanel:open(args)
end

function onDestroyGhostDupPanel(self)
    self.mGhostDupPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyGhostDupPanel, self)
    self.mGhostDupPanel = nil
end

function onCloseGhostDupPanel(self)
    if self.mGhostDupPanel ~= nil then
        self.mGhostDupPanel:close()
    end
end

function onOpenGhostSettlePanel(self, args)
    if self.mGhostSettlePanel == nil then
        self.mGhostSettlePanel = ghost.GhostSettlePanel.new()
        self.mGhostSettlePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyGhostSettlePanel, self)
    end
    self.mGhostSettlePanel:open(args)
end

function onDestroyGhostSettlePanel(self)
    self.mGhostSettlePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyGhostSettlePanel, self)
    self.mGhostSettlePanel = nil
end

function onGhostTipsViewHandler(self, args)
    if self.mGhostTipsView == nil then
        self.mGhostTipsView = ghost.GhostTipsView.new()
        self.mGhostTipsView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyGhostTipsView, self)
    end
    self.mGhostTipsView:open(args)
end

function onDestroyGhostTipsView(self)
    self.mGhostTipsView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyGhostTipsView, self)
    self.mGhostTipsView = nil
end

function onGhostTaskViewHandler(self, args)
    if self.mGhostTaskView == nil then
        self.mGhostTaskView = ghost.GhostTaskPanel.new()
        self.mGhostTaskView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyGhostTaskView, self)
    end
    self.mGhostTaskView:open(args)
end

function onDestroyGhostTaskView(self)
    self.mGhostTaskView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyGhostTaskView, self)
    self.mGhostTaskView = nil
end

function onOpenGhostRankPanel(self, args)
    if self.mGhostRankPanel == nil then
        self.mGhostRankPanel = ghost.GhostRankPanel.new()
        self.mGhostRankPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyGhostRankPanel, self)
    end
    self.mGhostRankPanel:open(args)
end

function onDestroyGhostRankPanel(self)
    self.mGhostRankPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyGhostRankPanel, self)
    self.mGhostRankPanel = nil
end

return _M
