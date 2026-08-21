collectgarbage("setpause", 100)
collectgarbage("setstepmul", 5000)
_G.accountServer = "http://cuisine.zhaolugame.com:7001"
_G.appreview = 25
local cjson = require("cjson")
local list_filename = "flist"
local fileUtils = cc.FileUtils:getInstance()
local sharedDirector = cc.Director:getInstance()
local sharedScheduler = sharedDirector:getScheduler()
local sharedApplication = cc.Application:getInstance()
local glview = sharedDirector:getOpenGLView()

local function urlencode(str)
  str = string.gsub(str, "\n", "\r\n")
  str = string.gsub(str, "([^%w ])", function(c)
    return string.format("%%%02X", string.byte(c))
  end)
  return str
end

local function versionValue(version)
  local ver1, ver2, ver3 = string.match(version, "%s*(%d+)%.(%d+)%.(%d+)%s*")
  return ver1 * 100000 + ver2 * 1000 + ver3
end

function __G__TRACKBACK__(msg)
  local message = msg
  local msg = debug.traceback(msg, 3)
  print(msg)
  return msg
end

local platformNames = {
  [0] = "windows",
  [1] = "linux",
  [2] = "mac",
  [3] = "android",
  [4] = "iphone",
  [5] = "ipad"
}
local ResolutionPolicy = {
  EXACT_FIT = 0,
  NO_BORDER = 1,
  SHOW_ALL = 2,
  FIXED_HEIGHT = 3,
  FIXED_WIDTH = 4,
  UNKNOWN = 5
}
CC_DESIGN_RESOLUTION = {
  width = 1136,
  height = 640,
  autoscale = "SHOW_ALL",
  callback = function(framesize)
    local ratio = framesize.width / framesize.height
    if ratio < 1.78 and 1.77 < ratio then
      return {
        autoscale = "FIXED_WIDTH"
      }
    end
    if framesize.width == 2436 and framesize.height == 1125 then
      return {
        autoscale = "FIXED_HEIGHT"
      }
    end
  end
}
if nil == glview then
  local width, height = 1136, 640
  if CC_DESIGN_RESOLUTION then
    if CC_DESIGN_RESOLUTION.width then
      width = CC_DESIGN_RESOLUTION.width
    end
    if CC_DESIGN_RESOLUTION.height then
      height = CC_DESIGN_RESOLUTION.height
    end
  end
  glview = cc.GLViewImpl:createWithRect("MIER", cc.rect(0, 0, width, height))
  sharedDirector:setOpenGLView(glview)
end
local framesize = glview:getFrameSize()

local function checkResolution(r)
  r.width = tonumber(r.width) or 0
  r.height = tonumber(r.height) or 0
  r.autoscale = string.upper(r.autoscale)
  assert(r.width > 0 and 0 < r.height, string.format("display - invalid design resolution size %d, %d", r.width, r.height))
end

local function setDesignResolution(r, framesize)
  if r.autoscale == "FILL_ALL" then
    glview:setDesignResolutionSize(framesize.width, framesize.height, ResolutionPolicy.FILL_ALL)
  else
    local scaleX, scaleY = framesize.width / r.width, framesize.height / r.height
    local width, height = framesize.width, framesize.height
    if r.autoscale == "FIXED_WIDTH" then
      width = framesize.width / scaleX
      height = framesize.height / scaleX
      glview:setDesignResolutionSize(width, height, ResolutionPolicy.NO_BORDER)
    elseif r.autoscale == "FIXED_HEIGHT" then
      width = framesize.width / scaleY
      height = framesize.height / scaleY
      glview:setDesignResolutionSize(width, height, ResolutionPolicy.NO_BORDER)
    elseif r.autoscale == "EXACT_FIT" then
      glview:setDesignResolutionSize(r.width, r.height, ResolutionPolicy.EXACT_FIT)
    elseif r.autoscale == "NO_BORDER" then
      glview:setDesignResolutionSize(r.width, r.height, ResolutionPolicy.NO_BORDER)
    elseif r.autoscale == "SHOW_ALL" then
      glview:setDesignResolutionSize(r.width, r.height, ResolutionPolicy.SHOW_ALL)
    else
      print(string.format("display - invalid r.autoscale \"%s\"", r.autoscale))
    end
  end
end

local function setAutoScale(configs)
  if type(configs) ~= "table" then
    return
  end
  checkResolution(configs)
  if type(configs.callback) == "function" then
    local c = configs.callback(framesize)
    for k, v in pairs(c or {}) do
      configs[k] = v
    end
    checkResolution(configs)
  end
  setDesignResolution(configs, framesize)
end

setAutoScale(CC_DESIGN_RESOLUTION)
local viewsize = sharedDirector:getWinSize()

local function class(classname, ...)
  local cls = {__cname = classname}
  local supers = {
    ...
  }
  for _, super in ipairs(supers) do
    local superType = type(super)
    assert(superType == "nil" or superType == "table" or superType == "function", string.format("class() - create class \"%s\" with invalid super class type \"%s\"", classname, superType))
    if superType == "function" then
      assert(cls.__create == nil, string.format("class() - create class \"%s\" with more than one creating function", classname))
      cls.__create = super
    elseif superType == "table" then
      if super[".isclass"] then
        assert(cls.__create == nil, string.format("class() - create class \"%s\" with more than one creating function or native class", classname))
        
        function cls.__create()
          return super:create()
        end
      else
        cls.__supers = cls.__supers or {}
        cls.__supers[#cls.__supers + 1] = super
        if not cls.super then
          cls.super = super
        end
      end
    else
      error(string.format("class() - create class \"%s\" with invalid super type", classname), 0)
    end
  end
  cls.__index = cls
  if not cls.__supers or #cls.__supers == 1 then
    setmetatable(cls, {
      __index = cls.super
    })
  else
    setmetatable(cls, {
      __index = function(_, key)
        local supers = cls.__supers
        for i = 1, #supers do
          local super = supers[i]
          if super[key] then
            return super[key]
          end
        end
      end
    })
  end
  if not cls.ctor then
    function cls.ctor()
    end
  end
  
  function cls.new(...)
    local instance
    if cls.__create then
      instance = cls.__create(...)
    else
      instance = {}
    end
    local setmetatableindex_
    
    function setmetatableindex_(t, index)
      if type(t) == "userdata" then
        local peer = tolua.getpeer(t)
        if not peer then
          peer = {}
          tolua.setpeer(t, peer)
        end
        setmetatableindex_(peer, index)
      else
        local mt = getmetatable(t)
        mt = mt or {}
        if not mt.__index then
          mt.__index = index
          setmetatable(t, mt)
        elseif mt.__index ~= index then
          setmetatableindex_(mt, index)
        end
      end
    end
    
    setmetatableindex_(instance, cls)
    instance.class = cls
    instance:ctor(...)
    return instance
  end
  
  function cls.create(_, ...)
    return cls.new(...)
  end
  
  return cls
end

local function writefile(path, content, mode)
  mode = mode or "w+b"
  local file = io.open(path, mode)
  if file then
    if file:write(content) == nil then
      return false
    end
    io.close(file)
    return true
  else
    return false
  end
end

local function checkFile(fileName, cryptoCode)
  if cryptoCode == nil then
    return true
  end
  if not fileUtils:isFileExist(fileName) then
    return false
  end
  local ms = cc.Crypto:MD5File(fileUtils:fullPathForFilename(fileName))
  if ms == cryptoCode then
    return true
  end
  print(string.format("%s md5 value expected %s, but %s", fileName, cryptoCode, ms))
  return false
end

local function checkDirOK(path)
  if fileUtils:isDirectoryExist(path) then
    return true
  end
  if fileUtils:createDirectory(path) then
    return true
  end
end

local function createButton(params)
  local button = ccui.Button:create()
  button:loadTextureNormal(params.files[1])
  if params.files[2] then
    button:loadTexturePressed(params.files[2])
  end
  if params.files[3] then
    button:loadTextureDisabled(params.files[3])
  end
  
  local function func(sender, type)
    if type == 2 and params.callback then
      params.callback(sender)
    end
  end
  
  local color = {
    r = 111,
    g = 73,
    b = 37
  }
  local fontSize = params.fontSize or params.size or 30
  button:setTitleFontSize(fontSize)
  button:setTitleColor(color)
  button:setTitleText(params.text)
  button:addTouchEventListener(func)
  return button
end

local function enterGame()
  if not SKIP_UPDATE then
    cc.LuaLoadChunksFromZIP("cocos.dat")
    cc.LuaLoadChunksFromZIP("game.dat")
  end
  require("config")
  require("cocos.init")
  _G.game = require("app.MyApp"):new()
  xpcall(function()
    game:run()
  end, __G__TRACKBACK__)
end

local UpdateScene = class("UpdateScene", function()
  return cc.Scene:create()
end)
local _updateScene

function UpdateScene:ctor()
  _updateScene = self
  self.rootPath = fileUtils:getWritablePath()
  self.processDone = false
  self.versionSame = false
  self.filesNeedUpdate = {}
  
  local function onNodeEvent(tag)
    if tag == "exit" then
      self:onExit()
    elseif tag == "enter" then
      self:onEnter()
    end
  end
  
  self:registerScriptHandler(onNodeEvent)
end

function UpdateScene:onEnter()
  self.rootNode = cc.CSLoader:createNode("ui/login/UpdateLayer.csb")
  self:parseUIData(self.rootNode)
  ccui.Helper:doLayout(self.rootNode)
  self.rootNode:setAnchorPoint({x = 0.5, y = 0.5})
  self.rootNode:setPosition({
    x = viewsize.width / 2,
    y = viewsize.height / 2
  })
  self:addChild(self.rootNode)
  if framesize.width == 2436 and framesize.height == 1125 or framesize.width == 1218 and framesize.height == 562 then
    local scale = CC_DESIGN_RESOLUTION.height / framesize.height * framesize.width / CC_DESIGN_RESOLUTION.width
    local scaleY = framesize.height / CC_DESIGN_RESOLUTION.height
    local offset = (framesize.height - CC_DESIGN_RESOLUTION.height * scale * scaleY) / 2
    self.rootNode:setScale(scale)
    self.rootNode:setPositionY(self.rootNode:getPositionY() - offset)
  end
  local firstCheckList = self.rootPath .. list_filename
  local platformName = platformNames[sharedApplication:getTargetPlatform()]
  local data = cc.HelperFunc:getFileData(list_filename)
  self.curList = assert(loadstring(data))()
  if fileUtils:isFileExist(firstCheckList) then
    local cacheList = dofile(firstCheckList)
    if versionValue(self.curList.ver) > versionValue(cacheList.ver) then
      if platformName == "android" then
        LuaJavaBridge.callStaticMethod("org.cocos2dx.utils.DataCleanManager", "cleanFiles", {}, "()V")
      elseif platformName == "iphone" or platformName == "ipad" then
        LuaObjcBridge.callStaticMethod("ChannelManager", "clearCaches", {})
      end
    else
      self.curList = cacheList
    end
  end
  self.version:setString("版本号: " .. self.curList.ver)
  self.gameTips:setString("请仔细阅读隐私权限")
  if _G.AndroidSecretShow then
    self:showAndroidSecret(function()
      self:AndroidRequestVersion()
    end)
  else
    self:requestVersion()
  end
end

function UpdateScene:showAndroidSecret(callback)
  local fileCheckName = self.rootPath .. "zhaolu_androidsecret.dat"
  if fileUtils:isFileExist(fileCheckName) then
    callback()
    return
  end
  self.androidSecretNode = cc.CSLoader:createNode("ui/global/SecretRuleLayer.csb")
  local widgets = {
    infoBg = "popAction/infoBg",
    cancelBtn = "popAction/infoBg/cancelBtn",
    okBtn = "popAction/infoBg/okBtn"
  }
  for name, path in pairs(widgets) do
    local control
    self.androidSecretNode:enumerateChildren("//" .. path, function(ret)
      control = ret
      return false
    end)
    self["secret" .. name] = control
  end
  ccui.Helper:doLayout(self.androidSecretNode)
  self.androidSecretNode:setAnchorPoint({x = 0.5, y = 0.5})
  self.androidSecretNode:setPosition({
    x = viewsize.width / 2,
    y = viewsize.height / 2
  })
  self:addChild(self.androidSecretNode)
  if framesize.width == 2436 and framesize.height == 1125 or framesize.width == 1218 and framesize.height == 562 then
    local scale = CC_DESIGN_RESOLUTION.height / framesize.height * framesize.width / CC_DESIGN_RESOLUTION.width
    local scaleY = framesize.height / CC_DESIGN_RESOLUTION.height
    local offset = (framesize.height - CC_DESIGN_RESOLUTION.height * scale * scaleY) / 2
    self.androidSecretNode:setScale(scale)
    self.androidSecretNode:setPositionY(self.androidSecretNode:getPositionY() - offset)
  end
  self.secretcancelBtn:addTouchEventListener(function(sender, type)
    if type == 2 then
      cc.UserDefault:getInstance():setBoolForKey("privacyCheck", false)
      sharedDirector:endToLua()
    end
  end)
  self.secretokBtn:addTouchEventListener(function(sender, type)
    if type == 2 then
      cc.UserDefault:getInstance():setBoolForKey("privacyCheck", true)
      self.androidSecretNode:setVisible(false)
      writefile(fileCheckName, "zhaoluGame")
      self:AndroidRequestVersion()
    end
  end)
end

function UpdateScene:AndroidRequestVersion()
  if not _G.AndroidPermissionFinished then
    self.gameTips:setString("正在申请权限...")
    AndroidPermissionFinish()
    return
  end
  self:requestVersion()
end

function AndroidPermissionFinish(parameter)
  _G.AndroidPermissionFinished = true
  xpcall(function()
    _updateScene:AndroidRequestVersion()
  end, __G__TRACKBACK__)
end

function UpdateScene:requestVersion()
  local curList = self.curList
  local platformName = platformNames[sharedApplication:getTargetPlatform()]
  local version_url = string.format(_G.accountServer .. "/version?platform=%s&version=%s&packagetype=%s&packcode=%s", platformName, curList.ver, urlencode(CHANNEL_NAME), _G.PACK_VERSION_CODE)
  if appreview then
    version_url = version_url .. "&appreview=" .. appreview
  end
  self.progressBar:setPercent(0)
  self.updateSlot:setVisible(false)
  self.gameTips:setString("正在获取最新版本号...")
  local requestVersion
  
  function requestVersion()
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = 0
    xhr:open("GET", version_url)
    xhr:registerScriptHandler(function()
      local errorCode = xhr.status
      if errorCode ~= 200 then
        local errorText = "错误码: " .. errorCode
        if errorCode == 0 then
          errorText = "游戏无法正常连接网络，检查后重试。"
        end
        self:createPopupDialog({
          content = errorText,
          leftText = "重试",
          leftCallback = function()
            requestVersion()
          end,
          rightText = "退出",
          rightCallback = function()
            sharedDirector:endToLua()
          end
        })
        return
      end
      local oldValue = versionValue(curList.ver)
      self.serverInfo = cjson.decode(xhr.response)
      if self.serverInfo.errorCode and self.serverInfo.errorCode ~= 0 then
        self:createPopupDialog({
          content = self.serverInfo.errorMsg,
          leftText = self.serverInfo.url and "下载" or "重试",
          leftCallback = function()
            if self.serverInfo.url then
              cc.Native:openURL(self.serverInfo.url)
            else
              requestVersion()
            end
          end,
          rightText = "退出",
          rightCallback = function()
            sharedDirector:endToLua()
          end
        })
        return
      end
      local newValue = versionValue(self.serverInfo.version)
      print("最新版本号: " .. self.serverInfo.version, oldValue, newValue)
      if oldValue >= newValue then
        self.versionSame = true
        enterGame()
      else
        self.oldListMap = {}
        for _, file in pairs(curList.stage or {}) do
          self.oldListMap[file.name] = file.code
        end
        self.requesting = list_filename
        self.dataRecv = nil
        self:requestFromServer(self.requesting)
        self:scheduleUpdateWithPriorityLua(function(dt)
          self:onEnterFrame(dt)
        end, 0)
      end
    end)
    xhr:send()
  end
  
  requestVersion()
end

function UpdateScene:createPopupDialog(params)
  local mask = cc.Layer:create()
  local eventDispatcher = mask:getEventDispatcher()
  local listenner = cc.EventListenerTouchOneByOne:create()
  listenner:setSwallowTouches(true)
  listenner:registerScriptHandler(function(touch, event)
    return true
  end, 40)
  eventDispatcher:addEventListenerWithSceneGraphPriority(listenner, mask)
  local dialogBg = ccui.Scale9Sprite:create({
    x = 20,
    y = 20,
    width = 64,
    height = 64
  }, "ui/global/dialog_small.png")
  dialogBg:setAnchorPoint({x = 0.5, y = 0.5})
  dialogBg:setPosition({
    x = viewsize.width / 2,
    y = viewsize.height / 2
  })
  dialogBg:setContentSize({width = 600, height = 250})
  mask:addChild(dialogBg)
  self:addChild(mask)
  local dialogSize = dialogBg:getContentSize()
  if params.content then
    local label = cc.Label:createWithSystemFont(params.content, "Arial", 24, {
      width = dialogSize.width - 80,
      height = 0
    }, 1, 2)
    label:setAnchorPoint({x = 0.5, y = 1})
    label:setPosition({
      x = dialogSize.width / 2,
      y = dialogSize.height - 80
    })
    label:setColor({
      r = 83,
      g = 44,
      b = 27,
      a = 255
    })
    dialogBg:addChild(label)
  end
  local leftBtn = createButton({
    text = params.leftText or "取消",
    files = {
      "ui/global/dialog_cancel.png",
      "ui/global/dialog_cancel.png"
    },
    callback = function()
      mask:removeFromParent(true)
      if params.leftCallback then
        params.leftCallback()
      end
    end
  })
  leftBtn:setAnchorPoint({x = 1, y = 0})
  leftBtn:setScale(0.8)
  leftBtn:setPosition({
    x = dialogSize.width / 2 - 60,
    y = 25
  })
  dialogBg:addChild(leftBtn)
  local rightBtn = createButton({
    text = params.rightText or "确定",
    files = {
      "ui/global/dialog_ok.png",
      "ui/global/dialog_ok.png"
    },
    callback = function()
      mask:removeFromParent(true)
      if params.rightCallback then
        params.rightCallback()
      end
    end
  })
  rightBtn:setAnchorPoint({x = 0, y = 0})
  rightBtn:setScale(0.8)
  rightBtn:setPosition({
    x = dialogSize.width / 2 + 60,
    y = 25
  })
  dialogBg:addChild(rightBtn)
  return dialogBg
end

function UpdateScene:parseUIData()
  local widgets = {
    gameTips = "center/gameTips",
    updateSlot = "center/update_slot",
    progressBar = "center/update_slot/progressBar",
    version = "version"
  }
  for name, path in pairs(widgets) do
    local control
    self.rootNode:enumerateChildren("//" .. path, function(ret)
      control = ret
      return false
    end)
    self[name] = control
  end
end

function UpdateScene:onExit()
  sharedDirector:purgeCachedData()
end

function UpdateScene:updateFiles()
  fileUtils:renameFile(self.rootPath, list_filename .. ".upd", list_filename)
  print("替换flist文件完成!")
  for _, updFile in ipairs(self.filesNeedUpdate) do
    fileUtils:renameFile(self.rootPath, updFile.name .. ".upd", updFile.name)
  end
  self.processDone = true
  self:endProcess()
end

function UpdateScene:reqNextFile()
  if self.updateFileNum >= #self.filesNeedUpdate then
    self:updateFiles()
    return
  end
  self.updateFileNum = self.updateFileNum + 1
  local newStageFile = self.filesNeedUpdate[self.updateFileNum]
  if self.oldListMap[newStageFile.name] == newStageFile.code then
    return self:reqNextFile()
  end
  local fn = self.rootPath .. newStageFile.name .. ".upd"
  if checkFile(fn, newStageFile.code) then
    return self:reqNextFile()
  end
  self:requestFromServer(newStageFile.name)
end

function UpdateScene:showUpdateInfo()
  local totalUpdateSize = 0
  for _, file in pairs(self.newList.stage) do
    if self.oldListMap[file.name] ~= file.code then
      print("update file " .. file.name)
      totalUpdateSize = totalUpdateSize + tonumber(file.size)
      table.insert(self.filesNeedUpdate, file)
    end
  end
  
  local function beginDownLoad()
    self.updateFileNum = 0
    self.requesting = "files"
    self:reqNextFile()
    self.gameTips:setString("开始下载文件列表")
    self.updateSlot:setVisible(true)
  end
  
  local dialogBg = self:createPopupDialog({
    leftCallback = function()
      sharedDirector:endToLua()
    end,
    rightCallback = function()
      local networkState = cc.Network:getInternetConnectionStatus()
      if networkState == cc.kCCNetworkStatusReachableViaWWAN then
        self:createPopupDialog({
          content = "当前处于2G/3G/4G网络，下载将消耗较多流量",
          leftText = "取消",
          leftCallback = function()
            self:showUpdateInfo()
          end,
          rightText = "下载",
          rightCallback = function()
            beginDownLoad()
          end
        })
        return
      end
      beginDownLoad()
    end
  })
  local dialogSize = dialogBg:getContentSize()
  local updateText = string.format("检测到新版本，更新资源包大小约 %d KB", math.floor(totalUpdateSize / 1000))
  local findUpdateText = cc.Label:createWithSystemFont(updateText, "Arial", 24, {
    width = dialogSize.width - 80,
    height = 0
  }, 1, 2)
  findUpdateText:setAnchorPoint({x = 0.5, y = 1})
  findUpdateText:setPosition({
    x = dialogSize.width / 2,
    y = dialogSize.height - 80
  })
  findUpdateText:setColor({
    r = 0,
    g = 0,
    b = 0,
    a = 255
  })
  dialogBg:addChild(findUpdateText)
end

function UpdateScene:onEnterFrame(dt)
  if not self.dataRecv then
    return
  end
  if self.requesting == list_filename then
    self.newListFilePath = self.rootPath .. list_filename .. ".upd"
    writefile(self.newListFilePath, self.dataRecv)
    if checkFile(self.newListFilePath, self.serverInfo.md5Version) then
      self.dataRecv = nil
      self.newList = dofile(self.newListFilePath)
      if self.newList == nil then
        print("配置更新文件flist打开错误!")
        self:endProcess()
        return
      end
    else
      self:createPopupDialog({
        content = "flist下载文件MD5错误",
        leftCallback = function()
          self:requestFromServer(self.requesting)
        end,
        rightCallback = function()
          sharedDirector:endToLua()
        end
      })
      return
    end
    print(string.format("客户端版本号 %s, 服务端版本号 %s", self.curList.ver, self.newList.ver))
    if self.newList.ver ~= self.curList.ver then
      self:showUpdateInfo()
      return
    end
    fileUtils:removeFile(self.newListFilePath)
    self.processDone = true
    self.versionSame = true
    self:endProcess()
  elseif self.requesting == "files" then
    local progress = self.updateFileNum * 100 / #self.filesNeedUpdate
    self.progressBar:setPercent(progress)
    self.gameTips:setString(string.format("开始下载文件列表 [%d/%d]", self.updateFileNum, #self.filesNeedUpdate))
    local newStageFile = self.filesNeedUpdate[self.updateFileNum]
    checkDirOK(self.rootPath .. string.match(newStageFile.name, "(.*/)"))
    local fn = self.rootPath .. newStageFile.name .. ".upd"
    writefile(fn, self.dataRecv)
    self.dataRecv = nil
    if checkFile(fn, newStageFile.code) then
      self:reqNextFile()
    else
      self:createPopupDialog({
        content = "下载文件MD5错误",
        leftCallback = function()
          self:requestFromServer(self.requestfn or self.requesting)
        end,
        rightCallback = function()
          sharedDirector:endToLua()
        end
      })
    end
  end
end

function UpdateScene:endProcess()
  fileUtils:removeFile(self.newListFilePath)
  if self.processDone and not self.versionSame then
    for _, file in ipairs(self.curList.remove) do
      fileUtils:removeFile(self.rootPath .. file.name)
    end
  end
  enterGame()
end

function UpdateScene:requestFromServer(filename)
  local url = string.gsub(self.serverInfo.updateUrl, "%%(%x%x)", function(hex)
    return string.char(tonumber(hex, 16))
  end)
  if not self.serverInfo.public then
    url = url .. filename
  else
    url = url .. "/" .. self.serverInfo.version .. "/" .. filename
  end
  self.requestfn = filename
  local xhr = cc.XMLHttpRequest:new()
  xhr.responseType = 0
  xhr:open("GET", url)
  xhr:registerScriptHandler(function()
    self:onResponse(xhr)
  end)
  xhr:send()
end

function UpdateScene:onResponse(request)
  if request.readyState ~= 4 then
    return
  end
  local errorCode = request.status
  if errorCode ~= 200 then
    if errorCode == 302 or errorCode == 301 then
      local xhr = cc.XMLHttpRequest:new()
      xhr.responseType = 0
      xhr:open("GET", request:getResponseHeader("Location"))
      xhr:registerScriptHandler(function()
        self:onResponse(xhr)
      end)
      xhr:send()
    else
      self:createPopupDialog({
        content = string.format("错误码 %d", errorCode),
        leftCallback = function()
          self:requestFromServer(self.requestfn or self.requesting)
        end,
        rightCallback = function()
          sharedDirector:endToLua()
        end
      })
    end
  else
    self.dataRecv = request.response
  end
end

function enterUpdate(parameter)
  local config = cjson.decode(parameter or "{}") or {}
  _G.CHANNEL_KEY = config.configKey or _G.CHANNEL_KEY
  _G.CHANNEL_NAME = config.channelName or _G.CHANNEL_NAME
  _G.AndroidSecretShow = config.AndroidSecretShow or false
  _G.CHANNEL_TAG = config.chennalTag or ""
  _G.PACK_VERSION_CODE = tonumber(config.versionCode) or 0
  if SKIP_UPDATE then
    enterGame()
  else
    xpcall(function()
      sharedDirector:runWithScene(UpdateScene.new())
    end, __G__TRACKBACK__)
  end
end
