dessert = {}

--require("game/dessert/manager/CircleLayoutUtil")
require("game/dessert/manager/DessertConst")
--dessert.DessertRunGameVo = require("game/dessert/manager/vo/DessertRunGameVo")
dessert.DessertTaskDataVo = require("game/dessert/manager/vo/DessertTaskDataVo")

dessert.DessertTaskItem = require("game/dessert/view/item/DessertTaskItem")

dessert.DessertRankPanel = require("game/dessert/view/DessertRankPanel")
dessert.DessertRankItem = require("game/dessert/view/item/DessertRankItem")


dessert.DessertStarDataVo = require("game/dessert/manager/vo/DessertStarDataVo")
dessert.DessertDupDataVo = require("game/dessert/manager/vo/DessertDupDataVo")
dessert.DessertStarRwardConfigVo = require("game/dessert/manager/vo/DessertStarRwardConfigVo")
dessert.DessertEventListVo = require("game/dessert/manager/vo/DessertEventListVo")
dessert.DessertGameDataVo = require("game/dessert/manager/vo/DessertGameDataVo")
dessert.DessertItemDataVo = require("game/dessert/manager/vo/DessertItemDataVo")

dessert.DessertGamePanel = require("game/dessert/view/DessertGamePanel")
dessert.DessertTaskPanel = require("game/dessert/view/DessertTaskPanel")

dessert.DessertStarAwardItem = require("game/dessert/view/item/DessertStarAwardItem")

dessert.DessertTipsView = require("game/dessert/view/DessertTipsView")

dessert.DessertStartView = require("game/dessert/view/DessertStartView")
dessert.DessertStageMainUI = require("game/dessert/view/DessertStageMainUI")
dessert.DessertStarAwardView = require("game/dessert/view/DessertStarAwardView")
dessert.DessertDupPanel = require("game/dessert/view/DessertDupPanel")
dessert.DessertSettlePanel = require("game/dessert/view/DessertSettlePanel")

dessert.DessertManager = require("game/dessert/manager/DessertManager").new()

dessert.DessertWorldVo = require("game/dessert/manager/vo/DessertWorldVo")
--dessert.DessertGameWorld = require("game/dessert/manager/DessertGameWorld").new()
dessert.DessertController = require("game/dessert/controller/DessertController").new(dessert.DessertManager)
local module = {dessert.DessertController}
return module