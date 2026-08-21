local channelConfigs = import(".ChannelConfigs")
local config = channelConfigs[CHANNEL_KEY]
local SDK_CLASS_NAME = channelConfigs[CHANNEL_KEY].sdkClassName
local productIds = {
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5,
  [6] = 6,
  [7] = 52,
  [8] = 53,
  [9] = 54,
  [10] = 55,
  [11] = 56,
  [12] = 57,
  [99] = 18,
  [101] = 19,
  [102] = 7,
  [103] = 8,
  [104] = 17,
  [105] = 23,
  [106] = 22,
  [107] = 25,
  [120] = 24,
  [109] = 20,
  [110] = 21,
  [111] = 27,
  [112] = 28,
  [113] = 29,
  [114] = 30,
  [115] = 31,
  [116] = 32
}
local SDKSamsung = {
  callbacks = {}
}

local function onEnterPlatform()
  sharedDirector:pause()
end

local function onLeavePlatform()
  sharedDirector:resume()
end

function SDKSamsung:initPlatform(...)
  local function callback(event)
    local params = json.decode(event)
    
    if not self.callbacks[params.name] then
      return
    end
    self.callbacks[params.name](params)
  end
  
  luaj.callStaticMethod(SDK_CLASS_NAME, "registerScriptHandler", {callback})
  local initArgs = {}
  luaj.callStaticMethod(SDK_CLASS_NAME, "initPlatform", {
    json.encode(initArgs)
  })
end

function SDKSamsung:cleanup()
  self.callbacks = {}
end

function SDKSamsung:addCallback(name, callback)
  self.callbacks[name] = callback
end

function SDKSamsung:removeCallback(name)
  self.callbacks[name] = nil
end

function SDKSamsung:getDeviceId()
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

function SDKSamsung:getLoginUrl(params)
  local loginUrl = DEBUG > 0 and config.loginUrl_dev or config.loginUrl
  loginUrl = string.format(loginUrl, params.token, self:getDeviceId(), CHANNEL_NAME)
  if appreview then
    loginUrl = loginUrl .. "&appreview=" .. appreview
  end
  return loginUrl
end

function SDKSamsung:login()
  luaj.callStaticMethod(SDK_CLASS_NAME, "login")
end

function SDKSamsung:logout(cleanAutoLogin)
  luaj.callStaticMethod(SDK_CLASS_NAME, "logout")
end

function SDKSamsung:exit()
  MDialog:double({
    text = "确定现在退出游戏么？",
    okCallback = function()
      luaj.callStaticMethod(SDK_CLASS_NAME, "exit")
      sharedDirector:endToLua()
    end,
    cancelCallback = function()
      return true
    end
  })
end

function SDKSamsung:initStore(params)
end

function SDKSamsung:purchase(params)
  params = params or {}
  local request = {}
  request.price = tostring(params.rechargeData.rmb)
  request.name = params.rechargeData.title
  request.productId = tostring(productIds[params.rechargeData.id])
  request.partnerOrderId = params.order
  request.userId = game.platform_uid:sub(1, -3) .. "#" .. game.serverInfo.serverId
  luaj.callStaticMethod(SDK_CLASS_NAME, "doPay", {
    json.encode(request)
  })
  self:addCallback("recharge", function(event)
    game:sendData(actionCodes.Store_purchaseOrderResult, MsgPack.pack({
      status = event.result,
      order = params.order,
      platformOrder = event.orderId
    }))
    if event.result ~= "success" then
      print(event.msg)
      NetManager:removeResponseHandler(actionCodes.Store_ayncPurchaseRpc)
      return
    end
  end)
end

function SDKSamsung:handleEvent(event)
  if event.eventName == "roleLogin" then
    local apiArgs = {
      userId = event.userId,
      roleName = event.roleName,
      roleLevel = event.roleLevel,
      serverId = event.serverId,
      firstLogin = event.firstLogin
    }
    luaj.callStaticMethod(SDK_CLASS_NAME, "roleLogin", {
      json.encode(apiArgs)
    })
  elseif event.eventName == "roleLevel" then
    local apiArgs = {
      roleLevel = event.roleLevel
    }
    luaj.callStaticMethod(SDK_CLASS_NAME, "roleLevel", {
      json.encode(apiArgs)
    })
  elseif event.eventName == "logout" then
  end
end

return SDKSamsung
