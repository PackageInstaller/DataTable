local M = BaseClass("ResCopyActivityUIContext", BaseContext)

function M:Init()
end

function M:Open(activityId)
    ActivityDataMgr:GetInstance():GetActivityByIdAsyn(activityId, function(data)
        if data and data:IsOpen() then
            self:_Show(data)
        else
            GameHelper.TipsById(1055) -- 活动未开放
        end
    end)
end

return M
