--模拟训练
training = {}

require("game/training/manager/TrainingConst")
training.TrainingPanel = require("game/training/view/TrainingPanel")
training.TrainingResultPanel = require("game/training/view/TrainingResultPanel")
training.TrainingDupInfoView = require("game/training/view/TrainingDupInfoView")
training.TrainingVo = require("game/training/manager/vo/TrainingVo")
training.TrainingConfigVo = require("game/training/manager/vo/TrainingConfigVo")
training.TrainingEventConfigVo = require("game/training/manager/vo/TrainingEventConfigVo")
training.TrainingShopConfigVo = require("game/training/manager/vo/TrainingShopConfigVo")
training.TrainingDupConfigVo = require("game/training/manager/vo/TrainingDupConfigVo")
training.TrainingManager = require("game/training/manager/TrainingManager").new()
training.TrainingController = require("game/training/controller/TrainingController").new(training.TrainingManager)

training.TrainingScene = require("game/training/view/TrainingScene")
training.TrainingSceneController = require("game/training/controller/TrainingSceneController").new()

local module = {training.TrainingController, training.TrainingSceneController}
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
