local TcpSocket = require("network.TcpSocket")
local ByteBuffer = require("network.ByteBuffer")
local DateCsv = require("csvdata.date")
local sdkInterface = require("sdk.SDKInterface")
local NetManager = class("NetManager")
local XXTEA_KEY = "699D448D6D24f7F941E9F6E99F823E18"

function NetManager:ctor()
  cc(self):addComponent("components.behavior.EventProtocol"):exportMethods()
  self.tcpSocket = nil
  self.heartBeatHandler = nil
  self.byteBuffer = ByteBuffer:create()
  self.retryCount = 0
  self.lastHeartTime = 0
  self.totalWave = 0
  self.waveTag = {}
  self.roleData = {}
  
  function _G.netchange(networkName)
    if not self.preNetwordName or networkName ~= self.preNetwordName then
      self:closeSocket(true)
    end
    self.preNetwordName = networkName
  end
end

function NetManager:sendData(actionCode, binaray, showMask, sender)
  if not self.tcpSocket then
    return false
  end
  local msgData = self:packMsg(actionCode, binaray)
  local result = self.tcpSocket:send(msgData)
  if actionCode ~= actionCodes.Sys_heartBeat then
    printInfo("send: %s", actionHandlers[actionCode])
  end
  return result
end

function NetManager:addResponseHandler(actionCode, callback, keep)
  local handlerName = actionHandlers[actionCode]
  if string.sub(handlerName, -3, -1) == "Rpc" then
    actionCode = actionCode + rpcResponseBegin
  end
  self:addEventListener(actionHandlers[actionCode], function(event)
    event.stop(event)
    if not keep then
      self:removeEventListenersByEvent(actionHandlers[actionCode])
    end
    callback(event)
  end)
end

function NetManager:removeResponseHandler(actionCode)
  local handlerName = actionHandlers[actionCode]
  if string.sub(handlerName, -3, -1) == "Rpc" then
    actionCode = actionCode + rpcResponseBegin
  end
  self:removeEventListenersByEvent(actionHandlers[actionCode])
end

function NetManager:newSocket(host, port)
  if self.tcpSocket then
    self:closeSocket()
  end
  self.tcpSocket = TcpSocket.new(host, port, false)
  self.tcpSocket:addEventListener(TcpSocket.EVENT_CONNECTED, handler(self, self.onConnected))
  self.tcpSocket:addEventListener(TcpSocket.EVENT_CLOSE, handler(self, self.onStatus))
  self.tcpSocket:addEventListener(TcpSocket.EVENT_CLOSED, handler(self, self.onClosed))
  self.tcpSocket:addEventListener(TcpSocket.EVENT_CONNECT_FAILURE, handler(self, self.onConnectFailed))
  self.tcpSocket:addEventListener(TcpSocket.EVENT_DATA, handler(self, self.onData))
  self._host = host
  self._port = port
  return self.tcpSocket:connect()
end

function NetManager:recvMessage(actionName, body)
  if actionName ~= "Role.notifyNewEvent" then
    printInfo("recv message: %s", actionName)
  end
  if actionName == "Role.pipelining" then
    local pipelining = MsgPack.unpack(body)
    for _, msg in ipairs(pipelining) do
      local curName = actionHandlers[msg[1]]
      if curName and curName ~= "" then
        self:recvMessage(curName, msg[2])
      end
    end
  else
    self:dispatchEvent({name = actionName, data = body})
  end
end

function NetManager:onData(__event)
  local msgs = self.byteBuffer:paserMessage(__event.data)
  for _, message in ipairs(msgs) do
    local cmd = struct.unpack("H", string.sub(message, 1, 2))
    local body = string.sub(message, 3)
    local actionName = actionHandlers[cmd]
    if not actionName or actionName == "" then
      return
    end
    if 4 < #body then
      body = crypto.decryptXXTEA(body, XXTEA_KEY)
    end
    self:recvMessage(actionName, body)
  end
end

function NetManager:onConnected(event)
  if self.byteBuffer then
    self.byteBuffer:reset()
  end
  self:dispatchEvent({
    name = "networkConnected"
  })
end

function NetManager:onClosed(event)
  self:dispatchEvent({
    name = "networkClosed"
  })
end

function NetManager:onConnectFailed(event)
end

function NetManager:onStatus(__event)
  echoInfo("socket status: %s", __event.name)
end

function NetManager:closeSocket(keepHeartBeat)
  if self.tcpSocket then
    self.tcpSocket:close()
    self.tcpSocket:disconnect()
    self.tcpSocket:removeAllEventListeners()
    self.tcpSocket = nil
  end
  if not keepHeartBeat and self.heartBeatHandler then
    scheduler.unscheduleGlobal(self.heartBeatHandler)
    self.heartBeatHandler = nil
  end
end

function NetManager:startHeartBeat()
  local first = true
  if self.reConnectHandler then
    scheduler.unscheduleGlobal(self.reConnectHandler)
    self.reConnectHandler = nil
  end
  if self.heartBeatHandler then
    scheduler.unscheduleGlobal(self.heartBeatHandler)
    self.heartBeatHandler = nil
  end
  local child = display.getRunningScene():getChildByTag(NETWORK_WAITING_TAG)
  if child then
    display.getRunningScene():removeChildByTag(NETWORK_WAITING_TAG)
  end
  self.heartBeatHandler = scheduler.scheduleGlobal(function()
    if not self:sendData(actionCodes.Sys_heartBeat, first and "skip" or "") then
      self:showConnectFailTip()
    end
    first = false
  end, 5)
end

function NetManager:packMsg(actionCode, binaray)
  local data = struct.pack("H", actionCode)
  data = data .. crypto.encryptXXTEA(binaray, XXTEA_KEY)
  local head = struct.pack(ByteBuffer.PACKAGE_HEAD_FMT, #data)
  return head .. data
end

function NetManager:getDeviceId()
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

function NetManager:login(reConnect)
  self:removeEventListenersByEvent("networkConnected")
  self:addEventListener("networkConnected", function(e1)
    e1.stop(e1)
    self:removeEventListenersByEvent("networkConnected")
    local bin = MsgPack.pack({
      uid = game.platform_uid,
      subId = game.platform_sid
    })
    self:removeResponseHandler(actionCodes.Role_queryLoginRpc)
    local result = self:sendData(actionCodes.Role_queryLoginRpc, bin)
    self:setTips("正在请求登录...")
    self:setTimeout(15)
    self:addResponseHandler(actionCodes.Role_queryLoginRpc, function(e2)
      local msg = MsgPack.unpack(e2.data)
      self:clearTimeout()
      if msg.ret == "RET_NOT_EXIST" then
        local bin = MsgPack.pack({
          uid = game.platform_uid,
          subId = game.platform_sid,
          device = self:getDeviceId()
        })
        self:removeResponseHandler(actionCodes.Role_createRpc)
        self:sendData(actionCodes.Role_createRpc, bin)
        self:setTips("正在登记主厨的信息...")
        self:setTimeout(30)
        self:addResponseHandler(actionCodes.Role_createRpc, function(e3)
          local msg = MsgPack.unpack(e3.data)
          self:clearTimeout()
          if msg.result == "SUCCESS" then
            game.role = nil
            self:loadRoleData(msg.roleName, reConnect)
          else
            self:showLoginFailTip()
          end
        end)
      elseif msg.ret == "RET_HAS_EXISTED" then
        self:loadRoleData(msg.name, reConnect)
      elseif msg.ret == "RET_SERVER_FULL" then
        self:showLoginFailTip()
      elseif msg.ret == "INNER_ERROR" then
        self:closeSocket(true)
      end
    end)
  end)
  local host = game.serverInfo and game.serverInfo.host or self._host
  local port = game.serverInfo and game.serverInfo.port or self._port
  local Active = false
  if Active then
    game.platform_uid = "1000495123"
    port = 9801
    host = "vva.zhaolugame.com" or game.serverInfo and game.serverInfo.host or self._host
    local length = game.platform_uid:len()
    local lastTwo = string.sub(game.platform_uid, length - 1, -1)
    local sid = tonumber(lastTwo)
    game.platform_sid = sid
  end
  self:setTips("正在建立新的联系...")
  self:setTimeout(15, function()
    self:removeEventListenersByEvent("networkConnected")
  end)
  if not self:newSocket(host, port) then
    self:removeEventListenersByEvent("networkConnected")
    return false
  end
  return true
end

function NetManager:loadRoleData(name, reConnect)
  local bin = MsgPack.pack({
    name = name,
    version = globalCsv.version,
    device = self:getDeviceId(),
    account = game.account
  })
  self:removeResponseHandler(actionCodes.Role_loginRpc)
  self:sendData(actionCodes.Role_loginRpc, bin)
  self:setTips("主厨，正在努力加载数据...")
  self:setTimeout(60)
  local age = 18
  self.totalWave = 0
  self.waveTag = {}
  self.roleData = {}
  self:addResponseHandler(actionCodes.Role_loginRpc, function(event)
    local msg = MsgPack.unpack(event.data)
    if msg.result == "GM_TIP" then
      self:showLoginFailTip(msg.body)
      return
    end
    if msg.result == "UPDATE_TIP" then
      self:showLoginFailTip("你的客户端需要更新，请重启游戏。", true)
      return
    end
    if msg.wave then
      print("roleWave", msg.wave)
      self.totalWave = msg.wave
      for key, value in pairs(msg) do
        self.roleData[key] = value
      end
      self.waveTag[1] = true
    end
    if msg.heroWave then
      print("heroWave", msg.heroWave)
      if not self.roleData.heros then
        self.roleData.heros = {}
      end
      for _, hero in pairs(msg.heros) do
        table.insert(self.roleData.heros, hero)
      end
      self.waveTag[msg.heroWave] = true
    end
    if msg.equipWave then
      print("equipWave", msg.equipWave)
      if not self.roleData.equips then
        self.roleData.equips = {}
      end
      for _, equip in pairs(msg.equips) do
        table.insert(self.roleData.equips, equip)
      end
      self.waveTag[msg.equipWave] = true
    end
    if msg.sauceWave then
      print("sauceWave", msg.sauceWave)
      if not self.roleData.sauces then
        self.roleData.sauces = {}
      end
      for _, sauce in pairs(msg.sauces) do
        table.insert(self.roleData.sauces, sauce)
      end
      self.waveTag[msg.sauceWave] = true
    end
    if msg.unionWave then
      print("unionWave", msg.unionWave)
      self.roleData.unionData = msg.unionData
      self.waveTag[msg.unionWave] = true
    end
    if msg.storybookWave then
      print("storybookWave", msg.storybookWave)
      local storyBook = msg.storyBook
      local tempBook2 = {}
      local storyBookData = (msg.storyBook["2"] or ""):toTableArray(" ")
      for _, data in pairs(storyBookData) do
        tempBook2[data[1]] = {
          check = tonumber(data[2]),
          love = tonumber(data[3]),
          loveBreak = tonumber(data[4])
        }
      end
      storyBook["2"] = tempBook2
      self.roleData.storyBook = json.encode(storyBook)
      self.waveTag[msg.storybookWave] = true
    end
    if self.totalWave > 0 then
      local finish = true
      for _wave = 1, self.totalWave do
        if not self.waveTag[_wave] then
          finish = false
          break
        end
      end
      if finish then
        self:clearTimeout()
        local child = display.getRunningScene():getChildByTag(NETWORK_WAITING_TAG)
        if child then
          display.getRunningScene():removeChildByTag(NETWORK_WAITING_TAG)
        end
        self:removeResponseHandler(actionCodes.Role_loginRpc)
        if game.checkAge and game.age < 18 then
          local desc = ""
          local date = CommonHelper.date(self.roleData.serverTime)
          local canPlay = DateCsv[tonumber(string.format("%d%02d%02d", date.year, date.month, date.day))] and true or false
          if not canPlay or date.hour >= 21 or date.hour < 20 then
            desc = "未成年用户无法在此时间段登录游戏，请您谅解"
          end
          if desc ~= "" then
            self:closeSocket()
            local child = display.getRunningScene():getChildByTag(NETWORK_WAITING_TAG)
            if child then
              display.getRunningScene():removeChildByTag(NETWORK_WAITING_TAG)
            end
            MDialog:single({
              text = desc,
              tag = NETWORK_TIPS_TAG,
              order = NETWORK_WAITING_ORDER - 1
            }, function()
              cc.Director:getInstance():endToLua()
            end)
            return
          end
        end
        local reConnect = game.role ~= nil
        g_protocolHanders[actionCodes.Role_loginRpc](self.roleData)
        self:dispatchEvent({
          name = "networkLogin"
        })
        if reConnect and display.getRunningScene().name ~= "BattleScene" and game.role.majorGuideStep <= MAX_MAJOR_STEP then
          game:enterScene("MainScene")
        end
        self:startHeartBeat()
      end
    end
  end, true)
end

function NetManager:showConnectFailTip(showDialog)
  self:closeSocket()
  self:clearTimeout()
  
  local function reCon()
    self.retryCount = 0
    if self.reConnectHandler then
      scheduler.unscheduleGlobal(self.reConnectHandler)
    end
    self.reConnectHandler = scheduler.scheduleGlobal(function()
      self:reConnect()
    end, 10)
    self:reConnect()
  end
  
  if showDialog then
    local child = display.getRunningScene():getChildByTag(NETWORK_WAITING_TAG)
    if child then
      display.getRunningScene():removeChildByTag(NETWORK_WAITING_TAG)
    end
    MDialog:single({
      text = "主厨，好像与次元小屋失去了联系，\n              请重新登录。",
      tag = NETWORK_TIPS_TAG,
      order = NETWORK_WAITING_ORDER - 1
    }, function()
      reCon()
    end)
  else
    reCon()
  end
end

function NetManager:showLoginFailTip(text)
  self:closeSocket()
  local child = display.getRunningScene():getChildByTag(NETWORK_WAITING_TAG)
  if child then
    display.getRunningScene():removeChildByTag(NETWORK_WAITING_TAG)
  end
  text = text or "当前选择的服务器已满，请尝试登陆其他服务器。"
  MDialog:single({
    text = text,
    tag = NETWORK_TIPS_TAG,
    order = NETWORK_WAITING_ORDER - 1
  }, function()
    game:enterScene("LoginScene")
  end)
end

function NetManager:reConnect()
  self.retryCount = self.retryCount + 1
  self:setTips(string.format("第%d次尝试重连...", self.retryCount))
  local result = self:login(true)
  if not result or self.retryCount >= 5 then
    if self.reConnectHandler then
      scheduler.unscheduleGlobal(self.reConnectHandler)
    end
    self:showConnectFailTip(true)
  end
end

function NetManager:setTips(tip)
  local content = display.getRunningScene():getChildByTag(NETWORK_WAITING_TAG)
  if not content then
    content = UIHelper.newMask({
      size = cc.size(display.width, display.height),
      color3B = cc.c3b(0, 0, 0),
      opacity = 51
    })
    content:addTo(display.getRunningScene(), NETWORK_WAITING_ORDER, NETWORK_WAITING_TAG)
    content:setTouchEnabled(true)
    content:setSwallowTouches(true)
    UIHelper.fitForiPhoneX(content)
    display.newSprite("ui/global/net_bg.png"):center(content):addTo(content)
    local res = UIHelper.loadAnimation("ui/global/", "waiting", 12, 12)
    res.sprite:pos(display.cx, display.cy + 25):addTo(content):runAction(cc.RepeatForever:create(cc.Animate:create(res.animation)))
    display.newTTFLabel({
      text = "",
      size = 20,
      color = display.COLOR_BLACK
    }):pos(display.cx + 21, display.cy - 69):addTo(content):name("tipLabel")
  end
  local tipLabel = content:getChildByName("tipLabel")
  if tipLabel then
    tipLabel:setString(tip)
  end
end

function NetManager:setTimeout(time, callback)
  self:clearTimeout()
  self.timeoutHandler = scheduler.performWithDelayGlobal(function()
    if callback then
      callback()
    end
    self:closeSocket(true)
    if not self.heartBeatHandler then
      self:showConnectFailTip(true)
    end
  end, time)
end

function NetManager:clearTimeout()
  if self.timeoutHandler then
    scheduler.unscheduleGlobal(self.timeoutHandler)
    self.timeoutHandler = nil
  end
end

function NetManager:clearHeartBeat()
  if self.heartBeatHandler then
    scheduler.unscheduleGlobal(self.heartBeatHandler)
    self.heartBeatHandler = nil
  end
end

return NetManager
