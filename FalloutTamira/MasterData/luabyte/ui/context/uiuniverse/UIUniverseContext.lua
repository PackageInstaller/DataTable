--baoruichang
--2023/3/30 14:40:21
local UIUniverseContext = BaseClass("UIUniverseContext", BaseContext)
local M = UIUniverseContext

function M:Open(activityId)
    self.activityId = activityId
    self:_Show(self.activityId)
end

function M:GetChapterId(chapterType)
    if not self.activityCopy then
        local activityCopys = ConfigHelper.GetCfgsByLua("activityCopy", { activityId = self.mainActivityId })
        if #activityCopys <= 0 then
            Logger.LogError("配置表错误")
            return
        end
        self.activityCopy = activityCopys[1]
    end
    if chapterType == 0 then
        return self.activityCopy.chapterId
    else
        return self.activityCopy.specialChapterId
    end
end

function M:GetActivityId()
    return self.activityId
end
return UIUniverseContext

