module("bird.BirdController", Class.impl(Controller))
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
    GameDispatcher:addEventListener(EventName.OPEN_BIRD_GAME_PANEL, self.onOpenBirdGamePanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_BIRD_GAME_PANEL, self.onCloseBirdGamePanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_BIRD_STAGEMAIN_UI, self.onOpenBirdStageMainUI, self)
    GameDispatcher:addEventListener(EventName.OPEN_BIRD_STAR_REWARD_PANEL, self.onOpenBirdStarRewardPanel,
        self)

    GameDispatcher:addEventListener(EventName.OPEN_BIRD_DUP_PANEL, self.onOpenBirdDupPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_BIRD_DUP_PANEL, self.onCloseBirdDupPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_BIRD_SETTLE_PANEL, self.onOpenBirdSettlePanel, self)

    GameDispatcher:addEventListener(EventName.REQ_BIRD_PASS_DUP, self.onReqBirdPassDupHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_BIRD_RECEIVE_STAR, self.onReqBirdReceiveHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_BIRD_TIPS_VIEW, self.onBirdTipsViewHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_BIRD_TASK_PANEL, self.onBirdTaskViewHandler, self)

    GameDispatcher:addEventListener(EventName.REQ_BIRD_TASK_RECEIVE, self.onReqBirdTaskHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_BIRD_RANK_PANEL, self.onOpenBirdRankPanel, self)

    GameDispatcher:addEventListener(EventName.REQ_BIRD_EVENT, self.onReqBirdEventHandler, self)
    
end

-- 注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_BIRD_PANEL = self.onBirdPanelHandler,
        SC_UPDATE_BIRD_INFO = self.onBirdPassDupHandler,
        SC_BIRD_TASK_GAIN_RETURN = self.onBirdTaskGainHandler,
        SC_BIRD_TASK_UPDATE = self.onBirdTaskUpdateHandler,
    }
end

function onBirdPanelHandler(self, msg)
    bird.BirdManager:parseBirdPanelData(msg)
end

function onBirdPassDupHandler(self, msg)
    bird.BirdManager:parseBirdPassDupData(msg.dup_info)
end

function onBirdTaskGainHandler(self, msg)
    if msg.result == 1 then
        bird.BirdManager:updateBirdTaskData(msg)
    end
end

function onBirdTaskUpdateHandler(self,msg)
    bird.BirdManager:updateBirdTaskDataCount(msg)
end

function onReqBirdPassDupHandler(self, args)
    SOCKET_SEND(Protocol.CS_PASS_BIRD, {
        dup_id = args.dupId,
        point = args.point
    }, Protocol.SC_UPDATE_BIRD_INFO)
end

function onReqBirdReceiveHandler(self, list)
    SOCKET_SEND(Protocol.CS_BIRD_RECEIVE_STAR, {
        star_reward_id = list
    })
end

function onReqBirdTaskHandler(self, args)
    SOCKET_SEND(Protocol.CS_BIRD_TASK_GAIN, {
        task_id_list = args.taskId
    }, Protocol.SC_BIRD_TASK_GAIN_RETURN)
end

function onReqBirdEventHandler(self,msg)
    SOCKET_SEND(Protocol.CS_BIRD_EVENT)
end

function onOpenBirdGamePanel(self, args)
    -- GM
    -- GameDispatcher:dispatchEvent(EventName.OPEN_BIRD_GAME_PANEL)
    if self.mBirdGamePanel == nil then
        self.mBirdGamePanel = bird.BirdGamePanel.new()
        self.mBirdGamePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryBirdGamePanel, self)
    end
    self.mBirdGamePanel:open(args)
end

function onDestoryBirdGamePanel(self)
    self.mBirdGamePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryBirdGamePanel, self)
    self.mBirdGamePanel = nil
end

function onCloseBirdGamePanel(self)
    if self.mBirdGamePanel ~= nil then
        self.mBirdGamePanel:close()
    end
end

function onOpenBirdStageMainUI(self, args)
    if self.mBirdStageMainUI == nil then
        self.mBirdStageMainUI = bird.BirdStageMainUI.new()
        self.mBirdStageMainUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBirdStageMainUI, self)
    end
    self.mBirdStageMainUI:open(args)
end

-- ui销毁
function onDestroyBirdStageMainUI(self)
    self.mBirdStageMainUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBirdStageMainUI, self)
    self.mBirdStageMainUI = nil
end

function onOpenBirdStarRewardPanel(self, args)
    if self.mBirdStarRewardPanel == nil then
        self.mBirdStarRewardPanel = bird.BirdStarAwardView.new()
        self.mBirdStarRewardPanel:addEventListener(View.EVENT_VIEW_DESTROY,
            self.onDestroyBirdStarRewardPanel, self)
    end
    self.mBirdStarRewardPanel:open(args)
end

function onDestroyBirdStarRewardPanel(self)
    self.mBirdStarRewardPanel:removeEventListener(View.EVENT_VIEW_DESTROY,
        self.onDestroyBirdStarRewardPanel, self)
    self.mBirdStarRewardPanel = nil
end

function onOpenBirdDupPanel(self, args)
    if self.mBirdDupPanel == nil then
        self.mBirdDupPanel = bird.BirdDupPanel.new()
        self.mBirdDupPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBirdDupPanel, self)
    end
    self.mBirdDupPanel:open(args)
end

function onDestroyBirdDupPanel(self)
    self.mBirdDupPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBirdDupPanel, self)
    self.mBirdDupPanel = nil
end

function onCloseBirdDupPanel(self)
    if self.mBirdDupPanel ~= nil then
        self.mBirdDupPanel:close()
    end
end

function onOpenBirdSettlePanel(self, args)
    if self.mBirdSettlePanel == nil then
        self.mBirdSettlePanel = bird.BirdSettlePanel.new()
        self.mBirdSettlePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBirdSettlePanel, self)
    end
    self.mBirdSettlePanel:open(args)
end

function onDestroyBirdSettlePanel(self)
    self.mBirdSettlePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBirdSettlePanel, self)
    self.mBirdSettlePanel = nil

end

function onBirdTipsViewHandler(self, args)
    if self.mBirdTipsView == nil then
        self.mBirdTipsView = bird.BirdTipsView.new()
        self.mBirdTipsView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBirdTipsView, self)
    end
    self.mBirdTipsView:open(args)
end

function onDestroyBirdTipsView(self)
    self.mBirdTipsView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBirdTipsView, self)
    self.mBirdTipsView = nil
end

function onBirdTaskViewHandler(self, args)
    if self.mBirdTaskView == nil then
        self.mBirdTaskView = bird.BirdTaskPanel.new()
        self.mBirdTaskView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBirdTaskView, self)
    end
    self.mBirdTaskView:open(args)
end

function onDestroyBirdTaskView(self)
    self.mBirdTaskView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBirdTaskView, self)
    self.mBirdTaskView = nil
end

function onOpenBirdRankPanel(self, args)
    if self.mBirdRankPanel == nil then
        self.mBirdRankPanel = bird.BirdRankPanel.new()
        self.mBirdRankPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBirdRankPanel, self)
    end
    self.mBirdRankPanel:open(args)
end

function onDestroyBirdRankPanel(self)
    self.mBirdRankPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBirdRankPanel, self)
    self.mBirdRankPanel = nil
end

return _M
