fashionPermit = {}

fashionPermit.FashionPermitVo = require("game/fashionPermit/manager/vo/FashionPermitVo")
fashionPermit.FashionPermitTaskVo = require("game/fashionPermit/manager/vo/FashionPermitTaskVo")

fashionPermit.FashionPermitTaskItem = require("game/fashionPermit/view/item/FashionPermitTaskItem")

fashionPermit.FashionPermitItem = require("game/fashionPermit/view/item/FashionPermitItem")
fashionPermit.FashionPermitPanel = require("game/fashionPermit/view/FashionPermitPanel")

fashionPermit.FashionPermitBuyPanel = require("game/fashionPermit/view/FashionPermitBuyPanel")
fashionPermit.FashionPermitTaskPanel = require("game/fashionPermit/view/FashionPermitTaskPanel")

fashionPermit.FashionPermitManager = require("game/fashionPermit/manager/FashionPermitManager").new()
fashionPermit.FashionPermitController = require('game/fashionPermit/controller/FashionPermitController').new(fashionPermit.FashionPermitManager)
local module = {fashionPermit.FashionPermitController}

return module