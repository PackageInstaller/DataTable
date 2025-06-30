module("task.DailyTaskController", Class.impl(Controller))

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
    -- 打开每日任务积分奖励面板
    GameDispatcher:addEventListener(EventName.OPEN_DAILY_TASK_AWARD_PANEL, self.__onOpenDailyTaskScoreAwardHandler, self)
    -- 请求领取任务奖励
    GameDispatcher:addEventListener(EventName.REQ_REC_TASK_AWARD, self.__onReqRecTaskAwardHandler, self)
    -- 请求领取积分奖励
    GameDispatcher:addEventListener(EventName.REQ_REC_TASK_SCORE_AWARD, self.__onReqRecTaskScoreAwardHandler, self)
    -- 请求领取全部奖励
    GameDispatcher:addEventListener(EventName.REQ_REC_ALL_TASK_AWARD, self.__onReqRecAllTaskAwardHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 任务信息面板 24002
        SC_TASK_PANEL_INFO = self.__onResTaskPanelInfoHandler,
        --- *s2c* 领取任务奖励 24004
        SC_GAIN_TASK_AWARD = self.__onResGetTaskAwardHandler,
        --- *s2c* 领取积分奖励 24006
        SC_GAIN_SCORE_AWARD = self.__onResGetTaskScoreAwardHandler,
        --- *s2c* 更新任务进度 24007
        SC_UPDATE_TASK_INFO = self.__onResTaskInfoHandler,
        --- *s2c* 领取全部奖励 24009
        SC_GAIN_ALL_AWARD = self.__onResGetAllTaskAwardHandler,
        --- *s2c* 更新积分 24010
        SC_UPDATE_TASK_SCORE = self.__onResTaskScoreUpdateHandler,
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- 更新任务信息面板
function __onResTaskPanelInfoHandler(self, msg)
    task.DailyTaskManager:parseTaskListMsg(msg)
end

-- 更新领取任务奖励
function __onResGetTaskAwardHandler(self, msg)
    task.DailyTaskManager:updateTaskAward(msg)
end

-- 更新领取积分奖励
function __onResGetTaskScoreAwardHandler(self, msg)
    task.DailyTaskManager:updateTaskScoreAward(msg)
end

-- 更新任务进度
function __onResTaskInfoHandler(self, msg)
    task.DailyTaskManager:updateTaskListMsg(msg.task_info)
end

-- 领取全部奖励
function __onResGetAllTaskAwardHandler(self, msg)
    task.DailyTaskManager:updateAllTaskAward(msg)
end

-- 更新日常任务积分
function __onResTaskScoreUpdateHandler(self, msg)
    task.DailyTaskManager:updateDailyTaskScore(msg)
end

---------------------------------------------------------------请求------------------------------------------------------------------
-- 请求领取任务奖励
function __onReqRecTaskAwardHandler(self, args)
    --- *c2s* 请求领取任务奖励 24003
    SOCKET_SEND(Protocol.CS_GAIN_TASK_AWARD, { task_id = args.taskId })
end

-- 请求领取积分奖励
function __onReqRecTaskScoreAwardHandler(self, args)
    --- *c2s* 请求领取积分奖励 24005
    SOCKET_SEND(Protocol.CS_GAIN_SCORE_AWARD, { score_award_id = args.scoreAwardId })
end

-- 请求领取全部奖励
function __onReqRecAllTaskAwardHandler(self, args)
    --- *c2s* 请求领取全部奖励 24008
    SOCKET_SEND(Protocol.CS_GAIN_ALL_AWARD, { type = args.type })
end

------------------------------------------------------------------------ 打开每日任务积分奖励面板 ------------------------------------------------------------------------
function __onOpenDailyTaskScoreAwardHandler(self, args)
    if self.m_scoreAwardPanel == nil then
        self.m_scoreAwardPanel = task.DailyTaskScoreAwardPanel.new()
        self.m_scoreAwardPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyScoreAwardPanelHandler, self)
    end
    self.m_scoreAwardPanel:open()
    local scoreAwardVo = args
    self.m_scoreAwardPanel:setData(scoreAwardVo)
end

function onDestroyScoreAwardPanelHandler(self)
    self.m_scoreAwardPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyScoreAwardPanelHandler, self)
    self.m_scoreAwardPanel = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
