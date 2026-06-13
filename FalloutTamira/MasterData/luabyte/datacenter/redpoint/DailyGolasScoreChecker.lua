local DailyGolasScoreChecker = BaseClass("DailyGolasScoreChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = DailyGolasScoreChecker

function M:Check(day)
    if not self:OnChanged(day) then
        return
    end
    
    local data = ActivityDataMgr:GetInstance():GetActivityByType(ActivityType.SEVENDAYSCORE)
    if data == nil then 
        self.checkResult = 0 
        return 
    end
    self._day = day
    self._isReady = data:IsActivityReady()

    if self._isReady then 
        self:AsynCallBack(data);
        return
    end
    self.isChecking = true 
    DailyGolasDataMgr:GetInstance():GetActivityScoreData(Bind(self, self.AsynCallBack))
end

function M:AsynCallBack(data)
    self.isChecking = false 
    self.checkResult = 0 
    local isShow = false

    if data == nil then 
        Logger.Log("ActivityType.SEVENDAYSCORE 数据为空") 
        return 
    end

    local activityData = data:RoleActivity()
    if not data:IsActivityReady() then
        Logger.Log("活动数据没有准备好") 
        return 
    end

    if #activityData <= 0 then
        Logger.Log("没有子活动数据") 
        return 
    end
    
    local data = activityData[1]
    local score = data.Value0
    local cfg = ConfigHelper.GetCfgs("activitySevenScore")
    local isReward = false
    
    for i, v in ipairs(cfg) do
        local idx = i % 32
        if (data.Value1 < 1 << idx) and score >= v.score then
            isReward = true
        end
    end

    self.checkResult = isReward and 1 or 0 

    -- 特别注释 * 因活动详情内容需要异步读取， 所以 (* 防止数据未到 红点判断先行 ) 这里特别处理 在第一次数据返回后 进行强制 check 如后续有方法解决 可干掉
    if not self._isReady then
        IRedPointMgr:NoScruplesCheckByType(RedPointConst.ThreeDayGoalLivenessChecker)
    end
end


return DailyGolasScoreChecker