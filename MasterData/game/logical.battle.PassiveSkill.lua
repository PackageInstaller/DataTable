local PassiveSkillCsv = require("csvdata.skill_passive")
local SkillSpecialSet = require("csvdata.skill_special")
local buffDataSet = require("csvdata.buff")
local UnitCsv = require("csvdata.unit")
local PassiveSkill = class("PassiveSkill")
PassiveSkill.CONDITION_BATTLE_START = 1
PassiveSkill.CONDITION_ACTIVE_WITH_TIME = 2
PassiveSkill.CONDITION_SPECIAL_SKILL = 3
PassiveSkill.CONDITION_ATTACK_TARGET = 4
PassiveSkill.CONDITION_ATTACK_TRAGET_WITH_HURT = 5
PassiveSkill.CONDITION_ATTACK_WITH_MISS = 6
PassiveSkill.CONDITION_ATTACK_WITH_CRIT = 7
PassiveSkill.CONDITION_ATTACK_NUM = 8
PassiveSkill.CONDITION_ATTACK_PROFESSION = 9
PassiveSkill.CONDITION_ATTACKED_BY_TARGET = 10
PassiveSkill.CONDITION_ATTACKED_WITH_HURT = 11
PassiveSkill.CONDITION_ATTACKED_WITH_MISS = 12
PassiveSkill.CONDITION_ATTACKED_WITH_CRIT = 13
PassiveSkill.CONDITION_ATTACKED_NUM = 14
PassiveSkill.CONDITION_ATTACKED_PROFESSION = 15
PassiveSkill.CONDITION_SELF_DOWN_HP = 16
PassiveSkill.CONDITION_SELF_ADD_HP = 17
PassiveSkill.CONDITION_SELF_DEAD = 18
PassiveSkill.CONDITION_SELF_ADD_BUFF = 19
PassiveSkill.CONDITION_SELF_ADD_DEBUFF = 20
PassiveSkill.CONDITION_SELF_CLEAR_DEBUFF = 21
PassiveSkill.CONDITION_TEAMER_DOWN_HP = 22
PassiveSkill.CONDITION_TEAMER_ADD_HP = 23
PassiveSkill.CONDITION_TEAMER_DEAD = 24
PassiveSkill.CONDITION_TEAMER_ADD_BUFF = 25
PassiveSkill.CONDITION_TEAMER_ADD_DEBUFF = 26
PassiveSkill.CONDITION_TEAMER_CLEAR_DEBUFF = 27
PassiveSkill.CONDITION_ENEMY_DOWN_HP = 28
PassiveSkill.CONDITION_ENEMY_ADD_HP = 29
PassiveSkill.CONDITION_ENEMY_DEAD = 30
PassiveSkill.CONDITION_ENEMY_ADD_BUFF = 31
PassiveSkill.CONDITION_ENEMY_ADD_DEBUFF = 32
PassiveSkill.CONDITION_ENEMY_CLEAR_DEBUFF = 33
PassiveSkill.CONDITION_ATTACKED_BEFORE_HURT = 34
PassiveSkill.CONDITION_ACTIVE_WITH_DELAY = 35
PassiveSkill.CONDITION_BATTLE_START_CHECK_HP = 36
PassiveSkill.CONDITION_ENEMY_ADD_BUFF_SPECIAL = 37
PassiveSkill.CONDITION_TEAMER_ADD_NOT_DEBUFF = 38
PassiveSkill.CONDITION_ENEMY_PROFESSION = 39
PassiveSkill.CONDITION_NO_TEAMER = 41
PassiveSkill.CONDITION_TEAMER_DEAD_ALL = 42
PassiveSkill.CONDITION_ATTACK_BEFORE_SHIELD = 43
PassiveSkill.CONDITION_ATTACK_TRAGET_WITH_HURT_2 = 44
PassiveSkill.CONDITION_TEAMER_AND_SELF_SPECIAL_SKILL = 46
PassiveSkill.CONDITION_ENEMY_SPECIAL_SKILL = 47
PassiveSkill.CONDITION_SPECIAL_SKILL_FINISH = 48
PassiveSkill.CONDITION_ATTACK_HURTVALUE = 49
PassiveSkill.CONDITION_HURTED_NUM = 50
PassiveSkill.CONDITION_HURT_NUM = 51
PassiveSkill.CONDITION_SELF_ADD_SPECIAL_BUFF = 52
PassiveSkill.CONDITION_TEAMER_ADD_SPECIAL_BUFF_BY_SELF = 53
PassiveSkill.CONDITION_TEAMER_DEAD_BY_PROFESSION = 54
PassiveSkill.CONDITION_SELF_ADD_UPBUFF = 56
PassiveSkill.CONDITION_ADD_DEBUFF_TO_OTHERS = 57
PassiveSkill.CONDITION_ADD_UPBUFF_TO_TEAMER = 58
PassiveSkill.CONDITION_SELF_SIDE_DOWN_HP = 60
PassiveSkill.CONDITION_ENEMY_ADD_UPBUFF = 61
PassiveSkill.CONDITION_ATTACK_WITHOUT_CRIT = 64
PassiveSkill.CONDITION_SELF_HAS_BUFFS = 65
PassiveSkill.CONDITION_SELF_ADD_SHIELD = 67
PassiveSkill.CONDITION_TEAMER_AND_SELF_ADD_SHIELD = 68
PassiveSkill.CONDITION_TEAMER_START = 70
PassiveSkill.CONDITION_TEAMER_START_WITH_DELAY = 71
PassiveSkill.CONDITION_ADD_BUFFS_TO_ENEMY = 72
PassiveSkill.CONDITION_ENEMY_BATTLE_START = 73
PassiveSkill.CONDITION_BATTLE_CHECK_HP = 74
PassiveSkill.CONDITION_ADD_DEBUFFS_TO_ENEMY = 75
PassiveSkill.CONDITION_SELF_BUFF_END_BY_ID = 78
PassiveSkill.CONDITION_ATTACK_WITH_TRUE_HURT = 80
PassiveSkill.CONDITION_TEAMER_PREPARE_TO_DEAD = 81
PassiveSkill.CONDITION_ENEMY_OR_TEAMER_DEAD = 82
PassiveSkill.CONDITION_SELF_SIDE_ADD_DEBUFF_BY_ID = 83
PassiveSkill.CONDITION_ADD_CONTROLBUFF_TO_ENEMY = 84
PassiveSkill.CONDITION_ADD_SPECIAL_ID_BUFF = 85
PassiveSkill.CONDITION_ADD_SPECIAL_TYPE_BUFF = 86
PassiveSkill.CONDITION_ATTACK_HAVE_DEBUFF = 87
PassiveSkill.CONDITION_SPECIALMISS_SUCCESS = 89
PassiveSkill.CONDITION_ATTACK_HIT_LOSS = 90
PassiveSkill.CONDITION_SELF_SIDE_ADD_BUFF_BY_ID = 91
PassiveSkill.CONDITION_SELF_ADD_BUFF_BY_ID = 92
PassiveSkill.CONDITION_OWNER_PREPARE_TO_DEAD = 93
PassiveSkill.CONDITION_SELF_BUFF_END_BY_TYPE = 94
PassiveSkill.CONDITION_ATTACK_NUM_NEW = 95
PassiveSkill.CONDITION_SELF_ADD_SOMEKIND_BUFF = 96
PassiveSkill.CONDITION_SELF_BUFF_END_BY_DEBUFF1 = 97
PassiveSkill.CONDITION_SELF_BUFF_END_BY_DEBUFF2 = 98
PassiveSkill.CONDITION_SELF_HAS_BUFFS_MULTIPLE = 99
PassiveSkill.CONDITION_ENEMY_ADD_BUFF_TO_SELF = 100
PassiveSkill.CONDITION_HURT_OVER_ATK_N = 101
PassiveSkill.CONDITION_SELF_HAS_BUFFS_EQUIP_NUM = 102

function PassiveSkill:ctor(params)
  params = params or {}
  self.id = params.id
  self.owner = params.owner
  self.firstBlock = params.firstBlock
  self.parentPlayer = params.parent
  self.csvData = PassiveSkillCsv[self.id]
  self.cd = 0
  self.bActive = true
  self.recordValue = nil
  self:preprocessing()
end

function PassiveSkill:preprocessing()
  if self.csvData.value == "" then
    return
  end
  self.recordValue = {}
  if self.csvData.condition == PassiveSkill.CONDITION_ENEMY_ADD_BUFF_SPECIAL or self.csvData.condition == PassiveSkill.CONDITION_ENEMY_PROFESSION then
    for _, pro in ipairs(self.csvData.value:toArray("=", true)) do
      self.recordValue[pro] = true
    end
  end
end

function PassiveSkill:effect(params)
  params = params or {}
  if self.parentPlayer and params.parent ~= self.parentPlayer then
    return
  end
  if self.owner:hasBuff(135) then
    for _, _buff in ipairs(self.owner.buffTypes[135]) do
      for _, _skillid in ipairs(_buff:effect()) do
        if _skillid == self.id then
          return
        end
      end
    end
  end
  if self.owner:hasBuff(202) then
    for _, _buff in ipairs(self.owner.buffTypes[202]) do
      local effectValue = _buff.effectValue
      local buffValues = effectValue:toArray("=", true)
      for _, typ in ipairs(buffValues) do
        if self.csvData.condition == typ then
          return
        end
      end
    end
  end
  for _, t in pairs(self.csvData.effect:toTableArray()) do
    local type = tonumber(t[1])
    local value = t[2]
    if type ~= 57 then
      value = tonumber(t[2])
    end
    if type == 105 then
      value = tonumber(self.recordValue)
    end
    if type <= 73 and 70 <= type then
      value = {
        unitType = tonumber(t[2]),
        ratio = tonumber(t[3])
      }
    end
    if type == 60 and 3 <= #t then
      for i = 3, #t do
        value = value .. "=" .. t[i]
      end
    end
    if type == 75 then
      value = {
        skillId = tonumber(t[2]),
        skillType = tonumber(t[3])
      }
    end
    if type == 112 or type == 113 or type == 114 then
      value = {
        cbuffId = tonumber(t[2]),
        abuffId = tonumber(t[3])
      }
    end
    if type == 117 and tonumber(t[1]) == 117 or type == 127 and tonumber(t[1]) == 127 then
      value = {
        heroType = tonumber(t[2]),
        abuffId = tonumber(t[3])
      }
    end
    if type == 118 and tonumber(t[1]) == 118 or type == 119 and tonumber(t[1]) == 119 or type == 120 and tonumber(t[1]) == 120 or type == 121 and tonumber(t[1]) == 121 or type == 122 and tonumber(t[1]) == 122 then
      value = {
        professionValue = tonumber(t[2]),
        abuffId = tonumber(t[3])
      }
    end
    if type == 123 and tonumber(t[1]) == 123 or type == 124 and tonumber(t[1]) == 124 or type == 125 and tonumber(t[1]) == 125 or type == 126 and tonumber(t[1]) == 126 then
      value = {
        proId1 = tonumber(t[2]),
        proId2 = tonumber(t[3]),
        abuffId1 = tonumber(t[4]),
        abuffId2 = tonumber(t[5]),
        abuffId3 = tonumber(t[6]),
        abuffId4 = tonumber(t[7])
      }
    end
    print("PassiveSkill:effect", self.id, type, value)
    self["effect" .. type](self, params, value)
  end
  if self.csvData.CD > 0 then
    self.cd = self.csvData.CD
    if self.cd >= 999 then
      self.bActive = false
    end
  end
end

function PassiveSkill:reset()
  if not self.bActive then
    self.cd = 0
    self.bActive = true
  end
end

function PassiveSkill:update(dt)
  if not self.bActive then
    return
  end
  if self.cd > 0 then
    self.cd = self.cd - dt
  end
end

function PassiveSkill:isCD()
  if self.csvData.CD == 0 then
    return false
  end
  return 0 < self.cd
end

function PassiveSkill:isActive()
  return self.bActive
end

function PassiveSkill:showBlockTip()
  return self.firstBlock
end

function PassiveSkill:effect1(params, value)
  self.owner:setProperty("hp", self.owner:getProperty("hp") * (100 + value) / 100)
end

function PassiveSkill:effect2(params, value)
  self.owner:setProperty("atk", self.owner:getProperty("atk") * (100 + value) / 100)
end

function PassiveSkill:effect3(params, value)
  self.owner:setProperty("phyDef", self.owner:getProperty("phyDef") * (100 + value) / 100)
end

function PassiveSkill:effect4(params, value)
  self.owner.hit = self.owner.hit * (100 + value) / 100
end

function PassiveSkill:effect5(params, value)
  self.owner.miss = self.owner.miss * (100 + value) / 100
end

function PassiveSkill:effect6(params, value)
  self.owner.crit = self.owner.crit * (100 + value) / 100
end

function PassiveSkill:effect7(params, value)
  self.owner.critHurt = self.owner.critHurt * (100 + value) / 100
end

function PassiveSkill:effect8(params, value)
  self.owner.atkSpeed = self.owner.atkSpeed * (100 + value) / 100
end

function PassiveSkill:effect9(params, value)
  self.owner.resist = self.owner.resist * (100 + value) / 100
end

function PassiveSkill:effect50(params, value)
  self.owner:releaseSkillById(value, true, _, true)
end

function PassiveSkill:effect51(params, value)
  self.owner:releaseSkillById(value, false)
end

function PassiveSkill:effect52(params, value)
  self.owner:releaseSkillById(value, true)
end

function PassiveSkill:effect53(params, value)
  self.owner:addBuff({
    buffId = value,
    releaser = self.owner
  })
end

function PassiveSkill:effect54(params, value)
  local battle = self.owner.battle
  for _, player in ipairs(battle:getTeamers(self.owner)) do
    player:addBuff({
      buffId = value,
      releaser = self.owner
    })
  end
end

function PassiveSkill:effect55(params, value)
  local battle = self.owner.battle
  for _, player in ipairs(battle:getEnemys(self.owner)) do
    if player:hasBuff(190) then
      local buffData = buffDataSet[value]
      for _, buff in ipairs(player.buffTypes[190]) do
        print("buff.effectValue 55 buff190:", buff.effectValue, value)
        local buffValues = {}
        if type(buff.effectValue) == "string" then
          buffValues = buff.effectValue:toArray("=", true)
        elseif type(buff.effectValue) == "number" then
          buffValues = {
            tostring(buff.effectValue)
          }
        else
          print("Warning: Unexpected buff.effectValue type:", type(buff.effectValue))
          buffValues = {}
        end
        for _, type in ipairs(buffValues) do
          if buffData.type == type then
            return
          end
        end
      end
    end
    player:addBuff({
      buffId = value,
      releaser = self.owner
    })
  end
end

function PassiveSkill:effect56(params, value)
  if not params.origin then
    print("PassiveSkill effect56 do not have origin target", self.id, value)
    return
  end
  local target = params.origin
  if target:hasBuff(200) then
    local buffData = buffDataSet[value]
    for _, buff in ipairs(target.buffTypes[200]) do
      local buffValues = buff.effectValue:toArray("=", true)
      for _, typ in ipairs(buffValues) do
        if buffData.type == typ then
          return
        end
      end
    end
  end
  params.origin:addBuff({
    buffId = value,
    releaser = self.owner
  })
end

function PassiveSkill:effect57(params, value)
  self.owner:changeSkillOrders(value)
end

function PassiveSkill:effect58(params, value)
  if not params.origin then
    print("PassiveSkill effect58 do not have origin target", self.id, value)
    return
  end
  local target = params.origin
  if target:hasBuff(200) then
    local buffData = buffDataSet[value]
    for _, buff in ipairs(target.buffTypes[200]) do
      local buffValues = buff.effectValue:toArray("=", true)
      for _, typ in ipairs(buffValues) do
        if buffData.type == typ then
          return
        end
      end
    end
  end
  if not params.origin.leader then
    params.origin:addBuff({
      buffId = value,
      releaser = self.owner
    })
  end
end

function PassiveSkill:effect59(params, value)
  self.owner:releaseSkillById(value, true, 2)
end

function PassiveSkill:effect60(params, value)
  value = value .. ""
  local battle = self.owner.battle
  local enemys = battle:getEnemys(self.owner)
  if #enemys < 1 then
    return
  end
  local index = math.randomInt(1, #enemys)
  local buffids = value:toArray("=", true)
  local buffToAdd = {}
  local target = enemys[index]
  if target:hasBuff(200) then
    for _, buffId in ipairs(buffids) do
      local isBlock = false
      local buffData = buffDataSet[buffId]
      for _, buff in ipairs(target.buffTypes[200]) do
        local buffValues = buff.effectValue:toArray("=", true)
        for _, typ in ipairs(buffValues) do
          if buffData.type == typ then
            isBlock = true
            break
          end
        end
        if isBlock then
          break
        end
      end
      if not isBlock then
        table.insert(buffToAdd, buffId)
      end
    end
  else
    for _, buffId in ipairs(buffids) do
      table.insert(buffToAdd, buffId)
    end
  end
  for _, id in ipairs(buffToAdd) do
    enemys[index]:addBuff({
      buffId = tonumber(id),
      releaser = self.owner
    })
  end
end

function PassiveSkill:effect61(params, value)
  if self.owner:hasBuff(61) then
    for _, buff in ipairs(self.owner.buffTypes[61]) do
      buff:effect()
    end
  end
end

function PassiveSkill:effect62(params, value)
  if not params.origin then
    print("PassiveSkill effect62 do not have origin target", self.id, value)
    return
  end
  local buffId = params.origin.id
  local releaser = params.origin.releaser
  self.owner:addBuff({
    buffId = buffId,
    releaser = releaser,
    steal = true
  })
end

function PassiveSkill:effect63(params, value)
  local battle = self.owner.battle
  local enemys = battle:getEnemys(self.owner)
  local targets = {}
  for _, enemy in ipairs(enemys) do
    if not enemy.leader then
      table.insert(targets, enemy)
    end
  end
  if #targets < 1 then
    return
  end
  local index = math.randomInt(1, #targets)
  local target = targets[index]
  if target:hasBuff(200) then
    local buffData = buffDataSet[value]
    for _, buff in ipairs(target.buffTypes[200]) do
      local buffValues = buff.effectValue:toArray("=", true)
      for _, typ in ipairs(buffValues) do
        if buffData.type == typ then
          return
        end
      end
    end
  end
  targets[index]:addBuff({
    buffId = value,
    releaser = self.owner
  })
end

function PassiveSkill:effect64(params, value)
  if not self.owner:hasBuff(62) then
    self.owner:addBuff({
      buffId = value,
      releaser = self.owner
    })
    return
  end
  for _, buff in ipairs(self.owner.buffTypes[62]) do
    if buff.id == value then
      buff:effect()
    end
  end
end

function PassiveSkill:effect65(params, value)
  local skillId = value
  self.owner:addPassiveSkill(skillId)
end

function PassiveSkill:effect66(params, value)
  if not params.hurtValue then
    print("PassiveSkill effect66 do not have enough params", self.id, value)
    return
  end
  local hurtValue = params.hurtValue
  if hurtValue ~= hurtValue then
    hurtValue = 1
  end
  if hurtValue <= 0 then
    return
  end
  local players = self.owner.battle:getPlayers(self.owner.side)
  local player = players[math.randomInt(1, #players)]
  if not player.buffIds[value] or player.buffIds[value].num == 0 then
    player:addBuff({
      buffId = value,
      releaser = self.owner,
      hurtValue = params.hurtValue
    })
    return
  end
  for _, buff in ipairs(player.buffTypes[64]) do
    if buff.id == value then
      buff:sheildChange({
        hurtValue = params.hurtValue
      })
    end
  end
end

function PassiveSkill:effect67(params, value)
  if not params.hurtValue then
    print("PassiveSkill effect67 do not have enough params", self.id, value)
    return
  end
  local hurtValue = params.hurtValue
  if hurtValue ~= hurtValue then
    hurtValue = 1
  end
  if hurtValue <= 0 then
    return
  end
  local players = self.owner.battle:getPlayers(self.owner.side)
  local player = players[math.randomInt(1, #players)]
  player:addBuff({
    buffId = value,
    releaser = self.owner,
    hurtValue = params.hurtValue
  })
end

function PassiveSkill:effect68(params, value)
  local releaser = params.hurtParams.releaser
  local hurtValue = params.hurtParams.hurtValue
  if not (releaser and hurtValue) or hurtValue <= 0 then
    print("PassiveSkill effect68 do not have enough params", self.id, value)
    return
  end
  if value < 100 then
    return
  end
  params.hurtParams.shieldHurt = value / 100 - 1
end

function PassiveSkill:effect69(params, value)
  local battle = self.owner.battle
  local players = battle:getPlayers(self.owner.side)
  local targets = {}
  if #players <= 3 then
    targets = players
  else
    local choose = {}
    while #targets < 3 do
      local index = math.randomInt(1, #players)
      if choose[index] ~= 1 then
        table.insert(targets, players[index])
        choose[index] = 1
      end
    end
  end
  for _, player in ipairs(targets) do
    player:addBuff({
      buffId = value,
      releaser = self.owner
    })
  end
end

local call = {
  [1] = function(self, value, ratio)
    local function packAttrInfo(value, caller, ratio)
      local unitData = UnitCsv[value]
      
      local player = {}
      player.type = value
      player.side = caller.side
      player.leader = false
      player.hp = caller.fullHp * ratio / 100
      player.phyDef = caller.phyDef * ratio / 100
      player.hit = caller.hit * ratio / 100
      player.caller = caller
      player.slave = true
      return player
    end
    
    local caller = self.owner
    local battle = self.owner.battle
    local calleeInfo = packAttrInfo(value, caller, ratio)
    local SpritePlayer = require("app.views.battle.SpritePlayer")
    local callee = SpritePlayer:create(calleeInfo)
    callee.map = caller.map
    callee.mapLayers = caller.mapLayers
    battle:addCalleePlayer(callee)
    callee.displayNode:addTo(caller.map)
    return callee
  end
}

function PassiveSkill:effect70(params, value)
  local ratio = value.ratio or globalCsv.slaveHpPercent2
  local callee = call[1](self, value.unitType, ratio)
  callee.slaveDistance = globalCsv.callSlaveDistance
  callee.position.y = self.owner.position.y + callee.slaveDistance / 2
  callee.xPos = self.owner.xPos + callee.slaveDistance
  callee.position.x = callee.xPos
  callee:onUpdatePosition()
end

function PassiveSkill:effect71(params, value)
  local ratio = value.ratio or globalCsv.slaveHpPercent2
  local callee = call[1](self, value.unitType, ratio)
  callee.slaveDistance = globalCsv.callSlaveDistance
  callee.position.y = self.owner.position.y - callee.slaveDistance / 2
  callee.xPos = self.owner.xPos + callee.slaveDistance
  callee.position.x = callee.xPos
  callee:onUpdatePosition()
end

function PassiveSkill:effect72(params, value)
  local ratio = value.ratio or globalCsv.slaveHpPercent
  local callee = call[1](self, value.unitType, ratio)
  callee.slaveDistance = -globalCsv.callSlaveDistance
  callee.position.y = self.owner.position.y - callee.slaveDistance / 2
  callee.xPos = self.owner.xPos + callee.slaveDistance
  callee.position.x = callee.xPos
  callee:onUpdatePosition()
end

function PassiveSkill:effect73(params, value)
  local ratio = value.ratio or globalCsv.slaveHpPercent
  local callee = call[1](self, value.unitType, ratio)
  callee.slaveDistance = -globalCsv.callSlaveDistance
  callee.position.y = self.owner.position.y + callee.slaveDistance / 2
  callee.xPos = self.owner.xPos + callee.slaveDistance
  callee.position.x = callee.xPos
  callee:onUpdatePosition()
end

function PassiveSkill:effect74(params, value)
  local skillId = value
  local enemys = self.owner.battle:getPlayers(self.owner.otherSide)
  for _, enemy in pairs(enemys) do
    if not enemy:checkPassiveSkill(skillId) and not enemy:hasBuff(185) then
      enemy:addPassiveSkill(skillId)
    end
  end
end

function PassiveSkill:effect75(params, value)
  local skillId = value.skillId
  local enemys = self.owner.battle:getPlayers(self.owner.otherSide)
  for _, enemy in pairs(enemys) do
    if not enemy:hasBuff(185) then
      if not enemy:checkSubPassiveSkill(skillId, self.owner) then
        enemy:addSubPassiveSkill(skillId, self.owner)
      elseif enemy:checkSubPassiveSkill(skillId, self.owner) and value.skillType == 0 then
        enemy:addSubPassiveSkill(skillId, self.owner)
      end
    end
  end
end

function PassiveSkill:effect91(params, value)
  self.owner:addBuff({
    buffId = value,
    releaser = self.owner
  })
end

function PassiveSkill:effect92(params, value)
  local skillId = value
  local players = self.owner.battle:getPlayers(self.owner.side)
  for _, player in ipairs(players) do
    if not player:hasBuff(186) then
      player:addPassiveSkill(skillId)
    end
  end
end

function PassiveSkill:effect93(params, value)
  local players = self.owner.battle:getPlayers(self.owner.side)
  for _, player in ipairs(players) do
    player:addBuff({
      buffId = value,
      releaser = self.owner
    })
  end
end

function PassiveSkill:effect94(params, value)
  if not params.origin then
    print("PassiveSkill effect94 do not have origin target", self.id, value)
    return
  end
  params.origin:addBuff({
    buffId = value,
    releaser = self.owner
  })
end

function PassiveSkill:effect96(params, value)
  local skillId = self.owner.specialSkill.specialId
  if not skillId then
    return
  end
  local specialSkillId = SkillSpecialSet[skillId][self.owner.specialLevel].skillId
  self.owner:releaseSkillById(specialSkillId, true)
end

function PassiveSkill:effect97(params, value)
  if not params.origin then
    print("PassiveSkill effect97 do not have origin target", self.id, value)
    return
  end
  params.origin:addBuff({
    buffId = value,
    releaser = self.owner
  })
  params.origin:addBuffFromCache()
end

function PassiveSkill:effect104(params, value)
  self.owner:addBuff({
    buffId = value,
    releaser = self.owner
  })
end

function PassiveSkill:effect105(params, value)
  self.owner:releaseSkillById(value, false)
end

function PassiveSkill:effect106(params, value)
  local players = self.owner.battle:getPlayers(self.owner.otherSide)
  for _, player in ipairs(players) do
    player:addBuff({
      buffId = value,
      releaser = self.owner
    })
  end
end

function PassiveSkill:effect110(params, value)
  local battle = self.owner.battle
  local enemys = battle:getEnemys(self.owner)
  if #enemys < 1 then
    return
  end
  table.sort(enemys, function(tA, tB)
    return tB.hp > tA.hp
  end)
  local target = enemys[1]
  if target:hasBuff(200) then
    local buffData = buffDataSet[value]
    for _, buff in ipairs(target.buffTypes[200]) do
      local buffValues = buff.effectValue:toArray("=", true)
      for _, typ in ipairs(buffValues) do
        if buffData.type == typ then
          return
        end
      end
    end
  end
  target:addBuff({
    buffId = value,
    releaser = self.owner
  })
end

function PassiveSkill:effect112(params, value)
  local battle = self.owner.battle
  for _, player in ipairs(battle:getTeamers(self.owner)) do
    if player:hasBuffById(tonumber(value.cbuffId)) then
      player:addBuff({
        buffId = value.abuffId,
        releaser = self.owner
      })
    end
  end
end

function PassiveSkill:effect113(params, value)
  local battle = self.owner.battle
  print("effect113:", value.cbuffId, value.abuffId)
  for _, player in ipairs(battle:getEnemys(self.owner)) do
    if player:hasBuffById(tonumber(value.cbuffId)) then
      player:addBuff({
        buffId = value.abuffId,
        releaser = self.owner
      })
    end
  end
end

function PassiveSkill:effect114(params, value)
  local battle = self.owner.battle
  if self.owner:hasBuffById(tonumber(value.cbuffId)) then
    self.owner:addBuff({
      buffId = value.abuffId,
      releaser = self.owner
    })
  end
end

function PassiveSkill:effect115(params, value)
  local battle = self.owner.battle
  local players = battle:getPlayers(self.owner.side)
  local targets = {}
  if #players <= 1 then
    targets = players
  else
    local choose = {}
    while #targets < 1 do
      local index = math.randomInt(1, #players)
      if choose[index] ~= 1 then
        table.insert(targets, players[index])
        choose[index] = 1
      end
    end
  end
  for _, player in ipairs(targets) do
    player:addBuff({
      buffId = value,
      releaser = self.owner
    })
  end
end

function PassiveSkill:effect116(params, value)
  self.owner:addBuff({
    buffId = value,
    releaser = self.owner
  })
  local battle = self.owner.battle
  for _, player in ipairs(battle:getTeamers(self.owner)) do
    player:addBuff({
      buffId = value,
      releaser = self.owner
    })
  end
end

function PassiveSkill:effect117(params, value)
  local battle = self.owner.battle
  local enemys = battle:getEnemys(self.owner)
  for _, enemy in ipairs(enemys) do
    if enemy.type == value.heroType then
      local target = enemy
      if target:hasBuff(200) then
        local buffData = buffDataSet[value]
        for _, buff in ipairs(target.buffTypes[200]) do
          local buffValues = buff.effectValue:toArray("=", true)
          for _, typ in ipairs(buffValues) do
            if buffData.type == typ then
              return
            end
          end
        end
      end
      enemy:addBuff({
        buffId = value.abuffId,
        releaser = self.owner
      })
    end
  end
end

function PassiveSkill:effect118(params, value)
  local battle = self.owner.battle
  for _, player in ipairs(battle:getTeamers(self.owner)) do
    if player.unit.profession == tonumber(value.professionValue) then
      player:addBuff({
        buffId = value.abuffId,
        releaser = self.owner
      })
    end
  end
end

function PassiveSkill:effect119(params, value)
  local battle = self.owner.battle
  for _, player in ipairs(battle:getEnemys(self.owner)) do
    if player:hasBuff(190) then
      local buffData = buffDataSet[value]
      for _, buff in ipairs(player.buffTypes[190]) do
        print("buff.effectValue 119 buff190:", buff.effectValue, value)
        local buffValues = buff.effectValue:toArray("=", true)
        for _, type in ipairs(buffValues) do
          if buffData.type == type then
            return
          end
        end
      end
    end
    if player.unit.profession == tonumber(value.professionValue) then
      player:addBuff({
        buffId = value.abuffId,
        releaser = self.owner
      })
    end
  end
end

function PassiveSkill:effect120(params, value)
  local battle = self.owner.battle
  for _, player in ipairs(battle:getTeamers(self.owner)) do
    if player.unit.profession == tonumber(value.professionValue) and not player:hasBuff(186) then
      player:addPassiveSkill(value.abuffId)
    end
  end
end

function PassiveSkill:effect121(params, value)
  local battle = self.owner.battle
  for _, player in ipairs(battle:getEnemys(self.owner)) do
    if player.unit.profession == tonumber(value.professionValue) and not player:hasBuff(185) then
      player:addPassiveSkill(value.abuffId)
    end
  end
end

function PassiveSkill:effect122(params, value)
  if value.professionValue == self.owner.unit.profession then
    self.owner:addBuff({
      buffId = value.abuffId,
      releaser = self.owner
    })
  end
end

function PassiveSkill:effect123(params, value)
  local battle = self.owner.battle
  local players = battle:getTeamers(self.owner)
  local targets = {}
  for _, player in ipairs(players) do
    if value.proId1 == player.unit.profession or value.proId2 == player.unit.profession then
      table.insert(targets, player)
    end
  end
  if #targets < 1 then
    return
  end
  local index = math.randomInt(1, #targets)
  if tonumber(value.abuffId1) > 0 then
    targets[index]:addBuff({
      buffId = value.abuffId1,
      releaser = self.owner
    })
  end
  if 0 < tonumber(value.abuffId2) then
    targets[index]:addBuff({
      buffId = value.abuffId2,
      releaser = self.owner
    })
  end
  if 0 < tonumber(value.abuffId3) then
    targets[index]:addBuff({
      buffId = value.abuffId3,
      releaser = self.owner
    })
  end
  if 0 < tonumber(value.abuffId4) then
    targets[index]:addBuff({
      buffId = value.abuffId4,
      releaser = self.owner
    })
  end
end

function PassiveSkill:effect124(params, value)
  local battle = self.owner.battle
  local players = battle:getTeamers(self.owner)
  local targets = {}
  for _, player in ipairs(players) do
    if value.proId1 == player.unit.profession or value.proId2 == player.unit.profession then
      table.insert(targets, player)
    end
  end
  if #targets < 1 then
    return
  end
  local index = math.randomInt(1, #targets)
  if not targets[index]:hasBuff(186) then
    if tonumber(value.abuffId1) > 0 then
      targets[index]:addPassiveSkill(value.abuffId1)
    end
    if 0 < tonumber(value.abuffId2) then
      targets[index]:addPassiveSkill(value.abuffId2)
    end
    if 0 < tonumber(value.abuffId3) then
      targets[index]:addPassiveSkill(value.abuffId3)
    end
    if 0 < tonumber(value.abuffId4) then
      targets[index]:addPassiveSkill(value.abuffId4)
    end
  end
end

function PassiveSkill:effect125(params, value)
  local battle = self.owner.battle
  local players = battle:getEnemys(self.owner)
  local targets = {}
  for _, player in ipairs(players) do
    if value.proId1 == player.unit.profession or value.proId2 == player.unit.profession then
      table.insert(targets, player)
    end
  end
  if #targets < 1 then
    return
  end
  local index = math.randomInt(1, #targets)
  if tonumber(value.abuffId1) > 0 then
    targets[index]:addBuff({
      buffId = value.abuffId1,
      releaser = self.owner
    })
  end
  if 0 < tonumber(value.abuffId2) then
    targets[index]:addBuff({
      buffId = value.abuffId2,
      releaser = self.owner
    })
  end
  if 0 < tonumber(value.abuffId3) then
    targets[index]:addBuff({
      buffId = value.abuffId3,
      releaser = self.owner
    })
  end
  if 0 < tonumber(value.abuffId4) then
    targets[index]:addBuff({
      buffId = value.abuffId4,
      releaser = self.owner
    })
  end
end

function PassiveSkill:effect126(params, value)
  local battle = self.owner.battle
  local players = battle:getEnemys(self.owner)
  local targets = {}
  for _, player in ipairs(players) do
    if value.proId1 == player.unit.profession or value.proId2 == player.unit.profession then
      table.insert(targets, player)
    end
  end
  if #targets < 1 then
    return
  end
  local index = math.randomInt(1, #targets)
  if not targets[index]:hasBuff(185) then
    if tonumber(value.abuffId1) > 0 then
      targets[index]:addPassiveSkill(value.abuffId1)
    end
    if 0 < tonumber(value.abuffId2) then
      targets[index]:addPassiveSkill(value.abuffId2)
    end
    if 0 < tonumber(value.abuffId3) then
      targets[index]:addPassiveSkill(value.abuffId3)
    end
    if 0 < tonumber(value.abuffId4) then
      targets[index]:addPassiveSkill(value.abuffId4)
    end
  end
end

function PassiveSkill:effect127(params, value)
  local battle = self.owner.battle
  local players = battle:getPlayers(self.owner.side)
  for _, player in ipairs(players) do
    if player.type == value.heroType then
      player:addBuff({
        buffId = value.abuffId,
        releaser = self.owner
      })
    end
  end
end

function PassiveSkill:effect128(params, value)
  local buffId = tonumber(value)
  if self.owner:hasBuffById(buffId) then
    for _, buff in ipairs(self.owner.buffIds[buffId].buffs) do
      buff:endBuff()
      return
    end
  end
end

function PassiveSkill:effect129(params, value)
  local battle = self.owner.battle
  local players = battle:getTeamers(self.owner)
  local targets = {}
  if #players <= 1 then
    targets = players
  else
    local choose = {}
    while #targets < 1 do
      local index = math.randomInt(1, #players)
      if choose[index] ~= 1 then
        table.insert(targets, players[index])
        choose[index] = 1
      end
    end
  end
  for _, player in ipairs(targets) do
    player:addBuff({
      buffId = value,
      releaser = self.owner
    })
  end
end

function PassiveSkill:effect130(params, value)
  local battle = self.owner.battle
  local teammates = battle:getTeamers(self.owner)
  local enemies = battle:getEnemys(self.owner)
  local allUnits = {}
  for _, unit in ipairs(teammates) do
    if unit ~= self.owner then
      table.insert(allUnits, unit)
    end
  end
  for _, unit in ipairs(enemies) do
    table.insert(allUnits, unit)
  end
  if #allUnits < 1 then
    return
  end
  local randomIndex = math.randomInt(1, #allUnits)
  local target = allUnits[randomIndex]
  target:addBuff({
    buffId = value,
    releaser = self.owner
  })
end

function PassiveSkill:effect131(params, value)
  local battle = self.owner.battle
  local players = battle:getTeamers(self.owner)
  local targets = {}
  local otherPlayers = {}
  for _, player in ipairs(players) do
    if player ~= self.owner then
      table.insert(otherPlayers, player)
    end
  end
  if #otherPlayers == 0 then
    table.insert(targets, self.owner)
  else
    local index = math.randomInt(1, #otherPlayers)
    table.insert(targets, otherPlayers[index])
  end
  for _, player in ipairs(targets) do
    player:addBuff({
      buffId = value,
      releaser = self.owner
    })
  end
end

return PassiveSkill
