module("watermelon.WatermelonController", Class.impl(Controller))
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
    GameDispatcher:addEventListener(EventName.OPEN_WATERMELON_GAME_PANEL, self.onOpenWatermelonGamePanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_WATERMELON_GAME_PANEL, self.onCloseWatermelonGamePanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_WATERMELON_STAGEMAIN_UI, self.onOpenWatermelonStageMainUI, self)
    GameDispatcher:addEventListener(EventName.OPEN_WATERMELON_STAR_REWARD_PANEL, self.onOpenWatermelonStarRewardPanel,
        self)

    GameDispatcher:addEventListener(EventName.OPEN_WATERMELON_DUP_PANEL, self.onOpenWatermelonDupPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_WATERMELON_DUP_PANEL, self.onCloseWatermelonDupPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_WATERMELON_SETTLE_PANEL, self.onOpenWatermelonSettlePanel, self)

    GameDispatcher:addEventListener(EventName.REQ_WATERMELON_PASS_DUP, self.onReqWatermelonPassDupHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_WATERMELON_RECEIVE_STAR, self.onReqWatermelonReceiveHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_WATERMELON_TIPS_VIEW, self.onWatermelonTipsViewHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_WATERMELON_TASK_PANEL, self.onWatermelonTaskViewHandler, self)

    GameDispatcher:addEventListener(EventName.REQ_WATERMELON_TASK_RECEIVE, self.onReqWatermelonTaskHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_WATERMELON_RANK_PANEL, self.onOpenWatermelonRankPanel, self)

    GameDispatcher:addEventListener(EventName.REQ_WATERMELON_EVENT, self.onReqWatermelonEventHandler, self)
    
end

-- 注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_WATERMELON_PANEL = self.onWatermelonPanelHandler,
        SC_UPDATE_WATERMELON_INFO = self.onWatermelonPassDupHandler,
        SC_WATERMELON_TASK_GAIN_RETURN = self.onWatermelonTaskGainHandler,
        SC_WATERMELON_TASK_UPDATE = self.onWatermelonTaskUpdateHandler,
    }
end

function onWatermelonPanelHandler(self, msg)
    watermelon.WatermelonManager:parseWatermelonPanelData(msg)
end

function onWatermelonPassDupHandler(self, msg)
    watermelon.WatermelonManager:parseWatermelonPassDupData(msg.dup_info)
end

function onWatermelonTaskGainHandler(self, msg)
    if msg.result == 1 then
        watermelon.WatermelonManager:updateWatermelonTaskData(msg)
    end
end

function onWatermelonTaskUpdateHandler(self,msg)
    watermelon.WatermelonManager:updateWatermelonTaskDataCount(msg)
end

function onReqWatermelonPassDupHandler(self, args)
    SOCKET_SEND(Protocol.CS_PASS_WATERMELON, {
        dup_id = args.dupId,
        point = args.point
    }, Protocol.SC_UPDATE_WATERMELON_INFO)
end

function onReqWatermelonReceiveHandler(self, list)
    SOCKET_SEND(Protocol.CS_WATERMELON_RECEIVE_STAR, {
        star_reward_id = list
    })
end

function onReqWatermelonTaskHandler(self, args)
    SOCKET_SEND(Protocol.CS_WATERMELON_TASK_GAIN, {
        task_id_list = args.taskId
    }, Protocol.SC_WATERMELON_TASK_GAIN_RETURN)
end

function onReqWatermelonEventHandler(self,msg)
    SOCKET_SEND(Protocol.CS_WATERMELON_EVENT)
end

function onOpenWatermelonGamePanel(self, args)
    -- GM
    -- GameDispatcher:dispatchEvent(EventName.OPEN_WATERMELON_GAME_PANEL)
    if self.mWatermelonGamePanel == nil then
        self.mWatermelonGamePanel = watermelon.WatermelonGamePanel.new()
        self.mWatermelonGamePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryWatermelonGamePanel, self)
    end
    self.mWatermelonGamePanel:open(args)
end

function onDestoryWatermelonGamePanel(self)
    self.mWatermelonGamePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryWatermelonGamePanel, self)
    self.mWatermelonGamePanel = nil
end

function onCloseWatermelonGamePanel(self)
    if self.mWatermelonGamePanel ~= nil then
        self.mWatermelonGamePanel:close()
    end
end

function onOpenWatermelonStageMainUI(self, args)
    if self.mWatermelonStageMainUI == nil then
        self.mWatermelonStageMainUI = watermelon.WatermelonStageMainUI.new()
        self.mWatermelonStageMainUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyWatermelonStageMainUI, self)
    end
    self.mWatermelonStageMainUI:open(args)
end

-- ui销毁
function onDestroyWatermelonStageMainUI(self)
    self.mWatermelonStageMainUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyWatermelonStageMainUI, self)
    self.mWatermelonStageMainUI = nil
end

function onOpenWatermelonStarRewardPanel(self, args)
    if self.mWatermelonStarRewardPanel == nil then
        self.mWatermelonStarRewardPanel = watermelon.WatermelonStarAwardView.new()
        self.mWatermelonStarRewardPanel:addEventListener(View.EVENT_VIEW_DESTROY,
            self.onDestroyWatermelonStarRewardPanel, self)
    end
    self.mWatermelonStarRewardPanel:open(args)
end

function onDestroyWatermelonStarRewardPanel(self)
    self.mWatermelonStarRewardPanel:removeEventListener(View.EVENT_VIEW_DESTROY,
        self.onDestroyWatermelonStarRewardPanel, self)
    self.mWatermelonStarRewardPanel = nil
end

function onOpenWatermelonDupPanel(self, args)
    if self.mWatermelonDupPanel == nil then
        self.mWatermelonDupPanel = watermelon.WatermelonDupPanel.new()
        self.mWatermelonDupPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyWatermelonDupPanel, self)
    end
    self.mWatermelonDupPanel:open(args)
end

function onDestroyWatermelonDupPanel(self)
    self.mWatermelonDupPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyWatermelonDupPanel, self)
    self.mWatermelonDupPanel = nil
end

function onCloseWatermelonDupPanel(self)
    if self.mWatermelonDupPanel ~= nil then
        self.mWatermelonDupPanel:close()
    end
end

function onOpenWatermelonSettlePanel(self, args)
    if self.mWatermelonSettlePanel == nil then
        self.mWatermelonSettlePanel = watermelon.WatermelonSettlePanel.new()
        self.mWatermelonSettlePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyWatermelonSettlePanel, self)
    end
    self.mWatermelonSettlePanel:open(args)
end

function onDestroyWatermelonSettlePanel(self)
    self.mWatermelonSettlePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyWatermelonSettlePanel, self)
    self.mWatermelonSettlePanel = nil

end

function onWatermelonTipsViewHandler(self, args)
    if self.mWatermelonTipsView == nil then
        self.mWatermelonTipsView = watermelon.WatermelonTipsView.new()
        self.mWatermelonTipsView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyWatermelonTipsView, self)
    end
    self.mWatermelonTipsView:open(args)
end

function onDestroyWatermelonTipsView(self)
    self.mWatermelonTipsView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyWatermelonTipsView, self)
    self.mWatermelonTipsView = nil
end

function onWatermelonTaskViewHandler(self, args)
    if self.mWatermelonTaskView == nil then
        self.mWatermelonTaskView = watermelon.WatermelonTaskPanel.new()
        self.mWatermelonTaskView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyWatermelonTaskView, self)
    end
    self.mWatermelonTaskView:open(args)
end

function onDestroyWatermelonTaskView(self)
    self.mWatermelonTaskView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyWatermelonTaskView, self)
    self.mWatermelonTaskView = nil
end

function onOpenWatermelonRankPanel(self, args)
    if self.mWatermelonRankPanel == nil then
        self.mWatermelonRankPanel = watermelon.WatermelonRankPanel.new()
        self.mWatermelonRankPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyWatermelonRankPanel, self)
    end
    self.mWatermelonRankPanel:open(args)
end

function onDestroyWatermelonRankPanel(self)
    self.mWatermelonRankPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyWatermelonRankPanel, self)
    self.mWatermelonRankPanel = nil
end

return _M
