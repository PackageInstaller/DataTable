local OtakuCanteenFootRedPointChecker = BaseClass("OtakuCanteenFootRedPointChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = OtakuCanteenFootRedPointChecker

function M:__init()
    self.dataCenterId = {EGetterID.OtakuData}    
end

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end
    
    self.checkResult = OtakuRedPointMgr.CanteenFoodFinish() and 1 or 0
end


return OtakuCanteenFootRedPointChecker