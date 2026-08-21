vision = {}
require("game/vision/manager/VisionConst")

vision.VisionMirrorVo = require("game/vision/manager/vo/VisionMirrorVo")
vision.VisionMirrorStageVo = require("game/vision/manager/vo/VisionMirrorStageVo")
vision.VisionMirrorPassDupVo = require("game/vision/manager/vo/VisionMirrorPassDupVo")
vision.VisionMirrorDupVo = require("game/vision/manager/vo/VisionMirrorDupVo")
vision.VisionMirrorRankInfoVo = require("game/vision/manager/vo/VisionMirrorRankInfoVo")
vision.VisionMirrorRankPanelVo = require("game/vision/manager/vo/VisionMirrorRankPanelVo")

vision.VisionPanel =  require("game/vision/view/VisionPanel")
vision.VisionHeroInfoPanel = require("game/vision/view/VisionHeroInfoPanel")
vision.VisionResultPanel = require("game/vision/view/VisionResultPanel")
vision.VisionRankItem = require("game/vision/view/item/VisionRankItem")
vision.VisionRankPanel = require("game/vision/view/VisionRankPanel")


vision.VisionManager = require("game/vision/manager/VisionManager").new()
vision.VisionController = require('game/vision/controller/VisionController').new(vision.VisionManager)
local module = {vision.VisionController}

return module
