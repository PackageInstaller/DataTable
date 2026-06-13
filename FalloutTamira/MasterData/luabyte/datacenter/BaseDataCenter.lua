local BaseDataCenter = BaseClass("BaseDataCenter", Singleton)
local M = BaseDataCenter

-- 以下方法 可重写
function M:Init()
end

function M:OnDispose()
end

function M:Cleanup()
end
-- end

-- 以下方法 可调用
function M:_Broadcast(eventName, ...) 
    EventMgr:Broadcast(eventName, ... )
end

function M:_AddListener(eventName, handler)
    if self.m_Events == nil then
        return 
    end
    if self.m_Events[eventName] ~= nil then 
        EventMgr:RemoveListener(eventName, self.m_Events[eventName])
    end
    EventMgr:AddListener(eventName, handler)
    self.m_Events[eventName] = handler
end

function M:_RemoveListener(eventName, handler)
    if self.m_Events == nil then
        return 
    end
    if self.m_Events[eventName] then 
        EventMgr:RemoveListener(eventName, self.m_Events[eventName])
    end
    self.m_Events[eventName] = nil
    EventMgr:RemoveListener(eventName, handler)
end

function M:_RegistResponse(messageId, handler)
    if self.m_Responses == nil then
        return
    end
    if self.m_Responses[messageId] ~= nil then 
        NetPack:UnRegistResponse(messageId, self.m_Responses[messageId])
    end
    NetPack:RegistResponse(messageId, handler)
    self.m_Responses[messageId] = handler
end

function M:_UnRegistResponse(messageId, handler)
    if self.m_Responses == nil then
        return
    end
    if self.m_Responses[messageId] ~= nil then 
        NetPack:UnRegistResponse(messageId, self.m_Responses[messageId])
    end
    self.m_Responses[messageId] = nil
    NetPack:UnRegistResponse(messageId, handler)
end
-- end

-- 以下基类 不要重写
function M:__init(...)
    self.m_Events = {}
    self.m_Responses = {}
    self:Init(...)
end

function M:Dispose()
    if self.m_Events ~= nil then 
        for eventName, handler in pairs(self.m_Events) do
            EventMgr:RemoveListener(eventName, handler)
        end
    end

    if self.m_Responses ~= nil then 
        for messageId, handler in pairs(self.m_Responses) do
            NetPack:UnRegistResponse(messageId, handler)
        end
    end

    self.m_Events = nil 
    self.m_Responses = nil
    self:OnDispose()
end
-- end

return BaseDataCenter
