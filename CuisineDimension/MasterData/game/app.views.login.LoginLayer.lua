local channelConfigs = require("sdk.ChannelConfigs")
local config = channelConfigs[CHANNEL_KEY]
local MDiaLog = require("uicontrols.MDialog")
local MFlashMsg = require("uicontrols.MFlashMsg")
local sdkInterface = require("sdk.SDKInterface")
local loginRes = "ui/login/"
local isCheck = false
local uiData = {
  csbFile = "ui/login/LoginLayer.csb",
  widgets = {
    bgNode = "bgNode",
    serverBg = "serverBg",
    serverStatus = "serverBg/serverStatus",
    serverName = "serverBg/serverName",
    enterBg = "enterBg",
    accountBtn = "accountBtn",
    version = "version",
    tipNode = "tipNode",
    copyright = "copyright",
    videoBtn = "videoBtn"
  }
}
local fileUtils = cc.FileUtils:getInstance()
local LoginLayer = class("LoginLayer", UIBase)

function LoginLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function LoginLayer:init(params)
  UIHelper.fitForiPhoneX(self.bgNode)
  local spine = UIHelper.createSpineNodeByRes("spine/ui/login/Login")
  spine:addTo(self.bgNode)
  spine:setAnimation(0, "in", false)
  spine:addAnimation(0, "loop", true)
  spine:registerSpineEventHandler(function(event)
    self:showUI()
  end, sp.EventType.ANIMATION_EVENT)
  self.serverBg:hide()
  self.enterBg:hide()
  self.accountBtn:hide()
  self.enterBg:setTouchScale()
  self.accountBtn:setTouchScale()
  self.serverBg:setCascadeOpacityEnabled(true)
  self.enterBg:setCascadeOpacityEnabled(true)
  self.accountBtn:setCascadeOpacityEnabled(true)
  self.copyright:hide()
  self.version:hide()
  self.videoBtn:hide()
  local spine = UIHelper.createSpineNodeByRes("spine/ui/login/LoginButton")
  spine:pos(209, 81):addTo(self.enterBg, -1)
  spine:setAnimation(0, "special", true)
  local spine = UIHelper.createSpineNodeByRes("spine/ui/login/LoginButton")
  spine:pos(209, 81):addTo(self.accountBtn)
  spine:setAnimation(0, "special", true)
  game:playMusic(12)
  local curList = {ver = "1.0.0"}
  if fileUtils:isFileExist(device.writablePath .. "flist") then
    curList = dofile(device.writablePath .. "flist")
  elseif fileUtils:isFileExist("flist") then
    local data = cc.HelperFunc:getFileData("flist")
    curList = assert(loadstring(data))()
  end
  game.clientVersion = curList.ver
  self.version:setString("版本号: " .. curList.ver)
  local ageTips = UIHelper.extend(ccui.Button:create())
  ageTips:setImages("ui/login/", {
    "age12tips.png",
    "age12tips.png"
  })
  ageTips:anch(0.5, 0.5):scale(0.57):pos(510, 221):addTo(self.bgNode):setTouchScale()
  ageTips:setCallback(function()
    game:createView("global.RuleLayer", {typeStr = "age_tips"})
  end)
  NetManager:clearHeartBeat()
end

function LoginLayer:showUI()
  self.copyright:show()
  self.version:show()
  self.videoBtn:show()
  self:CheckPrivacyBox()
  self:initSdkInterface()
  if config.showAccount then
    self.accountBtn:show()
    UIHelper.MoveToUp({
      node = self.accountBtn,
      pos = {0, 20}
    })
  end
  if config.mock and not UserData.user then
    self:showUserAccount()
  end
  self.enterBg:setCallback(function()
    if not UserData.lastServerId then
      return
    end
    if not isCheck then
      MFlashMsg:show({
        text = "主厨，您还没没有勾选用户协议和隐私政策哦~"
      })
      return
    end
    game.serverInfo = self.serverList[UserData.lastServerId]
    game.noticeUrl = self.noticeUrl
    NetManager:login()
  end)
  self.serverBg:setCallback(function()
    local layer = game:createView("login.ServerListLayer", {
      serverList = self.serverList,
      parent = self
    })
  end)
  self.videoBtn:setCallback(function()
    self:showPV()
    self.videoBtn:setTouchEnabled(false)
  end)
  local accountTime = 0
  self.accountBtn:setCallback(function()
    if os.time() - accountTime < 1 then
      return
    end
    sdkInterface:login()
    accountTime = os.time()
  end)
  if config.mock and UserData.user then
    sdkInterface:login()
  end
end

function LoginLayer:showData(params)
  if game.role then
    game.role:reset()
  end
  game.role = nil
  if device.platform == "android" then
    scheduler.performWithDelayGlobal(function()
      luaj.callStaticMethod(ANDROID_CLASSNAME, "networkMonitor", {}, "()V")
    end, 0.1)
  end
end

function LoginLayer:initSdkInterface()
  sdkInterface:addEventCallBack("login", function(event)
    if event.errorCode then
      if self.accountBtn and not tolua.isnull(self.accountBtn) then
        self.accountBtn:show()
      end
      return
    end
    if self.accountBtn and not tolua.isnull(self.accountBtn) then
      self.accountBtn:hide()
    end
    local checkAge = event.checkAge
    local age = event.age and tonumber(event.age)
    local visit = event.visit
    local phone = event.phone
    self:showTip("正在获取服务器列表...", 0.3)
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    xhr:open("GET", sdkInterface:getLoginUrl(event))
    xhr:registerScriptHandler(function()
      self.tipNode:removeAllChildren()
      if xhr.status ~= 200 then
        MDiaLog:single({
          text = "网络连接异常，请检查网络后重新尝试。",
          okText = "重试"
        }, function()
          sdkInterface:login()
        end)
        return
      end
      if tolua.isnull(self) then
        return
      end
      local jsonResult = json.decode(xhr.response)
      game.checkAge = jsonResult.checkAge or checkAge
      if not game.age or game.age < 18 then
        game.age = jsonResult.age or age
      end
      game.visit = visit
      print(string.format("全局信息 朝露account=%s age=%s visit=%s", game.account or "unknown", game.age or "unknown", game.visit and "yes" or "no"))
      local codeHandlers = {
        [0] = function()
          game.platform_uid = jsonResult.userid
          game.platform_sid = jsonResult.sid
          self.serverList = jsonResult.serverList
          self.noticeUrl = string.gsub(jsonResult.noticeUrl, "%%(%x%x)", function(hex)
            return string.char(tonumber(hex, 16))
          end)
          self:showNotice()
        end,
        [1] = function()
          self:showUserAccount()
        end,
        [2] = function()
          self:showUserAccount()
        end,
        [100] = function()
          MDiaLog:single({
            text = jsonResult.errorMsg
          }, function()
            sharedDirector:endToLua()
          end)
        end
      }
      if codeHandlers[jsonResult.errorCode] then
        codeHandlers[jsonResult.errorCode]()
      end
    end)
    xhr:send()
  end)
  sdkInterface:addEventCallBack("logout", function(event)
    game:enterScene("LoginScene")
  end)
  sdkInterface:initPlatform({})
end

function LoginLayer:showNotice()
  self:showCurrentServer()
end

function LoginLayer:showCurrentServer()
  self.serverBg:show()
  self.enterBg:show()
  self.accountBtn:hide()
  UIHelper.MoveToUp({
    node = self.serverBg
  })
  UIHelper.MoveToUp({
    node = self.enterBg,
    pos = {0, 20}
  })
  local lastServerId = UserData.lastServerId
  local serverIds = table.keys(self.serverList)
  table.sort(serverIds, function(a, b)
    return a < b
  end)
  for serverId, info in pairs(self.serverList) do
    if info.recommend then
      self.recommend = serverId
      break
    end
  end
  if not lastServerId or lastServerId > #serverIds then
    UserData.lastServerId = self.recommend or serverIds[#serverIds]
    GameState.save(UserData)
  end
  local index = table.indexof(serverIds, UserData.lastServerId)
  local serverInfo = self.serverList[UserData.lastServerId]
  self.serverName:setString(string.format("%d区 %s", index, serverInfo.name))
  local status = ""
  if serverInfo.free >= 0.8 then
    status = "爆满"
  elseif serverInfo.free >= 0.2 then
    status = "空闲"
  else
    status = "新服"
  end
  self.serverStatus:setString(status)
end

function LoginLayer:showUserAccount()
  game:createView("login.ActivationLayer", {
    scene = self,
    sdk = sdkInterface,
    callback = function(serverList, noticeUrl)
      self.serverList = serverList
      self.noticeUrl = noticeUrl
      self:showNotice()
    end
  })
end

function LoginLayer:showTip(text, delay)
  self.tipNode:removeAllChildren()
  self.tipNode:stopAllActions()
  self.tipNode:show()
  UIHelper.createJeteWord({
    text = text,
    outline = display.COLOR_BLACK
  }):addTo(self.tipNode)
  if delay then
    self.tipNode:hide()
    self.tipNode:runAction(transition.sequence({
      cc.DelayTime:create(delay),
      cc.Show:create()
    }))
  end
end

function LoginLayer:showPV()
  if device.platform ~= "android" and device.platform ~= "ios" then
    return
  end
  self:hide()
  ccexp.AudioEngine:pauseAll()
  local visibleRect = cc.Director:getInstance():getOpenGLView():getVisibleRect()
  local centerPos = cc.p(visibleRect.x + visibleRect.width / 2, visibleRect.y + visibleRect.height / 2)
  _G.touchMaskEnabled = false
  local skipLayer = UIHelper.extend(ccui.Layout:create())
  local videoPlayer = ccexp.VideoPlayer:create()
  videoPlayer:addTo(display.getRunningScene(), 10000)
  videoPlayer:setPosition(centerPos)
  videoPlayer:setAnchorPoint(cc.p(0.5, 0.5))
  videoPlayer:setContentSize(cc.size(display.width, display.height))
  videoPlayer:setFullScreenEnabled(true)
  videoPlayer:setKeepAspectRatioEnabled(true)
  local frameSize = cc.Director:getInstance():getOpenGLView():getFrameSize()
  if frameSize.width == 2436 and frameSize.height == 1125 then
    videoPlayer:setContentSize(cc.size(frameSize.width, frameSize.height))
    videoPlayer:setKeepAspectRatioEnabled(false)
  end
  game.videoHandler = videoPlayer
  
  local function onVideoEventCallback(sener, eventType)
    if eventType == ccexp.VideoPlayerEvent.STOPPED or eventType == ccexp.VideoPlayerEvent.COMPLETED then
      skipLayer:removeSelf()
      scheduler.performWithDelayGlobal(function()
        videoPlayer:removeSelf()
        _G.touchMaskEnabled = true
        self.videoBtn:setTouchEnabled(true)
      end, 0.03333333333333333)
      self:show()
      ccexp.AudioEngine:resumeAll()
      game.videoHandler = nil
    end
  end
  
  videoPlayer:addEventListener(onVideoEventCallback)
  videoPlayer:setFileName(cc.FileUtils:getInstance():fullPathForFilename("video/openvcr.mp4"))
  videoPlayer:setTouchable(true)
  videoPlayer:play()
  skipLayer:size(display.width, display.height):addTo(display.getRunningScene(), 10001)
  skipLayer:setCallback(function()
    videoPlayer:stop()
  end)
end

function LoginLayer:CheckPrivacyBox()
  local blockBg = UIHelper.newImageView(loginRes .. "block_bg.png"):anch(0.5, 0.5):pos(250, -250):addTo(self.bgNode)
  blockBg:setScale(0.6)
  blockBg:setTouchEnabled(true)
  isCheck = cc.UserDefault:getInstance():getBoolForKey("privacyCheck")
  if isCheck then
    UIHelper.newImageView(loginRes .. "yes.png"):center(blockBg):addTo(blockBg)
  end
  blockBg:setCallback(function()
    if not isCheck then
      UIHelper.newImageView(loginRes .. "yes.png"):center(blockBg):addTo(blockBg)
      isCheck = true
    else
      blockBg:removeAllChildren()
      isCheck = false
    end
    cc.UserDefault:getInstance():setBoolForKey("privacyCheck", isCheck)
  end)
  local label = display.newTTFLabel({
    text = "我已阅读并同意",
    size = 14
  }):anch(0, 0.5):pos(268, -250):addTo(self.bgNode):enableOutline(UIHelper.hex2rgb("#000000"), 1)
  local label2 = display.newTTFLabel({
    text = "《用户协议和隐私政策》",
    size = 14,
    color = UIHelper.hex2rgb("#0000ff")
  }):anch(0, 0.5):pos(360, -250):addTo(self.bgNode)
  local btn = UIHelper.extend(ccui.Button:create()):opacity(0.001)
  btn:setImages(loginRes, {
    "server_bg.png",
    "server_bg.png"
  })
  local btnSize = cc.size(154, 30)
  btn:setAnchorPoint(cc.p(0, 0.5))
  btn:setContentSize(btnSize)
  btn:pos(360, -250):addTo(self.bgNode)
  btn:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "secret_safe",
      isFirstSecret = false,
      okCallback = function()
        UserData.firstSecret = 1
        GameState.save(UserData)
        blockBg:removeAllChildren()
        UIHelper.newImageView(loginRes .. "yes.png"):center(blockBg):addTo(blockBg)
        if not isCheck then
          isCheck = true
          cc.UserDefault:getInstance():setBoolForKey("privacyCheck", isCheck)
        end
      end,
      cancelCallback = function()
        blockBg:removeAllChildren()
        isCheck = false
        cc.UserDefault:getInstance():setBoolForKey("privacyCheck", isCheck)
      end
    })
  end)
end

return LoginLayer
