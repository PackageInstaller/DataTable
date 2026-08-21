--[[
-----------------------------------------------------
@filename       : MiningController
@Description    : 捞宝藏小游戏控制管理器
@date           : 2023-11-28 17:22:06
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.mining.controller.MiningController', Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

--游戏开始的回调
function gameStartCallBack(self)

end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_MINING_SCENE, self.onOpenMiningScene, self)
    GameDispatcher:addEventListener(EventName.CLOSE_MINING_SCENE, self.onCloseMiningScene, self)
    GameDispatcher:addEventListener(EventName.OPEN_MINING_DUP_PANEL, self.onOpenMiningDupPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_MINING_DUP_INFO, self.onOpenMiningDupInfoView, self)
    GameDispatcher:addEventListener(EventName.OPEN_MINING_DUP_RESULT, self.onOpenMiningDupResultView, self)
    GameDispatcher:addEventListener(EventName.OPEN_MINING_STAR_REWARD, self.onOpenMiningStarAwardView, self)
    GameDispatcher:addEventListener(EventName.OPEN_MINING_RANK_PANEL, self.onOpenMiningRankPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_MINING_TASK_PANEL, self.onOpenMiningTaskView, self)

    GameDispatcher:addEventListener(EventName.SEND_MINING_REPLAY, self.onRepalyMiningDupHandler, self)
    GameDispatcher:addEventListener(EventName.SEND_MINING_EVENT_TO_SEVER, self.onReqMiningEventHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_MINING_PASS, self.onSendPassMinerHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_MINING_GAIN_STAR_REWARD, self.onReqMiningGainStarHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_MINING_GAIN_TASK_REWARD, self.onReqMiningGainTaskHandler, self)
    -- 断线重连
    GameDispatcher:addEventListener(EventName.ACCOUNT_RELOGIN_SUC, self.onReConnect, self)

end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_MINER_PANEL = self.onParseMinerPanelHandler,
        SC_MINER_TASK_UPDATE = self.onParseMinerTaskUpdateHandler,
        SC_MINER_TASK_GAIN_RETURN = self.onParseMinerTaskGainHandler,
        SC_UPDATE_MINER_INFO = self.onParseMinerInfoHandler,
        SC_GAIN_MINER_REWARD = self.onParseMinerRewardHandler,
    }
end

-- 重新开始
function onRepalyMiningDupHandler(self, args)
    self:onCloseMiningScene()
    self:onOpenMiningScene(args)
end

-- 断线重连
function onReConnect(self)
    if self.mMgr.passDupId ~= nil then
        self:onSendPassMinerHandler(self.mMgr.passDupId)
    end
end

--- *s2c* 挖矿信息 18130
function onParseMinerPanelHandler(self, msg)
    self.mMgr:onParseMinerPanelMsg(msg)
    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

--- *s2c* 挖矿任务进度更新 18132
function onParseMinerTaskUpdateHandler(self, msg)
    self.mMgr:onParseMinerTaskUpdateMsg(msg)
    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

--- *s2c* 挖矿任务领取 返回 18134
function onParseMinerTaskGainHandler(self, msg)
    self.mMgr:onParseMinerTaskGainMsg(msg)
    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

--- *s2c* 更新挖矿信息 18136
function onParseMinerInfoHandler(self, msg)
    self.mMgr.passDupId = nil --返回则表示后端收到了
    self.mMgr:onParseMinerInfoMsg(msg)
end

--- *s2c* 挖矿获取阶段奖励返回 18138
function onParseMinerRewardHandler(self, msg)
    self.mMgr:onParseMinerRewardMsg(msg)
    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

--- *c2s* 通关挖矿玩法 18135
function onSendPassMinerHandler(self, dupId)
    self.mMgr.passDupId = dupId --缓存用于可能断线没发送给后端成功
    if self.mMgr:getPlayerDupRecord(dupId) >= self.mMgr.currScore then
        -- 没有之前的高分，不保存了
        return
    end

    local cmd = {}
    cmd.dup_id = dupId
    cmd.point = self.mMgr.currScore
    SOCKET_SEND(Protocol.CS_PASS_MINER, cmd)
end

--- *c2s* 挖矿任务领取 18133
function onReqMiningGainTaskHandler(self, ids)
    SOCKET_SEND(Protocol.CS_MINER_TASK_GAIN, {task_id_list = ids})
end

--- *c2s* 挖矿获取阶段奖励 18137
function onReqMiningGainStarHandler(self, ids)
    SOCKET_SEND(Protocol.CS_GAIN_MINER_REWARD, {id_list = ids})
end

--- *c2s* 挖矿事件触发通知 18131
function onReqMiningEventHandler(self, id)
    SOCKET_SEND(Protocol.CS_MINER_EVENT, {id = id})
end

-- 挖矿游戏界面
function onOpenMiningScene(self, args)
    if not self.mMiningScene then
        self.mMiningScene = UI.new(mining.MiningScenePanel)
        self.mMiningScene:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMiningSceneHandler, self)
    end
    self.mMiningScene:open(args)
end

-- 关闭
function onCloseMiningScene(self)
    if self.mMiningScene and self.mMiningScene.isPop == 1 then
        self.mMiningScene:close()
    end
end

function onDestroyMiningSceneHandler(self)
    self.mMiningScene:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMiningSceneHandler, self)
    self.mMiningScene = nil
end

-- 取当前场景矿物列表
function getMiningSceneThingDic(self)
    if self.mMiningScene and self.mMiningScene.isPop == 1 then
        return self.mMiningScene:getThingDic()
    end
    return nil
end

-- 挖矿副本入口
function onOpenMiningDupPanel(self)
    if not self.mMiningDupPanel then
        self.mMiningDupPanel = UI.new(mining.MiningDupPanel)
        self.mMiningDupPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMiningDupPanelHandler, self)
    end
    self.mMiningDupPanel:open()
end

function onDestroyMiningDupPanelHandler(self)
    self.mMiningDupPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMiningDupPanelHandler, self)
    self.mMiningDupPanel = nil

    if self.mMiningDupInfoView and self.mMiningDupInfoView.isPop == 1 then
        self.mMiningDupInfoView:close()
    end
end

-- 挖矿副本信息
function onOpenMiningDupInfoView(self, args)
    if not self.mMiningDupInfoView then
        self.mMiningDupInfoView = UI.new(mining.MiningDupInfoView)
        self.mMiningDupInfoView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMiningDupInfoViewHandler, self)
    end
    if self.mMiningDupInfoView.isPop == 1 then
        self.mMiningDupInfoView:updateView(args)
    else
        self.mMiningDupInfoView:open(args)
    end
end

function onDestroyMiningDupInfoViewHandler(self)
    self.mMiningDupInfoView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMiningDupInfoViewHandler, self)
    self.mMiningDupInfoView = nil
end

-- 挖矿副本结算
function onOpenMiningDupResultView(self, args)
    if not self.mMiningDupResultView then
        self.mMiningDupResultView = UI.new(mining.MiningResultView)
        self.mMiningDupResultView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMiningDupResultViewHandler, self)
    end
    self.mMiningDupResultView:open(args)
end

function onDestroyMiningDupResultViewHandler(self)
    self.mMiningDupResultView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMiningDupResultViewHandler, self)
    self.mMiningDupResultView = nil
end

-- 挖矿副本结算
function onOpenMiningStarAwardView(self, args)
    if not self.mMiningStarAwardView then
        self.mMiningStarAwardView = UI.new(mining.MiningStarAwardView)
        self.mMiningStarAwardView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMiningStarAwardViewHandler, self)
    end
    self.mMiningStarAwardView:open(args)
end

function onDestroyMiningStarAwardViewHandler(self)
    self.mMiningStarAwardView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMiningStarAwardViewHandler, self)
    self.mMiningStarAwardView = nil
end

-- 挖矿排行榜
function onOpenMiningRankPanel(self, args)
    if not self.mMiningRankPanel then
        self.mMiningRankPanel = UI.new(mining.MiningRankPanel)
        self.mMiningRankPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMiningRankPanelHandler, self)
    end
    self.mMiningRankPanel:open(args)
end

function onDestroyMiningRankPanelHandler(self)
    self.mMiningRankPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMiningRankPanelHandler, self)
    self.mMiningRankPanel = nil
end

-- 挖矿任务
function onOpenMiningTaskView(self, args)
    if not self.mMiningTaskView then
        self.mMiningTaskView = UI.new(mining.MiningTaskView)
        self.mMiningTaskView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMiningTaskViewHandler, self)
    end
    self.mMiningTaskView:open(args)
end

function onDestroyMiningTaskViewHandler(self)
    self.mMiningTaskView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMiningTaskViewHandler, self)
    self.mMiningTaskView = nil
end

return _M
