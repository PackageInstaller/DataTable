cc.FileUtils:getInstance():setPopupNotify(false)
cc.load("quick")
import(".GlobalVar")
require("common.init")
require("helper.init")
require("uicontrols.init")
require("ProtocolCode")
require("struct")
require("language.language")
require("network.ProtocolHandler")
require("app.views.global.init")
local channelConfigs = require("sdk.ChannelConfigs")
local musicCsv = require("csvdata.music")
local StoryCsv = require("csvdata.story")
GameState = require(cc.PACKAGE_NAME .. ".cc.utils.GameState")
bulletManager = import(".views.common.BulletManager"):new()
ResourceMgr = import(".views.common.ResourceMgr"):new()
NetManager = import(".views.common.NetManager"):new()
local audio = ccexp.AudioEngine
local XXTEA_KEY = "699D448D6D24f7F941E9F6E99F823E18"
local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
  MyApp.super.ctor(self)
  self.resourceCache = {}
  self:initUserDefault()
end

function MyApp:run()
  local sysCodesCsv = require("csvdata.sys_codes")
  for key, value in pairs(sysCodesCsv) do
    _G[string.trim(value.varname)] = key
  end
  
  function _G.memoryWarning()
    if ResourceMgr and not ResourceMgr.inLoading and not ResourceMgr.inBattle then
      sharedTextureCache:removeUnusedTextures()
    end
    collectgarbage("collect")
  end
  
  self:enterScene("LoginScene")
end

function MyApp:initUserDefault()
  GameState.init(function(param)
    local returnValue
    if param.errorCode then
    elseif param.name == "save" then
      local str = json.encode(param.values)
      str = crypto.encryptXXTEA(str, XXTEA_KEY)
      returnValue = {data = str}
    elseif param.name == "load" then
      local str = crypto.decryptXXTEA(param.values.data, XXTEA_KEY)
      returnValue = json.decode(str)
    end
    return returnValue
  end, "user.bin", XXTEA_KEY)
  _G.UserData = GameState.load()
  _G.UserData = _G.UserData or {
    music = 100,
    sound = 100,
    cv = 100,
    auto = 0
  }
end

function MyApp:setServerTime(serverTime)
  self.serverTime = serverTime
  self.startTime = os.time()
end

function MyApp:nowTime()
  return self.serverTime + (os.time() - self.startTime)
end

function MyApp:passTime()
  return os.time() - self.startTime
end

function MyApp:newSocket(host, port)
  return NetManager:newSocket(host, port)
end

function MyApp:sendData(actionCode, binaray, showMask, sender)
  return NetManager:sendData(actionCode, binaray, showMask, sender)
end

function MyApp:addResponseHandler(actionCode, callback)
  return NetManager:addResponseHandler(actionCode, callback)
end

function MyApp:onEnterBackground(event)
  audio:pauseAll()
  if self.videoHandler and not tolua.isnull(self.videoHandler) then
    self.videoHandler:pause()
  end
end

function MyApp:onEnterForeground(event)
  if NetManager.tcpSocket and NetManager.tcpSocket.isConnected then
    if self:sendData(actionCodes.Role_syncTimeRpc, "") then
      self:addResponseHandler(actionCodes.Role_syncTimeRpc, function(event)
        local msg = MsgPack.unpack(event.data)
        self:setServerTime(msg.nowTime)
      end)
    end
    NetManager:startHeartBeat()
  end
  audio:resumeAll()
  if self.videoHandler and not tolua.isnull(self.videoHandler) then
    self.videoHandler:resume()
  end
end

local musicHandlers = {
  [1] = {},
  [2] = {},
  [3] = {}
}
local musicUniqueId = -1

function MyApp:playMusic(id, onComplete, loop)
  if SKIP_MUSIC then
    return
  end
  local musicData = musicCsv[id]
  if not musicData then
    return
  end
  local musicRes = musicData.res
  local musicVolume = musicData.volume
  if musicData.id > 9500 and self.role and self.role.autoStatus and self.role.autoStatus:getv(11, 1) == 0 then
    musicRes = musicData.cnRes
    musicVolume = musicData.cnVolume
  end
  if musicRes == "" then
    return
  end
  local musicLoop = false
  local musicSkip = false
  local handler = -1
  local volumes = {
    UserData.music,
    UserData.sound,
    UserData.cv
  }
  if musicData.type == 1 then
    if id ~= musicUniqueId then
      for h, _ in pairs(musicHandlers[musicData.type]) do
        self:stopMusic(h)
      end
      musicHandlers[musicData.type] = {}
      musicUniqueId = id
    else
      musicSkip = true
    end
    musicLoop = musicData.loop == 1
  elseif musicData.type == 2 then
    musicLoop = musicData.loop == 1 or loop
  end
  if not musicSkip then
    local volume = musicVolume / 100 * volumes[musicData.type] / 100
    handler = audio:play2d(musicRes, musicLoop, volume)
  end
  if handler ~= -1 then
    musicHandlers[musicData.type][handler] = musicVolume
    audio:setFinishCallback(handler, function()
      musicHandlers[musicData.type][handler] = nil
      if onComplete then
        onComplete()
      end
    end)
    return handler
  end
end

function MyApp:setMusicVolume(type, volume)
  local handlers = musicHandlers[type]
  for _id, _volume in pairs(handlers) do
    audio:setVolume(_id, _volume / 100 * volume / 100)
  end
end

function MyApp:preloadMusic(id)
  local musicData = musicCsv[id]
  if not musicData or musicData.res == "" then
    return
  end
  audio:preload(musicData.res)
end

function MyApp:unloadMusic(id)
  local musicData = musicCsv[id]
  if not musicData or musicData.res == "" then
    return
  end
  audio:uncache(musicData.res)
end

function MyApp:stopMusic(handler)
  if handler and handler ~= -1 then
    audio:setLoop(handler, false)
    audio:stop(handler)
  end
end

return MyApp
