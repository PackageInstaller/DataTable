module('activityTarget.ActitvtyTargetController', Class.impl(Controller))

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
    --self:__onActivityTargetInfoHandler()
end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_ACTIVITY_TARGET_PANEL,self.onOpenActivityTargetHandler,self)
    
    GameDispatcher:addEventListener(EventName.REQ_ACTIVITY_TARGET_GAIN_AWARD,self.onReqActivityTargetAward,self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 任务信息面板 24041
        SC_NOVICE_TARGET_PANEL_INFO = self.__onActivityTargetInfoHandler, 
        --- *s2c* 领取任务奖励 24043
        SC_GAIN_NOVICE_TARGET_AWARD = self.__onActivityTargetGainAwardHandler,
        --- *s2c* 更新任务进度 24044
        SC_UPDATE_NOVICE_TARGET_INFO = self.__onActivityTargetUpdateTaskInfoHandler,
    }
end

------------------------------------------------------------------------ 请求 ------------------------------------------------------------------------

--- *c2s* 请求领取任务奖励 24042
function onReqActivityTargetAward(self,msg)
    SOCKET_SEND(Protocol.CS_GAIN_NOVICE_TARGET_AWARD,{task_list = msg})
end


------------------------------------------------------------------------ 响应 ------------------------------------------------------------------------
--- *s2c* 任务信息面板 24041
function __onActivityTargetInfoHandler(self,msg)
    activityTarget.ActivityTargetManager:parseTaskListMsg(msg)
end

--- *s2c* 领取任务奖励 24043
function __onActivityTargetGainAwardHandler(self,msg)
    activityTarget.ActivityTargetManager:setTaskState(msg)
end

--- *s2c* 更新任务进度 24046
function __onActivityTargetUpdateTaskInfoHandler(self,msg)
    activityTarget.ActivityTargetManager:updateActivityTargetTask(msg)
end
---------------------------------------------------------------------- 界面 ------------------------------------------------------------------------
----------------------------新手目标界面----------------------------
function onOpenActivityTargetHandler(self,args)
    -- if self.mActivityTargetPanel == nil then
    --     self.mActivityTargetPanel = UI.new(activityTarget.ActivityTargetView)
    --     self.mActivityTargetPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestroyActivityTargetPanel,self)
    -- end
    -- self.mActivityTargetPanel:open(args)
end


function onDestroyActivityTargetPanel(self)
    -- self.mActivityTargetPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestroyActivityTargetPanel,self)
    -- self.mActivityTargetPanel = nil
end


---------------------------------------------------------------------- 事件 ------------------------------------------------------------------------



return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
