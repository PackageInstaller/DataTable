local ShopConst = {}

local ShopType = {
    None = 0,
    Normal = 1, --常规商店
    Recharge = 2, --山巅城商店（充值商店）
    GiftPack = 3, --礼包商店
    Recommend = 4, --推荐商店
    Cloth = 5, --时装商店
    PassCard = 6, --通行证商店
    MonthCard = 7, --月卡商店
}

local ShopItemType = {
    None = 0,
    Normal = 1, --正常商品
    Discount = 2, --打折商品
    Free = 3, --免费商品
    Owned = 4 --已拥有
}

local ShopTab = {
    Normal = {
        type = ShopType.Normal,
        txt = "常规商店"
    },
    Recharge = {
        type = ShopType.Recharge,
        txt = "山巅城商店"
    },
    GiftPack = {
        type = ShopType.GiftPack,
        txt = "礼包商店"
    },
    Recommend = {
        type = ShopType.Recommend,
        txt = "推荐商店"
    }
}

local ShopBagType ={
    Tyro = 1, --新手
    Period = 2, --周期
    Normal = 3, --常规
}

local ShopBagTab = {
    Tyro = {
        type = ShopBagType.Tyro,
        txt = 6238,
        icon = "UI/SpritePics/shop/ui_shop_icon_xr"
    },
    Period = {
        type = ShopBagType.Period,
        txt = 6239,
        icon = "UI/SpritePics/shop/ui_shop_icon_zq"
    },
    Normal = {
        type = ShopBagType.Normal,
        txt = 6241,
        icon = "UI/SpritePics/shop/ui_shop_icon_comon"
    }

}

local EShopRefreshType = {
    E_Not_Refresh = 1,
    E_Day_Refresh = 2,
    E_Week_Refresh = 3,
    E_Month_Refresh = 4,
    E_Fix_Refresh = 5,
}

ShopConst.ShopType = ShopType
ShopConst.ShopItemType = ShopItemType
ShopConst.ShopTab = ShopTab
ShopConst.EShopRefreshType = EShopRefreshType
ShopConst.ShopBagType = ShopBagType
ShopConst.ShopBagTab = ShopBagTab
return ShopConst
