---@class BuffHandlerBase
local BuffHandlerBase = class("BuffHandlerBase")

function BuffHandlerBase:OnAdd(buff)
end

function BuffHandlerBase:OnUpdate(buff, dt)
end

function BuffHandlerBase:OnTick(buff)
end

function BuffHandlerBase:OnRemove(buff)
end

function BuffHandlerBase:OnStackChange(buff)
end

return BuffHandlerBase
