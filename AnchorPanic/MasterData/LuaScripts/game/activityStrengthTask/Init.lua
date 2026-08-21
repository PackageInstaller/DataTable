activityStrengthTask = {}

activityStrengthTask.ActivityStrengthTaskView = require("game/activityStrengthTask/view/ActivityStrengthTaskView")

activityStrengthTask.ActivityStrengthTaskItem = require("game/activityStrengthTask/view/item/ActivityStrengthTaskItem")

activityStrengthTask.ActivityStrengthTaskVo = require("game/activityStrengthTask/manager/vo/ActivityStrengthTaskVo")

activityStrengthTask.ActivityStrengthTaskConst = require("game/activityStrengthTask/manager/ActivityStrengthTaskConst").new()
activityStrengthTask.ActivityStrengthTaskManager = require(
    "game/activityStrengthTask/manager/ActivityStrengthTaskManager").new()

activityStrengthTask.activityStrengthTaskController = require(
    "game/activityStrengthTask/controller/activityStrengthTaskController").new(activityStrengthTask.ActivityStrengthTaskManager)

local module = { activityStrengthTask.activityStrengthTaskController }
return module
