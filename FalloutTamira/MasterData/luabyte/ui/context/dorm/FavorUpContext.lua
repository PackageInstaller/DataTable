local FavorUpContext = BaseClass("FavorUpContext", BaseContext)
local M = FavorUpContext

function M:__init()
end

function M:_Destory()
    M.super._Destory(self)
end

function M:Open(heroId, favorLevel, curLevel)
    self:_Show(heroId, favorLevel, curLevel)
end

return FavorUpContext
