web = {}

-- 当web模块放在最一开始加载时需解锁注释
-- Class = require("lib/Class")
-- JsonUtil = require 'utils/JsonUtil'

require("game/web/manager/WebConst")
require("game/web/manager/WebUtil")

web.WebServerVo = require("game/web/manager/vo/WebServerVo")
web.WebManager = require("game/web/manager/WebManager").new()
web.WebController = require("game/web/controller/WebController").new()

local module = {}
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
