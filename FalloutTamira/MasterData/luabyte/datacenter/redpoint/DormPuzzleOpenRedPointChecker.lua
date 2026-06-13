local DormPuzzleOpenRedPointChecker = BaseClass("DormPuzzleRedPointChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = DormPuzzleOpenRedPointChecker

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end
    ActivityDataMgr:GetInstance():GetActivitysByTypeAsyn(ActivityType.DORM_PUZZLE, Bind(self, self.AsynCallBack))
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
        isShow = DormPuzzleActivityDataMgr:GetInstance():CheckActivityOpenByData(value)   
        if isShow then
            return true
        end
    end
    return isShow
end

return DormPuzzleOpenRedPointChecker