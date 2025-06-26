module("purchase.FashionShopController", Class.impl(Controller))

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
    -- 打开皮肤展示界面
    GameDispatcher:addEventListener(EventName.OPEN_SKIN_SHOW_VIEW, self.onOpenFashionShowViewHandler, self)
    -- 打开3D皮肤展示界面
    GameDispatcher:addEventListener(EventName.OPEN_SKIN_SHOW3D_VIEW, self.onOpenFashionShow3DViewHandler, self)
    -- 请求购买皮肤
    GameDispatcher:addEventListener(EventName.REQ_FASHION_SHOP_BUY, self.onReqFashionShopBuyHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_SKIN_SHOW_ONE_VIEW, self.onOpenFashionShowOneViewHandler, self)

    GameDispatcher:addEventListener(EventName.REQ_FASHION_COMBO_SHOP_BUY, self.onReqFashionShowShopBuyHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_SKIN_SHOW_ONE_VIEW_BUY, self.onOpenFashionShowOneBuyViewHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 皮肤商店面板 24131
        SC_FASHION_SHOP_PANEL = self.onResFashionShopInfoHandler,
        --- *s2c* 皮肤商店购买商品结果 24133
        SC_FASHION_SHOP_BUY = self.onResFashionShopBuyHandler,

        SC_FASHION_COMBO_SHOP_BUY = self.onResFashionComboShopBuyHandler
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- 更新时装/皮肤面板信息
function onResFashionShopInfoHandler(self, msg)
    purchase.FashionShopManager:parseFashionedInfoMsg(msg)
end
-- 更新皮肤商店购买商品结果
function onResFashionShopBuyHandler(self, msg)
    purchase.FashionShopManager:parseFashionBuyMsg(msg)
end


function onResFashionComboShopBuyHandler(self,msg)
    if msg.result == 1 then
        purchase.FashionShopManager:parseFashionComboBuyMsg(msg)
    end
end
---------------------------------------------------------------请求------------------------------------------------------------------
-- 请求皮肤商店购买商品
function onReqFashionShopBuyHandler(self, args)
    --- *c2s* 皮肤商店购买商品 24132
    SOCKET_SEND(Protocol.CS_FASHION_SHOP_BUY, { goods_id = args.id, is_use_discount = args.isUseDis })
end

function onReqFashionShowShopBuyHandler(self, args)
    SOCKET_SEND(Protocol.CS_FASHION_COMBO_SHOP_BUY, { goods_id = args.id },Protocol.SC_FASHION_COMBO_SHOP_BUY)
end
---------------------------------------------------------------界面创建------------------------------------------------------------------
function onOpenFashionShowViewHandler(self, args)
    if self.mFashionShowView == nil then
        self.mFashionShowView = purchase.FashionShowView.new()
        self.mFashionShowView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFashionShowView, self)
    end
    self.mFashionShowView:open(args)
end

function onDestroyFashionShowView(self)
    self.mFashionShowView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFashionShowView, self)
    self.mFashionShowView = nil
end

function onOpenFashionShow3DViewHandler(self, args)
    if self.FashionShow3D == nil then
        self.FashionShow3D = purchase.FashionShow3DView.new()
        self.FashionShow3D:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFashionShow3DView, self)
    end
    self.FashionShow3D:open(args)
end

function onDestroyFashionShow3DView(self)
    self.FashionShow3D:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFashionShow3DView, self)
    self.FashionShow3D = nil
end

-- 单个皮肤预览界面
function onOpenFashionShowOneViewHandler(self, args)
    if self.mFashionShowOneView == nil then
        self.mFashionShowOneView = purchase.FashionShowOneView.new()
        self.mFashionShowOneView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFashionShowOneView, self)
    end
    self.mFashionShowOneView:open(args)
end

function onDestroyFashionShowOneView(self)
    self.mFashionShowOneView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFashionShowOneView, self)
    self.mFashionShowOneView = nil
end

function onOpenFashionShowOneBuyViewHandler(self,args)
    if self.mFashionShowOneBuyView == nil then
        self.mFashionShowOneBuyView = purchase.FashionShowOneBuyView.new()
        self.mFashionShowOneBuyView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFashionShowOneBuyView, self)
    end
    self.mFashionShowOneBuyView:open(args)
end

function onDestroyFashionShowOneBuyView(self)
    self.mFashionShowOneBuyView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFashionShowOneBuyView, self)
    self.mFashionShowOneBuyView = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]