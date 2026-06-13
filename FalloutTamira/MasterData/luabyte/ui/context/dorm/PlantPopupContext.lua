local PlantPopupContext = BaseClass("PlantPopupContext", BaseContext)
local M = PlantPopupContext

function M:__init()
end

function M:_Destory()
    M.super._Destory(self)
end

function M:Open()
    self:_Show()
end

return PlantPopupContext
