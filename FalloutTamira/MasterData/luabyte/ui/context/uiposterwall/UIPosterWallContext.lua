--baoruichang
--2022/3/24 10:59:47
local UIPosterWallContext = BaseClass("UIPosterWallContext", BaseContext)
local M = UIPosterWallContext

function M:Init()
end

function M:OnClose()
    M.super.OnClose(self)
end

function M:Open(houseFurnitureId)
    self:_Show(houseFurnitureId)
end

return UIPosterWallContext