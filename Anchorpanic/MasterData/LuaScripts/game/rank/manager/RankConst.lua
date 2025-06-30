--[[ 
-----------------------------------------------------
@filename       : RankConst
@Description    : 排行榜常量
@date           : 2021年8月16日 17:45:17
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.rank.manager.vo.RankConst', Class.impl())

-- -- 代号希望
-- RANK_CODE_HOPE = 1
-- -- 默示之境
-- RANK_IMPLIED = 2
-- -- 移动迷宫
-- RANK_MAZE = 3
-- -- 使徒之战
-- RANK_APOSTLES = 4
-- -- 无限城
RANK_CYCLE = 1 
-- 爬塔
RANK_CLIMBTOWER = 2
-- 肉鸽
--RANK_ROGUELIKE = 102

-- 挖矿
RANK_MINING = 9

---------------------（不在排行榜列表上）---------------------

-- 无限城
RANK_INFINITE_CITY = 101
-- 肉鸽


-- 排行榜图标
rank.getPageIcon = function(cusPageType)
    local icon
    -- if cusPageType == ShopTabType.NOMAL then
    --     icon = UrlManager:getPackPath("shop/shop_icon_1.png")
    -- elseif cusPageType == ShopTabType.ARM then
    --     icon = UrlManager:getPackPath("shop/shop_icon_2.png")
    -- elseif cusPageType == ShopTabType.CONVERT then
    --     icon = UrlManager:getPackPath("shop/shop_icon_3.png")
    -- elseif cusPageType == ShopTabType.BLACK then
    --     icon = UrlManager:getPackPath("shop/shop_icon_4.png")
    -- elseif cusPageType == ShopTabType.DISMISS then
    --     icon = UrlManager:getPackPath("shop/shop_icon_5.png")
    -- elseif cusPageType == ShopTabType.FRAGMENTS then
    --     icon = UrlManager:getPackPath("shop/shop_icon_6.png")
    -- end
    icon = UrlManager:getPackPath("cycle/cycleMain_07.png")
    return icon
end

---------------------（不在排行榜列表上）---------------------


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
