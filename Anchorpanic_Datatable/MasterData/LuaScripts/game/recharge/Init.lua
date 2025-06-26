recharge = {}

require('game/recharge/manager/RechargeConst')
recharge.RechargeVo = require('game/recharge/manager/vo/RechargeVo')
recharge.RechargeManager = require('game/recharge/manager/RechargeManager').new()
recharge.RechargeController = require('game/recharge/controller/RechargeController').new(recharge.RechargeManager)

local module = { recharge.RechargeController }
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
