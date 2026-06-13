local DormDailyGolasRedPointChecker = BaseClass("DormDailyGolasRedPointChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = DormDailyGolasRedPointChecker

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
        DormDailyGolasDataMgr:GetInstance():GetActivityData(Bind(self, self.AsynCallBack))
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
    -- if isShow then
    --     Logger.Log("result+++++++true+++++++"..self.activityId)
    -- else
    --     Logger.Log("result+++++++false+++++++"..self.activityId)
    -- end
    self.isChecking = false
    self.checkResult = isShow and 1 or 0
end

function M:CheckData(datas)
    local isShow = false
    for key, value in pairs(datas) do
        local data = value:RoleActivity()
        if data then
            isShow = DormDailyGolasDataMgr:GetInstance():AllRedPoint(data)   
            if isShow then
                return true
            end
        end
    end
    return isShow
end

return DormDailyGolasRedPointChecker