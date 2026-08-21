local bulletDataSet = require("csvdata.bullet")
local NullBulletRes = "skillEff/null"
local BulletManager = class("BulletManager")
local BulletActionId = {
  begin = 1,
  process = 2,
  ["end"] = 3,
  hurt = 4
}
local Blends = {
  [1] = cc.blendFunc(gl.SRC_ALPHA, gl.ONE),
  [2] = cc.blendFunc(gl.ZERO, gl.SRC_COLOR),
  [3] = cc.blendFunc(gl.ONE_MINUS_SRC_COLOR, gl.ONE),
  [4] = cc.blendFunc(gl.ONE, gl.ONE)
}

function BulletManager:ctor()
  self.bulletRes = {}
  self.bullets = {}
  self.musicIds = {}
  self.cacheAnimations = {}
end

function BulletManager:cacheAnimation(name, animation)
  display.setAnimationCache(name, animation)
  self.cacheAnimations[name] = true
end

function BulletManager:load(id)
  local csvData = bulletDataSet[id]
  if not csvData then
    print(">>>>>>>>>>>没有找到子弹 id =", id)
  end
  if csvData.res == "" then
    return false
  end
  if self.bullets[id] then
    return true
  end
  self.bullets[id] = {}
  local bulletActionData = require(csvData.actCsv)
  self.bulletRes[csvData.res] = true
  local textureCache = cc.Director:getInstance():getTextureCache()
  if device.platform ~= "ios" then
    textureCache:setTexturePixelFormat(csvData.res .. ".pvr.ccz", cc.TEXTURE2D_PIXEL_FORMAT_RGBA8888)
  else
    textureCache:setTexturePixelFormat(csvData.res .. ".pvr.ccz", cc.TEXTURE2D_PIXEL_FORMAT_PVRTC4A)
  end
  display.addSpriteFrames(csvData.res .. ".plist", csvData.res .. ".pvr.ccz")
  
  local function initAnimationData(name, prefixName, bulletActionData)
    local animationName = csvData.id .. "_" .. name
    local animation = display.getAnimationCache(animationName)
    if not tolua.isnull(animation) then
      return
    end
    local frames = {}
    local actionData = bulletActionData[BulletActionId[name]]
    if actionData and actionData.fps > 0 then
      local frameIds = string.split(actionData.frameIDs, " ")
      for _, frameId in ipairs(frameIds) do
        local frameId = string.format("%02d", tonumber(frameId))
        frames[#frames + 1] = display.newSpriteFrame(prefixName .. "_" .. frameId .. ".png")
      end
      local animation = display.newAnimation(frames, 1 / actionData.fps)
      self.bullets[id][name] = {
        frames = frames,
        fps = actionData.fps,
        musicId = actionData.soundId,
        zorder = actionData.zorder,
        eventFrame = actionData.event,
        blend = actionData.blend
      }
      self:cacheAnimation(animationName, animation)
    end
  end
  
  local bulletPaths = string.split(csvData.res, "/")
  for name, value in pairs(BulletActionId) do
    initAnimationData(name, bulletPaths[#bulletPaths], bulletActionData)
  end
  return true
end

function BulletManager:getAnimation(id, name)
  local animation = display.getAnimationCache(id .. "_" .. name)
  return animation
end

function BulletManager:getFrameCount(id, name)
  if not self.bullets[id] then
    return 0
  end
  if not self.bullets[id][name] then
    return 0
  end
  return table.nums(self.bullets[id][name].frames)
end

function BulletManager:getFrame(id, name, index)
  index = index or 1
  if not self.bullets[id] then
    return nil
  end
  if not self.bullets[id][name] then
    return nil
  end
  return self.bullets[id][name].frames[index]
end

function BulletManager:getAnimationTime(id, name)
  if not self.bullets[id] then
    return 0
  end
  if not self.bullets[id][name] then
    return 0
  end
  return table.nums(self.bullets[id][name].frames) / self.bullets[id][name].fps
end

function BulletManager:getEventDelay(id, name)
  if not self.bullets[id] then
    return 0
  end
  if not self.bullets[id][name] then
    return 0
  end
  if self.bullets[id][name].fps == 0 then
    return 0
  end
  return self.bullets[id][name].eventFrame / self.bullets[id][name].fps
end

function BulletManager:getFrameSprite(id, name, index)
  index = index or 1
  if not self.bullets[id] then
    return nil
  end
  if not self.bullets[id][name] then
    return nil
  end
  local bulletData = bulletDataSet[id]
  local bulletSprite = display.newSprite(self.bullets[id][name].frames[index])
  bulletSprite:setScaleX(bulletData.xScale / 100)
  bulletSprite:setScaleY(bulletData.yScale / 100)
  return bulletSprite
end

function BulletManager:getMusicId(id, name)
  if not self.bullets[id] then
    return 0
  end
  if not self.bullets[id][name] then
    return 0
  end
  return self.bullets[id][name].musicId
end

function BulletManager:getZorder(id, name)
  if not self.bullets[id] then
    return 0
  end
  if not self.bullets[id][name] then
    return 0
  end
  return self.bullets[id][name].zorder
end

function BulletManager:getBlend(id, name)
  if not self.bullets[id] then
    return
  end
  if not self.bullets[id][name] then
    return
  end
  local blend = self.bullets[id][name].blend
  if blend == 0 then
    return
  end
  return Blends[blend]
end

function BulletManager:getMapZorder(id, name)
  local zorder = self:getZorder(id, name)
  return zorder == 0 and MAP_ABOVE_ORDER or MAP_UNDER_ORDER
end

function BulletManager:getPlayerZorder(id, name)
  local zorder = self:getZorder(id, name)
  return zorder == 0 and DISPLAY_ABOVE_ORDER or DISPLAY_UNDER_ORDER
end

function BulletManager:clearBullets(bulletIds)
  for _, bulletId in ipairs(bulletIds) do
    local csvData = bulletDataSet[bulletId]
    if self.bulletRes[csvData.res] and csvData.res ~= NullBulletRes then
      display.removeSpriteFramesWithFile(csvData.res .. ".plist", csvData.res .. ".pvr.ccz")
      self.bulletRes[csvData.res] = nil
      self.bullets[bulletId] = nil
    end
  end
end

function BulletManager:dispose()
  for name, _ in pairs(self.bulletRes) do
    display.removeSpriteFramesWithFile(name .. ".plist", name .. ".pvr.ccz")
  end
  for name in pairs(self.cacheAnimations) do
    display.removeAnimationCache(name)
  end
  for id, _ in pairs(self.musicIds) do
    game:unloadMusic(id)
  end
  self.bulletRes = {}
  self.bullets = {}
  self.cacheAnimations = {}
end

return BulletManager
