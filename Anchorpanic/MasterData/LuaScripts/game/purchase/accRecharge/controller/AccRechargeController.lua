module("purchase.AccRechargeController", Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_ACCRECHARGE, self.__openAccRechargePanel, self)

    GameDispatcher:addEventListener(EventName.GET_ACCAWARD, self.__getAccAward, self)
end



--模块间事件监听
function listNotification(self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_ACC_PAY_PANEL = self.__onAccRechargeHandler,
        SC_ACC_PAY_AWARD = self.__onGetRechargeResultHandler,
    }
end

function __getAccAward(self, msg)
    SOCKET_SEND(Protocol.CS_ACC_PAY_AWARD, { acc_id = msg.id })
end

function __onAccRechargeHandler(self, msg)
    purchase.AccRechargeManager:parseAccRechargeData(msg)
end

function __onGetRechargeResultHandler(self, msg)
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACCRECHARGEPANEL)
end


function __openAccRechargePanel(self)
    if self.mAccRechargePanel == nil then
        self.mAccRechargePanel = purchase.AccRechargePanel.new()
        self.mAccRechargePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyAccRechargePanel, self)
    end
    self.mAccRechargePanel:open()

end

function onDestroyAccRechargePanel(self)
    self.mAccRechargePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyAccRechargePanel, self)
    self.mAccRechargePanel = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]