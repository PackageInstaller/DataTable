module("training.TrainingController", Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self,cusMgr)
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
    GameDispatcher:addEventListener(EventName.ENTER_TRAINING_SCENE, self.__onEnterTrainingSceneHandler, self)
    GameDispatcher:addEventListener(EventName.TRAINING_SCENE_LOAD_SUC, self.__onEnterTrainingSceneSucHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_TRAINING_RESULT_PANEL, self.__onOpenResultPanelHandler, self)
    
    GameDispatcher:addEventListener(EventName.REQ_TRAINING_PANEL_INFO, self.__onReqTrainingPanelInfoHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_TRAINING_RESULT_REC, self.__onReqTrainingResultRecHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_TRAINING_ELITE_BUY, self.__onReqTrainingEliteBuyHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 返回模拟训练面板信息 19132
        SC_TRAINING_PANEL_INFO = self.__onResTrainingPanelInfoHandler,
        --- *s2c* 领取模拟训练奖励返回 19134
        SC_GAIN_TRAINING_AWARD = self.__onResTrainingResultRecHandler,
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- 返回模拟训练面板信息
function __onResTrainingPanelInfoHandler(self, msg)
    training.TrainingManager:parsePanelInfoMsgHandler(msg)
    if(msg.is_one_end == 0)then
        GameDispatcher:dispatchEvent(EventName.RES_TRAINING_PANEL_INFO, {})
    else
        GameDispatcher:dispatchEvent(EventName.RES_ONE_TRAINING_END, {lastStepId = msg.last_step_id, lastEventId = msg.last_event_id})
    end
    -- 已开启则添加红点检测
    if(training.TrainingManager.startTime > 0)then
        self:__onUnLockTrainingHandler()
    end
    GameDispatcher:dispatchEvent(EventName.TRAINING_STATE_UPDATE)
end

-- 返回模拟训练成果领取
function __onResTrainingResultRecHandler(self, msg)
    -- msg.award
    GameDispatcher:dispatchEvent(EventName.OPEN_TRAINING_RESULT_PANEL, {})
end
---------------------------------------------------------------请求------------------------------------------------------------------
-- 请求模拟训练面板信息
function __onReqTrainingPanelInfoHandler(self, args)
    --- *c2s* 模拟训练面板信息 19131
    SOCKET_SEND(Protocol.CS_TRAINING_PANEL_INFO, {})
end

-- 请求模拟训练成果领取
function __onReqTrainingResultRecHandler(self, args)
    --- *c2s* 领取模拟训练奖励 19133
    SOCKET_SEND(Protocol.CS_GAIN_TRAINING_AWARD, {})
end

-- 请求模拟训练精英数据购买
function __onReqTrainingEliteBuyHandler(self, args)
    --- *c2s* 数据商人购买 19135
    SOCKET_SEND(Protocol.CS_TRAINING_BUSINESSMAN_BUY, {})
end

------------------------------------------------------------------------ 解锁模拟训练 ------------------------------------------------------------------------
function __onUnLockTrainingHandler(self)
    self:__updateTickTime()
    self.m_loopSn = LoopManager:addTimer(1, 0, self, self.__updateTickTime)
end

function __updateTickTime(self)
    local isBubbleChange = training.TrainingManager:isBubbleChange()
    if(isBubbleChange)then
        GameDispatcher:dispatchEvent(EventName.TRAINING_BUBBLE_UPDATE, training.TrainingManager:isBubble())
        mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_TRAINING, training.TrainingManager:isBubble())
    end
end

------------------------------------------------------------------------ 打开模拟训练面板 ------------------------------------------------------------------------
function __onEnterTrainingSceneHandler(self)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_TRAINING, true) == false then
        return
    end

    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.TRAINING)
end

function __onEnterTrainingSceneSucHandler(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_TRAINING, true) == false then
        return
	end
	
    if self.mPanel == nil then
        self.mPanel = training.TrainingPanel.new()
        self.mPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPanelHandler, self)
    end
    self.mPanel:open()
end

function onDestroyPanelHandler(self)
    self.mPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPanelHandler, self)
    self.mPanel = nil
end

------------------------------------------------------------------------ 打开模拟训练成果面板 ------------------------------------------------------------------------
function __onOpenResultPanelHandler(self, args)
    if self.mResultPanel == nil then
        self.mResultPanel = training.TrainingResultPanel.new()
        self.mResultPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyResultPanelHandler, self)
    end
    self.mResultPanel:open()
end

function onDestroyResultPanelHandler(self)
    self.mResultPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyResultPanelHandler, self)
    self.mResultPanel = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
