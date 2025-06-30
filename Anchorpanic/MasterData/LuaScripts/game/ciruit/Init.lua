ciruit = {}

-----------------配置相关
ciruit.CiruitAreaConfigVo = require("game/ciruit/manager/configVo/CiruitAreaConfigVo")
ciruit.CiruitDupConfigVo = require("game/ciruit/manager/configVo/CiruitDupConfigVo")
ciruit.CiruitGridConfigVo = require("game/ciruit/manager/configVo/CiruitGridConfigVo")

ciruit.CiruitGridVo = require("game/ciruit/manager/CiruitGridVo")

-----------------UI相关
ciruit.CiruitStageMainUI = "game/ciruit/view/CiruitStageMainUI"
ciruit.CiruitDupPanel = "game/ciruit/view/CiruitDupPanel"
ciruit.CiruitSceneUI = "game/ciruit/view/CiruitSceneUI"

ciruit.CiruitGridItem = require("game/ciruit/view/item/CiruitGridItem")

-----------------管理器相关
ciruit.CiruitConst = require("game/ciruit/manager/CiruitConst")
ciruit.CiruitManager = require("game/ciruit/manager/CiruitManager").new()
ciruit.CiruitController = require("game/ciruit/controller/CiruitController").new(ciruit.CiruitManager)
ciruit.CiruitSceneController = require("game/ciruit/controller/CiruitSceneController").new()

local module = {ciruit.CiruitController, ciruit.CiruitSceneController}
return module

--[[ 替换语言包自动生成，请勿修改！
]]
