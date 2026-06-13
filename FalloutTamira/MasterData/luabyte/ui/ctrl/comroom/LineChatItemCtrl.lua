local LineChatItemCtrl = BaseClass("LineChatItemCtrl")
local M = LineChatItemCtrl

function M:__init(view)
    self._view = view
end

--data:heroStory
function M:UpdateItem(data)
    if data == nil then
        return
    end


end

function M:Dispose()
    self:OnDispose()
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return LineChatItemCtrl
