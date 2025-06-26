--[[ 
-----------------------------------------------------
@filename       : NoviceNoviceActivityConst
@Description    : 新手活动控制器
@date           : 2023-6-5 16:50:35
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.noviceActivity.controller.NoviceActivityController', Class.impl(Controller))


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
    GameDispatcher:addEventListener(EventName.OPEN_NOVICE_ACTIVITY_PANEL, self.onOpenNoviceActivityPanel, self)
    GameDispatcher:addEventListener(EventName.REQ_RECEIVE_RECRUIT, self.onReqNoviceActivityRecruitRecive, self)
    GameDispatcher:addEventListener(EventName.REQ_RECEIVE_UPGRADE_PLAN_AWARD, self.onReqNoviceActivityPlanTaskRecive, self)
    GameDispatcher:addEventListener(EventName.REQ_RECEIVE_RECRUIT_BRACELETS, self.onReqNoviceActivityBraceletsRecive, self)
    GameDispatcher:addEventListener(EventName.REQ_RECEIVE_RETURN, self.onReqNoviceActivityReturnaskRecive, self)
    
    GameDispatcher:addEventListener(EventName.REQ_RAFFLE_REWARD,self.onReqWelfareRaffleHandler,self)
    noviceActivity.NoviceActivityManager:addEventListener(noviceActivity.NoviceActivityManager.UPDATE_RED, self.updateRed, self)

    GameDispatcher:addEventListener(EventName.REQ_NOVICE_SSR_GET,self.onReqNoviceSsrGet,self)
    GameDispatcher:addEventListener(EventName.REQ_NOVICE_ACTIVITY_RECHARGE_RECEIVE,self.onReqNoviceRechargeReceive,self)
   
    
    GameDispatcher:addEventListener(EventName.ACTIVITY_NOVICE_UPDATE, self.onUpdateNoviceEndTimeChange,self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 新手活动-战员招募面板数据 24220
        SC_ACTIVITY_NOVICE_RECRUIT_HERO_PANEL = self.onReceive_NoviceActivityRecruit_Panel_Handler,
        --- *s2c* 新手活动-战员招募领取奖励 24222
        SC_ACTIVITY_NOVICE_RECRUIT_HERO_RECEIVE = self.onReceive_NoviceActivityRecruit_Handler,

        --- *s2c* 新手活动-手环招募面板数据 24230
        SC_ACTIVITY_NOVICE_RECRUIT_BRACELET_PANEL = self.onReceive_NoviceActivityBraceletsPanel_Handler,
        --- *s2c* 新手活动-手环招募领取奖励 24232
        SC_ACTIVITY_NOVICE_RECRUIT_BRACELET_RECEIVE = self.onReceive_NoviceActivityBracelets_Handler,

        --- *s2c* 新手活动-升格计划面板数据 24240
        SC_ACTIVITY_NOVICE_UPGRADE_PANEL = self.onResNoviceActivityPlanPanel,
        --- *s2c* 新手活动-升格计划任务更新 24241
        SC_ACTIVITY_NOVICE_UPGRADE_UPDATE = self.onResNoviceActivityPlanTaskUpdate,
        --- *s2c* 新手活动-升格计划领取奖励 24243
        SC_ACTIVITY_NOVICE_UPGRADE_RECEIVE = self.onResNoviceActivityPlanTaskRecive,

        --- *s2c* 新手活动-成长返还面板数据 24260
        SC_ACTIVITY_NOVICE_RETURN_PANEL = self.onResNoviceActivity_Return_Panel,
        --- *s2c* 新手活动-成长返还任务更新 24261
        SC_ACTIVITY_NOVICE_RETURN_UPDATE = self.onResNoviceActivity_Return_Update,
        --- *s2c* 新手活动-成长返还领取奖励 24263
        SC_ACTIVITY_NOVICE_RETURN_RECEIVE = self.onResNoviceActivity_Return_Receive,

        --- *s2c* 新手活动-转盘面板数据 24300
        SC_ACTIVITY_NOVICE_TURNTABLE_PANEL = self.onNoiveTurntablePanel,
        --- *s2c* 新手活动-转盘面板抽奖 24302
        SC_ACTIVITY_NOVICE_TURNTABLE_DRAW = self.onNoviceTurntableDraw,
        --- *s2c* 作战储备-srr奖励-面板 24480
        SC_COMBAT_PREPARE_SSR_PANEL = self.onCombatPrepareSsrPanel,
        --- *s2c* 作战储备-累充奖励面板 24482
        SC_COMBAT_PREPARE_RECHARGE_PANEL = self.onCombatPrepareRechargePanel,

        SC_COMBAT_PREPARE_RECHARGE_RECEIVE = self.onUpdatePrepareRechargeReceive,
    }
end

---------------------------------------------------------S2C--------------------------------------------------
--- *s2c* 新手活动-战员招募面板数据 24220
function onReceive_NoviceActivityRecruit_Panel_Handler(self, msg)
    noviceActivity.NoviceActivityManager:parseNoviceActivityRecruitMsg(msg)
end

--- *s2c* 新手活动-战员招募领取奖励 24222  "result", "int8", "结果，1：成功 0：失败" 
function onReceive_NoviceActivityRecruit_Handler(self, msg)
    if msg.result then
        noviceActivity.NoviceActivityManager:updateNoviceActivityRecruitMsg(msg.id)
        GameDispatcher:dispatchEvent(EventName.UPDATE_RECEIVE_RECRUIT)
    else
        gs.Message.Show("领取失败")
    end
end

--- *s2c* 新手活动-手环招募面板数据 24230
function onReceive_NoviceActivityBraceletsPanel_Handler(self, msg)
    noviceActivity.NoviceActivityManager:parseNoviceActivityBraceletsMsg(msg)
end

--- *s2c* 新手活动-手环招募领取奖励 24232   "result", "int8", "结果，1：成功 0：失败" 
function onReceive_NoviceActivityBracelets_Handler(self, msg)
    if msg.result then
        noviceActivity.NoviceActivityManager:updateNoviceActivityBraceletsMsg(msg.id)
        GameDispatcher:dispatchEvent(EventName.UPDATE_RECEIVE_RECRUIT_BRACELETS)
    else
        gs.Message.Show("领取失败")
    end
end

--- *s2c* 新手活动-升格计划面板数据 24240
function onResNoviceActivityPlanPanel(self, msg)
    if msg then
        noviceActivity.NoviceActivityManager:parseUpgradePlanMsg(msg)
    end
end

--- *s2c* 新手活动-升格计划任务更新 24241
function onResNoviceActivityPlanTaskUpdate(self, msg)
    if msg then
        noviceActivity.NoviceActivityManager:parseUpgradePlanTaskUpdateMsg(msg)
    end
end

--- *s2c* 新手活动-升格计划领取奖励 24243
function onResNoviceActivityPlanTaskRecive(self, msg)
    if msg and msg.result == 1 then
        noviceActivity.NoviceActivityManager:parseUpgradePlanTaskReciveMsg(msg)
    else
        gs.Message.Show(_TT(27600))--领取失败
    end
end

--- *s2c* 新手活动-成长返还面板数据 24260
function onResNoviceActivity_Return_Panel(self, msg)
    if msg and next(msg) then
        noviceActivity.NoviceActivityManager:parseNoviceActivityReturnMsg(msg)
    else 
        logError("后端发空数据")
    end
end

--- *s2c* 新手活动-成长返还任务更新 24261
function onResNoviceActivity_Return_Update(self, msg)
    if msg and next(msg) then
        noviceActivity.NoviceActivityManager:updateNoviceActivityReturnMsg(msg)
    end
end
--- *s2c* 新手活动-成长返还领取奖励 24263
function onResNoviceActivity_Return_Receive(self, msg)
    if msg and msg.result == 1 then
        noviceActivity.NoviceActivityManager:oReturnAwardRecivedMsg(msg.id)
    else
        gs.Message.Show(_TT(27600))--领取失败
    end
end

--- *c2s* 新手活动-转盘面板抽奖 24301
function onReqWelfareRaffleHandler(self)
    SOCKET_SEND(Protocol.CS_ACTIVITY_NOVICE_TURNTABLE_DRAW,{},Protocol.SC_ACTIVITY_NOVICE_TURNTABLE_DRAW)
end
-----------------------------------------------协议请求--------------------------------------------------------------------------
--- *c2s* 新手活动-战员招募领取奖励 24221
function onReqNoviceActivityRecruitRecive(self, taskId)
    SOCKET_SEND(Protocol.CS_ACTIVITY_NOVICE_RECRUIT_HERO_RECEIVE, { id = taskId })
end

--- *c2s* 新手活动-手环招募领取奖励 24231
function onReqNoviceActivityBraceletsRecive(self, taskId)
    SOCKET_SEND(Protocol.CS_ACTIVITY_NOVICE_RECRUIT_BRACELET_RECEIVE, { id = taskId })
end

--- *c2s* 新手活动-升格计划领取奖励 24242
function onReqNoviceActivityPlanTaskRecive(self, taskId)
    SOCKET_SEND(Protocol.CS_ACTIVITY_NOVICE_UPGRADE_RECEIVE, { id = taskId })
end


--- *c2s* 新手活动-成长返还领取奖励 24262
function onReqNoviceActivityReturnaskRecive(self, taskId)
    SOCKET_SEND(Protocol.CS_ACTIVITY_NOVICE_RETURN_RECEIVE, { id = taskId })
end

--- *c2s* 作战储备-srr奖励-领取 24481
function onReqNoviceSsrGet(self)
    SOCKET_SEND(Protocol.CS_COMBAT_PREPARE_SSR_GET, {},Protocol.SC_COMBAT_PREPARE_SSR_PANEL)
end

--- *c2s* 领取作战储备-累充奖励 24483
function onReqNoviceRechargeReceive(self,taskId)
    SOCKET_SEND(Protocol.CS_COMBAT_PREPARE_RECHARGE_RECEIVE, { recharge_id = taskId },Protocol.SC_COMBAT_PREPARE_RECHARGE_RECEIVE)
end

-------------------------------------------------红点---------------------------------------------------------------------------
function updateRed(self, type)
    noviceActivity.NoviceActivityManager:updateBubble(type)
end


--- *s2c* 新手活动-转盘面板数据 24300
function onNoiveTurntablePanel(self,msg)
    noviceActivity.NoviceActivityManager:parseServeRaffle(msg)
end

--- *s2c* 新手活动-转盘面板抽奖 24302
function onNoviceTurntableDraw(self,msg)
    if msg.result == 1 then
        noviceActivity.NoviceActivityManager:parseServerRaffleDraw(msg)
    end
end

--- *s2c* 作战储备-srr奖励-面板 24480
function onCombatPrepareSsrPanel(self,msg)
    noviceActivity.NoviceActivityManager:parseSsrPanelInfoMsg(msg)
end

--- *s2c* 作战储备-累充奖励面板 24482
function onCombatPrepareRechargePanel(self,msg)
    noviceActivity.NoviceActivityManager:parseNoviceActivityRechargeMsg(msg)
end

function onUpdatePrepareRechargeReceive(self,msg)
    if msg.result == 1 then
        noviceActivity.NoviceActivityManager:updateNoviceActivityRechargeMsg(msg)
    end
end

-------------------------------------------------打开界面------------------------------------------------------------------------
function onOpenNoviceActivityPanel(self, args)
    if not args then
        args = {}
    end
    if not args.type then
        if activity.ActivityManager:getNoviceActivityIsOpen() then
            args.type = noviceActivity.NoviceActivityConst:getTabList()[1].page
        else
            if activity.ActivityManager:getNoviceActivitySsrIsOpen() then
                args.type = noviceActivity.NoviceActivityConst.NOVICEAVTIVITY_SSR
            end

            if activity.ActivityManager:getNoviceActivityRechargeIsOpen() then
                args.type = noviceActivity.NoviceActivityConst.NOVICEACTIVITY_RECHARGE
            end
        end
        
    end

    cusLog(args.type)
    if self.mNoviceActivityPanel == nil then
        self.mNoviceActivityPanel = noviceActivity.NoviceActivityPanel.new()
        self.mNoviceActivityPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyNoviceActivityPanel, self)
    end
    self.mNoviceActivityPanel:open(args)
end

function onDestroyNoviceActivityPanel(self)
    self.mNoviceActivityPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyNoviceActivityPanel, self)
    self.mNoviceActivityPanel = nil
end

function onUpdateNoviceEndTimeChange(self)
    if self.mNoviceActivityPanel then
        self.mNoviceActivityPanel:close()
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]