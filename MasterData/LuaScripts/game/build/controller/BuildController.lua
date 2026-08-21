module("build.BuildController", Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_BUILD_GAME_PANEL, self.onOpenBuildGamePanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_BUILD_GAME_PANEL, self.onCloseBuildGamePanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_BUILD_STAGEMAIN_UI, self.onOpenBuildStageMainUI, self)
    GameDispatcher:addEventListener(EventName.OPEN_BUILD_STAR_REWARD_PANEL, self.onOpenBuildStarRewardPanel,
        self)

    GameDispatcher:addEventListener(EventName.OPEN_BUILD_DUP_PANEL, self.onOpenBuildDupPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_BUILD_DUP_PANEL, self.onCloseBuildDupPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_BUILD_SETTLE_PANEL, self.onOpenBuildSettlePanel, self)

    GameDispatcher:addEventListener(EventName.REQ_BUILD_PASS_DUP, self.onReqBuildPassDupHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_BUILD_RECEIVE_STAR, self.onReqBuildReceiveHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_BUILD_TIPS_VIEW, self.onBuildTipsViewHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_BUILD_TASK_PANEL, self.onBuildTaskViewHandler, self)

    GameDispatcher:addEventListener(EventName.REQ_BUILD_TASK_RECEIVE, self.onReqBuildTaskHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_BUILD_RANK_PANEL, self.onOpenBuildRankPanel, self)

    GameDispatcher:addEventListener(EventName.REQ_BUILD_EVENT, self.onReqBuildEventHandler, self)
    
end

-- 注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_BUILD_PANEL = self.onBuildPanelHandler,
        SC_UPDATE_BUILD_INFO = self.onBuildPassDupHandler,
        SC_BUILD_TASK_GAIN_RETURN = self.onBuildTaskGainHandler,
        SC_BUILD_TASK_UPDATE = self.onBuildTaskUpdateHandler,
    }
end

function onBuildPanelHandler(self, msg)
    build.BuildManager:parseBuildPanelData(msg)
end

function onBuildPassDupHandler(self, msg)
    build.BuildManager:parseBuildPassDupData(msg.dup_info)
end

function onBuildTaskGainHandler(self, msg)
    if msg.result == 1 then
        build.BuildManager:updateBuildTaskData(msg)
    end
end

function onBuildTaskUpdateHandler(self,msg)
    build.BuildManager:updateBuildTaskDataCount(msg)
end

function onReqBuildPassDupHandler(self, args)
    SOCKET_SEND(Protocol.CS_PASS_BUILD, {
        dup_id = args.dupId,
        point = tostring(args.point)
    }, Protocol.SC_UPDATE_BUILD_INFO)
end

function onReqBuildReceiveHandler(self, list)
    SOCKET_SEND(Protocol.CS_BUILD_RECEIVE_STAR, {
        star_reward_id = list
    })
end

function onReqBuildTaskHandler(self, args)
    SOCKET_SEND(Protocol.CS_BUILD_TASK_GAIN, {
        task_id_list = args.taskId
    }, Protocol.SC_BUILD_TASK_GAIN_RETURN)
end

function onReqBuildEventHandler(self,score)
    SOCKET_SEND(Protocol.CS_BUILD_SCORE,{score = tostring(score)})
end

function onOpenBuildGamePanel(self, args)
    -- GM
    -- GameDispatcher:dispatchEvent(EventName.OPEN_BUILD_GAME_PANEL)
    if self.mBuildGamePanel == nil then
        self.mBuildGamePanel = build.BuildGamePanel.new()
        self.mBuildGamePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryBuildGamePanel, self)
    end
    self.mBuildGamePanel:open(args)
end

function onDestoryBuildGamePanel(self)
    self.mBuildGamePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryBuildGamePanel, self)
    self.mBuildGamePanel = nil
end

function onCloseBuildGamePanel(self)
    if self.mBuildGamePanel ~= nil then
        self.mBuildGamePanel:close()
    end
end

function onOpenBuildStageMainUI(self, args)
    if self.mBuildStageMainUI == nil then
        self.mBuildStageMainUI = build.BuildStageMainUI.new()
        self.mBuildStageMainUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBuildStageMainUI, self)
    end
    self.mBuildStageMainUI:open(args)
end

-- 关卡主界面销毁时移除监听并清空缓存实例，避免下次打开引用已销毁对象
function onDestroyBuildStageMainUI(self)
    self.mBuildStageMainUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBuildStageMainUI, self)
    self.mBuildStageMainUI = nil
end

function onOpenBuildStarRewardPanel(self, args)
    if self.mBuildStarRewardPanel == nil then
        self.mBuildStarRewardPanel = build.BuildStarAwardView.new()
        self.mBuildStarRewardPanel:addEventListener(View.EVENT_VIEW_DESTROY,
            self.onDestroyBuildStarRewardPanel, self)
    end
    self.mBuildStarRewardPanel:open(args)
end

function onDestroyBuildStarRewardPanel(self)
    self.mBuildStarRewardPanel:removeEventListener(View.EVENT_VIEW_DESTROY,
        self.onDestroyBuildStarRewardPanel, self)
    self.mBuildStarRewardPanel = nil
end

function onOpenBuildDupPanel(self, args)
    if self.mBuildDupPanel == nil then
        self.mBuildDupPanel = build.BuildDupPanel.new()
        self.mBuildDupPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBuildDupPanel, self)
    end
    self.mBuildDupPanel:open(args)
end

function onDestroyBuildDupPanel(self)
    self.mBuildDupPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBuildDupPanel, self)
    self.mBuildDupPanel = nil
end

function onCloseBuildDupPanel(self)
    if self.mBuildDupPanel ~= nil then
        self.mBuildDupPanel:close()
    end
end

function onOpenBuildSettlePanel(self, args)
    if self.mBuildSettlePanel == nil then
        self.mBuildSettlePanel = build.BuildSettlePanel.new()
        self.mBuildSettlePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBuildSettlePanel, self)
    end
    self.mBuildSettlePanel:open(args)
end

function onDestroyBuildSettlePanel(self)
    self.mBuildSettlePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBuildSettlePanel, self)
    self.mBuildSettlePanel = nil

end

function onBuildTipsViewHandler(self, args)
    if self.mBuildTipsView == nil then
        self.mBuildTipsView = build.BuildTipsView.new()
        self.mBuildTipsView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBuildTipsView, self)
    end
    self.mBuildTipsView:open(args)
end

function onDestroyBuildTipsView(self)
    self.mBuildTipsView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBuildTipsView, self)
    self.mBuildTipsView = nil
end

function onBuildTaskViewHandler(self, args)
    if self.mBuildTaskView == nil then
        self.mBuildTaskView = build.BuildTaskPanel.new()
        self.mBuildTaskView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBuildTaskView, self)
    end
    self.mBuildTaskView:open(args)
end

function onDestroyBuildTaskView(self)
    self.mBuildTaskView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBuildTaskView, self)
    self.mBuildTaskView = nil
end

function onOpenBuildRankPanel(self, args)
    if self.mBuildRankPanel == nil then
        self.mBuildRankPanel = build.BuildRankPanel.new()
        self.mBuildRankPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBuildRankPanel, self)
    end
    self.mBuildRankPanel:open(args)
end

function onDestroyBuildRankPanel(self)
    self.mBuildRankPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBuildRankPanel, self)
    self.mBuildRankPanel = nil
end

return _M
