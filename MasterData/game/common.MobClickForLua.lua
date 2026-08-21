local SDK_CLASS_NAME
if device.platform == "android" then
  SDK_CLASS_NAME = "org.cocos2dx.utils.UmengAdapter"
elseif device.platform == "ios" then
  SDK_CLASS_NAME = "UmengAdapter"
end
local MobClickForLua = {
  callbacks = {}
}

function MobClickForLua:init()
  local function callback(params)
    if not self.callbacks[params.name] then
      return
    end
    self.callbacks[params.name](params)
  end
  
  if device.platform == "android" then
    luaj.callStaticMethod(SDK_CLASS_NAME, "registerScriptHandler", {callback})
  elseif device.platform == "ios" then
    luaoc.callStaticMethod(SDK_CLASS_NAME, "registerScriptHandler", {listener = callback})
  end
  return self
end

function MobClickForLua:cleanup()
  self.callbacks = {}
  if device.platform == "android" then
    luaj.callStaticMethod(SDK_CLASS_NAME, "unregisterScriptHandler", {callback})
  elseif device.platform == "ios" then
    luaoc.callStaticMethod(SDK_CLASS_NAME, "unregisterScriptHandler", {})
  end
end

function MobClickForLua.setLogEnabled(value)
  if device.platform == "android" then
  elseif device.platform == "ios" then
  end
end

function MobClickForLua.setProxy(host, port)
  if device.platform == "android" then
  elseif device.platform == "ios" then
  end
end

function MobClickForLua.setSessionIdleLimit(seconds)
  if device.platform == "android" then
  elseif device.platform == "ios" then
  end
end

function MobClickForLua.setEncryptEnabled(value)
  if device.platform == "android" then
  elseif device.platform == "ios" then
  end
end

function MobClickForLua.event(eventId, ...)
  if device.platform == "android" then
  elseif device.platform == "ios" then
  end
end

function MobClickForLua.eventWithAttributesString(eventId, attributes, ...)
  if device.platform == "android" then
  elseif device.platform == "ios" then
  end
end

function MobClickForLua.beginLogPageView(pageViewName)
  if device.platform == "android" then
  elseif device.platform == "ios" then
  end
end

function MobClickForLua.endLogPageView(pageViewName)
  if device.platform == "android" then
  elseif device.platform == "ios" then
  end
end

function MobClickForLua.updateOnlineConfig(...)
  if device.platform == "android" then
  elseif device.platform == "ios" then
  end
end

function MobClickForLua.getConfigParam(key)
  if device.platform == "android" then
  elseif device.platform == "ios" then
  end
end

function MobClickForLua.profileSignIn(puid, ...)
  local params = {
    ...
  }
  local umengArgs
  if #params == 1 then
    umengArgs = {
      userId = puid,
      provider = params[1]
    }
  else
    umengArgs = {userId = puid}
  end
  if device.platform == "android" then
  elseif device.platform == "ios" then
    luaoc.callStaticMethod(SDK_CLASS_NAME, "profileSignIn", umengArgs)
  end
end

function MobClickForLua.profileSignOff()
  if device.platform == "android" then
  elseif device.platform == "ios" then
    luaoc.callStaticMethod(SDK_CLASS_NAME, "profileSignOff", {})
  end
end

function MobClickForLua.setUserLevel(level)
  local umengArgs = {level = level}
  if device.platform == "android" then
  elseif device.platform == "ios" then
    luaoc.callStaticMethod(SDK_CLASS_NAME, "setUserLevelId", umengArgs)
  end
end

function MobClickForLua.startLevel(level)
  local umengArgs = {gate = level}
  if device.platform == "android" then
  elseif device.platform == "ios" then
    luaoc.callStaticMethod(SDK_CLASS_NAME, "startLevel", umengArgs)
  end
end

function MobClickForLua.finishLevel(level)
  local umengArgs = {gate = level}
  if device.platform == "android" then
  elseif device.platform == "ios" then
    luaoc.callStaticMethod(SDK_CLASS_NAME, "finishLevel", umengArgs)
  end
end

function MobClickForLua.failLevel(level)
  local umengArgs = {gate = level}
  if device.platform == "android" then
  elseif device.platform == "ios" then
    luaoc.callStaticMethod(SDK_CLASS_NAME, "failLevel", umengArgs)
  end
end

function MobClickForLua.pay(cash, source, ...)
  local params = {
    ...
  }
  local umengArgs
  if #params == 1 then
    umengArgs = {
      amount = cash,
      count = params[1],
      source = source
    }
  elseif #params == 3 then
    umengArgs = {
      amount = cash,
      item = params[1],
      count = params[2],
      price = params[3],
      source = source
    }
  end
  if device.platform == "android" then
  elseif device.platform == "ios" then
    luaoc.callStaticMethod(SDK_CLASS_NAME, "pay", umengArgs)
  end
end

function MobClickForLua.buy(item, amount, price)
  local umengArgs = {
    item = item,
    count = amount,
    price = price
  }
  if device.platform == "android" then
  elseif device.platform == "ios" then
    luaoc.callStaticMethod(SDK_CLASS_NAME, "buy", umengArgs)
  end
end

function MobClickForLua.use(item, amount, price)
  local umengArgs = {
    item = item,
    count = amount,
    price = price
  }
  if device.platform == "android" then
  elseif device.platform == "ios" then
    luaoc.callStaticMethod(SDK_CLASS_NAME, "use", umengArgs)
  end
end

function MobClickForLua.bonus(...)
  local params = {
    ...
  }
  local umengArgs
  if #params == 2 then
    umengArgs = {
      count = params[1],
      source = params[2]
    }
  elseif #params == 4 then
    umengArgs = {
      item = params[1],
      count = params[2],
      price = params[3],
      source = params[4]
    }
  end
  if device.platform == "android" then
  elseif device.platform == "ios" then
    luaoc.callStaticMethod(SDK_CLASS_NAME, "bonus", umengArgs)
  end
end

function MobClickForLua.setLatency(latency)
  if device.platform == "android" then
  elseif device.platform == "ios" then
  end
end

function MobClickForLua.shareContent(umengArgs)
  if device.platform == "android" then
    luaj.callStaticMethod(SDK_CLASS_NAME, "shareContent", {
      json.encode(umengArgs)
    })
  elseif device.platform == "ios" then
    luaoc.callStaticMethod(SDK_CLASS_NAME, "shareContent", umengArgs)
  end
end

return MobClickForLua.init(MobClickForLua)
