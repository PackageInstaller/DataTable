local channelConfigs = import(".ChannelConfigs")
local config = channelConfigs[CHANNEL_KEY]
local SDKEmpty = {
  callbacks = {}
}

local function onEnterPlatform()
  sharedDirector:pause()
end

local function onLeavePlatform()
  sharedDirector:resume()
end

function SDKEmpty:initPlatform(...)
end

function SDKEmpty:cleanup()
  self.callbacks = {}
end

function SDKEmpty:addCallback(name, callback)
  self.callbacks[name] = callback
end

function SDKEmpty:removeCallback(name)
  self.callbacks[name] = nil
end

function SDKEmpty:getDeviceId()
  if UserData.deviceId then
    return UserData.deviceId
  end
  
  function randomId()
    local time = os.time() + 28800
    local timeTab = os.date("!*t", time)
    local timeStr = string.format("%d%02d%02d", timeTab.year, timeTab.month, timeTab.day)
    local secret = crypto.md5(math.randomFloat(0, 1))
    local id = string.format("%s%s", timeStr, secret)
    UserData.deviceId = id
    GameState.save(UserData)
    return id
  end
  
  return randomId()
end

function SDKEmpty:getLoginUrl(params)
  local loginUrl = DEBUG > 0 and config.loginUrl_dev or config.loginUrl
  return string.format(loginUrl, params.token, self:getDeviceId(), CHANNEL_NAME)
end

function SDKEmpty:login()
  self.callbacks.login({
    token = UserData.user
  })
end

function SDKEmpty:logout(cleanAutoLogin)
  MDialog:double({
    text = "确定现在退出游戏么？",
    okCallback = function()
      sharedDirector:endToLua()
    end,
    cancelCallback = function()
      return true
    end
  })
end

function SDKEmpty:initStore(params)
end

function SDKEmpty:purchase(params)
end

return SDKEmpty
