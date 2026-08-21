module("dessert.DessertController", Class.impl(Controller))
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
    GameDispatcher:addEventListener(EventName.OPEN_DESSERT_GAME_PANEL, self.onOpenDessertGamePanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_DESSERT_GAME_PANEL, self.onCloseDessertGamePanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_DESSERT_STAGEMAIN_UI, self.onOpenDessertStageMainUI, self)
    GameDispatcher:addEventListener(EventName.OPEN_DESSERT_STAR_REWARD_PANEL, self.onOpenDessertStarRewardPanel,
        self)

    GameDispatcher:addEventListener(EventName.OPEN_DESSERT_DUP_PANEL, self.onOpenDessertDupPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_DESSERT_DUP_PANEL, self.onCloseDessertDupPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_DESSERT_SETTLE_PANEL, self.onOpenDessertSettlePanel, self)

    GameDispatcher:addEventListener(EventName.REQ_DESSERT_PASS_DUP, self.onReqDessertPassDupHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_DESSERT_RECEIVE_STAR, self.onReqDessertReceiveHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_DESSERT_TIPS_VIEW, self.onDessertTipsViewHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_DESSERT_TASK_PANEL, self.onDessertTaskViewHandler, self)

    GameDispatcher:addEventListener(EventName.REQ_DESSERT_TASK_RECEIVE, self.onReqDessertTaskHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_DESSERT_RANK_PANEL, self.onOpenDessertRankPanel, self)

    GameDispatcher:addEventListener(EventName.REQ_DESSERT_EVENT, self.onReqDessertEventHandler, self)
    
end

-- 注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_DESSERT_PANEL = self.onDessertPanelHandler,
        SC_UPDATE_DESSERT_INFO = self.onDessertPassDupHandler,
        SC_DESSERT_TASK_GAIN_RETURN = self.onDessertTaskGainHandler,
        SC_DESSERT_TASK_UPDATE = self.onDessertTaskUpdateHandler,
    }
end

function onDessertPanelHandler(self, msg)
    dessert.DessertManager:parseDessertPanelData(msg)
end

function onDessertPassDupHandler(self, msg)
    dessert.DessertManager:parseDessertPassDupData(msg.dup_info)
end

function onDessertTaskGainHandler(self, msg)
    if msg.result == 1 then
        dessert.DessertManager:updateDessertTaskData(msg)
    end
end

function onDessertTaskUpdateHandler(self,msg)
    dessert.DessertManager:updateDessertTaskDataCount(msg)
end

function onReqDessertPassDupHandler(self, args)
    SOCKET_SEND(Protocol.CS_PASS_DESSERT, {
        dup_id = args.dupId,
        point = args.point
    }, Protocol.SC_UPDATE_DESSERT_INFO)
end

-- function onReqDessertReceiveHandler(self, list)
--     SOCKET_SEND(Protocol.CS_DESSERT_TASK_GAIN, {
--         task_id_list = list
--     })
-- end

function onReqDessertTaskHandler(self, args)
    SOCKET_SEND(Protocol.CS_DESSERT_TASK_GAIN, {
        task_id_list = args.taskId
    }, Protocol.SC_DESSERT_TASK_GAIN_RETURN)
end

function onReqDessertEventHandler(self,args)
    SOCKET_SEND(Protocol.CS_DESSERT_EVENT,{event_id = args})
end

function onOpenDessertGamePanel(self, args)
    -- GM
    -- GameDispatcher:dispatchEvent(EventName.OPEN_DESSERT_GAME_PANEL,{dupId = 1001})
    if self.mDessertGamePanel == nil then
        self.mDessertGamePanel = dessert.DessertGamePanel.new()
        self.mDessertGamePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryDessertGamePanel, self)
    end
    self.mDessertGamePanel:open(args)
end

function onDestoryDessertGamePanel(self)
    self.mDessertGamePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryDessertGamePanel, self)
    self.mDessertGamePanel = nil
end

function onCloseDessertGamePanel(self)
    if self.mDessertGamePanel ~= nil then
        self.mDessertGamePanel:close()
    end
end

function onOpenDessertStageMainUI(self, args)
    if self.mDessertStageMainUI == nil then
        self.mDessertStageMainUI = dessert.DessertStageMainUI.new()
        self.mDessertStageMainUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDessertStageMainUI, self)
    end
    self.mDessertStageMainUI:open(args)
end

-- ui销毁
function onDestroyDessertStageMainUI(self)
    self.mDessertStageMainUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDessertStageMainUI, self)
    self.mDessertStageMainUI = nil
end

function onOpenDessertStarRewardPanel(self, args)
    if self.mDessertStarRewardPanel == nil then
        self.mDessertStarRewardPanel = dessert.DessertStarAwardView.new()
        self.mDessertStarRewardPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestroyDessertStarRewardPanel, self)
    end
    self.mDessertStarRewardPanel:open(args)
end

function onDestroyDessertStarRewardPanel(self)
    self.mDessertStarRewardPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestroyDessertStarRewardPanel, self)
    self.mDessertStarRewardPanel = nil
end

function onOpenDessertDupPanel(self, args)
    if self.mDessertDupPanel == nil then
        self.mDessertDupPanel = dessert.DessertDupPanel.new()
        self.mDessertDupPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDessertDupPanel, self)
    end
    self.mDessertDupPanel:open(args)
end

function onDestroyDessertDupPanel(self)
    self.mDessertDupPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDessertDupPanel, self)
    self.mDessertDupPanel = nil
end

function onCloseDessertDupPanel(self)
    if self.mDessertDupPanel ~= nil then
        self.mDessertDupPanel:close()
    end
end

function onOpenDessertSettlePanel(self, args)
    if self.mDessertSettlePanel == nil then
        self.mDessertSettlePanel = dessert.DessertSettlePanel.new()
        self.mDessertSettlePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDessertSettlePanel, self)
    end
    self.mDessertSettlePanel:open(args)
end

function onDestroyDessertSettlePanel(self)
    self.mDessertSettlePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDessertSettlePanel, self)
    self.mDessertSettlePanel = nil
end

function onDessertTipsViewHandler(self, args)
    if self.mDessertTipsView == nil then
        self.mDessertTipsView = dessert.DessertTipsView.new()
        self.mDessertTipsView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDessertTipsView, self)
    end
    self.mDessertTipsView:open(args)
end

function onDestroyDessertTipsView(self)
    self.mDessertTipsView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDessertTipsView, self)
    self.mDessertTipsView = nil
end

function onDessertTaskViewHandler(self, args)
    if self.mDessertTaskView == nil then
        self.mDessertTaskView = dessert.DessertTaskPanel.new()
        self.mDessertTaskView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDessertTaskView, self)
    end
    self.mDessertTaskView:open(args)
end

function onDestroyDessertTaskView(self)
    self.mDessertTaskView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDessertTaskView, self)
    self.mDessertTaskView = nil
end

function onOpenDessertRankPanel(self, args)
    if self.mDessertRankPanel == nil then
        self.mDessertRankPanel = dessert.DessertRankPanel.new()
        self.mDessertRankPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDessertRankPanel, self)
    end
    self.mDessertRankPanel:open(args)
end

function onDestroyDessertRankPanel(self)
    self.mDessertRankPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDessertRankPanel, self)
    self.mDessertRankPanel = nil
end

return _M
