module("supercial.SupercialController", Class.impl(Controller))
-- 构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

-- 析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

-- 游戏开始的回调
function gameStartCallBack(self)
end

-- 模块间事件监听
function listNotification(self)

    GameDispatcher:addEventListener(EventName.OPEN_SUPERCIAL_PANEL, self.onOpenSupecialPanel, self)
    GameDispatcher:addEventListener(EventName.REQ_GET_SUPERCIAL_AWARD, self.reqSupercialAward, self)
    

    
end

-- 注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_SUPER_GIFT_PANEL = self.onSuperGiftPanel,
        SC_SUPER_GIFT_BUY = self.onBuySupercialAward,
    }
end

function onSuperGiftPanel(self,msg)
    supercial.SupercialManager:parseSupercialMsg(msg)
end

function reqSupercialAward(self,args)
    SOCKET_SEND(Protocol.CS_SUPER_GIFT_BUY, {goods_id=args.id}, Protocol.SC_SUPER_GIFT_BUY)
end

function onBuySupercialAward(self,msg)
    if msg.result == 1 then
        supercial.SupercialManager:updateRed()
        GameDispatcher:dispatchEvent(EventName.UPDATE_SUPERCIAL_PANEL,msg.goods_id)
    end
end

function onOpenSupecialPanel(self,args)
    if self.mSupercialPanel == nil then
        self.mSupercialPanel = supercial.SupercialPanel.new()
        self.mSupercialPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestorySupercialPanel,self)
    end
    self.mSupercialPanel:open(args)
end

function onDestorySupercialPanel(self)
    self.mSupercialPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestorySupercialPanel,self)
    self.mSupercialPanel = nil
end

return _M