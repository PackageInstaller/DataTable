local VoteRedPointChecker = BaseClass("VoteRedPointChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = VoteRedPointChecker

function M:Check(taskType)
    if not self:OnChanged(taskType) then
        return
    end
    
    self.checkResult = VotingDataMgr:GetInstance():HaveVoteNum(Bind(self,self._CallBack)) and 1 or 0 
end

function M:_CallBack(result)
    self.checkResult = result and 1 or 0 
end

return VoteRedPointChecker