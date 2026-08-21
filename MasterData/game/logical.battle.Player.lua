local unitDataSet = require("csvdata.unit")
local professionDataSet = require("csvdata.profession")
local skillSpecialSet = require("csvdata.skill_special")
local skillAwakeSet = require("csvdata.skill_awake")
local Skill = import(".Skill")
local AILogic = import(".AILogic")
local Entity = import(".Entity")
local PlayerPlugin = import(".PlayerPlugin")
local Player = class("Player", Entity)
PlayerPlugin.bind(Player)

function Player:ctor(params)
  Player.super.ctor(self, params)
  params = params or {}
  self.side = params.side or SIDE_LEFT
  self.otherSide = self.side == SIDE_LEFT and SIDE_RIGHT or SIDE_LEFT
  self.origSide = self.side
  self.type = params.type
  self.id = params.id or 0
  self.leader = params.leader
  self.unit = unitDataSet[params.type]
  self.level = params.level or 1
  self.star = params.star or self.unit.star
  self.quality = params.quality or 0
  self.battleTag = params.battleTag or 0
  self.hurtChange = params.hurtChange or {}
  self.normalLevel = 1
  self.__battleValue = params.__battleValue or "0"
  self.skillInfo = params.skillInfo or {}
  self.blockLevel = self.skillInfo.blockLv or 1
  self.specialLevel = self.skillInfo.specialLv or 1
  self.specialId = self.skillInfo.specialId or self.unit.specialId
  self.blockId = self.skillInfo.blockId or self.unit.blockId
  self.blockId2 = self.skillInfo.blockId2 or self.unit.blockId2
  self.blockId3 = self.skillInfo.blockId3 or self.unit.blockId3
  self.awakeId = self.skillInfo.awakeId or self.unit.awakeId
  self.awakeLevel = self.skillInfo.awakeLv or 0
  self.characteristicId = self.skillInfo.characteristicId
  self.characteristicLv = self.skillInfo.characteristicLv or 0
  self.dreamId = self.skillInfo.dreamId
  self.dreamLv = self.skillInfo.dreamLv or 0
  self.tebao = self.skillInfo.tebao or 0
  self.tekang = self.skillInfo.tekang or 0
  self.dress = params.dress or 0
  self.formatEffect = params.formatEffect or {}
  self.helpType = params.helpType or "self"
  self.bornType = params.bornType or "normal"
  self.liveTime = params.liveTime or math.huge
  self.magicValue = params.material2
  self.pvpSkillOrder = params.pvpSkillOrder or 0
  self.xPos = params.xPos or 0
  self.position = {
    x = self.xPos,
    y = BATTLE_Y_POS
  }
  self.yMove = self.position.y
  self.index = params.index or 1
  self.zorder = params.zorder or self.index
  self.scale = (params.scale or self.unit.boneRatio) / 100
  self.widthScale = params.widthScale or 100
  self.width = self.unit.width * self.widthScale / 100
  self.hp = params.hp
  if self.hp ~= self.hp then
    self.hp = self.side == SIDE_LEFT and 1 or 10000
  end
  self.hp = math.max(self.hp, 1)
  self.fullHp = params.fullHp or self.hp
  if self.fullHp ~= self.fullHp then
    self.fullHp = self.side == SIDE_LEFT and 1 or 10000
  end
  self.fullHp = math.max(self.fullHp, 1)
  self.atk = params.atk or self.unit.atk
  self.phyDef = params.phyDef or self.unit.phyDef
  self.hit = params.hit or self.unit.hit
  self.miss = params.miss or self.unit.miss
  self.crit = params.crit or self.unit.crit
  self.critHurt = params.critHurt or self.unit.critHurt
  self.resist = params.resist or self.unit.resist
  self.atkSpeed = params.atkSpeed or self.unit.atkSpeed
  self.shieldValue = 0
  self.shieldAddValue = 0
  self.trueAtk = params.trueAtk or 0
  self.atkResist = params.atkResist or 0
  self.hitResist = params.hitResist or 0
  self.critResist = params.critResist or 0
  self.critHurtResist = params.critHurtResist or 0
  self.isWorldBoss = params.isWorldBoss or false
  self:setProperty("hp", self.hp)
  self:setProperty("fullHp", self.fullHp)
  self:setProperty("atk", self.atk)
  self:setProperty("phyDef", self.phyDef)
  self:setProperty("crit", self.crit)
  self:setProperty("critHurt", self.critHurt)
  self:setProperty("hit", self.hit)
  self:setProperty("miss", self.miss)
  self:setProperty("atkSpeed", self.atkSpeed)
  self:setProperty("trueAtk", self.trueAtk)
  self:setProperty("atkResist", self.atkResist)
  self:setProperty("hitResist", self.hitResist)
  self:setProperty("critResist", self.critResist)
  self:setProperty("critHurtResist", self.critHurtResist)
  self.moveSpeed = self.unit.move
  self.proData = professionDataSet[self.unit.profession]
  self.atkInterval = self.proData.attackInterval / self.atkSpeed
  self.atkIntervalDetect = 0
  self.knockbackResist = self.unit.knockbackResist
  self.skillOrders = params.skillOrders
  self.skillOrderIdx = 1
  self.attackOrders = params.attackQueue or {}
  self.attackOrderIdx = 0 < #self.attackOrders and 1 or 0
  self.specialSkillOrder = {}
  self.blockSkillOrder = {}
  self.currentSkill = nil
  self.currentSkillAnimation = nil
  self.passiveSkills = {}
  self.specialSkill = {}
  self.buffTypes = {}
  self.buffIds = {}
  self.useBuffCacheNum = 1
  self.buffCache = {}
  self.buffCache2 = {}
  self.canMove = true
  self.hurtMoveBack = 0
  self.hurtPullClose = 0
  self.knockbackCd = 0
  self.animationStatus = ""
  self.moveKeepTime = 0
  self.attrDirty = true
  self.buffIconDirty = true
  self.totalCSkillCnt = 0
  self.totalSSkillCnt = 0
  self.totalAttackCnt = 0
  self.totalAttackedCnt = 0
  self.totalAttackValue = 0
  self.totalHurtCnt = 0
  self.totalHurtedCnt = 0
  self.totalHurtOutput = 0
  self.totalAttackNum = 0
  self.totalAttackNumNew = 0
  self.teamerStateRecords = {}
  self.lastStateRecords = {}
  self.caller = params.caller
  self.calleeNum = 0
  self.deadCnt = 0
  self.slave = params.slave or false
  self.slaveDistance = params.slaveDistance
  self.skillBar = params.skillBar
  self.taste = params.taste
  self:initStatusMap()
  self:initSpecialSkills()
  self:initPassiveSkills()
  self:initAwakeSkills()
  self:initInnateSkills()
  self:resetAttributes()
end

function Player:initStatusMap()
  self:setupState({
    initial = "None",
    events = {
      {
        name = "idle",
        from = "None",
        to = "Idle"
      },
      {
        name = "idle",
        from = "Move",
        to = "Idle"
      },
      {
        name = "idle",
        from = "Attack",
        to = "Idle"
      },
      {
        name = "idle",
        from = "Block",
        to = "Idle"
      },
      {
        name = "idle",
        from = "Standby",
        to = "Idle"
      },
      {
        name = "idle",
        from = "Special",
        to = "Idle"
      },
      {
        name = "idle",
        from = "Hurt",
        to = "Idle"
      },
      {
        name = "move",
        from = "Idle",
        to = "Move"
      },
      {
        name = "attack",
        from = "Idle",
        to = "Attack"
      },
      {
        name = "attack",
        from = "Move",
        to = "Attack"
      },
      {
        name = "block",
        from = "Idle",
        to = "Block"
      },
      {
        name = "block",
        from = "Move",
        to = "Block"
      },
      {
        name = "standby",
        from = "Idle",
        to = "Standby"
      },
      {
        name = "standby",
        from = "Move",
        to = "Standby"
      },
      {
        name = "special",
        from = "Idle",
        to = "Special"
      },
      {
        name = "special",
        from = "Move",
        to = "Special"
      },
      {
        name = "special",
        from = "Standby",
        to = "Special"
      },
      {
        name = "hurt",
        from = "Idle",
        to = "Hurt"
      },
      {
        name = "hurt",
        from = "Move",
        to = "Hurt"
      },
      {
        name = "hurt",
        from = "Standby",
        to = "Hurt"
      },
      {
        name = "hurt",
        from = "Special",
        to = "Hurt"
      },
      {
        name = "hurt",
        from = "Attack",
        to = "Hurt"
      },
      {
        name = "hurt",
        from = "Block",
        to = "Hurt"
      },
      {
        name = "cheer",
        from = "*",
        to = "Cheer"
      },
      {
        name = "over",
        from = "*",
        to = "Dead"
      }
    },
    callbacks = {
      onenterIdle = function(event)
        self:onIdle(event)
      end,
      onenterMove = function(event)
        self.moveKeepTime = 0.2
        self:onMove(event)
      end,
      onenterAttack = function(event)
        self.atkIntervalDetect = self.curAtkInterval
        self.skillOrderIdx = self.skillOrderIdx + 1
        self:enterAttack()
      end,
      onenterBlock = function(event)
        self:onBlock()
      end,
      onenterSpecial = function(event)
        self:enterSpecial()
      end,
      onenterStandby = function(event)
        self:onStandby()
      end,
      onenterHurt = function(event)
        self:onHurt(event)
      end,
      onenterCheer = function(event)
        self:onCheer(event)
      end,
      onenterDead = function(event)
        self:enterDead(event)
      end
    }
  })
end

function Player:releaseSkill()
  if not self.currentSkillId then
    return
  end
  if self.currentSkill and not self.currentSkill.hasDisposed then
    self.currentSkill:effect()
  else
    local skill = Skill.new({
      owner = self,
      id = self.currentSkillId,
      event = true
    })
    self.battle:addSkill(skill)
    self.currentSkill = skill
  end
end

function Player:disposeSkill()
  if self.currentSkill and not self.currentSkill.hasDisposed then
    self:onSkillFinish(self.currentSkill)
    self.currentSkill:eventEnd()
  end
  self.currentSkill = nil
end

function Player:releaseSkillById(skillId, withAction, animation, skipSpecial)
  if not withAction or skipSpecial then
    local skill = Skill.new({owner = self, id = skillId})
    self.battle:addSkill(skill)
    return
  end
  if self:isSpecial(skillId) then
    table.insert(self.specialSkillOrder, {skillId = skillId, animation = animation})
  else
    table.insert(self.blockSkillOrder, skillId)
  end
end

function Player:createSpecialSkill(bLimit, skillId, level)
  skillId = skillId or self.specialSkill.specialId
  level = level or self.specialLevel
  if bLimit then
    if self.specialSkill.curNum >= self.specialSkill.numLimit then
      return
    end
    self.specialSkill.curNum = self.specialSkill.curNum + 1
  end
  if self.skillBar then
    self.skillBar:addSkill(skillId, level, self)
  end
end

function Player:update(dt)
  if self.isPause then
    return
  end
  if self:getState() == "Dead" then
    return
  end
  if dt == 0 then
    return
  end
  self:battleUpdate(dt)
  if self.buffIconDirty then
    self:updateBuffIcon()
    self.buffIconDirty = false
  end
  if 0 < self.knockbackCd then
    self.knockbackCd = self.knockbackCd - dt * 1000
  end
  for type, datas in pairs(self.passiveSkills) do
    for _, skill in ipairs(datas) do
      skill.passiveSkill:update(dt)
    end
  end
  if self.slave then
    self:slaveUpdate(dt)
    return
  end
  if self:hasBuff(10) or self:hasBuff(189) or self:hasBuff(11) then
    return
  end
  self:skillOrderUpdate(dt)
  if self.skillOrders then
    self:AIUpdate(dt)
  end
  self:moveUpdate(dt)
end

function Player:slaveUpdate(dt)
  self.xPos = self.caller.xPos + self.slaveDistance
  self.position.x = self.xPos
  self:onUpdatePosition()
end

function Player:moveUpdate(dt)
  if self.hurtMoveBack < 0 then
    return
  end
  if 0 > self.hurtPullClose then
    return
  end
  if self.hurtMoveBack > 0 then
    local xPos = self.side == SIDE_LEFT and self.xPos - self.hurtMoveBack or self.xPos + self.hurtMoveBack
    xPos = math.min(self.battle.rightBoundary, xPos)
    xPos = math.max(self.battle.leftBoundary, xPos)
    local delta = xPos - self.xPos
    local dis = math.abs(delta)
    if 150 <= dis then
      local deltaTime = dis / 1500
      self.displayNode:runAction(transition.sequence({
        cc.Spawn:create({
          cc.MoveBy:create(deltaTime, cc.p(delta / 3 * 2, 0)),
          cc.EaseOut:create(cc.MoveBy:create(deltaTime, cc.p(0, dis / 4)), 2)
        }),
        cc.Spawn:create({
          cc.MoveBy:create(deltaTime, cc.p(delta / 3, 0)),
          cc.EaseIn:create(cc.MoveBy:create(deltaTime, cc.p(0, -dis / 4)), 2)
        }),
        cc.CallFunc:create(function()
          self.hurtMoveBack = 0
        end)
      }))
      self.xPos = xPos
      self.position.x = self.position.x + delta
      self.hurtMoveBack = -1
      return
    elseif 1 < dis then
      self.displayNode:runAction(transition.sequence({
        cc.Spawn:create({
          cc.MoveBy:create(0.15, cc.p(delta / 2, 0)),
          cc.EaseOut:create(cc.MoveBy:create(0.15, cc.p(0, dis / 4)), 2)
        }),
        cc.Spawn:create({
          cc.MoveBy:create(0.15, cc.p(delta / 2, 0)),
          cc.EaseIn:create(cc.MoveBy:create(0.15, cc.p(0, -dis / 4)), 2)
        }),
        cc.CallFunc:create(function()
          self.hurtMoveBack = 0
        end)
      }))
      self.xPos = xPos
      self.position.x = self.position.x + delta
      self.hurtMoveBack = -1
      return
    end
    self.hurtMoveBack = 0
  end
  if 0 < self.hurtPullClose then
    local xPos = self.side == SIDE_LEFT and self.xPos + self.hurtPullClose or self.xPos - self.hurtPullClose
    xPos = math.min(self.battle.rightBoundary, xPos)
    xPos = math.max(self.battle.leftBoundary, xPos)
    local enemy = self.battle:nearestEnemy(self)
    xPos = self.side == SIDE_LEFT and math.min(enemy.xPos - 50, xPos) or math.max(enemy.xPos + 50, xPos)
    local delta = xPos - self.xPos
    local dis = math.abs(delta)
    if 150 <= dis then
      local deltaTime = dis / 1500
      self.displayNode:runAction(transition.sequence({
        cc.Spawn:create({
          cc.MoveBy:create(deltaTime, cc.p(delta / 3 * 2, 0)),
          cc.EaseOut:create(cc.MoveBy:create(deltaTime, cc.p(0, dis / 4)), 2)
        }),
        cc.Spawn:create({
          cc.MoveBy:create(deltaTime, cc.p(delta / 3, 0)),
          cc.EaseOut:create(cc.MoveBy:create(deltaTime, cc.p(0, -dis / 4)), 2)
        }),
        cc.CallFunc:create(function()
          self.hurtPullClose = 0
        end)
      }))
      self.xPos = xPos
      self.position.x = self.position.x + delta
      self.hurtPullClose = -1
      return
    elseif 1 < dis then
      self.displayNode:runAction(transition.sequence({
        cc.Spawn:create({
          cc.MoveBy:create(0.15, cc.p(delta / 2, 0)),
          cc.EaseOut:create(cc.MoveBy:create(0.15, cc.p(0, dis / 4)), 2)
        }),
        cc.Spawn:create({
          cc.MoveBy:create(0.15, cc.p(delta / 2, 0)),
          cc.EaseIn:create(cc.MoveBy:create(0.15, cc.p(0, -dis / 4)), 2)
        }),
        cc.CallFunc:create(function()
          self.hurtPullClose = 0
        end)
      }))
      self.xPos = xPos
      self.position.x = self.position.x + delta
      self.hurtPullClose = -1
      return
    end
    self.hurtPullClose = 0
  end
  if self:getState() == "Move" or self:getState() == "Idle" then
    local enemy = self.battle:nearestEnemy(self)
    if not enemy then
      return
    end
    local offset = self.moveSpeed * dt
    if self:hasBuff(12) then
      local effectValue = 0
      for _, _buff in pairs(self.buffTypes[12]) do
        effectValue = effectValue + _buff:effect()
      end
      effectValue = math.max(effectValue, 1)
      offset = offset * (1 - effectValue)
    end
    local yMove = self.yMove - self.position.y
    if math.abs(yMove) > 1 then
      offset = offset / 2
      local yOffset = math.min(math.abs(yMove), offset)
      self.position.y = 0 < yMove and self.position.y + yOffset or self.position.y - yOffset
    end
    local xPos = self.xPos
    local distance = self.battle:distance(self, enemy)
    if distance < self.proData.minAtkDis and not self.neverMoveBack then
      offset = offset * globalCsv.backSpeedMod
      xPos = self.side == SIDE_LEFT and self.xPos - offset or self.xPos + offset
    elseif distance > self.proData.maxAtkDis then
      xPos = self.side == SIDE_LEFT and self.xPos + offset or self.xPos - offset
    end
    local ignoreBoundary = self.xPos < self.battle.leftBoundary or self.xPos > self.battle.rightBoundary
    if not ignoreBoundary then
      xPos = math.min(self.battle.rightBoundary, xPos)
      xPos = math.max(self.battle.leftBoundary, xPos)
    elseif self.xPos < self.battle.leftBoundary then
      xPos = math.max(self.xPos, xPos)
    elseif self.xPos > self.battle.rightBoundary then
      xPos = math.min(self.xPos, xPos)
    end
    local delta = xPos - self.xPos
    self.xPos = xPos
    self.position.x = self.position.x + delta
    self:onUpdatePosition()
    if delta == 0 and math.abs(yMove) < 1 then
      if 0 >= self.atkIntervalDetect and self:canDoEvent("attack") then
        self:doEvent("attack")
      elseif 0 < self.moveKeepTime then
        self.moveKeepTime = self.moveKeepTime - dt
      elseif self:canDoEvent("idle") then
        self:doEvent("idle")
      end
    elseif self:canDoEvent("move") then
      self:doEvent("move")
    end
  end
end

function Player:skillOrderUpdate(dt)
  if self.atkIntervalDetect > 0 then
    self.atkIntervalDetect = self.atkIntervalDetect - dt
  end
  if self:hasBuff(24) then
    return
  end
  if self:hasBuff(14) then
    return
  end
  if 0 < #self.specialSkillOrder then
    local skill
    if 0 < self.unit.standby and self:canDoEvent("standby") then
      skill = self.specialSkillOrder[1]
      self.currentSkillId = skill.skillId
      self.currentSkillAnimation = skill.animation
      if self.unit.standby == 1 or self.unit.standby == self.currentSkillId then
        self:doEvent("standby")
      elseif self:canDoEvent("special") then
        self:doEvent("special")
      else
        skill = nil
      end
    elseif self:canDoEvent("special") then
      skill = self.specialSkillOrder[1]
      self.currentSkillId = skill.skillId
      self.currentSkillAnimation = skill.animation
      self:doEvent("special")
    end
    if skill then
      table.remove(self.specialSkillOrder, 1)
      return
    end
  elseif 0 < #self.blockSkillOrder and self:canDoEvent("block") then
    self.currentSkillId = self.blockSkillOrder[1]
    self:doEvent("block")
    table.remove(self.blockSkillOrder, 1)
    return
  end
end

function Player:AIUpdate(dt)
  if (self:getState() == "Move" or self:getState() == "Idle") and self.atkIntervalDetect <= 0 then
    if self.skillOrderIdx > #self.skillOrders then
      self.skillOrderIdx = 1
    end
    local skillIndex = self.skillOrders[self.skillOrderIdx]
    if skillIndex and 1 <= skillIndex then
      local specialId = self.specialId
      if 1 < skillIndex then
        specialId = self.unit["specialId" .. skillIndex]
      end
      if 0 < specialId then
        local skillData = skillSpecialSet[specialId][self.specialLevel]
        self:releaseSkillById(skillData.skillId, true, skillIndex)
      end
      self.atkIntervalDetect = self.curAtkInterval
      self.skillOrderIdx = self.skillOrderIdx + 1
    end
  end
end

function Player:changeSkillOrders(value)
  local orders = value:toArray("-", true)
  self.skillOrders = orders
  self.skillOrderIdx = 1
end

function Player:changeUnitType(params)
  if self:getState() == "Dead" then
    return
  end
  if not unitDataSet[params.type] then
    return
  end
  local lastUnit = self.unit
  self.realType = lastUnit.type
  self.unit = unitDataSet[params.type]
  self:onChangeUnitType()
  if self:canDoEvent("idle") then
    self:doEvent("idle")
  end
end

function Player:setHurtMoveBack(dis, backType)
  backType = backType or 0
  if 0 < self.knockbackResist then
    return
  end
  if self.hurtMoveBack ~= 0 then
    return
  end
  if self.hurtPullClose ~= 0 then
    return
  end
  if self:getState() == "Dead" then
    return
  end
  local ignoreCD = 0 < backType
  if not ignoreCD and 0 < self.knockbackCd then
    return
  end
  local forceBack = backType == 2
  if not forceBack then
    local hurtActs = {
      Idle = true,
      Move = true,
      Standby = true
    }
    if not hurtActs[self:getState()] then
      return
    end
  end
  if not self:canDoEvent("hurt") then
    return
  end
  self.knockbackCd = globalCsv.knockbackCd
  self.hurtMoveBack = dis
  self:doEvent("hurt")
end

function Player:setHurtPullClose(dis, pullType)
  pullType = pullType or 0
  if 0 < self.knockbackResist then
    return
  end
  if self.hurtPullClose ~= 0 then
    return
  end
  if self:getState() == "Dead" then
    return
  end
  local ignoreCD = 0 < pullType
  if not ignoreCD and 0 < self.pullcloseCd then
    return
  end
  local forcePull = pullType == 2
  if not forcePull then
    local hurtActs = {
      Idle = true,
      Move = true,
      Standby = true
    }
    if not hurtActs[self:getState()] then
      return
    end
  end
  if not self:canDoEvent("hurt") then
    return
  end
  self.pullcloseCd = globalCsv.pullcloseCd
  self.hurtPullClose = dis
  self:doEvent("hurt")
end

function Player:getSideKey()
  local key = {
    [SIDE_LEFT] = "left",
    [SIDE_RIGHT] = "right"
  }
  return key[self.side]
end

function Player:getOrigSideKey()
  local key = {
    [SIDE_LEFT] = "left",
    [SIDE_RIGHT] = "right"
  }
  return key[self.origSide]
end

function Player:getKey()
  return self:getSideKey() .. "_" .. self.index
end

function Player:getOrigKey()
  return self:getOrigSideKey() .. "_" .. self.index
end

function Player:pause(shipAnimation)
  self.isPause = true
  self:onPause(shipAnimation)
end

function Player:resume(shipAnimation)
  self.isPause = false
  self:onResume(shipAnimation)
end

function Player:clearSubPassive()
  local enemys = self.battle:getPlayers(self.otherSide)
  for _, player in pairs(enemys) do
    local passives = player.passiveSkills
    for _, skills in ipairs(passives) do
      for _, skill in pairs(skills) do
        if skill.parentPlayer and skill.parentPlayer == self then
          skill.cd = 999
        end
      end
    end
  end
end

function Player:enterDead(event)
  self:clearBuffs()
  self:clearSubPassive()
  self:onDead(event)
  self:deadFinal()
  local keep = false
  if not keep then
    self.battle:removePlayer(self)
    self:removeAllEventListeners()
  end
end

function Player:enterAttack()
  self.currentSkillId = self.unit.attackId
  self:beginAttack()
  self:onAttack()
end

function Player:clearBuffs()
  for type, buffs in pairs(self.buffTypes) do
    for _, buff in ipairs(buffs) do
      buff:endBuff()
    end
  end
  self.buffTypes = {}
end

function Player:clearSkills()
end

function Player:dispose()
end

function Player:setProperty(key, value)
  if type(value) == "number" then
    self[key .. "__ed"] = tostring(value)
  end
  self[key] = value
end

function Player:getProperty(key)
  if self[key .. "__ed"] then
    return tonumber(self[key .. "__ed"])
  else
    return self[key]
  end
end

return Player
