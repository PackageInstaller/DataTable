--baoruichang
--2022/11/15 17:15:07
local UIMasqueradeContext = BaseClass("UIMasqueradeContext", BaseContext)
local M = UIMasqueradeContext

function M:Init()
end

function M:Open(activityId)
    self.activityId = activityId
    self:_Show(self.activityId)
end

function M:GetChapterId(chapterType)
    if not self.activityCopy then
        local activityCopys = ConfigHelper.GetCfgsByLua("activityCopy", { activityId = self.activityId })
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

function M:GetTaskActivityId()
    if not self.activityId or self.activityId==0 then
        return 0 
    end
    local relationIds = ConfigHelper.GetCfgPropByLua("activity", self.activityId, "relationId")
    -- 任务活动id
    return relationIds[1] or 0
end

function M:OnClose()
    M.super.OnClose(self)
end

return UIMasqueradeContext
