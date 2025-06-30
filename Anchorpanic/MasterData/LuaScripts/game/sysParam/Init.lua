sysParam = {}
require('game/sysParam/Manager/SysParamConst')
sysParam.SysParamManager = require('game/sysParam/Manager/SysParamManager').new()
sysParam.SysParamController = require('game/sysParam/Controller/SysParamController').new(sysParam.SysParamManager)
local module = {sysParam.SysParamController}
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
