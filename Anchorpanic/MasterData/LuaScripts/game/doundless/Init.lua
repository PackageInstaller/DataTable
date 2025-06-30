doundless = {}
require("game/doundless/manager/DoundlessConst")
doundless.DoundlessDisturbanceVo = require("game/doundless/manager/vo/DoundlessDisturbanceVo")
doundless.DoundlessCityTargetVo = require("game/doundless/manager/vo/DoundlessCityTargetVo")
doundless.DoundlessResultPanel =  require("game/doundless/view/DoundlessResultPanel")


doundless.DoundlessRoundDataVo = require("game/doundless/manager/vo/DoundlessRoundDataVo")
doundless.DoundlessCityStageVo = require("game/doundless/manager/vo/DoundlessCityStageVo")

doundless.DoundlessCityVo = require("game/doundless/manager/vo/DoundlessCityVo")
doundless.DoundlessSingleCityVo = require("game/doundless/manager/vo/DoundlessSingleCityVo")




doundless.DoundlessPanel =  require("game/doundless/view/DoundlessPanel")

doundless.DoundlessLogPanel =  require("game/doundless/view/DoundlessLogPanel")


doundless.DoundlessDisturbancePanel =  require("game/doundless/view/DoundlessDisturbancePanel")


doundless.DoundlessPromoteItem = require("game/doundless/view/item/DoundlessPromoteItem")
doundless.DoundlessPromoteTabView = require("game/doundless/view/tab/DoundlessPromoteTabView")

doundless.DoundlessWarupgradeTabView = require("game/doundless/view/tab/DoundlessWarupgradeTabView")

doundless.DoundlessAwardItem = require("game/doundless/view/item/DoundlessAwardItem")
doundless.DoundlessRewardPanel = require("game/doundless/view/DoundlessRewardPanel")
doundless.DoundlessLowRankTabView = require("game/doundless/view/tab/DoundlessLowRankTabView")
doundless.DoundlessMiddleRankTabView = require("game/doundless/view/tab/DoundlessMiddleRankTabView")
doundless.DoundlessHighRankTabView = require("game/doundless/view/tab/DoundlessHighRankTabView")

doundless.DoundlessRankItem = require("game/doundless/view/item/DoundlessRankItem")
doundless.DoundlessRankPanel =  require("game/doundless/view/DoundlessRankPanel")

doundless.DoundlessManager = require("game/doundless/manager/DoundlessManager").new()
doundless.DoundlessController = require('game/doundless/controller/DoundlessController').new(doundless.DoundlessManager)
local module = {doundless.DoundlessController}

return module