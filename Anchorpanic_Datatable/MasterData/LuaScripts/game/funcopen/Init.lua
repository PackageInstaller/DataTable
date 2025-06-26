funcopen = {}
funcopen.FuncOpenConst = require('game/funcopen/manager/FuncOpenConst')
funcopen.FuncOpenConfigVo = require('game/funcopen/manager/vo/FuncOpenConfigVo')
funcopen.FuncOpenManager = require('game/funcopen/manager/FuncOpenManager').new()

local _c = require('game/funcopen/controller/FuncOpenController').new(funcopen.FuncOpenManager)
local module = {_c}
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
