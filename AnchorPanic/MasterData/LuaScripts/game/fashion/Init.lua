fashion = {}

--base
require("game/fashion/manager/FashionConst")
fashion.FashionConfigVo = require("game/fashion/manager/vo/FashionConfigVo")
fashion.FashionVo = require("game/fashion/manager/vo/FashionVo")
fashion.FashionColorVo = require("game/fashion/manager/vo/FashionColorVo")
fashion.FashionColorBaseVo = require("game/fashion/manager/vo/FashionColorBaseVo")
fashion.FashionColorMsgVo = require("game/fashion/manager/vo/FashionColorMsgVo")
fashion.FashionManager = require("game/fashion/manager/FashionManager").new()
fashion.FashionItem = require("game/fashion/view/item/FashionItem")
fashion.FashionPanel = require("game/fashion/view/FashionPanel")
fashion.FashionController = require("game/fashion/controller/FashionController").new(fashion.FashionManager)
fashion.ReceiveFashionSuccess = require("game/fashion/view/ReceiveFashionSuccess")

-- 服饰
fashion.FashionClothesTabView = require("game/fashion/view/tab/FashionClothesTabView")

-- 武器
fashion.FashionWeaponTabView = require("game/fashion/view/tab/FashionWeaponTabView")


local module = { fashion.FashionController }
return module

--[[ 替换语言包自动生成，请勿修改！
]]