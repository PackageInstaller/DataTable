local NoticeRedPointChecker = BaseClass("NoticeRedPointChecker",
    require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = NoticeRedPointChecker

function M:__init()
    self.dataCenterId = { EGetterID.NoticeData }
end

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end

    self.checkResult = INoticeDataMgr:CheckNoticeRedPoint(param) and 1 or 0
end

return NoticeRedPointChecker
