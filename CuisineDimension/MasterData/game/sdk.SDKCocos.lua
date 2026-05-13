local channelConfigs = import(".ChannelConfigs")
local config = channelConfigs[CHANNEL_KEY]
local SDK_CLASS_NAME = channelConfigs[CHANNEL_KEY].sdkClassName
local SDKCocos = {
  callbacks = {}
}

local function onEnterPlatform()
  sharedDirector:pause()
end

local function onLeavePlatform()
  sharedDirector:resume()
end

function SDKCocos:initPlatform(...)
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

function SDKCocos:cleanup()
  self.callbacks = {}
end

function SDKCocos:addCallback(name, callback)
  self.callbacks[name] = callback
end

function SDKCocos:removeCallback(name)
  self.callbacks[name] = nil
end

function SDKCocos:getDeviceId()
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

function SDKCocos:getLoginUrl(params)
  local loginUrl = DEBUG > 0 and config.loginUrl_dev or config.loginUrl
  loginUrl = string.format(loginUrl, params.token, self:getDeviceId(), CHANNEL_NAME, _G.CHANNEL_TAG)
  if appreview then
    loginUrl = loginUrl .. "&appreview=" .. appreview
  end
  return loginUrl
end

function SDKCocos:login()
  luaj.callStaticMethod(SDK_CLASS_NAME, "login")
end

function SDKCocos:logout(cleanAutoLogin)
  luaj.callStaticMethod(SDK_CLASS_NAME, "logout")
end

function SDKCocos:exit()
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

function SDKCocos:initStore(params)
end

function SDKCocos:purchase(params)
  params = params or {}
  local request = {}
  request.price = tostring(params.rechargeData.rmb)
  request.name = params.rechargeData.title
  request.desc = params.rechargeData.desc
  request.partnerOrderId = params.order
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

function SDKCocos:handleEvent(event)
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

return SDKCocos
