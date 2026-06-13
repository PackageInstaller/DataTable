local DormPuzzleActivityContext = BaseClass("DormPuzzleActivityContext", BaseContext)
local M = DormPuzzleActivityContext

function M:Init()
end

function M:Open()
    self:_Show()
end

function M:OnClose()
    M.super.OnClose(self)
end

return DormPuzzleActivityContext