firstCharge = {}
firstCharge.FirstChargeVo = require("game/firstCharge/manager/vo/FirstChargeVo")
firstCharge.FirstChargePanel = require("game/firstCharge/view/FirstChargePanel")
firstCharge.FirstChargeManager = require("game/firstCharge/manager/FirstChargeManager").new()
firstCharge.FirstChargeController = require('game/firstCharge/controller/FirstChargeController').new(firstCharge.FirstChargeManager)

local module = { firstCharge.FirstChargeController }
return module

--[[ 替换语言包自动生成，请勿修改！
]]