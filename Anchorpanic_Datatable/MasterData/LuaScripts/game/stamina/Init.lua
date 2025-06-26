stamina = {}

-- manager
stamina.StaminaExchangeVo = require('game/stamina/manager/vo/StaminaExchangeVo')
stamina.StaminaManager = require('game/stamina/manager/StaminaManager').new()

-- view
stamina.AddStaminaPanel = require("game/stamina/view/AddStaminaPanel")
stamina.AddStaminaPropsItem = require("game/stamina/view/item/AddStaminaPropsItem")

local c = require('game/stamina/controller/StaminaController').new(stamina.StaminaManager)

local module = { c }
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
