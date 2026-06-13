local LoginAwardChecker = BaseClass("LoginAwardChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = LoginAwardChecker
local HOURS5 = 18000

function M:Check(activityId)
    self.activityId = activityId
    if self.activityId <= 0 then
        self.isChecking = false
        return
    end
    if not self:OnChanged(activityId) then
        return
    end
    self.isChecking = true
    ActivityDataMgr:GetInstance():GetActivityByIdAsyn(activityId, Bind(self, self._OnActivityCallback))
end

function M:_OnActivityCallback(activityData)
    self.isChecking = false
    if activityData == nil then
        self.checkResult = 0
        return
    end
    local roleData = activityData:RoleActivity()
    if roleData == nil or #roleData == 0 then
        self.checkResult = 1
        return
    end
    local nowTimer = TimeUtil.GetNowTimeStamp()
    local data = roleData[1]
    local isSigned = TimeUtil.IsOneDay(data.Value1 - HOURS5, nowTimer - HOURS5)
    local nums = ConfigHelper.GetCfgsByLua("activityLogin", {activityId=self.activityId})
    self.checkResult = not isSigned and (data.Value0 < #nums) and 1 or 0
end

return LoginAwardChecker
