-- @FileName:   SandPlayHappyFarmShopPanel.lua
-- @Description:   开心农场商店界面
-- @Author: ZDH
-- @Date:   2024-01-17 11:40:13
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.view.SandPlayHappyFarmShopPanel', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("sandPlay/SandPlayHappyFarmShopPanel.prefab")

panelType = 2 -- 窗口类型 1 全屏 2 弹窗
isShowMoneyBar = 1

--构造函数
function ctor(self)
    super.ctor(self)

    self:setSize(1120, 519)
    self:setTxtTitle(_TT(137016))
end

-- 初始化数据
function initData(self)
    super.initData(self)
end

--初始化UI
function configUI(self)
    self.LyScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.LyScroller:SetItemRender(sandPlay.SandPlayHappyFarmShopItem)
end

function initViewText(self)
end

function addAllUIEvent(self)

end

--激活
function active(self, args)
    shop.ShopManager:addEventListener(shop.ShopManager.EVENT_SHOP_DATA_UPDATE, self.refreshView, self)
    shop.ShopManager:addEventListener(shop.ShopManager.EVENT_SHOP_TYPE_UPDATE, self.onShopUpdateHandler, self)
    shop.ShopManager:addEventListener(shop.ShopManager.EVENT_SHOP_ITEM_UPDATE, self.refreshView, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.refreshView, self)


    MoneyManager:setMoneyTidList({MoneyTid.HAPPYFARM_TID})

    self:refreshView()
end

--非激活
function deActive(self)
    MoneyManager:setMoneyTidList()

    shop.ShopManager:removeEventListener(shop.ShopManager.EVENT_SHOP_DATA_UPDATE, self.refreshView, self)
    shop.ShopManager:removeEventListener(shop.ShopManager.EVENT_SHOP_TYPE_UPDATE, self.onShopUpdateHandler, self)
    shop.ShopManager:removeEventListener(shop.ShopManager.EVENT_SHOP_ITEM_UPDATE, self.refreshView, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.refreshView, self)
    
end

-- 商店数据更新
function onShopUpdateHandler(self, cusType)
    if self:getShopType() == ShopType.HAPPYFARM then
        self:refreshView()
    end
end

function refreshView(self)
    local shopDataList = shop.ShopManager:getShopItemList(ShopType.HAPPYFARM)

    if self.LyScroller.Count <= 0 then
        self.LyScroller.DataProvider = shopDataList
    else
        self.LyScroller:ReplaceAllDataProvider(shopDataList)
    end
end

return _M
