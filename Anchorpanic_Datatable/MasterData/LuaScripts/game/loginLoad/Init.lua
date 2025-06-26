loginLoad = {}
loginLoad.LoginLoadView = require('game/loginLoad/view/LoginLoadView')
loginLoad.LoginLoadController = require('game/loginLoad/controller/LoginLoadController').new()
local module = { loginLoad.LoginLoadController }
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
