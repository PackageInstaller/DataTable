build = {}

-- 建造小游戏模块入口，集中加载配置、数据对象、界面、管理器与控制器
require("game/build/manager/BuildConst")
build.BuildRunGameVo = require("game/build/manager/vo/BuildRunGameVo")
build.BuildTaskDataVo = require("game/build/manager/vo/BuildTaskDataVo")

build.BuildTaskItem = require("game/build/view/item/BuildTaskItem")

build.BuildRankPanel = require("game/build/view/BuildRankPanel")
build.BuildRankItem = require("game/build/view/item/BuildRankItem")


build.BuildStarDataVo = require("game/build/manager/vo/BuildStarDataVo")
build.BuildDupDataVo = require("game/build/manager/vo/BuildDupDataVo")
build.BuildStarRwardConfigVo = require("game/build/manager/vo/BuildStarRwardConfigVo")
build.BuildEventListVo = require("game/build/manager/vo/BuildEventListVo")
build.BuildGameDataVo = require("game/build/manager/vo/BuildGameDataVo")
build.BuildItemDataVo = require("game/build/manager/vo/BuildItemDataVo")

build.BuildGamePanel = require("game/build/view/BuildGamePanel")
build.BuildTaskPanel = require("game/build/view/BuildTaskPanel")

build.BuildStarAwardItem = require("game/build/view/item/BuildStarAwardItem")

build.BuildTipsView = require("game/build/view/BuildTipsView")

build.BuildStartView = require("game/build/view/BuildStartView")
build.BuildStageMainUI = require("game/build/view/BuildStageMainUI")
build.BuildStarAwardView = require("game/build/view/BuildStarAwardView")
build.BuildDupPanel = require("game/build/view/BuildDupPanel")
build.BuildSettlePanel = require("game/build/view/BuildSettlePanel")

build.BuildManager = require("game/build/manager/BuildManager").new()

build.BuildWorldVo = require("game/build/manager/vo/BuildWorldVo")
build.BuildGameWorld = require("game/build/manager/BuildGameWorld").new()
build.BuildController = require("game/build/controller/BuildController").new(build.BuildManager)
local module = {build.BuildController}
return module