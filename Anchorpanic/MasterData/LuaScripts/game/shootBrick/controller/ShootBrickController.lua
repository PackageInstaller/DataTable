-- @FileName:   ShootBrickController.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2024-01-05 16:11:19
-- @Copyright:   (LY) 2023 雷焰网络

module("game.shootBrick.controller.ShootBrickController", Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_SHOOTBRICK_STAGEPANEL, self.onOpenShootBrickStagePanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_SHOOTBRICK_REWARDVIEW, self.onOpeShootBrickRewardView, self)
    GameDispatcher:addEventListener(EventName.OPEN_SHOOTBRICK_SCENEUI, self.onOpeShootBrickSceneUI, self)
    GameDispatcher:addEventListener(EventName.CLOSE_SHOOTBRICK_SCENEUI, self.onCloseShootBrickSceneUI, self)
    GameDispatcher:addEventListener(EventName.OPEN_SHOOTBRICK_PAUSEPANEL, self.onOpeShootBrickPausePanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_SHOOTBRICK_SETTLEMENTPANEL, self.onOpeShootBrickSettlementPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_SHOOTBRICK_TEACHING_VIEW, self.onOpeShootBrickTeachingView, self)

    GameDispatcher:addEventListener(EventName.ONREQ_SHOOTBRICK_PASS_DUP, self.onReqShootBrickPassStage, self)
    GameDispatcher:addEventListener(EventName.ONREQ_SHOOTBRICK_GET_AWARD, self.onReqShootBrickRewardGetAward, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return
    {
        SC_BREAKOUT_PANEL = onReceiveShootBrickPanelInfo,
        SC_BREAKOUT_PASS_DUP = onReceiveShootBrickPassDup,
    }
end
-------------------------------------------------------------数据--------------------------------------------------------------------

--------------------------------------------------------------打开UI界面(其他与角色玩家)----------------------------------------------
-- 打开钓鱼教程界面
function onOpeShootBrickTeachingView(self, args)
    if self.mShootBrickTeachingView == nil then
        self.mShootBrickTeachingView = UI.new(shootBrick.ShootBrickTeachingView)
        self.mShootBrickTeachingView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShootBrickTeachingView, self)
    end
    self.mShootBrickTeachingView:open(args)
end

-- ui销毁
function onDestroyShootBrickTeachingView(self)
    self.mShootBrickTeachingView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShootBrickTeachingView, self)
    self.mShootBrickTeachingView = nil
end

-- 打开蛋壳副本选择界面
function onOpenShootBrickStagePanel(self, args)
    if self.mShootBrickStagePanel == nil then
        self.mShootBrickStagePanel = UI.new(shootBrick.ShootBrickStagePanel)
        self.mShootBrickStagePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShootBrickStagePanel, self)
    end
    self.mShootBrickStagePanel:open(args)
end

-- ui销毁
function onDestroyShootBrickStagePanel(self)
    self.mShootBrickStagePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShootBrickStagePanel, self)
    self.mShootBrickStagePanel = nil
end

-- 打开蛋壳任务界面
function onOpeShootBrickRewardView(self, args)
    if self.mShootBrickRewardView == nil then
        self.mShootBrickRewardView = UI.new(shootBrick.ShootBrickRewardView)
        self.mShootBrickRewardView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShootBrickRewardView, self)
    end
    self.mShootBrickRewardView:open(args)
end

-- ui销毁
function onDestroyShootBrickRewardView(self)
    self.mShootBrickRewardView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShootBrickRewardView, self)
    self.mShootBrickRewardView = nil
end

-- 打开蛋壳场景战斗界面
function onOpeShootBrickSceneUI(self, args)
    if self.mShootBrickSceneUI == nil then
        self.mShootBrickSceneUI = UI.new(shootBrick.ShootBrickSceneUI)
        self.mShootBrickSceneUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShootBrickSceneUI, self)
        self.mShootBrickSceneUI:open(args)
    else
        self.mShootBrickSceneUI:refreshView(args)
    end
end

-- ui销毁
function onDestroyShootBrickSceneUI(self)
    self.mShootBrickSceneUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShootBrickSceneUI, self)
    self.mShootBrickSceneUI = nil
end

-- 关闭蛋壳场景战斗界面
function onCloseShootBrickSceneUI(self)
    if self.mShootBrickSceneUI then
        self.mShootBrickSceneUI:close()
    end
end

-- 打开蛋壳战斗暂停界面
function onOpeShootBrickPausePanel(self, args)
    if self.mShootBrickPausePanel == nil then
        self.mShootBrickPausePanel = UI.new(shootBrick.ShootBrickPausePanel)
        self.mShootBrickPausePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShootBrickPausePanel, self)
    end
    self.mShootBrickPausePanel:open(args)
end

-- ui销毁
function onDestroyShootBrickPausePanel(self)
    self.mShootBrickPausePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShootBrickPausePanel, self)
    self.mShootBrickPausePanel = nil
end

-- 打开蛋壳结算界面
function onOpeShootBrickSettlementPanel(self, args)
    if self.mShootBrickSettlementPanel == nil then
        self.mShootBrickSettlementPanel = UI.new(shootBrick.ShootBrickSettlementPanel)
        self.mShootBrickSettlementPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShootBrickSettlementPanel, self)
    end
    self.mShootBrickSettlementPanel:open(args)
end

-- ui销毁
function onDestroyShootBrickSettlementPanel(self)
    self.mShootBrickSettlementPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShootBrickSettlementPanel, self)
    self.mShootBrickSettlementPanel = nil
end

---------------------------------------------------------------响应------------------------------------------------------------------

--面板数据
function onReceiveShootBrickPanelInfo(self, msg)
    -- logAll(msg, "*s2c* 打砖块面板 18206")
    for _, stage_info in pairs(msg.dup_list) do
        shootBrick.ShootBrickManager:setPassStageStar(stage_info)
    end

    for _, reward_id in pairs(msg.star_reward_list) do
        shootBrick.ShootBrickManager:setRewardInfo(reward_id)
    end

    GameDispatcher:dispatchEvent(EventName.SHOOTBRICK_RECEIVE_INFO)
    GameDispatcher:dispatchEvent(EventName.SHOOTBRICK_RECEIVE_REWARD)

    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

--通过返回
function onReceiveShootBrickPassDup(self, msg)
    GameDispatcher:dispatchEvent(EventName.OPEN_SHOOTBRICK_SETTLEMENTPANEL, {dup_id = msg.dup_id, star = msg.star})
end
-- ---------------------------------------------------------------请求------------------------------------------------------------------

-- --请求领取任务奖励
function onReqShootBrickRewardGetAward(self, reward_id_list)
    -- logAll(reward_id_list, "请求领取任务奖励")
    SOCKET_SEND(Protocol.CS_BREAKOUT_RECEIVE_STAR, {star_reward_id = reward_id_list})
end

--请求通关关卡
function onReqShootBrickPassStage(self, args)
    shootBrick.ShootBrickManager:setOpenSettlementPanel(true)

    local oldStar_count = shootBrick.ShootBrickManager:getPassStageStar(args.dup_id)
    if args.star_count <= 0 or args.star_count <= oldStar_count then
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOOTBRICK_SETTLEMENTPANEL, {dup_id = args.dup_id, star = args.star_count})
        return
    end

    local cmd = {dup_id = args.dup_id, star = args.star_count}
    -- logAll(cmd, "请求通关关卡")
    SOCKET_SEND(Protocol.CS_BREAKOUT_PASS_DUP, cmd, Protocol.SC_BREAKOUT_PASS_DUP)
end

return _M
