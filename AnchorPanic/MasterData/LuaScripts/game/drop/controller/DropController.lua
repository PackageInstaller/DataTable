module("drop.DropController", Class.impl(Controller))

-- 建造小游戏控制器，负责模块事件监听、协议收发与各界面生命周期管理
-- 构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

-- 析构函数
function dtor(self)
end

-- 重新登录时走父类清理流程，当前模块暂无额外重登数据处理
function reLogin(self)
    super.reLogin(self)
end

-- 游戏启动回调，预留给模块初始化完成后的额外处理
function gameStartCallBack(self)

end

-- 注册模块内事件监听：界面打开关闭、奖励领取、任务领取、关卡结算和排行榜入口都从这里转发
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_DROP_GAME_PANEL, self.onOpenDropGamePanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_DROP_GAME_PANEL, self.onCloseDropGamePanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_DROP_STAGEMAIN_UI, self.onOpenDropStageMainUI, self)
    GameDispatcher:addEventListener(EventName.OPEN_DROP_STAR_REWARD_PANEL, self.onOpenDropStarRewardPanel,
        self)

    GameDispatcher:addEventListener(EventName.OPEN_DROP_DUP_PANEL, self.onOpenDropDupPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_DROP_DUP_PANEL, self.onCloseDropDupPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_DROP_SETTLE_PANEL, self.onOpenDropSettlePanel, self)

    GameDispatcher:addEventListener(EventName.REQ_DROP_PASS_DUP, self.onReqDropPassDupHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_DROP_RECEIVE_STAR, self.onReqDropReceiveHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_DROP_TIPS_VIEW, self.onDropTipsViewHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_DROP_TASK_PANEL, self.onDropTaskViewHandler, self)

    GameDispatcher:addEventListener(EventName.REQ_DROP_TASK_RECEIVE, self.onReqDropTaskHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_DROP_RANK_PANEL, self.onOpenDropRankPanel, self)

    GameDispatcher:addEventListener(EventName.REQ_DROP_EVENT, self.onReqDropEventHandler, self)
    
end

-- 注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_CLEAR_PANEL = self.onDropPanelHandler,
        SC_UPDATE_CLEAR_INFO = self.onDropPassDupHandler,
        SC_CLEAR_TASK_GAIN_RETURN = self.onDropTaskGainHandler,
        SC_CLEAR_TASK_UPDATE = self.onDropTaskUpdateHandler,
    }
end

function onDropPanelHandler(self, msg)
    drop.DropManager:parseDropPanelData(msg)
end

function onDropPassDupHandler(self, msg)
    drop.DropManager:parseDropPassDupData(msg.dup_info)
end

function onDropTaskGainHandler(self, msg)
    if msg.result == 1 then
        drop.DropManager:updateDropTaskData(msg)
    end
end

function onDropTaskUpdateHandler(self,msg)
    drop.DropManager:updateDropTaskDataCount(msg)
end

function onReqDropPassDupHandler(self, args)
    SOCKET_SEND(Protocol.CS_PASS_CLEAR, {
        dup_id = args.dupId,
        point = tostring(args.point)
    }, Protocol.SC_UPDATE_CLEAR_INFO)
end

function onReqDropReceiveHandler(self, list)
    SOCKET_SEND(Protocol.CS_CLEAR_RECEIVE_STAR, {
        star_reward_id = list
    })
end

function onReqDropTaskHandler(self, args)
    SOCKET_SEND(Protocol.CS_CLEAR_TASK_GAIN, {
        task_id_list = args.taskId
    }, Protocol.SC_CLEAR_TASK_GAIN_RETURN)
end

function onReqDropEventHandler(self,score)
    SOCKET_SEND(Protocol.CS_CLEAR_SCORE,{score = tostring(score)})
end

function onOpenDropGamePanel(self, args)
    -- GM
    -- GameDispatcher:dispatchEvent(EventName.OPEN_DROP_GAME_PANEL)
    if self.mDropGamePanel == nil then
        self.mDropGamePanel = drop.DropGamePanel.new()
        self.mDropGamePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryDropGamePanel, self)
    end
    self.mDropGamePanel:open(args)
end

function onDestoryDropGamePanel(self)
    self.mDropGamePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryDropGamePanel, self)
    self.mDropGamePanel = nil
end

function onCloseDropGamePanel(self)
    if self.mDropGamePanel ~= nil then
        self.mDropGamePanel:close()
    end
end

function onOpenDropStageMainUI(self, args)
    if self.mDropStageMainUI == nil then
        self.mDropStageMainUI = drop.DropStageMainUI.new()
        self.mDropStageMainUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDropStageMainUI, self)
    end
    self.mDropStageMainUI:open(args)
end

-- 关卡主界面销毁时移除监听并清空缓存实例，避免下次打开引用已销毁对象
function onDestroyDropStageMainUI(self)
    self.mDropStageMainUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDropStageMainUI, self)
    self.mDropStageMainUI = nil
end

function onOpenDropStarRewardPanel(self, args)
    if self.mDropStarRewardPanel == nil then
        self.mDropStarRewardPanel = drop.DropStarAwardView.new()
        self.mDropStarRewardPanel:addEventListener(View.EVENT_VIEW_DESTROY,
            self.onDestroyDropStarRewardPanel, self)
    end
    self.mDropStarRewardPanel:open(args)
end

function onDestroyDropStarRewardPanel(self)
    self.mDropStarRewardPanel:removeEventListener(View.EVENT_VIEW_DESTROY,
        self.onDestroyDropStarRewardPanel, self)
    self.mDropStarRewardPanel = nil
end

function onOpenDropDupPanel(self, args)
    if self.mDropDupPanel == nil then
        self.mDropDupPanel = drop.DropDupPanel.new()
        self.mDropDupPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDropDupPanel, self)
    end
    self.mDropDupPanel:open(args)
end

function onDestroyDropDupPanel(self)
    self.mDropDupPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDropDupPanel, self)
    self.mDropDupPanel = nil
end

function onCloseDropDupPanel(self)
    if self.mDropDupPanel ~= nil then
        self.mDropDupPanel:close()
    end
end

function onOpenDropSettlePanel(self, args)
    if self.mDropSettlePanel == nil then
        self.mDropSettlePanel = drop.DropSettlePanel.new()
        self.mDropSettlePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDropSettlePanel, self)
    end
    self.mDropSettlePanel:open(args)
end

function onDestroyDropSettlePanel(self)
    self.mDropSettlePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDropSettlePanel, self)
    self.mDropSettlePanel = nil

end

function onDropTipsViewHandler(self, args)
    if self.mDropTipsView == nil then
        self.mDropTipsView = drop.DropTipsView.new()
        self.mDropTipsView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDropTipsView, self)
    end
    self.mDropTipsView:open(args)
end

function onDestroyDropTipsView(self)
    self.mDropTipsView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDropTipsView, self)
    self.mDropTipsView = nil
end

function onDropTaskViewHandler(self, args)
    if self.mDropTaskView == nil then
        self.mDropTaskView = drop.DropTaskPanel.new()
        self.mDropTaskView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDropTaskView, self)
    end
    self.mDropTaskView:open(args)
end

function onDestroyDropTaskView(self)
    self.mDropTaskView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDropTaskView, self)
    self.mDropTaskView = nil
end

function onOpenDropRankPanel(self, args)
    if self.mDropRankPanel == nil then
        self.mDropRankPanel = drop.DropRankPanel.new()
        self.mDropRankPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDropRankPanel, self)
    end
    self.mDropRankPanel:open(args)
end

function onDestroyDropRankPanel(self)
    self.mDropRankPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDropRankPanel, self)
    self.mDropRankPanel = nil
end

return _M
