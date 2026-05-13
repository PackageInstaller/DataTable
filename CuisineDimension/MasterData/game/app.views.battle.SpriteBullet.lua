local unitCsv = require("csvdata.unit")
local SpritePlayer = import(".SpritePlayer")
local TotemClass = import(".SpriteTotem")
local SpriteBullet = class("SpriteBullet", require("logical.battle.Bullet"))

local function filterDeadTarget(targets)
  local result = {}
  for _, target in ipairs(targets) do
    if target.type > 0 and target:getState() ~= "Dead" then
      result[#result + 1] = target
    end
  end
  return result
end

local function bulletInView(params)
  if params.side == SIDE_LEFT then
    return params.pos <= params.begin + display.width
  else
    return params.pos >= params.begin
  end
end

local function bulletZOrder(id, name)
  local value = bulletManager:getZorder(id, name)
  return value == 0 and EFFECT_ABOVE_ORDER or EFFECT_UNDER_ORDER
end

function SpriteBullet:ctor(params)
  params = params or {}
  SpriteBullet.super.ctor(self, params)
  bulletManager:load(self.id)
  bulletManager:load(self.skill.csvData.hurtBulletId)
end

function SpriteBullet:onBeginEffect()
  local skill = self.bullet.skill
  local player = skill.owner
  if self.csvData.bgColor ~= "" then
    display.newLayer(UIHelper.hex2rgba(self.csvData.bgColor)):size(player.map:getContentSize()):addTo(player.map, COLOR_BG_ORDER):runAction(transition.sequence({
      cc.DelayTime:create(1.5),
      cc.FadeOut:create(0.5),
      cc.RemoveSelf:create()
    }))
  end
  if self.csvData.shake > 0 then
    UIHelper.shake(self.skill.owner.mapLayers, {
      count = self.csvData.shake,
      x = 10,
      y = 10
    })
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

function SpriteBullet:onEffect1()
  local player = self.skill.owner
  local targets = self.skill:getAttackTargets()
  for index, enemy in ipairs(targets) do
    local ignoreEffect = false
    if enemy ~= self.skill.skillTarget then
      ignoreEffect = true
    end
    if bulletManager:getFrameCount(self.id, "end") > 0 then
      local sprite = bulletManager:getFrameSprite(self.id, "end")
      sprite:flipX(player.side == SIDE_RIGHT)
      if 0 < enemy.type then
        local value = bulletManager:getZorder(self.id, "end")
        sprite:pos(enemy.nodeSize.width / 2 + self.csvData.effectXOffset, enemy.nodeSize.height / 2 + self.csvData.effectYOffset):flipX(enemy.side == SIDE_RIGHT):addTo(enemy.displayNode, value == 0 and 1 or -1):playAnimationOnce(bulletManager:getAnimation(self.id, "end"), true)
      else
        sprite:pos(enemy.xPos + self.csvData.effectXOffset, 220 + self.csvData.effectYOffset):flipX(enemy.side == SIDE_RIGHT):addTo(player.map, bulletZOrder(self.id, "end")):playAnimationOnce(bulletManager:getAnimation(self.id, "end"), true)
      end
      scheduler.performWithDelayGlobal(function()
        self:hurtEffect(enemy, {
          last = index == #targets,
          ignoreEffect = ignoreEffect
        })
      end, bulletManager:getEventDelay(self.id, "end"))
    else
      self:hurtEffect(enemy, {
        last = index == #targets,
        ignoreEffect = ignoreEffect
      })
    end
  end
  self.skill:addBlocks(targets)
  game:playMusic(bulletManager:getMusicId(self.id, "end"))
end

function SpriteBullet:onEffect2(params)
  params = params or {}
  local player = self.skill.owner
  if params.begin then
    self.sprite = bulletManager:getFrameSprite(self.id, "progress")
    self.sprite:anch(player.side == SIDE_RIGHT and 0 or 1, 0.5):pos(self.curPositionX, self.csvData.keepYOffset + BATTLE_Y_POS + BATTLE_HURT_OFFSET):flipX(player.side == SIDE_RIGHT):addTo(player.map, bulletZOrder(self.id, "progress")):opacity(0):runAction(cc.FadeIn:create(0.1))
    self.sprite:playAnimationForever(bulletManager:getAnimation(self.id, "progress"))
    game:playMusic(bulletManager:getMusicId(self.id, "progress"))
    return
  end
  if params.finish then
    if 0 < bulletManager:getFrameCount(self.id, "end") then
      local sprite = bulletManager:getFrameSprite(self.id, "end")
      local actions = {}
      actions[#actions + 1] = cc.CallFunc:create(function()
        self.sprite:removeSelf()
      end)
      actions[#actions + 1] = cc.Animate:create(bulletManager:getAnimation(self.id, "end"))
      actions[#actions + 1] = cc.RemoveSelf:create()
      local middleXPos = 0
      for _, enemy in ipairs(params.targets) do
        middleXPos = middleXPos + enemy.xPos
      end
      sprite:anch(0.5, 0):pos(self.csvData.effectXOffset + middleXPos / #params.targets, self.csvData.effectYOffset + 100):flipX(player.side == SIDE_RIGHT):addTo(player.map, bulletZOrder(self.id, "end")):runAction(transition.sequence(actions))
      for _, enemy in ipairs(params.targets) do
        if 0 < enemy.type then
          scheduler.performWithDelayGlobal(function()
            self:hurtEffect(enemy, {
              last = index == #params.targets
            })
          end, bulletManager:getEventDelay(self.id, "end"))
        end
      end
    else
      for _, enemy in ipairs(params.targets) do
        if 0 < enemy.type then
          self:hurtEffect(enemy, {
            last = index == #params.targets
          })
        end
      end
      self.sprite:removeSelf()
    end
    return
  end
  local viewNodeXPos = math.abs(player.map:getParent():getPositionX())
  if not bulletInView({
    begin = viewNodeXPos,
    pos = self.curPositionX,
    side = player.side
  }) then
    self.hasFinish = true
    self.sprite:removeSelf()
    return true
  end
  self.sprite:pos(self.curPositionX, self.sprite:getPositionY())
  return
end

function SpriteBullet:onEffect3()
  local player = self.skill.owner
  local targets = self.skill:getAttackTargets()
  targets = filterDeadTarget(targets)
  for index, enemy in ipairs(targets) do
    local sprite = bulletManager:getFrameSprite(self.id, "progress")
    sprite:playAnimationForever(bulletManager:getAnimation(self.id, "progress"))
    local time = math.abs(player.xPos - enemy.xPos) / self.csvData.speed
    local parabolaToAction = UIHelper.createParabolaAction({
      time = time,
      height = 700,
      startPos = {
        x = player.displayNode:getPositionX() + self.csvData.keepXOffset,
        y = player.displayNode:getPositionY() + self.csvData.keepYOffset
      },
      endPos = {
        x = enemy.displayNode:getPositionX(),
        y = enemy.displayNode:getPositionY()
      }
    })
    local actions = {}
    actions[#actions + 1] = cc.Spawn:create({
      parabolaToAction,
      cc.RotateBy:create(time, player.side == SIDE_LEFT and 140 or -140)
    })
    actions[#actions + 1] = cc.RemoveSelf:create()
    actions[#actions + 1] = cc.CallFunc:create(function()
      self:hurtEffect(enemy, {
        last = index == #targets
      })
    end)
    sprite:flipX(player.side == SIDE_RIGHT):pos(player.xPos + self.csvData.keepXOffset, self.csvData.keepYOffset + BATTLE_Y_POS + BATTLE_HURT_OFFSET):rotate(player.side == SIDE_LEFT and -70 or 70):addTo(player.map, bulletZOrder(self.id, "progress")):runAction(transition.sequence(actions))
  end
  self.skill:addBlocks(targets)
  game:playMusic(bulletManager:getMusicId(self.id, "progress"))
end

function SpriteBullet:onEffect4(params)
  params = params or {}
  local player = self.skill.owner
  if params.begin then
    self.sprite = bulletManager:getFrameSprite(self.id, "progress")
    self.sprite:pos(player.xPos + self.csvData.keepXOffset, self.csvData.keepYOffset + BATTLE_Y_POS + BATTLE_HURT_OFFSET):flipX(player.side == SIDE_RIGHT):addTo(player.map, bulletZOrder(self.id, "progress")):opacity(0):runAction(cc.FadeIn:create(0.1))
    self.sprite:playAnimationForever(bulletManager:getAnimation(self.id, "progress"))
    game:playMusic(bulletManager:getMusicId(self.id, "progress"))
    return false
  end
  local viewNodeXPos = math.abs(player.map:getParent():getPositionX())
  if not bulletInView({
    begin = viewNodeXPos,
    pos = self.curPositionX,
    side = player.side
  }) then
    self.hasFinish = true
    self.sprite:removeSelf()
    return true
  end
  self.sprite:pos(self.curPositionX, self.csvData.keepYOffset + BATTLE_Y_POS + BATTLE_HURT_OFFSET)
  return false
end

function SpriteBullet:onEffect5()
end

function SpriteBullet:onEffect6()
  local player = self.skill.owner
  local targets = self.skill:getAttackTargets()
  local middleXPos = 0
  for _, enemy in ipairs(targets) do
    middleXPos = middleXPos + enemy.xPos
  end
  local effectXOffset = player.side == SIDE_LEFT and self.csvData.effectXOffset or -self.csvData.effectXOffset
  if self.csvData.spineId == 0 then
    if 0 < bulletManager:getFrameCount(self.id, "end") then
      local actions = {}
      local sprite = bulletManager:getFrameSprite(self.id, "end")
      actions[#actions + 1] = cc.Animate:create(bulletManager:getAnimation(self.id, "end"))
      actions[#actions + 1] = cc.RemoveSelf:create()
      sprite:anch(0.5, 0):pos(effectXOffset + middleXPos / #targets, self.csvData.effectYOffset + 100):flipX(player.side == SIDE_RIGHT):addTo(player.map, bulletZOrder(self.id, "end")):runAction(transition.sequence(actions))
    end
    scheduler.performWithDelayGlobal(function()
      for index, enemy in ipairs(targets) do
        self:hurtEffect(enemy, {
          last = index == #targets
        })
      end
    end, bulletManager:getEventDelay(self.id, "end"))
  else
    local effectNode = UIHelper.createSpineNode(self.csvData.spineId)
    effectNode:pos(effectXOffset + middleXPos / #targets, self.csvData.effectYOffset + BATTLE_Y_POS):addTo(player.map, bulletZOrder(self.id, "end"))
    effectNode:setScaleX((player.side == SIDE_RIGHT and -1 or 1) * effectNode:getScaleX())
    effectNode:setScaleY(effectNode:getScaleY())
    effectNode:setAnimation(0, "special", false)
    effectNode:registerSpineEventHandler(function(event)
      if event.type == "end" then
        scheduler.performWithDelayGlobal(function()
          effectNode:removeSelf()
        end, 0.016666666666666666)
      end
    end, sp.EventType.ANIMATION_END)
    effectNode:registerSpineEventHandler(function(event)
      if event.animation == "special" then
        for _, enemy in ipairs(targets) do
          self:hurtEffect(enemy, {
            last = index == #targets
          })
        end
      end
    end, sp.EventType.ANIMATION_EVENT)
  end
  self.skill:addBlocks(targets)
  game:playMusic(bulletManager:getMusicId(self.id, "end"))
end

function SpriteBullet:onEffect7()
  local player = self.skill.owner
  local targets = self.skill:getAttackTargets()
  local callHeroCsvData = string.split(string.trim(self.skill.csvData.callHero), "=")
  local skillOrders = string.split(string.trim(callHeroCsvData[5]), " ")
  local modifier = tonumber(callHeroCsvData[3]) / 100
  local heroUnit = unitCsv[tonumber(callHeroCsvData[2])]
  if player.calleeNum >= tonumber(callHeroCsvData[1]) then
    return
  end
  local calleeData = {
    type = heroUnit.type,
    index = self.skill.battle:nextPlayerIdx(player.side) + 6,
    liveTime = tonumber(callHeroCsvData[4]),
    level = player.level,
    side = player.side,
    fullHp = player.fullHp * modifier * heroUnit.hp / player.unit.hp,
    hp = player.hp * modifier * heroUnit.hp / player.unit.hp,
    atk = player.atk * modifier * heroUnit.atk / player.unit.atk,
    phyDef = player.phyDef * modifier * heroUnit.phyDef / player.unit.phyDef,
    magDef = player.magDef * modifier * heroUnit.magDef / player.unit.magDef,
    xPos = targets[1].xPos,
    caller = player,
    bornType = "callee",
    skillOrders = skillOrders
  }
  local actions = {}
  local sprite = bulletManager:getFrameSprite(self.id, "end")
  actions[#actions + 1] = cc.Animate:create(bulletManager:getAnimation(self.id, "end"))
  actions[#actions + 1] = cc.RemoveSelf:create()
  actions[#actions + 1] = cc.CallFunc:create(function()
    local callee = SpritePlayer:create(calleeData)
    callee.map = player.map
    callee.displayNode:pos(targets[1].xPos, BATTLE_Y_POS):addTo(player.map, LEFT_PLAYER_ORDER - calleeData.index)
    self.skill.battle:addCalleePlayer(callee)
    player.calleeNum = player.calleeNum + 1
    self.hasFinish = true
  end)
  sprite:pos(targets[1].xPos + self.csvData.effectXOffset, BATTLE_Y_POS + self.csvData.effectYOffset):flipX(player.side == SIDE_RIGHT):addTo(player.map, bulletZOrder(self.id, "end")):runAction(transition.sequence(actions))
end

function SpriteBullet:onEffect8()
  local player = self.skill.owner
  local changeHeroCsvData = string.split(string.trim(self.skill.csvData.changeBody), "=")
  local actions = {}
  local sprite = bulletManager:getFrameSprite(self.id, "begin")
  actions[#actions + 1] = cc.Animate:create(bulletManager:getAnimation(self.id, "begin"))
  actions[#actions + 1] = cc.RemoveSelf:create()
  actions[#actions + 1] = cc.CallFunc:create(function()
    if player:getState() == "Dead" then
      return
    end
    player:changeUnitType({
      action = "change",
      type = tonumber(changeHeroCsvData[1]),
      liveTime = tonumber(changeHeroCsvData[2])
    })
    self.hasFinish = true
  end)
  local value = bulletManager:getZorder(self.id, "begin")
  sprite:pos(player.nodeSize.width / 2 + self.csvData.effectXOffset, player.nodeSize.height / 2 + self.csvData.effectYOffset):flipX(player.side == SIDE_RIGHT):addTo(player.displayNode, value == 0 and 1 or -1):runAction(transition.sequence(actions))
end

function SpriteBullet:onEffect9()
  local player = self.skill.owner
  local targets = self.skill:getAttackTargets()
  if bulletManager:getFrameCount(self.id, "begin") > 0 then
    local sprite = bulletManager:getFrameSprite(self.id, "begin")
    sprite:playAnimationOnce(bulletManager:getAnimation(self.id, "begin"), true)
  end
  local effectNode
  if 0 < self.csvData.spineId then
    scheduler.performWithDelayGlobal(function()
      effectNode = UIHelper.createSpineNode(self.csvData.spineId)
      effectNode:pos(targets[1].xPos + self.csvData.effectXOffset, BATTLE_Y_POS + self.csvData.effectYOffset):addTo(player.map)
      effectNode:setScaleX((player.side == SIDE_RIGHT and -1 or 1) * effectNode:getScaleX())
      effectNode:setScaleY(effectNode:getScaleY())
      effectNode:setAnimation(0, "nvshen", true)
    end, bulletManager:getEventDelay(self.id, "begin") + 0.016666666666666666)
  else
    scheduler.performWithDelayGlobal(function()
      effectNode = bulletManager:getFrameSprite(self.id, "end")
      effectNode:pos(targets[1].xPos + self.csvData.effectXOffset, BATTLE_Y_POS + self.csvData.effectYOffset):flipX(player.side == SIDE_RIGHT):addTo(player.map, bulletZOrder(self.id, "end")):playAnimationForever(bulletManager:getAnimation(self.id, "end"))
    end, bulletManager:getEventDelay(self.id, "begin") + 0.016666666666666666)
  end
  scheduler.performWithDelayGlobal(function()
    local totem = TotemClass:create({
      id = self.skill.csvData.callTuteng,
      side = player.side,
      xPos = targets[1].xPos,
      releaser = player
    })
    totem:addEventListener("totemOver", function(event)
      self.hasFinish = true
      effectNode:removeSelf()
    end)
    self.skill:addTotem(totem)
  end, bulletManager:getEventDelay(self.id, "begin") + 0.016666666666666666)
end

function SpriteBullet:onEffect13()
  local player = self.skill.owner
  local targets = self.skill:getAttackTargets()
  if bulletManager:getFrameCount(self.id, "begin") > 0 then
    local sprite = bulletManager:getFrameSprite(self.id, "begin")
    sprite:playAnimationOnce(bulletManager:getAnimation(self.id, "begin"), true)
  end
  local effectNode
  if 0 < self.csvData.spineId then
    scheduler.performWithDelayGlobal(function()
      effectNode = UIHelper.createSpineNode(self.csvData.spineId)
      effectNode:pos(self.skill.skillTarget.xPos + self.csvData.effectXOffset, BATTLE_Y_POS + self.csvData.effectYOffset):addTo(player.map)
      effectNode:setScaleX((player.side == SIDE_RIGHT and -1 or 1) * effectNode:getScaleX())
      effectNode:setScaleY(effectNode:getScaleY())
      effectNode:setAnimation(0, "nvshen", true)
    end, bulletManager:getEventDelay(self.id, "begin") + 0.016666666666666666)
  else
    scheduler.performWithDelayGlobal(function()
      effectNode = bulletManager:getFrameSprite(self.id, "end")
      effectNode:pos(self.skill.skillTarget.xPos + self.csvData.effectXOffset, BATTLE_Y_POS + self.csvData.effectYOffset):flipX(player.side == SIDE_RIGHT):addTo(player.map, bulletZOrder(self.id, "end")):playAnimationForever(bulletManager:getAnimation(self.id, "end"))
    end, bulletManager:getEventDelay(self.id, "begin") + 0.016666666666666666)
  end
  scheduler.performWithDelayGlobal(function()
    local totem = TotemClass:create({
      id = self.skill.csvData.callTuteng,
      side = player.side,
      xPos = self.skill.skillTarget.xPos,
      releaser = player
    })
    totem:addEventListener("totemOver", function(event)
      self.hasFinish = true
      effectNode:removeSelf()
    end)
    self.skill:addTotem(totem)
  end, bulletManager:getEventDelay(self.id, "begin") + 0.016666666666666666)
end

function SpriteBullet:dispose()
  if not tolua.isnull(self.sprite) then
    self.sprite:removeSelf()
  end
end

return SpriteBullet
