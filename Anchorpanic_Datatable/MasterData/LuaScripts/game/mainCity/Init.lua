require('game/map/Init')

mainCity = {}
mainCity.MainCityScene = require('game/mainCity/view/MainCityScene')
mainCity.MainCityConst = require('game/mainCity/manager/MainCityConst')
mainCity.MainCityManager = require('game/mainCity/manager/MainCityManager').new()
mainCity.MainCityController = require('game/mainCity/controller/MainCityController').new(mainCity.MainCityManager)
local module = {mainCity.MainCityController}
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
