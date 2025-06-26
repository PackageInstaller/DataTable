read = {}

require('game/read/manager/ReadConst')
read.ReadManager = require('game/read/manager/ReadManager').new()
read.ReadController = require('game/read/controller/ReadController').new(read.ReadManager)

local module = {read.ReadController}
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
