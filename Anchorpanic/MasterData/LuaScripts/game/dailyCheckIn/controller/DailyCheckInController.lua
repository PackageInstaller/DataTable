--[[ 
-----------------------------------------------------
@filename       : DailyCheckInController
@Description    : 每日签到
@date           : 2023-3-13 
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("dailyCheckIn.DailyCheckInController", Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_SIGNIN_PANEL, self.onOpenDailyCheckInPanelHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_SIGNIN, self.onReqDailyCheckInHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 每日签到 24035
        SC_DAILY_SIGN = self.onResDailyCheckInHandler,
        --- *s2c* 签到面板 24033
        SC_SIGN_PANEL = self.onResDailyCheckInPanelHandler
    }
end

---------------------------------------------------------响应--------------------------------------------------------------
--- *s2c* 每日签到 24035
function onResDailyCheckInHandler(self, msg)
    dailyCheckIn.DailyCheckInManager:parseDailyCheckInMsg(msg)
end

--- *s2c* 签到面板 24033
function onResDailyCheckInPanelHandler(self, msg)
    dailyCheckIn.DailyCheckInManager:parseDailyCheckInPanelMsg(msg)
end
---------------------------------------------------------请求--------------------------------------------------------------

--请求签到
function onReqDailyCheckInHandler(self)
    SOCKET_SEND(Protocol.CS_DAILY_SIGN, {}, Protocol.SC_DAILY_SIGN)
end

---------------------------------------------------------界面-------------------------------------------------------------
--打开信息
function onOpenDailyCheckInPanelHandler(self, args)
    if self.mDailyCheckInPanel == nil then
        self.mDailyCheckInPanel = dailyCheckIn.DailyCheckInPanel.new()
        self.mDailyCheckInPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDailyCheckInPanelHandler, self)
    end
    self.mDailyCheckInPanel:open(args)
end

function onDestroyDailyCheckInPanelHandler(self)
    self.mDailyCheckInPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDailyCheckInPanelHandler, self)
    self.mDailyCheckInPanel = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]