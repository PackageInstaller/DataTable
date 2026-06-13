local AchievementContentUIContext = BaseClass("AchievementContentUIContext", BaseContext)
local M = AchievementContentUIContext


function M:Init()
end


function M:Open(data)
    if not data:IsLoad() then
        AchievementDataMgr:GetInstance():SendRequestAchievementGroupDetail(data:Id(), Bind(self, self._OnShow))
        return
    end
    self:_Show(data)
end

function M:_OnShow(data)
    self:_Show(data)
end

return AchievementContentUIContext