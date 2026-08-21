-- 1.1副本活动
module("game.activityStrengthTask.controller.activityStrengthTaskController", Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.REQ_RECIVE_ACTIVITY_STRENGTH_TASK_TASK_AWARD,self.onReqReciveCelebrationTaskAwardHandler,self)
    GameDispatcher:addEventListener(EventName.REQ_RECIVE_ACTIVITY_STRENGTH_TASK_TARGET_TASK_AWARD,self.onReqReciveCelebrationTaskTargetAwardHandler,self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_CELE_ACTIVITY_TASK2_PANEL = self.onResUpdateTaskPanelMsgHandler,
        SC_CELE_ACTIVITY_TASK2_UPDATE = self.onResUpdateTaskInfoMsgHandler,
        SC_CELE_ACTIVITY_TASK2_RECEIVE = self.onResUpdateTaskAwardListMsgHandler,
        SC_CELE_ACTIVITY_TASK2_TARGET_GAIN=self.onResUpdateTaskTargetInfoMsgHandler,
    }
end
---------------------------------------请求-----------------------------------------------------------------------------
--请求领取庆典任务奖励
function onReqReciveCelebrationTaskAwardHandler(self,list)
    SOCKET_SEND(Protocol.CS_CELE_ACTIVITY_TASK2_RECEIVE, {task_id_list=list}, Protocol.SC_CELE_ACTIVITY_TASK2_RECEIVE)
end
--请求领取庆典目标任务奖励
function onReqReciveCelebrationTaskTargetAwardHandler(self)
    SOCKET_SEND(Protocol.CS_CELE_ACTIVITY_TASK2_TARGET_GAIN, nil, Protocol.SC_CELE_ACTIVITY_TASK2_TARGET_GAIN)
end

-----------------------------------------响应---------------------------------------------------------------------------
-----------------周年庆-周年活动任务领取任务奖励更新-------------------
function onResUpdateTaskAwardListMsgHandler(self,msg)
    if msg.result then
        gs.Message.Show(_TT(41722))
        activityStrengthTask.ActivityStrengthTaskManager:updateCelebrationTaskReciveMsg(msg)
    else
        gs.Message.Show(_TT(44209))
    end
end
-----------------周年庆-庆典任务面板更新-------------------
function onResUpdateTaskPanelMsgHandler(self,msg)
    activityStrengthTask.ActivityStrengthTaskManager:parseCelebrationTaskPanelMsg(msg)
end

-----------------周年庆-庆典任务更新-------------------
function onResUpdateTaskInfoMsgHandler(self,msg)
    activityStrengthTask.ActivityStrengthTaskManager:parseCelebrationTaskInfoMsg(msg)
end
-----------------周年庆-庆典目标任务更新-------------------
function onResUpdateTaskTargetInfoMsgHandler(self,msg)
    activityStrengthTask.ActivityStrengthTaskManager:parseCelebrationTargetTaskInfoMsg(msg)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
