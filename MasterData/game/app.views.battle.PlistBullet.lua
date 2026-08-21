local spineActSet = require("csvdata.spine_act")

local function getMapZorder(zorder)
  return zorder == 0 and MAP_ABOVE_ORDER or MAP_UNDER_ORDER
end

local function getPlayerZorder(zorder)
  return zorder == 0 and DISPLAY_ABOVE_ORDER or DISPLAY_UNDER_ORDER
end

local PlistBullet = class("PlistBullet")

function PlistBullet:ctor(params)
  params = params or {}
  self.bullet = params.bullet
  self.csvData = self.bullet.csvData
  self.id = self.csvData.id
  self.hurtCsvData = self.bullet.hurtCsvData
  self.hurtBulletId = self.hurtCsvData.id
  self.bulletType = "plist"
  bulletManager:load(self.id)
  if self.hurtCsvData.spineAct == 0 then
    bulletManager:load(self.hurtBulletId)
  end
end

function PlistBullet:onBeginEffect()
  local skill = self.bullet.skill
  local player = skill.owner
  if self.csvData.bgColor ~= "" then
  end
  local beginTypes = {
    [3] = handler(self, self.onBegin3),
    [4] = handler(self, self.onBegin4),
    [5] = handler(self, self.onBegin5),
    [7] = handler(self, self.onBegin7)
  }
  if beginTypes[self.csvData.type] then
    beginTypes[self.csvData.type](dt)
  end
  game:playMusic(bulletManager:getMusicId(self.id, "begin"))
  local sprite = bulletManager:getFrameSprite(self.id, "begin")
  if not sprite then
    skill:addSelfBuff()
    return
  end
  sprite:flipX(skill.side == SIDE_RIGHT):pos(self.csvData.beginXOffset, self.csvData.beginYOffset + player.nodeSize.height / 2):addTo(player.displayNode)
  sprite:playAnimationOnce(bulletManager:getAnimation(self.id, "begin"), true)
  scheduler.performWithDelayGlobal(function()
    skill:addSelfBuff()
  end, bulletManager:getEventDelay(self.id, "begin"))
end

function PlistBullet:onHurt(target)
  local effectNode, zorder
  local xOffset = target.side == SIDE_RIGHT and -self.hurtCsvData.endXOffset or self.hurtCsvData.endXOffset
  if self.hurtCsvData.spineAct == 0 then
    effectNode = bulletManager:getFrameSprite(self.hurtBulletId, "end")
    if not effectNode then
      return
    end
    local blend = bulletManager:getBlend(self.hurtBulletId, "end")
    if blend then
      effectNode:setBlendFunc(blend)
    end
    zorder = bulletManager:getPlayerZorder(self.hurtBulletId, "end")
    effectNode:playAnimationOnce(bulletManager:getAnimation(self.hurtBulletId, "end"), true)
    game:playMusic(bulletManager:getMusicId(self.hurtBulletId, "end"))
    effectNode:flipX(self.hurtCsvData.type == 101 and target.side == SIDE_LEFT)
  else
    local actData = spineActSet[self.hurtCsvData.spineAct]
    game:playMusic(actData.soundId)
    zorder = getPlayerZorder(actData.zorder)
    effectNode = UIHelper.createSpineNode(actData.spineId)
    effectNode:setAnimation(0, "special", false)
    effectNode:registerSpineEventHandler(function(event)
      if event.type ~= "end" then
        return
      end
      scheduler.performWithDelayGlobal(function()
        effectNode:removeSelf()
      end, 0.016666666666666666)
    end, sp.EventType.ANIMATION_END)
    if self.hurtCsvData.type == 101 then
      local scaleX = target.side == SIDE_LEFT and -1 or 1
      effectNode:setScaleX(effectNode:getScaleX() * scaleX)
    end
  end
  if self.hurtCsvData.hurtLayer == 0 then
    effectNode:pos(xOffset, target.nodeSize.height / 2 + self.hurtCsvData.endYOffset)
    effectNode:addTo(target.displayNode, zorder)
  else
    effectNode:pos(target.position.x + xOffset, target.position.y + target.nodeSize.height / 2 + self.hurtCsvData.endYOffset)
    effectNode:addTo(target.map, target.zorder + (0 < zorder and 1 or -1))
  end
  if not self.shakeAction and 0 < self.csvData.shake then
    UIHelper.shake(self.bullet.skill.owner.mapLayers, {
      count = self.csvData.shake,
      x = 10,
      y = 10
    })
    self.shakeAction = true
  end
end

function PlistBullet:onDispose()
  if not tolua.isnull(self.sprite) then
    self.sprite:removeSelf()
  end
end

function PlistBullet:onUpdate1()
  local player = self.bullet.skill.owner
  local targets = self.bullet:getTargets()
  for index, target in ipairs(targets) do
    local sprite = bulletManager:getFrameSprite(self.id, "process")
    if not sprite then
      self.bullet:beginHurt(target, index ~= #targets)
    else
      local xOffset = target.side == SIDE_RIGHT and -self.csvData.processXOffset or self.csvData.processXOffset
      local zorder = bulletManager:getZorder(self.id, "process")
      sprite:pos(xOffset, target.nodeSize.height / 2 + self.csvData.processYOffset):addTo(target.displayNode, zorder):playAnimationOnce(bulletManager:getAnimation(self.id, "process"), true):flipX(player.side == SIDE_RIGHT)
      local blend = bulletManager:getBlend(self.id, "process")
      if blend then
        sprite:setBlendFunc(blend)
      end
      scheduler.performWithDelayGlobal(function()
        self.bullet:beginHurt(target, index ~= #targets)
      end, bulletManager:getEventDelay(self.id, "process"))
    end
  end
  game:playMusic(bulletManager:getMusicId(self.id, "process"))
end

function PlistBullet:onUpdate2()
  local player = self.bullet.skill.owner
  local targets = self.bullet:getTargets()
  local sprite = bulletManager:getFrameSprite(self.id, "process")
  if not sprite then
    for index, target in ipairs(targets) do
      self.bullet:beginHurt(target, index ~= #targets)
    end
  else
    local xPos = 0
    local order = 0
    for _, target in ipairs(targets) do
      xPos = xPos + target.xPos
      order = order + target.zorder
    end
    xPos = xPos / #targets
    order = order / #targets
    local zorder = bulletManager:getZorder(self.id, "process")
    if zorder == 2 then
      zorder = order
    else
      zorder = bulletManager:getMapZorder(self.id, "process")
    end
    local xOffset = player.side == SIDE_RIGHT and -self.csvData.processXOffset or self.csvData.processXOffset
    sprite:pos(xPos + xOffset, BATTLE_Y_POS + self.csvData.processYOffset):addTo(player.map, zorder):flipX(player.side == SIDE_RIGHT):playAnimationOnce(bulletManager:getAnimation(self.id, "process"), true)
    local blend = bulletManager:getBlend(self.id, "process")
    if blend then
      sprite:setBlendFunc(blend)
    end
    scheduler.performWithDelayGlobal(function()
      for index, target in ipairs(targets) do
        self.bullet:beginHurt(target, index ~= #targets)
      end
    end, bulletManager:getEventDelay(self.id, "process"))
  end
  game:playMusic(bulletManager:getMusicId(self.id, "process"))
end

function PlistBullet:onBegin3()
  local player = self.bullet.skill.owner
  self.sprite = bulletManager:getFrameSprite(self.id, "process")
  self.sprite:anch(player.side == SIDE_LEFT and 0 or 1, 0.5):pos(self.bullet.curPosX, self.bullet.curPosY + self.csvData.processYOffset + BATTLE_HURT_OFFSET):flipX(player.side == SIDE_RIGHT):addTo(player.map, bulletManager:getMapZorder(self.id, "process")):opacity(0):runAction(cc.FadeIn:create(0.1))
  self.sprite:playAnimationForever(bulletManager:getAnimation(self.id, "process"))
  local blend = bulletManager:getBlend(self.id, "process")
  if blend then
    self.sprite:setBlendFunc(blend)
  end
  game:playMusic(bulletManager:getMusicId(self.id, "process"))
end

function PlistBullet:onUpdate3()
  self.sprite:setPositionX(self.bullet.curPosX)
end

function PlistBullet:onBegin4()
  local player = self.bullet.skill.owner
  self.sprite = bulletManager:getFrameSprite(self.id, "process")
  self.sprite:anch(player.side == SIDE_LEFT and 0 or 1, 0.5):pos(self.bullet.curPosX, self.bullet.curPosY + self.csvData.processYOffset + BATTLE_HURT_OFFSET):flipX(player.side == SIDE_RIGHT):addTo(player.map, bulletManager:getMapZorder(self.id, "process")):opacity(0):runAction(cc.FadeIn:create(0.1))
  self.sprite:playAnimationForever(bulletManager:getAnimation(self.id, "process"))
  local blend = bulletManager:getBlend(self.id, "process")
  if blend then
    self.sprite:setBlendFunc(blend)
  end
  game:playMusic(bulletManager:getMusicId(self.id, "process"))
end

function PlistBullet:onUpdate4()
  self.sprite:setPositionX(self.bullet.curPosX)
end

function PlistBullet:onBegin5()
  local player = self.bullet.skill.owner
  self.sprite = bulletManager:getFrameSprite(self.id, "process")
  self.sprite:anch(player.side == SIDE_LEFT and 0 or 1, 0.5):pos(self.bullet.curPosX, self.bullet.curPosY):flipX(player.side == SIDE_RIGHT):addTo(player.map, bulletManager:getMapZorder(self.id, "process")):opacity(0):runAction(cc.FadeIn:create(0.1))
  self.sprite:playAnimationForever(bulletManager:getAnimation(self.id, "process"))
  local blend = bulletManager:getBlend(self.id, "process")
  if blend then
    self.sprite:setBlendFunc(blend)
  end
  game:playMusic(bulletManager:getMusicId(self.id, "process"))
end

function PlistBullet:onUpdate5()
  self.sprite:pos(self.bullet.curPosX, self.bullet.curPosY)
  self.sprite:rotation(self.bullet.curRotation)
end

function PlistBullet:onUpdate6()
  local player = self.bullet.skill.owner
  local targets = self.bullet:getTargets()
  for index, target in ipairs(targets) do
    local direction = player.side == SIDE_LEFT and 1 or -1
    local actions = {}
    local x1, y1 = player.displayNode:getPosition()
    x1 = x1 + self.csvData.beginXOffset * direction
    y1 = y1 + self.csvData.beginYOffset
    local x2, y2 = target.displayNode:getPosition()
    x2 = x2 + self.csvData.endXOffset * direction
    y2 = y2 + self.csvData.endYOffset
    local t = (y2 - y1) / math.abs(x2 - x1)
    local r = math.deg(math.atan(t))
    if x1 < x2 then
      r = 180 - r
    end
    local l = math.sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1))
    local sprite = bulletManager:getFrameSprite(self.id, "process")
    sprite:anch(1, 0.5):rotation(r):pos(self.csvData.processXOffset * direction, self.csvData.processYOffset):setScaleX(l / sprite:getTextureRect().width)
    sprite:addTo(player.displayNode, bulletManager:getPlayerZorder(self.id, "process"))
    sprite:playAnimationOnce(bulletManager:getAnimation(self.id, "process"), true)
    scheduler.performWithDelayGlobal(function()
      self.bullet:beginHurt(target, index ~= #targets)
    end, bulletManager:getEventDelay(self.id, "process"))
  end
  game:playMusic(bulletManager:getMusicId(self.id, "process"))
end

function PlistBullet:onBegin7()
  local player = self.bullet.skill.owner
  self.sprite = bulletManager:getFrameSprite(self.id, "process")
  self.sprite:anch(player.side == SIDE_LEFT and 0 or 1, 0.5):pos(self.bullet.curPosX, self.bullet.curPosY + self.csvData.processYOffset + BATTLE_HURT_OFFSET):flipX(player.side == SIDE_RIGHT):addTo(player.map, bulletManager:getMapZorder(self.id, "process")):opacity(0):runAction(cc.FadeIn:create(0.1))
  self.sprite:playAnimationForever(bulletManager:getAnimation(self.id, "process"))
  local blend = bulletManager:getBlend(self.id, "process")
  if blend then
    self.sprite:setBlendFunc(blend)
  end
  game:playMusic(bulletManager:getMusicId(self.id, "process"))
end

function PlistBullet:onUpdate7()
  self.sprite:pos(self.bullet.curPosX)
end

function PlistBullet:onUpdate8()
  local player = self.bullet.skill.owner
  local targets = self.bullet:getTargets()
  for index, target in ipairs(targets) do
    local sprite = bulletManager:getFrameSprite(self.id, "process")
    if not sprite then
      self.bullet:beginHurt(target, index ~= #targets)
    else
      local xOffset = target.side == SIDE_RIGHT and -self.csvData.processXOffset or self.csvData.processXOffset
      local zorder = bulletManager:getPlayerZorder(self.id, "process")
      sprite:pos(target.position.x + xOffset, target.position.y + self.csvData.processYOffset):addTo(target.map, target.zorder + (0 < zorder and 1 or -1)):flipX(player.side == SIDE_RIGHT):playAnimationOnce(bulletManager:getAnimation(self.id, "process"), true)
      local blend = bulletManager:getBlend(self.id, "process")
      if blend then
        sprite:setBlendFunc(blend)
      end
      scheduler.performWithDelayGlobal(function()
        self.bullet:beginHurt(target, index ~= #targets)
      end, bulletManager:getEventDelay(self.id, "process"))
    end
  end
  game:playMusic(bulletManager:getMusicId(self.id, "process"))
end

function PlistBullet:onUpdate9()
  local player = self.bullet.skill.owner
  local targets = self.bullet:getTargets()
  local sprite = bulletManager:getFrameSprite(self.id, "process")
  local xPos = display.cx
  local xOffset = player.side == SIDE_RIGHT and -self.csvData.processXOffset or self.csvData.processXOffset
  local sceneLayer = player.map:getChildByName("sceneSkillLayer")
  sprite:pos(xPos + xOffset, BATTLE_Y_POS + self.csvData.processYOffset):addTo(sceneLayer):flipX(player.side == SIDE_RIGHT):playAnimationOnce(bulletManager:getAnimation(self.id, "process"), true)
  local blend = bulletManager:getBlend(self.id, "process")
  if blend then
    sprite:setBlendFunc(blend)
  end
  scheduler.performWithDelayGlobal(function()
    for index, target in ipairs(targets) do
      self.bullet:beginHurt(target, index ~= #targets)
    end
  end, bulletManager:getEventDelay(self.id, "process"))
  game:playMusic(bulletManager:getMusicId(self.id, "process"))
end

function PlistBullet:onUpdate10()
  local player = self.bullet.skill.owner
  local targets = self.bullet:getTargets()
  local xPos
  if player.side == SIDE_LEFT then
    xPos = math.huge
  else
    xPos = -1
  end
  for index, target in ipairs(targets) do
    if player.side == SIDE_LEFT then
      if xPos > target.xPos then
        xPos = target.xPos
      end
    elseif xPos < target.xPos then
      xPos = target.xPos
    end
  end
  local xOffset = player.side == SIDE_RIGHT and -self.csvData.processXOffset or self.csvData.processXOffset
  local sprite = bulletManager:getFrameSprite(self.id, "process")
  sprite:pos(xPos + xOffset, BATTLE_Y_POS + self.csvData.processYOffset):addTo(player.map, zorder):flipX(player.side == SIDE_RIGHT):playAnimationOnce(bulletManager:getAnimation(self.id, "process"), true)
  local blend = bulletManager:getBlend(self.id, "process")
  if blend then
    sprite:setBlendFunc(blend)
  end
  scheduler.performWithDelayGlobal(function()
    for index, target in ipairs(targets) do
      self.bullet:beginHurt(target, index ~= #targets)
    end
  end, bulletManager:getEventDelay(self.id, "process"))
  game:playMusic(bulletManager:getMusicId(self.id, "process"))
end

function PlistBullet:onUpdate11()
  local player = self.bullet.skill.owner
  local targets = self.bullet:getTargets()
  local sprite = bulletManager:getFrameSprite(self.id, "process")
  local xPos = player.xPos
  local xOffset = player.side == SIDE_RIGHT and -self.csvData.processXOffset or self.csvData.processXOffset
  sprite:pos(xPos + xOffset, BATTLE_Y_POS + self.csvData.processYOffset):addTo(player.map, zorder):flipX(player.side == SIDE_RIGHT):playAnimationOnce(bulletManager:getAnimation(self.id, "process"), true)
  local blend = bulletManager:getBlend(self.id, "process")
  if blend then
    sprite:setBlendFunc(blend)
  end
  scheduler.performWithDelayGlobal(function()
    for index, target in ipairs(targets) do
      self.bullet:beginHurt(target, index ~= #targets)
    end
  end, bulletManager:getEventDelay(self.id, "process"))
  game:playMusic(bulletManager:getMusicId(self.id, "process"))
end

function PlistBullet:onUpdate12()
  local player = self.bullet.skill.owner
  
  local function changeHero()
    local changeSet = self.bullet.skill.csvData.changeBody:toArray("=", true)
    player:changeUnitType({
      action = "change",
      type = changeSet[1],
      liveTime = changeSet[2]
    })
    self.bullet.hasFinish = true
  end
  
  local sprite = bulletManager:getFrameSprite(self.id, "process")
  if not sprite then
    changeHero()
  else
    local xOffset = player.side == SIDE_RIGHT and -self.csvData.processXOffset or self.csvData.processXOffset
    local zorder = bulletManager:getZorder(self.id, "process")
    sprite:pos(xOffset, player.nodeSize.height / 2 + self.csvData.processYOffset):addTo(player.displayNode, zorder):flipX(player.side == SIDE_RIGHT):playAnimationOnce(bulletManager:getAnimation(self.id, "process"), true)
    local blend = bulletManager:getBlend(self.id, "process")
    if blend then
      sprite:setBlendFunc(blend)
    end
    scheduler.performWithDelayGlobal(function()
      changeHero()
    end, bulletManager:getEventDelay(self.id, "process"))
  end
  game:playMusic(bulletManager:getMusicId(self.id, "process"))
end

return PlistBullet
