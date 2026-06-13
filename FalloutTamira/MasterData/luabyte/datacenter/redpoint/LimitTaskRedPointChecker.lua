-- 权限挑战  极限任务点
local BaseRedPointChecker = require("DataCenter.RedPoint.BaseRedPointChecker")
local M = BaseClass("LimitTaskRedPointChecker",BaseRedPointChecker)

function M:__init()
    -- checker 依赖的数据中心ID
    self.m_getLimitChallgeDataHandler = Bind(self,self._OnGetLimitData)
end

function M:_OnGetLimitData(limitChallgeData)
    self.isChecking = false
    if limitChallgeData then 
        if limitChallgeData:HasRedPointAboutLimitTask(self.m_type) then 
            self.checkResult = 1
        else
            self.checkResult = 0
        end
    end
end

function M:Check(type)
    self.isChecking = true
    self.m_type = type
    LimitDataMgr:GetInstance():GetLimitChallgeData(self.m_getLimitChallgeDataHandler)
end

return M