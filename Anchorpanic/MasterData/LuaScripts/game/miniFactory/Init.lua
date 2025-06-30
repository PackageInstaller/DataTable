miniFac = {}

miniFac.MiniFactoryPanel = require('game/miniFactory/view/MiniFactoryPanel')
miniFac.MiniProduceView = require('game/miniFactory/view/MiniProduceView')
miniFac.MiniConvertView = require('game/miniFactory/view/MiniConvertView')
miniFac.MiniFactoryInfoView = require('game/miniFactory/view/MiniFactoryInfoView')
miniFac.MiniFactoryProduceItem = require('game/miniFactory/view/item/MiniFactoryProduceItem')
miniFac.MiniFactoryFormulaItem = require("game/miniFactory/view/item/MiniFactoryFormulaItem")
miniFac.MiniFactoryFormulaListItem = require('game/miniFactory/view/item/MiniFactoryFormulaListItem')

miniFac.MiniProduceVo = require("game/miniFactory/manager/vo/MiniProduceVo")
miniFac.MiniConvertVo = require('game/miniFactory/manager/vo/MiniConvertVo')
miniFac.MiniFactoryConfigVo = require('game/miniFactory/manager/vo/MiniFactoryConfigVo')
miniFac.MiniFactoryFormulaVo = require('game/miniFactory/manager/vo/MiniFactoryFormulaVo')

miniFac.MiniFactoryManager = require('game/miniFactory/manager/MiniFactoryManager').new()
miniFac.MiniFactoryMainSceneController = require('game/miniFactory/controller/MiniFactoryMainSceneController').new()
miniFac.MiniFactoryController = require('game/miniFactory/controller/MiniFactoryController').new(miniFac.MiniFactoryManager)

local module = { miniFac.MiniFactoryController }
return module

--[[ 替换语言包自动生成，请勿修改！
]]