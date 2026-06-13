local LotteryRecordContext = BaseClass( "LotteryRecordContext" , BaseContext )
local M = LotteryRecordContext

function M:Init()

end

function M:Open(cfg)
    self:_Show(cfg)
end

function M:OnClose()
    M.super.OnClose(self)
end

return LotteryRecordContext