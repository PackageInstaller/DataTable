eliminate = {}
require("game/eliminate/manager/EliminateConst")

eliminate.EliminateEffectExecutor = require("game/eliminate/executor/EliminateEffectExecutor")

eliminate.EliminateTaskConfigVo = require("game/eliminate/manager/vo/EliminateTaskConfigVo")
eliminate.EliminateAreaConfigVo = require("game/eliminate/manager/vo/EliminateAreaConfigVo")
eliminate.EliminateStageConfigVo = require("game/eliminate/manager/vo/EliminateStageConfigVo")
eliminate.EliminateTileConfigVo = require("game/eliminate/manager/vo/EliminateTileConfigVo")
eliminate.EliminateThingConfigVo = require("game/eliminate/manager/vo/EliminateThingConfigVo")
eliminate.EliminateTileVo = require("game/eliminate/manager/vo/EliminateTileVo")
eliminate.EliminateThingVo = require("game/eliminate/manager/vo/EliminateThingVo")

eliminate.EliminateTaskItem = require("game/eliminate/view/item/EliminateTaskItem")
eliminate.EliminateAreaItem = require("game/eliminate/view/item/EliminateAreaItem")
eliminate.EliminateStageItem = require("game/eliminate/view/item/EliminateStageItem")
eliminate.EliminateChallengePanel = require("game/eliminate/view/EliminateChallengePanel")
eliminate.EliminateTaskPanel = require("game/eliminate/view/EliminateTaskPanel")
eliminate.EliminateStagePanel = require("game/eliminate/view/EliminateStagePanel")
eliminate.EliminateResultPanel = require("game/eliminate/view/EliminateResultPanel")

eliminate.EliminateThing = require("game/eliminate/view/item/EliminateThing")
eliminate.EliminateTile = require("game/eliminate/view/item/EliminateTile")
eliminate.EliminatePanel = require("game/eliminate/view/EliminatePanel")
eliminate.EliminateManager = require("game/eliminate/manager/EliminateManager").new()
eliminate.EliminateObjManager = require("game/eliminate/manager/EliminateObjManager").new()
local mgrList = {}
table.insert(mgrList, eliminate.EliminateManager)
table.insert(mgrList, eliminate.EliminateObjManager)
eliminate.EliminateController = require('game/eliminate/controller/EliminateController').new(mgrList)

local module = { eliminate.EliminateController }
return module

--[[ 替换语言包自动生成，请勿修改！
]]
