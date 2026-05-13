function string.startWith(str, strStart)
  local a, _ = string.find(str, strStart)
  
  return a == 1
end

function string.split(s, p)
  local rt = {}
  string.gsub(s, "[^" .. p .. "]+", function(w)
    table.insert(rt, w)
  end)
  return rt
end

local UpdateScene = class("UpdateScene", function()
  return display.newScene("UpdateScene")
end)
local NEEDUPDATE = true
local server = "http://服务器ip:3001/"
local versionFile = "version/?fileVersion="
local allFileList = "version/?id="
local nowVersion = CCUserDefault:sharedUserDefault():getStringForKey("current-version-code")
local bigVersion = CCUserDefault:sharedUserDefault():getStringForKey("VERSION_BIG")

function UpdateScene:ctor()
  display.newSprite("kfs_background.png", display.cx, display.cy):addTo(self)
  self.path = device.writablePath .. "kdfs/"
  self:createDownPath(self.path)
  self:createDownPath(self.path .. "res/")
  self:createDownPath(self.path .. "scripts/")
  if string.len(nowVersion) == 0 then
    nowVersion = bigVersion .. ".0"
  end
  local list = string.split(nowVersion, ".")
  self.nowId = tonumber(list[3])
  self.versionBig = list[1] .. "." .. list[2]
  if self.versionBig ~= bigVersion then
    self:delAllFilesInDirectory(self.path)
  end
  NEEDUPDATE = CCUserDefault:sharedUserDefault():getBoolForKey("CanUpdate")
  self.updateProgress = self:newProgressTimer("kfs_jindutiaobox.png", "kfs_jindutiao.png"):pos(display.cx, 120):addTo(self)
  self.progressLabel = ui.newTTFLabel({
    text = "更新",
    size = 26,
    align = ui.TEXT_ALIGN_CENTER,
    color = display.COLOR_BLACK
  }):pos(display.cx, 160):addTo(self)
end

function UpdateScene:downIndexedVersion()
  if not self.nowDownIndex then
    self.nowDownIndex = 1
  end
  local versionUrl = server .. versionFile .. self.needDownVersions[self.nowDownIndex].version .. "." .. self.needDownVersions[self.nowDownIndex].id
  local packageUrl = self.needDownVersions[self.nowDownIndex].fileUrl
  if self.nowDownIndex == 1 then
    self.assetsManager = AssetsManager:new(packageUrl, versionUrl, self.path)
    self.assetsManager:registerScriptHandler(handler(self, self.downHandler))
  else
    self.assetsManager:setVersionFileUrl(versionUrl)
    self.assetsManager:setPackageUrl(packageUrl)
  end
  if self.assetsManager:checkUpdate() then
    self.assetsManager:update()
  end
end

function UpdateScene:getNewestVersion()
  self.progressLabel:setString("正在获取版本列表")
  if not NEEDUPDATE then
    print("当前版本为DEBUG版本，不需要更新！")
    self.progressLabel:setString("当前版本为DEBUG版本，不需要更新")
    self:performWithDelay(function()
      self:noUpdateStart()
    end, 2)
    return
  end
  
  function callback(event)
    if event.name ~= "completed" then
      print("请求失败 " .. request:getErrorMessage())
      self.progressLabel:setString("版本更新列表请求网络出错")
      self:performWithDelay(function()
        self:noUpdateStart()
      end, 2)
      return
    end
    local request = event.request
    local code = request:getResponseStatusCode()
    if code ~= 200 then
      print("请求错误，代码 " .. request:getResponseStatusCode())
      self.progressLabel:setString("版本更新列表请求网络出错" .. request:getResponseStatusCode())
      self:performWithDelay(function()
        self:noUpdateStart()
      end, 2)
      return
    end
    if json.decode(request:getResponseString()) then
      print(request:getResponseString())
      local needDownVersions = json.decode(request:getResponseString())
      if needDownVersions.code == 200 then
        self.needDownVersions = needDownVersions.list
        for i, v in ipairs(self.needDownVersions) do
          if v.needRestart > 0 then
            self.needRestart = true
          end
        end
        if #self.needDownVersions > 0 then
          self:downIndexedVersion()
        end
      else
        self.progressLabel:setString("当前版本已经是最新版本")
        self.updateProgress.progressTimer:setPercentage(100)
        self:performWithDelay(function()
          self:noUpdateStart()
        end, 2)
      end
    end
  end
  
  local request = network.createHTTPRequest(callback, server .. allFileList .. self.nowId .. "&versionBig=" .. self.versionBig, "GET")
  request:setTimeout(10)
  request:start()
end

function UpdateScene:onEnter()
  self:getNewestVersion()
end

function UpdateScene:afterUpdateStart()
  if self.needRestart then
    print("提示需要重新启动游戏")
    require("game")
    game.exit()
    return
  end
  print("更新成功，启动游戏")
  package.loaded.config = nil
  require("gameEntry")
end

function UpdateScene:noUpdateStart()
  print("没有更新或者更新失败启动游戏")
  require("gameEntry")
end

function UpdateScene:downHandler(event)
  if event == "success" then
    if self.nowDownIndex < #self.needDownVersions then
      self.nowDownIndex = self.nowDownIndex + 1
      self:downIndexedVersion()
    else
      self.progressLabel:setString("更新成功")
      self:performWithDelay(function()
        self:afterUpdateStart()
      end, 2)
    end
  elseif string.startWith(event, "error") then
    local text = ""
    if event == "errorNetwork" then
      text = "网络出错！"
    end
    if event == "errorNoNewVersion" then
      self.updateProgress.progressTimer:setPercentage(100)
      text = "已是最新"
    end
    if event == "errorUncompress" then
      text = "解压出错"
    end
    if event == "errorUnknown" then
      text = "未知错误"
    end
    self.progressLabel:setString(text)
    self:performWithDelay(function()
      self:noUpdateStart()
    end, 2)
  else
    local alreadyDownPercent = (self.nowDownIndex - 1) * 100 / #self.needDownVersions
    print("alreadyDownPercent:", alreadyDownPercent)
    alreadyDownPercent = alreadyDownPercent + event / #self.needDownVersions
    alreadyDownPercent = math.floor(alreadyDownPercent)
    self.progressLabel:setString("已更新" .. alreadyDownPercent .. "%")
    self.updateProgress.progressTimer:setPercentage(alreadyDownPercent)
    self:progressTimerAction(self.updateProgress.progressTimer, self.updateProgress.progressTimer:getPercentage(), alreadyDownPercent)
  end
end

function UpdateScene:createDownPath(path)
  if not self:checkDirOK(path) then
    print("更新目录创建失败，直接开始游戏")
    self:noUpdateStart()
    return
  else
  end
end

function UpdateScene:checkDirOK(path)
  require("lfs")
  local oldpath = lfs.currentdir()
  if lfs.chdir(path) then
    lfs.chdir(oldpath)
    return true
  end
  if lfs.mkdir(path) then
    return true
  end
end

function UpdateScene:newProgressTimer(bgBarImg, progressBarImg)
  local bg = display.newSprite(bgBarImg)
  local progressTimer = CCProgressTimer:create(display.newSprite(progressBarImg))
  bg.progressTimer = progressTimer
  progressTimer:setType(kCCProgressTimerTypeBar)
  progressTimer:setPercentage(0)
  progressTimer:setMidpoint(ccp(0, 0))
  progressTimer:setBarChangeRate(ccp(1, 0))
  progressTimer:setPosition(ccp(bg:getContentSize().width / 2, bg:getContentSize().height / 2))
  bg:addChild(progressTimer, 140)
  return bg
end

function UpdateScene:progressTimerAction(progressTimer, fromPercentage, toPercentage, duration)
  duration = duration or 0.3
  local ac = CCProgressFromTo:create(duration, fromPercentage, toPercentage)
  progressTimer:runAction(ac)
end

function UpdateScene:delAllFilesInDirectory(path)
  for file in lfs.dir(path) do
    if file ~= "." and file ~= ".." then
      local f = path .. "/" .. file
      local attr = lfs.attributes(f)
      assert(type(attr) == "table")
      if attr.mode == "directory" then
        self:delAllFilesInDirectory(f)
      else
        os.remove(f)
      end
    end
  end
end

return UpdateScene
