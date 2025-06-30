purchase = {}
fashionShop = {}
-- 月卡
purchase.MonthCardManager = require("game/purchase/monthCard/manager/MonthCardManager").new()
purchase.MonthCardController = require("game/purchase/monthCard/controller/MonthCardController").new()
purchase.MonthCardPanel = require("game/purchase/monthCard/view/MonthCardView")

purchase.StrengthCardPanel = require("game/purchase/monthCard/view/StrengthCardView")
-- 皮肤商店
require("game/purchase/fashionShop/manager/FashionShopConst")

purchase.FashionSceneChildVo = require("game/purchase/fashionShop/manager/vo/FashionSceneChildVo")
purchase.FashionSceneVo = require("game/purchase/fashionShop/manager/vo/FashionSceneVo")
purchase.FashionPairtsItem = require("game/purchase/fashionShop/view/item/FashionPairtsItem")

purchase.FashionComboConfigVo = require("game/purchase/fashionShop/manager/vo/FashionComboConfigVo")
purchase.FashionComboVo = require("game/purchase/fashionShop/manager/vo/FashionComboVo")
purchase.FashionComboItem = require("game/purchase/fashionShop/view/item/FashionComboItem")
purchase.FashionSceneItem = require("game/purchase/fashionShop/view/item/FashionSceneItem")
purchase.FashionShopSubView = require("game/purchase/fashionShop/view/FashionShopSubView")
purchase.FashionShopComboView = require("game/purchase/fashionShop/view/FashionShopComboView")
purchase.FashionShowOneBuyView = require("game/purchase/fashionShop/view/FashionShowOneBuyView")
purchase.FashionPairtsShowItem = require("game/purchase/fashionShop/view/item/FashionPairtsShowItem")

purchase.FashionShopView = require("game/purchase/fashionShop/view/FashionShopView")
purchase.FashionShowView = require("game/purchase/fashionShop/view/FashionShowView")
purchase.FashionShowOneView = require("game/purchase/fashionShop/view/FashionShowOneView")
purchase.FashionShopVo = require("game/purchase/fashionShop/manager/vo/FashionShopVo")
purchase.FashionShow3DView = require("game/purchase/fashionShop/view/FashionShow3DView")
purchase.FashionShopItem = require("game/purchase/fashionShop/view/item/FashionShopItem")
purchase.FashionShowItem = require("game/purchase/fashionShop/view/item/FashionShowItem")
purchase.FashionShopCoinView = require("game/purchase/fashionShop/view/FashionShopCoinView")
purchase.FashionShopTypeVo = require("game/purchase/fashionShop/manager/vo/FashionShopTypeVo")
purchase.FashionShopManager = require("game/purchase/fashionShop/manager/FashionShopManager").new()
purchase.FashionShopController = require("game/purchase/fashionShop/controller/FashionShopController").new()
-- 等级礼包
purchase.GradeGiftView = require("game/purchase/gradeGift/view/GradeGiftView")
purchase.GradeGiftVo = require("game/purchase/gradeGift/manager/vo/GradeGiftVo")
--purchase.FashionShopItem = require("game/purchase/gradeGift/view/item/FashionShopItem")
purchase.GradeGiftManager = require("game/purchase/gradeGift/manager/GradeGiftManager").new()
purchase.GradeGiftController = require("game/purchase/gradeGift/controller/GradeGiftController").new()
-- 成长基金
purchase.GrowthFundPanel = require("game/purchase/growthFund/view/GrowthFundPanel")
purchase.GrowthFundVo = require("game/purchase/growthFund/manager/vo/GrowthFundVo")
purchase.GrowthFundItem = require("game/purchase/growthFund/view/item/GrowthFundItem")
purchase.GrowthFundManager = require("game/purchase/growthFund/manager/GrowthFundManager").new()
purchase.GrowthFundController = require("game/purchase/growthFund/controller/GrowthFundController").new()

-- 直购礼包
purchase.DirectBuyManager = require("game/purchase/directBuy/manager/DirectBuyManager").new()
purchase.DirectBuyController = require("game/purchase/directBuy/controller/DirectBuyController").new()
purchase.DirectBuyItem = require("game/purchase/directBuy/view/item/DirectBuyItem")
purchase.DirectBuyPanel = require("game/purchase/directBuy/view/DirectBuyView")
purchase.LimitShopBuyItem = require("game/purchase/directBuy/view/item/LimitShopBuyItem")
purchase.DirectBuyMoneyView = require("game/purchase/directBuy/view/DirectBuyMoneyView")
purchase.DirectBuySubView_1 = "game/purchase/directBuy/view/DirectBuySubView_1"

purchase.DirectBuyVo = require("game/purchase/directBuy/manager/vo/DirectBuyVo")
purchase.DirectBuyTypeConfigVo = require("game/purchase/directBuy/manager/vo/DirectBuyTypeConfigVo")

-- 充值
purchase.RechargeCostView = require("game/purchase/recharge/view/RechargeCostView")
purchase.RechargeCostItem = require("game/purchase/recharge/view/item/RechargeCostItem")
purchase.RechargeCostVo = require("game/purchase/recharge/manager/vo/RechargeCostVo")
purchase.RechargeCostManager = require("game/purchase/recharge/manager/RechargeCostManager").new()
purchase.RechargeCostController = require("game/purchase/recharge/controller/RechargeCostController").new()

-- 累计充值
purchase.AccRechargePanel = require("game/purchase/accRecharge/view/AccRechargePanel")
purchase.AccRechargeItem = require("game/purchase/accRecharge/view/item/AccRechargeItem")
purchase.AccRechargeManager = require("game/purchase/accRecharge/manager/AccRechargeManager").new()
purchase.AccRechargeController = require("game/purchase/accRecharge/controller/AccRechargeController").new()
purchase.AccRechargeVo = require("game/purchase/accRecharge/manager/vo/AccRechargeVo")


-- 购买基础
purchase.PurchasePanel = require("game/purchase/base/view/PurchasePanel")
purchase.PurchaseTabItem = "game/purchase/base/view/item/PurchaseTabItem"
purchase.PurchaseConst = require("game/purchase/base/manager/PurchaseConst")
purchase.PurchaseMainTabItem = "game/purchase/base/view/item/PurchaseMainTabItem"
purchase.PurchaseChildTabItem = "game/purchase/base/view/item/PurchaseChildTabItem"
purchase.PurchaseManager = require("game/purchase/base/manager/PurchaseManager").new()

local mgrList = {}
table.insert(mgrList, purchase.PurchaseManager)
table.insert(mgrList, purchase.MonthCardManager)
table.insert(mgrList, purchase.DirectBuyManager)
table.insert(mgrList, purchase.RechargeCostManager)
table.insert(mgrList, purchase.AccRechargeManager)
table.insert(mgrList, purchase.FashionShopManager)
table.insert(mgrList, purchase.GrowthFundManager)
table.insert(mgrList, purchase.GradeGiftManager)
purchase.PurchaseController = require("game/purchase/base/controller/PurchaseController").new(mgrList)

local module = { purchase.PurchaseController, purchase.MonthCardController, purchase.DirectBuyController, purchase.RechargeCostController, purchase.AccRechargeController }
return module

--[[ 替换语言包自动生成，请勿修改！
]]