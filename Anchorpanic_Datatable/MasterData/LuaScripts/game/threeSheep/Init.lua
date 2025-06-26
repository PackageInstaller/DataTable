threeSheep = {}

-----------------配置相关
threeSheep.ThreeSheepDupConfigVo = require("game/threeSheep/manager/configVo/ThreeSheepDupConfigVo")
threeSheep.ThreeSheepCardConfigVo = require("game/threeSheep/manager/configVo/ThreeSheepCardConfigVo")
threeSheep.ThreeSheepAreaConfigVo = require("game/threeSheep/manager/configVo/ThreeSheepAreaConfigVo")
threeSheep.ThreeSheepStarRwardConfigVo = require("game/threeSheep/manager/configVo/ThreeSheepStarRwardConfigVo")

-----------------UI相关
threeSheep.ThreeSheepSceneUI = "game/threeSheep/view/ThreeSheepSceneUI"
threeSheep.ThreeSheepStageMainUI = "game/threeSheep/view/ThreeSheepStageMainUI"
threeSheep.ThreeSheepDupPanel = "game/threeSheep/view/ThreeSheepDupPanel"
threeSheep.ThreeSheepSettlementPanel = "game/threeSheep/view/ThreeSheepSettlementPanel"
threeSheep.ThreeSheepStarAwardView = "game/threeSheep/view/ThreeSheepStarAwardView"

threeSheep.ThreeSheepStarAwardItem = require("game/threeSheep/view/item/ThreeSheepStarAwardItem")
threeSheep.ThreeSheepCardItem = require("game/threeSheep/view/item/ThreeSheepCardItem")

-----------------管理器相关
threeSheep.ThreeSheepConst = require("game/threeSheep/manager/ThreeSheepConst")
threeSheep.ThreeSheepManager = require("game/threeSheep/manager/ThreeSheepManager").new()
threeSheep.ThreeSheepController = require("game/threeSheep/controller/ThreeSheepController").new(threeSheep.ThreeSheepManager)
threeSheep.ThreeSheepSceneController = require("game/threeSheep/controller/ThreeSheepSceneController").new()

local module = {threeSheep.ThreeSheepController, threeSheep.ThreeSheepSceneController}
return module

--[[ 替换语言包自动生成，请勿修改！
]]
