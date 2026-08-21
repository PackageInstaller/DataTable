module("bulle.BulleController", Class.impl(Controller))
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
    GameDispatcher:addEventListener(EventName.OPEN_BULLE_GAME_PANEL, self.onOpenBulleGamePanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_BULLE_GAME_PANEL, self.onCloseBulleGamePanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_BULLE_STAGEMAIN_UI, self.onOpenBulleStageMainUI, self)
    GameDispatcher:addEventListener(EventName.OPEN_BULLE_STAR_REWARD_PANEL, self.onOpenBulleStarRewardPanel,
        self)

    GameDispatcher:addEventListener(EventName.OPEN_BULLE_DUP_PANEL, self.onOpenBulleDupPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_BULLE_DUP_PANEL, self.onCloseBulleDupPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_BULLE_SETTLE_PANEL, self.onOpenBulleSettlePanel, self)

    GameDispatcher:addEventListener(EventName.REQ_BULLE_PASS_DUP, self.onReqBullePassDupHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_BULLE_RECEIVE_STAR, self.onReqBulleReceiveHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_BULLE_TIPS_VIEW, self.onBulleTipsViewHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_BULLE_TASK_PANEL, self.onBulleTaskViewHandler, self)

    GameDispatcher:addEventListener(EventName.REQ_BULLE_TASK_RECEIVE, self.onReqBulleTaskHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_BULLE_RANK_PANEL, self.onOpenBulleRankPanel, self)

    GameDispatcher:addEventListener(EventName.REQ_BULLE_EVENT, self.onReqBulleEventHandler, self)
    
end

-- 注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_BULLE_PANEL = self.onBullePanelHandler,
        SC_UPDATE_BULLE_INFO = self.onBullePassDupHandler,
        SC_BULLE_TASK_GAIN_RETURN = self.onBulleTaskGainHandler,
        SC_BULLE_TASK_UPDATE = self.onBulleTaskUpdateHandler,
    }
end

function onBullePanelHandler(self, msg)
    bulle.BulleManager:parseBullePanelData(msg)
end

function onBullePassDupHandler(self, msg)
    bulle.BulleManager:parseBullePassDupData(msg.dup_info)
end

function onBulleTaskGainHandler(self, msg)
    if msg.result == 1 then
        bulle.BulleManager:updateBulleTaskData(msg)
    end
end

function onBulleTaskUpdateHandler(self,msg)
    bulle.BulleManager:updateBulleTaskDataCount(msg)
end

function onReqBullePassDupHandler(self, args)
    SOCKET_SEND(Protocol.CS_PASS_BULLE, {
        dup_id = args.dupId,
        score = tostring(args.point)
    }, Protocol.SC_UPDATE_BULLE_INFO)
end

function onReqBulleReceiveHandler(self, list)
    SOCKET_SEND(Protocol.CS_BULLE_RECEIVE_STAR, {
        star_reward_id = list
    })
end

function onReqBulleTaskHandler(self, args)
    SOCKET_SEND(Protocol.CS_BULLE_TASK_GAIN, {
        task_id_list = args.taskId
    }, Protocol.SC_BULLE_TASK_GAIN_RETURN)
end

function onReqBulleEventHandler(self,score)
    SOCKET_SEND(Protocol.CS_BULLE_SCORE,{score = tostring(score)})
end

function onOpenBulleGamePanel(self, args)
    -- GM
    -- GameDispatcher:dispatchEvent(EventName.OPEN_BULLE_GAME_PANEL)
    if self.mBulleGamePanel == nil then
        self.mBulleGamePanel = bulle.BulleGamePanel.new()
        self.mBulleGamePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryBulleGamePanel, self)
    end
    self.mBulleGamePanel:open(args)
end

function onDestoryBulleGamePanel(self)
    self.mBulleGamePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryBulleGamePanel, self)
    self.mBulleGamePanel = nil
end

function onCloseBulleGamePanel(self)
    if self.mBulleGamePanel ~= nil then
        self.mBulleGamePanel:close()
    end
end

function onOpenBulleStageMainUI(self, args)
    if self.mBulleStageMainUI == nil then
        self.mBulleStageMainUI = bulle.BulleStageMainUI.new()
        self.mBulleStageMainUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBulleStageMainUI, self)
    end
    self.mBulleStageMainUI:open(args)
end

-- ui销毁
function onDestroyBulleStageMainUI(self)
    self.mBulleStageMainUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBulleStageMainUI, self)
    self.mBulleStageMainUI = nil
end

function onOpenBulleStarRewardPanel(self, args)
    if self.mBulleStarRewardPanel == nil then
        self.mBulleStarRewardPanel = bulle.BulleStarAwardView.new()
        self.mBulleStarRewardPanel:addEventListener(View.EVENT_VIEW_DESTROY,
            self.onDestroyBulleStarRewardPanel, self)
    end
    self.mBulleStarRewardPanel:open(args)
end

function onDestroyBulleStarRewardPanel(self)
    self.mBulleStarRewardPanel:removeEventListener(View.EVENT_VIEW_DESTROY,
        self.onDestroyBulleStarRewardPanel, self)
    self.mBulleStarRewardPanel = nil
end

function onOpenBulleDupPanel(self, args)
    if self.mBulleDupPanel == nil then
        self.mBulleDupPanel = bulle.BulleDupPanel.new()
        self.mBulleDupPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBulleDupPanel, self)
    end
    self.mBulleDupPanel:open(args)
end

function onDestroyBulleDupPanel(self)
    self.mBulleDupPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBulleDupPanel, self)
    self.mBulleDupPanel = nil
end

function onCloseBulleDupPanel(self)
    if self.mBulleDupPanel ~= nil then
        self.mBulleDupPanel:close()
    end
end

function onOpenBulleSettlePanel(self, args)
    if self.mBulleSettlePanel == nil then
        self.mBulleSettlePanel = bulle.BulleSettlePanel.new()
        self.mBulleSettlePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBulleSettlePanel, self)
    end
    self.mBulleSettlePanel:open(args)
end

function onDestroyBulleSettlePanel(self)
    self.mBulleSettlePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBulleSettlePanel, self)
    self.mBulleSettlePanel = nil

end

function onBulleTipsViewHandler(self, args)
    if self.mBulleTipsView == nil then
        self.mBulleTipsView = bulle.BulleTipsView.new()
        self.mBulleTipsView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBulleTipsView, self)
    end
    self.mBulleTipsView:open(args)
end

function onDestroyBulleTipsView(self)
    self.mBulleTipsView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBulleTipsView, self)
    self.mBulleTipsView = nil
end

function onBulleTaskViewHandler(self, args)
    if self.mBulleTaskView == nil then
        self.mBulleTaskView = bulle.BulleTaskPanel.new()
        self.mBulleTaskView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBulleTaskView, self)
    end
    self.mBulleTaskView:open(args)
end

function onDestroyBulleTaskView(self)
    self.mBulleTaskView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBulleTaskView, self)
    self.mBulleTaskView = nil
end

function onOpenBulleRankPanel(self, args)
    if self.mBulleRankPanel == nil then
        self.mBulleRankPanel = bulle.BulleRankPanel.new()
        self.mBulleRankPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBulleRankPanel, self)
    end
    self.mBulleRankPanel:open(args)
end

function onDestroyBulleRankPanel(self)
    self.mBulleRankPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBulleRankPanel, self)
    self.mBulleRankPanel = nil
end

return _M
