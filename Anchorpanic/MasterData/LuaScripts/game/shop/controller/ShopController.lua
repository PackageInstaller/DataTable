module('shop.ShopController', Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_SHOP_PANEL, self.onOpenShoppingPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_SHOP_BUY_PANEL, self.onOpenBuyPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_SHOP_BUY_VIEW, self.onOpenShopBuyPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_COVENANT_SHOP_PANEL, self.onOpenCovenantShopPanel, self)
    GameDispatcher:addEventListener(EventName.REQ_SHOP_BUY, self.__onReqShopBuyHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_SHOP_TYPE_DATA, self.__onReqShopTypeDataHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_SHOP_REFRESH, self.__onReqShopRefreshHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_SHOPPING_PANEL, self.onOpenShoppingPanel, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_SHOP_DATA = self.__onShopDataHandler,
        SC_SHOP_BUY = self.__onShopBuyHandler,
        SC_SHOP_TYPE_DATA = self.__onShopTypeDataHandler,
        SC_SHOP_REFRESH = self.__onShopRefreshHandler,
        SC_UPDATE_SHOP_DATA = self.__onShopDataUpdateHandler,
        SC_REFRESH_SHOP_DATA = self.onShopItemUpdate,
    }
end

--更新商店数据
function onShopItemUpdate(self, msg)
    shop.ShopManager:updateShopData(msg)
    if self.mBuyView and self.mBuyView.isPop == 1 then
        self.mBuyView:close()
    end

    if self.mBuyView2 and self.mBuyView2.isPop == 1 then
        self.mBuyView2:close()
    end
end

-- 商店数据
function __onShopDataHandler(self, msg)
    shop.ShopManager:parseShopDataMsg(msg)
    if self.mBuyView and self.mBuyView.isPop == 1 then
        self.mBuyView:close()
    end

    if self.mBuyView2 and self.mBuyView2.isPop == 1 then
        self.mBuyView2:close()
    end
end

-- 商店购买返回
function __onShopBuyHandler(self, msg)
    shop.ShopManager:parseShopBuyMsg(msg)
    local awardList = {}
    for _, v in pairs(msg.award_list) do
        if not awardList[v.tid] then
            awardList[v.tid] = v
        else
            awardList[v.tid].count = awardList[v.tid].count + v.count
        end
    end
    if msg.shop_type == ShopType.RETURNED then
        ShowAwardPanel:showPropsAwardMsg(msg.award_list)
    else
        for _, v in pairs(awardList) do
            local propsVo = LuaPoolMgr:poolGet(props.PropsVo)
            propsVo:setPropsAwardMsgData(v)
            gs.Message.Show('获得 ' .. propsVo:getName() .. 'x' .. propsVo.count)
            GameDispatcher:dispatchEvent(EventName.SHOPBUYSUCCESS, propsVo.tid)
        end
    end
end

--- *s2c* 某个类型商店的数据 17010
function __onShopTypeDataHandler(self, msg)
    shop.ShopManager:parseShopTypeDataMsg(msg)
end

--- *s2c* 请求商店刷新返回 17012
function __onShopRefreshHandler(self)
    gs.Message.Show('刷新成功')
end

--- *s2c* 更新商品信息 17019
function __onShopDataUpdateHandler(self, msg)
    shop.ShopManager:parseShopDataUpdateMsg(msg)
end

--- *c2s* 购买商店道具 17007
function __onReqShopBuyHandler(self, cusData)
    local cmd = {
        shop_type = cusData.type,
        shop_id = cusData.id,
        num = cusData.num
    }
    SOCKET_SEND(Protocol.CS_SHOP_BUY, cmd)
end

--- *c2s* 请求某个商店的数据 17009
function __onReqShopTypeDataHandler(self, cusType)
    local cmd = { shop_type = cusType }
    SOCKET_SEND(Protocol.CS_SHOP_TYPE_DATA, cmd)
end

--- *c2s* 请求商店刷新 17011
function __onReqShopRefreshHandler(self, cusType)
    local cmd = { shop_type = cusType }
    SOCKET_SEND(Protocol.CS_SHOP_REFRESH, cmd)
end

-- 商店页面
function __onOpenShopPanel(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_STOP, true) == false then
        return
    end

    if not args then
        for i, shopShowVo in ipairs(shop.ShopManager:getShopShowList()) do
            if funcopen.FuncOpenManager:isOpen(shopShowVo.funcId) then
                if not args then
                    local shopSubType = nil
                    if #shopShowVo.shopType > 1 then
                        for n, subType in ipairs(shopShowVo.shopType) do
                            if funcopen.FuncOpenManager:isOpen(shopShowVo.pageFuncId[n]) then
                                shopSubType = subType
                                break
                            end
                        end
                    end
                    args = { type = shopShowVo.sort, subType = shopSubType }
                    break
                end
            end
        end
    end
    if self.mShopPanel == nil then
        self.mShopPanel = UI.new(shop.ShopPanel)
        self.mShopPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.__onDestroyViewHandler, self)
    end
    self.mShopPanel:open(args)
end

-- ui销毁
function __onDestroyViewHandler(self)
    self.mShopPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    self.mShopPanel = nil
end
function onOpenShoppingPanel(self, args)
    if not args then
        args = {}
        if not args.type then
            args.type = 1
        end
        if not args.subType then
            args.subType = shop.getTabMainLsit()[1].funcId
        end
    end
    if self.mShoppingPanel == nil then
        self.mShoppingPanel = UI.new(shop.ShoppingPanel)
        self.mShoppingPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShoppingPanelHandler, self)
    end
    if self.mShoppingPanel.isPop == 0 then
        self.mShoppingPanel:open(args)
    else
        self.mShoppingPanel:openView(args)
    end
end

-- ui销毁
function onDestroyShoppingPanelHandler(self)
    self.mShoppingPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShoppingPanelHandler, self)
    self.mShoppingPanel = nil
end

-- 购买界面
function onOpenBuyPanel(self, cusShopVo)
    if self.mBuyView == nil then
        if cusShopVo.type == ShopType.CONVERT or cusShopVo.type == ShopType.ROGUELIKE or cusShopVo.type == ShopType.GUILD then
            self.mBuyView = UI.new(shop.ShopBuyView2)
        else
            self.mBuyView = UI.new(shop.ShopBuyView)
        end
        self.mBuyView:addEventListener(View.EVENT_VIEW_DESTROY, self.__onDestroyShopBuyViewHandler, self)
    end

    if cusShopVo.buyNum then
        self.mBuyView:open(cusShopVo.shopVo)
        self.mBuyView:setBuyNum(cusShopVo.buyNum)
    else
        self.mBuyView:open(cusShopVo)
    end
end

-- ui销毁
function __onDestroyShopBuyViewHandler(self)
    self.mBuyView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    self.mBuyView = nil
end

-- 商店购买界面
function onOpenShopBuyPanel(self, cusShopVo)
    if self.mBuyView2 == nil then
        self.mBuyView2 = UI.new(shop.ShopBuyView2)
        self.mBuyView2:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBuyViewHandler, self)
    end
    self.mBuyView2:open(cusShopVo)
end
-- ui销毁
function onDestroyBuyViewHandler(self)
    self.mBuyView2:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    self.mBuyView2 = nil
end

-- 打开盟约商店面板
function onOpenCovenantShopPanel(self, args)
    if self.mCovenantShopPanel == nil then
        self.mCovenantShopPanel = covenant.CovenantShopPanel.new()
        self.mCovenantShopPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShopPanelHandler, self)
    end
    self.mCovenantShopPanel:open(args)
end
-- ui销毁
function onDestroyShopPanelHandler(self)
    self.mCovenantShopPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShopPanelHandler, self)
    self.mCovenantShopPanel = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]