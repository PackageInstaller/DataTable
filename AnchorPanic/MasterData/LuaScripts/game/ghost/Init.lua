ghost = {}

require("game/ghost/manager/GhostConst")
--ghost.GhostRunGameVo = require("game/ghost/manager/vo/GhostRunGameVo")
ghost.GhostTaskDataVo = require("game/ghost/manager/vo/GhostTaskDataVo")

ghost.GhostTaskItem = require("game/ghost/view/item/GhostTaskItem")

ghost.GhostRankPanel = require("game/ghost/view/GhostRankPanel")
ghost.GhostRankItem = require("game/ghost/view/item/GhostRankItem")


ghost.GhostStarDataVo = require("game/ghost/manager/vo/GhostStarDataVo")
ghost.GhostDupDataVo = require("game/ghost/manager/vo/GhostDupDataVo")
ghost.GhostStarRwardConfigVo = require("game/ghost/manager/vo/GhostStarRwardConfigVo")
ghost.GhostEventListVo = require("game/ghost/manager/vo/GhostEventListVo")
ghost.GhostGameDataVo = require("game/ghost/manager/vo/GhostGameDataVo")
ghost.GhostItemDataVo = require("game/ghost/manager/vo/GhostItemDataVo")

ghost.GhostGamePanel = require("game/ghost/view/GhostGamePanel")
ghost.GhostTaskPanel = require("game/ghost/view/GhostTaskPanel")

ghost.GhostStarAwardItem = require("game/ghost/view/item/GhostStarAwardItem")

ghost.GhostTipsView = require("game/ghost/view/GhostTipsView")

ghost.GhostStartView = require("game/ghost/view/GhostStartView")
ghost.GhostStageMainUI = require("game/ghost/view/GhostStageMainUI")
ghost.GhostStarAwardView = require("game/ghost/view/GhostStarAwardView")
ghost.GhostDupPanel = require("game/ghost/view/GhostDupPanel")
ghost.GhostSettlePanel = require("game/ghost/view/GhostSettlePanel")

ghost.GhostManager = require("game/ghost/manager/GhostManager").new()

ghost.GhostWorldVo = require("game/ghost/manager/vo/GhostWorldVo")
--ghost.GhostGameWorld = require("game/ghost/manager/GhostGameWorld").new()
ghost.GhostController = require("game/ghost/controller/GhostController").new(ghost.GhostManager)
local module = {ghost.GhostController}
return module