activityTarget = {}
require("game/activityTarget/manager/ActivityTargetConst")

activityTarget.ActivityTargetView = "game/activityTarget/view/ActivityTargetView"


activityTarget.ActivityTargetVo = require("game/activityTarget/manager/vo/ActivityTargetVo")
activityTarget.ActivityTargetAwardVo = require("game/activityTarget/manager/vo/ActivityTargetAwardVo")
activityTarget.ActivityTargetTaskInfoVo = require("game/activityTarget/manager/vo/ActivityTargetTaskInfoVo")
activityTarget.ActivityTargetScoreAwardVo = require("game/activityTarget/manager/vo/ActivityTargetScoreAwardVo")
activityTarget.TaskItem = require("game/activityTarget/view/item/TaskItem")

activityTarget.ActivityTargetManager = require("game/activityTarget/manager/ActivityTargetManager").new()
local _sc = require("game/activityTarget/controller/ActivityTargetController").new()
local _module = {_sc}

return _module
 
--[[ 替换语言包自动生成，请勿修改！
]]
