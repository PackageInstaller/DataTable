local SDK_CLASS_NAME
if device.platform == "android" then
  SDK_CLASS_NAME = "org.cocos2dx.utils.MiPushAdapter"
elseif device.platform == "ios" then
  SDK_CLASS_NAME = "MiPushAdapter"
end
local MipushApi = {}

function MipushApi.setAlias(alias)
  local apiArgs = {alias = alias}
  if device.platform == "android" then
    apiArgs.category = "default"
    luaj.callStaticMethod(SDK_CLASS_NAME, "setAlias", {
      json.encode(apiArgs)
    })
  elseif device.platform == "ios" then
    luaoc.callStaticMethod(SDK_CLASS_NAME, "setAlias", apiArgs)
  end
end

function MipushApi.unsetAlias(alias)
  local apiArgs = {alias = alias}
  if device.platform == "android" then
    apiArgs.category = "default"
    luaj.callStaticMethod(SDK_CLASS_NAME, "unsetAlias", {
      json.encode(apiArgs)
    })
  elseif device.platform == "ios" then
    luaoc.callStaticMethod(SDK_CLASS_NAME, "unsetAlias", apiArgs)
  end
end

function MipushApi.setUserAccount(userAccount)
  local apiArgs = {userAccount = userAccount}
  if device.platform == "android" then
    apiArgs.category = "default"
    luaj.callStaticMethod(SDK_CLASS_NAME, "setUserAccount", {
      json.encode(apiArgs)
    })
  elseif device.platform == "ios" then
    luaoc.callStaticMethod(SDK_CLASS_NAME, "setUserAccount", apiArgs)
  end
end

function MipushApi.unsetUserAccount(userAccount)
  local apiArgs = {userAccount = userAccount}
  if device.platform == "android" then
    apiArgs.category = "default"
    luaj.callStaticMethod(SDK_CLASS_NAME, "unsetUserAccount", {
      json.encode(apiArgs)
    })
  elseif device.platform == "ios" then
    luaoc.callStaticMethod(SDK_CLASS_NAME, "unsetUserAccount", apiArgs)
  end
end

function MipushApi.subscribe(topic)
  local apiArgs = {topic = topic}
  if device.platform == "android" then
    apiArgs.category = "default"
    luaj.callStaticMethod(SDK_CLASS_NAME, "subscribe", {
      json.encode(apiArgs)
    })
  elseif device.platform == "ios" then
    luaoc.callStaticMethod(SDK_CLASS_NAME, "subscribe", apiArgs)
  end
end

function MipushApi.unsubscribe(topic)
  local apiArgs = {topic = topic}
  if device.platform == "android" then
    apiArgs.category = "default"
    luaj.callStaticMethod(SDK_CLASS_NAME, "unsubscribe", {
      json.encode(apiArgs)
    })
  elseif device.platform == "ios" then
    luaoc.callStaticMethod(SDK_CLASS_NAME, "unsubscribe", apiArgs)
  end
end

function MipushApi.setAcceptTime(startHour, startMin, endHour, endMin)
  local apiArgs = {
    startHour = startHour,
    startMin = startMin,
    endHour = endHour,
    endMin = endMin
  }
  if device.platform == "android" then
    apiArgs.category = "default"
    luaj.callStaticMethod(SDK_CLASS_NAME, "setAcceptTime", {
      json.encode(apiArgs)
    })
  elseif device.platform == "ios" then
  end
end

function MipushApi.pausePush()
  local apiArgs = {}
  if device.platform == "android" then
    apiArgs.category = "default"
    luaj.callStaticMethod(SDK_CLASS_NAME, "pausePush", {
      json.encode(apiArgs)
    })
  elseif device.platform == "ios" then
  end
end

function MipushApi.resumePush()
  local apiArgs = {}
  if device.platform == "android" then
    apiArgs.category = "default"
    luaj.callStaticMethod(SDK_CLASS_NAME, "resumePush", {
      json.encode(apiArgs)
    })
  elseif device.platform == "ios" then
  end
end

function MipushApi.clearNotification(notifyId)
  local apiArgs = {notifyId = notifyId}
  if device.platform == "android" then
    luaj.callStaticMethod(SDK_CLASS_NAME, "clearNotification", {
      json.encode(apiArgs)
    })
  elseif device.platform == "ios" then
  end
end

function MipushApi.clearAllNotification()
  local apiArgs = {}
  if device.platform == "android" then
    luaj.callStaticMethod(SDK_CLASS_NAME, "clearNotification", {
      json.encode(apiArgs)
    })
  elseif device.platform == "ios" then
  end
end

function MipushApi.getRegId()
  local ok, ret
  if device.platform == "android" then
    local sig = "()Ljava/lang/String;"
    ok, ret = luaj.callStaticMethod(SDK_CLASS_NAME, "getRegId", {}, sig)
  elseif device.platform == "ios" then
    ok, ret = luaoc.callStaticMethod(SDK_CLASS_NAME, "getRegId", {})
  end
  if not ok then
    print("luaj error:", ret)
  else
    return ret
  end
end

return MipushApi
