login = {}
require("game/login/manager/LoginConst")
require("game/login/manager/LoginPreloadConst")

login.LoginManager = require("game/login/manager/LoginManager").new() 

login.LoginPreloadView = require("game/login/view/LoginPreloadView") 
login.LoginView = require("game/login/view/LoginView") 

login.DebugLoginView = require("game/login/view/DebugLoginView") 
login.DebugLoginScrollerItem = require("game/login/view/item/DebugLoginScrollerItem") 

login.LoginBulletinTipPanel = require("game/login/view/LoginBulletinTipPanel")
login.LoginAgeTipPanel = require("game/login/view/LoginAgeTipPanel") 

local _c = require("game/login/controller/LoginController").new(login.LoginManager) 
local module = {_c}
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
