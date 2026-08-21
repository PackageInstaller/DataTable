local configs = {
  mock = {
    id = 1,
    channelName = "mock",
    platform = "cross",
    mock = true,
    showGm = true,
    showShare = true,
    sdkInterface = "sdk.SDKEmpty",
    sdkClassName = "org.cocos2dx.lua.AppActivity",
    loginUrl = "http://cuisine.zhaolugame.com:7001/login?token=%s&device=%s&channel=%s"
  },
  player = {
    id = 2,
    channelName = "player",
    platform = "cross",
    showShare = false,
    mock = true,
    sdkInterface = "sdk.SDKEmpty",
    sdkClassName = "org.cocos2dx.lua.AppActivity",
    loginUrl = "http://cuisine.zhaolugame.com:7001/login?token=%s&device=%s&channel=%s"
  },
  zhaolu = {
    showAccount = true,
    showShare = true,
    platform = "android",
    sdkInterface = "sdk.SDKZhaolu",
    sdkClassName = "org.cocos2dx.lua.AppActivity",
    loginUrl = "http://cuisine.zhaolugame.com:7001/login?userId=%s&device=%s&channel=%s&bind=%s"
  },
  secret = {
    showAccount = true,
    showShare = true,
    platform = "android",
    sdkInterface = "sdk.SDKZhaolu",
    sdkClassName = "org.cocos2dx.lua.AppActivity",
    loginUrl = "http://cuisine.zhaolugame.com:7001/login?userId=%s&device=%s&channel=%s&bind=%s"
  },
  haoyou = {
    showAccount = true,
    showShare = true,
    platform = "android",
    sdkInterface = "sdk.SDKZhaolu",
    sdkClassName = "org.cocos2dx.lua.AppActivity",
    loginUrl = "http://cuisine.zhaolugame.com:7001/login?userId=%s&device=%s&channel=%s&bind=%s"
  },
  taptap = {
    showAccount = true,
    showShare = true,
    platform = "android",
    sdkInterface = "sdk.SDKZhaolu",
    sdkClassName = "org.cocos2dx.lua.AppActivity",
    loginUrl = "http://cuisine.zhaolugame.com:7001/login?userId=%s&device=%s&channel=%s&bind=%s"
  },
  quick = {
    platform = "android",
    showAccount = true,
    showShare = false,
    sdkInterface = "sdk.SDKQuick",
    sdkClassName = "org.cocos2dx.lua.AppActivity",
    loginUrl = "http://cuisine.zhaolugame.com:7001/login?userId=%s&device=%s&channel=%s"
  },
  appstore = {
    showAccount = true,
    platform = "ios",
    showShare = true,
    sdkInterface = "sdk.SDKAppstore",
    sdkClassName = "ChannelManager",
    loginUrl = "http://cuisine.zhaolugame.com:7001/login?token=%s&device=%s&channel=%s"
  },
  momoyu = {
    showAccount = true,
    showShare = true,
    platform = "android",
    sdkInterface = "sdk.SDKZhaolu",
    sdkClassName = "org.cocos2dx.lua.AppActivity",
    loginUrl = "http://cuisine.zhaolugame.com:7001/login?userId=%s&device=%s&channel=%s&bind=%s"
  }
}
return configs
