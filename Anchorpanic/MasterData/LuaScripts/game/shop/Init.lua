shop = {}
require("game/shop/manager/ShopConst")

require("game/shop/manager/ShopTabConst")
shop.ShopTabItem = "game/shop/view/item/ShopTabItem"
shop.ShopTabMainItem = "game/shop/view/item/ShopTabMainItem"
shop.ShopTabChildItem = "game/shop/view/item/ShopTabChildItem"
shop.ShopSubView = "game/shop/view/sub/ShopSubView"
shop.ShopConvertView = "game/shop/view/sub/ShopConvertView"
shop.ShopFragmentsView = "game/shop/view/sub/ShopFragmentsView"
shop.ShopRecommendedView = "game/shop/view/sub/ShopRecommendedView"
-- shop.NomalShopView = "game/shop/view/sub/NomalShopView"
-- shop.ArenaShopView = "game/shop/view/sub/ArenaShopView"
-- shop.BlackShopView = "game/shop/view/sub/BlackShopView"
-- shop.MedalShopView = "game/shop/view/sub/MedalShopView"
-- shop.DecorateShopView = "game/shop/view/sub/DecorateShopView"

shop.ShopItem = require("game/shop/view/item/ShopItem")
shop.ShopLimitItem = require("game/shop/view/item/ShopLimitItem")
shop.ShopConvertItem = require("game/shop/view/item/ShopConvertItem")


shop.ShopBuyView = "game/shop/view/ShopBuyView"
shop.ShopBuyView2 = "game/shop/view/ShopBuyView2"
shop.ShopPanel = "game/shop/view/ShopPanel"
shop.ShoppingPanel = "game/shop/view/ShoppingPanel"
-- shop.ShopPanel = require("game/shop/view/ShopPanel")
shop.ShopVo = require("game/shop/manager/vo/ShopVo")
shop.ShopFragmentRuleVo = require("game/shop/manager/vo/ShopFragmentRuleVo")
shop.ShopTypeVo = require("game/shop/manager/vo/ShopTypeVo")
shop.ShopShowVo = require("game/shop/manager/vo/ShopShowVo")

shop.ShopManager = require("game/shop/manager/ShopManager").new()

local _sc = require("game/shop/controller/ShopController").new(shop.ShopManager)

local _module = { _sc }

return _module

--[[ 替换语言包自动生成，请勿修改！
]]