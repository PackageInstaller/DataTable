activity = {}

activity.ActivityPanel = require("game/activity/view/ActivityPanel")
activity.ActivitySpecialSupplyPanel = require("game/activity/view/ActivitySpecialSupplyPanel")
activity.ActivityPromoView1 = require("game/activity/view/ActivityPromoView1")
activity.ActivityPromoView2 = require("game/activity/view/ActivityPromoView2")
activity.ActivityPromoView3 = require("game/activity/view/ActivityPromoView3")
activity.ActivityPromoView4 = require("game/activity/view/ActivityPromoView4")
activity.ActivityLimitShopGift = "game/activity/view/ActivityLimitShopGift"
activity.ActivitySubscribeGift = "game/activity/view/ActivitySubscribeGift"
activity.ActivityRechargeNiceGift = "game/activity/view/ActivityRechargeNiceGift"
activity.ActivityCarnivalGift = "game/activity/view/ActivityCarnivalGift"
activity.ActivityInvestView = "game/activity/view/ActivityInvestView"
activity.ActivityInvestBuyView = "game/activity/view/ActivityInvestBuyView"
activity.ActivitySelectView = "game/activity/view/ActivitySelectView"

activity.ActivitySelectBuyView = require("game/activity/view/ActivitySelectBuyView")

activity.ActivityInvestRewardVo = require("game/activity/manager/vo/ActivityInvestRewardVo")
activity.ActivityInvestAccrueVo = require("game/activity/manager/vo/ActivityInvestAccrueVo")
activity.ActivitySelectBuyVo = require("game/activity/manager/vo/ActivitySelectBuyVo")

activity.ActivityExpiredGoodsVo = require("game/activity/manager/vo/ActivityExpiredGoodsVo")
activity.ActivityFashionHisView = "game/activity/view/ActivityFashionHisView"

activity.ActivityVo = require("game/activity/manager/vo/ActivityVo")
activity.ActivityConst = require("game/activity/manager/ActivityConst")
activity.ActivitySpecialSupplyConst = require("game/activity/manager/ActivitySpecialSupplyConst")
activity.BillboardConfigVo = require("game/activity/manager/vo/BillboardConfigVo")
activity.PermitBillboardVo = require("game/activity/manager/vo/PermitBillboardVo")
activity.ActivitySubscribeVo = require("game/activity/manager/vo/ActivitySubscribeVo")
activity.ActivitySubscribeWeChat = "game/activity/view/ActivitySubscribeWeChat"
activity.ActivityLimitShopVo = require("game/activity/manager/vo/ActivityLimitShopVo")
activity.ActivityCarnivalVo = require("game/activity/manager/vo/ActivityCarnivalVo")
activity.ActivityLimitShopTypeVo = require("game/activity/manager/vo/ActivityLimitShopTypeVo")
activity.ActivityManager = require("game/activity/manager/ActivityManager").new()
activity.ActitvityExtraManager = require("game/activity/manager/ActitvityExtraManager").new()
local mgrList = {}
table.insert(mgrList, activity.ActivityManager)
table.insert(mgrList, activity.ActitvityExtraManager)
local _c = require('game/activity/controller/ActivityController').new(mgrList)
local _popC = require('game/activity/controller/PopController').new()
local module = {_c, _popC}
return module

    --[[ 替换语言包自动生成，请勿修改！
]]
    --[[ 替换语言包自动生成，请勿修改！
]]

   