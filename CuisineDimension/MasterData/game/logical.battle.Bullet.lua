local bulletDataSet = require("csvdata.bullet")
local SpineBullet = require("app.views.battle.SpineBullet")
local PlistBullet = require("app.views.battle.PlistBullet")
local Entity = import(".Entity")
local Bullet = class("Bullet", Entity)

function Bullet:ctor(params)
  params = params or {}
  self.id = params.id
  self.skill = params.skill
  self.hurtParams = params.hurtParams
  self.hasEffectPlayers = {}
  self.display = nil
  self.hasFinish = false
  self.hasReached = false
  self.csvData = bulletDataSet[self.id]
  if not self.csvData then
    printError(">>>>>> bullet not found", self.id)
  end
  self.hurtCsvData = bulletDataSet[self.skill.csvData.hurtBulletId]
  self.moveDistance = self.csvData.speed
end

function Bullet:beginEffect()
  local beginTypes = {
    [3] = handler(self, self.beginEffect3),
    [4] = handler(self, self.beginEffect4),
    [5] = handler(self, self.beginEffect5),
    [7] = handler(self, self.beginEffect7)
  }
  if beginTypes[self.csvData.type] then
    beginTypes[self.csvData.type](dt)
  end
  local display
  if self.csvData.spineAct > 0 then
    display = SpineBullet.new({bullet = self})
  else
    display = PlistBullet.new({bullet = self})
  end
  self.display = display
  display:onBeginEffect()
end

function Bullet:endEffect()
  self.display:onEndEffect()
end

function Bullet:update(dt)
  if self.hasReached then
    return
  end
  local updateTypes = {
    [1] = handler(self, self.update1),
    [2] = handler(self, self.update2),
    [3] = handler(self, self.update3),
    [4] = handler(self, self.update4),
    [5] = handler(self, self.update5),
    [6] = handler(self, self.update6),
    [7] = handler(self, self.update7),
    [8] = handler(self, self.update8),
    [9] = handler(self, self.update9),
    [10] = handler(self, self.update10),
    [11] = handler(self, self.update11),
    [12] = handler(self, self.update12)
  }
  if updateTypes[self.csvData.type] then
    updateTypes[self.csvData.type](dt)
  end
end

function Bullet:isDone()
  return self.hasFinish
end

local skipHurt = {
  miss = true,
  immune = true,
  unbeatable = true
}

function Bullet:beginHurt(target, bProcess)
  local effectCount = 1
  local delay = 0
  if self.csvData.effectCount ~= "" then
    effectCount, delay = self.csvData.effectCount:match("(%d+)=(%d+)")
    effectCount, delay = tonumber(effectCount), tonumber(delay)
  end
  local hurtType = "normal"
  if effectCount == 1 and delay == 0 then
    self.hurtParams.hurtValue = target:getHurtValue(self.hurtParams, self.skill)
    hurtType = target:beginHurt(self.hurtParams, self.skill)
    self.display:onHurt(target)
    if not bProcess then
      self.hasFinish = true
    end
    self.skill:addTargetBuff(target)
  elseif effectCount == 1 and 0 < delay then
    scheduler.performWithDelayGlobal(function()
      if not target or target.hp <= 0 then
        target = self.skill:getSkillTarget()
      end
      if target.type ~= -1 then
        self.hurtParams.hurtValue = target:getHurtValue(self.hurtParams, self.skill)
        hurtType = target:beginHurt(self.hurtParams, self.skill)
        self.display:onHurt(target)
        if not bProcess then
          self.hasFinish = true
        end
        self.skill:addTargetBuff(target)
      end
    end, delay / 1000)
  else
    for index = 1, effectCount do
      scheduler.performWithDelayGlobal(function()
        self.hurtParams.hurtValue = target:getHurtValue(self.hurtParams, self.skill)
        hurtType = target:beginHurt(self.hurtParams, self.skill)
        self.display:onHurt(target)
        if not bProcess then
          self.hasFinish = self.hasFinish or index == effectCount
        end
      end, delay * (index - 1) / 1000)
    end
    self.skill:addTargetBuff(target)
  end
  if hurtType and skipHurt[hurtType] then
  else
    self.skill:hurtTarget(target)
  end
end

function Bullet:getTargets()
  return self.hurtParams.targets
end

function Bullet:update1(dt)
  self.hasReached = true
  self.display:onUpdate1()
end

function Bullet:update2(dt)
  self.hasReached = true
  self.display:onUpdate2()
end

function Bullet:beginEffect3()
  local player = self.skill.owner
  local beginXOffset = player.side == SIDE_LEFT and self.csvData.processXOffset or -self.csvData.processXOffset
  self.curPosX = player.position.x + beginXOffset
  self.curPosY = player.position.y
  self.beginPosX = self.curPosX
end

function Bullet:update3(dt)
  local player = self.skill.owner
  local moveDis = self.moveDistance * dt
  self.curPosX = self.curPosX + (self.skill.side == SIDE_LEFT and moveDis or -moveDis)
  self.display:onUpdate3(dt)
  local enemys = self.skill.battle:pointedPlayer({
    x = self.curPosX,
    side = player.otherSide
  }, moveDis)
  if #enemys == 0 then
    local moveLimit = 0 < self.csvData.movedis and self.csvData.movedis or display.width
    if moveLimit < math.abs(self.curPosX - self.beginPosX) then
      self.hasFinish = true
    end
  else
    self.hasReached = true
    self:beginHurt(enemys[1])
  end
end

function Bullet:beginEffect4()
  local player = self.skill.owner
  local beginXOffset = player.side == SIDE_LEFT and self.csvData.processXOffset or -self.csvData.processXOffset
  self.curPosX = player.position.x + beginXOffset
  self.curPosY = player.position.y
  self.beginPosX = self.curPosX
end

function Bullet:update4(dt)
  local player = self.skill.owner
  local moveDis = self.moveDistance * dt
  self.curPosX = self.curPosX + (self.skill.side == SIDE_LEFT and moveDis or -moveDis)
  local enemys = self.skill.battle:pointedPlayer({
    x = self.curPosX,
    side = player.otherSide
  }, moveDis)
  if 0 < #enemys then
    for _, enemy in ipairs(enemys) do
      if not self.hasEffectPlayers[enemy:getKey()] then
        self:beginHurt(enemy, true)
        self.hasEffectPlayers[enemy:getKey()] = true
      end
    end
  end
  self.display:onUpdate4(dt)
  local moveLimit = 0 < self.csvData.movedis and self.csvData.movedis or display.width
  if moveLimit < math.abs(self.curPosX - self.beginPosX) then
    self.hasFinish = true
  end
end

function Bullet:beginEffect5()
  local player = self.skill.owner
  local beginXOffset = player.side == SIDE_LEFT and self.csvData.processXOffset or -self.csvData.processXOffset
  local beginYOffset = self.csvData.processYOffset
  local target = self:getTargets()[1]
  local height = 200
  local x1, y1 = player.position.x + beginXOffset, player.position.y + beginYOffset
  local x3, y3 = target.position.x, target.position.y + beginYOffset + target.unit.hpBarHeight / 2
  height = math.min(math.abs(x1 - x3) / 4, height)
  local x2, y2 = x1 + (x3 - x1) / 2, y3 + height
  y2 = math.max(y2, (y1 + y3) / 2)
  local b = ((y1 - y3) * (x1 * x1 - x2 * x2) - (y1 - y2) * (x1 * x1 - x3 * x3)) / ((x1 - x3) * (x1 * x1 - x2 * x2) - (x1 - x2) * (x1 * x1 - x3 * x3))
  local a = (y1 - y2 - b * (x1 - x2)) / (x1 * x1 - x2 * x2)
  local c = y1 - a * x1 * x1 - b * x1
  self.keys = {
    a = a,
    b = b,
    c = c
  }
  self.curPosX = player.position.x
  self.curPosY = player.position.y
  self.targetX = target.position.x
  self.curRotation = 0
end

function Bullet:update5(dt)
  local moveDis = self.moveDistance * dt
  local x = self.curPosX + (self.skill.side == SIDE_LEFT and moveDis or -moveDis)
  self.curPosX = x
  self.curPosY = self.keys.a * x * x + self.keys.b * x + self.keys.c
  local sy = 2 * self.keys.a * x + self.keys.b
  self.curRotation = -math.deg(math.atan(sy))
  self.display:onUpdate5(dt)
  if self.skill.side == SIDE_LEFT and self.curPosX > self.targetX or self.skill.side == SIDE_RIGHT and self.curPosX < self.targetX then
    self.hasReached = true
    local targets = self:getTargets()
    for index, target in ipairs(targets) do
      self:beginHurt(target, index ~= #targets)
    end
  end
end

function Bullet:update6()
  self.hasReached = true
  self.display:onUpdate6()
end

function Bullet:beginEffect7()
  local player = self.skill.owner
  local beginXOffset = player.side == SIDE_LEFT and self.csvData.processXOffset or -self.csvData.processXOffset
  self.curPosX = player.xPos + beginXOffset
  self.beginPosX = self.curPosX
  self.direction = self.skill.side
  self.backMove = false
end

function Bullet:update7(dt)
  local player = self.skill.owner
  local moveDis = self.moveDistance * dt
  self.curPosX = self.curPosX + (self.direction == SIDE_LEFT and moveDis or -moveDis)
  local enemys = self.skill.battle:pointedPlayer({
    x = self.curPosX,
    side = player.otherSide
  }, moveDis)
  if 0 < #enemys then
    for _, enemy in ipairs(enemys) do
      if not self.hasEffectPlayers[enemy:getKey()] then
        self:beginHurt(enemy, true)
        self.hasEffectPlayers[enemy:getKey()] = true
      end
    end
  end
  self.display:onUpdate7(dt)
  local moveLimit = 0 < self.csvData.movedis and self.csvData.movedis or display.width
  if moveLimit < math.abs(self.curPosX - self.beginPosX) then
    if self.backMove then
      self.hasFinish = true
    else
      self.backMove = true
      self.beginPosX = self.curPosX
      self.direction = self.direction == SIDE_LEFT and SIDE_RIGHT or SIDE_LEFT
      self.hasEffectPlayers = {}
    end
  end
end

function Bullet:update8(dt)
  self.hasReached = true
  self.display:onUpdate8()
end

function Bullet:update9(dt)
  self.hasReached = true
  self.display:onUpdate9()
end

function Bullet:update10(dt)
  self.hasReached = true
  self.display:onUpdate10()
end

function Bullet:update11(dt)
  self.hasReached = true
  self.display:onUpdate11()
end

function Bullet:update12(dt)
  self.hasReached = true
  self.display:onUpdate12()
end

function Bullet:dispose()
  self.hasFinish = true
  if self.display then
    self.display:onDispose()
  end
end

return Bullet
