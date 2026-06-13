local DormActivityStoryRedPoint = BaseClass("DormActivityStoryRedPoint",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = DormActivityStoryRedPoint

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end
    if param > 0 then
        self.module = ModuleMgr:GetInstance():GetCurrentModule()
        self.checkResult = self.module:CheckActivityStoryRedpoint() and 1 or 0
    else
        self.checkResult = 0
    end

end

return DormActivityStoryRedPoint