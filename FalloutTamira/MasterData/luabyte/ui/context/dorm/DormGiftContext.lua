local DormGiftContext = BaseClass("DormGiftContext", BaseContext)
local M = DormGiftContext

function M:__init()
    self._heroId = 0
end

function M:Open(heroId, callback)
    self._heroId = heroId
    local items = DormDataMgr:GetGiftItems(self._heroId)
    self:_Show(heroId, items, callback)
end

function M:clearCallback()
    local ctrl = self:GetCtrl()
    if ctrl and ctrl._closeCallback then
        ctrl._closeCallback = nil
    end
end 

return DormGiftContext
