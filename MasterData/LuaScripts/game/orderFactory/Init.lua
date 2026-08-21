orderFactory = {}

orderFactory.OrderFactoryBagScrollerItem = require("game/orderFactory/view/item/OrderFactoryBagScrollerItem")
orderFactory.OrderFactoryPanel = "game/orderFactory/view/OrderFactoryPanel"

orderFactory.OrderFactoryConfigVo = require("game/orderFactory/manager/vo/OrderFactoryConfigVo")
orderFactory.OrderFactoryManager = require("game/orderFactory/manager/OrderFactoryManager").new()

local _ofc = require("game/orderFactory/controller/OrderFactoryController").new(orderFactory.OrderFactoryManager)

local _module = { _ofc }

return _module
 
--[[ 替换语言包自动生成，请勿修改！
]]
