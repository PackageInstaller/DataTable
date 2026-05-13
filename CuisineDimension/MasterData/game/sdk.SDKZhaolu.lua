local MDiaLog = require("uicontrols.MDialog")
local MFlashMsg = require("uicontrols.MFlashMsg")
local channelConfigs = import(".ChannelConfigs")
local config = channelConfigs[CHANNEL_KEY]
local SDK_CLASS_NAME = channelConfigs[CHANNEL_KEY].sdkClassName
local SDKZhaolu = {
  callbacks = {}
}

local function onEnterPlatform()
  sharedDirector:pause()
end

local function onLeavePlatform()
  sharedDirector:resume()
end

function SDKZhaolu:initPlatform(...)
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

function SDKZhaolu:cleanup()
  self.callbacks = {}
end

function SDKZhaolu:addCallback(name, callback)
  self.callbacks[name] = callback
end

function SDKZhaolu:removeCallback(name)
  self.callbacks[name] = nil
end

function SDKZhaolu:getDeviceId()
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

function SDKZhaolu:getLoginUrl(params)
  local loginUrl = DEBUG > 0 and config.loginUrl_dev or config.loginUrl
  loginUrl = string.format(loginUrl, params.uid, self:getDeviceId(), CHANNEL_NAME, params.bind)
  if appreview then
    loginUrl = loginUrl .. "&appreview=" .. appreview
  end
  return loginUrl
end

function SDKZhaolu:login()
  game:createView("sign.SignInLayer", {
    callback = function(params)
      luaj.callStaticMethod(SDK_CLASS_NAME, "login", {
        json.encode(params)
      })
    end
  })
end

function SDKZhaolu:logout(cleanAutoLogin)
  luaj.callStaticMethod(SDK_CLASS_NAME, "logout")
end

function SDKZhaolu:exit()
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

function SDKZhaolu:initStore(params)
end

function SDKZhaolu:purchase(params)
  params = params or {}
  local rtypes = {"alipay", "wxpay"}
  local url = "http://cuisine.zhaolugame.com:7001/payorder?paytype=%s&rechargeid=%s&order=%s"
  url = string.format(url, rtypes[params.rtype], params.rechargeData.id, params.order)
  local xhr = cc.XMLHttpRequest:new()
  xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
  xhr:open("POST", url)
  xhr:registerScriptHandler(function()
    if xhr.status ~= 200 then
      MDiaLog:single({
        text = "网络连接异常，请检查网络后重新尝试。",
        okText = "重试"
      }, function()
      end)
      return
    end
    local jsonResult = json.decode(xhr.response)
    if jsonResult.errorCode == 100 then
      MDiaLog:single({
        text = jsonResult.errorMsg
      }, function()
      end)
      return
    end
    if jsonResult.errorMsg then
      MFlashMsg:show({
        text = jsonResult.errorMsg
      })
    end
    local request = {}
    if params.rtype == 1 then
      request.order = jsonResult.orderInfo
      luaj.callStaticMethod(SDK_CLASS_NAME, "doAliPay", {
        json.encode(request)
      })
    elseif params.rtype == 2 then
      request = jsonResult
      luaj.callStaticMethod(SDK_CLASS_NAME, "doWxPay", {
        json.encode(request)
      })
    else
      luaj.callStaticMethod(SDK_CLASS_NAME, "doPay", {
        json.encode(request)
      })
    end
    self:addCallback("recharge", function(args)
      local body = {
        order = params.order,
        paytype = args.paytype,
        response = args.response
      }
      print(args.response)
      if args.message then
        MDiaLog:single({
          text = args.message
        }, function()
        end)
        NetManager:removeResponseHandler(actionCodes.Store_ayncPurchaseRpc)
        return
      end
      game:sendData(actionCodes.Store_officialPurchaseRpc, MsgPack.pack(body))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Store_officialPurchaseRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        if msg.result ~= "success" then
          NetManager:removeResponseHandler(actionCodes.Store_ayncPurchaseRpc)
          return
        end
      end)
    end)
  end)
  xhr:send()
end

function SDKZhaolu:handleEvent(event)
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

return SDKZhaolu
