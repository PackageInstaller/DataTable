purchase.PurchaseTab = {
    --商城推荐
    Recommended = 1,
    -- 充值
    RECHARGE = 2,
    -- 直购礼包
    DIRECT_BUY = 3,
    -- 皮肤商店
    SKIN_SHOP = 4,
    -- 月卡
    MONTH_CARD = 5,
    -- 等级礼包
    GRADE_GIFT = 6,
    --时装币商店
    FASHIONCION_SHOP = 7,
    --体力月卡
    STRENGTH_CARD = 8,
}

purchase.TabType = {
    -- 充值
    RECHARGE = funcopen.FuncOpenConst.FUNC_ID_PURCHASE_RECHARGE,
    -- 直购礼包
    DIRECT_BUY = funcopen.FuncOpenConst.FUNC_ID_PURCHASE_DIRECT_BUY,
    -- 皮肤商店
    SKIN_SHOP = funcopen.FuncOpenConst.FUNC_ID_SKIN_SHOP,
    --时装币商店
    FASHIONCION_SHOP = funcopen.FuncOpenConst.FUNC_ID_FASHIONCION_SHOP,
    -- 月卡
    MONTH_CARD = funcopen.FuncOpenConst.FUNC_ID_PURCHASE_MONTH_CARD,
    -- 等级礼包
    GRADE_GIFT = funcopen.FuncOpenConst.FUNC_ID_GRADE_GIFT,
    --体力月卡
    STRENGTH_CARD = funcopen.FuncOpenConst.FUNC_ID_STRENGTH_CARD,
}

purchase.getTabList = function(self)
    local tabList = {}
    if(not GameManager:getIsInCommiting())then
        --商城推荐
        table.insert(tabList, {page = purchase.PurchaseTab.Recommended, nomalLan = _TT(50068), funcId = funcopen.FuncOpenConst.FUNC_ID_SHOPPING, nomalLanEn = "RECHARGE", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_6.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_6.png"), view = shop.ShopRecommendedView})
    end
    -- 充值
    --  if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_PURCHASE_RECHARGE, false)) then
    table.insert(tabList, {page = purchase.PurchaseTab.RECHARGE, nomalLan = _TT(50009), funcId = funcopen.FuncOpenConst.FUNC_ID_PURCHASE_RECHARGE, nomalLanEn = "RECHARGE", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_6.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_6.png"), view = purchase.RechargeCostView})
    -- end
    -- 直购礼包
    if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_PURCHASE_DIRECT_BUY, false)) then
        table.insert(tabList, {page = purchase.PurchaseTab.DIRECT_BUY, nomalLan = _TT(50008), funcId = funcopen.FuncOpenConst.FUNC_ID_PURCHASE_DIRECT_BUY, nomalLanEn = "Direct buy", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_9.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_9.png"), view = purchase.DirectBuyView})
    end
    -- 皮肤商店
    if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_SKIN_SHOP, false) and #purchase.FashionShopManager:getCurShopList(fashionShop.ShopType.NOMAL) > 0) then
        table.insert(tabList, {page = purchase.PurchaseTab.SKIN_SHOP, nomalLan = _TT(50033), funcId = funcopen.FuncOpenConst.FUNC_ID_SKIN_SHOP, nomalLanEn = "Skin shop", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_7.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_5.png"), view = purchase.FashionShopComboView})
    end
    -- 时装币商店
    if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FASHIONCION_SHOP, false) and #purchase.FashionShopManager:getCurShopList(fashionShop.ShopType.FASHIONCOIN) > 0) then
        table.insert(tabList, {page = purchase.PurchaseTab.FASHIONCION_SHOP, nomalLan = _TT(50064), funcId = funcopen.FuncOpenConst.FUNC_ID_FASHIONCION_SHOP, nomalLanEn = "Skin shop", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_7.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_5.png"), view = purchase.FashionShopCoinView})
    end
    -- 月卡
    if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_PURCHASE_MONTH_CARD, false)) then
        table.insert(tabList, {page = purchase.PurchaseTab.MONTH_CARD, nomalLan = _TT(50002), funcId = funcopen.FuncOpenConst.FUNC_ID_PURCHASE_MONTH_CARD, nomalLanEn = "Month card", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_45.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_45.png"), view = purchase.MonthCardView})
    end

    if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_STRENGTH_CARD, false)) then
        table.insert(tabList, {page = purchase.PurchaseTab.STRENGTH_CARD, nomalLan = _TT(50072), funcId = funcopen.FuncOpenConst.FUNC_ID_STRENGTH_CARD, nomalLanEn = "Month card", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_45.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_45.png"), view = purchase.StrengthCardView})
    end
    -- 等级礼包
    if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_GRADE_GIFT, false) and (not purchase.GradeGiftManager:getGradeGiftAllOver())) then
        table.insert(tabList, {page = purchase.PurchaseTab.GRADE_GIFT, nomalLan = _TT(50032), funcId = funcopen.FuncOpenConst.FUNC_ID_GRADE_GIFT, nomalLanEn = "Grade gift", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_7.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_7.png"), view = purchase.GradeGiftView})
    end

    return tabList
end

purchase.getPageName = function(cusPageType)
    local name = ""
    if (cusPageType == purchase.PurchaseTab.RECHARGE) then--充值
        name = _TT(50009)
    elseif (cusPageType == purchase.PurchaseTab.DIRECT_BUY) then--直购礼包
        name = _TT(50008)
    elseif (cusPageType == purchase.PurchaseTab.SKIN_SHOP) then--皮肤商店
        name = _TT(50033)
    elseif (cusPageType == purchase.PurchaseTab.FASHIONCION_SHOP) then--时装币商店
        name = _TT(50064)
    elseif (cusPageType == purchase.PurchaseTab.MONTH_CARD) then--月卡
        name = _TT(50002)
    elseif (cusPageType == purchase.PurchaseTab.GRADE_GIFT) then--等级礼包
        name = _TT(50032)
    elseif (cusPageType == purchase.PurchaseTab.STRENGTH_CARD) then--等级礼包
        name = "体力月卡"
    end
    return name
end

purchase.getPageNameEn = function(cusPageType)
    local name = ""
    if (cusPageType == purchase.PurchaseTab.RECHARGE) then--充值
        name = "RECHARGE"
    elseif (cusPageType == purchase.PurchaseTab.DIRECT_BUY) then--直购礼包
        name = "Direct buy"
    elseif (cusPageType == purchase.PurchaseTab.SKIN_SHOP) then--皮肤商店
        name = "Skin shop"
    elseif (cusPageType == purchase.PurchaseTab.MONTH_CARD) then--月卡
        name = "Month card"
    elseif (cusPageType == purchase.PurchaseTab.GRADE_GIFT) then--等级礼包
        name = "Grade gift"
    end
    return name
end

-- 直购礼包子类型和配置的子类型一致
purchase.DirectBuySubTab = {
    -- 直购
    DIRECT_BUY = 1,
    -- 家具
    DORMITORY = 2,
    -- 限时
    LIMITED = 3,
    -- 抽卡
    RECRUIT = 4,
    -- 体力
    POWER = 5,
}

-- 直购礼包限购类型
purchase.DirectBuyLimitType = {
    -- 不限购
    UN_LIMIT = 0,
    -- 每日
    EVERY_DAY = 1,
    -- 每周
    EVERY_WEEK = 2,
    -- 每月
    EVERY_MONTH = 3,
    -- 终生
    LIFETIME = 4,
    -- 活动期间限购
    ACTIVITY = 5,
}


-- 获取建筑名字
purchase.getFashionShopComboList = function(type)
    local tabList = {}
    table.insert(tabList, {page = fashionShop.ShopType.COMBO, nomalLanId =84510, funcId = funcopen.FuncOpenConst.FUNC_ID_SHOPPING, nomalLanEn = "RECHARGE", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_6.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_6.png"), view = purchase.FashionShopSubView})
    
    table.insert(tabList, {page = fashionShop.ShopType.NOMAL, nomalLanId = 84511, funcId = funcopen.FuncOpenConst.FUNC_ID_SHOPPING, nomalLanEn = "RECHARGE", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_6.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_6.png"), view = purchase.FashionShopSubView})
    table.insert(tabList, {page = fashionShop.ShopType.SCENE, nomalLanId = 84512, funcId = funcopen.FuncOpenConst.FUNC_ID_SHOPPING, nomalLanEn = "RECHARGE", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_6.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_6.png"), view = purchase.FashionShopSubView})

    table.insert(tabList, {page = fashionShop.ShopType.PAIRTS, nomalLanId = 84513, funcId = funcopen.FuncOpenConst.FUNC_ID_SHOPPING, nomalLanEn = "RECHARGE", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_6.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_6.png"), view = purchase.FashionShopSubView})
    return tabList
end
--[[ 替换语言包自动生成，请勿修改！
语言包: _TT(50009):"充值"
语言包: _TT(50008):"直购礼包"
语言包: _TT(50002):"月卡"
]]
