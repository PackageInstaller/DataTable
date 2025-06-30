module("permit.PermitController", Class.impl(Controller))


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
    --GameDispatcher:addEventListener(EventName.OPEN_PERMIT_PANEL, self.onOpenPermitPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_PERMIT_BUY_VIEW, self.onOpenPermitBuyView, self)
    GameDispatcher:addEventListener(EventName.OPEN_PERMIT_BUY_SHOW_VIEW, self.onOpenPermitBuyShowView, self)
    GameDispatcher:addEventListener(EventName.REQ_PERMIT_BUY_LV, self.onReqPermitBuyRuslt, self)
    GameDispatcher:addEventListener(EventName.REQ_PERMIT_RECIVE_LV_AWARD, self.onReqPermitRecRuslt, self)
    GameDispatcher:addEventListener(EventName.ONE_KEY_RECIVER, self.onReqPermitOneKeyRecRuslt, self)
end


--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 通行证面板 24101
        SC_PERMIT_PANEL = self.onResPermitPanel,
        --- *s2c* 购买通行证等级 24103
        SC_BUY_PERMIT_LV = self.onResPermitBuyRuslt,
        --- *s2c* 领取通行证奖励 24105
        SC_GAIN_PERMIT_REWARD = self.onResPermitRecRuslt,
    }
end

-------------------------------------------------响应-----------------------------------------
-- *s2c* 通行证面板 24101
function onResPermitPanel(self, msg)
    permit.PermitManager:parsePermitMsg(msg)
end
--- *s2c* 购买通行证Lv 24103
function onResPermitBuyRuslt(self, msg)
    permit.PermitManager:parsePermitBuyMsg(msg)
end
--- *s2c* 领取通行证奖励 24105
function onResPermitRecRuslt(self, msg)
    permit.PermitManager:parsePermitRecMsg(msg)
end
-------------------------------------------------请求-----------------------------------------
function onReqPermitPanel(self)
    --- *c2s* 通行证面板 24100
    SOCKET_SEND(Protocol.CS_PERMIT_PANEL, {})
end
--- *c2s* 购买通行证等级 24102
function onReqPermitBuyRuslt(self, msg)
    SOCKET_SEND(Protocol.CS_BUY_PERMIT_LV, { buy_lv = msg.buyLv })
end
--- *c2s* 领取通行证奖励 24104
function onReqPermitRecRuslt(self, msg)
    SOCKET_SEND(Protocol.CS_GAIN_PERMIT_REWARD, { lv = msg.lv, is_senior = msg.isSenior })
end

--- *c2s* 领取通行证奖励 24104
function onReqPermitOneKeyRecRuslt(self, msg)
    SOCKET_SEND(Protocol.CS_GAIN_ALL_PERMIT_REWARD, {})
end

-------------------------------------------------view-----------------------------------------
--function onOpenPermitPanel(self)
--    if permit.PermitManager:getIsPermitActivityAction() == false then
--        gs.Message.Show("活动已结束")
--        return
--    end
--    if self.mPermitPanel == nil then
--        self.mPermitPanel = permit.PermitPanel.new()
--        self.mPermitPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onPermitPanelDestroy, self)
--    end
--    self.mPermitPanel:open()
--end
--
--function onPermitPanelDestroy(self)
--    self.mPermitPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onPermitPanelDestroy, self)
--    self.mPermitPanel = nil
--end

function onOpenPermitBuyView(self)
    if self.mPermitBuyView == nil then
        self.mPermitBuyView = permit.PermitBuyView.new()
        self.mPermitBuyView:addEventListener(View.EVENT_VIEW_DESTROY, self.onmPermitBuyViewDestroy, self)
    end
    self.mPermitBuyView:open()
end

function onmPermitBuyViewDestroy(self)
    self.mPermitBuyView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onmPermitBuyViewDestroy, self)
    self.mPermitBuyView = nil
end

function onOpenPermitBuyShowView(self)
    if self.mPermitBuyShowView == nil then
        self.mPermitBuyShowView = permit.PermitBuyShowView.new()
        self.mPermitBuyShowView:addEventListener(View.EVENT_VIEW_DESTROY, self.onPermitBuyShowViewDestroy, self)
    end
    self.mPermitBuyShowView:open()
end

function onPermitBuyShowViewDestroy(self)
    self.mPermitBuyShowView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onPermitBuyShowViewDestroy, self)
    self.mPermitBuyShowView = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]