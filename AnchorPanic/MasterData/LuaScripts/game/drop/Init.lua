drop = {}

-- 建造小游戏模块入口，集中加载配置、数据对象、界面、管理器与控制器
require("game/drop/manager/DropConst")
drop.DropRunGameVo = require("game/drop/manager/vo/DropRunGameVo")
drop.DropTaskDataVo = require("game/drop/manager/vo/DropTaskDataVo")

drop.DropTaskItem = require("game/drop/view/item/DropTaskItem")

drop.DropRankPanel = require("game/drop/view/DropRankPanel")
drop.DropRankItem = require("game/drop/view/item/DropRankItem")


drop.DropStarDataVo = require("game/drop/manager/vo/DropStarDataVo")
drop.DropDupDataVo = require("game/drop/manager/vo/DropDupDataVo")
drop.DropStarRwardConfigVo = require("game/drop/manager/vo/DropStarRwardConfigVo")
drop.DropEventListVo = require("game/drop/manager/vo/DropEventListVo")
drop.DropGameDataVo = require("game/drop/manager/vo/DropGameDataVo")
drop.DropItemDataVo = require("game/drop/manager/vo/DropItemDataVo")

drop.DropGamePanel = require("game/drop/view/DropGamePanel")
drop.DropTaskPanel = require("game/drop/view/DropTaskPanel")

drop.DropStarAwardItem = require("game/drop/view/item/DropStarAwardItem")

drop.DropTipsView = require("game/drop/view/DropTipsView")

drop.DropStartView = require("game/drop/view/DropStartView")
drop.DropStageMainUI = require("game/drop/view/DropStageMainUI")
drop.DropStarAwardView = require("game/drop/view/DropStarAwardView")
drop.DropDupPanel = require("game/drop/view/DropDupPanel")
drop.DropSettlePanel = require("game/drop/view/DropSettlePanel")

drop.DropManager = require("game/drop/manager/DropManager").new()

drop.DropWorldVo = require("game/drop/manager/vo/DropWorldVo")
drop.DropGameWorld = require("game/drop/manager/DropGameWorld").new()
drop.DropController = require("game/drop/controller/DropController").new(drop.DropManager)
local module = {drop.DropController}
return module