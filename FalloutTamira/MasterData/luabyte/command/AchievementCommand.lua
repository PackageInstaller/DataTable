-- 活动命令
local AchievementCommand = BaseClass("AchievementCommand", BaseCommand)
local M = AchievementCommand

function M:Execute()
    --此数据没必要一登录就获取，先注释，会在登录之后进行调整 xiaokun

end

return AchievementCommand
