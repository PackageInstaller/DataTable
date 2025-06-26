-- 1.1副本活动
module("Celebration.CelebrationController", Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.ACTIVITY_OPEN_UPDATE, self.onUpdateRedHandler, self)
    GameDispatcher:addEventListener(EventName.ACTIVITY_CLOSE_UPDATE, self.onUpdateRedHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_CELEBRATION_RED_STATE, self.onUpdateRedHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_CELEBRATION_PANEL, self.onOpenCelebrationPanelHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_RECIVE_SSR_OPTIONAL_AWARD,self.onReqReciveSSROptionalAwardHandler,self)
    GameDispatcher:addEventListener(EventName.REQ_RECIVE_RECHARGE_AWARD,self.onReqReciveCelebrationRechargetAwardHandler,self)
    GameDispatcher:addEventListener(EventName.REQ_RECIVE_CELEBRATION_TASK_AWARD,self.onReqReciveCelebrationTaskAwardHandler,self)
    GameDispatcher:addEventListener(EventName.REQ_RECIVE_CELEBRATION_TARGET_TASK_AWARD,self.onReqReciveCelebrationTaskTargetAwardHandler,self)

    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.onUpdateRedHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_CELE_MON_CARD_GIFT_SHOW = self.onResHadRecDownGiftMsgHandler,
        SC_CELE_ACTIVITY_TASK_PANEL = self.onResUpdateTaskPanelMsgHandler,
        SC_CELE_MON_CARD_GIFT = self.onResReciveSSROptionalAwardMsgHandler,
        SC_CELE_ACTIVITY_TASK_UPDATE = self.onResUpdateTaskInfoMsgHandler,
        SC_CELE_ACTIVITY_TASK_RECEIVE = self.onResUpdateTaskAwardListMsgHandler,
        SC_CELE_ACTIVITY_TASK_TARGET_GAIN=self.onResUpdateTaskTargetInfoMsgHandler,
        SC_CELE_RECHARGE_PANEL = self.onResUpdateAccRechargeInfoMsgHandler,
        SC_CELE_RECHARGE_RECEIVE=self.onResUpdateAccRechargeReciveMsgHandler,
    }
end
---------------------------------------请求-----------------------------------------------------------------------------
--请求领取SSR自选礼包奖励
function onReqReciveSSROptionalAwardHandler(self)
    SOCKET_SEND(Protocol.CS_CELE_MON_CARD_GIFT, nil, Protocol.SC_CELE_MON_CARD_GIFT)
end
--请求领取庆典任务奖励
function onReqReciveCelebrationTaskAwardHandler(self,list)
    SOCKET_SEND(Protocol.CS_CELE_ACTIVITY_TASK_RECEIVE, {task_id_list=list}, Protocol.SC_CELE_ACTIVITY_TASK_RECEIVE)
end
--请求领取庆典目标任务奖励
function onReqReciveCelebrationTaskTargetAwardHandler(self)
    SOCKET_SEND(Protocol.CS_CELE_ACTIVITY_TASK_TARGET_GAIN, nil, Protocol.SC_CELE_ACTIVITY_TASK_TARGET_GAIN)
end
--请求领取庆典充值任务奖励
function onReqReciveCelebrationRechargetAwardHandler(self,id)
    SOCKET_SEND(Protocol.CS_CELE_RECHARGE_RECEIVE, {recharge_id=id}, Protocol.SC_CELE_RECHARGE_RECEIVE)
end
-----------------------------------------响应---------------------------------------------------------------------------
-----------------周年庆ssr月卡自选领取结果返回-------------------
function onResReciveSSROptionalAwardMsgHandler(self,msg)
    if msg.result == 1 then
        gs.Message.Show(_TT(41722))
    else
        gs.Message.Show(_TT(44209))
    end
end
-----------------周年庆ssr月卡自选状态返回-------------------
function onResHadRecDownGiftMsgHandler(self,msg)
    Celebration.CelebrationManager:updateSSROptionalState(msg)
end
-----------------周年庆-周年活动任务领取任务奖励更新-------------------
function onResUpdateTaskAwardListMsgHandler(self,msg)
    if msg.result then
        gs.Message.Show(_TT(41722))
        Celebration.CelebrationManager:updateCelebrationTaskReciveMsg(msg)
    else
        gs.Message.Show(_TT(44209))
    end
end
-----------------周年庆-庆典任务面板更新-------------------
function onResUpdateTaskPanelMsgHandler(self,msg)
    Celebration.CelebrationManager:parseCelebrationTaskPanelMsg(msg)
end

-----------------周年庆-庆典任务更新-------------------
function onResUpdateTaskInfoMsgHandler(self,msg)
    Celebration.CelebrationManager:parseCelebrationTaskInfoMsg(msg)
end
-----------------周年庆-庆典目标任务更新-------------------
function onResUpdateTaskTargetInfoMsgHandler(self,msg)
    Celebration.CelebrationManager:parseCelebrationTargetTaskInfoMsg(msg)
end
-----------------周年庆-庆典纍計充值面板更新-------------------
function onResUpdateAccRechargeInfoMsgHandler(self,msg)
    Celebration.CelebrationManager:updateCelebrationTaskInfoMsg(msg)
end
-----------------周年庆-庆典纍計充值领取更新-------------------
function onResUpdateAccRechargeReciveMsgHandler(self,msg)
    Celebration.CelebrationManager:updateAccRechargeReciveMsg(msg)
end
------------------周年庆红点----------------------------
function onUpdateRedHandler(self)
    Celebration.CelebrationManager:updateCelebrationRed()
end
-------------------------------------界面--------------------------------------------------------------------------------
-- 打开周年庆面板
function onOpenCelebrationPanelHandler(self,args)
    if not args then
        args = {}
    end
    local curPage = Celebration.CelebrationConst:getTabList()[1].page
    for i, pageVo in pairs(Celebration.CelebrationConst:getTabList()) do
        if activity.ActivityManager:getActivityVoById(pageVo.activityId) and  activity.ActivityManager:getActivityVoById(pageVo.activityId):isOpen() then
            curPage = pageVo.page
            break
        end
    end
    if not args.type then
        args.type = curPage
    end
    if  (not self:checkActivityIsOpen(args.type)) or (not self:checkActivityIsOpen(Celebration.CelebrationConst.Celebration_Task)) then
        gs.Message.Show(_TT(94503))
        return
    end
    if self.mCelebrationPanel == nil then
        self.mCelebrationPanel = Celebration.CelebrationPanel.new()
        self.mCelebrationPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyCelebrationPanelHandler, self)
    end
    self.mCelebrationPanel:open(args)
end

function checkActivityIsOpen(self,type)
    for _, pagevo in ipairs(Celebration.CelebrationConst:getTabList()) do
        if pagevo.page==type then
            return (activity.ActivityManager:getActivityVoById(pagevo.activityId) and activity.ActivityManager:getActivityVoById(pagevo.activityId):isOpen())
        end
    end
    return false
end

-- ui销毁
function onDestroyCelebrationPanelHandler(self)
    if self.mCelebrationPanel ~= nil then
        self.mCelebrationPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyCelebrationPanelHandler, self)
        self.mCelebrationPanel = nil
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
