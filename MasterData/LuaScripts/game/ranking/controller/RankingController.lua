-- @FileName:   RankingController.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2024-01-05 16:11:19
-- @Copyright:   (LY) 2023 雷焰网络

module("game.ranking.controller.RankingController", Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_RANKING_STAGEPANEL, self.onOpenRankingStagePanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_RANKING_REWARDVIEW, self.onOpeRankingRewardView, self)
    GameDispatcher:addEventListener(EventName.OPEN_RANKING_SCENEUI, self.onOpeRankingSceneUI, self)
    GameDispatcher:addEventListener(EventName.CLOSE_RANKING_SCENEUI, self.onCloseRankingSceneUI, self)
    GameDispatcher:addEventListener(EventName.OPEN_RANKING_SETTLEMENTPANEL, self.onOpeRankingSettlementPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_RANKING_DUPPANEL, self.onOpenRankingDupPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_RANKING_DUPPANEL, self.onCloseRankingDupPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_RANKING_TEACHINGVIEW, self.onOpenRankingTeachingPanel, self)
    

    GameDispatcher:addEventListener(EventName.ONREQ_RANKING_PASS_DUP, self.onReqRankingPassStage, self)
    GameDispatcher:addEventListener(EventName.ONREQ_RANKING_GET_AWARD, self.onReqRankingRewardGetAward, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return
    {
        SC_RANKING_GAME_PANEL = onReceiveRankingPanelInfo,
        SC_RANKING_GAME_PASS_DUP = onReceiveRankingPassDup,
    }
end
-------------------------------------------------------------数据--------------------------------------------------------------------

--------------------------------------------------------------打开UI界面(其他与角色玩家)----------------------------------------------
function onOpenRankingTeachingPanel(self, args)
    if self.mRankingTeachingPanel == nil then
        self.mRankingTeachingPanel = UI.new(ranking.RankingTeachingView)
        self.mRankingTeachingPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRankingTeachingPanel, self)

        self.mRankingTeachingPanel:open(args)
    else
        self.mRankingTeachingPanel:updateView(args)
    end
end
function onCloseRankingTeachingPanel(self, args)
    if self.mRankingTeachingPanel ~= nil then
        self.mRankingTeachingPanel:close()
    end
end
-- ui销毁
function onDestroyRankingTeachingPanel(self)
    self.mRankingTeachingPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRankingTeachingPanel, self)
    self.mRankingTeachingPanel = nil
end

function onOpenRankingDupPanel(self, args)
    if self.mRankingDupPanel == nil then
        self.mRankingDupPanel = UI.new(ranking.RankingDupPanel)
        self.mRankingDupPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRankingDupPanel, self)

        self.mRankingDupPanel:open(args)
    else
        self.mRankingDupPanel:updateView(args)
    end
end
function onCloseRankingDupPanel(self, args)
    if self.mRankingDupPanel ~= nil then
        self.mRankingDupPanel:close()
    end
end
-- ui销毁
function onDestroyRankingDupPanel(self)
    self.mRankingDupPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRankingDupPanel, self)
    self.mRankingDupPanel = nil
end

-- 打开蛋壳副本选择界面
function onOpenRankingStagePanel(self, args)
    if self.mRankingStagePanel == nil then
        self.mRankingStagePanel = UI.new(ranking.RankingStageMainUI)
        self.mRankingStagePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRankingStagePanel, self)
    end
    self.mRankingStagePanel:open(args)
end

-- ui销毁
function onDestroyRankingStagePanel(self)
    self.mRankingStagePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRankingStagePanel, self)
    self.mRankingStagePanel = nil
end

-- 打开蛋壳任务界面
function onOpeRankingRewardView(self, args)
    if self.mRankingRewardView == nil then
        self.mRankingRewardView = UI.new(ranking.RankingStarAwardView)
        self.mRankingRewardView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRankingRewardView, self)
    end
    self.mRankingRewardView:open(args)
end

-- ui销毁
function onDestroyRankingRewardView(self)
    self.mRankingRewardView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRankingRewardView, self)
    self.mRankingRewardView = nil
end

-- 打开蛋壳场景战斗界面
function onOpeRankingSceneUI(self, args)
    if self.mRankingSceneUI == nil then
        self.mRankingSceneUI = UI.new(ranking.RankingSceneUI)
        self.mRankingSceneUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRankingSceneUI, self)
        self.mRankingSceneUI:open(args)
    else
        self.mRankingSceneUI:refreshView(args)
    end
end

-- ui销毁
function onDestroyRankingSceneUI(self)
    self.mRankingSceneUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRankingSceneUI, self)
    self.mRankingSceneUI = nil
end

-- 关闭蛋壳场景战斗界面
function onCloseRankingSceneUI(self)
    if self.mRankingSceneUI then
        self.mRankingSceneUI:close()
    end
end

-- 打开蛋壳结算界面
function onOpeRankingSettlementPanel(self, args)
    if self.mRankingSettlementPanel == nil then
        self.mRankingSettlementPanel = UI.new(ranking.RankingSettlementPanel)
        self.mRankingSettlementPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRankingSettlementPanel, self)
    end
    self.mRankingSettlementPanel:open(args)
end

-- ui销毁
function onDestroyRankingSettlementPanel(self)
    self.mRankingSettlementPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRankingSettlementPanel, self)
    self.mRankingSettlementPanel = nil
end

---------------------------------------------------------------响应------------------------------------------------------------------

--面板数据
function onReceiveRankingPanelInfo(self, msg)
    -- logAll(msg, "*s2c* 打砖块面板 18206")
    for _, stage_info in pairs(msg.dup_list) do
        ranking.RankingManager:setPassStageStar(stage_info)
    end

    for _, reward_id in pairs(msg.star_reward_list) do
        ranking.RankingManager:setRewardInfo(reward_id)
    end

    GameDispatcher:dispatchEvent(EventName.RANKING_RECEIVE_INFO)
    GameDispatcher:dispatchEvent(EventName.RANKING_RECEIVE_REWARD)

    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

--通过返回
function onReceiveRankingPassDup(self, msg)
    local old_star = ranking.RankingManager:getPassStageStar(self.m_DupId)
    GameDispatcher:dispatchEvent(EventName.OPEN_RANKING_SETTLEMENTPANEL, {dup_id = msg.dup_id, first = old_star == 0})
end
-- ---------------------------------------------------------------请求------------------------------------------------------------------

-- --请求领取任务奖励
function onReqRankingRewardGetAward(self, reward_id_list)
    -- logAll(reward_id_list, "请求领取任务奖励")
    SOCKET_SEND(Protocol.CS_RANKING_GAME_RECEIVE_STAR, {star_reward_id = reward_id_list})
end

--请求通关关卡
function onReqRankingPassStage(self, args)
    ranking.RankingManager:setOpenSettlementPanel(true)

    local oldStar_count = ranking.RankingManager:getPassStageStar(args.dup_id)
    if args.star_count <= 0 or args.star_count <= oldStar_count then
        GameDispatcher:dispatchEvent(EventName.OPEN_RANKING_SETTLEMENTPANEL, {dup_id = args.dup_id, star = args.star_count})
        return
    end

    local cmd = {dup_id = args.dup_id, star = args.star_count}
    -- logAll(cmd, "请求通关关卡")
    SOCKET_SEND(Protocol.CS_RANKING_GAME_PASS_DUP, cmd, Protocol.SC_RANKING_GAME_PASS_DUP)
end

return _M
