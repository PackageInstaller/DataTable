local buffDataSet = require("csvdata.buff")
local skillBlockSet = require("csvdata.skill_block")
local skillSpecialSet = require("csvdata.skill_special")
local skillAwakeSet = require("csvdata.skill_awake")
local specialRateSet = require("csvdata.special_rate")
local innateCsv = require("csvdata.innate")
local Buff = import(".Buff")
local PassiveSkill = import(".PassiveSkill")
local stealBuffTypes = {
  [3] = true,
  [30] = true,
  [31] = true,
  [32] = true,
  [34] = true,
  [35] = true,
  [36] = true
}
local PlayerPlugin = {}

function PlayerPlugin.bind(Player)
  function Player:initSpecialSkills()
    if self.specialId == 0 then
      return
    end
    if self.skillOrders then
      return
    end
    local skillData = skillSpecialSet[self.specialId][self.specialLevel]
    local special = {
      specialId = self.specialId,
      mana = skillData.manaCost,
      cd = skillData.coolDown,
      numLimit = skillData.numLimit,
      weight = 100,
      curNum = 0,
      originNum = skillData.numLimit,
      originMana = skillData.manaCost
    }
    for _, effect in ipairs(self.formatEffect) do
      if effect.active then
        if effect.type == 1 then
          special.mana = special.mana + effect.value
        elseif effect.type == 2 then
          special.cd = special.cd * (100 + effect.value) / 100
        elseif effect.type == 3 then
          special.numLimit = special.numLimit + effect.value
        elseif effect.type == 4 then
          special.weight = special.weight * effect.value / 100
        end
      end
    end
    special.mana = math.max(special.mana, 1)
    special.numLimit = math.max(special.numLimit, 1)
    self.specialSkill = special
  end
  
  function Player:resetSpecialSkillNum()
    self.specialSkill.curNum = 0
  end
  
  function Player:initPassiveSkills()
    for _, effect in ipairs(self.formatEffect) do
      if effect.active and effect.type == 7 and effect.unitType == self.unit.type then
        self:addPassiveSkill(effect.value)
      end
    end
    if self.skillInfo.passiveSkills then
      for _, skillId in ipairs(self.skillInfo.passiveSkills) do
        self:addPassiveSkill(skillId)
      end
    end
    if self.blockId == 0 then
      return
    end
    local skills = {
      {
        id = self.blockId,
        firstBlock = true
      }
    }
    for slot = 2, 3 do
      local blockId = self["blockId" .. slot]
      if 0 < blockId then
        table.insert(skills, {id = blockId, firstBlock = false})
      end
    end
    for _, blockData in ipairs(skills) do
      local skillData = skillBlockSet[blockData.id][self.blockLevel]
      self:addPassiveSkill(skillData.skillId, blockData.firstBlock)
    end
  end
  
  function Player:initAwakeSkills()
    if not (self.awakeId and self.awakeId ~= 0 and self.awakeLevel) or self.awakeLevel == 0 then
      return
    end
    local skillData = skillAwakeSet[self.awakeId][self.awakeLevel]
    self:addPassiveSkill(skillData.skillId, true)
  end
  
  function Player:initInnateSkills()
    if not (self.characteristicId and self.characteristicId ~= 0 and self.characteristicLv) or self.characteristicLv == 0 then
    else
      local skillData = skillBlockSet[self.characteristicId][self.characteristicLv]
      self:addPassiveSkill(skillData.skillId, true)
    end
    if not (self.dreamId and self.dreamId ~= 0 and self.dreamLv) or self.dreamLv == 0 then
    else
      local skillData = skillBlockSet[self.dreamId][self.dreamLv]
      self:addPassiveSkill(skillData.skillId, true)
    end
  end
  
  function Player:addPassiveSkill(skillId, firstBlock)
    local passiveSkill = PassiveSkill.new({
      id = skillId,
      owner = self,
      firstBlock = firstBlock
    })
    local type = passiveSkill.csvData.condition
    if not self.passiveSkills[type] then
      self.passiveSkills[type] = {}
    end
    table.insert(self.passiveSkills[type], {
      passiveSkill = passiveSkill,
      value = passiveSkill.csvData.value,
      probability = passiveSkill.csvData.probability
    })
  end
  
  function Player:addSubPassiveSkill(skillId, parent)
    local passiveSkill = PassiveSkill.new({
      id = skillId,
      owner = self,
      parent = parent
    })
    local type = passiveSkill.csvData.condition
    if not self.passiveSkills[type] then
      self.passiveSkills[type] = {}
    end
    table.insert(self.passiveSkills[type], {
      passiveSkill = passiveSkill,
      value = passiveSkill.csvData.value,
      probability = passiveSkill.csvData.probability
    })
  end
  
  function Player:checkPassiveSkill(skillId)
    for _, skills in pairs(self.passiveSkills) do
      for _, skill in ipairs(skills) do
        if skill.id == skillId then
          return true
        end
      end
    end
  end
  
  function Player:checkSubPassiveSkill(skillId, owner)
    for _, skills in pairs(self.passiveSkills) do
      for _, skill in ipairs(skills) do
        if skill.id == skillId and skill.parentPlayer == owner then
          return true
        end
      end
    end
  end
  
  function Player:resetPassiveSkillCD()
    local resetTypes = {71}
    for _, skillType in pairs(resetTypes) do
      if not self.passiveSkills[skillType] then
        return
      end
      for _, skill in ipairs(self.passiveSkills[skillType]) do
        skill.passiveSkill:reset()
      end
    end
  end
  
  function Player:reducePassiveSkillCD(skillId, number)
    for _, skills in pairs(self.passiveSkills) do
      for _, skill in ipairs(skills) do
        if skill.passiveSkill.id == skillId then
          skill.passiveSkill.cd = skill.passiveSkill.cd - number
          if skill.passiveSkill.cd < 0 then
            skill.passiveSkill.cd = 0
          end
        end
      end
    end
  end
  
  function Player:resetAttributes()
    self.curAtk = self:getProperty("atk")
    self.curPhyDef = self:getProperty("phyDef")
    self.curHit = self:getProperty("hit")
    self.curMiss = self:getProperty("miss")
    self.curCrit = self:getProperty("crit")
    self.curCritHurt = self:getProperty("critHurt")
    self.curResist = self.resist
    self.curAtkSpeed = self:getProperty("atkSpeed")
    self.curTrueAtk = self:getProperty("trueAtk")
    self.curAtkResist = self:getProperty("atkResist")
    self.curHitResist = self:getProperty("hitResist")
    self.curCritResist = self:getProperty("critResist")
    self.curCritHurtResist = self:getProperty("critHurtResist")
    self.curTeBao = self:getProperty("tebao")
    self.curTeKang = self:getProperty("tekang")
    self.curAtkInterval = self.proData.attackInterval / self.curAtkSpeed
    if not self.battle then
      return
    end
  end
  
  function Player:changeAttribute(params)
    local attrName = "cur" .. params.name
    local ratio = 1
    if params.value > 0 and self:hasBuff(112) then
      for _, _buff in pairs(self.buffTypes[112]) do
        ratio = ratio + _buff:effect()
      end
    end
    self[attrName] = self[attrName] + params.value * ratio
    if params.name == "Atk" or params.name == "PhyDef" then
      self[attrName] = math.max(self[attrName], 1)
    else
      self[attrName] = math.max(self[attrName], 0)
    end
    if attrName == "curAtkSpeed" then
      self.curAtkInterval = self.proData.attackInterval / self.curAtkSpeed
    end
  end
  
  function Player:getBaseAttribute(id)
    local attrName = AttsEnumEx[id]
    if attrName == "hp" then
      attrName = "fullHp"
    end
    return self:getProperty(attrName) or 0
  end
  
  function Player:onPhaseBegin()
    self:triggerPassiveSkill({
      extra = {releaser = self},
      condition = PassiveSkill.CONDITION_TEAMER_START
    })
    self:resetPassiveSkillCD()
  end
  
  function Player:battleUpdate(dt)
    self:addBuffFromCache()
    if self.attrDirty then
      self:resetAttributes()
      for type, buffs in pairs(self.buffTypes) do
        for buffIndex, buff in ipairs(buffs) do
          if not buff.hasFinished then
            buff:attrChange()
          end
        end
      end
      self.attrDirty = false
    end
    for type, buffs in pairs(self.buffTypes) do
      local buffIndex = 1
      while buffIndex <= #buffs do
        buffs[buffIndex]:update(dt)
        if buffs[buffIndex].hasFinished then
          table.remove(buffs, buffIndex)
        else
          buffIndex = buffIndex + 1
        end
      end
      if #buffs == 0 then
        self.buffTypes[type] = nil
      end
    end
    self:triggerPassiveSkill({
      condition = PassiveSkill.CONDITION_ACTIVE_WITH_TIME
    })
    self:triggerPassiveSkill({
      condition = PassiveSkill.CONDITION_ACTIVE_WITH_DELAY,
      triggerFunc = function(value)
        return self.battle:getTime() > tonumber(value)
      end
    })
    self:triggerPassiveSkill({
      condition = PassiveSkill.CONDITION_TEAMER_START_WITH_DELAY,
      triggerFunc = function(value)
        return self.battle:getPhaseTime() > tonumber(value)
      end
    })
    self:triggerPassiveSkill({
      extra = {releaser = self},
      condition = PassiveSkill.CONDITION_ENEMY_PROFESSION,
      triggerFunc = function(value, skill)
        if value == "" then
          return true
        end
        for _, enemy in ipairs(self.battle:getPlayers(self.otherSide)) do
          if skill.recordValue[enemy.unit.profession] then
            return true
          end
        end
      end
    })
    self:triggerPassiveSkill({
      extra = {releaser = self},
      condition = PassiveSkill.CONDITION_NO_TEAMER,
      triggerFunc = function(value, skill)
        if value == "" then
          return
        end
        local teamers = self.battle:getTeamers(self)
        if not next(teamers) then
          return true
        end
        skill.cd = tonumber(value)
      end
    })
    self:triggerPassiveSkill({
      condition = PassiveSkill.CONDITION_BATTLE_CHECK_HP,
      triggerFunc = function(value)
        if value == "" then
          return true
        end
        value = tonumber(value)
        local percent = self.hp * 100 / self.fullHp
        return value > percent
      end
    })
  end
  
  function Player:addBuff(params)
    local buffSet = buffDataSet[params.buffId]
    if not params.steal and buffSet.replace == 0 and 0 < buffSet.mutex and self:hasBuff(buffSet.type) then
      for _, buff in pairs(self.buffTypes[buffSet.type]) do
        if buff.csvData.mutex == buffSet.mutex then
          return
        end
      end
    end
    if self:hasBuff(193) and buffSet.debuff == 1 then
      for _, buff193 in ipairs(self.buffTypes[193]) do
        if buff193.effectValue == 0 and 0 >= buff193.otherBuffTime then
          buff193.effectValue1 = tostring(buff193.effectValue1)
          for _, _buffId in ipairs(buff193.effectValue1:toArray("=", true)) do
            buff193.releaser:addBuff({buffId = _buffId, releaser = self})
          end
          buff193.otherBuffTime = buff193.effectValue2
        elseif buff193.effectValue == 1 and 0 >= buff193.otherBuffTime then
          buff193.effectValue1 = tostring(buff193.effectValue1)
          for _, _buffId in ipairs(buff193.effectValue1:toArray("=", true)) do
            self:addBuff({buffId = _buffId, releaser = self})
          end
          buff193.otherBuffTime = buff193.effectValue2
        end
      end
      return
    end
    if self:hasBuff(181) then
      local canGet = false
      if self.side ~= params.releaser.side then
        for _, buff in ipairs(self.buffTypes[181]) do
          local buffList = buff.effectValue:toArray("=", true)
          for i = 1, #buffList do
            if buffList[i] == buffSet.type then
              canGet = true
              break
            end
          end
        end
        if not canGet then
          return
        end
      end
    end
    if self:hasBuff(182) then
      local canGet = false
      if self.side == params.releaser.side and self.id ~= params.releaser.id then
        for _, buff in ipairs(self.buffTypes[182]) do
          local buffList = buff.effectValue:toArray("=", true)
          for i = 1, #buffList do
            if buffList[i] == buffSet.type then
              canGet = true
              break
            end
          end
        end
        if not canGet then
          return
        end
      end
    end
    if self:hasBuff(183) and self.side ~= params.releaser.side then
      for _, buff in ipairs(self.buffTypes[183]) do
        local deList = buff.effectValue:toArray("=", true)
        local canGet1 = true
        for i = 1, #deList do
          if deList[i] == buffSet.debuff then
            canGet1 = false
            break
          end
        end
        local typeList = buff.effectValue1:toArray("=", true)
        local canGet2 = false
        if not canGet1 then
          for i = 1, #typeList do
            if typeList[i] == buffSet.type then
              canGet2 = true
              break
            end
          end
          if not canGet2 then
            return
          end
        end
      end
    end
    if self:hasBuff(184) and self.side == params.releaser.side and self.id ~= params.releaser.id then
      for _, buff in ipairs(self.buffTypes[184]) do
        local deList = buff.effectValue:toArray("=", true)
        local canGet1 = true
        for i = 1, #deList do
          if deList[i] == buffSet.debuff then
            canGet1 = false
            break
          end
        end
        local typeList = buff.effectValue1:toArray("=", true)
        local canGet2 = false
        if not canGet1 then
          for i = 1, #typeList do
            if typeList[i] == buffSet.type then
              canGet2 = true
              break
            end
          end
          if not canGet2 then
            return
          end
        end
      end
    end
    local invalidBuffs = {}
    for _, enemy in ipairs(self.battle:getPlayers(self.otherSide)) do
      if enemy:hasBuff(131) then
        for _, buff in ipairs(enemy.buffTypes[131]) do
          local buffInvalid = buff:effect()
          for i, buff in pairs(buffInvalid) do
            table.insert(invalidBuffs, buff)
          end
        end
      end
    end
    for i, otherBuff in pairs(invalidBuffs) do
      for key, ourBuff in pairs(self.buffTypes) do
        if otherBuff == key then
          return
        end
      end
    end
    if self:hasBuff(139) and buffSet.debuff == 1 then
      for _, _buff in pairs(self.buffTypes[139]) do
        if _buff.isValid == true then
          local enemys = self.battle:getPlayers(self.otherSide)
          local rand = math.randomInt(1, #enemys)
          for index, enemy in ipairs(enemys) do
            if index == rand then
              _buff:effect()
              enemy:addBuff(params)
              return
            end
          end
        end
      end
    end
    if self:hasBuff(195) and buffSet.debuff == 1 then
      for _, _buff in pairs(self.buffTypes[195]) do
        if _buff.isValid == true then
          local unitList = _buff.effectValue:toArray("=", true)
          local players = self.battle:getPlayers(self.side)
          for _, player in ipairs(players) do
            for _, unitId in ipairs(unitList) do
              if player.unit.type == unitId then
                _buff:effect()
                player:addBuff(params)
                return
              end
            end
          end
        end
      end
    end
    if self:hasBuff(37) and buff ~= 37 and buffSet.debuff == 1 then
      return
    end
    if self:hasBuff(36) and buff ~= 36 and (buffSet.type == 10 or buffSet.type == 11) then
      return
    end
    if self:hasBuff(38) and buff ~= 38 and buffSet.type == 19 then
      return
    end
    if self:hasBuff(175) and buff ~= 175 and buffSet.type == 29 then
      return
    end
    if self:hasBuff(177) and buff ~= 177 and buffSet.type == 3 then
      return
    end
    if self:hasBuff(179) and buff ~= 179 and buffSet.type == 31 and 0 < buffSet.effectValue then
      return
    end
    if self:hasBuff(116) then
      for _, buff in ipairs(self.buffTypes[116]) do
        if buff:effect(buffSet.id) then
          return
        end
      end
    end
    if self:hasBuff(155) then
      for _, buff in ipairs(self.buffTypes[155]) do
        if buff:effect(buffSet.type) then
          return
        end
      end
    end
    if self:hasBuff(120) and buffSet.debuff == -1 then
      return
    end
    if self:hasBuff(199) and self.side ~= params.releaser.side then
      for _, buff in ipairs(self.buffTypes[199]) do
        local idList = buff.effectValue:toArray("=", true)
        local isForbiddenId = false
        for i = 1, #idList do
          if idList[i] == buffSet.debuff then
            isForbiddenId = true
            break
          end
        end
        local typeList = buff.effectValue1:toArray("=", true)
        local isForbiddenType = false
        for i = 1, #typeList do
          if typeList[i] == buffSet.type then
            isForbiddenType = true
            break
          end
        end
        if isForbiddenId and isForbiddenType then
          printInfo("Buff199: 免疫debuff ID=%s, 类型=%s, 玩家=%s", buffSet.debuff, buffSet.type, self.unit.name)
          return
        end
      end
    end
    if self:hasBuff(203) then
      for _, _buff in pairs(self.buffTypes[203]) do
        local effectValue = _buff.effectValue
        local buffValues = effectValue:toArray("=", true)
        for _, _type in ipairs(buffValues) do
          if buffSet.type == _type and self.id ~= params.releaser.id then
            return
          end
        end
      end
    end
    local temp = self.useBuffCacheNum == 1 and self.buffCache or self.buffCache2
    table.insert(temp, params)
  end
  
  function Player:addBuffSilent(params)
    local buffSet = buffDataSet[params.buffId]
    if not buffSet then
      return
    end
    if not params.steal and buffSet.replace == 0 and 0 < buffSet.mutex and self:hasBuff(buffSet.type) then
      for _, buff in pairs(self.buffTypes[buffSet.type]) do
        if buff.csvData.mutex == buffSet.mutex then
          return
        end
      end
    end
    local buff = Buff:create({
      id = params.buffId,
      player = self,
      releaser = params.releaser,
      steal = params.steal or false
    })
    if not self.buffTypes[buff.csvData.type] then
      self.buffTypes[buff.csvData.type] = {}
    end
    table.insert(self.buffTypes[buff.csvData.type], buff)
    if not self.buffIds[buff.id] then
      self.buffIds[buff.id] = {
        num = 0,
        buffs = {}
      }
    end
    self.buffIds[buff.id].timestamp = game:nowTime()
    table.insert(self.buffIds[buff.id].buffs, buff)
    self.buffIds[buff.id].num = self.buffIds[buff.id].num + 1
    printInfo("静默添加buff %d", params.buffId)
    buff:beginEffect()
  end
  
  function Player:addBuffFromCache()
    local debuffPassive = false
    local temp = self.useBuffCacheNum == 1 and self.buffCache or self.buffCache2
    self.useBuffCacheNum = 3 - self.useBuffCacheNum
    for index, params in ipairs(temp) do
      params.id = params.buffId
      params.player = self
      local buffSet = buffDataSet[params.id]
      local addBuff = true
      if not params.steal and self.buffTypes[buffSet.type] then
        if buffSet.replace == 0 and 0 < buffSet.mutex then
          for _, _buff in pairs(self.buffTypes[buffSet.type]) do
            if _buff.csvData.mutex == buffSet.mutex then
              addBuff = false
              break
            end
          end
        elseif buffSet.replace == 1 then
          for _, _buff in pairs(self.buffTypes[buffSet.type]) do
            if buffSet.id == _buff.csvData.id then
              _buff:endBuff()
            end
          end
        elseif buffSet.replace == 2 then
          if buffSet.type == 3 then
            for _, _buff in pairs(self.buffTypes[buffSet.type]) do
              if _buff.csvData.effectValue3 == buffSet.effectValue3 then
                addBuff = false
                break
              end
            end
          else
            addBuff = false
          end
        end
      end
      if 0 < buffSet.levelBuff and self:hasBuffById(params.id) then
        for _, _buff in ipairs(self.buffIds[params.id].buffs) do
          _buff:levelChange(params)
        end
        addBuff = false
      end
      if addBuff and not params.steal and params.releaser and stealBuffTypes[buffSet.type] and not self:hasBuff(63) and buffSet.debuff ~= 1 and 0 < buffSet.keepTime then
        for _, enemy in ipairs(self.battle:getPlayers(self.otherSide)) do
          enemy:triggerPassiveSkill({
            condition = PassiveSkill.CONDITION_ENEMY_ADD_BUFF_SPECIAL,
            triggerFunc = function(value, skill)
              if value == "" then
                return true
              end
              if not skill.recordValue then
                return
              end
              return skill.recordValue[self.proData.id]
            end,
            extra = {
              origin = {
                id = params.id,
                releaser = params.releaser
              }
            },
            callback = function()
              addBuff = false
            end
          })
        end
      end
      if addBuff then
        local buff = Buff:create(params)
        if not self.buffTypes[buff.csvData.type] then
          self.buffTypes[buff.csvData.type] = {}
        end
        table.insert(self.buffTypes[buff.csvData.type], buff)
        if not self.buffIds[buff.id] then
          self.buffIds[buff.id] = {
            num = 0,
            buffs = {}
          }
        end
        self.buffIds[buff.id].timestamp = game:nowTime()
        table.insert(self.buffIds[buff.id].buffs, buff)
        self.buffIds[buff.id].num = self.buffIds[buff.id].num + 1
        if self:hasBuff(191) then
          for _, _buff in pairs(self.buffTypes[191]) do
            _buff.effectValue2 = tostring(_buff.effectValue2)
            for _, _buffType in ipairs(_buff.effectValue2:toArray("=", true)) do
              for _, subBuff in pairs(self.buffTypes[_buffType] or {}) do
                if _buff.effectValue1 == subBuff.csvData.debuff then
                  subBuff.leftTime = subBuff.leftTime * (1 + _buff.effectValue / 100)
                end
              end
            end
          end
        end
        if self:hasBuff(188) then
          local debuffTime, buffTime = 0, 0
          for _, _buff in pairs(self.buffTypes[188]) do
            if _buff.effectValue1 == 1 then
              debuffTime = debuffTime + buff.leftTime * _buff.effectValue / 100
            elseif _buff.effectValue1 == -1 then
              buffTime = buffTime + buff.leftTime * _buff.effectValue / 100
            end
          end
          if buff.csvData.debuff == 1 then
            buff.leftTime = buff.leftTime + debuffTime
          elseif buff.csvData.debuff == -1 then
            buff.leftTime = buff.leftTime + buffTime
          end
        end
        buff:beginEffect()
        self:dispatchEvent({
          name = "addBuff",
          buffId = buff.id
        })
        if buff.csvData.type ~= 56 and not params.steal then
          self:triggerPassiveSkill({
            condition = PassiveSkill.CONDITION_SELF_ADD_BUFF
          })
          self:triggerPassiveSkill({
            condition = PassiveSkill.CONDITION_SELF_ADD_BUFF_BY_ID,
            triggerFunc = function(value, skill)
              if value == "" then
                return
              end
              return tonumber(buff.id) == tonumber(value)
            end
          })
          self:triggerPassiveSkill({
            condition = PassiveSkill.CONDITION_SELF_HAS_BUFFS,
            triggerFunc = function(value, skill)
              if value == "" then
                return
              end
              local buffValue = value:toArray("=", true)
              if self:hasBuffById(buffValue[1]) then
                return self.buffIds[buffValue[1]].num >= buffValue[2]
              end
              return
            end
          })
          self:triggerPassiveSkill({
            condition = PassiveSkill.CONDITION_SELF_HAS_BUFFS_MULTIPLE,
            triggerFunc = function(value, skill)
              if value == "" then
                return
              end
              local buffValue = value:toArray("=", true)
              if self:hasBuffById(buffValue[1]) then
                return self.buffIds[buffValue[1]].num > 0 and self.buffIds[buffValue[1]].num % buffValue[2] == 0
              end
              return
            end
          })
          self:triggerPassiveSkill({
            condition = PassiveSkill.CONDITION_SELF_HAS_BUFFS_EQUIP_NUM,
            triggerFunc = function(value, skill)
              if value == "" then
                return
              end
              local buffValue = value:toArray("=", true)
              if self:hasBuffById(buffValue[1]) then
                return self.buffIds[buffValue[1]].num == buffValue[2]
              end
              return
            end
          })
          self:triggerPassiveSkill({
            condition = PassiveSkill.CONDITION_SELF_ADD_SOMEKIND_BUFF,
            triggerFunc = function(value)
              if value == "" then
                return
              end
              local buffSet = type(value) == "number" and {value} or value:toArray("=", true)
              for _, type in ipairs(buffSet) do
                if buff.csvData.type == type then
                  return true
                end
              end
              return false
            end
          })
          if buff.csvData.debuff == -1 then
            self:triggerPassiveSkill({
              condition = PassiveSkill.CONDITION_SELF_ADD_UPBUFF
            })
            self:triggerPassiveSkill({
              condition = PassiveSkill.CONDITION_SELF_ADD_SPECIAL_BUFF,
              triggerFunc = function(value)
                if value == "" then
                  return
                end
                local buffSet = type(value) == "number" and {value} or value:toArray("=", true)
                for _, type in ipairs(buffSet) do
                  if buff.csvData.type == type then
                    return true
                  end
                end
                return false
              end
            })
            if buff.releaser.side == self.side then
              buff.releaser:triggerPassiveSkill({
                condition = PassiveSkill.CONDITION_TEAMER_ADD_SPECIAL_BUFF_BY_SELF,
                triggerFunc = function(value)
                  if value == "" then
                    return
                  end
                  local buffSet = type(value) == "number" and {value} or value:toArray("=", true)
                  for _, type in ipairs(buffSet) do
                    if buff.csvData.type == type then
                      return true
                    end
                  end
                  return false
                end
              })
            end
          end
          for _, enemy in ipairs(self.battle:getPlayers(self.otherSide)) do
            enemy:triggerPassiveSkill({
              condition = PassiveSkill.CONDITION_ENEMY_ADD_BUFF
            })
            if buff.csvData.debuff == -1 then
              enemy:triggerPassiveSkill({
                condition = PassiveSkill.CONDITION_ENEMY_ADD_UPBUFF
              })
            end
          end
          for _, selfPlayer in ipairs(self.battle:getPlayers(self.side)) do
            selfPlayer:triggerPassiveSkill({
              condition = PassiveSkill.CONDITION_SELF_SIDE_ADD_BUFF_BY_ID,
              triggerFunc = function(value)
                if value == "" then
                  return
                end
                local types = value:toArray("=", true)
                for _, type in ipairs(types) do
                  if type == buff.csvData.type then
                    return true
                  end
                end
                return false
              end
            })
            if buff.csvData.debuff == 1 then
              selfPlayer:triggerPassiveSkill({
                condition = PassiveSkill.CONDITION_SELF_SIDE_ADD_DEBUFF_BY_ID,
                triggerFunc = function(value)
                  if value == "" then
                    return
                  end
                  local types = value:toArray("=", true)
                  for _, type in ipairs(types) do
                    if type == buff.csvData.type then
                      return true
                    end
                  end
                  return false
                end
              })
            end
          end
          for _, teamer in ipairs(self.battle:getTeamers(self)) do
            teamer:triggerPassiveSkill({
              condition = PassiveSkill.CONDITION_TEAMER_ADD_BUFF
            })
            if buff.csvData.debuff ~= 1 then
              teamer:triggerPassiveSkill({
                condition = PassiveSkill.CONDITION_TEAMER_ADD_NOT_DEBUFF
              })
            end
            if buff.csvData.debuff == -1 and buff.releaser and buff.releaser.id == teamer.id then
              buff.releaser:triggerPassiveSkill({
                condition = PassiveSkill.CONDITION_ADD_UPBUFF_TO_TEAMER,
                extra = {origin = self}
              })
            end
          end
          if buff.csvData.debuff == 1 and buff.releaser.side ~= self.side then
            for _, player in ipairs(self.battle:getPlayers(buff.releaser.side)) do
              player:triggerPassiveSkill({
                condition = PassiveSkill.CONDITION_ADD_DEBUFFS_TO_ENEMY
              })
            end
          end
          buff.releaser:triggerPassiveSkill({
            condition = PassiveSkill.CONDITION_ADD_BUFFS_TO_ENEMY,
            triggerFunc = function(value, skill)
              if value == "" then
                return true
              end
              local buffToSkill = value:toTableArray(" ", true)
              for _, toSkill in pairs(buffToSkill) do
                if buff.csvData.id == tonumber(toSkill[1]) then
                  skill.recordValue = toSkill[2]
                  return true
                end
              end
              return false
            end
          })
          buff.releaser:triggerPassiveSkill({
            extra = {origin = self},
            condition = PassiveSkill.CONDITION_ADD_SPECIAL_ID_BUFF,
            triggerFunc = function(value)
              if value == "" then
                return
              end
              local buffidList = value:toArray("=", true)
              for _, buffid in pairs(buffidList) do
                if buff.csvData.id == buffid then
                  return true
                end
              end
              return false
            end
          })
          buff.releaser:triggerPassiveSkill({
            condition = PassiveSkill.CONDITION_ADD_SPECIAL_TYPE_BUFF,
            triggerFunc = function(value)
              if value == "" then
                return
              end
              local buffTypeList = value:toArray("=", true)
              for _, buffType in pairs(buffTypeList) do
                if buff.csvData.type == buffType then
                  return true
                end
              end
              return false
            end
          })
          if buff.csvData.type == 10 or buff.csvData.type == 11 then
            buff.releaser:triggerPassiveSkill({
              condition = PassiveSkill.CONDITION_ADD_CONTROLBUFF_TO_ENEMY
            })
          end
          if buff.csvData.type == 170 then
            self:enterEmptySpecial()
          end
          if buff.csvData.type == 173 then
            self:enterCirtOnce()
          end
          if buff.csvData.type == 174 then
            self:enterMissOnce()
          end
          if buff.csvData.type == 196 then
            self:deadFinalFake()
          end
          if buff.csvData.type == 206 then
            self:enterHurtFake()
          end
        end
        if buff.csvData.debuff == 1 and not debuffPassive then
          self:triggerPassiveSkill({
            condition = PassiveSkill.CONDITION_SELF_ADD_DEBUFF,
            extra = {
              parent = buff.releaser
            }
          })
          for _, enemy in ipairs(self.battle:getPlayers(self.otherSide)) do
            enemy:triggerPassiveSkill({
              condition = PassiveSkill.CONDITION_ENEMY_ADD_DEBUFF
            })
          end
          for _, teamer in ipairs(self.battle:getTeamers(self)) do
            teamer:triggerPassiveSkill({
              condition = PassiveSkill.CONDITION_TEAMER_ADD_DEBUFF,
              extra = {origin = self}
            })
          end
          if buff.releaser then
            buff.releaser:triggerPassiveSkill({
              extra = {origin = self},
              condition = PassiveSkill.CONDITION_ADD_DEBUFF_TO_OTHERS,
              triggerFunc = function(value, skill)
                value = tonumber(value)
                if value == 1 then
                  return true
                end
                if self:hasBuff(value) then
                  for _, buff1 in ipairs(self.buffTypes[value]) do
                    if buff1.releaser.type == skill.owner.unit.type then
                      return true
                    end
                  end
                end
                return false
              end
            })
          end
          printInfo("player %d new debuff11111 %d", self.type, buff.id)
        end
        if buff.csvData.debuff == -1 then
          self:triggerPassiveSkill({
            extra = {origin = self},
            condition = PassiveSkill.CONDITION_ENEMY_ADD_BUFF_TO_SELF,
            triggerFunc = function(value, skill)
              return buff.releaser.side ~= self.side
            end
          })
        end
        printInfo("player %d add buff %d", self.type, buff.id)
      end
    end
    if self.useBuffCacheNum == 2 then
      self.buffCache = {}
    else
      self.buffCache2 = {}
    end
  end
  
  function Player:hasBuff(type)
    local buffs = self.buffTypes[type] or {}
    return 0 < #buffs
  end
  
  function Player:hasBuffNum()
    if not next(self.buffTypes) then
      return
    end
    local count = 0
    for _, buff in pairs(self.buffTypes) do
      for i, value in pairs(buff) do
        if value.csvData.debuff == -1 then
          local buffById = self.buffIds[value.csvData.id]
          local num = 0
          if buffById then
            num = buffById.num or 0
          end
          count = count + num
        end
      end
    end
    return count
  end
  
  function Player:totalBuffs()
    if not next(self.buffIds) then
      return
    end
    return self.buffIds
  end
  
  function Player:hasBuffById(id)
    local buffs = self.buffIds[id]
    local num = 0
    if buffs then
      num = buffs.num or 0
    end
    return 0 < num
  end
  
  function Player:onShieldAdd()
    self:triggerPassiveSkill({
      condition = PassiveSkill.CONDITION_SELF_ADD_SHIELD
    })
    for _, player in ipairs(self.battle:getPlayers(self.side)) do
      player:triggerPassiveSkill({
        condition = PassiveSkill.CONDITION_TEAMER_AND_SELF_ADD_SHIELD
      })
    end
  end
  
  function Player:hasShieldBuff()
    local types, hasType = {
      32,
      64,
      74,
      78
    }, {}
    for _, buff in ipairs(types) do
      if self:hasBuff(buff) then
        table.insert(hasType, buff)
      end
    end
    return hasType
  end
  
  function Player:hasShield()
    if self.shieldValue > 0 then
      return true
    end
  end
  
  function Player:checkTaunt()
    local targets = {}
    if self:hasBuff(24) then
      for _, _buff in pairs(self.buffTypes[24]) do
        table.insert(targets, _buff.releaser)
      end
    end
    return targets
  end
  
  function Player:checkConfusion(targets)
    local leftPlayer = self.battle:getPlayers(SIDE_LEFT)
    local rightPlayer = self.battle:getPlayers(SIDE_RIGHT)
    local allPlayer = {}
    for _, data in pairs(leftPlayer) do
      if data:getState() ~= "Dead" then
        table.insert(allPlayer, data)
      end
    end
    for _, data in pairs(rightPlayer) do
      if data:getState() ~= "Dead" then
        table.insert(allPlayer, data)
      end
    end
    local finalTargets = {}
    for i = 1, #targets do
      local luckyNo = math.randomInt(1, #allPlayer)
      table.insert(finalTargets, allPlayer[luckyNo])
    end
    return finalTargets
  end
  
  function Player:checkCharm(targets)
    local finalTargets = {}
    local leftPlayer = self.battle:getPlayers(SIDE_LEFT)
    local rightPlayer = self.battle:getPlayers(SIDE_RIGHT)
    for _, data in pairs(targets) do
      if data:getState() ~= "Dead" then
        if data.side == SIDE_LEFT then
          local luckyNo = math.randomInt(1, #rightPlayer)
          table.insert(finalTargets, rightPlayer[luckyNo])
        else
          local luckyNo = math.randomInt(1, #leftPlayer)
          table.insert(finalTargets, leftPlayer[luckyNo])
        end
      end
    end
    return finalTargets
  end
  
  function Player:isSpecial(skillId)
    if 20000 < skillId and skillId < 40000 or 200000 < skillId and skillId < 400000 or 2000000 < skillId and skillId < 4000000 then
      return true
    end
    return
  end
  
  function Player:checkReaction(buffId1, buffId2, otherPlayer)
    if self:hasBuff(buffId1) and otherPlayer:hasBuff(buffId2) then
      for _, leftBuff in ipairs(self.buffTypes[buffId1]) do
        local keyNum1 = leftBuff:effect()
        for _, rightBuff in ipairs(otherPlayer.buffTypes[buffId2]) do
          local keyNum2 = rightBuff:effect()
          if keyNum1 == keyNum2 then
            table.insert(self.buffReaction, keyNum1)
            break
          end
        end
      end
    end
  end
  
  function Player:getFinalAtk(player)
    local fixedAtk = player.curTrueAtk ^ 1.2 / (6 + player.curTrueAtk / 5000)
    local atkResist = self.curAtkResist / 2500
    local finalAtk = player.curAtk / (1 + atkResist * 2) + fixedAtk
    return finalAtk
  end
  
  function Player:getHurtValue(hurtParams, skill)
    local player = hurtParams.releaser
    local finalAtk = self:getFinalAtk(player)
    local hurtValue = finalAtk * finalAtk * skill.csvData.hurtPercent / 100 + skill.csvData.hurtConstant
    if skill.csvData.extraHurt ~= "" then
      for id, value in pairs(skill.csvData.extraHurt:toNumMap()) do
        if BuffAtts[id] then
          hurtValue = hurtValue + player["cur" .. BuffAtts[id]] * value / 100
        end
      end
    end
    hurtValue = hurtValue * math.randomInt(80, 120) / 100
    hurtValue = hurtValue * 0.8
    return math.ceil(hurtValue)
  end
  
  function Player:beginHurt(hurtParams, skillHurt)
    if self:getState() == "Dead" then
      return
    end
    local hurtValue = hurtParams.hurtValue
    local hurtTag = hurtParams.hurtTag or "normal"
    local hurtType = hurtParams.hurtType or "normal"
    local hurtBuffId = hurtParams.hurtBuffId or 0
    local skillType = "normal"
    if hurtType == "holycrash" then
      hurtType = "normal"
    end
    local releaser = hurtParams.releaser
    local hurtMultAdd = 1
    local hurtMultDec = 1
    local hurtMultAddTag = 1
    local hurtMultDecTag = 1
    local hurtMultAddTag2 = 0
    local hurtMultDecTag2 = 0
    local hurtMultTag = 1
    local bigAdd = 0.9897
    local bigShield = 0.5024
    if hurtValue == 0 then
      return
    end
    local buffBaseId = hurtParams.buffBaseId or 0
    if self:hasBuff(163) and hurtParams.buffBaseId == 67 then
      return
    end
    self:triggerPassiveSkill({
      condition = PassiveSkill.CONDITION_HURT_OVER_ATK_N,
      extra = {origin = releaser},
      triggerFunc = function(value)
        if value == "" then
          return false
        end
        local _params = value:toArray("=", true)
        if #_params ~= 3 then
          return false
        end
        local buffType = tonumber(_params[1])
        local buffData = buffDataSet[hurtBuffId]
        if not buffData then
          return false
        end
        if buffData.type ~= buffType then
          return false
        end
        local isPercent = tonumber(_params[2])
        local hurtValLimit = tonumber(_params[3])
        if isPercent then
          if hurtValue > self.curAtk * hurtValLimit / 100 then
            return true
          end
        elseif hurtValLimit < hurtValue then
          return true
        end
      end
    })
    if releaser then
      if globalCsv.battleTagEffect[releaser.battleTag] and globalCsv.battleTagEffect[releaser.battleTag][self.battleTag] then
        hurtMultTag = globalCsv.battleTagEffect[releaser.battleTag][self.battleTag]
        if 1 < hurtMultTag then
          hurtMultAddTag = hurtMultTag
        else
          hurtMultDecTag = hurtMultTag
        end
      end
      hurtMultAddTag2 = ((releaser.hurtChange.damageTag or {})[self.battleTag] or 0) / 100
      hurtMultDecTag2 = ((self.hurtChange.shieldTag or {})[releaser.battleTag] or 0) / 100
      hurtMultAdd = hurtMultAdd + (releaser.hurtChange.damage or 0) / 100
    end
    hurtMultDec = hurtMultDec - (self.hurtChange.shield or 0) / 100
    hurtMultTag = hurtMultTag + hurtMultAddTag2 - hurtMultDecTag2
    if hurtMultTag > 1 + bigAdd then
      hurtMultDecTag = 1
      hurtMultAddTag = 1
      hurtMultAddTag2 = 0
      hurtMultDecTag2 = 0
    end
    if hurtMultAdd > 1 + bigAdd then
      hurtMultAdd = 1
    end
    if hurtMultDec < 1 - bigShield then
      hurtMultDec = 1
    end
    if hurtTag == "extraHurt" then
      hurtValue = hurtValue * math.max(hurtMultDec, 0.01) * math.max(hurtMultDecTag, 0.01) * math.max(1 - hurtMultDecTag2, 0.01)
      hurtParams.hurtReviseRatio = 0.001
    elseif hurtTag == "pierceHurt" then
      hurtValue = hurtValue * math.max(hurtMultAdd, 0.01)
      hurtParams.hurtReviseRatio = math.max(hurtMultAddTag2 + hurtMultAddTag - 1, 0.001)
    else
      hurtValue = hurtValue * math.max(hurtMultAdd, 0.01) * math.max(hurtMultDec, 0.01) * math.max(hurtMultDecTag, 0.01) * math.max(1 - hurtMultDecTag2, 0.01)
      hurtParams.hurtReviseRatio = math.max(hurtMultAddTag2 + hurtMultAddTag - 1, 0.001)
    end
    self.buffReaction = {}
    if skillHurt then
      if skillHurt.id > 10000 and skillHurt.id < 20000 then
        skillType = "block"
      elseif self:isSpecial(skillHurt.id) then
        skillType = "special"
      end
      if releaser:hasBuff(141) then
        for _, buff in ipairs(releaser.buffTypes[141]) do
          buff:effect(skillHurt.id)
        end
      end
      if releaser.side ~= self.side then
        self:triggerPassiveSkill({
          condition = PassiveSkill.CONDITION_ATTACKED_BY_TARGET,
          extra = {origin = releaser}
        })
        releaser:triggerPassiveSkill({
          condition = PassiveSkill.CONDITION_ATTACK_TARGET,
          extra = {origin = self},
          triggerFunc = function(value)
            if value == "" then
              return
            end
            if tonumber(value) == 1 then
              return true
            end
            local buffIds = value:toArray("=", true)
            for _, id in ipairs(buffIds) do
              if releaser:hasBuffById(tonumber(id)) then
                return true
              end
            end
          end
        })
        self.totalAttackedCnt = self.totalAttackedCnt + 1
        self:triggerPassiveSkill({
          condition = PassiveSkill.CONDITION_ATTACKED_NUM,
          triggerFunc = function(value)
            return self.totalAttackedCnt % tonumber(value) == 0
          end
        })
        self:triggerPassiveSkill({
          condition = PassiveSkill.CONDITION_ATTACKED_PROFESSION,
          extra = {origin = releaser},
          triggerFunc = function(value)
            return releaser.unit.profession == tonumber(value)
          end
        })
        releaser:triggerPassiveSkill({
          condition = PassiveSkill.CONDITION_ATTACK_PROFESSION,
          extra = {origin = self},
          triggerFunc = function(value)
            return self.unit.profession == tonumber(value)
          end
        })
      end
      local twinBuff = {
        [1] = {21, 22},
        [2] = {22, 21}
      }
      for _, buffSet in ipairs(twinBuff) do
        self:checkReaction(buffSet[1], buffSet[2], releaser)
      end
      if hurtTag == "pierceHurt" then
        hurtValue = hurtValue / self:getFinalAtk(releaser)
      else
        hurtValue = hurtValue / (self:getFinalAtk(releaser) + self.curPhyDef)
      end
      printInfo("Skill %d: %d--->%d %f", skillHurt.id, releaser.type, self.type, hurtValue)
      if skillType ~= "special" and self:tryDodge(hurtParams, hurtType) then
        hurtType = "miss"
      end
      if self:trySpecialDodge(hurtType) then
        hurtType = "specialMiss"
      end
      if releaser:hasBuff(138) then
        for _, _buff in pairs(releaser.buffTypes[138]) do
          if _buff:effect() < math.randomInt(1, 100) then
            hurtType = "hitLoss"
            break
          end
        end
      end
      if hurtType == "miss" or hurtType == "specialMiss" or hurtType == "hitLoss" then
        hurtValue = 0
        self:hurtAction(hurtValue, hurtType, skillType, hurtParams, releaser)
        if hurtType == "specialMiss" then
          self:triggerPassiveSkill({
            condition = PassiveSkill.CONDITION_SPECIALMISS_SUCCESS
          })
        end
        if releaser and hurtType == "hitLoss" then
          releaser:triggerPassiveSkill({
            condition = PassiveSkill.CONDITION_ATTACK_HIT_LOSS
          })
        end
        return
      end
      hurtType, hurtValue = self:calCritHurtValue(hurtParams, hurtValue, hurtType)
    end
    hurtType, hurtValue = self:calSpecialCritHurtValue(hurtParams, hurtValue, hurtType)
    hurtValue = math.max(hurtValue, 0)
    if hurtValue == 0 and hurtType == "normal" then
      return
    end
    local hasDebuff = false
    for i, buffList in pairs(self.buffTypes) do
      for _, buff in ipairs(buffList) do
        if buff.csvData.debuff == 1 then
          hasDebuff = true
          break
        end
      end
      if releaser and hasDebuff == true then
        releaser:triggerPassiveSkill({
          condition = PassiveSkill.CONDITION_ATTACK_HAVE_DEBUFF
        })
        break
      end
    end
    local immune = false
    self:triggerPassiveSkill({
      condition = PassiveSkill.CONDITION_ATTACKED_BEFORE_HURT,
      callback = function(value)
        if value == "" then
          immune = true
        end
      end
    })
    if self:hasBuff(77) and hurtType ~= "kill" and hurtType ~= "hurtBounce" and hurtTag ~= "sheildToHurt" then
      for _, buff in ipairs(self.buffTypes[77]) do
        buff:effect(hurtValue)
      end
    end
    if self:hasBuff(79) and hurtType ~= "kill" then
      for _, buff in ipairs(self.buffTypes[79]) do
        if buff.effectValue1 == 0 then
          buff:effect(hurtValue)
        end
      end
    end
    if releaser and releaser:hasBuff(79) and hurtType ~= "kill" then
      for _, buff in ipairs(releaser.buffTypes[79]) do
        if buff.effectValue1 == 1 then
          buff:effect(hurtValue)
        end
      end
    end
    if releaser and releaser:hasBuff(103) and hurtType ~= "kill" and hurtTag ~= "sheildToHurt" then
      for _, buff in ipairs(releaser.buffTypes[103]) do
        buff:effect(hurtValue, releaser)
      end
    end
    if self:hasBuff(30) and hurtType ~= "undefendable" then
      hurtValue = 0
      hurtType = "unbeatable"
      self:hurtAction(hurtValue, hurtType, skillType, hurtParams, releaser)
      return hurtType
    end
    if self:hasBuff(39) and hurtType ~= "kill" and hurtTag ~= "pierceHurt" then
      for _, buff in ipairs(self.buffTypes[39]) do
        buff:effect()
      end
      immune = true
    end
    if self:hasBuff(126) and not immune then
      for _, buff in ipairs(self.buffTypes[126]) do
        immune = buff:effect()
      end
    end
    if self:hasBuff(171) then
      for _, buff in ipairs(self.buffTypes[171]) do
        local effectValue = buff:effect(hurtValue)
        hurtValue = hurtValue + effectValue.numValue
      end
    end
    if immune then
      hurtValue = 0
      hurtType = "immune"
      self:hurtAction(hurtValue, hurtType, skillType, hurtParams, releaser)
      return hurtType
    end
    local tempHurtType = ""
    hurtValue, tempHurtType = self:calHurtValueCorrect(hurtParams, hurtValue, hurtType, skillHurt)
    local shieldBuff = self:hasShieldBuff()
    if hurtTag ~= "pierceHurt" then
      if 0 < hurtValue and 0 < #shieldBuff and releaser then
        releaser:triggerPassiveSkill({
          extra = {hurtParams = hurtParams},
          condition = PassiveSkill.CONDITION_ATTACK_BEFORE_SHIELD,
          callback = function(value)
            return true
          end
        })
      end
      if hurtParams.shieldHurt then
        local shieldHurt = hurtValue * hurtParams.shieldHurt
        hurtValue = hurtValue * (1 + hurtParams.shieldHurt)
        hurtParams.shieldHurt = shieldHurt
      end
      if 0 < hurtValue and 0 < #shieldBuff and hurtType ~= "kill" then
        for _, buffType in ipairs(shieldBuff) do
          for _, buff in ipairs(self.buffTypes[buffType]) do
            if hurtValue == 0 then
              break
            end
            local oldValue = hurtValue
            hurtValue = buff:effect(hurtValue)
            hurtType = oldValue ~= hurtValue and "shield" or hurtType
          end
          if hurtValue == 0 then
            break
          end
        end
      end
      if hurtParams.shieldHurt then
        hurtValue = math.max(hurtValue - hurtParams.shieldHurt, 0)
        hurtParams.shieldHurt = nil
      end
      if hurtValue == 0 then
        return
      end
    end
    if hurtType == "hurtBounce" then
      self:hurtAction(hurtValue, hurtType, skillType, hurtParams, releaser)
      return hurtType
    end
    if not hurtParams.teamerHurt and hurtType ~= "kill" and hurtTag ~= "extraHurt" and hurtTag ~= "pierceHurt" then
      local betterMan
      for _, player in ipairs(self.battle:getTeamers(self)) do
        local returnValue = 0
        if player:hasBuff(51) and player:getState() ~= "Dead" then
          betterMan = player
          for _, buff in ipairs(player.buffTypes[51]) do
            returnValue = returnValue + buff:effect({
              professionId = self.unit.profession,
              hurtValue = hurtValue
            })
          end
          if returnValue ~= 0 then
            hurtValue = hurtValue - returnValue
            hurtValue = math.max(0, hurtValue)
            betterMan:beginHurt({
              hurtValue = returnValue,
              hurtType = hurtType,
              teamerHurt = true
            })
          end
          if hurtValue <= 0 then
            break
          end
        end
      end
      if self:hasBuff(128) then
        for _, _buff in ipairs(self.buffTypes[128]) do
          hurtValue = _buff:effect(hurtValue)
        end
      end
    end
    if not hurtParams.teamerHurt then
      local betterMan
      for _, player in ipairs(self.battle:getTeamers(self)) do
        local returnValue = 0
        if player:hasBuff(166) and player:getState() ~= "Dead" then
          betterMan = player
          for _, buff in ipairs(player.buffTypes[166]) do
            returnValue = returnValue + buff:effect({
              professionId = self.unit.profession,
              hurtValue = hurtValue
            })
          end
          if returnValue ~= 0 then
            hurtValue = hurtValue - returnValue
            hurtValue = math.max(0, hurtValue)
            betterMan:beginHurt({
              hurtValue = returnValue,
              hurtType = hurtType,
              teamerHurt = true
            })
          end
          if hurtValue <= 0 then
            break
          end
        end
      end
    end
    if self:hasBuff(50) and not self:hasBuff(51) and hurtType ~= "kill" and hurtTag ~= "extraHurt" and hurtTag ~= "pierceHurt" then
      local helpers = {}
      for _, player in ipairs(self.battle:getTeamers(self)) do
        if player:getState() ~= "Dead" and not player:hasBuff(50) then
          table.insert(helpers, player)
        end
      end
      if 0 < #helpers then
        local effectValue = self.buffTypes[50][1]:effect()
        local returnValue = hurtValue * effectValue / 100 / #helpers
        hurtValue = hurtValue * (1 - effectValue / 100)
        for _, player in ipairs(helpers) do
          player:beginHurt({
            hurtValue = returnValue,
            hurtType = "normal",
            teamerHurt = true
          })
        end
      end
    end
    if 0 < hurtValue and hurtTag ~= "extraHurt" then
      self:triggerPassiveSkill({
        condition = PassiveSkill.CONDITION_ATTACKED_WITH_HURT,
        extra = {origin = releaser}
      })
    end
    if releaser then
      if hurtTag ~= "extraHurt" then
        releaser:triggerPassiveSkill({
          condition = PassiveSkill.CONDITION_ATTACK_TRAGET_WITH_HURT,
          extra = {origin = releaser, hurtValue = hurtValue}
        })
        releaser:triggerPassiveSkill({
          condition = PassiveSkill.CONDITION_ATTACK_TRAGET_WITH_HURT_2,
          extra = {origin = self, hurtValue = hurtValue}
        })
      end
      if self:hasBuff(34) and hurtType ~= "kill" and hurtTag ~= "pierceHurt" then
        local returnValue = 0
        for _, _buff in pairs(self.buffTypes[34]) do
          returnValue = returnValue + _buff:effect(hurtValue)
        end
        local temhurt = 0
        if releaser:hasBuff(158) then
          for _, _buff1 in pairs(releaser.buffTypes[158]) do
            temhurt = releaser.fullHp * _buff1.csvData.effectValue / 100
            returnValue = math.min(temhurt, returnValue)
          end
        end
        releaser:beginHurt({
          hurtValue = returnValue,
          hurtType = "hurtBounce",
          releaser = self
        })
      end
    end
    if hurtTag == "trueHurt" and releaser then
      local skillId = hurtParams.skillId or 0
      if not self:isSpecial(skillId) then
        releaser:triggerPassiveSkill({
          condition = PassiveSkill.CONDITION_ATTACK_WITH_TRUE_HURT,
          extra = {origin = self, hurtValue = hurtValue}
        })
      end
      if releaser:hasBuff(76) then
        local skillId = hurtParams.skillId or 0
        for _, _buff in ipairs(releaser.buffTypes[76]) do
          _buff:levelChange(skillId)
        end
      end
    end
    if releaser and releaser:hasBuff(76) and hurtParams.skillId then
      local addValue = 0
      for _, _buff in ipairs(releaser.buffTypes[76]) do
        addValue = _buff:effect(hurtValue, hurtParams.skillId) + addValue
      end
      hurtValue = addValue + hurtValue
    end
    if tempHurtType ~= "" then
      hurtParams.hurtExtrTag = tempHurtType
    end
    if self:hasBuff(158) then
      for _, _buff in ipairs(self.buffTypes[158]) do
        hurtValue = _buff:effect(hurtValue)
      end
    end
    self:hurtAction(hurtValue, hurtType, skillType, hurtParams, releaser)
    if 0 < hurtValue and self:hasBuff(75) and hurtType ~= "tomato" then
      for _, _buff in ipairs(self.buffTypes[75]) do
        _buff:effect(hurtValue)
      end
    end
    if 0 < hurtValue and releaser then
      if releaser:hasBuff(35) and hurtType ~= "kill" then
        local returnValue = 0
        for _, _buff in pairs(releaser.buffTypes[35]) do
          returnValue = returnValue + _buff:effect(hurtValue)
        end
        releaser:beginHurt({hurtValue = returnValue, hurtType = "suckHp"})
      end
      if releaser:hasBuff(74) then
        for _, buff in ipairs(releaser.buffTypes[74]) do
          buff:sheildChange({hurtValue = hurtValue})
        end
      end
      releaser.totalHurtCnt = releaser.totalHurtCnt + 1
      releaser:triggerPassiveSkill({
        condition = PassiveSkill.CONDITION_HURT_NUM,
        triggerFunc = function(value)
          return releaser.totalHurtCnt % tonumber(value) == 0
        end
      })
      self.totalHurtedCnt = self.totalHurtedCnt + 1
      self:triggerPassiveSkill({
        condition = PassiveSkill.CONDITION_HURTED_NUM,
        triggerFunc = function(value)
          return self.totalHurtedCnt % tonumber(value) == 0
        end
      })
      self.totalAttackNum = self.totalAttackNum + 1
      self:triggerPassiveSkill({
        condition = PassiveSkill.CONDITION_ATTACK_NUM,
        triggerFunc = function(value)
          return self.totalAttackNum % tonumber(value) == 0
        end
      })
    end
    if 0 <= hurtValue and releaser then
      self.totalAttackNumNew = self.totalAttackNumNew + 1
      self:triggerPassiveSkill({
        condition = PassiveSkill.CONDITION_ATTACK_NUM_NEW,
        triggerFunc = function(value)
          return self.totalAttackNumNew % tonumber(value) == 0
        end
      })
    end
    if self:hasBuff(134) then
      for _, _buff in ipairs(self.buffTypes[134]) do
        local buffs = _buff.effectValue3:toTableArray()
        local isSame = false
        for i, data in ipairs(buffs) do
          if data[1] == hurtBuffId then
            isSame = true
            break
          end
        end
        if not isSame then
          _buff:effect(true)
        end
      end
    end
    if releaser and releaser:hasBuff(137) then
      for _, _buff in ipairs(releaser.buffTypes[137]) do
        local buffs = _buff.effectValue3:toTableArray()
        local isSame = false
        for i, data in ipairs(buffs) do
          if data[1] == hurtBuffId then
            isSame = true
            break
          end
        end
        if not isSame then
          _buff:effect(true)
        end
      end
    end
  end
  
  function Player:calCritHurtValue(hurtParams, hurtValue, hurtType)
    local releaser = hurtParams.releaser
    local critResist = self.curCritResist / 1600 * 1000
    local critValue = math.max(hurtParams.curCrit - critResist, 0)
    if releaser:hasBuff(9) then
      local effectValue = 0
      for _, _buff in pairs(releaser.buffTypes[9]) do
        effectValue = effectValue + _buff:effect()
      end
      critValue = critValue * (1 + effectValue)
    end
    if releaser:hasBuff(4) then
      critValue = 1000
    end
    if self:hasBuff(5) then
      critValue = 0
    end
    local bCrit = false
    if critValue >= math.randomInt(0, 1000) then
      local critHurtResist = (self.curCritHurtResist / 2300 + 1) * 1000
      local CritHurt = (1500 + hurtParams.curCritHurt) / critHurtResist
      hurtValue = hurtValue * CritHurt
      hurtType = "crit"
      bCrit = true
      self:triggerPassiveSkill({
        condition = PassiveSkill.CONDITION_ATTACKED_WITH_CRIT
      })
      releaser:triggerPassiveSkill({
        condition = PassiveSkill.CONDITION_ATTACK_WITH_CRIT,
        extra = {origin = self}
      })
    end
    if self:hasBuff(101) and not bCrit then
      hurtType = "crit"
      bCrit = true
      self:triggerPassiveSkill({
        condition = PassiveSkill.CONDITION_ATTACKED_WITH_CRIT
      })
      releaser:triggerPassiveSkill({
        condition = PassiveSkill.CONDITION_ATTACK_WITH_CRIT,
        extra = {origin = self}
      })
    end
    if not bCrit then
      releaser:triggerPassiveSkill({
        condition = PassiveSkill.CONDITION_ATTACK_WITHOUT_CRIT
      })
    end
    if bCrit and releaser:hasBuff(9) then
      for _, _buff in pairs(releaser.buffTypes[9]) do
        _buff:effect(true)
      end
    end
    return hurtType, hurtValue
  end
  
  function Player:calSpecialCritHurtValue(hurtParams, hurtValue, hurtType)
    if hurtType ~= "specialBuff" then
      return hurtType, hurtValue
    end
    local releaser = hurtParams.releaser
    if not releaser then
      return hurtType, hurtValue
    end
    local critResist = self.curCritResist / 1600 * 1000
    local critValue = math.max(hurtParams.curCrit - critResist, 0)
    if releaser:hasBuff(9) then
      local effectValue = 0
      for _, _buff in pairs(releaser.buffTypes[9]) do
        effectValue = effectValue + _buff:effect()
      end
      critValue = critValue * (1 + effectValue)
    end
    if releaser:hasBuff(4) then
      critValue = 1000
    end
    if self:hasBuff(5) then
      critValue = 0
    end
    local bCrit = false
    if critValue >= math.randomInt(0, 1000) then
      local critHurtResist = (self.curCritHurtResist / 2300 + 1) * 1000
      local CritHurt = (1500 + hurtParams.curCritHurt) / critHurtResist
      hurtValue = hurtValue * CritHurt
      hurtType = "crit"
      bCrit = true
      self:triggerPassiveSkill({
        condition = PassiveSkill.CONDITION_ATTACKED_WITH_CRIT
      })
      releaser:triggerPassiveSkill({
        condition = PassiveSkill.CONDITION_ATTACK_WITH_CRIT,
        extra = {origin = self}
      })
    else
      hurtType = "normal"
    end
    if bCrit and releaser:hasBuff(9) then
      for _, _buff in pairs(releaser.buffTypes[9]) do
        _buff:effect(true)
      end
    end
    return hurtType, hurtValue
  end
  
  function Player:tryDodge(hurtParams, hurtType)
    local releaser = hurtParams.releaser
    local hitResist = self.curHitResist / 2320 * 2 + 1
    local finalHit = hurtParams.curHit / hitResist
    local hitValue = self.curMiss > 0 and finalHit / self.curMiss * 100 or 100
    if hurtType == "crit" and releaser:hasBuff(6) then
      hitValue = 100
    end
    if releaser:hasBuff(7) then
      hitValue = 100
    end
    if self:hasBuff(8) or releaser:hasBuff(13) then
      hitValue = 0
    end
    if hitValue < math.randomInt(1, 100) then
      self:triggerPassiveSkill({
        condition = PassiveSkill.CONDITION_ATTACKED_WITH_MISS
      })
      releaser:triggerPassiveSkill({
        condition = PassiveSkill.CONDITION_ATTACK_WITH_MISS
      })
      return true
    end
  end
  
  function Player:trySpecialDodge(hurtType)
    if hurtType == "miss" then
      return
    end
    local hitValue = 0
    if self:hasBuff(23) then
      for _, _buff in pairs(self.buffTypes[23]) do
        hitValue = hitValue + _buff:effect()
      end
      if 100 <= hitValue then
        hitValue = 100
      end
      hitValue = 100 - hitValue
      if hitValue < math.randomInt(1, 100) then
        self:triggerPassiveSkill({
          condition = PassiveSkill.CONDITION_ATTACKED_WITH_ADVANCED_MISS
        })
        return true
      end
    end
  end
  
  function Player:calHurtValueCorrect(hurtParams, hurtValue, hurtType, skillHurt)
    if hurtType == "kill" then
      return hurtValue
    end
    local tempHurtType = ""
    local releaser = hurtParams.releaser
    local causeBuffId = hurtParams.buffId
    local causeBuffType = hurtParams.buffType
    local underHurtBuff = {
      99,
      31,
      40,
      71,
      81,
      98,
      104,
      69,
      115,
      122,
      171
    }
    local causeHurtBuff = {
      29,
      102,
      68,
      90,
      92,
      108,
      109,
      110,
      111,
      114,
      123,
      127,
      132,
      160
    }
    local addRatio1, subRatio1 = 100, 1
    if releaser and hurtTag ~= "extraHurt" then
      for _, buffId in ipairs(causeHurtBuff) do
        local buffParams = {
          hurtValue = hurtValue,
          buffId = buffId,
          releaser = releaser
        }
        local revise
        if buffId == 90 then
          revise = self:reviseHurt(buffParams, self)
        elseif buffId == 109 then
          revise = self:reviseHurt(buffParams, self)
        elseif buffId == 123 then
          revise = self:reviseHurt(buffParams, self)
        elseif buffId == 127 or buffId == 132 then
          local oriValue = hurtValue
          revise = self:reviseHurt(buffParams)
          if revise.addRatio > 0 then
            tempHurtType = "doubleHurt"
          end
        elseif buffId == 31 then
          revise = self:reviseHurt(buffParams, hurtParams.hurtTag)
        elseif buffId == 68 then
          revise = self:reviseHurt(buffParams, causeBuffId, causeBuffType)
        else
          revise = self:reviseHurt(buffParams)
        end
        addRatio1 = addRatio1 + revise.addRatio
        subRatio1 = subRatio1 * revise.subRatio
        hurtValue = revise.hurtValue
      end
    end
    addRatio1 = addRatio1 / 100 + hurtParams.hurtReviseRatio
    local addRatio2, subRatio2 = 100, 1
    if hurtTag ~= "pierceHurt" then
      for _, buffId in ipairs(underHurtBuff) do
        local revise
        local buffParams = {
          hurtValue = hurtValue,
          buffId = buffId,
          releaser = self
        }
        if buffId == 81 then
          function buffParams.triggerFunc()
            return #self.buffReaction ~= 0
          end
          
          revise = self:reviseHurt(buffParams, self.buffReaction)
        elseif buffId == 69 and skillHurt then
          revise = self:reviseHurt(buffParams, skillHurt.id)
        elseif buffId == 98 and releaser then
          revise = self:reviseHurt(buffParams, releaser)
        elseif buffId == 122 and releaser then
          revise = self:reviseHurt(buffParams, releaser)
        else
          revise = self:reviseHurt(buffParams)
        end
        addRatio2 = addRatio2 + revise.addRatio
        subRatio2 = subRatio2 * revise.subRatio
        hurtValue = revise.hurtValue
      end
    end
    addRatio2 = addRatio2 / 100
    hurtValue = math.max(hurtValue, 1)
    hurtValue = hurtValue * addRatio1 * subRatio1 * addRatio2 * subRatio2
    return hurtValue, tempHurtType
  end
  
  function Player:reviseHurt(params, ...)
    local hurtValue = params.hurtValue
    local releaser = params.releaser
    local buffId = params.buffId
    local addRatio, subRatio = 0, 1
    local func = params.triggerFunc or function()
      return true
    end
    if not func() then
      return {
        addRatio = addRatio,
        subRatio = subRatio,
        hurtValue = hurtValue
      }
    end
    if releaser:hasBuff(buffId) then
      for _, buff in ipairs(releaser.buffTypes[buffId]) do
        local effectValue = buff:effect(hurtValue, ...)
        if effectValue then
          if 0 < effectValue.ratio then
            addRatio = addRatio + effectValue.ratio
          elseif effectValue.ratio == 0 then
            hurtValue = hurtValue + effectValue.numValue
          else
            subRatio = subRatio * (100 + effectValue.ratio) / 100
          end
        end
      end
    end
    return {
      addRatio = addRatio,
      subRatio = subRatio,
      hurtValue = hurtValue
    }
  end
  
  function Player:hurtAction(value, type, skillType, hurtParams, releaser)
    local hurtValue = value
    if hurtValue ~= hurtValue then
      hurtValue = 1
    end
    if 0 < hurtValue and (self:hasBuff(33) or self:hasBuff(124)) then
      local deadLine = self.fullHp
      local deadLines = {}
      if self:hasBuff(33) then
        local dl = deadLine
        for _, buff in ipairs(self.buffTypes[33]) do
          local value = buff:effect()
          if dl > value then
            dl = value
          end
        end
        table.insert(deadLines, dl)
      end
      if self:hasBuff(124) then
        local dl = deadLine
        for _, buff in ipairs(self.buffTypes[124]) do
          local value = buff:effect()
          if dl > value then
            dl = value
          end
        end
        table.insert(deadLines, dl)
      end
      table.sort(deadLines, function(a, b)
        return b < a
      end)
      deadLine = deadLines[1]
      deadLine = math.min(self.fullHp, deadLine)
      deadLine = math.max(1, deadLine)
      if deadLine <= self.hp and deadLine > self.hp - hurtValue then
        hurtValue = math.min(self.hp - deadLine, hurtValue)
        hurtValue = hurtValue - 1
        hurtValue = math.max(0, hurtValue)
        if hurtValue == 0 then
          type = "immune"
        end
      end
      if deadLine >= self.hp then
        hurtValue = 0
        type = "immune"
      end
    end
    if hurtValue >= self.hp then
      self:triggerPassiveSkill({
        condition = PassiveSkill.CONDITION_OWNER_PREPARE_TO_DEAD,
        extra = {origin = self},
        callback = function()
          hurtValue = 0
          print("hurtValue = 0", hurtValue)
        end
      })
    end
    local original = self:getProperty("hp")
    if hurtValue >= original then
      for _, player in ipairs(self.battle:getPlayers(self.side)) do
        player:triggerPassiveSkill({
          condition = PassiveSkill.CONDITION_TEAMER_PREPARE_TO_DEAD,
          extra = {origin = self},
          callback = function()
            hurtValue = 0
            print("hurtValue = 0", hurtValue)
          end
        })
      end
    end
    local overHurtValue = 0
    if hurtParams.hurtType == "holycrash" and self:hasBuff(96) and not self:hasBuff(33) and not self:hasBuff(124) then
      for _, _buff in pairs(self.buffTypes[96]) do
        overHurtValue = _buff:effect(hurtValue)
      end
    end
    self:changeHp(hurtValue, type, skillType, hurtParams, releaser)
    if 0 < overHurtValue and hurtParams.releaser then
      print(">>>>>>>", overHurtValue, hurtValue)
      self:doOverFlowHurt(overHurtValue, hurtParams.releaser)
    end
  end
  
  function Player:changeHp(value, type, skillType, hurtParams, releaser)
    local emengType = ""
    if self.battle.modeType == 3 and self.battle.battleType == BattleType.PvE and releaser and self:hasBuff(187) then
      if releaser.curTeBao - self.curTeKang > 0 then
        local tebaoRate = (releaser.curTeBao - self.curTeKang) / (releaser.curTeBao + self.curTeKang)
        local index = math.random(1, 10000)
        if index < math.floor(tebaoRate * 10000) then
          emengType = "tebao"
        else
          emengType = "tekang"
          value = math.max(1, value - value * globalCsv.emengBattleRate)
        end
      else
        emengType = "tekang"
        value = math.max(1, value - value * globalCsv.emengBattleRate)
      end
    end
    if releaser then
      releaser.totalAttackValue = releaser.totalAttackValue + value
    end
    local original = self:getProperty("hp")
    local hp = original - value
    if hp < 0 and self.isWorldBoss then
      hp = hp % self.fullHp
    end
    hp = math.min(hp, self.fullHp)
    hp = math.max(hp, 0)
    self:setProperty("hp", hp)
    if hp < 0 then
      self.deadCnt = self.deadCnt + 1
    end
    printInfo("player Hp change %d: value: %d hurtType: %s skillType: %s", self.type, value, type or "", skillType or "not skill")
    local origPercent = original * 100 / self.fullHp
    local nowPercent = hp * 100 / self.fullHp
    self:dispatchEvent({
      name = "playerHpChange",
      origPercent = origPercent,
      nowPercent = nowPercent
    })
    if 0 < value then
      self:triggerPassiveSkill({
        condition = PassiveSkill.CONDITION_SELF_DOWN_HP,
        triggerFunc = function(value)
          if value == "" then
            return true
          end
          value = tonumber(value)
          if value < origPercent and value >= nowPercent then
            return true
          end
        end
      })
      for _, teamer in ipairs(self.battle:getTeamers(self)) do
        teamer:triggerPassiveSkill({
          extra = {origin = self},
          condition = PassiveSkill.CONDITION_TEAMER_DOWN_HP
        })
      end
      for _, player in ipairs(self.battle:getPlayers(self.side)) do
        player:triggerPassiveSkill({
          extra = {origin = self},
          condition = PassiveSkill.CONDITION_SELF_SIDE_DOWN_HP,
          triggerFunc = function(value)
            if value == "" then
              return true
            end
            value = tonumber(value)
            if value < origPercent and value >= nowPercent then
              return true
            end
          end
        })
      end
      for _, enemy in ipairs(self.battle:getPlayers(self.otherSide)) do
        enemy:triggerPassiveSkill({
          extra = {origin = self},
          condition = PassiveSkill.CONDITION_ENEMY_DOWN_HP,
          triggerFunc = function(value)
            if value == "" then
              return true
            end
            value = tonumber(value)
            if value < origPercent and value >= nowPercent then
              return true
            end
          end
        })
      end
      if 0 < value then
        self.hurt = (self.hurt or 0) + value
      end
      print(value .. "------------------value")
      print(origPercent .. "----------------origPercent")
      print(nowPercent .. "----------------nowPercent")
      print("----------------------------")
    elseif value < 0 then
      self:triggerPassiveSkill({
        condition = PassiveSkill.CONDITION_SELF_ADD_HP
      })
      for _, enemy in ipairs(self.battle:getPlayers(self.otherSide)) do
        enemy:triggerPassiveSkill({
          extra = {origin = self},
          condition = PassiveSkill.CONDITION_ENEMY_ADD_HP
        })
      end
      for _, teamer in ipairs(self.battle:getTeamers(self)) do
        teamer:triggerPassiveSkill({
          extra = {origin = self},
          condition = PassiveSkill.CONDITION_TEAMER_ADD_HP
        })
      end
    end
    self:onHpChange({
      original = original,
      now = hp,
      value = math.ceil(value),
      type = type,
      emengType = emengType,
      skillType = skillType,
      hurtParams = hurtParams
    })
    if hp == 0 then
      if self.realType then
        self:changeUnitType({
          action = "restore",
          type = self.realType
        })
      end
      self:dispatchEvent({name = "playerDead"})
      self.leader = false
      if self:hasBuff(57) then
        for _, _buff in pairs(self.buffTypes[57]) do
          _buff:effect()
        end
      end
      if self:hasBuff(59) then
        for _, _buff in pairs(self.buffTypes[59]) do
          _buff:effect()
        end
      end
      if self:hasBuff(144) then
        for _, _buff in pairs(self.buffTypes[144]) do
          _buff:effect()
        end
      end
      self:doEvent("over")
      if hurtParams and hurtParams.releaser then
        if hurtParams.releaser:hasBuff(56) then
          for _, _buff in pairs(hurtParams.releaser.buffTypes[56]) do
            _buff:effect()
          end
        end
        if hurtParams.releaser:hasBuff(125) and skillType == "special" then
          for _, _buff in pairs(hurtParams.releaser.buffTypes[125]) do
            _buff:effect()
          end
        end
      end
    end
  end
  
  function Player:doOverFlowHurt(overValue, releaser)
    for _, teamer in ipairs(self.battle:getTeamers(self)) do
      local hurtParams = {
        hurtValue = overValue,
        hurtType = "overflow",
        releaser = releaser,
        hurtTag = "trueHurt"
      }
      teamer:beginHurt(hurtParams)
    end
  end
  
  function Player:beginAttack()
    self.totalAttackCnt = self.totalAttackCnt + 1
    self:triggerPassiveSkill({
      condition = PassiveSkill.CONDITION_ATTACK_NUM,
      triggerFunc = function(value)
        return self.totalAttackCnt % tonumber(value) == 0
      end
    })
  end
  
  function Player:enterCirtOnce()
    local enemys = self.battle:getPlayers(self.otherSide)
    local randomValue = math.randomInt(1, #enemys)
    local releaser = enemys[randomValue]
    if not releaser then
      return
    end
    releaser:triggerPassiveSkill({
      condition = PassiveSkill.CONDITION_ATTACKED_WITH_CRIT
    })
    self:triggerPassiveSkill({
      condition = PassiveSkill.CONDITION_ATTACK_WITH_CRIT,
      extra = {origin = releaser}
    })
  end
  
  function Player:enterHurtFake()
    local enemys = self.battle:getPlayers(self.otherSide)
    local randomValue = math.randomInt(1, #enemys)
    local releaser = enemys[randomValue]
    if not releaser then
      return
    end
    self:triggerPassiveSkill({
      condition = PassiveSkill.CONDITION_ATTACKED_WITH_HURT,
      extra = {origin = releaser}
    })
  end
  
  function Player:enterMissOnce()
    local enemys = self.battle:getPlayers(self.otherSide)
    local randomValue = math.randomInt(1, #enemys)
    local releaser = enemys[randomValue]
    if not releaser then
      return
    end
    self:triggerPassiveSkill({
      condition = PassiveSkill.CONDITION_ATTACKED_WITH_MISS
    })
    releaser:triggerPassiveSkill({
      condition = PassiveSkill.CONDITION_ATTACK_WITH_MISS
    })
  end
  
  function Player:enterEmptySpecial()
    self:triggerPassiveSkill({
      condition = PassiveSkill.CONDITION_SPECIAL_SKILL,
      triggerFunc = function(value)
        if value == "" or tonumber(value) == 1 then
          return true
        end
        local idSet
        if type(value) == "number" then
          idSet = {value}
        else
          idSet = value:toArray("=", true)
        end
        for _, id in ipairs(idSet) do
          if self.currentSkillId == id then
            return true
          end
        end
        return false
      end
    })
    local players = self.battle:getPlayers(self.side)
    for _, player in ipairs(players) do
      if not player:hasBuff(176) then
        player:triggerPassiveSkill({
          condition = PassiveSkill.CONDITION_TEAMER_AND_SELF_SPECIAL_SKILL,
          extra = {origin = self}
        })
      end
    end
    local enemys = self.battle:getPlayers(self.otherSide)
    for _, enemy in ipairs(enemys) do
      if not enemy:hasBuff(176) then
        enemy:triggerPassiveSkill({
          condition = PassiveSkill.CONDITION_ENEMY_SPECIAL_SKILL
        })
      end
    end
  end
  
  function Player:enterSpecial()
    self:triggerPassiveSkill({
      condition = PassiveSkill.CONDITION_SPECIAL_SKILL,
      triggerFunc = function(value)
        if value == "" or tonumber(value) == 1 then
          return true
        end
        local idSet
        if type(value) == "number" then
          idSet = {value}
        else
          idSet = value:toArray("=", true)
        end
        for _, id in ipairs(idSet) do
          if self.currentSkillId == id then
            return true
          end
        end
        return false
      end
    })
    local players = self.battle:getPlayers(self.side)
    for _, player in ipairs(players) do
      if not player:hasBuff(176) then
        player:triggerPassiveSkill({
          condition = PassiveSkill.CONDITION_TEAMER_AND_SELF_SPECIAL_SKILL,
          extra = {origin = self}
        })
      end
    end
    local enemys = self.battle:getPlayers(self.otherSide)
    for _, enemy in ipairs(enemys) do
      if not enemy:hasBuff(176) then
        enemy:triggerPassiveSkill({
          condition = PassiveSkill.CONDITION_ENEMY_SPECIAL_SKILL
        })
      end
    end
    self:dispatchEvent({
      name = "releaseSpecial",
      skillId = self.currentSkillId
    })
    self:onSpecial()
  end
  
  function Player:onSkillFinish(skill)
    if self:isSpecial(skill.id) then
      self:triggerPassiveSkill({
        condition = PassiveSkill.CONDITION_SPECIAL_SKILL_FINISH
      })
    end
  end
  
  function Player:deadFinal()
    self:triggerPassiveSkill({
      condition = PassiveSkill.CONDITION_SELF_DEAD
    })
    for _, enemy in ipairs(self.battle:getPlayers(self.otherSide)) do
      enemy:triggerPassiveSkill({
        extra = {origin = self},
        condition = PassiveSkill.CONDITION_ENEMY_DEAD,
        triggerFunc = function(value)
          if value == "" then
            return true
          end
          value = tonumber(value)
          return self.unit.type == value
        end
      })
      enemy:triggerPassiveSkill({
        extra = {origin = self},
        condition = PassiveSkill.CONDITION_ENEMY_OR_TEAMER_DEAD,
        triggerFunc = function(value)
          if value == "" then
            return true
          end
          value = tonumber(value)
          return self.unit.type == value
        end
      })
    end
    for _, teamer in ipairs(self.battle:getTeamers(self)) do
      teamer:triggerPassiveSkill({
        extra = {origin = self},
        condition = PassiveSkill.CONDITION_TEAMER_DEAD,
        triggerFunc = function(value)
          if value == "" then
            return true
          end
          value = tonumber(value)
          return self.unit.type == value
        end
      })
      teamer:triggerPassiveSkill({
        extra = {origin = self},
        condition = PassiveSkill.CONDITION_ENEMY_OR_TEAMER_DEAD,
        triggerFunc = function(value)
          if value == "" then
            return true
          end
          value = tonumber(value)
          return self.unit.type == value
        end
      })
    end
    for _, teamer in ipairs(self.battle:getTeamers(self)) do
      teamer:triggerPassiveSkill({
        extra = {origin = self},
        condition = PassiveSkill.CONDITION_TEAMER_DEAD_ALL,
        triggerFunc = function(value)
          local teamers = self.battle:getTeamers(teamer)
          for _, _teamer in ipairs(teamers) do
            if _teamer.hp > 0 then
              return false
            end
          end
          return true
        end
      })
    end
    for _, teamer in ipairs(self.battle:getTeamers(self)) do
      teamer:triggerPassiveSkill({
        extra = {origin = self},
        condition = PassiveSkill.CONDITION_TEAMER_DEAD_BY_PROFESSION,
        triggerFunc = function(value)
          if value == "" then
            return false
          end
          local proSet = type(value) == number and {value} or value:toArray("=", true)
          if not table.keyof(proSet, self.unit.profession) then
            return false
          end
          local teamers, count = self.battle:getTeamers(teamer), 0
          for _, _teamer in ipairs(teamers) do
            for _, pro in ipairs(proSet) do
              count = _teamer.unit.profession == pro and count + 1 or count
            end
          end
          return count == 1
        end
      })
    end
  end
  
  function Player:deadFinalFake()
    self:triggerPassiveSkill({
      condition = PassiveSkill.CONDITION_SELF_DEAD,
      extra = {isFakeDead = true, origin = self}
    })
    for _, enemy in ipairs(self.battle:getPlayers(self.otherSide)) do
      enemy:triggerPassiveSkill({
        extra = {origin = self, isFakeDead = true},
        condition = PassiveSkill.CONDITION_ENEMY_DEAD,
        triggerFunc = function(value)
          if value == "" then
            return true
          end
          local targetType = tonumber(value)
          return self.unit.type == targetType
        end
      })
      enemy:triggerPassiveSkill({
        extra = {origin = self, isFakeDead = true},
        condition = PassiveSkill.CONDITION_ENEMY_OR_TEAMER_DEAD,
        triggerFunc = function(value)
          if value == "" then
            return true
          end
          local targetType = tonumber(value)
          return self.unit.type == targetType
        end
      })
    end
    for _, teamer in ipairs(self.battle:getTeamers(self)) do
      teamer:triggerPassiveSkill({
        extra = {origin = self, isFakeDead = true},
        condition = PassiveSkill.CONDITION_TEAMER_DEAD,
        triggerFunc = function(value)
          if value == "" then
            return true
          end
          local targetType = tonumber(value)
          return self.unit.type == targetType
        end
      })
      teamer:triggerPassiveSkill({
        extra = {origin = self, isFakeDead = true},
        condition = PassiveSkill.CONDITION_ENEMY_OR_TEAMER_DEAD,
        triggerFunc = function(value)
          if value == "" then
            return true
          end
          local targetType = tonumber(value)
          return self.unit.type == targetType
        end
      })
    end
    for _, teamer in ipairs(self.battle:getTeamers(self)) do
      teamer:triggerPassiveSkill({
        extra = {origin = self, isFakeDead = true},
        condition = PassiveSkill.CONDITION_TEAMER_DEAD_BY_PROFESSION,
        triggerFunc = function(value)
          if value == "" then
            return false
          end
          local targetProfessionSet = type(value) == number and {value} or value:toArray("=", true)
          if not table.keyof(targetProfessionSet, self.unit.profession) then
            return false
          end
          local allTeamers = self.battle:getTeamers(teamer)
          local deadTargetProfessionCount = 0
          for _, _teamer in ipairs(allTeamers) do
            local isTeamerDead = _teamer == self and true or 0 >= _teamer.hp
            if isTeamerDead and table.keyof(targetProfessionSet, _teamer.unit.profession) then
              deadTargetProfessionCount = deadTargetProfessionCount + 1
            end
          end
          return deadTargetProfessionCount == 1
        end
      })
    end
  end
  
  function Player:triggerPassiveSkill(params)
    local function check(passiveData)
      local skill = passiveData.passiveSkill
      
      if not skill:isActive() then
        return
      end
      params.triggerFunc = params.triggerFunc or function()
        return true
      end
      if not params.triggerFunc(passiveData.value, skill) then
        return
      end
      if not (math.randomInt(0, 100) <= passiveData.probability) then
        return
      end
      if skill:isCD() then
        return
      end
      for _, buff in pairs(self.buffTypes) do
        for i, value in pairs(buff) do
          if value.csvData.hideTag == 1 then
            return
          end
        end
      end
      return true
    end
    
    for _, passiveData in ipairs(self.passiveSkills[params.condition] or {}) do
      local skill = passiveData.passiveSkill
      if check(passiveData) then
        skill:effect(params.extra)
        if skill:showBlockTip() then
          self:dispatchEvent({
            name = "releaseBlock",
            skillId = skill.id
          })
        end
        if params.callback then
          params.callback(passiveData.value)
        end
      end
    end
  end
  
  function Player:hasPassiveSkill(condition)
    return self.passiveSkills[condition]
  end
  
  function Player:addToBattle(battle)
    self:setBattle(battle)
    self:triggerPassiveSkill({
      extra = {releaser = self},
      condition = PassiveSkill.CONDITION_BATTLE_START
    })
    self:triggerPassiveSkill({
      extra = {releaser = self},
      condition = PassiveSkill.CONDITION_ENEMY_BATTLE_START
    })
    self:triggerPassiveSkill({
      extra = {releaser = self},
      condition = PassiveSkill.CONDITION_BATTLE_START_CHECK_HP,
      triggerFunc = function(value)
        if value == "" then
          return true
        end
        value = tonumber(value)
        local percent = self.hp * 100 / self.fullHp
        return value > percent
      end
    })
    for _, enemy in ipairs(self.battle:getPlayers(self.otherSide)) do
      enemy:triggerPassiveSkill({
        extra = {releaser = enemy},
        condition = PassiveSkill.CONDITION_ENEMY_BATTLE_START
      })
    end
  end
  
  function Player:setAttrDirty()
    self.attrDirty = true
  end
  
  function Player:setBuffIconDirty()
    self.buffIconDirty = true
  end
  
  function Player:disposeAllBuff()
    if not self.buffTypes then
      return
    end
    for type, buffs in pairs(self.buffTypes) do
      for buffIndex, buff in ipairs(buffs) do
        buff:dispose()
      end
    end
  end
  
  function Player:onBuffEnd(buffId)
    self:triggerPassiveSkill({
      condition = PassiveSkill.CONDITION_SELF_BUFF_END_BY_ID,
      triggerFunc = function(value)
        if value == "" then
          return
        end
        local buffIds = value:toArray("=", true)
        for _, id in ipairs(buffIds) do
          if id == buffId then
            return true
          end
        end
      end
    })
  end
  
  function Player:onBuffEndByType(buffType)
    self:triggerPassiveSkill({
      condition = PassiveSkill.CONDITION_SELF_BUFF_END_BY_TYPE,
      triggerFunc = function(value)
        if value == "" then
          return
        end
        local buffTypes = value:toArray("=", true)
        for _, id in ipairs(buffTypes) do
          if id == buffType then
            return true
          end
        end
      end
    })
  end
  
  function Player:onBuffEndByDebuff(debuff)
    if tonumber(debuff) == -1 then
      self:triggerPassiveSkill({
        condition = PassiveSkill.CONDITION_SELF_BUFF_END_BY_DEBUFF1,
        triggerFunc = function(value)
          if value == "" then
            return
          end
          return true
        end
      })
    elseif tonumber(debuff) == 1 then
      self:triggerPassiveSkill({
        condition = PassiveSkill.CONDITION_SELF_BUFF_END_BY_DEBUFF2,
        triggerFunc = function(value)
          if value == "" then
            return
          end
          return true
        end
      })
    end
  end
end

return PlayerPlugin
