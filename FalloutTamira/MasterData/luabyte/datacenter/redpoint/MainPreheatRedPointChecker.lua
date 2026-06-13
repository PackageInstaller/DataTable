local M = BaseClass("MainPreheatRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))

function M:Check(chapterId)
    self.checkResult = 0
    self.isChecking = true
    UIContextMgr:GetInstance():GetContext("MainPreheatActivityUI"):CheckAwardRedPointAsync(chapterId, function(isShow)
        self.checkResult = isShow and 1 or 0
        self.isChecking = false
    end)
end

return M
