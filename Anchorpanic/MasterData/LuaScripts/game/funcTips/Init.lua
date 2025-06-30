funcTips = {}

funcTips.FuncTipsView = 'game/funcTips/view/FuncTipsView'
funcTips.FuncTipsConfigVo = require('game/funcTips/manager/vo/FuncTipsConfigVo')
funcTips.FuncTipsManager = require('game/funcTips/manager/FuncTipsManager').new()

funcTips.FuncTipsController = require('game/funcTips/controller/FuncTipsController').new(funcTips.FuncTipsManager)
local module = { funcTips.FuncTipsController }
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
