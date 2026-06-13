local OtakuSkillUnLockRedPointChecker = BaseClass("OtakuSkillUnLockRedPointChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = OtakuSkillUnLockRedPointChecker

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end
    
    self.checkResult = OtakuRedPointMgr.SkillUnLock() and 1 or 0
end


return OtakuSkillUnLockRedPointChecker