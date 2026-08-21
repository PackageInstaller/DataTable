split = {}

require("game/split/manager/SplitConst")
split.SplitRunGameVo = require("game/split/manager/vo/SplitRunGameVo")
split.SplitTaskDataVo = require("game/split/manager/vo/SplitTaskDataVo")

split.SplitTaskItem = require("game/split/view/item/SplitTaskItem")

split.SplitRankPanel = require("game/split/view/SplitRankPanel")
split.SplitRankItem = require("game/split/view/item/SplitRankItem")


split.SplitStarDataVo = require("game/split/manager/vo/SplitStarDataVo")
split.SplitDupDataVo = require("game/split/manager/vo/SplitDupDataVo")
split.SplitStarRwardConfigVo = require("game/split/manager/vo/SplitStarRwardConfigVo")
split.SplitEventListVo = require("game/split/manager/vo/SplitEventListVo")
split.SplitGameDataVo = require("game/split/manager/vo/SplitGameDataVo")
split.SplitItemDataVo = require("game/split/manager/vo/SplitItemDataVo")

split.SplitGamePanel = require("game/split/view/SplitGamePanel")
split.SplitTaskPanel = require("game/split/view/SplitTaskPanel")

split.SplitStarAwardItem = require("game/split/view/item/SplitStarAwardItem")

split.SplitTipsView = require("game/split/view/SplitTipsView")

split.SplitStartView = require("game/split/view/SplitStartView")
split.SplitStageMainUI = require("game/split/view/SplitStageMainUI")
split.SplitStarAwardView = require("game/split/view/SplitStarAwardView")
split.SplitDupPanel = require("game/split/view/SplitDupPanel")
split.SplitSettlePanel = require("game/split/view/SplitSettlePanel")

split.SplitManager = require("game/split/manager/SplitManager").new()

split.SplitWorldVo = require("game/split/manager/vo/SplitWorldVo")
split.SplitGameWorld = require("game/split/manager/SplitGameWorld").new()
split.SplitController = require("game/split/controller/SplitController").new(split.SplitManager)
local module = {split.SplitController}
return module