local ResourceMgr = class("ResourceMgr")
ResourceMgr.SyncLoad = false
ResourceMgr.AsyncLoad = true
local fileUtils = cc.FileUtils:getInstance()
local textureCache = cc.Director:getInstance():getTextureCache()
local spriteFrameCache = cc.SpriteFrameCache:getInstance()

function ResourceMgr:ctor()
  self._isAsyncLoad = ResourceMgr.AsyncLoad
  self.inLoading = false
  self.spineNodes = {}
  self.images = {}
  self.plists = {}
  self.newSpineNames = {}
  self.newImages = {}
  self.newPlists = {}
  self.newBullets = {}
  self.newLWFDatas = {}
end

function ResourceMgr:setLoadType(loadType)
  self._isAsyncLoad = loadType
end

function ResourceMgr:getSpineTextureFiles(file)
  local textures = {}
  local dir = string.match(file, "(.*/).*")
  local content = fileUtils:getStringFromFile(file)
  for pngName in string.gmatch(content, "%c(%w-%.png)%c") do
    textures[#textures + 1] = dir .. pngName
  end
  return textures
end

function ResourceMgr:getTileMapTextureFiles(file)
  local textures = {}
  local dir = string.match(file, "(.*/).*")
  local content = fileUtils:getStringFromFile(file)
  for pngName in string.gmatch(content, "%ssource=\"(.-)\"%s") do
    textures[#textures + 1] = dir .. pngName
  end
  return textures
end

function ResourceMgr:addImages(images)
  self.newImages = self.newImages or {}
  for _, v in ipairs(images) do
    if cc.FileUtils:getInstance():isFileExist(v) then
      self.newImages[v] = true
    end
  end
end

function ResourceMgr:addSpineRes(spineNames)
  self.newImages = self.newImages or {}
  self.newSpineNames = self.newSpineNames or {}
  for _, name in ipairs(spineNames) do
    if not self.spineNodes[name] and fileUtils:isFileExist(name .. ".atlas") then
      local textures = self:getSpineTextureFiles(name .. ".atlas")
      for _, tfile in ipairs(textures) do
        self.newImages[tfile] = true
      end
      self.newSpineNames[name] = true
    end
  end
end

function ResourceMgr:addTileMaps(tileMaps, pixelFormat)
  pixelFormat = pixelFormat or cc.TEXTURE2D_PIXEL_FORMAT_RGBA8888
  self.newImages = self.newImages or {}
  for _, map in ipairs(tileMaps) do
    if fileUtils:isFileExist(map) then
      local textures = self:getTileMapTextureFiles(map)
      for _, tfile in ipairs(textures) do
        textureCache:setTexturePixelFormat(tfile, pixelFormat)
        self.newImages[tfile] = true
      end
    end
  end
end

function ResourceMgr:addPlists(plistFiles)
  self.newPlists = self.newPlists or {}
  for _, plist in ipairs(plistFiles) do
    if fileUtils:isFileExist(plist) then
      local textureFile = UIHelper.loadPlistTexture(plist)
      self.newImages[textureFile] = true
      self.newPlists[plist] = textureFile
    end
  end
end

function ResourceMgr:addBullets(bullets)
  self.newBullets = self.newBullets or {}
  for _, bulletId in ipairs(bullets) do
    self.newBullets[bulletId] = true
  end
end

function ResourceMgr:addLWFRes(lwfs)
end

function ResourceMgr:loadImagesAsync(cb)
  local imageCount = table.nums(self.newImages)
  if imageCount == 0 then
    cb()
    return
  end
  local sum = imageCount
  
  local function loadCount(texture)
    sum = sum - 1
    if sum == 0 then
      for name, _ in pairs(self.newImages) do
        self.images[name] = true
      end
      self.newImages = {}
      cb()
    end
  end
  
  for path, _ in pairs(self.newImages) do
    textureCache:addImageAsync(path, loadCount)
  end
end

function ResourceMgr:loadImages()
  for path, _ in pairs(self.newImages) do
    self.images[path] = true
    textureCache:addImage(path)
  end
  self.newImages = {}
end

function ResourceMgr:loadSpineNodes()
  self.spineNodes = self.spineNodes or {}
  for name, _ in pairs(self.newSpineNames) do
    if not self.spineNodes[name] then
      local spineNode = sp.SkeletonAnimation:create(name .. ".json", name .. ".atlas", 1)
      self.spineNodes[name] = spineNode
      self.spineNodes[name]:retain()
    end
  end
  self.newSpineNames = {}
end

function ResourceMgr:loadPlists()
  for name, texturePath in pairs(self.newPlists) do
    spriteFrameCache:addSpriteFrames(name, texturePath)
    self.plists[name] = texturePath
  end
  self.newPlists = {}
end

function ResourceMgr:loadBullets()
  for bulletId, _ in pairs(self.newBullets) do
    bulletManager:load(bulletId)
  end
  self.newBullets = {}
end

function ResourceMgr:loadLWFDatas()
  self.newLWFDatas = {}
end

function ResourceMgr:getSpineNode(name)
  if self.spineNodes[name] then
    return sp.SkeletonAnimation:createWithData(self.spineNodes[name])
  end
end

function ResourceMgr:existSpineNode(name)
  return self.spineNodes[name] ~= nil
end

function ResourceMgr:removeSpineNode(name)
end

function ResourceMgr:setListener(listener)
  self.listener = listener
end

function ResourceMgr:clearSpineNodes(spines)
  for _, spineName in ipairs(spines) do
    if self.spineNodes[spineName] then
      self.spineNodes[spineName]:release()
      self.spineNodes[spineName] = nil
    end
  end
end

function ResourceMgr:clearPlists(plists)
  for _, plist in ipairs(plists) do
    if self.plists[plist] then
      spriteFrameCache:removeSpriteFramesFromFile(plist)
      textureCache:removeTextureForKey(self.plists[plist])
    end
  end
end

function ResourceMgr:clearImages(images)
  for _, file in ipairs(images) do
    if self.images[file] then
      textureCache:removeTextureForKey(file)
      self.images[file] = nil
    end
  end
end

function ResourceMgr:load()
  sharedTextureCache:removeUnusedTextures()
  self.inLoading = true
  local interval = 0.016666666666666666
  scheduler.performWithDelayGlobal(function()
    if self._isAsyncLoad then
      local function onLoaded()
        self:loadSpineNodes()
        
        scheduler.performWithDelayGlobal(function()
          self:loadPlists()
          scheduler.performWithDelayGlobal(function()
            self:loadBullets()
            scheduler.performWithDelayGlobal(function()
              self:loadLWFDatas()
              if self.listener then
                self.listener()
              end
              self.inLoading = false
            end, interval)
          end, interval)
        end, interval)
      end
      
      self:loadImagesAsync(onLoaded)
    else
      self:loadImages()
      self:loadSpineNodes()
      self:loadPlists()
      self:loadBullets()
      self:loadLWFDatas()
      if self.listener then
        self.listener()
      end
      self.inLoading = false
    end
  end, interval)
end

function ResourceMgr:clear()
  for plist, _ in pairs(self.plists) do
    spriteFrameCache:removeSpriteFramesFromFile(plist)
  end
  for path, _ in pairs(self.images) do
  end
  for _, spineNode in pairs(self.spineNodes) do
    spineNode:release()
  end
  self.spineNodes = {}
  self.images = {}
  self.plists = {}
  bulletManager:dispose()
end

return ResourceMgr
