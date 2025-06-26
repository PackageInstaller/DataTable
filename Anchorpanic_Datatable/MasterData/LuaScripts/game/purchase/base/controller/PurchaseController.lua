module("purchase.PurchaseController", Class.impl(Controller))

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
    if self.mMgr then
        for i = 1, #self.mMgr do
            if (self.mMgr[i] and self.mMgr[i].resetData) then
                self.mMgr[i]:resetData()
            end
        end
    end
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    -- 打开购买面板
    GameDispatcher:addEventListener(EventName.OPEN_PURCHASE_PANEL, self.__onOpenPurchasePanelHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {}
end

---------------------------------------------------------------界面------------------------------------------------------------------
function __onOpenPurchasePanelHandler(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_PURCHASE, true) then
        if (not self.mPurchasePanel) then
            self.mPurchasePanel = purchase.PurchasePanel.new()
            local function _destroy()
                self.mPurchasePanel:removeEventListener(View.EVENT_VIEW_DESTROY, _destroy, self)
                self.mPurchasePanel = nil
            end
            self.mPurchasePanel:addEventListener(View.EVENT_VIEW_DESTROY, _destroy, self)
        end
        self.mPurchasePanel:open({ type = args.type })
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]