local spineActCsv = require("csvdata.spine_act")
local SpineBullet = class("SpineBullet")

local function getMapZorder(zorder)
  return zorder == 0 and MAP_ABOVE_ORDER or MAP_UNDER_ORDER
end

local function getPlayerZorder(zorder)
  return zorder == 0 and DISPLAY_ABOVE_ORDER or DISPLAY_UNDER_ORDER
end

function SpineBullet:ctor(params)
  params = params or {}
  self.bullet = params.bullet
  self.csvData = self.bullet.csvData
  self.id = self.csvData.id
  self.hurtCsvData = self.bullet.hurtCsvData
  self.hurtBulletId = self.hurtCsvData.id
  self.bulletType = "spine"
  self.actData = spineActCsv[self.csvData.spineAct]
  bulletManager:load(self.bullet.id)
  if self.hurtCsvData.spineAct == 0 then
    bulletManager:load(self.hurtBulletId)
  end
end

function SpineBullet:onBeginEffect()
  local skill = self.bullet.skill
  local player = skill.owner
  if self.csvData.bgColor ~= "" then
    local colorMask = display.newLayer(UIHelper.hex2rgba(self.csvData.bgColor))
    local maskSize = player.map:getContentSize()
    local posX = 0
    if UIHelper.isiPhoneX() then
      posX = posX - UIHelper.getMoveXForX()
    end
    colorMask:size(maskSize):pos(posX, 0):addTo(player.map, COLOR_BG_ORDER):runAction(transition.sequence({
      cc.DelayTime:create(1.5),
      cc.FadeOut:create(0.5),
      cc.RemoveSelf:create()
    }))
  end
  local beginTypes = {
    [3] = handler(self, self.onBegin3),
    [4] = handler(self, self.onBegin4),
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
  sprite:flipX(skill.side == SIDE_RIGHT):pos(beginXOffset, self.csvData.beginYOffset + player.nodeSize.height / 2):addTo(player.displayNode)
  sprite:playAnimationOnce(bulletManager:getAnimation(self.id, "begin"), true)
  scheduler.performWithDelayGlobal(function()
    self:addSelfBuff()
  end, bulletManager:getEventDelay(self.id, "begin"))
end

function SpineBullet:onHurt(target)
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
    game:playMusic(bulletManager:getMusicId(self.hurtBulletId, "end"))
    zorder = bulletManager:getPlayerZorder(self.hurtBulletId, "end")
    effectNode:playAnimationOnce(bulletManager:getAnimation(self.hurtBulletId, "end"), true)
    effectNode:flipX(self.hurtCsvData.type == 101 and target.side == SIDE_LEFT)
  else
    local actData = spineActCsv[self.hurtCsvData.spineAct]
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

function SpineBullet:onDispose()
  print(">>>>>>>>>SpineBullet:onDispose", self.id)
  if not tolua.isnull(self.spine) then
    self.spine:removeSelf()
  end
end

function SpineBullet:onUpdate1()
  local player = self.bullet.skill.owner
  local targets = self.bullet:getTargets()
  for index, target in ipairs(targets) do
    local effectNode = UIHelper.createSpineNode(self.actData.spineId)
    effectNode:setAnimation(0, "special", false)
    local xOffset = target.side == SIDE_RIGHT and -self.csvData.processXOffset or self.csvData.processXOffset
    effectNode:pos(xOffset, self.csvData.processYOffset):addTo(target.displayNode, getPlayerZorder(self.actData.zorder))
    effectNode:setScaleX((player.side == SIDE_RIGHT and -1 or 1) * effectNode:getScaleX())
    effectNode:registerSpineEventHandler(function(event)
      if event.type ~= "end" then
        return
      end
      scheduler.performWithDelayGlobal(function()
        effectNode:removeSelf()
      end, 0.016666666666666666)
    end, sp.EventType.ANIMATION_END)
    effectNode:registerSpineEventHandler(function(event)
      if event.animation ~= "special" then
        return
      end
      self.bullet:beginHurt(target, index ~= #targets)
    end, sp.EventType.ANIMATION_EVENT)
  end
  game:playMusic(self.actData.soundId)
end

function SpineBullet:onUpdate2()
  local player = self.bullet.skill.owner
  local targets = self.bullet:getTargets()
  local xPos = 0
  local order = 0
  if #targets == 0 then
    xPos = player.xPos + 200
  else
    for _, target in ipairs(targets) do
      xPos = xPos + target.xPos
      order = order + target.zorder
    end
    xPos = xPos / #targets
    order = order / #targets
  end
  if self.actData.zorder == 2 then
    zorder = order
  else
    zorder = getMapZorder(self.actData.zorder)
  end
  local effectNode = UIHelper.createSpineNode(self.actData.spineId)
  effectNode:setScaleX((player.side == SIDE_RIGHT and -1 or 1) * effectNode:getScaleX())
  effectNode:setAnimation(0, "special", false)
  local xOffset = player.side == SIDE_RIGHT and -self.csvData.processXOffset or self.csvData.processXOffset
  effectNode:pos(xPos + xOffset, BATTLE_Y_POS + self.csvData.processYOffset):addTo(player.map, zorder)
  effectNode:registerSpineEventHandler(function(event)
    if event.type ~= "end" then
      return
    end
    scheduler.performWithDelayGlobal(function()
      effectNode:removeSelf()
    end, 0.016666666666666666)
  end, sp.EventType.ANIMATION_END)
  effectNode:registerSpineEventHandler(function(event)
    if event.animation ~= "special" then
      return
    end
    for index, target in ipairs(targets) do
      self.bullet:beginHurt(target, index ~= #targets)
    end
  end, sp.EventType.ANIMATION_EVENT)
  game:playMusic(self.actData.soundId)
end

function SpineBullet:onBegin3()
  local player = self.bullet.skill.owner
  self.spine = UIHelper.createSpineNode(self.actData.spineId)
  self.spine:anch(player.side == SIDE_LEFT and 0 or 1, 0.5):pos(self.bullet.curPosX, self.csvData.processYOffset + BATTLE_Y_POS):addTo(player.map, getMapZorder(self.actData.zorder)):opacity(0):runAction(cc.FadeIn:create(0.1))
  self.spine:setScaleX((player.side == SIDE_RIGHT and -1 or 1) * self.spine:getScaleX())
  self.spine:setAnimation(0, "special", true)
  game:playMusic(self.actData.soundId)
end

function SpineBullet:onUpdate3()
  self.spine:setPositionX(self.bullet.curPosX)
end

function SpineBullet:onBegin4()
  local player = self.bullet.skill.owner
  self.spine = UIHelper.createSpineNode(self.actData.spineId)
  self.spine:anch(player.side == SIDE_LEFT and 0 or 1, 0.5):pos(self.bullet.curPosX, self.csvData.processYOffset + BATTLE_Y_POS):addTo(player.map, getMapZorder(self.actData.zorder)):opacity(0):runAction(cc.FadeIn:create(0.1))
  self.spine:setScaleX((player.side == SIDE_RIGHT and -1 or 1) * self.spine:getScaleX())
  self.spine:setAnimation(0, "special", true)
  game:playMusic(self.actData.soundId)
end

function SpineBullet:onUpdate4()
  self.spine:setPositionX(self.bullet.curPosX)
end

function SpineBullet:onUpdate5()
end

function SpineBullet:onUpdate6()
end

function SpineBullet:onBegin7()
  local player = self.bullet.skill.owner
  self.spine = UIHelper.createSpineNode(self.actData.spineId)
  self.spine:anch(player.side == SIDE_LEFT and 0 or 1, 0.5):pos(self.bullet.curPosX, self.csvData.processYOffset + BATTLE_Y_POS):addTo(player.map, getMapZorder(self.actData.zorder)):opacity(0):runAction(cc.FadeIn:create(0.1))
  self.spine:setScaleX((player.side == SIDE_RIGHT and -1 or 1) * self.spine:getScaleX())
  self.spine:setAnimation(0, "special", true)
  game:playMusic(self.actData.soundId)
end

function SpineBullet:onUpdate7()
end

function SpineBullet:onUpdate8()
  local player = self.bullet.skill.owner
  local targets = self.bullet:getTargets()
  for index, target in ipairs(targets) do
    local effectNode = UIHelper.createSpineNode(self.actData.spineId)
    effectNode:setAnimation(0, "special", false)
    local xOffset = target.side == SIDE_RIGHT and -self.csvData.processXOffset or self.csvData.processXOffset
    local zorder = getPlayerZorder(self.actData.zorder)
    effectNode:pos(target.position.x + xOffset, target.position.y + self.csvData.processYOffset):addTo(target.map, target.zorder + (0 < zorder and 1 or -1))
    effectNode:setScaleX((player.side == SIDE_RIGHT and -1 or 1) * effectNode:getScaleX())
    effectNode:registerSpineEventHandler(function(event)
      if event.type ~= "end" then
        return
      end
      scheduler.performWithDelayGlobal(function()
        effectNode:removeSelf()
      end, 0.016666666666666666)
    end, sp.EventType.ANIMATION_END)
    effectNode:registerSpineEventHandler(function(event)
      if event.animation ~= "special" then
        return
      end
      self.bullet:beginHurt(target, index ~= #targets)
    end, sp.EventType.ANIMATION_EVENT)
  end
  game:playMusic(self.actData.soundId)
end

function SpineBullet:onUpdate9()
  local player = self.bullet.skill.owner
  local xPos = display.cx
  local xOffset = player.side == SIDE_RIGHT and -self.csvData.processXOffset or self.csvData.processXOffset
  local sceneLayer = player.map:getChildByName("sceneSkillLayer")
  local effectNode = UIHelper.createSpineNode(self.actData.spineId)
  effectNode:pos(xPos + xOffset, self.csvData.processYOffset + BATTLE_Y_POS):addTo(sceneLayer)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(effectNode, true)
  end
  effectNode:setScaleX((player.side == SIDE_RIGHT and -1 or 1) * effectNode:getScaleX())
  effectNode:setAnimation(0, "special", false)
  effectNode:registerSpineEventHandler(function(event)
    if event.type ~= "end" then
      return
    end
    scheduler.performWithDelayGlobal(function()
      effectNode:removeSelf()
    end, 0.016666666666666666)
  end, sp.EventType.ANIMATION_END)
  effectNode:registerSpineEventHandler(function(event)
    if event.animation ~= "special" then
      return
    end
    local targets = self.bullet:getTargets()
    for index, target in ipairs(targets) do
      self.bullet:beginHurt(target, index ~= #targets)
    end
  end, sp.EventType.ANIMATION_EVENT)
  game:playMusic(self.actData.soundId)
end

function SpineBullet:onUpdate10()
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
  local effectNode = UIHelper.createSpineNode(self.actData.spineId)
  effectNode:pos(xPos + xOffset, self.csvData.processYOffset + BATTLE_Y_POS):addTo(player.map, getMapZorder(self.actData.zorder))
  effectNode:setScaleX((player.side == SIDE_RIGHT and -1 or 1) * effectNode:getScaleX())
  effectNode:setAnimation(0, "special", false)
  effectNode:registerSpineEventHandler(function(event)
    if event.type ~= "end" then
      return
    end
    scheduler.performWithDelayGlobal(function()
      effectNode:removeSelf()
    end, 0.016666666666666666)
  end, sp.EventType.ANIMATION_END)
  effectNode:registerSpineEventHandler(function(event)
    if event.animation ~= "special" then
      return
    end
    for index, target in ipairs(targets) do
      self.bullet:beginHurt(target, index ~= #targets)
    end
  end, sp.EventType.ANIMATION_EVENT)
  game:playMusic(self.actData.soundId)
end

function SpineBullet:onUpdate11()
  local player = self.bullet.skill.owner
  local xPos = player.xPos
  local xOffset = player.side == SIDE_RIGHT and -self.csvData.processXOffset or self.csvData.processXOffset
  local effectNode = UIHelper.createSpineNode(self.actData.spineId)
  effectNode:pos(xPos + xOffset, self.csvData.processYOffset + BATTLE_Y_POS):addTo(player.map, getMapZorder(self.actData.zorder))
  effectNode:setScaleX((player.side == SIDE_RIGHT and -1 or 1) * effectNode:getScaleX())
  effectNode:setAnimation(0, "special", false)
  effectNode:registerSpineEventHandler(function(event)
    if event.type ~= "end" then
      return
    end
    scheduler.performWithDelayGlobal(function()
      effectNode:removeSelf()
    end, 0.016666666666666666)
  end, sp.EventType.ANIMATION_END)
  effectNode:registerSpineEventHandler(function(event)
    if event.animation ~= "special" then
      return
    end
    local targets = self.bullet:getTargets()
    for index, target in ipairs(targets) do
      self.bullet:beginHurt(target, index ~= #targets)
    end
  end, sp.EventType.ANIMATION_EVENT)
  game:playMusic(self.actData.soundId)
end

return SpineBullet
