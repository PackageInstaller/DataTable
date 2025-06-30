-- 主页签类型
ShopMainTabType = {}
--充值
ShopMainTabType.Recharge = 1
--商店
ShopMainTabType.Shop = 2

-- 商店图标
shop.getTabMainLsit = function()
    local tabLsit = {}
    table.insert(tabLsit, { page = ShopMainTabType.Recharge, nomalLan = _TT(52022), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_6.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_6.png"), list = purchase.getTabList() })
    table.insert(tabLsit, { page = ShopMainTabType.Shop, nomalLan = _TT(55009), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_6.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_6.png"), list = shop.ShopManager:getShopShowList() })
    return tabLsit
end

--[[ 替换语言包自动生成，请勿修改！
]]