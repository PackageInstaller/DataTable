local DormPuzzleRedPointChecker = BaseClass("DormPuzzleRedPointChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = DormPuzzleRedPointChecker

function M:Check(activityId)
    if not self:OnChanged(activityId) then
        return
    end

    if activityId < 0 then
        self.checkResult = 0
        return 
    end

    self.isChecking = true
    self.activityId = activityId

    if self.activityId == 0 then
        ActivityDataMgr:GetInstance():GetActivitysByTypeAsyn(ActivityType.DORM_PUZZLE, Bind(self, self.AsynCallBack))
    else
        self.activityData = ActivityDataMgr:GetInstance():GetActivityData(self.activityId)
        local data = {self.activityData}
        self:AsynCallBack(data)
    end 
end

function M:AsynCallBack(datas)
    local isShow = false

    if datas == {} then
        self.checkResult = 0
        return 
    end
    isShow = self:CheckData(datas)
    self.isChecking = false
    self.checkResult = isShow and 1 or 0
end

function M:CheckData(datas)
    local isShow = false
    for key, value in pairs(datas) do
        isShow = DormPuzzleActivityDataMgr:GetInstance():CheckAllRedpoint(value)   
        if isShow then
            return true
        end
    end
    return isShow
end

return DormPuzzleRedPointChecker