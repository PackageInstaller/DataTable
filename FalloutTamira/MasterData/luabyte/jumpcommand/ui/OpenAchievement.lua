local M = BaseClass("OpenAchievement", BaseJumpCommand)
M.uiName = "AchievementMain"

function M:Execute(args)
    if not AchievementDataMgr:GetInstance():IsReady() then
        return false
    end 
    self:ShowUI(M.uiName, table.unpack(args))
    return true
end

function M:_OnShowAchievement()
    Logger.Log("_OnShowAchievement")
end

return M