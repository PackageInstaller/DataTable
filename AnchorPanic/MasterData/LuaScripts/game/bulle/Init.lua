bulle = {}

require("game/bulle/manager/BulleConst")
bulle.BulleRunGameVo = require("game/bulle/manager/vo/BulleRunGameVo")
bulle.BulleTaskDataVo = require("game/bulle/manager/vo/BulleTaskDataVo")

bulle.BulleTaskItem = require("game/bulle/view/item/BulleTaskItem")

bulle.BulleRankPanel = require("game/bulle/view/BulleRankPanel")
bulle.BulleRankItem = require("game/bulle/view/item/BulleRankItem")


bulle.BulleStarDataVo = require("game/bulle/manager/vo/BulleStarDataVo")
bulle.BulleDupDataVo = require("game/bulle/manager/vo/BulleDupDataVo")
bulle.BulleStarRwardConfigVo = require("game/bulle/manager/vo/BulleStarRwardConfigVo")
bulle.BulleEventListVo = require("game/bulle/manager/vo/BulleEventListVo")
bulle.BulleGameDataVo = require("game/bulle/manager/vo/BulleGameDataVo")
bulle.BulleItemDataVo = require("game/bulle/manager/vo/BulleItemDataVo")

bulle.BulleGamePanel = require("game/bulle/view/BulleGamePanel")
bulle.BulleTaskPanel = require("game/bulle/view/BulleTaskPanel")

bulle.BulleStarAwardItem = require("game/bulle/view/item/BulleStarAwardItem")

bulle.BulleTipsView = require("game/bulle/view/BulleTipsView")

bulle.BulleStartView = require("game/bulle/view/BulleStartView")
bulle.BulleStageMainUI = require("game/bulle/view/BulleStageMainUI")
bulle.BulleStarAwardView = require("game/bulle/view/BulleStarAwardView")
bulle.BulleDupPanel = require("game/bulle/view/BulleDupPanel")
bulle.BulleSettlePanel = require("game/bulle/view/BulleSettlePanel")

bulle.BulleManager = require("game/bulle/manager/BulleManager").new()

bulle.BulleWorldVo = require("game/bulle/manager/vo/BulleWorldVo")
bulle.BulleGameWorld = require("game/bulle/manager/BulleGameWorld").new()
bulle.BulleController = require("game/bulle/controller/BulleController").new(bulle.BulleManager)
local module = {bulle.BulleController}
return module