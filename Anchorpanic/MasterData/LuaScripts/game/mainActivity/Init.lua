Celebration = {}
mainActivity = {}
mainActivity.MainActivityVo = require("game/mainActivity/manager/vo/MainActivityVo")
mainActivity.MainActivitySignVo = require("game/mainActivity/manager/vo/MainActivitySignVo")
mainActivity.MainActivityShopVo = require("game/mainActivity/manager/vo/MainActivityShopVo")
mainActivity.MainActivityTaskVo = require("game/mainActivity/manager/vo/MainActivityTaskVo")
mainActivity.MainActivityTaskMsgVo = require("game/mainActivity/manager/vo/MainActivityTaskMsgVo")
mainActivity.MainActivityTrialConfigVo = require("game/mainActivity/manager/vo/MainActivityTrialConfigVo")

mainActivity.MainActivityPanel = require("game/mainActivity/view/MainActivityPanel")
mainActivity.MainActivityUpView = require("game/mainActivity/view/MainActivityUpView")
mainActivity.MainActivitySignView = require("game/mainActivity/view/MainActivitySignView")
mainActivity.MainActivitySignItem = require("game/mainActivity/view/item/MainActivitySignItem")

mainActivity.MainActivityManager = require("game/mainActivity/manager/MainActivityManager").new()
mainActivity.MainActivityConst = require("game/mainActivity/manager/MainActivityConst")

local _c = require('game/mainActivity/controller/MainActivityController').new(mainActivity.MainActivityManager)
----------------------------------------Panel----------------------------------------------------
--活动商店
mainActivity.MainActivityShopPanel = require("game/mainActivity/view/MainActivityShopPanel")
--活动商店购买弹窗
mainActivity.MainActivityShopBuyView = require("game/mainActivity/view/MainActivityShopBuyView")
--活动限时任务
mainActivity.MainActivityTaskPanel = require("game/mainActivity/view/MainActivityTaskPanel")

--试玩
mainActivity.MainActivityTrialPanel = require("game/mainActivity/view/MainActivityTrialPanel")
----------------------------------------Item----------------------------------------------------
mainActivity.MainActivityShopItem = require("game/mainActivity/view/item/MainActivityShopItem")
mainActivity.MainActivityTaskItem = require("game/mainActivity/view/item/MainActivityTaskItem")

-------------------------------------------周年庆典----------------------------------------------------
Celebration.CelebrationPanel = require("game/mainActivity/celebration/view/CelebrationPanel")
Celebration.CelebrationConst = require("game/mainActivity/celebration/manager/CelebrationConst")
Celebration.CelebrationTaskVo = require("game/mainActivity/celebration/manager/vo/CelebrationTaskVo")
Celebration.CelebrationTaskItem = require("game/mainActivity/celebration/view/item/CelebrationTaskItem")
Celebration.CelebrationTaskSubView = require("game/mainActivity/celebration/view/CelebrationTaskSubView")
Celebration.CeleSsrOptionalSubView = require("game/mainActivity/celebration/view/CeleSsrOptionalSubView")
Celebration.CelebrationManager = require("game/mainActivity/celebration/manager/CelebrationManager").new()
Celebration.CelebrationRechargeVo = require("game/mainActivity/celebration/manager/vo/CelebrationRechargeVo")
Celebration.CelebrationAccRechargeView = require("game/mainActivity/celebration/view/CelebrationAccRechargeView")
Celebration.CelebrationAccRechargeItem = require("game/mainActivity/celebration/view/item/CelebrationAccRechargeItem")
Celebration.CelebrationController = require("game/mainActivity/celebration/controller/CelebrationController").new(Celebration.CelebrationManager)
----------------------------------------活动副本
require("game/mainActivity/activeDup/manager/ActiveDupConst")
mainActivity.ActiveDupStageVo = require("game/mainActivity/activeDup/manager/vo/ActiveDupStageVo")
mainActivity.ActiveDupStageHellVo = require("game/mainActivity/activeDup/manager/vo/ActiveDupStageHellVo")
mainActivity.ActiveDupStageStepVo = require("game/mainActivity/activeDup/manager/vo/ActiveDupStageStepVo")

mainActivity.ActiveDupStageListPanel = require("game/mainActivity/activeDup/view/ActiveDupStageListPanel")
mainActivity.ActiveDupStageAwardPanel = require("game/mainActivity/activeDup/view/ActiveDupStageAwardPanel")
mainActivity.ActiveDupStageItem = require("game/mainActivity/activeDup/view/item/ActiveDupStageItem")
mainActivity.ActiveDupStageAwardItem = require("game/mainActivity/activeDup/view/item/ActiveDupStageAwardItem")

mainActivity.ActiveDupStarVo = require("game/mainActivity/activeDup/manager/vo/ActiveDupStarVo")
mainActivity.ActiveDupManager = require("game/mainActivity/activeDup/manager/ActiveDupManager").new()
mainActivity.ActiveDupController = require('game/mainActivity/activeDup/controller/ActiveDupController').new(mainActivity.ActiveDupManager)

local module = {_c, mainActivity.ActiveDupController,Celebration.CelebrationController}

return module

--[[ 替换语言包自动生成，请勿修改！
]]
