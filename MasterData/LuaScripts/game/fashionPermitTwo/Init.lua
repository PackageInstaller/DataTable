fashionPermitTwo = {}

fashionPermitTwo.FashionPermitTwoVo = require("game/fashionPermitTwo/manager/vo/FashionPermitTwoVo")
fashionPermitTwo.FashionPermitTwoTaskVo = require("game/fashionPermitTwo/manager/vo/FashionPermitTwoTaskVo")

fashionPermitTwo.FashionPermitTwoTaskItem = require("game/fashionPermitTwo/view/item/FashionPermitTwoTaskItem")

fashionPermitTwo.FashionPermitTwoItem = require("game/fashionPermitTwo/view/item/FashionPermitTwoItem")
fashionPermitTwo.FashionPermitTwoPanel = require("game/fashionPermitTwo/view/FashionPermitTwoPanel")

fashionPermitTwo.FashionPermitTwoBuyPanel = require("game/fashionPermitTwo/view/FashionPermitTwoBuyPanel")
fashionPermitTwo.FashionPermitTwoTaskPanel = require("game/fashionPermitTwo/view/FashionPermitTwoTaskPanel")

fashionPermitTwo.FashionPermitTwoManager = require("game/fashionPermitTwo/manager/FashionPermitTwoManager").new()
fashionPermitTwo.FashionPermitTwoController = require('game/fashionPermitTwo/controller/FashionPermitTwoController').new(fashionPermitTwo.FashionPermitTwoManager)
local module = {fashionPermitTwo.FashionPermitTwoController}

return module