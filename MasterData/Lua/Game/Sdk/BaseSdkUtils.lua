---@class BaseSdkUtils
local BaseSdkUtils = Class("BaseSdkUtils")

function BaseSdkUtils:__init(sdkService)
    self.eventNameListerns = {}
    self.sdkService = sdkService
end
 
function BaseSdkUtils:AddEventName(name , func)
    if self.eventNameListerns[name] then
        Events.RemoveListener(name ,self.eventNameListerns[name])
        self.eventNameListerns[name] = nil 
    end
    self.eventNameListerns[name] = Events.AddListener(name , func)
end

function BaseSdkUtils:ClearEventNameListerns()
    for k, v in pairs(self.eventNameListerns) do
        Events.RemoveListener(k ,v)
    end
end
function BaseSdkUtils:__delete()
    if self.eventNameListerns then
        self:ClearEventNameListerns()
        self.eventNameListerns = nil
    end
    self.sdkService = nil
end
return BaseSdkUtils