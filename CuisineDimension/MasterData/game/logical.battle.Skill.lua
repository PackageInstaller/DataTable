local skillDataSet = require("csvdata.skill")
local bulletDataSet = require("csvdata.bullet")
local Bullet = import(".Bullet")
local SpriteSkill = require("app.views.battle.SpriteSkill")
local Skill = class("Skill")

function Skill:ctor(params)
  self.battle = params.battle
  self.owner = params.owner
  self.side = self.owner.side
  self.id = params.id
  self.blockNum = params.blockNum or -1
  self.bulletIndex = params.bulletIndex or 1
  self.bullets = {}
  self.display = nil
  self.csvData = skillDataSet[self.id]
  if not self.csvData then
    printError(">>>>>> skill not found", self.id)
  end
  self.objectBuffs = {}
  self.passiveTarget = params.passiveTarget
  self.effectTargets = {}
  self.hasEffectCount = 0
  self.delayFinish = true
  self.hasDisposed = false
  self.eventFinish = not params.event
  self:resetSkillId(self.id)
end

function Skill:update(dt)
  local index = 1
  while index <= #self.bullets do
    local bullet = self.bullets[index]
    bullet:update(dt)
    if bullet:isDone() then
      bullet:dispose()
      table.remove(self.bullets, index)
    else
      index = index + 1
    end
  end
end

function Skill:effect(params)
  if self.csvData.randomBullet > 0 then
    self.bulletIndex = math.randomInt(1, self.csvData.randomBullet)
  end
  local bulletId = self.csvData["bulletId" .. self.bulletIndex]
  if not bulletId or bulletId <= 0 then
    return
  end
  self.bulletIndex = self.bulletIndex + 1
  local skillTarget, skillTargets
  if 0 < self.csvData.targetLock then
    if not self.skillTarget then
      skillTarget = self:getSkillTarget()
    end
    skillTargets = self:getSkillTargets()
  end
  self:createBullet(bulletId, skillTarget, skillTargets)
  if self.csvData.effectCount ~= "" then
    local count, delay = self.csvData.effectCount:match("(%d+)=(%d+)")
    count = tonumber(count) - 1
    delay = tonumber(delay) / 60
    if count == 0 and 0 < delay then
      scheduler.performWithDelayGlobal(function()
        if not tolua.isnull(self) and self:isDone() then
          return
        end
        self:createBullet(bulletId, skillTarget, skillTargets)
        self.delayFinish = true
      end, delay)
    else
      for index = 1, count do
        self.delayFinish = false
        scheduler.performWithDelayGlobal(function()
          if not tolua.isnull(self) and self:isDone() then
            return
          end
          self:createBullet(bulletId, skillTarget, skillTargets)
          if index == count then
            self.delayFinish = true
          end
        end, delay * index)
      end
    end
  end
  if self.csvData.specialId ~= "" then
    local skillId, level, rate = self.csvData.specialId:match("(%d)=(%d)=(%d)")
    if math.randomInt(1, 100) <= tonumber(rate) then
      self.owner:createSpecialSkill(false, tonumber(skillId), tonumber(level))
    end
  end
end

function Skill:createBullet(bulletId, skillTarget, skillTargets)
  self.skillTarget = skillTarget or self:getSkillTarget()
  self.skillTargets = skillTargets or self:getSkillTargets()
  local targets = self:getAttackTargets()
  if self.owner:hasBuff(153) then
    local forceTargets = self.owner:checkCharm(targets)
    if #forceTargets ~= 0 then
      targets = forceTargets
    end
  end
  if self.owner:hasBuff(152) then
    local forceTargets = self.owner:checkConfusion(targets)
    if #forceTargets ~= 0 then
      targets = forceTargets
    end
  elseif self.owner:hasBuff(24) and not self.owner:isSpecial(self.id) then
    local forceTargets = self.owner:checkTaunt()
    if #forceTargets ~= 0 then
      targets = forceTargets
    end
  end
  if #targets == 0 then
    return
  end
  if 0 < self.csvData.effectLimit then
    for _, target in ipairs(targets) do
      if target.type ~= -1 then
        if not self.effectTargets[target.id] then
          self.effectTargets[target.id] = 1
        else
          self.effectTargets[target.id] = self.effectTargets[target.id] + 1
        end
      end
    end
  end
  
  local function bulletEffect(targets)
    local hurtParams = {
      skillId = self.id,
      sumHurt = self.csvData.sumHurt > 0,
      curAtk = self.owner.curAtk,
      curCrit = self.owner.curCrit,
      curMiss = self.owner.curMiss,
      curCritHurt = self.owner.curCritHurt,
      curHit = self.owner.curHit,
      releaser = self.owner,
      targets = targets
    }
    local bullet = Bullet:create({
      id = bulletId,
      skill = self,
      hurtParams = hurtParams
    })
    bullet:beginEffect()
    table.insert(self.bullets, bullet)
    self:releaseAttachSkill()
  end
  
  local bulletData = bulletDataSet[bulletId]
  if bulletData.type == 5 then
    for _, target in ipairs(targets) do
      bulletEffect({target})
    end
  else
    bulletEffect(targets)
  end
end

function Skill:beginEffect()
  local display = SpriteSkill:create({skill = self})
  self.display = display
  self:effect()
end

function Skill:isDone()
  return #self.bullets == 0 and self.delayFinish and self.eventFinish
end

function Skill:eventEnd()
  self.eventFinish = true
end

function Skill:getSkillTarget()
  local player = self.owner
  local effectTypeFuncs = {
    [1] = function(_targets)
      return _targets[1]
    end,
    [2] = function(_targets)
      table.sort(_targets, function(tA, tB)
        local disA = self.battle:distance(player, tA)
        local disB = self.battle:distance(player, tB)
        return disA < disB
      end)
      return _targets[1]
    end,
    [3] = function(_targets)
      table.sort(_targets, function(tA, tB)
        local disA = self.battle:distance(player, tA)
        local disB = self.battle:distance(player, tB)
        return disA > disB
      end)
      return _targets[1]
    end,
    [4] = function(_targets)
      return player
    end,
    [5] = function(_targets)
      local index = math.randomInt(1, #_targets)
      return _targets[index]
    end,
    [6] = function(_targets)
      table.sort(_targets, function(tA, tB)
        local disA = self.battle:distance(player, tA)
        local disB = self.battle:distance(player, tB)
        return disA < disB
      end)
      local rand = {}
      for _, _target in ipairs(_targets) do
        if math.abs(_target.xPos - _targets[1].xPos) <= 1 then
          table.insert(rand, _target)
        end
      end
      return rand[math.randomInt(1, #rand)]
    end,
    [7] = function(_targets)
      table.sort(_targets, function(tA, tB)
        local disA = self.battle:distance(player, tA)
        local disB = self.battle:distance(player, tB)
        return disA > disB
      end)
      local rand = {}
      for _, _target in ipairs(_targets) do
        if math.abs(_target.xPos - _targets[1].xPos) <= 1 then
          table.insert(rand, _target)
        end
      end
      return rand[math.randomInt(1, #rand)]
    end,
    [11] = function(_targets)
      for _, _target in ipairs(_targets) do
        if _target.unit.profession == 1 or _target.unit.profession == 2 then
          return _target
        end
      end
      return player
    end,
    [12] = function(_targets)
      for _, _target in ipairs(_targets) do
        if _target.unit.profession == 6 or _target.unit.profession == 5 then
          return _target
        end
      end
      for _, _target in ipairs(_targets) do
        if _target.unit.profession == 4 or _target.unit.profession == 3 then
          return _target
        end
      end
      for _, _target in ipairs(_targets) do
        if _target.unit.profession == 2 or _target.unit.profession == 1 then
          return _target
        end
      end
    end,
    [13] = function(_targets)
      return player
    end,
    [14] = function(_targets)
      for _, _target in ipairs(_targets) do
        if _target.unit.profession == 1 or _target.unit.profession == 2 then
          return _target
        end
      end
      for _, _target in ipairs(_targets) do
        if _target.unit.profession == 3 or _target.unit.profession == 4 then
          return _target
        end
      end
      for _, _target in ipairs(_targets) do
        if _target.unit.profession == 5 or _target.unit.profession == 6 then
          return _target
        end
      end
    end,
    [15] = function(_targets)
      table.sort(_targets, function(tA, tB)
        local disA = self.battle:distance(player, tA)
        local disB = self.battle:distance(player, tB)
        return disA > disB
      end)
      local rand = {}
      for _, _target in ipairs(_targets) do
        if math.abs(_target.xPos - _targets[1].xPos) <= 100 then
          table.insert(rand, _target)
        end
      end
      return rand[math.randomInt(1, #rand)]
    end,
    [16] = function(_targets)
      for _, _target in ipairs(_targets) do
        if _target.unit.profession == 4 then
          return _target
        end
      end
      for _, _target in ipairs(_targets) do
        if _target.unit.profession == 3 then
          return _target
        end
      end
      return player
    end,
    [17] = function(_targets)
      for _, _target in ipairs(_targets) do
        if _target.unit.profession == 3 or _target.unit.profession == 4 then
          return _target
        end
      end
      for _, _target in ipairs(_targets) do
        if _target.unit.profession == 1 or _target.unit.profession == 2 then
          return _target
        end
      end
      for _, _target in ipairs(_targets) do
        if _target.unit.profession == 5 or _target.unit.profession == 6 then
          return _target
        end
      end
    end,
    [18] = function(_targets)
      for _, _target in ipairs(_targets) do
        if _target.unit.profession == 2 then
          return _target
        end
      end
      return player
    end,
    [19] = function(_targets)
      table.sort(_targets, function(tA, tB)
        return tA.xPos < tB.xPos
      end)
      local target = _targets[1].side == SIDE_LEFT and _targets[#_targets] or _targets[1]
      return target
    end,
    [20] = function(_targets)
      table.sort(_targets, function(tA, tB)
        return tB.hp < tA.hp
      end)
      local target = _targets[1]
      return target
    end,
    [21] = function(_targets)
      table.sort(_targets, function(tA, tB)
        return tB.hp > tA.hp
      end)
      local target = _targets[1]
      return target
    end,
    [22] = function(_targets)
      local chooseTargets = {}
      local proIds = {
        [1] = {1, 2},
        [2] = {3, 4},
        [3] = {5, 6}
      }
      for _, proId in ipairs(proIds) do
        for _, _target in ipairs(_targets) do
          if _target.unit.profession == proId[1] or _target.unit.profession == proId[2] then
            table.insert(chooseTargets, _target)
          end
        end
        if 0 < #chooseTargets then
          break
        end
      end
      table.sort(chooseTargets, function(tA, tB)
        return tB.hp < tA.hp
      end)
      local target = chooseTargets[1]
      return target
    end,
    [23] = function(_targets)
      local chooseTargets = {}
      local proIds = {
        [1] = {3, 4},
        [2] = {1, 2}
      }
      for _, proId in ipairs(proIds) do
        for _, _target in ipairs(_targets) do
          if _target.unit.profession == proId[1] or _target.unit.profession == proId[2] then
            table.insert(chooseTargets, _target)
          end
        end
        if 0 < #chooseTargets then
          break
        end
      end
      table.sort(chooseTargets, function(tA, tB)
        return tB.hp < tA.hp
      end)
      local target = chooseTargets[1]
      return target
    end,
    [24] = function(_targets)
      local chooseTargets = {}
      local proIds = {
        [1] = {5, 6},
        [2] = {3, 4},
        [3] = {1, 2}
      }
      for _, proId in ipairs(proIds) do
        for _, _target in ipairs(_targets) do
          if _target.unit.profession == proId[1] or _target.unit.profession == proId[2] then
            table.insert(chooseTargets, _target)
          end
        end
        if 0 < #chooseTargets then
          break
        end
      end
      table.sort(chooseTargets, function(tA, tB)
        return tB.hp < tA.hp
      end)
      local target = chooseTargets[1]
      return target
    end,
    [25] = function(_targets)
      local chooseTargets = {}
      for i = 1, 2 do
        for _, _target in ipairs(_targets) do
          if _target.unit.profession == i then
            table.insert(chooseTargets, _target)
          end
        end
        if 0 < #chooseTargets then
          break
        end
      end
      if 0 < #chooseTargets then
        table.sort(chooseTargets, function(tA, tB)
          return tB.hp < tA.hp
        end)
        local target = chooseTargets[1]
        return target
      else
        local proIds = {
          [1] = {3, 4},
          [2] = {5, 6}
        }
        for _, proId in ipairs(proIds) do
          for _, _target in ipairs(_targets) do
            if _target.unit.profession == proId[1] or _target.unit.profession == proId[2] then
              return _target
            end
          end
        end
      end
    end,
    [26] = function(_targets)
      local chooseTargets = {}
      for i = 4, 3, -1 do
        for _, _target in ipairs(_targets) do
          if _target.unit.profession == i then
            table.insert(chooseTargets, _target)
          end
        end
        if 0 < #chooseTargets then
          break
        end
      end
      if 0 < #chooseTargets then
        table.sort(chooseTargets, function(tA, tB)
          return tB.hp < tA.hp
        end)
        local target = chooseTargets[1]
        return target
      else
        local proIds = {
          [1] = {1, 2},
          [2] = {5, 6}
        }
        for _, proId in ipairs(proIds) do
          for _, _target in ipairs(_targets) do
            if _target.unit.profession == proId[1] or _target.unit.profession == proId[2] then
              return _target
            end
          end
        end
      end
    end,
    [27] = function(_targets)
      local chooseTargets = {}
      for i = 6, 5, -1 do
        for _, _target in ipairs(_targets) do
          if _target.unit.profession == i then
            table.insert(chooseTargets, _target)
          end
        end
        if 0 < #chooseTargets then
          break
        end
      end
      if 0 < #chooseTargets then
        table.sort(chooseTargets, function(tA, tB)
          return tB.hp < tA.hp
        end)
        local target = chooseTargets[1]
        return target
      else
        local proIds = {
          [1] = {3, 4},
          [2] = {1, 2}
        }
        for _, proId in ipairs(proIds) do
          for _, _target in ipairs(_targets) do
            if _target.unit.profession == proId[1] or _target.unit.profession == proId[2] then
              return _target
            end
          end
        end
      end
    end
  }
  local targets = self:filterByType()
  targets = self:filterByDistance(targets)
  if self.csvData.type ~= 2 then
    local tastePlayers = self.battle.tastePlayers
    local force = {}
    if 0 < #tastePlayers then
      for _, target in ipairs(targets) do
        for __, _forceTarget in ipairs(tastePlayers) do
          if _forceTarget.id == target.id then
            table.insert(force, target)
            break
          end
        end
      end
    end
    if 0 < #force then
      targets = force
    end
  end
  local target
  local newTargets = {}
  local count = #targets
  if 0 < #targets then
    for i = 1, count do
      local index = math.randomInt(1, #targets)
      table.insert(newTargets, targets[index])
      table.remove(targets, index)
    end
    targets = newTargets
    if effectTypeFuncs[self.csvData.targetType] then
      target = effectTypeFuncs[self.csvData.targetType](targets)
    end
  end
  if not target then
    local xPos = player.side == SIDE_LEFT and player.xPos + self.atkDistance or player.xPos - self.atkDistance
    target = {
      xPos = xPos,
      side = player.otherSide,
      type = -1
    }
  end
  return target
end

function Skill:getSkillTargets()
  local player = self.owner
  local effectTypeFuncs = {
    [28] = function(_targets)
      local selectTargets = {}
      if self.csvData.targetType == 28 then
        for _, _target in ipairs(_targets) do
          if _target.unit.profession == 4 then
            table.insert(selectTargets, _target)
          end
        end
        if next(selectTargets) == nil then
          for _, _target in ipairs(_targets) do
            if _target.unit.profession == 1 then
              table.insert(selectTargets, _target)
            end
          end
        end
      end
      return selectTargets
    end,
    [29] = function(_targets)
      local selectTargets = {}
      for _, _target in ipairs(_targets) do
        if _target.unit.profession == 3 or _target.unit.profession == 4 then
          table.insert(selectTargets, _target)
        end
      end
      return selectTargets
    end,
    [30] = function(_targets)
      local selectTargets = {}
      for _, _target in ipairs(_targets) do
        if _target.unit.profession == 1 or _target.unit.profession == 2 then
          table.insert(selectTargets, _target)
        end
      end
      return selectTargets
    end,
    [31] = function(_targets)
      local selectTargets = {}
      for _, _target in ipairs(_targets) do
        if _target.unit.profession == 5 or _target.unit.profession == 6 then
          table.insert(selectTargets, _target)
        end
      end
      return selectTargets
    end
  }
  local targets = self:filterByType()
  targets = self:filterByDistance(targets)
  if self.csvData.type ~= 2 then
    local tastePlayers = self.battle.tastePlayers
    local force = {}
    if 0 < #tastePlayers then
      for _, target in ipairs(targets) do
        for __, _forceTarget in ipairs(tastePlayers) do
          if _forceTarget.id == target.id then
            table.insert(force, target)
            break
          end
        end
      end
    end
    if 0 < #force then
      targets = force
    end
  end
  if effectTypeFuncs[self.csvData.targetType] then
    targets = effectTypeFuncs[self.csvData.targetType](targets)
  end
  return targets
end

function Skill:getAttackTargets()
  local targets = self:filterByType()
  if self.csvData.targetType == 1 then
    targets = self:filterByDistance(targets)
  end
  print("getAttackTargets buff191:", #targets)
  local isFilter = false
  if self.csvData.type == 1 and self.csvData.targetType == 1 then
    if targets then
      table.filter(targets, function(target)
        return not target:hasBuff(191)
      end)
      isFilter = true
    end
    print("getAttackTargets buff191 191:", #targets)
  end
  local result = {}
  for _, target in ipairs(targets) do
    if self:validEffectRange(target) then
      table.insert(result, target)
    end
  end
  if #result == 0 and not isFilter then
    if self.skillTarget.type ~= -1 then
      table.insert(result, self.skillTarget)
    end
    for k, targetValue in pairs(self.skillTargets) do
      if targetValue.type ~= -1 and self.csvData.targetType >= 28 and self.csvData.targetType <= 31 then
        table.insert(result, targetValue)
      end
    end
  end
  return result
end

function Skill:filterByType()
  local targets = {}
  local side = self.side == SIDE_LEFT and SIDE_RIGHT or SIDE_LEFT
  if self.csvData.type == 2 then
    side = self.side
  end
  for _, target in ipairs(self.battle:getPlayers(side)) do
    local numLimit = false
    if self.csvData.effectLimit > 0 then
      local effNum = self.effectTargets[target.id] or 0
      numLimit = effNum >= self.csvData.effectLimit
    end
    if not numLimit and 0 < target.hp then
      table.insert(targets, target)
    end
  end
  local typeFunction = {
    [11] = function(target)
      return target.unit.profession == 1
    end,
    [12] = function(target)
      return target.unit.profession == 2
    end,
    [13] = function(target)
      return target.unit.profession == 3
    end,
    [14] = function(target)
      return target.unit.profession == 4
    end,
    [15] = function(target)
      return target.unit.profession == 5
    end,
    [16] = function(target)
      return target.unit.profession == 6
    end,
    [20] = function(target)
      return target.unit.profession == 1 or target.unit.profession == 2
    end,
    [21] = function(target)
      return target.unit.profession == 3 or target.unit.profession == 6
    end,
    [22] = function(target)
      return target.unit.profession == 4 or target.unit.profession == 5
    end,
    [23] = function(target)
      return target.side == self.owner.side and target.id ~= self.owner.id
    end
  }
  if self.csvData.type > 10 then
    if not typeFunction[self.csvData.type] then
      return targets
    end
    local chooseTargets = {}
    for _, target in ipairs(targets) do
      if typeFunction[self.csvData.type](target) then
        table.insert(chooseTargets, target)
      end
    end
    targets = chooseTargets
  end
  return targets
end

function Skill:filterByDistance(targets)
  local result = {}
  for _, target in ipairs(targets) do
    if self.battle:distance(self.owner, target) <= self.atkDistance + target.width then
      result[#result + 1] = target
    end
  end
  return result
end

function Skill:validEffectRange(player)
  if self.csvData.targetType == 1 or self.csvData.targetType == 4 then
    return true
  end
  local distance = self.battle:distance(self.skillTarget, player)
  return distance < self.effectRange
end

function Skill:filterByEffectRange(_targets)
  local targets = {}
  local player = self.owner
  local direction = player.direction == Direction.right and 1 or -1
  for _, _target in ipairs(_targets) do
    local distance = (_target.xPos - player.xPos) * direction
    if distance <= self.csvData.distanceFront * 100 and distance >= -self.csvData.distanceBehind * 100 then
      table.insert(targets, _target)
    end
  end
  return targets
end

function Skill:resetSkillId(skillId)
  self.id = skillId
  self.csvData = skillDataSet[skillId]
  self.atkDistance = self.csvData.distance * BATTLE_GRID_PIXEL + self.owner.width
  self.effectRange = self.csvData.effectRange * BATTLE_GRID_PIXEL
end

function Skill:appendObjectBuffs(buffId)
  table.insert(self.objectBuffs, buffId)
end

function Skill:hasEffect()
  return self.bulletIndex > 1
end

function Skill:addSelfBuff()
  for _, buffId in ipairs(self.csvData.selfBuff:toArray(" ", true)) do
    if 0 < buffId then
      self.owner:addBuff({
        buffId = buffId,
        releaser = self.owner,
        skillId = self.id
      })
    end
  end
end

function Skill:addTargetBuff(target)
  for _, buffId in ipairs(self.csvData.objectBuff:toArray(" ", true)) do
    if 0 < buffId then
      target:addBuff({
        buffId = buffId,
        releaser = self.owner,
        skillId = self.id
      })
    end
  end
  for _, buffId in ipairs(self.objectBuffs) do
    target:addBuff({
      buffId = buffId,
      releaser = self.owner,
      skillId = self.id
    })
  end
  self.objectBuffs = {}
end

function Skill:hurtTarget(target)
  if self.csvData.pullclose and self.csvData.pullclose > 0 then
    target:setHurtPullClose(self.csvData.pullclose, self.csvData.pullType)
  elseif 0 < self.csvData.knockback then
    target:setHurtMoveBack(self.csvData.knockback, self.csvData.backType)
  end
end

function Skill:releaseAttachSkill()
  if self.csvData.soundId > 0 then
    game:playMusic(self.csvData.soundId)
  end
  if self.csvData.attachSkill == "" then
    return
  end
  local skillMap = string.toNumMap(self.csvData.attachSkill)
  for skillId, probability in pairs(skillMap) do
    if self.owner and 0 < skillId and probability >= math.randomInt(1, 100) then
      self.owner:releaseSkillById(skillId, false)
    end
  end
end

function Skill:dispose()
  self.delayFinish = true
  self.hasDisposed = true
  self.eventFinish = true
  for index, bullet in ipairs(self.bullets) do
    bullet:dispose()
  end
  self.bullets = {}
  if self.removePlayer and self.owner:hasPassiveSkill(PassiveSkill.CONDITION_SELF_DEAD_FRAME) then
    self.battle:removePlayer(self.owner)
    self.owner:removeAllEventListeners()
  end
end

return Skill
