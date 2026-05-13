local channelConfigs = import(".ChannelConfigs")
local config = channelConfigs[CHANNEL_KEY]
local SDKInterface = {
  m_sdkInstance = require(config.sdkInterface)
}

function SDKInterface:initPlatform(...)
  if self.hasInited then
    return
  end
  cc(self):addComponent("components.behavior.EventProtocol"):exportMethods()
  self.m_sdkInstance:initPlatform(...)
  self.hasInited = true
  self:addEventListener("noticeSdkEvent", function(event)
    self:handleEvent(event)
  end)
end

function SDKInterface:login(...)
  self.m_sdkInstance:login()
end

function SDKInterface:logout(...)
  self.m_sdkInstance:logout()
end

function SDKInterface:exit(...)
  self.m_sdkInstance:exit()
end

function SDKInterface:handleEvent(event)
  if self.m_sdkInstance.handleEvent then
    self.m_sdkInstance:handleEvent(event)
  end
end

function SDKInterface:getChannelName()
  return config.channel
end

function SDKInterface:getLoginUrl(params)
  return self.m_sdkInstance:getLoginUrl(params)
end

function SDKInterface:addEventCallBack(name, callback)
  self.m_sdkInstance:addCallback(name, callback)
end

function SDKInterface:initStore(params)
  self.m_sdkInstance:initStore(params)
end

function SDKInterface:purchase(params)
  self.m_sdkInstance:purchase(params)
end

return SDKInterface
