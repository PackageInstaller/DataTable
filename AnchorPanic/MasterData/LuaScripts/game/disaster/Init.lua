disaster = {}
require("game/disaster/manager/DisasterConst")

disaster.DisasterDupVo = require("game/disaster/manager/vo/DisasterDupVo")
disaster.DisasterAwardVo = require("game/disaster/manager/vo/DisasterAwardVo")
disaster.DisasterRankAwardVo = require("game/disaster/manager/vo/DisasterRankAwardVo")

disaster.DisasterMainPanel = require("game/disaster/view/DisasterMainPanel")


disaster.DisasterFightAwardItem = require("game/disaster/view/item/DisasterFightAwardItem")
disaster.DisasterFightAwardPanel = require("game/disaster/view/DisasterFightAwardPanel")


disaster.DisasterAwardItem = require("game/disaster/view/item/DisasterAwardItem")
disaster.DisasterAwardTabView = require("game/disaster/view/tab/DisasterAwardTabView")

disaster.DisasterRankItem = require("game/disaster/view/item/DisasterRankItem")
disaster.DisasterRankTabView = require("game/disaster/view/tab/DisasterRankTabView")
disaster.DisasterRankPanel = require("game/disaster/view/DisasterRankPanel")

disaster.DisasterBossPanel = require("game/disaster/view/DisasterBossPanel")


disaster.DisasterResultPanel = require("game/disaster/view/DisasterResultPanel")

disaster.DisasterManager = require("game/disaster/manager/DisasterManager").new()
disaster.DisasterController = require("game/disaster/controller/DisasterController").new(disaster.DisasterManager)
local module = {disaster.DisasterController}
return module