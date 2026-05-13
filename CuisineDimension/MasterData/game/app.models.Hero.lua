local unitCsv = require("csvdata.unit")
local evolutionCsv = require("csvdata.evolution")
local skill_specialCsv = require("csvdata.skill_special")
local skill_blockCsv = require("csvdata.skill_block")
local skill_awakeCsv = require("csvdata.skill_awake")
local professionCsv = require("csvdata.profession")
local loveEffectCsv = require("csvdata.love_effect")
local roleInfoCsv = require("csvdata.role_info")
local equipCsv = require("csvdata.equip")
local equipAttrCsv = require("csvdata.equip_entry")
local equipSuitCsv = require("csvdata.equip_suit")
local DressCsv = require("csvdata.hero_skin")
local StrengthCsv = require("csvdata.strength")
local EquipLevelCsv = require("csvdata.equip_level")
local TreepointCsv = require("csvdata.treepoint")
local TreeRedirectCsv = require("csvdata.tree_redirect")
local SauceCsv = require("csvdata.sauce")
local SauceAdvanceCsv = require("csvdata.sauce_advance")
local skillPassiveSet = require("csvdata.skill_passive")
local awakeCsv = require("csvdata.awaken")
local innateCsv = require("csvdata.innate")
local jobBonusCsv = require("csvdata.hero_job_bonus")
local formationCsv = require("csvdata.formation")
local Hero = class("Hero")
local HeroRedEvent = import(".HeroRedEvent")
local pairs = pairs
local ipairs = ipairs
local math_floor = math.floor

function Hero:ctor(msg)
  cc(self):addComponent("components.behavior.EventProtocol"):exportMethods()
  for key, value in pairs(msg) do
    self:setProperty(key, value)
  end
  self.fieldLevel = 1
  self.unit = unitCsv[self:getProperty("type")]
end

function Hero:getAllValue()
  return self:getProperty("battleValue") + self:getJobBattleValue(self.unit.profession)
end

function Hero:getCailiao(i)
  return math.floor(self["get_material" .. i .. "_max"](self) * self["material" .. i] / 100)
end

function Hero:getSauceBuff()
  local buff = {}
  if self:getProperty("sauce") ~= 0 then
    local sauce = game.role.sauces[self:getProperty("sauce")]
    if sauce then
      buff = sauce:getBuff()
    end
  end
  return buff
end

function Hero:getHurtChange()
  local sauceBuffs = self:getSauceBuff()
  local hurtChange = {
    damage = sauceBuffs.damage or 0,
    shield = sauceBuffs.shield or 0
  }
  hurtChange.damageTag = {}
  hurtChange.shieldTag = {}
  for i = 1, 3 do
    hurtChange.damageTag[i] = sauceBuffs["damage" .. i] or 0
    hurtChange.shieldTag[i] = sauceBuffs["shield" .. i] or 0
  end
  return hurtChange
end

function Hero:isSauceAdvanceMax()
  if not self.sauce or self.sauce == 0 then
    return false
  end
  local sauce = game.role.sauces[self.sauce]
  if sauce.advanceL ~= #SauceAdvanceCsv[sauce.type] then
    return false
  end
  for _, heroType in pairs(SauceCsv[sauce.type].type:toArray("=", true)) do
    if heroType == self.type then
      return true
    end
  end
  return false
end

function Hero:getTotalAttrValues(params)
  params = params or {}
  local baseValues = self:getBaseAttrValues(params)
  local equipValues = params.skipEquip and {} or self:getEquipAttrValues(baseValues)
  local talentValues = params.skipTalent and {} or self:getBoxTalentValues(baseValues)
  local treeUpAttrValues = params.skipTreeUp and {} or self:getTreeUpAttrValues(baseValues)
  local awakeAttrValues = params.skipAwake and {} or self:getAwakeUpAttrValues(params.awakeLv)
  local sauceBuffs = params.skipSauce and {} or self:getSauceBuff()
  local innateAttrValues = params.skipInnate and {} or self:getInnateUpAttrValues(params.innateLv)
  local jobAttrValues = params.skipJobUp and {} or self:getJobUpAttrValues(baseValues)
  local unitData = unitCsv[self:getProperty("type")]
  local loveBreak = self:getProperty("loveBreak")
  local loveData = loveEffectCsv[loveBreak] or {}
  local attrs = {}
  for key, val in pairs(AttsEnum) do
    local attr = 0 + (baseValues[key] or 0) + (equipValues[key] or 0) + (unitData[key] or 0) * (loveData[key] or 0) + (talentValues[key] or 0) + (treeUpAttrValues[key] or 0) + (jobAttrValues[key] or 0) + (sauceBuffs[key] or 0) + (awakeAttrValues[key] or 0) + (innateAttrValues[key] or 0)
    if params.attrUp and (key == "atk" or key == "phyDef") then
      attr = attr + baseValues[key] * params.attrUp / 100
    end
    if params.battle then
      attrs[key] = attr
    else
      attrs[key] = ROUND[val] and math.ceil(attr) or math_floor(attr)
    end
  end
  return attrs
end

function Hero:getBaseAttrValues(params)
  params = params or {}
  local unitData = unitCsv[self:getProperty("type")]
  local professSet = professionCsv[unitData.profession]
  local level = params.level or self:getProperty("level")
  local quality = params.quality or self:getProperty("quality")
  local attrs = {
    hp = 0,
    atk = 0,
    phyDef = 0,
    crit = 0,
    critHurt = 0,
    hit = 0,
    miss = 0,
    atkSpeed = 0
  }
  for attr, value in pairs(attrs) do
    attrs[attr] = unitData[attr] or value
  end
  attrs.hp = attrs.hp + (level - 1) * unitData.hpGrowth
  local strengthAttrs = {}
  local strengthSet = StrengthCsv[self:getProperty("strengthLevel")]
  strengthAttrs.atk = attrs.atk * 7 / 3 * professSet.atkPart * strengthSet.strengthPercent / 100
  strengthAttrs.phyDef = attrs.phyDef * 7 / 3 * professSet.defPart * strengthSet.strengthPercent / 100
  strengthAttrs.hit = attrs.hit * 7 / 3 * professSet.hitPart * strengthSet.strengthPercent / 100
  strengthAttrs.miss = attrs.miss * 7 / 3 * professSet.missPart * strengthSet.strengthPercent / 100
  local qualityAttrs = {}
  local factor = evolutionCsv[quality].ratio
  qualityAttrs.hp = factor * attrs.hp
  qualityAttrs.atk = factor * attrs.atk
  qualityAttrs.phyDef = factor * attrs.phyDef
  qualityAttrs.hit = factor * attrs.hit
  qualityAttrs.miss = factor * attrs.miss
  attrs.hp = attrs.hp + (qualityAttrs.hp or 0) + (strengthAttrs.hp or 0)
  attrs.atk = attrs.atk + (qualityAttrs.atk or 0) + (strengthAttrs.atk or 0)
  attrs.phyDef = attrs.phyDef + (qualityAttrs.phyDef or 0) + (strengthAttrs.phyDef or 0)
  attrs.hit = attrs.hit + (qualityAttrs.hit or 0) + (strengthAttrs.hit or 0)
  attrs.miss = attrs.miss + (qualityAttrs.miss or 0) + (strengthAttrs.miss or 0)
  return attrs
end

function Hero:getInnateActive(innateLv)
  local active = {}
  if self.unit.star == 6 then
    local innateLevel = innateLv or self:getProperty("innate") + evolutionCsv[self:getProperty("quality")].innateLevel
    local Data = innateCsv[self:getProperty("type")] or {}
    if Data then
      for idx, dataList in pairs(Data) do
        for curType, value in pairs(dataList.effect:toNumMap()) do
          if innateLevel and idx <= innateLevel then
            active[curType] = (active[curType] or 0) + value
          end
          if curType == 8 then
            active[20] = value
          end
          if curType == 10 then
            active[21] = value
          end
        end
      end
    end
  end
  return active
end

function Hero:getAwakeActive(awakeLv)
  local active = {}
  local awakeStage = awakeLv or self:getProperty("awake")
  local Data = awakeCsv[self:getProperty("type")] or {}
  if Data then
    for idx, dataList in pairs(Data) do
      for curType, value in pairs(dataList.type:toNumMap()) do
        if awakeStage and idx <= awakeStage then
          active[curType] = (active[curType] or 0) + value
        end
        if curType == 8 then
          active[10] = value
        end
      end
    end
  end
  return active
end

function Hero:getStageActive(awakeLv)
  local active = {}
  local awakeStage = awakeLv or 0
  local Data = awakeCsv[self:getProperty("type")] or {}
  if Data then
    for idx, dataList in pairs(Data) do
      for curType, value in pairs(dataList.type:toNumMap()) do
        if idx == awakeStage then
          active[curType] = (active[curType] or 0) + value
        end
        if curType == 8 then
          active[10] = value
        end
      end
    end
  end
  return active
end

function Hero:getAwakeUpAttrValues(awakeLv)
  local totalAttrs = {}
  local active = self:getAwakeActive(awakeLv)
  totalAttrs.hp = active[1]
  totalAttrs.atk = active[2]
  totalAttrs.phyDef = active[3]
  totalAttrs.hit = active[4]
  totalAttrs.miss = active[5]
  totalAttrs.addSpecialLv = active[6]
  totalAttrs.addBlockLv = active[7]
  return totalAttrs
end

function Hero:getInnateUpAttrValues(innateLv)
  local totalAttrs = {}
  local active = self:getInnateActive(innateLv)
  totalAttrs.hp = active[1]
  totalAttrs.atk = active[2]
  totalAttrs.phyDef = active[3]
  totalAttrs.hit = active[4]
  totalAttrs.miss = active[5]
  totalAttrs.crit = active[6]
  totalAttrs.critHurt = active[7]
  return totalAttrs
end

function Hero:getTreeUpAttrValues(baseAttrs)
  local totalAttrs = {}
  local active = self:getActiveTreePointAttrs()
  totalAttrs.hp = active[1]
  totalAttrs.atk = active[2]
  totalAttrs.phyDef = active[3]
  totalAttrs.hit = active[4]
  totalAttrs.miss = active[5]
  return totalAttrs
end

function Hero:getActiveTreePointAttrs()
  if not self.treePointActive then
    self:saveTreePointActive()
  end
  return self.treePointActive
end

function Hero:saveTreePointActive()
  local active = {}
  local treePoint = self:getProperty("treePoint") or ""
  local treeData = TreepointCsv[self:getProperty("type")] or {}
  for k, v in pairs(treePoint:toNumMap()) do
    if 0 < v then
      local curData = (treeData[math.floor(k / 100)] or {})[k % 100][v]
      if curData then
        for curType, value in pairs(curData.pointType:toNumMap()) do
          if curType == 10 then
            active[curType] = math.max(value, active[curType] or 0)
          else
            active[curType] = (active[curType] or 0) + value
          end
        end
      end
    end
  end
  self.treePointActive = active
end

function Hero:getJobBattleValue(jobid)
  if not CommonHelper.funcOpen("job") then
    return 0
  end
  local bvalue = 0
  local stage = game.role:getJobStage(self.unit.profession)
  local level = game.role:getJobLevel(self.unit.profession)
  local bonusData = jobBonusCsv[jobid][stage][level]
  if bonusData then
    bvalue = stage * 1000 + (stage - 1) * 100 * 5 + level * 5
  end
  return bvalue
end

function Hero:getJobUpAttrValues()
  local totalAttrs = {}
  local active = self:getJobAttrActive()
  totalAttrs.hp = active[1]
  totalAttrs.atk = active[2]
  totalAttrs.phyDef = active[3]
  totalAttrs.hit = active[4]
  if not CommonHelper.funcOpen("job") then
    return {
      hp = 0,
      atk = 0,
      phyDef = 0,
      hit = 0
    }
  end
  return totalAttrs
end

function Hero:getJobAttrActive()
  local active = {}
  local stageId = game.role:getJobStage(self.unit.profession)
  local level = game.role:getJobLevel(self.unit.profession)
  local bonusData = jobBonusCsv[self.unit.profession][stageId][level]
  if not bonusData then
    return {}
  end
  local curData = bonusData.content:toNumMap()
  for curType, value in pairs(curData) do
    active[curType] = value
  end
  return active
end

function Hero:getTeBaoValue()
  if not CommonHelper.funcOpen("job") then
    return 0
  end
  local jobAttrActive = self:getJobAttrActive()
  return (jobAttrActive[5] or 0) + (self.unit.tebao or 0)
end

function Hero:getTeKangValue()
  if not CommonHelper.funcOpen("job") then
    return 0
  end
  local jobAttrActive = self:getJobAttrActive()
  return (jobAttrActive[6] or 0) + (self.unit.tekang or 0)
end

function Hero:getJobSkillId()
  local jobAttrActive = self:getJobAttrActive()
  return jobAttrActive[7] or 0
end

function Hero:getTreeStep()
  local treePoint = self:getProperty("treePoint") or ""
  for _, data in ipairs(TreepointCsv[self:getProperty("type")] or {}) do
    for _, point in ipairs(data) do
      if treePoint:getv(point[1].step * 100 + point[1].id, 0) < #point then
        return point[1].step - 1
      end
    end
  end
  return table.nums(TreepointCsv[self:getProperty("type")] or {})
end

function Hero:getPointLevel(step, pointId)
  return (self:getProperty("treePoint") or ""):getv(step * 100 + pointId, 0)
end

function Hero:checkPointMax(step, pointId)
  return self:getPointLevel(step, pointId) >= #TreepointCsv[self:getProperty("type")][step][pointId]
end

function Hero:isTreeMax()
  local cur = self:getTreeStep()
  if cur == 0 then
    return false
  end
  if self:isShengcanHero() then
    return 5 <= cur
  end
  return 3 <= cur
end

function Hero:showTreeTag()
  return self:isTreeMax() and self:hasTreeSkill()
end

function Hero:hasTreeSkill()
  local formationId = self:getFormationId() or self.unit.formation
  local formatData = formationCsv[formationId][self.fieldLevel]
  for _, effect in ipairs(formatData.effectValue:toTableArray(" ")) do
    local type, pro, value = tonumber(effect[1]), tonumber(effect[2]), tonumber(effect[3])
    if effect[4] and pro == 7 then
      return true
    end
  end
  return false
end

function Hero:isBlackHero()
  local unitId = self.unit.type
  return globalCsv.blackHeroUnitIds[unitId] == 1
end

function Hero:isMengJingHero()
  local unitId = self.unit.type
  return globalCsv.mengJingHeroUnitIds[unitId] == 1
end

function Hero:isShengcanHero()
  local unitId = self.unit.type
  return globalCsv.shengcanHeroUnitIds[unitId] == 1
end

function Hero:getSkinSkillId(skillId)
  local newId = (TreeRedirectCsv[self:getDressType()] or {})[skillId] or {}.skillId
  if not newId and self:getDressType() == self:getProperty("type") then
    return skillId
  end
  return newId
end

function Hero:getSpecialId()
  local treePointActive = self:getActiveTreePointAttrs()
  return treePointActive[9] and self:getSkinSkillId(treePointActive[9]) or unitCsv[self:getDressType()].specialId
end

function Hero:getBlockId()
  local treePointActive = self:getActiveTreePointAttrs()
  return treePointActive[10] and self:getSkinSkillId(treePointActive[10]) or unitCsv[self:getDressType()].blockId
end

function Hero:getBlockId2()
  local treePointActive = self:getActiveTreePointAttrs()
  return treePointActive[11] and self:getSkinSkillId(treePointActive[11]) or unitCsv[self:getDressType()].blockId2
end

function Hero:getAwakeId(awakeLv)
  local awakePointActive = self:getAwakeActive(awakeLv)
  return awakePointActive[8] or 0
end

function Hero:getAwakeIdShow(awakeLv)
  local awakePointActive = self:getAwakeActive(awakeLv)
  return awakePointActive[10]
end

function Hero:getInnateCharacteristicId(innateLv)
  local innatePointActive = self:getInnateActive(innateLv)
  return innatePointActive[8] or 0
end

function Hero:getInnateCharacteristicIdShow(innateLv)
  local innatePointActive = self:getInnateActive(innateLv)
  return innatePointActive[20]
end

function Hero:getInnateDreamId(innateLv)
  local innatePointActive = self:getInnateActive(innateLv)
  return innatePointActive[10] or 0
end

function Hero:getInnateDreamIdShow(innateLv)
  local innatePointActive = self:getInnateActive(innateLv)
  return innatePointActive[21]
end

function Hero:getBlockId3()
  local treePointActive = self:getActiveTreePointAttrs()
  return treePointActive[13] and self:getSkinSkillId(treePointActive[13]) or unitCsv[self:getDressType()].blockId3
end

function Hero:getFormationId()
  local treePointActive = self:getActiveTreePointAttrs()
  local innateSet = innateCsv[self:getProperty("type")]
  if self.unit.star == 6 then
    local innateLv = self:getProperty("innate") + evolutionCsv[self:getProperty("quality")].innateLevel
    return innateSet[innateLv].formationUp == 1 and innateSet[innateLv].formationId or unitCsv[self:getDressType()].formation
  else
    return treePointActive[12] and treePointActive[12] or unitCsv[self:getDressType()].formation
  end
end

function Hero:getLevelLimit()
  local treePointActive = self:getActiveTreePointAttrs()
  return globalCsv.heroLevelLimit + (treePointActive[6] or 0)
end

function Hero:getBattleTag()
  local treePointActive = self:getActiveTreePointAttrs()
  return treePointActive[7] and treePointActive[7] or 0
end

function Hero:getCgOpen()
  local treePointActive = self:getActiveTreePointAttrs()
  return treePointActive[8]
end

function Hero:getEquipAttrValues(baseAttrs)
  local equipAttrs = {}
  local totalAttrs = {}
  local selector = {
    [23] = function()
      return equipAttrs[1].base[1]
    end,
    [24] = function()
      return equipAttrs[1].base[2]
    end,
    [25] = function()
      return equipAttrs[2].base[1]
    end,
    [26] = function()
      return equipAttrs[2].base[2]
    end,
    [27] = function()
      return equipAttrs[1].extra[1]
    end,
    [28] = function()
      return equipAttrs[1].extra[2]
    end,
    [29] = function()
      return equipAttrs[2].extra[1]
    end,
    [30] = function()
      return equipAttrs[2].extra[2]
    end
  }
  
  local function getAttrEffect(attrType, effectValue)
    if 23 <= attrType and attrType <= 30 then
      local attrs = selector[attrType]()
      for attr, value in pairs(attrs or {}) do
        totalAttrs[attr] = (totalAttrs[attr] or 0) + value * effectValue / 100
      end
    end
  end
  
  local addAttrs = {}
  for slot = 1, 3 do
    local attrs = {
      base = {},
      extra = {}
    }
    equipAttrs[slot] = attrs
    local equipId = self.equips:getv(slot, 0)
    if 0 < equipId then
      local equip = game.role.equips[equipId]
      local equipSet = equipCsv[equip:getProperty("type")]
      local baseValues = equipSet.baseValue:toTableArray()
      local base = {}
      for index, value in ipairs(baseValues) do
        local level = equip:getAttrLevel(index, true)
        local attrType = tonumber(value[1])
        local attrValue = tonumber(value[2])
        local factor = EquipLevelCsv[level].strengthValue
        local attr = AttsEnumEx[attrType]
        if attr then
          attrs.base[index] = {
            [attr] = attrValue
          }
          totalAttrs[attr] = (totalAttrs[attr] or 0) + attrValue * factor
        else
          getAttrEffect(attrType, attrValue * factor)
        end
      end
      for index = 1, 2 do
        local attrId = equip.attrEx:getv(index, 0)
        if 0 < attrId then
          local attrSet = equipAttrCsv[attrId]
          if attrSet.profession == 0 or attrSet.profession == self.unit.profession or attrSet.unitType == 0 or attrSet.unitType == self.unit.type then
            local level = equip:getAttrLevel(index, false)
            local attrType = attrSet.effectType
            local attrValue = attrSet.effectValue
            local factor = EquipLevelCsv[level].strengthValue
            local attr = AttsEnumEx[attrType]
            if attr and attrType < 10 then
              if 0 < attrSet.valueType then
                attrs.extra[index] = {
                  [attr] = (baseAttrs[attr] or 0) * attrValue / 100
                }
                totalAttrs[attr] = (totalAttrs[attr] or 0) + (baseAttrs[attr] or 0) * attrValue * factor / 100
              else
                attrs.extra[index] = {
                  [attr] = attrValue
                }
                totalAttrs[attr] = (totalAttrs[attr] or 0) + attrValue * factor
              end
            elseif attr and 10 <= attrType then
              if 0 < attrSet.valueType then
                addAttrs[attr] = attrValue * factor
              else
                attrs.extra[index] = {
                  [attr] = attrValue
                }
                totalAttrs[attr] = (totalAttrs[attr] or 0) + attrValue * factor
              end
            else
              getAttrEffect(attrType, attrSet.effectValue * factor)
            end
          end
        end
      end
    end
  end
  local suitId = self:isSuitAcitve(true)
  if suitId then
    local suitSet = equipSuitCsv[suitId]
    for index = 1, 3 do
      local effectType = suitSet["effectType" .. index]
      local effectValue = suitSet["effectValue" .. index]
      if 0 < effectType then
        local attr = AttsEnumEx[effectType]
        if attr then
          totalAttrs[attr] = (totalAttrs[attr] or 0) + effectValue
        else
          getAttrEffect(effectType, effectValue)
        end
      end
    end
  end
  if next(addAttrs) then
    for attr, attrValue in pairs(addAttrs) do
      totalAttrs[attr] = (totalAttrs[attr] or 0) + (totalAttrs[attr] or 0) * attrValue / 100
    end
  end
  return totalAttrs
end

function Hero:getBoxTalentValues(baseAttrs)
  local atkUpC = game.role:getTalentValue(1001, self.id)
  local atkUpP = game.role:getTalentValue(1002, self.id)
  local defUpC = game.role:getTalentValue(1003, self.id)
  local defUpP = game.role:getTalentValue(1004, self.id)
  local hitUpC = game.role:getTalentValue(1005, self.id)
  local hitUpP = game.role:getTalentValue(1006, self.id)
  local missUpC = game.role:getTalentValue(1007, self.id)
  local missUpP = game.role:getTalentValue(1008, self.id)
  local totalAttrs = {}
  totalAttrs.atk = baseAttrs.atk * (atkUpP / 100) + atkUpC
  totalAttrs.phyDef = baseAttrs.phyDef * (defUpP / 100) + defUpC
  totalAttrs.hit = baseAttrs.hit * (hitUpP / 100) + hitUpC
  totalAttrs.miss = baseAttrs.miss * (missUpP / 100) + missUpC
  return totalAttrs
end

function Hero:getTotalAttrFactors(params)
  params = params or {}
  local evolutionSet = evolutionCsv[self:getProperty("quality")]
  local heroSet = unitCsv[self:getProperty("type")]
  local innateSet = innateCsv[self:getProperty("type")]
  local awakeId = self:getAwakeId()
  local awakeLv = 0 < awakeId and 1 or 0
  local blockLv = evolutionSet.skillLevel
  local specialLv = evolutionSet.skillLevel
  if heroSet.star == 6 then
    specialLv = innateSet[evolutionSet.innateLevel + self:getProperty("innate")].skillLevel
    blockLv = innateSet[evolutionSet.innateLevel + self:getProperty("innate")].skillLevel
  end
  local passiveSkills = {}
  local factor = 0
  if awakeId and 0 < awakeId and awakeLv ~= 0 then
    factor = factor + skill_awakeCsv[awakeId][awakeLv].fightVar
  end
  local jobSkillId = self:getJobSkillId()
  if 0 < jobSkillId then
    table.insert(passiveSkills, jobSkillId)
  end
  local sauceBuff = self:getSauceBuff()
  local awakeAttr = self:getAwakeUpAttrValues(params.awakeLv)
  blockLv = blockLv + (sauceBuff.blocklv or 0) + (awakeAttr.addBlockLv or 0)
  specialLv = specialLv + (sauceBuff.speciallv or 0) + (awakeAttr.addSpecialLv or 0)
  for _, passiveSkill in pairs(sauceBuff.skill_passive or {}) do
    table.insert(passiveSkills, passiveSkill)
  end
  for slot = 1, 3 do
    local equipId = self.equips:getv(slot, 0)
    if 0 < equipId then
      local equip = game.role.equips[equipId]
      local equipSet = equipCsv[equip.type]
      for index = 1, 2 do
        local attrId = equip.attrEx:getv(index, 0)
        if 0 < attrId then
          local attrSet = equipAttrCsv[attrId]
          if attrSet.profession == 0 or attrSet.profession == heroSet.profession or attrSet.unitType == 0 or attrSet.unitType == heroSet.type or attrSet.slot == 0 or self.equips:getv(attrSet.slot, 0) ~= 0 then
            if attrSet.effectType == 20 then
              blockLv = blockLv + 1
            elseif attrSet.effectType == 21 then
              specialLv = specialLv + 1
            elseif attrSet.effectType == 22 then
              table.insert(passiveSkills, attrSet.effectValue)
              factor = factor + attrSet.factor
            end
          end
        end
      end
    end
  end
  local suitId = self:isSuitAcitve(true)
  if suitId then
    local suitSet = equipSuitCsv[suitId]
    for index = 1, 3 do
      local effectType = suitSet["effectType" .. index]
      local effectValue = suitSet["effectValue" .. index]
      if effectType == 20 then
        blockLv = blockLv + 1
      elseif effectType == 21 then
        specialLv = specialLv + 1
      elseif effectType == 22 then
        table.insert(passiveSkills, effectValue)
      end
    end
  end
  local blockLv = math.min(blockLv, 6)
  local specialLv = math.min(specialLv, 6)
  local specialId = self:getSpecialId()
  if 0 < specialId then
    factor = factor + skill_specialCsv[specialId][specialLv].fightVar
  end
  local blockId = self:getBlockId()
  if 0 < blockId then
    factor = factor + skill_blockCsv[blockId][blockLv].fightVar
  end
  for _, passiveSkill in pairs(sauceBuff.skill_passive or {}) do
    factor = factor + skillPassiveSet[passiveSkill].fightVar
  end
  local innateActive = {}
  if self.unit.star == 6 then
    innateActive = self:getInnateActive()
  end
  return {
    blockId = blockId,
    blockId2 = self:getBlockId2(),
    blockId3 = self:getBlockId3(),
    tebao = self:getTeBaoValue(),
    tekang = self:getTeKangValue(),
    specialId = specialId,
    awakeId = awakeId,
    awakeLv = awakeLv,
    characteristicId = self:getInnateCharacteristicId(),
    characteristicLv = innateActive[9] or 0,
    dreamId = self:getInnateDreamId(),
    dreamLv = innateActive[11] or 0,
    blockLv = blockLv,
    specialLv = specialLv,
    passiveSkills = passiveSkills,
    factor = factor,
    suitId = suitId
  }, sauceBuff
end

function Hero:isSuitAcitve(durability)
  local suitId = 0
  local dura = false
  for slot = 1, 3 do
    local equipId = self.equips:getv(slot, 0)
    if equipId == 0 then
      return
    end
    local equip = game.role.equips[equipId]
    if equip.suitId == 0 then
      return
    end
    if equip.durability == 0 then
      dura = true
    end
    if suitId == 0 then
      suitId = equip.suitId
    elseif suitId ~= equip.suitId then
      return
    end
  end
  if 0 < suitId then
    local suitSet = equipSuitCsv[suitId]
    if 0 < suitSet.trigger and suitSet.trigger ~= self.type then
      return
    end
  end
  if durability and dura then
    return
  end
  return suitId
end

function Hero:get_material1_max()
  local valueC = game.role:getTalentValue(1011, self.id)
  local valueP = game.role:getTalentValue(1012, self.id)
  local material1 = self.unit.material1 * evolutionCsv[self.quality].materialCarry * (100 - valueP) / 100 - valueC
  return material1
end

function Hero:get_material2_max()
  local valueC = game.role:getTalentValue(1011, self.id)
  local valueP = game.role:getTalentValue(1012, self.id)
  local material2 = self.unit.material2 * evolutionCsv[self.quality].materialCarry * (100 - valueP) / 100 - valueC
  return material2
end

function Hero:set_level(value)
  local oldValue = self.level
  self.level = value
  self:setProperty("level", value)
  game.role:dispatchEvent({
    name = "notifyNewMessage",
    type = "hero"
  })
  self:dispatchEvent({
    name = "set_level",
    newValue = value,
    oldValue = oldValue
  })
end

function Hero:getState()
  local states = {}
  states[1] = self:bOnTreat()
  local formation = game.role.formation[tostring(self.formation or 0)] or {}
  local lock = formation.lock or {}
  states[2] = lock.carbon
  states[3] = lock.entrust
  return states
end

function Hero:bOnTreat()
  local treatInfo = json.decode(game.role.treatJson)
  for _, data in pairs(treatInfo) do
    if data.id == self.id then
      return true
    end
  end
  return false
end

function Hero:getMaterialCost()
  local type = self.type
  local quality = self.quality
  local level = self.level
  local material1 = self:get_material1_max()
  local material2 = self:get_material2_max()
  local percent1 = (100 - self.material1) / 100
  local percent2 = (100 - self.material2) / 100
  return math.floor(material1 * percent1), math.floor(material2 * percent2)
end

function Hero:getCureTime()
  local level = game.role.level
  local attrs = self:getBaseAttrValues()
  local lost = (1000 - self.hpPercent) / 1000
  local time = self.level <= 15 and 0.5 or 1
  if 0.7 <= lost then
    time = time * 3100 * math.pow(lost - 0.7, 2) * self.level * professionCsv[self.unit.profession].repairTime + 900
  else
    time = 0
  end
  local valueC = game.role:getTalentValue(1013, self.id)
  local valueP = game.role:getTalentValue(1014, self.id)
  time = time * roleInfoCsv[level].cure * (100 - valueP) / 100 - valueC
  return time
end

function Hero:getCanEquip(preset)
  local parts = {}
  if not CommonHelper.funcOpen("equip") then
    return parts
  end
  for _, equip in pairs(game.role.equips) do
    if equip.masterId == 0 or preset then
      local data = equipCsv[equip.type]
      if data.level <= self.level then
        parts[data.profession] = true
      end
    end
  end
  return parts
end

function Hero:getCanEquipSauce()
  if not CommonHelper.funcOpen("sauce") then
    return nil
  end
  for _, sauce in pairs(game.role.sauces) do
    if sauce.csvData.maintype ~= 0 then
      local hero = game.role.heros[sauce.masterId]
      if hero then
        local states = hero:getState()
        if not states[1] and not states[2] and not states[3] then
          return true
        end
      else
        return true
      end
    end
  end
  return false
end

function Hero:getPrivateSauceMainType()
  for _, data in pairs(SauceCsv) do
    for _, heroType in pairs(data.type:toArray("=", true)) do
      if heroType == self.type then
        return data.maintype
      end
    end
  end
end

function Hero:getName()
  if self.loveBreak >= 5 and self.name and self.name ~= "" then
    return self.name
  else
    return unitCsv[self:getDressType()].name
  end
end

function Hero:getDressType()
  local dressId = self.type * 10 + self.dress
  local dressSet = DressCsv[dressId]
  if not dressSet then
    return self.type
  else
    return dressSet.hero
  end
end

function Hero:getDressSet()
  local dressId = self.type * 10 + self.dress
  return DressCsv[dressId]
end

function Hero:showEquipRed()
  local equips = {}
  local showRed = false
  for slot = 1, 3 do
    local equipId = self.equips:getv(slot, 0)
    if equipId ~= 0 then
      local equip = game.role.equips[equipId]
      local res, value = equip:showRed()
      if res then
        showRed = res
        equips[equipId] = value
      end
    end
  end
  return showRed, equips
end

function Hero:updateProperty(key, ...)
  local method = self["set_" .. key]
  if type(method) ~= "function" then
    local newValue = select(1, ...)
    self:setProperty(key, newValue)
    self:dispatchEvent({
      name = "set_" .. key,
      newValue = newValue,
      oldValue = select(2, ...)
    })
    if key == "treePoint" then
      self:saveTreePointActive()
    end
    return
  end
  method(self, ...)
end

function Hero:getBattleValue(attrs, factor, sauceBuff)
  sauceBuff = sauceBuff or {}
  local heroSet = unitCsv[self:getProperty("type")]
  local professSet = professionCsv[heroSet.profession]
  local finalAtk = attrs.atk + attrs.trueAtk * 0.7
  local finalDef = attrs.phyDef + attrs.atkResist
  local finalHit = attrs.hit + attrs.hitResist * 0.56
  local finalCrit = attrs.crit + attrs.critResist * 0.625
  local finalCritHurt = attrs.critHurt + attrs.critHurtResist * 0.7
  local base = attrs.hp * (1 + finalDef / finalAtk * 7 / 27) * finalAtk / (professSet.attackInterval / attrs.atkSpeed) * (1 + attrs.miss) * finalHit * (1 + finalCrit / 1000 * finalCritHurt / 1000)
  local battleValue = math.pow(base, 0.4) * (1 + factor) / 40 * (1 + (sauceBuff.damage or 0) / 200) * (1 + (sauceBuff.shield or 0) / 200)
  return tostring(battleValue)
end

function Hero:setProperty(key, value)
  if type(value) == "number" then
    self[key .. "__ed"] = tostring(value)
  end
  self[key] = value
end

function Hero:getProperty(key)
  if self[key .. "__ed"] then
    return tonumber(self[key .. "__ed"])
  else
    return self[key]
  end
end

return Hero
