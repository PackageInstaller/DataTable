-- @FileName:   BlockController.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2024-01-05 16:11:19
-- @Copyright:   (LY) 2023 雷焰网络

module("game.block.controller.BlockController", Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_BLOCK_STAGEPANEL, self.onOpenBlockStagePanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_BLOCK_REWARDVIEW, self.onOpeBlockRewardView, self)
    GameDispatcher:addEventListener(EventName.OPEN_BLOCK_SCENEUI, self.onOpeBlockSceneUI, self)
    GameDispatcher:addEventListener(EventName.CLOSE_BLOCK_SCENEUI, self.onCloseBlockSceneUI, self)
    GameDispatcher:addEventListener(EventName.OPEN_BLOCK_SETTLEMENTPANEL, self.onOpeBlockSettlementPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_BLOCK_DUPPANEL, self.onOpenBlockDupPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_BLOCK_DUPPANEL, self.onCloseBlockDupPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_BLOCK_TEACHINGVIEW, self.onOpenBlockTeachingPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_BLOCK_RANKPANEL, self.onOpenBlockRankPanel, self)

    GameDispatcher:addEventListener(EventName.ONREQ_BLOCK_PASS_DUP, self.onReqBlockPassStage, self)
    GameDispatcher:addEventListener(EventName.ONREQ_BLOCK_GET_AWARD, self.onReqBlockRewardGetAward, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return
    {
        SC_BLOCK_PANEL = self.onReceiveBlockPanelInfo, --- *s2c* 俄罗斯方块信息 18250
        -- SC_BLOCK_TASK_UPDATE = self.onReceiveBlockTaskInfo, --- *s2c* 俄罗斯方块任务进度更新 18251
        SC_BLOCK_TASK_GAIN_RETURN = self.onReceiveBlockTaskGet, --- *s2c* 俄罗斯方块任务领取 返回 18253
        SC_UPDATE_BLOCK_INFO = self.onReceiveBlockPassDup, --- *s2c* 更新俄罗斯方块信息 18255
    }
end
-------------------------------------------------------------数据--------------------------------------------------------------------

--------------------------------------------------------------打开UI界面(其他与角色玩家)----------------------------------------------
function onOpenBlockRankPanel(self, args)
    if self.mBlockRankPanel == nil then
        self.mBlockRankPanel = UI.new(block.BlockRankPanel)
        self.mBlockRankPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBlockRankPanel, self)
    end
    self.mBlockRankPanel:open(args)
end
-- ui销毁
function onDestroyBlockRankPanel(self)
    self.mBlockRankPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBlockRankPanel, self)
    self.mBlockRankPanel = nil
end

function onOpenBlockTeachingPanel(self, args)
    if self.mBlockTeachingPanel == nil then
        self.mBlockTeachingPanel = UI.new(block.BlockTeachingView)
        self.mBlockTeachingPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBlockTeachingPanel, self)

        self.mBlockTeachingPanel:open(args)
    else
        self.mBlockTeachingPanel:updateView(args)
    end
end
function onCloseBlockTeachingPanel(self, args)
    if self.mBlockTeachingPanel ~= nil then
        self.mBlockTeachingPanel:close()
    end
end
-- ui销毁
function onDestroyBlockTeachingPanel(self)
    self.mBlockTeachingPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBlockTeachingPanel, self)
    self.mBlockTeachingPanel = nil
end

function onOpenBlockDupPanel(self, args)
    if self.mBlockDupPanel == nil then
        self.mBlockDupPanel = UI.new(block.BlockDupPanel)
        self.mBlockDupPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBlockDupPanel, self)

        self.mBlockDupPanel:open(args)
    else
        self.mBlockDupPanel:updateView(args)
    end
end
function onCloseBlockDupPanel(self, args)
    if self.mBlockDupPanel ~= nil then
        self.mBlockDupPanel:close()
    end
end
-- ui销毁
function onDestroyBlockDupPanel(self)
    self.mBlockDupPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBlockDupPanel, self)
    self.mBlockDupPanel = nil
end

-- 打开蛋壳副本选择界面
function onOpenBlockStagePanel(self, args)
    if self.mBlockStagePanel == nil then
        self.mBlockStagePanel = UI.new(block.BlockStageMainUI)
        self.mBlockStagePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBlockStagePanel, self)
    end
    self.mBlockStagePanel:open(args)
end

-- ui销毁
function onDestroyBlockStagePanel(self)
    self.mBlockStagePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBlockStagePanel, self)
    self.mBlockStagePanel = nil
end

-- 打开蛋壳任务界面
function onOpeBlockRewardView(self, args)
    if self.mBlockRewardView == nil then
        self.mBlockRewardView = UI.new(block.BlockStarAwardView)
        self.mBlockRewardView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBlockRewardView, self)
    end
    self.mBlockRewardView:open(args)
end

-- ui销毁
function onDestroyBlockRewardView(self)
    self.mBlockRewardView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBlockRewardView, self)
    self.mBlockRewardView = nil
end

-- 打开蛋壳场景战斗界面
function onOpeBlockSceneUI(self, args)
    if self.mBlockSceneUI == nil then
        self.mBlockSceneUI = UI.new(block.BlockSceneUI)
        self.mBlockSceneUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBlockSceneUI, self)
        self.mBlockSceneUI:open(args)
    else
        self.mBlockSceneUI:refreshView(args)
    end
end

-- ui销毁
function onDestroyBlockSceneUI(self)
    self.mBlockSceneUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBlockSceneUI, self)
    self.mBlockSceneUI = nil
end

-- 关闭蛋壳场景战斗界面
function onCloseBlockSceneUI(self)
    if self.mBlockSceneUI then
        self.mBlockSceneUI:close()
    end
end

-- 打开蛋壳结算界面
function onOpeBlockSettlementPanel(self, args)
    if self.mBlockSettlementPanel == nil then
        self.mBlockSettlementPanel = UI.new(block.BlockSettlementPanel)
        self.mBlockSettlementPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBlockSettlementPanel, self)
    end
    self.mBlockSettlementPanel:open(args)
end

-- ui销毁
function onDestroyBlockSettlementPanel(self)
    self.mBlockSettlementPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBlockSettlementPanel, self)
    self.mBlockSettlementPanel = nil
end

---------------------------------------------------------------响应------------------------------------------------------------------

--面板数据
function onReceiveBlockPanelInfo(self, msg)
    -- logAll(msg, "*s2c* 俄罗斯方块信息 18250")
    for _, stage_info in pairs(msg.dup_list) do
        block.BlockManager:setPassStageScore(stage_info)
    end

    for _, task_info in pairs(msg.task_list) do
        -- block.BlockManager:setTaskInfo(task_info)
        if task_info.state == 2 then
            block.BlockManager:setRewardInfo(task_info.id)
        end
    end

    GameDispatcher:dispatchEvent(EventName.BLOCK_RECEIVE_INFO)
    GameDispatcher:dispatchEvent(EventName.BLOCK_RECEIVE_REWARD)
    GameDispatcher:dispatchEvent(EventName.BLOCK_RECEIVE_TASK)

    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

--俄罗斯方块任务进度更新
-- function onReceiveBlockTaskInfo(self, msg)
--     logAll(msg, "俄罗斯方块任务进度更新")
-- block.BlockManager:setTaskInfo(msg.task_info)
-- GameDispatcher:dispatchEvent(EventName.BLOCK_RECEIVE_TASK)
-- end

--* s2c * 俄罗斯方块任务领取 返回 18253
function onReceiveBlockTaskGet(self, msg)
    -- logAll(msg, "* s2c * 俄罗斯方块任务领取 返回 18253")
    if msg.result == 1 then
        for k, id in pairs(msg.task_id_list) do
            block.BlockManager:setRewardInfo(id)
        end
        GameDispatcher:dispatchEvent(EventName.BLOCK_RECEIVE_REWARD)
    end
end

--通过返回
function onReceiveBlockPassDup(self, msg)
    -- logAll(msg, "通过返回")
    local old_score = block.BlockManager:getPassStageScore(msg.dup_info.id)
    local dup_config = block.BlockManager:getDupConfigVo(msg.dup_info.id)
    block.BlockManager:setPassStageScore(msg.dup_info)

    GameDispatcher:dispatchEvent(EventName.OPEN_BLOCK_SETTLEMENTPANEL, {dup_config = dup_config, score = msg.dup_info.point, first = old_score < dup_config.target_score})
end
-- -- ---------------------------------------------------------------请求------------------------------------------------------------------

-- --请求领取任务奖励
function onReqBlockRewardGetAward(self, reward_id_list)
    -- logAll(reward_id_list, "请求领取任务奖励")
    SOCKET_SEND(Protocol.CS_BLOCK_TASK_GAIN, {task_id_list = reward_id_list})
end

--请求通关关卡
function onReqBlockPassStage(self, args)
    block.BlockManager:setOpenSettlementPanel(true)

    local old_score = block.BlockManager:getPassStageScore(args.dup_config.id)
    if args.score < args.dup_config.target_score or args.score <= old_score then
        GameDispatcher:dispatchEvent(EventName.OPEN_BLOCK_SETTLEMENTPANEL, {dup_config = args.dup_config, score = args.score})
        return
    end

    local cmd = {dup_id = args.dup_config.id, point = args.score}
    -- logAll(cmd, "请求通关关卡")
    SOCKET_SEND(Protocol.CS_PASS_BLOCK, cmd)
end

return _M
