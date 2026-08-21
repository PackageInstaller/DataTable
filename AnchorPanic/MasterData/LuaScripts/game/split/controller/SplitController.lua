module("split.SplitController", Class.impl(Controller))
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
    GameDispatcher:addEventListener(EventName.OPEN_SPLIT_GAME_PANEL, self.onOpenSplitGamePanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_SPLIT_GAME_PANEL, self.onCloseSplitGamePanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_SPLIT_STAGEMAIN_UI, self.onOpenSplitStageMainUI, self)
    GameDispatcher:addEventListener(EventName.OPEN_SPLIT_STAR_REWARD_PANEL, self.onOpenSplitStarRewardPanel,
        self)

    GameDispatcher:addEventListener(EventName.OPEN_SPLIT_DUP_PANEL, self.onOpenSplitDupPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_SPLIT_DUP_PANEL, self.onCloseSplitDupPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_SPLIT_SETTLE_PANEL, self.onOpenSplitSettlePanel, self)

    GameDispatcher:addEventListener(EventName.REQ_SPLIT_PASS_DUP, self.onReqSplitPassDupHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_SPLIT_RECEIVE_STAR, self.onReqSplitReceiveHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_SPLIT_TIPS_VIEW, self.onSplitTipsViewHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_SPLIT_TASK_PANEL, self.onSplitTaskViewHandler, self)

    GameDispatcher:addEventListener(EventName.REQ_SPLIT_TASK_RECEIVE, self.onReqSplitTaskHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_SPLIT_RANK_PANEL, self.onOpenSplitRankPanel, self)

    GameDispatcher:addEventListener(EventName.REQ_SPLIT_EVENT, self.onReqSplitEventHandler, self)
    
end

-- 注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_DRINK_PANEL = self.onSplitPanelHandler,
        SC_UPDATE_DRINK_INFO = self.onSplitPassDupHandler,
        SC_DRINK_TASK_GAIN_RETURN = self.onSplitTaskGainHandler,
        SC_DRINK_TASK_UPDATE = self.onSplitTaskUpdateHandler,
    }
end

function onSplitPanelHandler(self, msg)
    split.SplitManager:parseSplitPanelData(msg)
end

function onSplitPassDupHandler(self, msg)
    split.SplitManager:parseSplitPassDupData(msg.dup_info)
end

function onSplitTaskGainHandler(self, msg)
    if msg.result == 1 then
        split.SplitManager:updateSplitTaskData(msg)
    end
end

function onSplitTaskUpdateHandler(self,msg)
    split.SplitManager:updateSplitTaskDataCount(msg)
end

function onReqSplitPassDupHandler(self, args)
    SOCKET_SEND(Protocol.CS_PASS_DRINK, {
        dup_id = args.dupId,
        point = args.point
    }, Protocol.SC_UPDATE_DRINK_INFO)
end

function onReqSplitReceiveHandler(self, list)
    SOCKET_SEND(Protocol.CS_DRINK_RECEIVE_STAR, {
        star_reward_id = list
    })
end

function onReqSplitTaskHandler(self, args)
    SOCKET_SEND(Protocol.CS_DRINK_TASK_GAIN, {
        task_id_list = args.taskId
    }, Protocol.SC_DRINK_TASK_GAIN_RETURN)
end

function onReqSplitEventHandler(self,msg)
    SOCKET_SEND(Protocol.CS_DRINK_EVENT)
end

function onOpenSplitGamePanel(self, args)
    -- GM
    -- GameDispatcher:dispatchEvent(EventName.OPEN_SPLIT_GAME_PANEL)
    if self.mSplitGamePanel == nil then
        self.mSplitGamePanel = split.SplitGamePanel.new()
        self.mSplitGamePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySplitGamePanel, self)
    end
    self.mSplitGamePanel:open(args)
end

function onDestorySplitGamePanel(self)
    self.mSplitGamePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySplitGamePanel, self)
    self.mSplitGamePanel = nil
end

function onCloseSplitGamePanel(self)
    if self.mSplitGamePanel ~= nil then
        self.mSplitGamePanel:close()
    end
end

function onOpenSplitStageMainUI(self, args)
    if self.mSplitStageMainUI == nil then
        self.mSplitStageMainUI = split.SplitStageMainUI.new()
        self.mSplitStageMainUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySplitStageMainUI, self)
    end
    self.mSplitStageMainUI:open(args)
end

-- ui销毁
function onDestroySplitStageMainUI(self)
    self.mSplitStageMainUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySplitStageMainUI, self)
    self.mSplitStageMainUI = nil
end

function onOpenSplitStarRewardPanel(self, args)
    if self.mSplitStarRewardPanel == nil then
        self.mSplitStarRewardPanel = split.SplitStarAwardView.new()
        self.mSplitStarRewardPanel:addEventListener(View.EVENT_VIEW_DESTROY,
            self.onDestroySplitStarRewardPanel, self)
    end
    self.mSplitStarRewardPanel:open(args)
end

function onDestroySplitStarRewardPanel(self)
    self.mSplitStarRewardPanel:removeEventListener(View.EVENT_VIEW_DESTROY,
        self.onDestroySplitStarRewardPanel, self)
    self.mSplitStarRewardPanel = nil
end

function onOpenSplitDupPanel(self, args)
    if self.mSplitDupPanel == nil then
        self.mSplitDupPanel = split.SplitDupPanel.new()
        self.mSplitDupPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySplitDupPanel, self)
    end
    self.mSplitDupPanel:open(args)
end

function onDestroySplitDupPanel(self)
    self.mSplitDupPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySplitDupPanel, self)
    self.mSplitDupPanel = nil
end

function onCloseSplitDupPanel(self)
    if self.mSplitDupPanel ~= nil then
        self.mSplitDupPanel:close()
    end
end

function onOpenSplitSettlePanel(self, args)
    if self.mSplitSettlePanel == nil then
        self.mSplitSettlePanel = split.SplitSettlePanel.new()
        self.mSplitSettlePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySplitSettlePanel, self)
    end
    self.mSplitSettlePanel:open(args)
end

function onDestroySplitSettlePanel(self)
    self.mSplitSettlePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySplitSettlePanel, self)
    self.mSplitSettlePanel = nil

end

function onSplitTipsViewHandler(self, args)
    if self.mSplitTipsView == nil then
        self.mSplitTipsView = split.SplitTipsView.new()
        self.mSplitTipsView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySplitTipsView, self)
    end
    self.mSplitTipsView:open(args)
end

function onDestroySplitTipsView(self)
    self.mSplitTipsView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySplitTipsView, self)
    self.mSplitTipsView = nil
end

function onSplitTaskViewHandler(self, args)
    if self.mSplitTaskView == nil then
        self.mSplitTaskView = split.SplitTaskPanel.new()
        self.mSplitTaskView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySplitTaskView, self)
    end
    self.mSplitTaskView:open(args)
end

function onDestroySplitTaskView(self)
    self.mSplitTaskView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySplitTaskView, self)
    self.mSplitTaskView = nil
end

function onOpenSplitRankPanel(self, args)
    if self.mSplitRankPanel == nil then
        self.mSplitRankPanel = split.SplitRankPanel.new()
        self.mSplitRankPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySplitRankPanel, self)
    end
    self.mSplitRankPanel:open(args)
end

function onDestroySplitRankPanel(self)
    self.mSplitRankPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySplitRankPanel, self)
    self.mSplitRankPanel = nil
end

return _M
