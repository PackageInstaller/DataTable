--[[ 
-----------------------------------------------------
@filename       : FirstChargeController
@Description    : 首充
@date           : 2023-4-2 
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("firstCharge.FirstChargeController", Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.REQ_RECEIVE_FIRSTCHARGE, self.onReqFirstChargeHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_FIRSTCHARGE_PANEL, self.onOpenFirstChargePanelHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 首充奖励面板信息 24212
        SC_FIRST_PAY_PANEL = self.onResFirstChargePanelMsg,
        --- *s2c* 领取首充奖励返回结果 24214
        SC_GAIN_FIRST_PAY = self.onResFirstChargeHandler,
    }
end

---------------------------------------------------------响应--------------------------------------------------------------

function onResFirstChargeHandler(self, msg)
    firstCharge.FirstChargeManager:parseFirstChargeMsg(msg)
end

function onResFirstChargePanelMsg(self, msg)
    firstCharge.FirstChargeManager:parseFirstChargePanelMsg(msg)
end

---------------------------------------------------------请求--------------------------------------------------------------
--请求签到
function onReqFirstChargeHandler(self, daily)
    SOCKET_SEND(Protocol.CS_GAIN_FIRST_PAY, { day = daily }, Protocol.SC_GAIN_FIRST_PAY)
end

---------------------------------------------------------界面-------------------------------------------------------------
--打开信息
function onOpenFirstChargePanelHandler(self, args)
    if self.mFirstChargePanel == nil then
        self.mFirstChargePanel = firstCharge.FirstChargePanel.new()
        self.mFirstChargePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFirstChargePanelHandler, self)
    end
    self.mFirstChargePanel:open(args)
end

function onDestroyFirstChargePanelHandler(self)
    self.mFirstChargePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFirstChargePanelHandler, self)
    self.mFirstChargePanel = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]