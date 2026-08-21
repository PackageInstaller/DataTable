--[[ 
-----------------------------------------------------
@filename       : DailyRechargeController
@Description    : 每日充值
@date           : 2026-06-01
@Author         : sxt
@copyright      : (LY) 雷焰网络
-----------------------------------------------------
]]
module("dailyRecharge.DailyRechargeController", Class.impl(Controller))

function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

function dtor(self)
end

function reLogin(self)
    super.reLogin(self)
end


function listNotification(self)
    -- 监听每日充值面板打开与奖励领取请求
    GameDispatcher:addEventListener(EventName.OPEN_DAILY_RECHARGE_PANEL, self.onOpenDailyRechargePanel, self)
    GameDispatcher:addEventListener(EventName.REQ_DAILY_RECHARGE_GAIN_AWARD, self.onReqDailyRechargeGainAward, self)
end

function registerMsgHandler(self)
    -- 注册每日累充面板数据与领取结果协议回调
    return {
        SC_DAY_ACC_PAY_PANEL = self.onDailyRechargePanelHandler,
        SC_DAY_ACC_PAY_GAIN_AWARD = self.onDailyRechargeGainAwardHandler,
    }
end

-- 解析服务端下发的每日充值面板数据
function onDailyRechargePanelHandler(self, msg)
    dailyRecharge.DailyRechargeManager:parseDailyRechargePanelData(msg)
end

-- 请求领取指定档位、指定天数的奖励
function onReqDailyRechargeGainAward(self, args)
    self.mLastReqGainAwardArgs = args
    SOCKET_SEND(Protocol.CS_DAY_ACC_PAY_GAIN_AWARD, { gear = args.gear, day = args.day })
end

-- 领取成功后本地置为已领取，并刷新红点和面板
function onDailyRechargeGainAwardHandler(self, msg)
    if msg.result == 1 then
        dailyRecharge.DailyRechargeManager:updateDailyRechargeAwardState(self.mLastReqGainAwardArgs)
        dailyRecharge.DailyRechargeManager:updateRed()
        GameDispatcher:dispatchEvent(EventName.UPDATE_DAILY_RECHARGE_PANEL)
    end
end

-- 打开每日充值面板
function onOpenDailyRechargePanel(self,args)
    if self.mDailyRechargePanel == nil then
        self.mDailyRechargePanel = dailyRecharge.DailyRechargePanel.new()
        self.mDailyRechargePanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onCloseDailyRechargePanel,self)
    end
    self.mDailyRechargePanel:open(args)
end

-- 面板销毁时清理引用
function onCloseDailyRechargePanel(self)
    self.mDailyRechargePanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onCloseDailyRechargePanel,self)
    self.mDailyRechargePanel = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
