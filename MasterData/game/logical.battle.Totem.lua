local totemCsv = require("csvdata.tuteng")
local bulletDataSet = require("csvdata.bullet")
local Entity = import(".Entity")
local Totem = class("Totem", Entity)

function Totem:ctor(params)
  Totem.super.ctor(self, params)
  params = params or {}
  self.id = params.id
  self.csvData = totemCsv[self.id]
  self.xPos = params.xPos
  self.side = params.side
  self.releaser = params.releaser
  self.battle = self.releaser.battle
  self.bullet = bulletDataSet[self.csvData.bulletId]
  if self.csvData.resId ~= 0 then
    self.resBullet = bulletDataSet[self.csvData.resId]
  end
  self:initAttributes()
  if type(self["recordValue" .. self.csvData.type]) == "function" then
    self["recordValue" .. self.csvData.type](self)
  end
  self.range = self.csvData.range * BATTLE_GRID_PIXEL
  self.lastTargets = {}
  self:onBeginEffect()
end

function Totem:initAttributes()
  self.leftTime = self.csvData.keepTime == -1 and math.huge or self.csvData.keepTime
  self.detectUnit = 0
  self.effectValue = self.csvData.effectValue
  self.effectValue1 = self.csvData.effectValue2
end

function Totem:effect(dt)
  if self.leftTime <= 0 then
    self:dispose()
    return
  end
  local FRAME_MSEC = dt * 1000
  if 0 < self.detectUnit then
    self.leftTime = self.leftTime - FRAME_MSEC
    self.detectUnit = self.detectUnit - FRAME_MSEC
    return
  end
  self.detectUnit = self.csvData.unitTime
  if not self["effect" .. self.csvData.type] then
  else
    local targets, removedTargets = self:filterTargets()
    local effectTargets = self["effect" .. self.csvData.type](self, targets)
    self:onEffect(effectTargets or targets)
    self:onEndEffect(removedTargets)
    self.lastTargets = targets
  end
  self.leftTime = self.leftTime - FRAME_MSEC
  self.detectUnit = self.detectUnit - FRAME_MSEC
end

function Totem:isDone()
  return self.hasFinish
end

function Totem:recordValue1()
  self.recordValue = self.releaser.curAtk
end

function Totem:recordValue2()
  self.recordValue = self.releaser.curAtk
end

function Totem:recordValue9()
  self.recordValue = self.releaser.curAtk
  self.recordValue1 = self.releaser.atk
end

function Totem:recordValue10()
  self.recordValue = self.releaser.curAtk
  self.recordValue1 = self.releaser.atk
end

function Totem:recordValue11()
  self.recordValue = self.releaser.curAtk
  self.recordValue1 = self.releaser.atk
end

function Totem:filterTargets()
  local newTargets
  if self.csvData.target == 0 then
    newTargets = self.battle:rangeTeamers({
      xPos = self.xPos,
      side = self.side
    }, self.range)
  else
    newTargets = self.battle:rangeEnemys({
      xPos = self.xPos,
      otherSide = self.side == SIDE_LEFT and SIDE_RIGHT or SIDE_LEFT
    }, self.range)
  end
  local removedTargets = {}
  for _, last in ipairs(self.lastTargets) do
    local found = false
    for _, new in ipairs(newTargets) do
      if new == last then
        found = true
        break
      end
    end
    if not found then
      table.insert(removedTargets, last)
    end
  end
  return newTargets, removedTargets
end

function Totem:effect1(targets)
  local value = self.recordValue * self.effectValue / 100 + self.effectValue1
  printInfo("Totem:normal buffId-%s releaser-%s value-%s", self.id, self.releaser.unit.name, value)
  for _, target in ipairs(targets) do
    target:beingHurt({value = value, type = "normal"})
  end
end

function Totem:effect2(targets)
  local value = self.recordValue * self.effectValue / 100 + self.effectValue1
  printInfo("Totem:normal buffId-%s releaser-%s value-%s", self.id, self.releaser.unit.name, value)
  for _, target in ipairs(targets) do
    target:beingHurt({value = value, type = "normal"})
  end
end

function Totem:effect3(targets)
  for _, target in ipairs(targets) do
    local atk = math.floor(target.curAtk * self.effectValue / 100) + self.effectValue1
    printInfo("Totem:Atk+ buffId-%s target-%s releaser-%s value-%s", self.id, target.unit.name, self.releaser.unit.name, atk)
    target:changeAttribute({name = "Atk", value = atk})
  end
end

function Totem:effect4(targets)
  for _, target in ipairs(targets) do
    local atk = math.floor(target.curAtk * self.effectValue / 100) + self.effectValue1
    printInfo("Totem:Atk- buffId-%s target-%s releaser-%s value-%s", self.id, target.unit.name, self.releaser.unit.name, -atk)
    target:changeAttribute({
      name = "Atk",
      value = -atk
    })
  end
end

function Totem:effect5(targets)
  for _, target in ipairs(targets) do
    local phyDef = math.floor(target.curPhyDef * self.effectValue / 100) + self.effectValue1
    printInfo("Totem:phyDef+ buffId-%s target-%s releaser-%s value-%s", self.id, target.unit.name, self.releaser.unit.name, phyDef)
    target:changeAttribute({name = "PhyDef", value = phyDef})
  end
end

function Totem:effect6(targets)
  for _, target in ipairs(targets) do
    local phyDef = math.floor(target.curPhyDef * self.effectValue / 100) + self.effectValue1
    printInfo("Totem:phyDef- buffId-%s target-%s releaser-%s value-%s", self.id, target.unit.name, self.releaser.unit.name, -phyDef)
    target:changeAttribute({
      name = "PhyDef",
      value = -phyDef
    })
  end
end

function Totem:effect7(targets)
  for _, target in ipairs(targets) do
    local magDef = math.floor(target.curMagDef * self.effectValue / 100) + self.effectValue1
    printInfo("Totem:MagDef+ buffId-%s target-%s releaser-%s value-%s", self.id, target.unit.name, self.releaser.unit.name, magDef)
    target:changeAttribute({name = "MagDef", value = magDef})
  end
end

function Totem:effect8(targets)
  for _, target in ipairs(targets) do
    local magDef = math.floor(target.curMagDef * self.effectValue / 100) + self.effectValue1
    printInfo("Totem:MagDef- buffId-%s target-%s releaser-%s value-%s", self.id, target.unit.name, self.releaser.unit.name, -magDef)
    target:changeAttribute({
      name = "MagDef",
      value = -magDef
    })
  end
end

function Totem:dispose()
  self.hasFinish = true
  self:dispatchEvent({name = "totemOver"})
  self:onDispose()
end

function Totem:calHurt(target, hurtType)
  if target:hasBuff(33) then
    return 0
  end
  local immuneCases = {
    [9] = function(target)
      return target:hasBuff(31)
    end,
    [10] = function(target)
      return target:hasBuff(32)
    end
  }
  if immuneCases[hurtType] and immuneCases[hurtType](target) then
    return 0
  end
  local defences = {
    [9] = target.curPhyDef,
    [10] = target.curMagDef,
    [11] = 1
  }
  local hurtValue1 = self.recordValue * globalCsv.hurtFactor
  local hurtValue = hurtValue1 * self.recordValue * self.effectValue * 0.01 / math.max(hurtValue1, defences[hurtType])
  if target:hasBuff(55) then
    local effectValue = target.buffTypes[55][1]:effect()
    hurtValue = math.max(0, math.floor(hurtValue * (1 - effectValue / 100)))
  end
  return hurtValue
end

function Totem:effect9(targets)
  local effectTargets = {}
  for _, target in ipairs(targets) do
    local hurtValue = self:calHurt(target, 9)
    if 0 < hurtValue then
      target:beingHurt({value = hurtValue, type = "normal"})
      table.insert(effectTargets, target)
    end
  end
  return effectTargets
end

function Totem:effect10(targets)
  local effectTargets = {}
  for _, target in ipairs(targets) do
    local hurtValue = self:calHurt(target, 10)
    if 0 < hurtValue then
      target:beingHurt({value = hurtValue, type = "normal"})
      printInfo("Totem:normal buffId-%s target-%s releaser-%s value-%s", self.id, target.unit.name, self.releaser.unit.name, hurtValue)
      table.insert(effectTargets, target)
    end
  end
  return effectTargets
end

function Totem:effect11(targets)
  local effectTargets = {}
  for _, target in ipairs(targets) do
    local hurtValue = self:calHurt(target, 11)
    if 0 < hurtValue then
      target:beingHurt({value = hurtValue, type = "normal"})
      printInfo("Totem:normal buffId-%s target-%s releaser-%s value-%s", self.id, target.unit.name, self.releaser.unit.name, hurtValue)
      table.insert(effectTargets, target)
    end
  end
  return effectTargets
end

function Totem:effect12(targets)
  local buffs = self.csvData.effectBuff:toArray("=", true)
  for _, target in ipairs(targets) do
    for __, buff in ipairs(buffs) do
      target:addBuff({
        buffId = buff,
        releaser = self.releaser
      })
    end
  end
end

function Totem:onEffect(targets)
end

function Totem:onEndEffect(targets)
end

return Totem
