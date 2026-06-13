local OtakuProduceRedPointChecker = BaseClass("OtakuProduceRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = OtakuProduceRedPointChecker

function M:__init()
    self.dataCenterId = {EGetterID.OtakuData}    
end

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end
    
    self.checkResult = OtakuRedPointMgr.ProduceItemFinish() and 1 or 0
end

return OtakuProduceRedPointChecker
