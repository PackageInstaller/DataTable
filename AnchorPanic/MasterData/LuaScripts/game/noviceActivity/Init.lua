noviceActivity = {}
noviceActivity.NoviceActivityVo = require("game/noviceActivity/manager/vo/NoviceActivityVo")
noviceActivity.NoviceActivityCreateVo = require("game/noviceActivity/manager/vo/NoviceActivityCreateVo")
noviceActivity.NoviceActivityRecruitVo = require("game/noviceActivity/manager/vo/NoviceActivityRecruitVo")
noviceActivity.NoviceActivityUpgradePlanVo = require("game/noviceActivity/manager/vo/NoviceActivityUpgradePlanVo")
noviceActivity.NoviceActivityReturnVo = require("game/noviceActivity/manager/vo/NoviceActivityReturnVo")
noviceActivity.NoviceActivityStrengthVo = require("game/noviceActivity/manager/vo/NoviceActivityStrengthVo")

noviceActivity.NoviceActivityRaffleVo = require("game/noviceActivity/manager/vo/NoviceActivityRaffleVo")
-----------------------------------------item--------------------------------------------------------
---
noviceActivity.NoviceActivityRecruitItem = require("game/noviceActivity/view/item/NoviceActivityRecruitItem")
noviceActivity.NoviceActivityBraceltesItem = require("game/noviceActivity/view/item/NoviceActivityBraceltesItem")
noviceActivity.NovicePermotionPlanItem = require("game/noviceActivity/view/item/NovicePermotionPlanItem")
noviceActivity.NoviceActivityReturnItem = require("game/noviceActivity/view/item/NoviceActivityReturnItem")
-------------------界面------------------------------------------------------------------------------
noviceActivity.NoviceActivityPanel = require("game/noviceActivity/view/NoviceActivityPanel")
-----招募次数
noviceActivity.NoviceActivityRecruitTabView = require("game/noviceActivity/view/NoviceActivityRecruitTabView")
-----手环次数
noviceActivity.NoviceActivityBracelectsTabView = require("game/noviceActivity/view/NoviceActivityBracelectsTabView")
-----升格次数
noviceActivity.NovicePromotionPlanView = require("game/noviceActivity/view/NovicePromotionPlanView")
-----升级返回
noviceActivity.NoviceActivityReturnTabView = require("game/noviceActivity/view/NoviceActivityReturnTabView")
--抽奖
noviceActivity.NoviceActivityRaffleTabView = require("game/noviceActivity/view/NoviceActivityRaffleTabView")
--体力
noviceActivity.NoviceActivityStrengtnView = require("game/noviceActivity/view/NoviceActivityStrengtnView")

--新人礼包
noviceActivity.NoviceNewSuperGiftTabView = require("game/noviceActivity/view/NoviceNewSuperGiftTabView")
-------------------管理------------------------------------------------------------------------------
noviceActivity.NoviceActivityConst = require("game/noviceActivity/manager/NoviceActivityConst")
noviceActivity.NoviceActivityManager = require("game/noviceActivity/manager/NoviceActivityManager").new()

noviceActivity.NoviceActivitySsrOptionalTabView = require("game/noviceActivity/view/NoviceActivitySsrOptionalTabView")


noviceActivity.NoviceActivityAccRechargeItem = require("game/noviceActivity/view/item/NoviceActivityAccRechargeItem")
noviceActivity.NoviceActivityRechargeVo = require("game/noviceActivity/manager/vo/NoviceActivityRechargeVo")
noviceActivity.NoviceActivityRechargeTabView = require("game/noviceActivity/view/NoviceActivityRechargeTabView")


noviceActivity.NoviceActivityAccRechargeTwoItem = require("game/noviceActivity/view/item/NoviceActivityAccRechargeTwoItem")
noviceActivity.NoviceActivityRechargeTwoVo = require("game/noviceActivity/manager/vo/NoviceActivityRechargeTwoVo")
noviceActivity.NoviceActivityRechargeTwoTabView = require("game/noviceActivity/view/NoviceActivityRechargeTwoTabView")

local _c = require('game/noviceActivity/controller/NoviceActivityController').new(noviceActivity.NoviceActivityManager)

local module = { _c }
return module

--[[ 替换语言包自动生成，请勿修改！
]]