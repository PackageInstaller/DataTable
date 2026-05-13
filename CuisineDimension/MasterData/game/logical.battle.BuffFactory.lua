local PassiveSkill = require("logical.battle.PassiveSkill")
local SkillSpecialSet = require("csvdata.skill_special")
local sheildBuff = {
  32,
  64,
  74,
  78
}
local BuffFactory = {
  [1] = function(Buff)
    function Buff:_update()
      local value = -self.recordValue
      
      printInfo("Buff1: player:%s buffId-%s value-%s", self.player.unit.name, self.id, value)
      self.player:beginHurt({hurtValue = value, hurtType = "cure"})
    end
    
    function Buff:_recordValue(params)
      if self.effectValue1 == 1 then
        local player = self.effectValue3 == 1 and self.player or self.releaser
        local attr = BuffAtts[self.effectValue2]
        if attr == "Hp" then
          attr = "fullHp"
        else
          attr = "cur" .. attr
        end
        self.recordValue = player[attr] * self.effectValue / 100
      else
        self.recordValue = self.effectValue
      end
    end
  end,
  [2] = function(Buff)
    function Buff:_update()
      local value = self.recordValue
      
      printInfo("Buff2: player:%s buffId-%s value-%s", self.player.unit.name, self.id, value)
      local hurtParams = {
        hurtValue = value,
        hurtType = "normal",
        releaser = self.releaser,
        hurtTag = "trueHurt",
        hurtBuffId = self.id
      }
      if self.skillId then
        hurtParams.skillId = self.skillId
        hurtParams.sumHurt = self.sumHurt
      end
      if not self.player:hasBuff(151) and not self.releaser:hasBuff(154) and not self.player:hasBuff(156) then
        hurtParams.buffType = 2
        hurtParams.buffId = self.id
        self.player:beginHurt(hurtParams)
      end
    end
    
    function Buff:_recordValue(params)
      if self.effectValue1 == 1 then
        local player = self.effectValue3 == 1 and self.player or self.releaser
        local attrValue
        if self.effectValue2 == 15 then
          attrValue = player.fullHp - player.hp
        else
          local attr = BuffAtts[self.effectValue2]
          if attr == "Hp" then
            attr = "fullHp"
          else
            attr = "cur" .. attr
          end
          attrValue = player[attr]
          if attr == "curAtk" then
            attrValue = player.curAtk + player.curTrueAtk ^ 1.2 / (6 + player.curTrueAtk / 5000)
          end
        end
        self.recordValue = attrValue * self.effectValue / 100
      else
        self.recordValue = self.effectValue
      end
      if self.player:hasBuff(143) then
        for _, _buff in pairs(self.player.buffTypes[143]) do
          if _buff.effectValue1 == 1 then
            self.recordValue = _buff:effect(self.recordValue, self.id)
          end
        end
        for _, _buff in pairs(self.player.buffTypes[143]) do
          if _buff.effectValue1 == 0 then
            self.recordValue = _buff:effect(self.recordValue, self.id)
          end
        end
      end
    end
  end,
  [3] = function(Buff)
    function Buff:_attrChange()
      local value = self.recordValue
      
      if self.firstEffect then
        self.firstEffect = false
        printInfo("Buff3:%s buffId-%s player-%s releaser-%s value-%s", BuffAtts[self.effectValue2], self.id, self.player.unit.name, self.releaser.unit.name, value)
      end
      self.player:changeAttribute({
        name = BuffAtts[self.effectValue2],
        value = value
      })
    end
    
    function Buff:_recordValue(params)
      self.firstEffect = true
      if self.effectValue1 == 1 then
        local player = self.effectValue3 == 0 and self.player or self.releaser
        local attrValue = player:getBaseAttribute(self.effectValue2)
        self.recordValue = attrValue * self.effectValue / 100
      else
        self.recordValue = self.effectValue
      end
    end
  end,
  [9] = function(Buff)
    function Buff:_effect(clear)
      if clear then
        self.recordValue = 0
      else
        self.recordValue = self.recordValue * (1 + effectValue / 100)
      end
      printInfo("Buff9: player:%s buffId-%s recordValue-%d", self.player.unit.name, self.id, self.recordValue)
      return self.recordValue
    end
    
    function Buff:_recordValue(params)
      self.recordValue = self.effectValue
    end
  end,
  [10] = function(Buff)
    function Buff:_recordValue()
      if self.player:hasBuff(30) or self.player:hasBuff(36) then
        self.leftTime = 0
        
        return
      end
      if self.player:canDoEvent("hurt") then
        self.player:doEvent("hurt")
      end
    end
  end,
  [12] = function(Buff)
    function Buff:_effect()
      return self.effectValue / 100
    end
  end,
  [16] = function(Buff)
    function Buff:_update()
      if self.player:hasBuff(self.effectValue) then
        for _, buff in ipairs(self.player.buffTypes[self.effectValue]) do
          buff:endBuff()
        end
      end
    end
  end,
  [17] = function(Buff)
    function Buff:_update()
      local hasDebuff = false
      
      for type, buffs in pairs(self.player.buffTypes) do
        for _, buff in ipairs(buffs or {}) do
          if buff.csvData.debuff == 1 then
            buff:endBuff()
            hasDebuff = true
          end
        end
      end
      if hasDebuff then
        local battle = self.player.battle
        self.player:triggerPassiveSkill({
          condition = PassiveSkill.CONDITION_SELF_CLEAR_DEBUFF
        })
        for _, enemy in ipairs(battle:getPlayers(self.player.otherSide)) do
          enemy:triggerPassiveSkill({
            extra = {origin = self},
            condition = PassiveSkill.CONDITION_ENEMY_CLEAR_DEBUFF
          })
        end
        for _, teamer in ipairs(battle:getTeamers(self.player)) do
          teamer:triggerPassiveSkill({
            extra = {origin = self},
            condition = PassiveSkill.CONDITION_TEAMER_CLEAR_DEBUFF
          })
        end
      end
    end
    
    function Buff:_recordValue()
      local hasDebuff = false
      for type, buffs in pairs(self.player.buffTypes) do
        for _, buff in ipairs(buffs or {}) do
          if buff.csvData.debuff == 1 then
            buff:endBuff()
            hasDebuff = true
          end
        end
      end
      if hasDebuff then
        local battle = self.player.battle
        self.player:triggerPassiveSkill({
          condition = PassiveSkill.CONDITION_SELF_CLEAR_DEBUFF
        })
        for _, enemy in ipairs(battle:getPlayers(self.player.otherSide)) do
          enemy:triggerPassiveSkill({
            extra = {origin = self},
            condition = PassiveSkill.CONDITION_ENEMY_CLEAR_DEBUFF
          })
        end
        for _, teamer in ipairs(battle:getTeamers(self.player)) do
          teamer:triggerPassiveSkill({
            extra = {origin = self},
            condition = PassiveSkill.CONDITION_TEAMER_CLEAR_DEBUFF
          })
        end
      end
    end
  end,
  [18] = function(Buff)
    function Buff:_recordValue(params)
      local buffSet, weight = {}, {}
      
      local buffs = {}
      local sum, value = 0, 0
      for _, buff in pairs(self.effectValue3:toTableArray()) do
        table.insert(buffSet, tonumber(buff[1]))
        table.insert(weight, tonumber(buff[2]))
      end
      local count = math.min(tonumber(self.effectValue), #buffSet)
      if count == 0 then
        return
      end
      for i = 1, count do
        for _, v in pairs(weight) do
          sum = sum + v
        end
        local randomValue = math.randomInt(1, sum)
        for i = 1, #weight do
          value = weight[i] + value
          if randomValue <= value then
            table.insert(buffs, buffSet[i])
            table.remove(buffSet, i)
            table.remove(weight, i)
            sum, value = 0, 0
            break
          end
        end
      end
      for _, id in pairs(buffs) do
        self.player:addBuff({
          buffId = id,
          releaser = self.releaser
        })
      end
    end
  end,
  [19] = function(Buff)
    function Buff:_recordValue()
      local BuffSet = {}
      
      self.recordValue = {}
      if type(self.effectValue3) == "number" then
        self.recordValue[self.effectValue3] = true
        return
      end
      BuffSet = self.effectValue3:toArray("=", true)
      for _, buffType in pairs(BuffSet) do
        self.recordValue[buffType] = true
      end
    end
    
    function Buff:_update()
      for type, buffs in pairs(self.player.buffTypes) do
        for _, buff in ipairs(buffs or {}) do
          if buff.csvData.debuff == -1 and not self.recordValue[buff.csvData.type] then
            buff:endBuff()
          end
        end
      end
    end
  end,
  [20] = function(Buff)
    function Buff:_update()
      if not self.player.buffIds[self.effectValue] or self.player.buffIds[self.effectValue].num == 0 then
        return
      end
      local buffs = self.player.buffIds[self.effectValue].buffs
      local hasDebuff = false
      for _, buff in pairs(buffs) do
        buff:endBuff()
        if buff.csvData.debuff == 1 then
          hasDebuff = true
        end
      end
      if hasDebuff then
        local battle = self.player.battle
        self.player:triggerPassiveSkill({
          condition = PassiveSkill.CONDITION_SELF_CLEAR_DEBUFF
        })
        for _, enemy in ipairs(battle:getPlayers(self.player.otherSide)) do
          enemy:triggerPassiveSkill({
            extra = {origin = self},
            condition = PassiveSkill.CONDITION_ENEMY_CLEAR_DEBUFF
          })
        end
        for _, teamer in ipairs(battle:getTeamers(self.player)) do
          teamer:triggerPassiveSkill({
            extra = {origin = self},
            condition = PassiveSkill.CONDITION_TEAMER_CLEAR_DEBUFF
          })
        end
      end
    end
  end,
  [21] = function(Buff)
    function Buff:_effect()
      return self.effectValue
    end
  end,
  [22] = function(Buff)
    function Buff:_effect()
      return self.effectValue
    end
  end,
  [23] = function(Buff)
    function Buff:_effect()
      return self.effectValue
    end
  end,
  [29] = function(Buff)
    function Buff:_effect(hurtValue)
      local numValue = hurtValue * (self.effectValue / 100)
      
      local ratio = self.effectValue
      printInfo("Buff29: player:%s buffId-%s value-%s ratio-%s", self.player.unit.name, self.id, numValue, ratio)
      return {numValue = numValue, ratio = ratio}
    end
  end,
  [31] = function(Buff)
    function Buff:_effect(hurtValue, hurtTag)
      local numValue = hurtValue * (self.effectValue / 100)
      
      local ratio = self.effectValue
      if self.effectValue1 == 1 and hurtTag ~= "trueHurt" then
        return {numValue = 0, ratio = ratio}
      end
      printInfo("Buff31: player:%s buffId-%s value-%s ratio-%s", self.player.unit.name, self.id, numValue, ratio)
      return {numValue = numValue, ratio = ratio}
    end
  end,
  [32] = function(Buff)
    function Buff:_effect(hurtValue)
      self.recordValue = self.recordValue - hurtValue
      
      printInfo("Buff32Effect: player:%s buffId-%s value-%s", self.player.unit.name, self.id, self.recordValue)
      local returnValue = self.recordValue >= 0 and 0 or -self.recordValue
      if self.recordValue <= 0 then
        self.leftTime = 0
        self.recordValue = 0
      end
      self.player:onChangeShield()
      return returnValue
    end
    
    function Buff:_recordValue(params)
      if self.effectValue1 == 1 then
        local player = self.effectValue2 == 1 and self.releaser or self.player
        if self.effectValue3 == 0 then
          self.recordValue = player.fullHp * self.effectValue / 100
        elseif self.effectValue3 == 1 then
          self.recordValue = player.hp * self.effectValue / 100
        elseif self.effectValue3 == 15 then
          self.recordValue = (player.fullHp - player.hp) * self.effectValue / 100
        else
          self.recordValue = player["cur" .. BuffAtts[self.effectValue3]] * self.effectValue / 100
        end
      else
        self.recordValue = self.effectValue
      end
      printInfo("Buff32Add: player:%s buffId-%s value-%s", self.player.unit.name, self.id, self.recordValue)
      self.player:onChangeShield()
    end
  end,
  [33] = function(Buff)
    function Buff:_effect()
      return self.recordValue
    end
    
    function Buff:_recordValue()
      if self.effectValue1 == 0 then
        self.recordValue = self.effectValue
      else
        self.recordValue = self.player.fullHp * self.effectValue / 100
      end
    end
  end,
  [34] = function(Buff)
    function Buff:_effect(hurtValue)
      if self.effectValue1 == 0 then
        return self.effectValue
      else
        return hurtValue * self.effectValue / 100
      end
    end
  end,
  [35] = function(Buff)
    function Buff:_effect(hurtValue)
      return -hurtValue * self.effectValue / 100
    end
  end,
  [39] = function(Buff)
    function Buff:_effect()
      printInfo("Buff39: player:%s buffId-%s", self.player.unit.name, self.id)
    end
  end,
  [40] = function(Buff)
    function Buff:_effect(hurtValue)
      local numValue = hurtValue * (self.effectValue / 100)
      
      local ratio = self.effectValue
      printInfo("Buff40: player:%s buffId-%s value-%s ratio-%s", self.player.unit.name, self.id, numValue, ratio)
      return {numValue = numValue, ratio = ratio}
    end
  end,
  [50] = function(Buff)
    function Buff:_effect()
      return self.effectValue
    end
  end,
  [51] = function(Buff)
    function Buff:_recordValue()
      if self.effectValue > 100 then
        printInfo("Buff51:Warn: player:%s buffId-%s value-%s", self.player.unit.name, self.id, self.effectValue)
      end
      if type(self.effectValue3) == "number" then
        self.recordValue = {
          [self.effectValue3] = true
        }
        return
      end
      local effectId = self.effectValue3:toArray("=", true)
      self.recordValue = {}
      for _, id in pairs(effectId) do
        self.recordValue[id] = true
      end
    end
    
    function Buff:_effect(params)
      local professionId = params.professionId
      local hurtValue = params.hurtValue
      if not self.recordValue[professionId] and not self.recordValue[0] then
        self.effectNum = self.effectNum + 1
        return 0
      end
      local returnValue = hurtValue * self.effectValue / 100
      returnValue = math.min(returnValue, hurtValue)
      return returnValue
    end
  end,
  [52] = function(Buff)
    function Buff:_attrChange()
      self.player:changeAttribute({
        name = "curBlockLevel",
        
        value = self.effectValue
      })
    end
  end,
  [53] = function(Buff)
    function Buff:_attrChange()
      self.player:changeAttribute({
        name = "curBlockRate",
        
        value = self.effectValue
      })
    end
  end,
  [54] = function(Buff)
    function Buff:_attrChange()
      self.player:changeAttribute({
        name = "curSpecialRate",
        
        value = self.effectValue
      })
    end
  end,
  [55] = function(Buff)
    function Buff:_update()
      self.player:releaseSkillById(self.effectValue)
    end
  end,
  [56] = function(Buff)
    function Buff:_effect()
      if self:isDone() then
        return
      end
      self.player:releaseSkillById(self.effectValue)
    end
  end,
  [57] = function(Buff)
    function Buff:_effect()
      if self:isDone() then
        return
      end
      self.player:releaseSkillById(self.effectValue)
    end
  end,
  [58] = function(Buff)
    function Buff:_effect(buffId)
      if self:isDone() then
        return
      end
      if buffId == self.effectValue then
        self.player:releaseSkillById(self.effectValue1)
        self.leftTime = 0
      end
    end
  end,
  [59] = function(Buff)
    function Buff:_effect()
      if self:isDone() then
        return
      end
      if not self.releaser then
        return
      end
      if self.releaser:getState() == "Dead" then
        return
      end
      self.releaser:releaseSkillById(self.effectValue)
    end
  end,
  [60] = function(Buff)
    function Buff:_update()
      local value = self.recordValue
      
      printInfo("Buff60: player:%s buffId-%s value-%s", self.player.unit.name, self.id, value)
      local hurtParams = {
        hurtValue = value,
        hurtType = "normal",
        releaser = self.releaser
      }
      if self.skillId then
        hurtParams.skillId = self.skillId
        hurtParams.sumHurt = self.sumHurt
      end
      hurtParams.buffType = 149
      hurtParams.buffId = self.id
      self.player:beginHurt(hurtParams)
    end
    
    function Buff:_recordValue(params)
      self.recordValue = self.player.fullHp * self.effectValue / 100
      if self.releaser then
        local limit = self.releaser.curAtk * self.effectValue1 / 100
        self.recordValue = math.min(self.recordValue, limit)
      end
    end
  end,
  [61] = function(Buff)
    function Buff:_attrChange()
      local value = self.recordValue * self.recordCount
      
      printInfo("Buff61:%s buffId-%s player-%s releaser-%s value-%s", BuffAtts[self.effectValue1], self.id, self.player.unit.name, self.releaser.unit.name, value)
      self.player:changeAttribute({
        name = BuffAtts[self.effectValue1],
        value = value
      })
    end
    
    function Buff:_effect()
      if self.recordCount >= self.effectValue2 then
        return
      end
      self.recordCount = self.recordCount + 1
      self.player:setAttrDirty()
      if self.recordCount % self.effectValue3 == 0 then
        self:onEffect()
      end
    end
    
    function Buff:_recordValue(params)
      self.recordCount = 1
      self.recordValue = self.effectValue
    end
  end,
  [62] = function(Buff)
    function Buff:_attrChange()
      local value = self.recordValue * self.recordCount
      
      printInfo("Buff62:%s buffId-%s player-%s releaser-%s value-%s", BuffAtts[self.effectValue1], self.id, self.player.unit.name, self.releaser.unit.name, value)
      self.player:changeAttribute({
        name = BuffAtts[self.effectValue1],
        value = value
      })
    end
    
    function Buff:_effect()
      self.leftTime = self.csvData.keepTime
      if self.recordCount >= self.effectValue2 then
        return
      end
      self.recordCount = self.recordCount + 1
      self.player:setAttrDirty()
      if self.recordCount % self.effectValue3 == 0 then
        self:onEffect()
      end
    end
    
    function Buff:_recordValue(params)
      self.recordCount = 1
      self.recordValue = self.effectValue
    end
  end,
  [64] = function(Buff)
    function Buff:_effect(hurtValue)
      self.recordValue = self.recordValue - hurtValue
      
      printInfo("Buff64: player:%s buffId-%s value-%s", self.player.unit.name, self.id, self.recordValue)
      local returnValue = self.recordValue >= 0 and 0 or -self.recordValue
      if self.recordValue <= 0 then
        self.leftTime = 0
        self.recordValue = 0
      end
      self.player:onChangeShield()
      return returnValue
    end
    
    function Buff:_recordValue(params)
      local hurtValue = params.hurtValue
      self.recordValue = hurtValue * self.effectValue / 100
      self.recordCount = 1
    end
    
    function Buff:_sheildChange(params)
      if self.recordCount >= self.effectValue1 then
        return
      end
      self.leftTime = self.csvData.keepTime
      self.recordCount = self.recordCount + 1
      local hurtValue = params.hurtValue
      self.recordValue = hurtValue * self.effectValue / 100 + self.recordValue
      self.player:onChangeShield()
    end
  end,
  [65] = function(Buff)
    function Buff:_update()
      local value = self.recordValue
      
      printInfo("Buff65: player:%s buffId-%s value-%s", self.player.unit.name, self.id, value)
      local hurtParams = {
        hurtValue = value,
        hurtType = "normal",
        releaser = self.releaser
      }
      if self.skillId then
        hurtParams.skillId = self.skillId
        hurtParams.sumHurt = self.sumHurt
      end
      hurtParams.buffType = 2
      hurtParams.buffId = self.id
      self.player:beginHurt(hurtParams)
    end
    
    function Buff:_recordValue(params)
      if self.effectValue1 == 1 then
        local attr = "curHit"
        self.recordValue = self.releaser[attr] * self.effectValue / 100
      else
        self.recordValue = self.effectValue
      end
      local buffSet = {}
      if type(self.effectValue3) ~= "number" then
        buffSet = self.effectValue3:toArray("=", true)
      else
        buffSet[1] = self.effectValue3
      end
      for _, buffId in ipairs(buffSet) do
        if self.player.buffIds[buffId] and self.player.buffIds[buffId].num > 0 then
          self.recordValue = self.recordValue * self.effectValue2
          break
        end
      end
    end
  end,
  [66] = function(Buff)
    function Buff:_update()
      local value = self.recordValue
      
      printInfo("Buff66: player:%s buffId-%s value-%s", self.player.unit.name, self.id, value)
      local hurtParams = {
        hurtValue = value,
        hurtType = "undefendable",
        releaser = self.releaser
      }
      if self.skillId then
        hurtParams.skillId = self.skillId
        hurtParams.sumHurt = self.sumHurt
      end
      hurtParams.buffType = 2
      hurtParams.buffId = self.id
      self.player:beginHurt(hurtParams)
    end
    
    function Buff:_recordValue(params)
      if self.effectValue1 == 1 then
        local attrValue = self.releaser.curAtk
        attrValue = attrValue + self.releaser.curTrueAtk ^ 1.2 / (6 + self.releaser.curTrueAtk / 5000)
        self.recordValue = attrValue * self.effectValue / 100
      else
        self.recordValue = self.effectValue
      end
      local proSet = {}
      local professions = {}
      if type(self.effectValue3) ~= "number" then
        proSet = self.effectValue3:toArray("=", true)
      else
        proSet[1] = self.effectValue3
      end
      for _, profession in ipairs(proSet) do
        professions[profession] = true
      end
      if professions[self.player.unit.profession] then
        self.recordValue = self.recordValue * self.effectValue2
      end
    end
  end,
  [67] = function(Buff)
    function Buff:_update()
      local value = self.recordValue.hurtValue
      
      if self.player.hp > self.recordValue.hp then
        return
      end
      printInfo("Buff67: player:%s buffId-%s value-%s", self.player.unit.name, self.id, value)
      local hurtParams = {
        hurtValue = value,
        hurtType = "kill",
        releaser = self.releaser
      }
      if self.skillId then
        hurtParams.skillId = self.skillId
        hurtParams.sumHurt = self.sumHurt
      end
      hurtParams.buffType = 150
      hurtParams.buffId = self.id
      hurtParams.buffBaseId = 67
      self.player:beginHurt(hurtParams)
    end
    
    function Buff:_recordValue(params)
      self.recordValue = {}
      self.recordValue.hp = self.player.fullHp * tonumber(self.effectValue3) / 100
      if self.effectValue1 == 1 then
        local player = self.releaser
        local attr = BuffAtts[self.effectValue2]
        if attr == "Hp" then
          attr = "fullHp"
        else
          attr = "cur" .. attr
        end
        local attrValue = player[attr]
        if attr == "curAtk" then
          attrValue = player.curAtk + player.curTrueAtk ^ 1.2 / (6 + player.curTrueAtk / 5000)
        end
        self.recordValue.hurtValue = attrValue * self.effectValue / 100
      else
        self.recordValue.hurtValue = self.effectValue
      end
    end
  end,
  [68] = function(Buff)
    function Buff:_effect(hurtValue, causeBuffId, causeBuffType)
      local players = self.player.battle:getPlayers(self.player.otherSide)
      
      local playersNum = #players
      local ratio = 5 < playersNum and self.recordValue[5] or self.recordValue[playersNum]
      if not ratio then
        return {numValue = 0, ratio = 0}
      end
      if self.effectValue and self.effectValue ~= causeBuffId then
        return {numValue = 0, ratio = 0}
      end
      if self.effectValue1 and self.effectValue1 ~= causeBuffType then
        return {numValue = 0, ratio = 0}
      end
      local returnValue = hurtValue * (ratio / 100)
      printInfo("Buff68: player:%s buffId-%s value-%s ratio-%s", self.player.unit.name, self.id, returnValue, ratio)
      return {numValue = returnValue, ratio = ratio}
    end
    
    function Buff:_recordValue(params)
      self.recordValue = {}
      if type(self.effectValue3) == "number" then
        self.recordValue[1] = self.effectValue3
      else
        local values = self.effectValue3:toArray("=", true)
        for i, v in ipairs(values) do
          self.recordValue[i] = v
        end
      end
    end
  end,
  [69] = function(Buff)
    function Buff:_effect(hurtValue, skillId)
      local returnValue = 0
      
      if not self.skillSet[skillId] then
        return {numValue = 0, ratio = 0}
      end
      local ratio = 0
      if self.player.hp > self.recordValue and self.effectValue2 == 0 then
        returnValue = hurtValue * (self.effectValue1 / 100)
        ratio = self.effectValue1
      elseif self.player.hp < self.recordValue and self.effectValue2 == 1 then
        returnValue = hurtValue * (self.effectValue1 / 100)
        ratio = self.effectValue1
      end
      printInfo("Buff69: player:%s buffId-%s value-%s ratio-%s", self.player.unit.name, self.id, returnValue, ratio)
      return {numValue = returnValue, ratio = ratio}
    end
    
    function Buff:_recordValue(params)
      self.recordValue = self.player.fullHp * (self.effectValue / 100)
      self.skillSet = {}
      if type(self.effectValue3) == "number" then
        self.skillSet[self.effectValue3] = 1
      else
        for _, skillId in pairs(self.effectValue3:toArray("=", true)) do
          self.skillSet[skillId] = 1
        end
      end
    end
  end,
  [70] = function(Buff)
    function Buff:_update()
      local value = self.recordValue
      
      local hurtType = "specialBuff"
      local hurtParams = {
        hurtValue = value,
        hurtType = hurtType,
        releaser = self.releaser,
        curCrit = self.releaser.curCrit,
        curCritHurt = self.releaser.curCritHurt
      }
      if self.skillId then
        hurtParams.skillId = self.skillId
        hurtParams.sumHurt = self.sumHurt
      end
      printInfo("Buff70: player:%s buffId-%s value-%s", self.player.unit.name, self.id, value)
      if not self.player:hasBuff(151) and not self.releaser:hasBuff(154) and not self.releaser:hasBuff(157) then
        hurtParams.buffType = 70
        hurtParams.buffId = self.id
        self.player:beginHurt(hurtParams)
      end
    end
    
    function Buff:_recordValue(params)
      if self.effectValue1 == 1 then
        local player = self.effectValue3 == 1 and self.player or self.releaser
        local attr = BuffAtts[self.effectValue2]
        if attr == "Hp" then
          attr = "fullHp"
        else
          attr = "cur" .. attr
        end
        local attrValue = player[attr]
        if attr == "curAtk" then
          attrValue = player.curAtk + player.curTrueAtk ^ 1.2 / (6 + player.curTrueAtk / 5000)
        end
        self.recordValue = attrValue * self.effectValue / 100
      else
        self.recordValue = self.effectValue
      end
    end
  end,
  [71] = function(Buff)
    function Buff:_effect(hurtValue)
      local numValue = self.recordValue
      
      local ratio = 0
      printInfo("Buff71: player:%s buffId-%s value-%s ratio-%s", self.player.unit.name, self.id, numValue, ratio)
      return {numValue = numValue, ratio = ratio}
    end
    
    function Buff:_recordValue(params)
      if self.effectValue1 == 1 then
        local player = self.effectValue3 == 1 and self.player or self.releaser
        local attr = BuffAtts[self.effectValue2]
        if attr == "Hp" then
          attr = "fullHp"
        else
          attr = "cur" .. attr
        end
        self.recordValue = player[attr] * self.effectValue / 100
      else
        self.recordValue = self.effectValue
      end
    end
  end,
  [72] = function(Buff)
    function Buff:_update()
      if self.leftTime <= self.StatusTime and self.StatusTag == 2 then
        self.StatusTag = 1
        
        self.totalHurtValue = self.player.totalAttackValue + self.effectValue
        for _, buffId in ipairs(self.buffSet2) do
          if self.player:hasBuffById(buffId) then
            for _, buff in ipairs(self.player.buffIds[buffId].buffs) do
              buff:endBuff()
            end
          end
        end
        for _, buffId in ipairs(self.buffSet1) do
          self.player:addBuff({
            buffId = buffId,
            releaser = self.player
          })
        end
      end
      if self.player.totalAttackValue > self.totalHurtValue and self.StatusTag == 1 then
        self.StatusTag = 2
        self.StatusTime = self.leftTime - self.effectValue1
        for _, buffId in ipairs(self.buffSet1) do
          if self.player:hasBuffById(buffId) then
            for _, buff in ipairs(self.player.buffIds[buffId].buffs) do
              buff:endBuff()
            end
          end
        end
        for _, buffId in ipairs(self.buffSet2) do
          self.player:addBuff({
            buffId = buffId,
            releaser = self.player
          })
        end
      end
    end
    
    function Buff:_recordValue(params)
      self.StatusTag = 2
      self.StatusTime = self.leftTime
      local buffSet = self.effectValue3:toArray(" ", false)
      self.buffSet1 = buffSet[1]:toArray("=", true)
      self.buffSet2 = buffSet[2]:toArray("=", true)
      self.totalHurtValue = self.player.totalAttackValue + self.effectValue
    end
  end,
  [73] = function(Buff)
    function Buff:_update()
      if self.player.totalAttackValue > self.totalHurtValue then
        local count = math.floor((self.player.totalAttackValue - self.totalHurtValue) / self.effectValue) + 1
        
        self.totalHurtValue = self.player.totalAttackValue + self.effectValue
        for i = 1, count do
          self.player:addBuff({
            buffId = tonumber(self.effectValue3),
            releaser = self.player
          })
        end
      end
    end
    
    function Buff:_recordValue(params)
      self.totalHurtValue = self.player.totalAttackValue + self.effectValue
    end
  end,
  [74] = function(Buff)
    function Buff:_effect(hurtValue)
      if self.recordValue <= 0 then
        return hurtValue
      end
      self.recordValue = self.recordValue - hurtValue
      printInfo("Buff74: player:%s buffId-%s value-%s", self.player.unit.name, self.id, self.recordValue)
      local returnValue = self.recordValue >= 0 and 0 or -self.recordValue
      if self.recordValue < 0 then
        self.recordValue = 0
      end
      self.player:onChangeShield()
      return returnValue
    end
    
    function Buff:_recordValue(params)
      self.recordValue = 0
    end
    
    function Buff:_sheildChange(params)
      local hurtValue = params.hurtValue
      self.recordValue = hurtValue * self.effectValue / 100 + self.recordValue
      self.player:onChangeShield()
    end
  end,
  [75] = function(Buff)
    function Buff:_effect(hurtValue)
      self.recordValue = self.recordValue + hurtValue
    end
    
    function Buff:_end()
      local limiteValue = math.min(self.player.fullHp * self.effectValue / 100, self.player.fullHp)
      if limiteValue <= self.recordValue then
        local newValue = self.recordValue * self.effectValue1 / 100
        local hurtParams = {
          hurtValue = newValue,
          hurtType = "tomato",
          releaser = self.releaser
        }
        if self.skillId then
          hurtParams.skillId = self.skillId
          hurtParams.sumHurt = self.sumHurt
        end
        printInfo("Buff75: player:%s buffId-%s value-%s", self.player.unit.name, self.id, self.recordValue)
        hurtParams.buffType = 2
        hurtParams.buffId = self.id
        self.player:beginHurt(hurtParams)
      end
    end
    
    function Buff:_recordValue(params)
      self.recordValue = 0
    end
  end,
  [76] = function(Buff)
    function Buff:_levelChange(skillId)
      if self.player:isSpecial(skillId) or self.recordCount >= self.effectValue1 or self.recordTime ~= 0 then
        return
      end
      self.recordCount = self.recordCount + 1
      printInfo("Buff76: player:%s buffId-%s addLevel to-%s", self.player.unit.name, self.id, self.recordCount)
      if self.recordCount >= self.effectValue1 then
        for _, id in pairs(self.recordValue) do
          self.player:addBuff({
            buffId = id,
            releaser = self.player
          })
        end
      end
    end
    
    function Buff:_effect(hurtValue, skillId)
      if self.player:isSpecial(skillId) and self.recordTime == 0 then
        self.isEffected = true
        self.recordTime = self.leftTime - self.effectValue2
      end
      local returnValue = 0
      if self.recordTime == 0 then
        return returnValue
      end
      returnValue = self.recordCount * self.effectValue / 100 * hurtValue
      for _, buffId in ipairs(self.recordValue) do
        if self.player:hasBuffById(buffId) then
          for _, buff in ipairs(self.player.buffIds[buffId].buffs) do
            buff:endBuff()
          end
        end
      end
      printInfo("Buff76: player:%s buffId-%s value-%s", self.player.unit.name, self.id, returnValue)
      return returnValue
    end
    
    function Buff:_recordValue(params)
      local level = params.level or 0
      self.recordCount, self.recordTime = math.min(level, self.effectValue1), 0
      self.recordValue = {}
      if self.effectValue3 == 0 then
        return
      end
      self.recordValue = type(self.effectValue3) == "number" and {
        self.effectValue3
      } or self.effectValue3:toArray("=", true)
    end
    
    function Buff:_update()
      if not self.isEffected then
        self.leftTime = self.csvData.keepTime
      end
      if self.recordTime ~= 0 and self.recordTime >= self.leftTime then
        self.recordTime, self.recordCount = 0, 0
      end
    end
    
    function Buff:_end()
      self.player:addBuff({
        buffId = self.id,
        releaser = self.player,
        level = self.recordCount
      })
    end
  end,
  [77] = function(Buff)
    function Buff:_effect(hurtValue)
      local targetsType = {
        [1] = function()
          return self.player.battle:getTeamers(self.player)
        end,
        [2] = function()
          return self.player.battle:getPlayers(self.player.side)
        end
      }
      local targets = self.effectValue1 == 0 and {
        self.player
      } or targetsType[self.effectValue1]()
      for _, player in ipairs(targets) do
        if player:hasBuffById(self.effectValue) then
          for _, buff in ipairs(player.buffIds[self.effectValue].buffs) do
            buff:sheildChange(hurtValue)
          end
        end
      end
    end
  end,
  [78] = function(Buff)
    function Buff:_effect(hurtValue)
      if self.recordValue <= 0 then
        return hurtValue
      end
      self.recordValue = self.recordValue - hurtValue
      printInfo("Buff78: player:%s buffId-%s value-%s", self.player.unit.name, self.id, self.recordValue)
      local returnValue = self.recordValue >= 0 and 0 or -self.recordValue
      if self.recordValue < 0 then
        self.recordValue = 0
      end
      self.player:onChangeShield()
      return returnValue
    end
    
    function Buff:_recordValue(params)
      self.recordValue = 0
    end
    
    function Buff:_update()
      if not self.display then
        return
      end
      if self.recordValue == 0 then
        self.display:hide()
      end
    end
    
    function Buff:_sheildChange(hurtValue)
      self.recordValue = hurtValue * self.effectValue / 100 + self.recordValue
      self.display:show()
      self.player:onChangeShield()
    end
  end,
  [79] = function(Buff)
    function Buff:_effect(hurtValue)
      self.recordValue.hurtValue = self.recordValue.hurtValue + hurtValue
      
      self.transmitValue = math.ceil(self.recordValue.hurtValue / self.effectValue)
      printInfo("Buff79: player:%s buffId-%s value-%s", self.player.unit.name, self.id, self.recordValue.hurtValue)
    end
    
    function Buff:_recordValue(params)
      self.recordValue = {}
      self.recordValue.hurtValue = 0
      self.transmitValue = 0
      self.recordValue.buffIds = type(self.effectValue3) == "number" and {
        self.effectValue3
      } or self.effectValue3:toArray("=", true)
    end
  end,
  [80] = function(Buff)
    function Buff:_update()
      local value = self.recordValue
      
      printInfo("Buff80: player:%s buffId-%s value-%s", self.player.unit.name, self.id, value)
      local hurtParams = {
        hurtValue = value,
        hurtType = "normal",
        releaser = self.releaser,
        hurtTag = "trueHurt"
      }
      if self.skillId then
        hurtParams.skillId = self.skillId
        hurtParams.sumHurt = self.sumHurt
      end
      hurtParams.buffType = 70
      hurtParams.buffId = self.id
      self.player:beginHurt(hurtParams)
    end
    
    function Buff:_recordValue(params)
      local subValue = 0
      if self.releaser:hasBuff(79) then
        for _, buff in ipairs(self.releaser.buffTypes[79]) do
          if table.keyof(buff.recordValue.buffIds, self.id) then
            subValue = buff.transmitValue
            break
          end
        end
      end
      if self.effectValue1 == 1 then
        local player = self.effectValue3 == 1 and self.player or self.releaser
        local attr = BuffAtts[self.effectValue2]
        if attr == "Hp" then
          attr = "fullHp"
        else
          attr = "cur" .. attr
        end
        local attrValue = player[attr]
        if attr == "curAtk" then
          attrValue = player.curAtk + player.curTrueAtk ^ 1.2 / (6 + player.curTrueAtk / 5000)
        end
        self.recordValue = attrValue * self.effectValue / 100
      else
        self.recordValue = self.effectValue
      end
      self.recordValue = self.recordValue - subValue
      if 0 >= self.recordValue then
        self.recordValue = 1
      end
      printInfo("Buff80: player:%s buffId-%s subvalue-%s", self.player.unit.name, self.id, subValue)
    end
  end,
  [81] = function(Buff)
    function Buff:_effect(hurtValue)
      for _, key in ipairs(self.player.buffReaction) do
        if key == self.effectValue1 then
          local returnValue = hurtValue * (self.effectValue / 100)
          
          printInfo("Buff81: player:%s buffId-%s value-%s ratio-%s", self.player.unit.name, self.id, returnValue, self.effectValue)
          return {
            numValue = returnValue,
            ratio = self.effectValue
          }
        end
      end
      return {numValue = 0, ratio = 0}
    end
  end,
  [90] = function(Buff)
    function Buff:_effect(hurtValue, player)
      local debuffTag = false
      
      for buffId, buffSet in pairs(player.buffIds) do
        local debuff = buffSet.buffs[1].csvData.debuff
        if debuff == 1 then
          debuffTag = true
          break
        end
      end
      if debuffTag then
        local numValue = hurtValue * (self.effectValue / 100)
        local ratio = self.effectValue
        printInfo("Buff90: player:%s buffId-%s value-%s ratio-%s", self.player.unit.name, self.id, numValue, ratio)
        return {numValue = numValue, ratio = ratio}
      end
      return {numValue = 0, ratio = 0}
    end
  end,
  [91] = function(Buff)
    function Buff:_attrChange()
      local value = self.recordValue * self.recordCount
      
      printInfo("Buff91:%s buffId-%s player-%s releaser-%s level-%s value-%s", BuffAtts[self.effectValue1], self.id, self.player.unit.name, self.releaser.unit.name, self.recordCount, value)
      self.player:changeAttribute({
        name = BuffAtts[self.effectValue1],
        value = value
      })
    end
    
    function Buff:_levelChange()
      self.leftTime = self.csvData.keepTime
      if self.recordCount >= self.effectValue2 then
        return
      end
      self.recordCount = self.recordCount + 1
      self.player:setAttrDirty()
      if self.effectValue3 == 0 then
        return
      end
      self.player:addBuff({
        buffId = self.effectValue3,
        releaser = self.releaser
      })
    end
    
    function Buff:_recordValue(params)
      self.recordCount = 1
      self.recordValue = self.effectValue
      if self.effectValue3 ~= 0 then
        self.player:addBuff({
          buffId = self.effectValue3,
          releaser = self.releaser
        })
      end
      if self.effectValue1 == 6 or self.effectValue1 == 7 then
        self.recordValue = self.effectValue * 10
      else
        local attrValue = self.player:getBaseAttribute(self.effectValue1)
        self.recordValue = attrValue * self.effectValue / 100
      end
    end
    
    function Buff:_end()
      if self.effectValue3 ~= 0 and self.player:hasBuffById(self.effectValue3) then
        for _, buff in ipairs(self.player.buffIds[self.effectValue3].buffs) do
          buff:endBuff()
        end
      end
    end
  end,
  [92] = function(Buff)
    function Buff:_effect(hurtValue)
      local isEffect = true
      
      for _, enemy in ipairs(self.player.battle:getPlayers(self.player.otherSide)) do
        if enemy:hasShield() then
          isEffect = false
          break
        end
      end
      local numValue, ratio = 0, 0
      if isEffect then
        numValue = hurtValue * self.recordValue
        ratio = self.effectValue
      end
      printInfo("Buff92: player:%s buffId-%s value-%s, ratio-%s", self.player.unit.name, self.id, numValue, ratio)
      return {numValue = numValue, ratio = ratio}
    end
    
    function Buff:_recordValue(params)
      self.recordValue = self.effectValue / 100
    end
  end,
  [93] = function(Buff)
    function Buff:_end()
      self.player.neverMoveBack = false
    end
    
    function Buff:_recordValue(params)
      self.player.neverMoveBack = true
    end
  end,
  [94] = function(Buff)
    function Buff:_attrChange()
      local value = self.recordValue
      
      if value == 0 then
        return
      end
      printInfo("Buff94:%s buffId-%s player-%s releaser-%s value-%s", BuffAtts[self.effectValue], self.id, self.player.unit.name, self.releaser.unit.name, value)
      self.player:changeAttribute({
        name = BuffAtts[self.effectValue],
        value = value
      })
    end
    
    function Buff:_update()
      if not self.isEffect then
        return
      end
      if not self.player:hasBuff(79) then
        if self.recordValue ~= 0 then
          self.isEffect = false
        end
        return
      end
      for _, buff in ipairs(self.player.buffTypes[79]) do
        if table.keyof(buff.recordValue.buffIds, self.id) and self.recordValue ~= buff.transmitValue then
          self.recordValue = buff.transmitValue
          self.player:setAttrDirty()
          break
        end
      end
    end
    
    function Buff:_recordValue(params)
      self.recordValue = 0
      self.isEffect = true
      if not self.player:hasBuff(79) then
        return
      end
      for _, buff in ipairs(self.player.buffTypes[79]) do
        if table.keyof(buff.recordValue.buffIds, self.id) then
          self.recordValue = buff.transmitValue
          self.player:setAttrDirty()
          break
        end
      end
    end
  end,
  [95] = function(Buff)
    function Buff:_update()
      local value = self.recordValue
      
      printInfo("Buff95: player:%s buffId-%s value-%s", self.player.unit.name, self.id, value)
      local hurtParams = {
        hurtValue = value,
        hurtType = "holycrash",
        releaser = self.releaser,
        hurtTag = "trueHurt"
      }
      if self.skillId then
        hurtParams.skillId = self.skillId
        hurtParams.sumHurt = self.sumHurt
      end
      hurtParams.buffType = 2
      hurtParams.buffId = self.id
      self.player:beginHurt(hurtParams)
    end
    
    function Buff:_recordValue(params)
      if self.effectValue1 == 1 then
        local player = self.effectValue3 == 1 and self.player or self.releaser
        local attr = BuffAtts[self.effectValue2]
        if attr == "Hp" then
          attr = "fullHp"
        else
          attr = "cur" .. attr
        end
        local attrValue = player[attr]
        if attr == "curAtk" then
          attrValue = player.curAtk + player.curTrueAtk ^ 1.2 / (6 + player.curTrueAtk / 5000)
        end
        self.recordValue = attrValue * self.effectValue / 100
      else
        self.recordValue = self.effectValue
      end
    end
  end,
  [96] = function(Buff)
    function Buff:_effect(hurtValue)
      if 0 < hurtValue and hurtValue > self.player.hp then
        local overflow = (hurtValue - self.player.hp) * self.effectValue / 100
        
        return overflow
      end
      return 0
    end
  end,
  [97] = function(Buff)
    function Buff:_update()
      if not self.player:hasBuffById(self.effectValue1) then
        return
      end
      local buffCount = self.player.buffIds[self.effectValue1].num
      self.recordCount = buffCount
      if self.recordCount >= self.effectValue then
        printInfo("Buff97 is effect: player:%s buffId-%s", self.player.unit.name, self.id)
        local buffAmount = self.player.buffIds[self.effectValue1].num
        local count = math.floor(buffAmount / self.effectValue)
        for i = 1, count do
          for _, id in pairs(self.recordValue) do
            self.player:addBuff({
              buffId = id,
              releaser = self.releaser
            })
          end
        end
        local endCount = 0
        local endList = {}
        for _, buff in pairs(self.player.buffIds[self.effectValue1].buffs) do
          table.insert(endList, buff)
          endCount = endCount + 1
          if endCount >= count * self.effectValue then
            break
          end
        end
        for _, buff in ipairs(endList) do
          buff:endBuff()
          if self.player.buffIds[self.effectValue1] then
            table.remove(self.player.buffIds[self.effectValue1].buffs, 1)
          end
        end
      end
    end
    
    function Buff:_recordValue(params)
      printInfo("Buff97: player:%s buffId-%s", self.player.unit.name, self.id)
      self.recordCount = 0
      self.recordValue = type(self.effectValue3) == "number" and {
        self.effectValue3
      } or self.effectValue3:toArray("=", true)
    end
  end,
  [98] = function(Buff)
    function Buff:_effect(hurtValue, releaser)
      local recordValue = {buffCount = 0, debuffCount = 0}
      
      local player = self.effectValue3 == 1 and releaser or self.player
      for buffId, buffSet in pairs(player.buffIds) do
        local debuff = buffSet.buffs[1].csvData.debuff
        if debuff == 1 then
          recordValue.debuffCount = recordValue.debuffCount + 1
        end
        if debuff == -1 then
          recordValue.buffCount = recordValue.buffCount + 1
        end
      end
      self.recordValue = recordValue
      local count = self.effectValue1 == 1 and self.recordValue.debuffCount or self.recordValue.buffCount
      count = math.min(self.effectValue2, count)
      local returnValue = hurtValue * (self.effectValue * count / 100)
      local ratio = self.effectValue * count
      printInfo("Buff98: player:%s buffId-%s value-%s ratio-%s", self.player.unit.name, self.id, returnValue, ratio)
      return {numValue = returnValue, ratio = ratio}
    end
    
    function Buff:_recordValue(params)
      self.recordValue = {buffCount = 0, debuffCount = 0}
    end
  end,
  [99] = function(Buff)
    function Buff:_effect(hurtValue)
      local player = self.effectValue1 == 1 and self.player or self.releaser
      
      if player.hp <= self.recordValue.lower or player.hp > self.recordValue.upper then
        return {numValue = 0, ratio = 0}
      end
      local numValue = hurtValue * (self.effectValue / 100)
      local ratio = self.effectValue
      printInfo("Buff99: player:%s buffId-%s value-%s ratio-%s", self.player.unit.name, self.id, numValue, ratio)
      return {numValue = numValue, ratio = ratio}
    end
    
    function Buff:_update()
      if not self.display then
        return
      end
      local player = self.effectValue1 == 1 and self.player or self.releaser
      if player.hp <= self.recordValue.lower or player.hp > self.recordValue.upper then
        self.display:hide()
        return
      end
      self.display:show()
    end
    
    function Buff:_recordValue(params)
      local player = self.effectValue1 == 1 and self.player or self.releaser
      local hpPercents = self.effectValue3:toArray("=", true)
      self.recordValue = {
        lower = math.floor(hpPercents[1] * player.fullHp / 100),
        upper = math.ceil(hpPercents[2] * player.fullHp / 100)
      }
      self.recordValue.upper = math.min(self.recordValue.upper, player.fullHp)
      self.recordValue.lower = math.max(self.recordValue.lower, 0)
    end
  end,
  [102] = function(Buff)
    function Buff:_effect(hurtValue)
      local player = self.effectValue1 == 1 and self.player or self.releaser
      
      if player.hp <= self.recordValue.lower or player.hp > self.recordValue.upper then
        return {numValue = 0, ratio = 0}
      end
      local numValue = hurtValue * (self.effectValue / 100)
      local ratio = self.effectValue
      printInfo("Buff102: player:%s buffId-%s value-%s ratio-%s", self.player.unit.name, self.id, numValue, ratio)
      return {numValue = numValue, ratio = ratio}
    end
    
    function Buff:_update()
      if not self.display then
        return
      end
      local player = self.effectValue1 == 1 and self.player or self.releaser
      if player.hp <= self.recordValue.lower or player.hp > self.recordValue.upper then
        self.display:hide()
        return
      end
      self.display:show()
    end
    
    function Buff:_recordValue(params)
      local player = self.effectValue1 == 1 and self.player or self.releaser
      local hpPercents = self.effectValue3:toArray("=", true)
      self.recordValue = {
        lower = hpPercents[1] * player.fullHp / 100,
        upper = hpPercents[2] * player.fullHp / 100
      }
      self.recordValue.upper = math.min(self.recordValue.upper, player.fullHp)
      self.recordValue.lower = math.max(self.recordValue.lower, 0)
    end
  end,
  [103] = function(Buff)
    function Buff:_effect(hurtValue, releaser)
      local players = self.player.battle:getPlayers(self.player.side)
      
      for _, player in ipairs(players) do
        if player:hasBuffById(self.effectValue) then
          for _, buff in ipairs(player.buffIds[self.effectValue].buffs) do
            buff:sheildChange(hurtValue)
          end
        end
      end
    end
  end,
  [104] = function(Buff)
    function Buff:_effect(hurtValue)
      local returnValue = 0
      
      returnValue = hurtValue * (self.effectValue * self.recordLevel / 100)
      local ratio = self.effectValue * self.recordLevel
      printInfo("Buff104: player:%s buffId-%s value-%s ratio-%s", self.player.unit.name, self.id, returnValue, ratio)
      return {numValue = returnValue, ratio = ratio}
    end
    
    function Buff:_levelChange()
      self.leftTime = self.csvData.keepTime
      if self.recordLevel >= self.effectValue2 then
        return
      end
      self.recordLevel = self.recordLevel + 1
      if self.effectValue3 == 0 then
        return
      end
      self.player:addBuff({
        buffId = self.effectValue3,
        releaser = self.releaser
      })
    end
    
    function Buff:_recordValue(params)
      self.recordLevel = 1
      if self.effectValue3 ~= 0 then
        self.player:addBuff({
          buffId = self.effectValue3,
          releaser = self.releaser
        })
      end
    end
    
    function Buff:_end()
      if self.effectValue3 == 0 then
        return
      end
      if self.player:hasBuffById(self.effectValue3) then
        for _, buff in ipairs(self.player.buffIds[self.effectValue3].buffs) do
          buff:endBuff()
        end
      end
    end
  end,
  [106] = function(Buff)
    function Buff:_update()
      if not self.player:hasBuffById(self.effectValue) then
        return
      end
      if self.player.buffIds[self.effectValue].num < self.effectValue1 then
        return
      end
      local endCount = 0
      local endList = {}
      for _, buff in pairs(self.player.buffIds[self.effectValue].buffs) do
        table.insert(endList, buff)
        endCount = endCount + 1
        if endCount >= self.effectValue1 then
          break
        end
      end
      for _, buff in ipairs(endList) do
        buff:endBuff()
        if self.player.buffIds[self.effectValue] then
          table.remove(self.player.buffIds[self.effectValue].buffs, 1)
        end
      end
    end
  end,
  [107] = function(Buff)
    function Buff:_update()
      for _, player in pairs(self.recordValue.targets) do
        for _, id in pairs(self.recordValue.buffSet) do
          player:addBuff({
            buffId = id,
            
            releaser = self.releaser
          })
        end
      end
    end
    
    function Buff:_recordValue(params)
      local targetsType = {
        [1] = function()
          local targets = {}
          table.insert(targets, self.player)
          return targets
        end,
        [2] = function()
          return self.player.battle:getTeamers(self.player)
        end,
        [3] = function()
          local targets = {}
          local enemys = self.player.battle:getPlayers(self.player.otherSide)
          for _, enemy in ipairs(enemys) do
            if enemy.unit.profession == 3 or enemy.unit.profession == 4 then
              table.insert(targets, enemy)
            end
          end
          local index = math.randomInt(1, #targets)
          local target = {}
          table.insert(target, targets[index])
          return target
        end
      }
      self.recordValue = {}
      self.recordValue.buffSet = type(self.effectValue3) == "number" and {
        self.effectValue3
      } or self.effectValue3:toArray("=", true)
      self.recordValue.targets = targetsType[self.effectValue]()
    end
  end,
  [108] = function(Buff)
    function Buff:_effect(hurtValue)
      local numValue = self.recordValue
      
      local ratio = 0
      printInfo("Buff108: player:%s buffId-%s value-%s ratio-%s", self.player.unit.name, self.id, numValue, ratio)
      return {numValue = numValue, ratio = ratio}
    end
    
    function Buff:_recordValue(params)
      if self.effectValue1 == 1 then
        local player = self.effectValue3 == 1 and self.player or self.releaser
        local attr = BuffAtts[self.effectValue2]
        if attr == "Hp" then
          attr = "fullHp"
        else
          attr = "cur" .. attr
        end
        self.recordValue = player[attr] * self.effectValue / 100
      else
        self.recordValue = self.effectValue
      end
    end
  end,
  [109] = function(Buff)
    function Buff:_effect(hurtValue, hurtPlayer)
      local recordValue = {buffCount = 0, debuffCount = 0}
      
      local player = self.effectValue3 == 1 and self.player or hurtPlayer
      for buffId, buffSet in pairs(player.buffIds) do
        local debuff = buffSet.buffs[1].csvData.debuff
        if debuff == 1 then
          recordValue.debuffCount = recordValue.debuffCount + 1
        end
        if debuff == -1 then
          recordValue.buffCount = recordValue.buffCount + 1
        end
      end
      self.recordValue = recordValue
      local count = self.effectValue1 == 1 and self.recordValue.debuffCount or self.recordValue.buffCount
      count = math.min(self.effectValue2, count)
      local returnValue = hurtValue * (self.effectValue * count / 100)
      local ratio = self.effectValue * count
      printInfo("Buff109: player:%s buffId-%s value-%s ratio-%s", self.player.unit.name, self.id, returnValue, ratio)
      return {numValue = returnValue, ratio = ratio}
    end
    
    function Buff:_recordValue(params)
      self.recordValue = {buffCount = 0, debuffCount = 0}
    end
  end,
  [110] = function(Buff)
    function Buff:_effect(hurtValue)
      local returnValue = 0
      
      returnValue = hurtValue * (self.effectValue * self.recordLevel / 100)
      local ratio = self.effectValue * self.recordLevel
      printInfo("Buff110: player:%s buffId-%s value-%s ratio-%s", self.player.unit.name, self.id, returnValue, ratio)
      return {numValue = returnValue, ratio = ratio}
    end
    
    function Buff:_levelChange()
      self.leftTime = self.csvData.keepTime
      if self.recordLevel >= self.effectValue2 then
        return
      end
      self.recordLevel = self.recordLevel + 1
      if self.effectValue3 ~= 0 then
        self.player:addBuff({
          buffId = self.effectValue3,
          releaser = self.releaser
        })
      end
    end
    
    function Buff:_recordValue(params)
      self.recordLevel = 1
      if self.effectValue3 ~= 0 then
        self.player:addBuff({
          buffId = self.effectValue3,
          releaser = self.releaser
        })
      end
    end
    
    function Buff:_end()
      if self.effectValue3 == 0 then
        return
      end
      if self.player:hasBuffById(self.effectValue3) then
        for _, buff in ipairs(self.player.buffIds[self.effectValue3].buffs) do
          buff:endBuff()
        end
      end
    end
  end,
  [111] = function(Buff)
    function Buff:_effect(hurtValue)
      local checkPlayer = {}
      
      for _, player in pairs(self.player.battle:getPlayers(self.player.otherSide)) do
        for _, buff in ipairs(self.recordValue) do
          if player:hasBuff(buff) then
            table.insert(checkPlayer, player)
          end
        end
      end
      local playersNum = #checkPlayer
      local ratio = playersNum * self.effectValue
      if not ratio then
        return {numValue = 0, ratio = 0}
      end
      local returnValue = hurtValue * (ratio / 100)
      printInfo("Buff111: player:%s buffId-%s value-%s ratio-%s", self.player.unit.name, self.id, returnValue, ratio)
      return {numValue = returnValue, ratio = ratio}
    end
    
    function Buff:_recordValue(params)
      self.recordValue = type(self.effectValue3) == "number" and {
        self.effectValue3
      } or self.effectValue3:toArray("=", true)
    end
  end,
  [112] = function(Buff)
    function Buff:_effect()
      return self.effectValue / 100
    end
  end,
  [113] = function(Buff)
    function Buff:_recordValue(params)
      self.recordValue = type(self.effectValue3) == "number" and {
        self.effectValue3
      } or self.effectValue3:toArray("=", true)
    end
    
    function Buff:_end()
      local releaser = self.effectValue == 1 and self.releaser or self.player
      for _, buffId in ipairs(self.recordValue) do
        self.player:addBuff({
          buffId = buffId,
          releaser = releaser,
          skillId = self.skillId
        })
      end
    end
  end,
  [114] = function(Buff)
    function Buff:_effect(hurtValue)
      local cent = (self.player.fullHp - self.player.hp) / self.player.fullHp
      
      local numValue = hurtValue * (self.effectValue * cent)
      local ratio = self.effectValue * cent * 100
      printInfo("Buff114: player:%s buffId-%s value-%s ratio-%s", self.player.unit.name, self.id, numValue, ratio)
      return {numValue = numValue, ratio = ratio}
    end
  end,
  [115] = function(Buff)
    function Buff:_effect(hurtValue)
      local cent = (self.player.fullHp - self.player.hp) / self.player.fullHp
      
      local numValue = hurtValue * (self.effectValue * cent)
      local ratio = self.effectValue * cent * 100
      printInfo("Buff115: player:%s buffId-%s value-%s ratio-%s", self.player.unit.name, self.id, numValue, ratio)
      return {numValue = numValue, ratio = ratio}
    end
  end,
  [116] = function(Buff)
    function Buff:_recordValue(params)
      self.recordValue = type(self.effectValue3) == "number" and {
        self.effectValue3
      } or self.effectValue3:toArray("=", true)
    end
    
    function Buff:_effect(id)
      local checkTag = false
      for _, buffId in ipairs(self.recordValue) do
        if id == buffId then
          checkTag = true
          break
        end
      end
      if checkTag then
        return checkTag
      end
    end
  end,
  [117] = function(Buff)
    function Buff:_update()
      local value = self.releaser.shieldAddValue * self.effectValue / 100
      
      printInfo("Buff117: player:%s buffId-%s value-%s", self.player.unit.name, self.id, value)
      local hurtParams = {
        hurtValue = value,
        hurtType = "normal",
        releaser = self.releaser
      }
      if self.skillId then
        hurtParams.skillId = self.skillId
        hurtParams.sumHurt = self.sumHurt
      end
      hurtParams.buffType = 2
      hurtParams.buffId = self.id
      self.player:beginHurt(hurtParams)
    end
  end,
  [121] = function(Buff)
    function Buff:_update()
      local skillId = self.player.specialSkill.specialId or self.player.unit.specialId
      
      local skillLevel = self.player.specialLevel or 1
      if not skillId or not SkillSpecialSet[skillId] then
        return
      end
      local specialSkillId = SkillSpecialSet[skillId][skillLevel].skillId
      self.player:releaseSkillById(specialSkillId, true)
    end
  end,
  [122] = function(Buff)
    function Buff:_recordValue(params)
      self.recordValue = {}
      
      self.recordLevel = 1
      table.insert(self.recordValue, self.releaser)
      if self.effectValue3 ~= 0 then
        self.player:addBuff({
          buffId = self.effectValue3,
          releaser = self.releaser
        })
      end
    end
    
    function Buff:_levelChange(params)
      self.leftTime = self.csvData.keepTime
      if self.recordLevel >= self.effectValue2 then
        return
      end
      self.recordLevel = self.recordLevel + 1
      table.insert(self.recordValue, params.releaser)
      printInfo("Buff122: player:%s buffId-%s addLevel %s", self.player.unit.name, self.id, self.recordLevel)
      if self.effectValue3 ~= 0 then
        self.player:addBuff({
          buffId = self.effectValue3,
          releaser = self.releaser
        })
      end
    end
    
    function Buff:_effect(hurtValue, releaser)
      if not releaser then
        return {numValue = 0, ratio = 0}
      end
      local check = false
      for _, player in ipairs(self.recordValue) do
        if player.side == releaser.side and player.id == releaser.id then
          check = true
        end
      end
      if not check then
        return {numValue = 0, ratio = 0}
      end
      local numValue = hurtValue * (self.effectValue * self.recordLevel / 100)
      local ratio = self.effectValue * self.recordLevel
      printInfo("Buff122: player:%s buffId-%s value-%s ratio-%s", self.player.unit.name, self.id, numValue, ratio)
      return {numValue = numValue, ratio = ratio}
    end
    
    function Buff:_end()
      if self.effectValue3 == 0 then
        return
      end
      if self.player:hasBuffById(self.effectValue3) then
        for _, buff in ipairs(self.player.buffIds[self.effectValue3].buffs) do
          buff:endBuff()
        end
      end
    end
  end,
  [123] = function(Buff)
    function Buff:_recordValue(params)
      self.recordValue = {}
      
      self.recordLevel = 1
      table.insert(self.recordValue, self.releaser)
      if self.effectValue3 ~= 0 then
        self.player:addBuff({
          buffId = self.effectValue3,
          releaser = self.releaser
        })
      end
    end
    
    function Buff:_levelChange(params)
      self.leftTime = self.csvData.keepTime
      if self.recordLevel >= self.effectValue2 then
        return
      end
      self.recordLevel = self.recordLevel + 1
      table.insert(self.recordValue, params.releaser)
      printInfo("Buff123: player:%s buffId-%s addLevel %s", self.player.unit.name, self.id, self.recordLevel)
      if self.effectValue3 ~= 0 then
        self.player:addBuff({
          buffId = self.effectValue3,
          releaser = self.releaser
        })
      end
    end
    
    function Buff:_effect(hurtValue, releaser)
      local check = false
      for _, player in ipairs(self.recordValue) do
        if player.side == releaser.side and player.id == releaser.id then
          check = true
        end
      end
      if not check then
        return {numValue = 0, ratio = 0}
      end
      local numValue = hurtValue * (self.effectValue * self.recordLevel / 100)
      local ratio = self.effectValue * self.recordLevel
      printInfo("Buff123: player:%s buffId-%s value-%s ratio-%s", self.player.unit.name, self.id, numValue, ratio)
      return {numValue = numValue, ratio = ratio}
    end
    
    function Buff:_end()
      if self.effectValue3 == 0 then
        return
      end
      if self.player:hasBuffById(self.effectValue3) then
        for _, buff in ipairs(self.player.buffIds[self.effectValue3].buffs) do
          buff:endBuff()
        end
      end
    end
  end,
  [124] = function(Buff)
    function Buff:_effect()
      return self.recordValue
    end
    
    function Buff:_recordValue()
      if self.effectValue1 == 0 then
        self.recordValue = self.effectValue
      else
        self.recordValue = self.player.fullHp * self.effectValue / 100
      end
    end
  end,
  [125] = function(Buff)
    function Buff:_effect()
      local effectPro = self.recordValue.effectPro
      
      local randomValue = math.random(1, 100)
      if effectPro < randomValue then
        return
      end
      local skillId = self.effectValue2
      if not SkillSpecialSet[skillId] then
        return
      end
      printInfo("Buff125: player:%s buffId-%s", self.player.unit.name, self.id)
      local skillLevel = self.player.specialLevel or 1
      local specialSkillId = SkillSpecialSet[skillId][skillLevel].skillId
      self.player:releaseSkillById(specialSkillId, true)
      self.recordValue.effectPro = self.recordValue.effectPro - self.recordValue.interval
      if self.recordValue.effectPro <= 0 then
        self:endBuff()
      end
    end
    
    function Buff:_recordValue()
      self.recordValue = {
        effectPro = self.effectValue,
        interval = self.effectValue1
      }
    end
  end,
  [126] = function(Buff)
    function Buff:_effect()
      local temp = math.random(1, 100)
      
      if temp <= self.effectValue then
        printInfo("Buff126: player:%s buffId-%s", self.player.unit.name, self.id)
        return true
      else
        return false
      end
    end
  end,
  [127] = function(Buff)
    function Buff:_effect(hurtValue)
      local temp = math.random(1, 100)
      
      if temp <= self.effectValue then
        local numValue = hurtValue * (self.effectValue1 / 100)
        local ratio = self.effectValue1
        printInfo("Buff127: player:%s buffId-%s value-%s ratio-%s", self.player.unit.name, self.id, numValue, ratio)
        return {
          numValue = numValue,
          ratio = self.effectValue1
        }
      else
        return {numValue = 0, ratio = 0}
      end
    end
  end,
  [128] = function(Buff)
    function Buff:_effect(hurtValue)
      if not self.releaser or self.releaser.hp <= 0 then
        printInfo("Buff127: buff releaser is Dead!")
        
        return hurtValue
      end
      local shareValue = math.max(self.effectValue / 100 * hurtValue, 0)
      local returValue = math.max(hurtValue - shareValue, 0)
      self.releaser:beginHurt({
        hurtValue = shareValue,
        hurtType = "normal",
        teamerHurt = true,
        buffType = 2,
        buffId = self.id
      })
      return returValue
    end
  end,
  [129] = function(Buff)
    function Buff:_recordValue()
      local master = self.player
      
      local infoValue = self.effectValue3:toArray("=", false)
      local playerInfo = {}
      playerInfo.side = master.side
      playerInfo.type = tonumber(infoValue[1])
      playerInfo.level = tonumber(infoValue[2])
      playerInfo.hp = master.fullHp * (tonumber(infoValue[3]) / 100)
      playerInfo.atk = master.atk * (tonumber(infoValue[3]) / 100)
      playerInfo.phyDef = master.phyDef * (tonumber(infoValue[3]) / 100)
      playerInfo.miss = master.miss * (tonumber(infoValue[3]) / 100)
      playerInfo.hit = master.hit * (tonumber(infoValue[3]) / 100)
      playerInfo.crit = master.crit * (tonumber(infoValue[3]) / 100)
      playerInfo.critHurt = master.critHurt * (tonumber(infoValue[3]) / 100)
      playerInfo.skillOrders = infoValue[4]:toArray(" ", true)
      playerInfo.index = self.player.battle:nextPlayerIdx(playerInfo.side)
      playerInfo.zorder = playerInfo.index
      playerInfo.xPos = master.xPos + tonumber(infoValue[5])
      self.recordValue = playerInfo
    end
    
    function Buff:_update()
      local player = self.player.layer:addPlayer(self.recordValue)
      player:addEventListener("playerDead", function(event)
        self.player.layer:onPlayerDead(player)
      end)
      if self.player.layer.carbonBuff then
        for _, buffId in ipairs(self.player.layer.carbonBuff) do
          player:addBuff({buffId = buffId, releaser = player})
        end
      end
    end
  end,
  [130] = function(Buff)
    function Buff:_update()
      printInfo("Buff130: player:%s buffId-%s", self.player.unit.name, self.id)
      
      local buffNum = self.player:hasBuffNum() or 0
      local buffOpenArray = self.effectValue:toArray("=", true)
      local buffOpenId = self.effectValue1:toArray("=", true)
      if next(buffOpenId) == nil or next(buffOpenArray) == nil then
        return
      end
      for i, value in ipairs(buffOpenId) do
        if buffNum >= buffOpenArray[i] then
          self.player:addBuff({
            buffId = value,
            releaser = self.releaser
          })
        end
      end
    end
  end,
  [131] = function(Buff)
    function Buff:_effect()
      local invalidBuffs = {}
      
      printInfo("Buff131: player:%s buffId-%s", self.player.unit.name, self.id)
      local enemyBuffs = self.effectValue1:toArray("=", true)
      for _, player in pairs(self.player.battle:getPlayers(self.player.otherSide)) do
        for _, enemyBuff in ipairs(enemyBuffs) do
          if player:hasBuff(enemyBuff) then
            table.insert(invalidBuffs, enemyBuff)
          end
        end
      end
      return invalidBuffs
    end
  end,
  [132] = function(Buff)
    function Buff:_update()
      local skillId = self.player.specialSkill.specialId or self.player.unit.specialId
      
      local judgeLevel = self.effectValue1
      local skillLevel = judgeLevel == 0 and (self.player.specialLevel or 1) or judgeLevel or 1
      if not skillId or not SkillSpecialSet[skillId] then
        return
      end
      local specialSkillId = SkillSpecialSet[skillId][skillLevel].skillId
      self.player:releaseSkillById(specialSkillId, true)
    end
  end,
  [133] = function(Buff)
    function Buff:_update()
      printInfo("Buff133:player:%s buffId-%s", self.player.unit.name, self.id)
      
      local buffs = self.effectValue:toArray("=", true)
      if not buffs or next(buffs) == nil then
        return
      end
      for i, buff in ipairs(buffs) do
        self.player:addBuff({
          buffId = buff,
          releaser = self.releaser
        })
        table.remove(buffs, i)
        break
      end
    end
  end,
  [134] = function(Buff)
    function Buff:_effect(isHurt)
      if not isHurt then
        return
      end
      printInfo("Buff134:player:%s buffId-%s", self.player.unit.name, self.id)
      local buffs = self.effectValue3:toTableArray()
      local temp = math.random(1, 100)
      if not buffs or next(buffs) == nil then
        return
      end
      if temp < self.effectValue1 then
        choose = math.randWeight(buffs, 2)
        self.player:addBuff({
          buffId = tonumber(buffs[choose][1]),
          releaser = self.releaser
        })
      end
    end
  end,
  [135] = function(Buff)
    function Buff:_effect()
      if type(self.effectValue3) == "number" then
        local list = {}
        
        list[1] = self.effectValue3
        return list
      else
        return self.effectValue3:toArray("=", true)
      end
    end
  end,
  [136] = function(Buff)
    function Buff:_effect()
      if self.player:hasBuffById(self.effectValue) then
        local num = self.player.buffIds[self.effectValue].num
        
        for i = 1, num do
          self.player:addBuff({
            buffId = self.effectValue1,
            releaser = self.releaser
          })
        end
      end
    end
  end,
  [137] = function(Buff)
    function Buff:_effect(isHurt)
      if not isHurt then
        return
      end
      printInfo("Buff137:player:%s buffId-%s", self.player.unit.name, self.id)
      local buffs = self.effectValue3:toTableArray()
      local temp = math.random(1, 100)
      if not buffs or next(buffs) == nil then
        return
      end
      if temp < self.effectValue1 then
        choose = math.randWeight(buffs, 2)
        self.player:addBuff({
          buffId = tonumber(buffs[choose][1]),
          releaser = self.releaser
        })
      end
    end
  end,
  [138] = function(Buff)
    function Buff:_effect()
      return self.effectValue
    end
  end,
  [139] = function(Buff)
    function Buff:_update()
      self.isValid = true
    end
    
    function Buff:_effect()
      self.isValid = false
    end
  end,
  [140] = function(Buff)
    function Buff:_update()
      if self.effectValue1 > 0 then
        for i = 1, self.effectValue1 do
          self.player:addBuff({
            buffId = tonumber(self.effectValue),
            
            releaser = self.releaser
          })
        end
      elseif self.effectValue1 < 0 then
        if not self.player:hasBuffById(self.effectValue) then
          return
        end
        local endCount = 0
        local endList = {}
        for _, buff in pairs(self.player.buffIds[self.effectValue].buffs) do
          table.insert(endList, buff)
          endCount = endCount + 1
          if endCount >= -self.effectValue1 then
            break
          end
        end
        for _, buff in ipairs(endList) do
          buff:endBuff()
          if self.player.buffIds[self.effectValue] then
            table.remove(self.player.buffIds[self.effectValue].buffs, 1)
          end
        end
      end
    end
  end,
  [141] = function(Buff)
    function Buff:_effect(skillId)
      if skillId < 10000 and self.effectValue == 2 then
        return
      end
      if 10000 < skillId and self.effectValue == 1 then
        return
      end
      if self.canEffect ~= true then
        return
      end
      local randomValue = math.randomInt(1, 100)
      if randomValue > self.effectValue2 then
        return
      end
      local buffList
      if type(self.effectValue3) == "number" then
        buffList = {}
        buffList[1] = self.effectValue3
      else
        buffList = self.effectValue3:toArray("=", true)
      end
      for _, buffid in ipairs(buffList) do
        self.player:addBuff({
          buffId = tonumber(buffid),
          releaser = self.releaser
        })
      end
      self.canEffect = false
    end
    
    function Buff:_update()
      self.canEffect = true
    end
  end,
  [142] = function(Buff)
    function Buff:_effect()
      for i = 1, self.effectValue1 do
        self.player:addBuff({
          buffId = tonumber(self.effectValue),
          
          releaser = self.releaser
        })
      end
    end
  end,
  [143] = function(Buff)
    function Buff:_effect(recordValue, id)
      local idList = self.effectValue3:toArray("=", true)
      
      for _, buffId in pairs(idList) do
        if id == tonumber(buffId) then
          if self.effectValue1 == 0 then
            return recordValue + self.effectValue
          elseif self.effectValue1 == 1 then
            return recordValue * (1 + self.effectValue / 100)
          end
        end
      end
      return recordValue
    end
  end,
  [144] = function(Buff)
    function Buff:_effect()
      local debuffList = {}
      
      for type, buffs in pairs(self.player.buffTypes) do
        for _, buff in ipairs(buffs or {}) do
          if buff.csvData.debuff == 1 then
            table.insert(debuffList, buff)
          end
        end
      end
      if #debuffList <= 0 then
        return
      end
      local teamPlayers = self.player.battle:getPlayers(self.player.side)
      if #teamPlayers <= 1 then
        return
      end
      local players = {}
      for _, player in pairs(teamPlayers or {}) do
        if player.id ~= self.player.id then
          table.insert(players, player)
        end
      end
      if #players < 1 then
        return
      end
      local random = math.randomInt(1, #players)
      for _, buff in ipairs(debuffList) do
        if players[random] then
          players[random]:addBuff({
            buffId = buff.id,
            releaser = self.releaser
          })
        end
      end
      printInfo("Buff144: player:%s buffId-%s", self.player.unit.name, self.id)
    end
  end,
  [145] = function(Buff)
    function Buff:_effect()
      local buffList = {}
      
      if self.effectValue == 1 then
        for type, buffs in pairs(self.player.buffTypes) do
          for _, buff in ipairs(buffs or {}) do
            table.insert(buffList, buff)
          end
        end
      elseif self.effectValue == 2 then
        for type, buffs in pairs(self.player.buffTypes) do
          for _, buff in ipairs(buffs or {}) do
            if buff.csvData.debuff == -1 then
              table.insert(buffList, buff)
            end
          end
        end
      elseif self.effectValue == 3 then
        for type, buffs in pairs(self.player.buffTypes) do
          for _, buff in ipairs(buffs or {}) do
            if buff.csvData.debuff == 1 then
              table.insert(buffList, buff)
            end
          end
        end
      end
      if #buffList <= 0 then
        return
      end
      if self.effectValue1 == 0 then
        for _, buff in ipairs(buffList) do
          buff.leftTime = buff.csvData.keepTime
        end
      else
        for _, buff in ipairs(buffList) do
          buff.leftTime = buff.leftTime + self.effectValue1
          if 0 >= buff.leftTime then
            buff:endBuff()
          end
        end
      end
    end
  end,
  [146] = function(Buff)
    function Buff:_effect()
      self.player:addPassiveSkill(self.effectValue)
    end
  end,
  [147] = function(Buff)
    function Buff:_effect()
      if self.effectValue1 == 0 or self.effectValue1 == nil then
        local killhp = self.player.fullHp * self.effectValue / 100
        
        self.player:changeHp(killhp, "normal", "not skill", {hurtValue = killhp, hurtType = "normal"}, self.releaser)
        printInfo("Buff147: player:%s buffId-%s killhp-%d", self.player.unit.name, self.id, killhp)
      else
        local killhp = self.player.hp * self.effectValue / 100
        self.player:changeHp(killhp, "normal", "not skill", {hurtValue = killhp, hurtType = "normal"}, self.releaser)
        printInfo("Buff147: player:%s buffId-%s killhp-%d", self.player.unit.name, self.id, killhp)
      end
    end
  end,
  [148] = function(Buff)
    function Buff:_effect()
      local buffIdList = {}
      
      if type(self.effectValue) == "number" then
        table.insert(buffIdList, self.effectValue)
      elseif type(self.effectValue) == "string" then
        buffIdList = self.effectValue:toArray("=", true)
      end
      local buffList = {}
      for _, buffId in pairs(buffIdList) do
        for type, buffs in pairs(self.player.buffTypes) do
          for _, buff in ipairs(buffs or {}) do
            if buff.id == buffId then
              table.insert(buffList, buff)
            end
          end
        end
      end
      if #buffList <= 0 then
        return
      end
      if self.effectValue1 == 0 then
        for _, buff in ipairs(buffList) do
          buff.leftTime = buff.csvData.keepTime
        end
      else
        for _, buff in ipairs(buffList) do
          buff.leftTime = buff.leftTime + self.effectValue1
          if 0 >= buff.leftTime then
            buff:endBuff()
          end
        end
      end
    end
  end,
  [149] = function(Buff)
    function Buff:_update()
      local value = self.recordValue
      
      printInfo("Buff149: player:%s buffId-%s value-%s", self.player.unit.name, self.id, value)
      local hurtParams = {
        hurtValue = value,
        hurtType = "normal",
        releaser = self.releaser,
        hurtTag = "extraHurt",
        hurtBuffId = self.id
      }
      if self.skillId then
        hurtParams.skillId = self.skillId
        hurtParams.sumHurt = self.sumHurt
      end
      hurtParams.buffType = 149
      hurtParams.buffId = self.id
      self.player:beginHurt(hurtParams)
    end
    
    function Buff:_recordValue(params)
      if self.effectValue1 == 1 then
        local player = self.effectValue3 == 1 and self.player or self.releaser
        local attrValue
        if self.effectValue2 == 15 then
          attrValue = player.fullHp - player.hp
        else
          local attr = BuffAtts[self.effectValue2]
          if attr == "Hp" then
            attr = "fullHp"
          else
            attr = "cur" .. attr
          end
          attrValue = player[attr]
          if attr == "curAtk" then
            attrValue = player.curAtk + player.curTrueAtk ^ 1.2 / (6 + player.curTrueAtk / 5000)
          end
        end
        self.recordValue = attrValue * self.effectValue / 100
      else
        self.recordValue = self.effectValue
      end
      if self.player:hasBuff(143) then
        for _, _buff in pairs(self.player.buffTypes[143]) do
          if _buff.effectValue1 == 1 then
            self.recordValue = _buff:effect(self.recordValue, self.id)
          end
        end
        for _, _buff in pairs(self.player.buffTypes[143]) do
          if _buff.effectValue1 == 0 then
            self.recordValue = _buff:effect(self.recordValue, self.id)
          end
        end
      end
    end
  end,
  [150] = function(Buff)
    function Buff:_update()
      local value = self.recordValue
      
      printInfo("Buff150: player:%s buffId-%s value-%s", self.player.unit.name, self.id, value)
      local hurtParams = {
        hurtValue = value,
        hurtType = "normal",
        releaser = self.releaser,
        hurtTag = "pierceHurt",
        hurtBuffId = self.id
      }
      if self.skillId then
        hurtParams.skillId = self.skillId
        hurtParams.sumHurt = self.sumHurt
      end
      hurtParams.buffType = 150
      hurtParams.buffId = self.id
      self.player:beginHurt(hurtParams)
    end
    
    function Buff:_recordValue(params)
      if self.effectValue1 == 1 then
        local player = self.effectValue3 == 1 and self.player or self.releaser
        local attrValue
        if self.effectValue2 == 15 then
          attrValue = player.fullHp - player.hp
        else
          local attr = BuffAtts[self.effectValue2]
          if attr == "Hp" then
            attr = "fullHp"
          else
            attr = "cur" .. attr
          end
          attrValue = player[attr]
          if attr == "curAtk" then
            attrValue = player.curAtk + player.curTrueAtk ^ 1.2 / (6 + player.curTrueAtk / 5000)
          end
        end
        self.recordValue = attrValue * self.effectValue / 100
      else
        self.recordValue = self.effectValue
      end
      if self.player:hasBuff(143) then
        for _, _buff in pairs(self.player.buffTypes[143]) do
          if _buff.effectValue1 == 1 then
            self.recordValue = _buff:effect(self.recordValue, self.id)
          end
        end
        for _, _buff in pairs(self.player.buffTypes[143]) do
          if _buff.effectValue1 == 0 then
            self.recordValue = _buff:effect(self.recordValue, self.id)
          end
        end
      end
    end
  end,
  [155] = function(Buff)
    function Buff:_recordValue(params)
      self.recordValue = type(self.effectValue3) == "number" and {
        self.effectValue3
      } or self.effectValue3:toArray("=", true)
    end
    
    function Buff:_effect(type)
      local checkTag = false
      for _, buffType in ipairs(self.recordValue) do
        if type == buffType then
          checkTag = true
          break
        end
      end
      if checkTag then
        return checkTag
      end
    end
  end,
  [158] = function(Buff)
    function Buff:_effect(hurtValue)
      local maxhurt = self.player.fullHp * 1 * self.effectValue / 100
      
      return math.min(maxhurt, hurtValue)
    end
  end,
  [159] = function(Buff)
    function Buff:_update()
      local value = self.recordValue
      
      local hurtType = "specialBuff"
      local hurtParams = {
        hurtValue = value,
        hurtType = hurtType,
        releaser = self.releaser,
        curCrit = self.releaser.curCrit,
        curCritHurt = self.releaser.curCritHurt,
        hurtTag = "sheildToHurt"
      }
      if self.skillId then
        hurtParams.skillId = self.skillId
        hurtParams.sumHurt = self.sumHurt
      end
      printInfo("Buff159: player:%s buffId-%s value-%s", self.player.unit.name, self.id, value)
      if not self.player:hasBuff(151) and not self.releaser:hasBuff(154) and not self.releaser:hasBuff(157) then
        hurtParams.buffType = 70
        hurtParams.buffId = self.id
        self.player:beginHurt(hurtParams)
      end
    end
    
    function Buff:_recordValue(params)
      if self.effectValue1 == 1 then
        local player = self.effectValue3 == 1 and self.player or self.releaser
        local attr = BuffAtts[self.effectValue2]
        if attr == "Hp" then
          attr = "fullHp"
        else
          attr = "cur" .. attr
        end
        local attrValue = player[attr]
        if attr == "curAtk" then
          attrValue = player.curAtk + player.curTrueAtk ^ 1.2 / (6 + player.curTrueAtk / 5000)
        end
        self.recordValue = attrValue * self.effectValue / 100
      else
        self.recordValue = self.effectValue
      end
    end
  end,
  [160] = function(Buff)
    function Buff:_effect(hurtValue)
      if self.player:hasBuffById(self.effectValue) then
        local numValue = 0
        
        local ratio = 0
        if self.effectValue1 == 0 then
          numValue = self.effectValue2
          ratio = 0
        elseif self.effectValue1 == 1 then
          numValue = hurtValue * (self.effectValue2 / 100)
          ratio = self.effectValue2
        end
        printInfo("Buff160: player:%s buffId-%s value-%s ratio-%s", self.player.unit.name, self.id, numValue, ratio)
        return {numValue = numValue, ratio = ratio}
      end
      return {numValue = 0, ratio = 0}
    end
  end,
  [161] = function(Buff)
    function Buff:_update()
      local hurtType = "specialBuff"
      
      local value = self.recordValue
      printInfo("Buff150: player:%s buffId-%s value-%s", self.player.unit.name, self.id, value)
      local hurtParams = {
        hurtValue = value,
        hurtType = hurtType,
        releaser = self.releaser,
        hurtTag = "pierceHurt",
        hurtBuffId = self.id,
        curCrit = self.releaser.curCrit,
        curCritHurt = self.releaser.curCritHurt
      }
      if self.skillId then
        hurtParams.skillId = self.skillId
        hurtParams.sumHurt = self.sumHurt
      end
      hurtParams.buffType = 150
      hurtParams.buffId = self.id
      self.player:beginHurt(hurtParams)
    end
    
    function Buff:_recordValue(params)
      if self.effectValue1 == 1 then
        local player = self.effectValue3 == 1 and self.player or self.releaser
        local attrValue
        if self.effectValue2 == 15 then
          attrValue = player.fullHp - player.hp
        else
          local attr = BuffAtts[self.effectValue2]
          if attr == "Hp" then
            attr = "fullHp"
          else
            attr = "cur" .. attr
          end
          attrValue = player[attr]
          if attr == "curAtk" then
            attrValue = player.curAtk + player.curTrueAtk ^ 1.2 / (6 + player.curTrueAtk / 5000)
          end
        end
        self.recordValue = attrValue * self.effectValue / 100
      else
        self.recordValue = self.effectValue
      end
      if self.player:hasBuff(143) then
        for _, _buff in pairs(self.player.buffTypes[143]) do
          if _buff.effectValue1 == 1 then
            self.recordValue = _buff:effect(self.recordValue, self.id)
          end
        end
        for _, _buff in pairs(self.player.buffTypes[143]) do
          if _buff.effectValue1 == 0 then
            self.recordValue = _buff:effect(self.recordValue, self.id)
          end
        end
      end
    end
  end,
  [162] = function(Buff)
    function Buff:_effect()
      local buffList = {}
      
      for type, buffs in pairs(self.player.buffTypes) do
        for _, buff in ipairs(buffs or {}) do
          if buff.csvData.debuff == -1 then
            table.insert(buffList, buff)
          end
        end
      end
      if #buffList <= 0 then
        return
      end
      for _, buff in ipairs(buffList) do
        self.releaser:addBuff({
          buffId = buff.id,
          releaser = self.releaser
        })
      end
      printInfo("Buff162: player:%s buffId-%s", self.player.unit.name, self.id)
    end
  end,
  [164] = function(Buff)
    function Buff:_attrChange()
      local value = self.recordValue
      
      if self.firstEffect then
        self.firstEffect = false
        printInfo("Buff164:%s buffId-%s player-%s releaser-%s value-%s", BuffAtts[self.effectValue2], self.id, self.player.unit.name, self.releaser.unit.name, value)
        self.player:changeAttribute({
          name = BuffAtts[self.effectValue2],
          value = value
        })
        local targets = self.player.battle:getPlayers(self.player.otherSide)
        for _, player in ipairs(targets) do
          if player:hasBuffById(tonumber(self.effectValue3)) then
            for _, buff in ipairs(player.buffIds[self.effectValue3].buffs) do
              buff:attrValueChange(value)
            end
          end
        end
      end
    end
    
    function Buff:_recordValue(params)
      self.firstEffect = true
      if self.effectValue1 == 1 then
        local player = self.player
        local attrValue = player:getBaseAttribute(self.effectValue2)
        self.recordValue = attrValue * self.effectValue / 100
      else
        self.recordValue = self.effectValue
      end
    end
  end,
  [165] = function(Buff)
    function Buff:_attrValueChange(value)
      printInfo("Buff165:%s buffId-%s player-%s releaser-%s value-%s", BuffAtts[self.effectValue2], self.id, self.player.unit.name, self.releaser.unit.name, -value)
      
      local rValue = -value * self.effectValue / 100
      self.player:changeAttribute({
        name = BuffAtts[self.effectValue2],
        value = rValue
      })
    end
  end,
  [166] = function(Buff)
    function Buff:_recordValue()
      if self.effectValue > 100 then
        printInfo("Buff166:Warn: player:%s buffId-%s value-%s", self.player.unit.name, self.id, self.effectValue)
      end
      if type(self.effectValue3) == "number" then
        self.recordValue = {
          [self.effectValue3] = true
        }
        return
      end
      local effectId = self.effectValue3:toArray("=", true)
      self.recordValue = {}
      for _, id in pairs(effectId) do
        self.recordValue[id] = true
      end
    end
    
    function Buff:_effect(params)
      local professionId = params.professionId
      local hurtValue = params.hurtValue
      if not self.recordValue[professionId] and not self.recordValue[0] then
        self.effectNum = self.effectNum + 1
        return 0
      end
      local returnValue = hurtValue * self.effectValue / 100
      returnValue = math.min(returnValue, hurtValue)
      return returnValue
    end
  end,
  [167] = function(Buff)
    Buff.player:reducePassiveSkillCD(Buff.effectValue, Buff.effectValue1)
  end,
  [168] = function(Buff)
    function Buff:_effect()
      self.player.totalHurtedCnt = self.player.totalHurtedCnt + 1
      
      self.player.totalAttackNum = self.player.totalAttackNum + 1
      self.player.totalHurtCnt = self.player.totalHurtCnt + 1
      printInfo("Buff166:Warn: player:%s buffId-%s totalHurtedCnt-%s totalAttackNum-%s totalHurtCnt-%s", self.player.unit.name, self.id, self.player.totalHurtedCnt, self.player.totalAttackNum, self.player.totalHurtCnt)
    end
  end,
  [169] = function(Buff)
    self.player:releaseSkillById(self.effectValue)
  end,
  [171] = function(Buff)
    function Buff:_effect(hurtValue)
      local missNum = self.player.miss * (self.effectValue / 100)
      
      missNum = 99 < missNum and 99 or missNum
      local numValue = hurtValue * missNum / 100
      printInfo("Buff171: player:%s buffId-%s miss-%s oldValue-%s value-%s ratio-%s", self.player.unit.name, self.id, self.player.miss, hurtValue, numValue, 0)
      return {
        numValue = -numValue,
        ratio = 0
      }
    end
  end,
  [172] = function(Buff)
    function Buff:_attrChange()
      local value = self.recordValue * self.effectValue / 100
      
      self.player:changeAttribute({name = "Atk", value = value})
      self.player:changeAttribute({name = "Hit", value = value})
      printInfo("Buff172:changeAttribute:%s buffId-%s player-%s value-%s", "Atk", self.id, self.player.unit.name, value)
    end
    
    function Buff:_recordValue(params)
      local player = self.player
      local attrValue = player:getBaseAttribute(self.effectValue1)
      self.recordValue = attrValue
    end
  end,
  [178] = function(Buff)
    function Buff:_update()
      if self.player:hasBuff(31) then
        for _, buff in ipairs(self.player.buffTypes[31]) do
          if self.effectValue > 0 then
            printInfo("Buff178:buffId-%s player-%s", self.id, self.player.unit.name)
            
            buff:endBuff()
          end
        end
      end
    end
  end,
  [180] = function(Buff)
    function Buff:_recordValue(params)
      self.recordValue = type(self.effectValue3) == "number" and {
        self.effectValue3
      } or self.effectValue3:toArray("=", true)
    end
    
    function Buff:_effect(type)
      local checkTag = false
      if tonumber(type) == 32 then
        checkTag = true
      end
      if checkTag then
        return checkTag
      end
    end
  end,
  [192] = function(Buff)
    function Buff:_update()
      if self.player:hasBuff(self.effectValue) then
        for _, buff in ipairs(self.player.buffTypes[self.effectValue]) do
          buff:endBuff()
        end
      end
    end
  end,
  [194] = function(Buff)
    function Buff:_recordValue()
      local BuffSet = {}
      
      self.recordValue = {}
      if type(self.effectValue3) == "number" then
        self.recordValue[self.effectValue3] = true
        return
      end
      BuffSet = self.effectValue3:toArray("=", true)
      for _, buffType in pairs(BuffSet) do
        self.recordValue[buffType] = true
      end
    end
    
    function Buff:_update()
      for type, buffs in pairs(self.player.buffTypes) do
        for _, buff in ipairs(buffs or {}) do
          if buff.csvData.debuff == self.effectValue and not self.recordValue[buff.csvData.type] then
            buff:endBuff()
          end
        end
      end
    end
  end,
  [195] = function(Buff)
    function Buff:_update()
      self.isValid = true
    end
    
    function Buff:_effect()
      self.isValid = false
    end
  end,
  [197] = function(Buff)
    function Buff:_update()
      local sourceBuffId = self.effectValue
      
      local targetBuffId = self.effectValue1
      local multiple = self.effectValue2 or 1
      local sourceBuffData = self.player.buffIds[sourceBuffId]
      if not sourceBuffData or sourceBuffData.num <= 0 then
        printInfo("Buff197: 源buff不存在或已失效，sourceBuffId=%s, player=%s", sourceBuffId, self.player.unit.name)
        return
      end
      local sourceStacks = sourceBuffData.num or 0
      local addStacks = sourceStacks * multiple
      if 0 < addStacks then
        printInfo("Buff197: 源buff层数%d, 倍数%d, 增加层数%d", sourceStacks, multiple, addStacks)
        for i = 1, addStacks do
          self.player:addBuff({
            buffId = tonumber(targetBuffId),
            releaser = self.releaser
          })
        end
        if not self.player.buffIds[targetBuffId] == nil then
          printInfo("Buff197: 目标当前层数%d", self.player.buffIds[targetBuffId].num)
        else
          printInfo("Buff197: 目标BUFF%d目前数量为0", targetBuffId)
        end
      else
        printInfo("Buff197: 目标BUFF%d目前数量为0", targetBuffId)
      end
    end
  end,
  [204] = function(Buff)
    function Buff:_effect(hurtValue)
      local numValue = hurtValue * (self.effectValue / 100)
      
      local ratio = self.effectValue
      printInfo("Buff29: player:%s buffId-%s value-%s ratio-%s", self.player.unit.name, self.id, numValue, ratio)
      return {numValue = numValue, ratio = ratio}
    end
  end,
  [205] = function(Buff)
    function Buff:_update()
      self.player:addBuff({
        buffId = tonumber(self.effectValue),
        
        releaser = self.releaser
      })
      local count = self.player.buffIds[self.effectValue1].num
      if count and 0 < count then
        self.NewUnitTime = math.max(self.csvData.unitTime / count, 30)
      end
    end
  end
}
return BuffFactory
