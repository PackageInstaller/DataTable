local DailyGoalsRoleCtrl = BaseClass("DailyGoalsRoleCtrl")
local M = DailyGoalsRoleCtrl



function M:Update()

end

function M:Init()

end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return DailyGoalsRoleCtrl
