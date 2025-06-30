-- 服务器商店类型
ShopType = {}
-- 交易所
ShopType.NOMAL = 1
-- 竞技商店
ShopType.ARENA = 2
-- 战勋商店
ShopType.MEDAL = 3
-- 装潢商店
ShopType.DECORATE = 4
-- 黑市
ShopType.BLACK = 5
-- 兑换商店(实际上是模组商店)
ShopType.CONVERT = 6
-- 盟约商店
ShopType.COVENANT = 8
-- 元件商店
ShopType.DISMISS = 9
-- 碎片商店
ShopType.FRAGMENTS = 10
-- 肉鸽商店
ShopType.ROGUELIKE = 11
-- 使徒之战2
ShopType.APOSTLES2 = 13
-- 输出情报所
ShopType.OUTPUT = 14
-- 辅助情报所
ShopType.ASSIST = 15
--巅峰竞技场
ShopType.ARENAHELL = 16

-- 联盟竞技场
ShopType.GUILD = 17

-- 无限城
ShopType.DOUNDLESS = 18
--总力战
ShopType.DISASTER = 19
--情报物资
ShopType.FRAGMENT = 20
--联盟商店
ShopType.GUILDWAR = 21
--DNA商店（心智体）
ShopType.DNA = 22

-- 无限城夜市
ShopType.INFINITECITY = 101
--回归商店
ShopType.RETURNED = 102

--开心农场商店
ShopType.HAPPYFARM = 103

--轮盘抽奖商店
ShopType.ROUNDPRIZE = 104
---隐藏商店，不做显示
ShopType.HIDE_SHOP = 105
--轮盘抽奖商店2
ShopType.ROUNDPRIZETWO = 106
---隐藏商店2，不做显示
ShopType.HIDE_SHOP_TWO = 107
-- 商店页签类型（对应shop_show_data配置表的id）
ShopTabType = {}
-- 交易所
ShopTabType.NOMAL = 6
-- 军械库
ShopTabType.ARM = 3
-- 兑换商店
ShopTabType.CONVERT = 2
-- 黑市
ShopTabType.BLACK = 1
-- 元件商店
ShopTabType.DISMISS = 4
-- 碎片商店
ShopTabType.FRAGMENTS = 5

-- 商店物品判断条件
shop.PropsJudge = {
    -- 道具充足
    PROPS_ENOUGH = 1,
    -- 道具不足，商城无出售
    PROPS_NOT_ENOUGH = 2,
    -- 道具不足，商城有出售，且货币充足
    MONEY_ENOUGH = 3,
    -- 道具不足，商城有出售，但货币不足
    MONEY_NOT_ENOUGH = 4,
    -- 道具不足，商城有出售，但购买次数不足
    BUY_TIMES_NOT_ENOUGH = 6,
}

-- 商店限购类型
shop.limitType = {
    -- 不限购
    NOT_LIMIT = 0,
    -- 日限购
    DAY_LIMIT = 1,
    -- 周限购
    WEEK_LIMIT = 2,
    -- 月限购
    MONTH_LIMIT = 3,
    -- 永久限购
    FOREVER_LIMIT = 4,
    -- 活动限购
    ACTIVITY_LIMIT = 5,
    --异想回渊- 常驻
    ACTIVITY_RESIDENT = 6,
    -- 限时下架
    LIMIT_TIME_OFF = 7,
}

-- 商店图标
shop.getPageIcon = function(cusPageType)
    local icon
    if cusPageType == ShopTabType.NOMAL then
        icon = UrlManager:getPackPath("shop/shop_icon_1.png")
    elseif cusPageType == ShopTabType.ARM then
        icon = UrlManager:getPackPath("shop/shop_icon_2.png")
    elseif cusPageType == ShopTabType.CONVERT then
        icon = UrlManager:getPackPath("shop/shop_icon_3.png")
    elseif cusPageType == ShopTabType.BLACK then
        icon = UrlManager:getPackPath("shop/shop_icon_4.png")
    elseif cusPageType == ShopTabType.DISMISS then
        icon = UrlManager:getPackPath("shop/shop_icon_5.png")
    elseif cusPageType == ShopTabType.FRAGMENTS then
        icon = UrlManager:getPackPath("shop/shop_icon_6.png")
    end
    return icon
end

--[[ 替换语言包自动生成，请勿修改！
]]
