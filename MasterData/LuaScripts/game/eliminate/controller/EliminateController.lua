--[[ 
-----------------------------------------------------
@filename       : EliminateController
@Description    : 消消乐
@date           : 2020-12-28 17:14:24
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('eliminate.EliminateController', Class.impl(Controller))

--构造
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
    if self.mMgr then
        for i = 1, #self.mMgr do
            if(self.mMgr[i] and self.mMgr[i].resetData)then
                self.mMgr[i]:resetData()
            end
        end
    end
end

--析构函数
function dtor(self)
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_ELIMINATE_CHALLENGE_PANEL, self.onOpenEliminateChallengePanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_ELIMINATE_TASK_PANEL, self.onOpenEliminateTaskPanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_ELIMINATE_PANEL, self.onOpenEliminatePanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_ELIMINATE_STAGE_PANEL, self.onOpenEliminateStagePanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_ELIMINATE_RESULT_PANEL, self.onOpenEliminateResultPanelHandler, self)
    GameDispatcher:addEventListener(EventName.CLOSE_ELIMINATE_PANEL, self.onCloseEliminatePanelHandler, self)

    GameDispatcher:addEventListener(EventName.REQ_ELIMINATE_RECORD, self.onReqEliminateRecoreHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_ELIMINATE_TASK_AWARD, self.onReqTaskAwardHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_ELIMINATE_STAGE_PASS, self.onReqStagePassHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 消消乐面板 18160
        SC_XIAOXIAOLE_PANEL = self.onResEliminatePanelHandler,
        --- *s2c* 任务进度更新 18162
        SC_XIAOXIAOLE_TASK_UPDATE = self.onResUpdateEliminateTaskHandler,
        --- *s2c* 任务领取返回 18164
        SC_XIAOXIAOLE_TASK_GAIN_RETURN = self.onResGainEliminateTaskHandler,
        --- *s2c* 消消乐关卡更新 18165
        SC_UPDATE_XIAOXIAOLE_INFO = self.onResUpdateEliminateStageHandler,
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------
--- *s2c* 消消乐面板 18160
function onResEliminatePanelHandler(self, msg)
    eliminate.EliminateManager:praseTaskList(msg.task_info)
    eliminate.EliminateManager:praseHadPassStageIdList(msg.dup_list)
end

--- *s2c* 任务进度更新 18162
function onResUpdateEliminateTaskHandler(self, msg)
    eliminate.EliminateManager:praseTask(msg.task_info)
end

--- *s2c* 任务领取返回 18164
function onResGainEliminateTaskHandler(self, msg)
    if(msg.result == 1)then
        local recTaskIdList = msg.task_id_list
        for i = 1, #recTaskIdList do
            local taskVo = eliminate.EliminateManager:getTaskVoById(recTaskIdList[i])
            if(taskVo)then
                taskVo:setState(task.AwardRecState.HAS_REC)
                GameDispatcher:dispatchEvent(EventName.UPDATE_ELIMINATE_TASK, taskVo)
                GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
            end
        end
    else
        gs.Message.Show(_TT(27600)) --"领取失败"
    end
end

--- *s2c* 消消乐关卡更新 18165
function onResUpdateEliminateStageHandler(self, msg)
    eliminate.EliminateManager:praseHadPassStageIdList(msg.dup_list)
end

---------------------------------------------------------------请求------------------------------------------------------------------
-- 请求消消乐消除记录
function onReqEliminateRecoreHandler(self, typeDic)
    local dic = {}
    for _, thingType in pairs(typeDic)do
        dic[thingType] = (dic[thingType] or 0) + 1
    end
    local typeList = {}
    for thingType, count in pairs(dic) do
        table.insert(typeList, {key = thingType, value = count})
    end
    SOCKET_SEND(Protocol.CS_XIAOXIAOLE_EVENT, { event_list = typeList }, nil)
end

-- 请求消消乐任务领取
function onReqTaskAwardHandler(self, taskConfigVoList)
    local taskIdList = {}
    for i = 1, #taskConfigVoList do
        table.insert(taskIdList, taskConfigVoList[i].taskId)
    end
    --- *c2s* 任务领取 18163
    SOCKET_SEND(Protocol.CS_XIAOXIAOLE_TASK_GAIN, {task_id_list = taskIdList}, Protocol.SC_XIAOXIAOLE_TASK_GAIN_RETURN)
end

-- 请求消消乐关卡通关
function onReqStagePassHandler(self, stageId)
    --- *c2s* 通关挖矿玩法 18166
    SOCKET_SEND(Protocol.CS_PASS_XIAOXIAOLE, {dup_id = stageId}, nil)
end

---------------------------------------------------------------界面------------------------------------------------------------------
-- 打开消消乐挑战入口界面
function onOpenEliminateChallengePanelHandler(self, args)
    local isActivityOpen = activity.ActivityManager:checkIsOpenById(activity.ActivityId.Eliminate)
    if (isActivityOpen) then
            if self.mEliminateChallengePanel == nil then
                self.mEliminateChallengePanel = eliminate.EliminateChallengePanel.new()
                self.mEliminateChallengePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEliminateChallengePanelHandler, self)
            end
            self.mEliminateChallengePanel:open()
    else
        local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.Eliminate)
        gs.Message.Show(activityVo:getLockDec())
    end
end
-- ui销毁
function onDestroyEliminateChallengePanelHandler(self)
    self.mEliminateChallengePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEliminateChallengePanelHandler, self)
    self.mEliminateChallengePanel = nil

    if self.mEliminateStagePanel ~= nil then
        self.mEliminateStagePanel:close()
    end
end

-- 打开消消乐任务界面
function onOpenEliminateTaskPanelHandler(self, args)
    if self.mEliminateTaskPanel == nil then
        self.mEliminateTaskPanel = eliminate.EliminateTaskPanel.new()
        self.mEliminateTaskPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEliminateTaskPanelHandler, self)
    end
    self.mEliminateTaskPanel:open()
end
-- ui销毁
function onDestroyEliminateTaskPanelHandler(self)
    self.mEliminateTaskPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEliminateTaskPanelHandler, self)
    self.mEliminateTaskPanel = nil
end

-- 打开消消乐界面
function onOpenEliminatePanelHandler(self, stageConfigVo)
    eliminate.EliminateManager:setRunStageConfigVo(stageConfigVo)
    if self.mEliminatePanel == nil then
        self.mEliminatePanel = eliminate.EliminatePanel.new()
        self.mEliminatePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEliminatePanelHandler, self)
    end
    self.mEliminatePanel:open()
end
-- ui销毁
function onDestroyEliminatePanelHandler(self)
    eliminate.EliminateManager:setRunStageConfigVo(nil)
    self.mEliminatePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEliminatePanelHandler, self)
    self.mEliminatePanel = nil
end

-- 打开消消乐关卡界面
function onOpenEliminateStagePanelHandler(self, stageConfigVo)
    if(self.mEliminateStagePanel)then
        self.mEliminateStagePanel:close()
        self.mEliminateStagePanel = nil
    end
    if self.mEliminateStagePanel == nil then
        self.mEliminateStagePanel = eliminate.EliminateStagePanel.new()
        self.mEliminateStagePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEliminateStagePanelHandler, self)
    end
    self.mEliminateStagePanel:setData(stageConfigVo)
    self.mEliminateStagePanel:open()
end
-- ui销毁
function onDestroyEliminateStagePanelHandler(self)
    self.mEliminateStagePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEliminateStagePanelHandler, self)
    self.mEliminateStagePanel = nil
end

-- 打开消消乐结果界面
function onOpenEliminateResultPanelHandler(self, isWin)
    if self.mEliminateResultPanel == nil then
        self.mEliminateResultPanel = eliminate.EliminateResultPanel.new()
        self.mEliminateResultPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEliminateResultPanelHandler, self)
    end
    self.mEliminateResultPanel:open(isWin)
end
-- ui销毁
function onDestroyEliminateResultPanelHandler(self)
    self.mEliminateResultPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEliminateResultPanelHandler, self)
    self.mEliminateResultPanel = nil
end

-- 关闭消消乐结果界面
function onCloseEliminatePanelHandler(self, isWin)
    if self.mEliminatePanel ~= nil then
        self.mEliminatePanel:close()
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
