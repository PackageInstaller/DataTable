-- @FileName:   PickGoldController.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2024-01-05 16:11:19
-- @Copyright:   (LY) 2023 雷焰网络

module("game.pickGold.controller.PickGoldController", Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_PICKGOLD_STAGEPANEL, self.onOpenPickGoldStagePanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_PICKGOLD_REWARDVIEW, self.onOpePickGoldRewardView, self)
    GameDispatcher:addEventListener(EventName.OPEN_PICKGOLD_SCENEUI, self.onOpePickGoldSceneUI, self)
    GameDispatcher:addEventListener(EventName.CLOSE_PICKGOLD_SCENEUI, self.onClosePickGoldSceneUI, self)
    GameDispatcher:addEventListener(EventName.OPEN_PICKGOLD_SETTLEMENTPANEL, self.onOpePickGoldSettlementPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_PICKGOLD_DUPPANEL, self.onOpenPickGoldDupPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_PICKGOLD_DUPPANEL, self.onClosePickGoldDupPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_PICKGOLD_TEACHINGVIEW, self.onOpenPickGoldTeachingPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_PICKGOLD_RANKPANEL, self.onOpenPickGoldRankPanel, self)

    GameDispatcher:addEventListener(EventName.ONREQ_PICKGOLD_PASS_DUP, self.onReqPickGoldPassStage, self)
    GameDispatcher:addEventListener(EventName.ONREQ_PICKGOLD_GET_AWARD, self.onReqPickGoldRewardGetAward, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return
    {
        SC_GOLD_PANEL = self.onReceivePickGoldPanelInfo, --- *s2c* 捡金币信息 18250
        SC_GOLD_TASK_GAIN_RETURN = self.onReceivePickGoldTaskGet, --- *s2c* 捡金币任务领取 返回 18253
        SC_UPDATE_GOLD_INFO = self.onReceivePickGoldPassDup, --- *s2c* 更新捡金币信息 18255
    }
end
-------------------------------------------------------------数据--------------------------------------------------------------------

--------------------------------------------------------------打开UI界面(其他与角色玩家)----------------------------------------------
function onOpenPickGoldRankPanel(self, args)
    if self.mPickGoldRankPanel == nil then
        self.mPickGoldRankPanel = UI.new(pickGold.PickGoldRankPanel)
        self.mPickGoldRankPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPickGoldRankPanel, self)
    end
    self.mPickGoldRankPanel:open(args)
end
-- ui销毁
function onDestroyPickGoldRankPanel(self)
    self.mPickGoldRankPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPickGoldRankPanel, self)
    self.mPickGoldRankPanel = nil
end

function onOpenPickGoldTeachingPanel(self, args)
    if self.mPickGoldTeachingPanel == nil then
        self.mPickGoldTeachingPanel = UI.new(pickGold.PickGoldTeachingView)
        self.mPickGoldTeachingPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPickGoldTeachingPanel, self)

        self.mPickGoldTeachingPanel:open(args)
    else
        self.mPickGoldTeachingPanel:updateView(args)
    end
end
function onClosePickGoldTeachingPanel(self, args)
    if self.mPickGoldTeachingPanel ~= nil then
        self.mPickGoldTeachingPanel:close()
    end
end
-- ui销毁
function onDestroyPickGoldTeachingPanel(self)
    self.mPickGoldTeachingPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPickGoldTeachingPanel, self)
    self.mPickGoldTeachingPanel = nil
end

function onOpenPickGoldDupPanel(self, args)
    if self.mPickGoldDupPanel == nil then
        self.mPickGoldDupPanel = UI.new(pickGold.PickGoldDupPanel)
        self.mPickGoldDupPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPickGoldDupPanel, self)

        self.mPickGoldDupPanel:open(args)
    else
        self.mPickGoldDupPanel:updateView(args)
    end
end
function onClosePickGoldDupPanel(self, args)
    if self.mPickGoldDupPanel ~= nil then
        self.mPickGoldDupPanel:close()
    end
end
-- ui销毁
function onDestroyPickGoldDupPanel(self)
    self.mPickGoldDupPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPickGoldDupPanel, self)
    self.mPickGoldDupPanel = nil
end

-- 打开蛋壳副本选择界面
function onOpenPickGoldStagePanel(self, args)
    if self.mPickGoldStagePanel == nil then
        self.mPickGoldStagePanel = UI.new(pickGold.PickGoldStageMainUI)
        self.mPickGoldStagePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPickGoldStagePanel, self)
    end
    self.mPickGoldStagePanel:open(args)
end

-- ui销毁
function onDestroyPickGoldStagePanel(self)
    self.mPickGoldStagePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPickGoldStagePanel, self)
    self.mPickGoldStagePanel = nil
end

-- 打开蛋壳任务界面
function onOpePickGoldRewardView(self, args)
    if self.mPickGoldRewardView == nil then
        self.mPickGoldRewardView = UI.new(pickGold.PickGoldStarAwardView)
        self.mPickGoldRewardView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPickGoldRewardView, self)
    end
    self.mPickGoldRewardView:open(args)
end

-- ui销毁
function onDestroyPickGoldRewardView(self)
    self.mPickGoldRewardView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPickGoldRewardView, self)
    self.mPickGoldRewardView = nil
end

-- 打开蛋壳场景战斗界面
function onOpePickGoldSceneUI(self, args)
    if self.mPickGoldSceneUI == nil then
        self.mPickGoldSceneUI = UI.new(pickGold.PickGoldSceneUI)
        self.mPickGoldSceneUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPickGoldSceneUI, self)
        self.mPickGoldSceneUI:open(args)
    else
        self.mPickGoldSceneUI:refreshView(args)
    end
end

-- ui销毁
function onDestroyPickGoldSceneUI(self)
    self.mPickGoldSceneUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPickGoldSceneUI, self)
    self.mPickGoldSceneUI = nil
end

-- 关闭蛋壳场景战斗界面
function onClosePickGoldSceneUI(self)
    if self.mPickGoldSceneUI then
        self.mPickGoldSceneUI:close()
    end
end

-- 打开蛋壳结算界面
function onOpePickGoldSettlementPanel(self, args)
    if self.mPickGoldSettlementPanel == nil then
        self.mPickGoldSettlementPanel = UI.new(pickGold.PickGoldSettlementPanel)
        self.mPickGoldSettlementPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPickGoldSettlementPanel, self)
    end
    self.mPickGoldSettlementPanel:open(args)
end

-- ui销毁
function onDestroyPickGoldSettlementPanel(self)
    self.mPickGoldSettlementPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPickGoldSettlementPanel, self)
    self.mPickGoldSettlementPanel = nil
end

---------------------------------------------------------------响应------------------------------------------------------------------

--面板数据
function onReceivePickGoldPanelInfo(self, msg)
    -- logAll(msg, "*s2c* 俄罗斯方块信息 18250")
    for _, stage_info in pairs(msg.dup_list) do
        pickGold.PickGoldManager:setPassStageScore(stage_info)
    end

    for _, task_info in pairs(msg.task_list) do
        if task_info.state == 2 then
            pickGold.PickGoldManager:setRewardInfo(task_info.id)
        end
    end

    GameDispatcher:dispatchEvent(EventName.PICKGOLD_RECEIVE_INFO)
    GameDispatcher:dispatchEvent(EventName.PICKGOLD_RECEIVE_REWARD)
    GameDispatcher:dispatchEvent(EventName.PICKGOLD_RECEIVE_TASK)

    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

--俄罗斯方块任务进度更新
-- function onReceivePickGoldTaskInfo(self, msg)
--     logAll(msg, "俄罗斯方块任务进度更新")
-- pickGold.PickGoldManager:setTaskInfo(msg.task_info)
-- GameDispatcher:dispatchEvent(EventName.PICKGOLD_RECEIVE_TASK)
-- end

--* s2c * 俄罗斯方块任务领取 返回 18253
function onReceivePickGoldTaskGet(self, msg)
    -- logAll(msg, "* s2c * 俄罗斯方块任务领取 返回 18253")
    if msg.result == 1 then
        for k, id in pairs(msg.task_id_list) do
            pickGold.PickGoldManager:setRewardInfo(id)
        end
        GameDispatcher:dispatchEvent(EventName.PICKGOLD_RECEIVE_REWARD)
    end
end

--通过返回
function onReceivePickGoldPassDup(self, msg)
    -- logAll(msg, "通过返回")
    local old_score = pickGold.PickGoldManager:getPassStageScore(msg.dup_info.id)
    local dup_config = pickGold.PickGoldManager:getDupConfigVo(msg.dup_info.id)
    pickGold.PickGoldManager:setPassStageScore(msg.dup_info)

    GameDispatcher:dispatchEvent(EventName.OPEN_PICKGOLD_SETTLEMENTPANEL, {dup_config = dup_config, score = msg.dup_info.point, first = old_score < dup_config.target_score})
end
-- -- ---------------------------------------------------------------请求------------------------------------------------------------------

-- --请求领取任务奖励
function onReqPickGoldRewardGetAward(self, reward_id_list)
    -- logAll(reward_id_list, "请求领取任务奖励")
    SOCKET_SEND(Protocol.CS_GOLD_TASK_GAIN, {task_id_list = reward_id_list}, Protocol.SC_GOLD_TASK_GAIN_RETURN)
end

--请求通关关卡
function onReqPickGoldPassStage(self, args)
    pickGold.PickGoldManager:setOpenSettlementPanel(true)

    local old_score = pickGold.PickGoldManager:getPassStageScore(args.dup_config.id)
    if args.score < args.dup_config.target_score or args.score <= old_score then
        GameDispatcher:dispatchEvent(EventName.OPEN_PICKGOLD_SETTLEMENTPANEL, {dup_config = args.dup_config, score = args.score})
        return
    end

    local cmd = {dup_id = args.dup_config.id, point = args.score}
    -- logAll(cmd, "请求通关关卡")
    SOCKET_SEND(Protocol.CS_PASS_GOLD, cmd, Protocol.SC_UPDATE_GOLD_INFO)
end

return _M
