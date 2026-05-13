local channelConfigs = import(".ChannelConfigs")
local config = channelConfigs[CHANNEL_KEY]
local SDK_CLASS_NAME = channelConfigs[CHANNEL_KEY].sdkClassName
local SDKQuick = {
  callbacks = {}
}

local function onEnterPlatform()
  sharedDirector:pause()
end

local function onLeavePlatform()
  sharedDirector:resume()
end

function SDKQuick:initPlatform(...)
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

function SDKQuick:cleanup()
  self.callbacks = {}
end

function SDKQuick:addCallback(name, callback)
  self.callbacks[name] = callback
end

function SDKQuick:removeCallback(name)
  self.callbacks[name] = nil
end

function SDKQuick:getDeviceId()
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

function SDKQuick:getLoginUrl(params)
  local loginUrl = config.loginUrl
  if CHANNEL_NAME == "yingyongbao" then
    loginUrl = "http://121.196.17.200/login?userId=%s&&device=%s&&channel=%s"
  end
  loginUrl = string.format(loginUrl, params.userId, self:getDeviceId(), CHANNEL_NAME)
  if appreview then
    loginUrl = loginUrl .. "&appreview=" .. appreview
  end
  return loginUrl
end

function SDKQuick:login()
  luaj.callStaticMethod(SDK_CLASS_NAME, "login")
end

function SDKQuick:logout(cleanAutoLogin)
  luaj.callStaticMethod(SDK_CLASS_NAME, "logout")
end

function SDKQuick:exit()
  luaj.callStaticMethod(SDK_CLASS_NAME, "exit")
end

function SDKQuick:initStore(params)
end

function SDKQuick:purchase(params)
  params = params or {}
  local request = {}
  request.roleName = game.role.name
  request.roleId = tostring(game.role.id)
  request.roleLevel = tostring(game.role.level)
  request.cumulCharge = tostring(game.role.cumulCharge)
  request.serverId = tostring(game.serverInfo.serverId)
  request.serverName = game.serverInfo.name
  request.createTime = tostring(game.role.createTime)
  request.price = params.rechargeData.rmb
  if CHANNEL_NAME == "acfun" then
    request.name = params.diamond > 0 and "钻石" or params.rechargeData.ac
  else
    request.name = params.diamond > 0 and "钻石" or params.rechargeData.title
  end
  request.desc = params.rechargeData.desc
  request.productId = params.rechargeData.id
  request.count = params.diamond > 0 and params.diamond or 1
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

function SDKQuick:handleEvent(event)
  if event.eventName == "roleLogin" then
    local apiArgs = {
      userId = tostring(event.userId),
      roleName = event.roleName,
      roleId = tostring(event.roleId),
      roleLevel = tostring(event.roleLevel),
      serverId = tostring(event.serverId),
      serverName = event.serverName,
      cumulCharge = tostring(event.cumulCharge),
      createTime = tostring(event.createTime),
      firstLogin = event.firstLogin
    }
    luaj.callStaticMethod(SDK_CLASS_NAME, "roleLogin", {
      json.encode(apiArgs)
    })
  elseif event.eventName == "roleLevel" then
    local apiArgs = {
      roleName = event.roleName,
      roleId = tostring(event.roleId),
      roleLevel = tostring(event.roleLevel),
      serverId = tostring(event.serverId),
      serverName = event.serverName,
      cumulCharge = tostring(event.cumulCharge),
      createTime = tostring(event.createTime)
    }
    luaj.callStaticMethod(SDK_CLASS_NAME, "roleLevel", {
      json.encode(apiArgs)
    })
  elseif event.eventName == "logout" then
  end
end

return SDKQuick
