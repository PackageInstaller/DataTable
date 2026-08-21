dailyRecharge = {}

dailyRecharge.DailyRechargeVo = require("game/dailyRecharge/manager/vo/DailyRechargeVo")
dailyRecharge.DailyRechargePanel = require("game/dailyRecharge/view/DailyRechargePanel")
dailyRecharge.DailyRechargeManager = require("game/dailyRecharge/manager/DailyRechargeManager").new()
dailyRecharge.DailyRechargeController = require("game/dailyRecharge/controller/DailyRechargeController").new(dailyRecharge.DailyRechargeManager)

local module = { dailyRecharge.DailyRechargeController }
return module

--[[ 替换语言包自动生成，请勿修改！
]]