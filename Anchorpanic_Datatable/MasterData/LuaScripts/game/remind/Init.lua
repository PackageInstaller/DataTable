remind = {}

require('game/remind/manager/RemindConst')
remind.RemindManager = require('game/remind/manager/RemindManager').new()
remind.RemindController = require('game/remind/controller/RemindController').new(remind.RemindManager)

local module = {remind.RemindController}
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
