task = {}

--base
require("game/task/base/manager/TaskHallConst")

task.TaskHallManager = require("game/task/base/manager/TaskHallManager").new()
task.TaskHallController = require("game/task/base/controller/TaskHallController").new(task.TaskHallManager)
task.TaskHallPanel = require("game/task/base/view/TaskHallPanel")

task.TaskVo = require("game/task/dailyTask/manager/vo/TaskVo")

--日常任务
task.DailyTaskConfigVo = require("rodata/DailyTaskDataRo")
task.DailyTaskVo = require("game/task/dailyTask/manager/vo/DailyTaskVo")
task.DailyTaskScoreAwardVo = require("game/task/dailyTask/manager/vo/DailyTaskScoreAwardVo")

task.DailyTaskManager = require("game/task/dailyTask/manager/DailyTaskManager").new()
task.DailyTaskController = require("game/task/dailyTask/controller/DailyTaskController").new(task.DailyTaskManager)
task.DailyTaskScoreAwardPanel = require("game/task/dailyTask/view/DailyTaskScoreAwardPanel")

task.DailyTaskBoxItem =  require("game/task/dailyTask/view/item/DailyTaskBoxItem")
task.DailyTaskItem = require("game/task/dailyTask/view/item/DailyTaskItem")
task.DailyTaskTabView = "game/task/dailyTask/view/DailyTaskTabView"

-- 周常任务
task.WeekTaskItem = require("game/task/weekTask/view/item/WeekTaskItem")
task.WeekTaskTabView = "game/task/weekTask/view/WeekTaskTabView"

--成就
task.AchievementScoreConfigVo = require("game/task/achievement/manager/vo/AchievementScoreConfigVo")
task.AchievementConfigVo = require("game/task/achievement/manager/vo/AchievementConfigVo")
task.AchievementVo = require("game/task/achievement/manager/vo/AchievementVo")

task.AchievementConst = require("game/task/achievement/manager/AchievementConst")
task.AchievementManager = require("game/task/achievement/manager/AchievementManager").new()
task.AchievementController = require("game/task/achievement/controller/AchievementController").new(task.AchievementManager)
task.AchievementPanel = require("game/task/achievement/view/AchievementPanel")
task.AchievementPreviewTabView = require("game/task/achievement/view/tab/AchievementPreviewTabView")
task.AchievementTabView = require("game/task/achievement/view/tab/AchievementTabView")
task.AchievementItem = require("game/task/achievement/view/item/AchievementItem")
task.AchievementTip = require("game/task/achievement/view/AchievementTip")

local module = {task.TaskHallController, task.DailyTaskController, task.AchievementController}
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
