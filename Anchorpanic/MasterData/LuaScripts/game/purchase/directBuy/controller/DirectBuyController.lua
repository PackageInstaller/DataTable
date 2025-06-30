module("purchase.DirectBuyController", Class.impl(Controller))

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
    -- 打开直购礼包购买面板信息
    GameDispatcher:addEventListener(EventName.OPEN_DIRECT_BUY_MONEY_PANEL, self.__onOpenDirectBuyMoneyPanel, self)

    -- 请求直购礼包面板信息
    GameDispatcher:addEventListener(EventName.REQ_DIRECT_BUY_INFO, self.__onReqPanelInfoHandler, self)
    -- 请求直购礼包购买
    GameDispatcher:addEventListener(EventName.REQ_DIRECT_BUY_GO, self.__onReqPanelBuyHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 直购礼包面板信息 24097
        SC_DIRECT_GIFT_PANEL = self.__onResDirectBuyPanelInfoHandler,
        --- *s2c* 购买直购礼包道具 24099
        SC_DIRECT_GIFT_BUY = self.__onResDirectBuyHandler,
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- 更新直购礼包面板信息
function __onResDirectBuyPanelInfoHandler(self, msg)
    purchase.DirectBuyManager:parsePanelInfoMsg(msg)
end

-- 购买直购礼包道具
function __onResDirectBuyHandler(self, msg)
    purchase.DirectBuyManager:parseBuyResultMsg(msg)
end

---------------------------------------------------------------请求------------------------------------------------------------------
-- 请求直购礼包面板信息
function __onReqPanelInfoHandler(self, args)
    -- *c2s* 直购礼包面板信息 24096
    SOCKET_SEND(Protocol.CS_DIRECT_GIFT_PANEL, {})
end

-- 请求购买直购礼包道具
function __onReqPanelBuyHandler(self, args)
    --- *c2s* 购买直购礼包道具 24098
    SOCKET_SEND(Protocol.CS_DIRECT_GIFT_BUY, {goods_id = args.id, num = args.num},Protocol.SC_DIRECT_GIFT_BUY)
end

-- 购买界面
function __onOpenDirectBuyMoneyPanel(self, cusDirectBuyVo)
    if self.mBuyView == nil then
        self.mBuyView = purchase.DirectBuyMoneyView.new()
        local function _onDestroyShopBuyViewHandler()
            self.mBuyView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
            self.mBuyView = nil
        end
        self.mBuyView:addEventListener(View.EVENT_VIEW_DESTROY, _onDestroyShopBuyViewHandler, self)
    end
    self.mBuyView:open(cusDirectBuyVo)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
