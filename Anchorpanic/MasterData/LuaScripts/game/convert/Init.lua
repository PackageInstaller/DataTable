convert = {}

convert.ConvertView = 'game/convert/view/ConvertView'
convert.ConvertView2 = 'game/convert/view/ConvertView2'

convert.ConvertManager = require('game/convert/manager/ConvertManager').new()

local _c = require('game/convert/controller/ConvertController').new(convert.ConvertManager)
local module = { _c }
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
