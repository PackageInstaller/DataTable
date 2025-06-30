dailyCheckIn = {}
dailyCheckIn.DailyCheckInVo = require("game/dailyCheckIn/manager/vo/DailyCheckInVo")
dailyCheckIn.DailyCheckInPanel = require("game/dailyCheckIn/view/DailyCheckInPanel")
dailyCheckIn.DailyCheckInItem = require("game/dailyCheckIn/view/item/DailyCheckInItem")
dailyCheckIn.DailyCheckInTabSubView = require("game/dailyCheckIn/view/DailyCheckInTabSubView")
dailyCheckIn.DailyCheckInManager = require("game/dailyCheckIn/manager/DailyCheckInManager").new()

dailyCheckIn.DailyCheckInController = require('game/dailyCheckIn/controller/DailyCheckInController').new(dailyCheckIn.DailyCheckInManager)

local module = { dailyCheckIn.DailyCheckInController }
return module

--[[ 替换语言包自动生成，请勿修改！
]]