local DressupEnterContext = BaseClass("DressupEnterContext", BaseContext)
local M = DressupEnterContext

function M:__init()
end

function M:_Destory()
    M.super._Destory(self)
end

function M:Open(furnitureId, curFurnitureId)
    self:_Show(furnitureId, curFurnitureId)
end

return DressupEnterContext
