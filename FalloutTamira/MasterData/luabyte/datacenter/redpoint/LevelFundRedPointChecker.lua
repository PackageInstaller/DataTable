-- 成长基金红点
local BaseRedPointChecker = require("DataCenter.RedPoint.BaseRedPointChecker")
local LevelFundRedPointChecker = BaseClass("LevelFundRedPointChecker", BaseRedPointChecker)
local M = LevelFundRedPointChecker

function M:__init()
    -- checker 依赖的数据中心ID
    self.dataCenterId = {EGetterID.LevelFundData}
end

function M:Check()
    self.checkResult = LevelFundMgr:GetInstance():RedPointCheck() and 1 or 0
end

return LevelFundRedPointChecker
