watermelon = {}

require("game/watermelon/manager/WatermelonConst")
watermelon.WatermelonRunGameVo = require("game/watermelon/manager/vo/WatermelonRunGameVo")
watermelon.WatermelonTaskDataVo = require("game/watermelon/manager/vo/WatermelonTaskDataVo")

watermelon.WatermelonTaskItem = require("game/watermelon/view/item/WatermelonTaskItem")

watermelon.WatermelonRankPanel = require("game/watermelon/view/WatermelonRankPanel")
watermelon.WatermelonRankItem = require("game/watermelon/view/item/WatermelonRankItem")


watermelon.WatermelonStarDataVo = require("game/watermelon/manager/vo/WatermelonStarDataVo")
watermelon.WatermelonDupDataVo = require("game/watermelon/manager/vo/WatermelonDupDataVo")
watermelon.WatermelonStarRwardConfigVo = require("game/watermelon/manager/vo/WatermelonStarRwardConfigVo")
watermelon.WatermelonEventListVo = require("game/watermelon/manager/vo/WatermelonEventListVo")
watermelon.WatermelonGameDataVo = require("game/watermelon/manager/vo/WatermelonGameDataVo")
watermelon.WatermelonItemDataVo = require("game/watermelon/manager/vo/WatermelonItemDataVo")

watermelon.WatermelonGamePanel = require("game/watermelon/view/WatermelonGamePanel")
watermelon.WatermelonTaskPanel = require("game/watermelon/view/WatermelonTaskPanel")

watermelon.WatermelonStarAwardItem = require("game/watermelon/view/item/WatermelonStarAwardItem")

watermelon.WatermelonTipsView = require("game/watermelon/view/WatermelonTipsView")

watermelon.WatermelonStartView = require("game/watermelon/view/WatermelonStartView")
watermelon.WatermelonStageMainUI = require("game/watermelon/view/WatermelonStageMainUI")
watermelon.WatermelonStarAwardView = require("game/watermelon/view/WatermelonStarAwardView")
watermelon.WatermelonDupPanel = require("game/watermelon/view/WatermelonDupPanel")
watermelon.WatermelonSettlePanel = require("game/watermelon/view/WatermelonSettlePanel")

watermelon.WatermelonManager = require("game/watermelon/manager/WatermelonManager").new()

watermelon.WatermelonWorldVo = require("game/watermelon/manager/vo/WatermelonWorldVo")
watermelon.WatermelonGameWorld = require("game/watermelon/manager/WatermelonGameWorld").new()
watermelon.WatermelonController = require("game/watermelon/controller/WatermelonController").new(watermelon.WatermelonManager)
local module = {watermelon.WatermelonController}
return module