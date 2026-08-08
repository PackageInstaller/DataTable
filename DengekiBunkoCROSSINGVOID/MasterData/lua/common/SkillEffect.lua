local WU, DB = require("Common/WindowUtil")()
local U = require("Common/Util")
local PB = require("Common/PbHelper")
local TU = require("Common/TextUtil")
local SE = {}
local m_actorSkillComboMap

function SE.GetActorComboEffect(skillId, level, actionIndex, speIndex)
  local effect = {}
  local actorCombo = SE.GetActorSkillCombo(skillId)
  if actorCombo then
    effect = SE.GetSkillEffect(actorCombo.skillList, level, actionIndex, speIndex)
  end
  return effect
end

function SE.GetActorLinkEffect(linkId, star, actionIndex, speIndex)
  local effect = {}
  local level = math.max(2, star or 2) - 1
  local actorLink = PB.get("ActorLink", linkId)
  local skillList = {}
  for _, link in ipairs(actorLink.link) do
    table.insert(skillList, link.skillID)
  end
  if actorLink then
    effect = SE.GetSkillEffect(skillList, level, actionIndex, speIndex)
  end
  return effect
end

function SE.GetSkillEffect(skillIds, level, actionIndex, speIndex)
  local effect = {
    attrs = {},
    buffs = {},
    triggers = {}
  }
  local triggerIndex = 0
  local attrList = {}
  local buffDict = _ENV["!"]({})
  local buffIndexDict = _ENV["!"]({})
  local buffPriorityDict = {}
  if type(skillIds) == "number" then
    skillIds = {skillIds}
  end
  for _, skillId in ipairs(skillIds) do
    local actionDamages = PB.all("ActionDamage"):where(function(k, v)
      return v.skillId == skillId
    end)
    if not actionDamages:empty() then
      for _, actionDamage in pairs(actionDamages) do
        local damageIndex = PB.get("DamageIndex", actionDamage.index, 1)
        local deltaRatio = (damageIndex.upRate - 10000) / 10000 / math.max(1, damageIndex.maxLevel - 1)
        local levelRatio = 1 + deltaRatio * (level - 1)
        for i = 1, #damageIndex.attrs do
          local attr = damageIndex.attrs[i]
          if attrList[i] then
            attrList[i].value = attrList[i].value + attr.value * levelRatio
            attrList[i].delta = attrList[i].delta + attr.value * deltaRatio
          else
            attrList[i] = {
              type = attr.type,
              isRatio = attr.isRatio,
              value = attr.value * levelRatio,
              delta = attr.value * deltaRatio
            }
          end
        end
      end
      for i = 1, #attrList do
        local attr = attrList[i]
        attr.value = math.floor(attr.value + 0.5)
        attr.delta = math.floor(attr.delta + 0.5)
        effect.attrs[i - 1] = {
          value = U.FormatAttrValue(attr),
          delta = U.FormatAttrValue({
            isRatio = attr.isRatio,
            value = attr.delta
          })
        }
      end
    end
    actionIndex = actionIndex or 1
    local actionBuffs = PB.all("ActionBuff"):where(function(k, v)
      return v.skillId == skillId
    end)
    for _, actionBuff in pairs(actionBuffs) do
      if actionBuff and actionIndex <= #actionBuff.buffIndex then
        local buffIndex = PB.get("BuffIndex", actionBuff.buffIndex[actionIndex])
        if not buffIndexDict[buffIndex.index] then
          buffIndexDict[buffIndex.index] = true
          for i = 1, #buffIndex.buffId do
            local buffData = PB.get("BuffData", buffIndex.buffId[i], buffIndex.owner[i])
            if buffData and not buffDict[buffData.id .. buffData.owner] then
              if 1 > buffData.priority then
                warning("invalid priority for BuffData with id " .. buffData.id)
              elseif buffPriorityDict[buffData.priority] then
                warning("BuffData " .. buffPriorityDict[buffData.priority] .. " and " .. buffData.id .. " share same priority within ActorSkill " .. skillId)
              else
                buffDict[buffData.id .. buffData.owner] = {
                  buffData = buffData,
                  launchChance = buffIndex.launchChance[i]
                }
                buffPriorityDict[buffData.priority] = buffData.id
              end
            end
          end
        end
      end
    end
    local effectBuffs = GenEffectBuffs(buffDict:toarray(), level)
    table.merge(effect, effectBuffs)
    local actorSkill = PB.get("ActorSkill", skillId)
    if actorSkill then
      local index_val = actorSkill.specialIndex[speIndex or 1]
      if index_val ~= nil and 0 < index_val then
        effect.triggers[triggerIndex] = SE.GetSpecialEffect(index_val, level)
        triggerIndex = triggerIndex + 1
      end
    end
  end
  return effect
end

function SE.GetActorTalentEffect(talent)
  return SE.GetSpecialEffect(talent.talentId, talent.talentValue)
end

function GetSpecialAttrInfoIndexRecursively(index)
  local result = _ENV["!"]({index})
  local specialAttrInfo = PB.get("SpecialAttrInfo", index)
  if specialAttrInfo then
    for _, childId in pairs(specialAttrInfo.childSpecialAttrInfoId) do
      result:append(GetSpecialAttrInfoIndexRecursively(childId))
    end
  else
    error("SpecialAttrInfo", "key " .. index .. " was not found in SpecialAttrInfo.xlsx")
  end
  return result
end

function SE.GetSpecialEffect(index, level, depth)
  local effect = {
    attrs = {},
    buffs = {}
  }
  depth = depth or 1
  level = level or 1
  local indexList = GetSpecialAttrInfoIndexRecursively(index)
  local attrList = {}
  local buffDict = _ENV["!"]({})
  local buffPriorityDict = {}
  for _, index in pairs(indexList) do
    local specialAttrInfo = PB.get("SpecialAttrInfo", index)
    if specialAttrInfo then
      if specialAttrInfo.timing == PB.enum.Timing.Always then
        local specialLevelUpIndex = PB.get("SpecialLevelUpIndex", index)
        for i = 1, #specialLevelUpIndex.attrs do
          local attr = specialLevelUpIndex.attrs[i]
          local levelRatio = 1 + (specialLevelUpIndex.upRate[i] - 10000) / 10000 / math.max(1, specialAttrInfo.maxLevel - 1) * (level - 1)
          attrList[i] = {
            type = attr.type,
            isRatio = attr.isRatio,
            value = attr.value * levelRatio
          }
        end
      else
        local buffIndex = PB.get("BuffIndex", index)
        for i = 1, #buffIndex.buffId do
          local buffData = PB.get("BuffData", buffIndex.buffId[i], buffIndex.owner[i])
          if buffData and not buffDict[buffData.id .. buffData.owner] then
            if 1 > buffData.priority then
              warning("BuffData", "invalid priority for BuffData with id " .. buffData.id)
            elseif buffPriorityDict[buffData.priority] then
              warning("BuffData", "BuffData " .. buffPriorityDict[buffData.priority] .. " and " .. buffData.id .. " share same priority within SpecialAttrInfo " .. index)
              warning("BuffData", "indexList : " .. table.dump(indexList))
            else
              buffDict[buffData.id .. buffData.owner] = {
                buffData = buffData,
                launchChance = buffIndex.launchChance[i]
              }
              buffPriorityDict[buffData.priority] = buffData.id
            end
          end
        end
      end
    else
      error("SpecialAttrInfo", "key " .. index .. " was not found in SpecialAttrInfo.xlsx")
    end
  end
  for i = 1, #attrList do
    local attr = attrList[i]
    attr.value = math.floor(attr.value + 0.5)
    effect.attrs[i - 1] = {
      value = U.FormatAttrValue(attr)
    }
  end
  local effectBuffs = GenEffectBuffs(buffDict:toarray(), level, depth)
  table.merge(effect, effectBuffs)
  return effect
end

function BuffIndexEffect(index, level, depth)
  local effect = {
    buffs = {}
  }
  depth = depth or 1
  level = level or 1
  local buffDict = _ENV["!"]({})
  local buffPriorityDict = {}
  local buffIndex = PB.get("BuffIndex", index)
  if buffIndex then
    for i = 1, #buffIndex.buffId do
      local buffData = PB.get("BuffData", buffIndex.buffId[i], buffIndex.owner[i])
      if buffData and not buffDict[buffData.id .. buffData.owner] then
        if 1 > buffData.priority then
          warning("invalid priority for BuffData with id " .. buffData.id)
        elseif buffPriorityDict[buffData.priority] then
          warning("BuffData " .. buffPriorityDict[buffData.priority] .. " and " .. buffData.id .. " share same priority ")
        else
          buffDict[buffData.id .. buffData.owner] = {
            buffData = buffData,
            launchChance = buffIndex.launchChance[i]
          }
          buffPriorityDict[buffData.priority] = buffData.id
        end
      end
    end
  else
    warning("BuffIndex", "Missing BuffIndex.xlsx index : " .. tostring(index))
  end
  local effectBuffs = GenEffectBuffs(buffDict:toarray(), level, depth)
  table.merge(effect, effectBuffs)
  return effect
end

function GenEffectBuffs(buffList, level, depth)
  level = level or 1
  depth = depth or 1
  local result = {
    buffs = {}
  }
  if not table.empty(buffList) then
    table.sort(buffList, function(a, b)
      return a.buffData.priority < b.buffData.priority
    end)
    for i = 1, #buffList do
      local buffData = buffList[i].buffData
      result.buffs[i - 1] = SE.GetBuffEffect(buffData, level)
      local extra = SE.GetBuffDataExtraInfo(buffData, level, depth)
      result.buffs[i - 1]["type" .. buffData.type] = extra
      result.buffs[i - 1].launchChance = buffList[i].launchChance
    end
  end
  return result
end

function SE.GetBuffDataExtraInfo(buffData, level, depth)
  depth = depth or 1
  level = level or 1
  if 3 < depth then
    return
  end
  if buffData.type == PB.enum.BuffFightType.StackDelete then
    return BuffIndexEffect(buffData.paramInt[2], level, depth + 1)
  elseif buffData.type == PB.enum.BuffFightType.SpecialAttrChange then
    return SE.GetSpecialEffect(buffData.paramInt[1], level, depth + 1)
  end
end

function SE.GetBuffEffect(buffData, level)
  local effect = {
    maxRound = buffData.maxRound,
    maxStack = buffData.maxStack,
    paramInt = {},
    value = {},
    delta = {}
  }
  for p = 1, #buffData.paramInt do
    effect.paramInt[p - 1] = buffData.paramInt[p]
  end
  local deltaRatio = (buffData.upRate - 10000) / 10000 / math.max(1, buffData.maxLevel - 1)
  local levelRatio = 1 + deltaRatio * (level - 1)
  if buffData.type == PB.enum.BuffFightType.Shield then
    effect.value[0] = math.floor(effect.paramInt[2] * levelRatio + 0.5)
    effect.value[1] = math.floor(effect.paramInt[3] * levelRatio + 0.5)
    effect.value[2] = math.floor(effect.paramInt[4] * levelRatio + 0.5)
    effect.delta[0] = math.floor(effect.paramInt[2] * deltaRatio + 0.5)
    effect.delta[1] = math.floor(effect.paramInt[3] * deltaRatio + 0.5)
    effect.delta[2] = math.floor(effect.paramInt[4] * deltaRatio + 0.5)
  elseif buffData.type == PB.enum.BuffFightType.HpChange then
    effect.value[0] = math.floor(effect.paramInt[1] * levelRatio + 0.5)
    effect.delta[0] = math.floor(effect.paramInt[1] * deltaRatio + 0.5)
  elseif buffData.type == PB.enum.BuffFightType.ActionFeedBack then
    effect.value[0] = math.floor(effect.paramInt[1] * levelRatio + 0.5)
    effect.delta[0] = math.floor(effect.paramInt[1] * deltaRatio + 0.5)
  elseif buffData.type == PB.enum.BuffFightType.AbHurt then
    effect.value[0] = math.floor(effect.paramInt[1] * levelRatio + 0.5)
    effect.delta[0] = math.floor(effect.paramInt[1] * deltaRatio + 0.5)
  elseif buffData.type == PB.enum.BuffFightType.Attr then
    effect.value[0] = math.floor(effect.paramInt[2] * levelRatio + 0.5)
    effect.delta[0] = math.floor(effect.paramInt[2] * deltaRatio + 0.5)
  elseif buffData.type == PB.enum.BuffFightType.Rebound then
    effect.value[0] = math.floor(effect.paramInt[1] * levelRatio + 0.5)
    effect.delta[0] = math.floor(effect.paramInt[1] * deltaRatio + 0.5)
  elseif buffData.type == PB.enum.BuffFightType.KeepAlive then
    effect.value[0] = math.floor(effect.paramInt[1] * levelRatio + 0.5)
    effect.delta[0] = math.floor(effect.paramInt[1] * deltaRatio + 0.5)
  elseif buffData.type == PB.enum.BuffFightType.HpAddChange then
    effect.value[0] = math.floor(effect.paramInt[0] * levelRatio + 0.5)
    effect.delta[0] = math.floor(effect.paramInt[0] * deltaRatio + 0.5)
  elseif buffData.type == PB.enum.BuffFightType.MpOnceChange then
    effect.value[0] = math.floor(effect.paramInt[0] * levelRatio + 0.5)
    effect.delta[0] = math.floor(effect.paramInt[0] * deltaRatio + 0.5)
  elseif buffData.type == PB.enum.BuffFightType.SpOnceChange then
    effect.value[0] = math.floor(effect.paramInt[0] * levelRatio + 0.5)
    effect.delta[0] = math.floor(effect.paramInt[0] * deltaRatio + 0.5)
  elseif buffData.type == PB.enum.BuffFightType.CostChange then
    effect.value[0] = math.floor(effect.paramInt[0] * levelRatio + 0.5)
    effect.delta[0] = math.floor(effect.paramInt[0] * deltaRatio + 0.5)
  elseif buffData.type == PB.enum.BuffFightType.SkillDamageChange then
    effect.value[0] = math.floor(effect.paramInt[2] * levelRatio + 0.5)
    effect.delta[0] = math.floor(effect.paramInt[2] * deltaRatio + 0.5)
  elseif buffData.type == PB.enum.BuffFightType.ChangeRoundAddMp then
    effect.value[0] = math.floor(effect.paramInt[0] * levelRatio + 0.5)
    effect.delta[0] = math.floor(effect.paramInt[0] * deltaRatio + 0.5)
  elseif buffData.type == PB.enum.BuffFightType.SpRateChange then
    effect.value[0] = math.floor(effect.paramInt[1] * levelRatio + 0.5)
    effect.delta[0] = math.floor(effect.paramInt[1] * deltaRatio + 0.5)
  elseif buffData.type == PB.enum.BuffFightType.Bomb then
    effect.value[0] = math.floor(effect.paramInt[1] * levelRatio + 0.5)
    effect.delta[0] = math.floor(effect.paramInt[1] * deltaRatio + 0.5)
  elseif buffData.type == PB.enum.BuffFightType.SpToMp then
    effect.value[0] = math.floor(effect.paramInt[1] * levelRatio + 0.5)
    effect.delta[0] = math.floor(effect.paramInt[1] * deltaRatio + 0.5)
  elseif buffData.type == PB.enum.BuffFightType.StackDelete then
    effect.value[0] = math.floor(effect.paramInt[0] * levelRatio + 0.5)
    effect.delta[0] = math.floor(effect.paramInt[0] * deltaRatio + 0.5)
  elseif buffData.type == PB.enum.BuffFightType.BuffValChange then
    effect.value[0] = math.floor(effect.paramInt[2] * levelRatio + 0.5)
    effect.delta[0] = math.floor(effect.paramInt[2] * deltaRatio + 0.5)
  elseif buffData.type == PB.enum.BuffFightType.SkillReset then
    effect.value[0] = math.floor(effect.paramInt[0] * levelRatio + 0.5)
    effect.delta[0] = math.floor(effect.paramInt[0] * deltaRatio + 0.5)
  elseif buffData.type == PB.enum.BuffFightType.HpImmeChange then
    effect.value[0] = math.floor(effect.paramInt[1] * levelRatio + 0.5)
    effect.delta[0] = math.floor(effect.paramInt[1] * deltaRatio + 0.5)
  elseif buffData.type == PB.enum.BuffFightType.BuffRoundChange then
    effect.value[0] = math.floor(effect.paramInt[3] * levelRatio + 0.5)
    effect.delta[0] = math.floor(effect.paramInt[3] * deltaRatio + 0.5)
  elseif buffData.type == PB.enum.BuffFightType.AttrTransAbHurt then
    effect.value[0] = math.floor(effect.paramInt[2] * levelRatio + 0.5)
    effect.delta[0] = math.floor(effect.paramInt[2] * deltaRatio + 0.5)
  elseif buffData.type == PB.enum.BuffFightType.SkillDamageAffect then
    effect.value[0] = math.floor(effect.paramInt[2] * levelRatio + 0.5)
    effect.delta[0] = math.floor(effect.paramInt[2] * deltaRatio + 0.5)
  elseif buffData.type == PB.enum.BuffFightType.AttrTransmission then
    effect.value[0] = math.floor(effect.paramInt[3] * levelRatio + 0.5)
    effect.delta[0] = math.floor(effect.paramInt[3] * deltaRatio + 0.5)
  end
  return effect
end

function SE.GetActorSkillCombo(skillId)
  if not m_actorSkillComboMap then
    m_actorSkillComboMap = {}
    local actorCombos = PB.all("ActorCombo")
    for _, actorCombo in pairs(actorCombos) do
      for _, skillId in pairs(actorCombo.skillList) do
        m_actorSkillComboMap[skillId] = actorCombo
      end
    end
  end
  return m_actorSkillComboMap[skillId]
end

function SE.GetActorSkillCost(skillId)
  local actorCombo = SE.GetActorSkillCombo(skillId)
  if actorCombo then
    return {
      costMp = actorCombo.costMp,
      costSp = actorCombo.costSp
    }
  else
    return nil
  end
end

function SE.GetSkillCostDesc(sp, mp)
  if 0 < sp then
    return "<font color=#FFBA00>" .. sp .. WU.GetString("Window_SPCost") .. "</font>"
  else
    return "<font color=#009CFF>" .. mp .. WU.GetString("Window_MPCost") .. "</font>"
  end
end

function SE.GetSkillLevel(actor, skillId)
  local skillLevel = 0
  local _, skill = table.find(actor.skills, function(_, v)
    return v.id == skillId
  end)
  if skill then
    skillLevel = skill.level
  end
  return skillLevel
end

function SE.IsSkillRead(actor, skillId)
  local result = false
  local _, skill = table.find(actor.skills, function(_, v)
    return v.id == skillId
  end)
  if skill then
    result = skill.isRead
  end
  return result
end

function SE.SetSkillRead(actor, skillId)
  local _, skill = table.find(actor.skills, function(_, v)
    return v.id == skillId
  end)
  if skill then
    skill.isRead = true
  end
end

function SE.GetActorSkills(actorId, activeOnly)
  local skills = _ENV["!"]({})
  for _, skill in ipairs(PB.all("ActorSkill")) do
    if skill.actorId == actorId and not skill.isLink and skill.displayIndex > 0 and (not activeOnly or not skill.isPassive) then
      local skillGroup = skills[skill.displayIndex] or {}
      table.insert(skillGroup, skill)
      skills[skill.displayIndex] = skillGroup
    end
  end
  return skills
end

function SE.GetSkillCount(actor)
  local curLevelSum = 0
  local skills = SE.GetActorSkills(actor.id)
  for _, skillGroup in pairs(skills) do
    curLevelSum = curLevelSum + SE.GetSkillLevel(actor, skillGroup[1].skillId)
  end
  return curLevelSum
end

function SE.HasSkillToUpgrade(actor)
  local skillFlag = false
  local skills = SE.GetActorSkills(actor.id)
  for i = 1, #skills do
    local skillGroup = skills[i]
    local skillLevel = SE.GetSkillLevel(actor, skillGroup[1].skillId)
    if 0 < skillLevel then
      local nextSkillLevelup = PB.get("SkillLevelup", skillGroup[1].costIndex, skillLevel + 1)
      if nextSkillLevelup ~= nil then
        local actorSkillMaxLevel = PB.get("ActorSkillMaxLevel", actor.id, actor.star)
        if actorSkillMaxLevel == nil then
          error("ActorSkillMaxLevel", "ActorSkillMaxLevel.xlsx error, id : " .. actor.id .. " star : " .. actor.star)
          return false
        end
        local skillMaxLevel = actorSkillMaxLevel.maxLevel[skillGroup[1].displayIndex]
        if skillMaxLevel == nil then
          error("ActorSkillMaxLevel", "can't find max skill level, actorId: " .. tostring(actor.id) .. " actorStar: " .. tostring(actor.star) .. " displayIndex: " .. tostring(skillGroup[1].displayIndex))
          return false
        end
        local skillLevelSatisfied = skillLevel < skillMaxLevel
        local affordAble = true
        local cost = nextSkillLevelup.cost
        if skillLevelSatisfied then
          for j = 1, #cost do
            local costCount = cost[j].count
            local stockCount = 0
            if cost[j].type == PB.enum.ResourceType.ResItem then
              stockCount = DB:GetData("fci/item/" .. cost[j].id).count
            else
              stockCount = DB:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[cost[j].type] .. "_" .. cost[j].id)
            end
            if costCount > stockCount then
              affordAble = false
              break
            end
          end
        end
        skillFlag = skillLevelSatisfied and affordAble
        if skillFlag == true then
          break
        end
      end
    end
  end
  return skillFlag
end

function SE.IsSkillUnlockedRaw(skill)
  local unlockStarCount = 0
  if skill.isPassive then
    local _, actorAttrStarPromotion = PB.all("ActorAttrStarPromotion"):find(function(_, v)
      return v.unlockSkillId == skill.skillId
    end)
    if actorAttrStarPromotion then
      unlockStarCount = actorAttrStarPromotion.star
    end
  end
  return unlockStarCount
end

function SE.IsSkillUnlocked(actor, skill)
  local unlocked = true
  local unlockStarCount = 0
  if skill.isPassive then
    local _, actorAttrStarPromotion = PB.all("ActorAttrStarPromotion"):find(function(_, v)
      return v.unlockSkillId == skill.skillId
    end)
    if actorAttrStarPromotion and actor.star < actorAttrStarPromotion.star then
      unlockStarCount = actorAttrStarPromotion.star
      unlocked = false
    end
  end
  return unlocked, unlockStarCount
end

function SE.GetSkillDetail(actor, actorSkillGroup, describeColor, actionIndex, speIndex)
  local result = {}
  local defaultSkill = actorSkillGroup[1]
  result.displayIndex = defaultSkill.displayIndex
  result.skillLevel = math.max(1, SE.GetSkillLevel(actor, defaultSkill.skillId))
  result.skillIds = {}
  result.skillNames = {}
  result.mainTexturePaths = {}
  result.kindIcons = {}
  local actorConfig = PB.get("ActorConfig", actor.id)
  if actorConfig then
    for _, skill in ipairs(actorSkillGroup) do
      table.insert(result.skillIds, skill.skillId)
      table.insert(result.skillNames, WU.GetString("SkillName_" .. skill.skillId))
      table.insert(result.mainTexturePaths, SE.GetSkillTexturePath(skill, actorConfig.id))
      if not skill.isPassive then
        table.insert(result.kindIcons, SE.GetActorSkillCombo(skill.skillId).kindIcon)
      end
    end
  else
    error("ActorConfig", "ActorConfig.xlsx error , id  " .. tostring(actor.id))
  end
  local levelLimit = PB.get("ActorSkillMaxLevel", actor.id, actor.star)
  local max = PB.get("ActorSkillMaxLevel", actor.id, 6)
  if levelLimit and max then
    result.isMax = max.maxLevel[result.displayIndex] == result.skillLevel
    result.isLevelLimit = levelLimit.maxLevel[result.displayIndex] <= result.skillLevel
    if not result.isMax then
      for i = 1, 6 do
        local actorSkillMaxLevel = PB.get("ActorSkillMaxLevel", actor.id, i)
        if actorSkillMaxLevel.maxLevel[result.displayIndex] > result.skillLevel then
          result.nextLevelStar = actorSkillMaxLevel.star
          break
        end
      end
      local skillLevelup = PB.get("SkillLevelup", defaultSkill.costIndex, result.skillLevel + 1)
      result.levelupCosts = skillLevelup.cost
    end
    result.describes = {}
    result.nextDescribes = {}
    for _, skill in ipairs(actorSkillGroup) do
      local effect = {}
      effect.current = SE.GetSkillEffectCommon(skill, result.skillLevel, actionIndex, speIndex)
      table.insert(result.describes, WU.FormatString(TU.render(WU.GetString("SkillDescribe_" .. skill.skillId), effect.current), describeColor))
      if not result.isMax then
        effect.next = SE.GetSkillEffectCommon(skill, result.skillLevel + 1, actionIndex, speIndex)
        table.insert(result.nextDescribes, WU.FormatString(TU.render(WU.GetString("NextSkillDescribe_" .. skill.skillId), effect), describeColor))
      end
    end
  else
    error("ActorSkillMaxLevel", "ActorSkillMaxLevel.xlsx error, id " .. tostring(actor.id) .. " star " .. tostring(actor.star))
  end
  return result
end

function SE.GetSkillEffectCommon(skill, level, actionIndex, speIndex)
  local effect
  if skill.isPassive then
    effect = SE.GetSpecialEffect(skill.specialIndex[speIndex or 1], level)
  else
    effect = SE.GetActorComboEffect(skill.skillId, level, actionIndex, speIndex)
  end
  return effect
end

function SE.GetSkillTexturePath(skill, actorId)
  if skill.isPassive then
    local actorConfig = PB.get("ActorConfig", actorId)
    local index = fif(actorConfig.kind == PB.enum.ActorType.Sub, skill.resIndex + 2, skill.resIndex)
    return "Texture/ActorSkillBig/actor_skill_" .. index
  else
    return "Texture/ActorSkillBig/actor_skill_" .. actorId .. string.format("%02d", skill.resIndex)
  end
end

function SE.IsSuperSkill(skill)
  return not skill.isPassive and skill.displayIndex == 3
end

function SE.GetTowerPillDesc(id, showAttr, iconColor)
  local desc = ""
  local pillInfo = PB.get("ExtremeChallengeBuffItem", id)
  local buffIds = _ENV["!"]({})
  for i = 1, #pillInfo.itemPos do
    buffIds[i] = pillInfo.itemPos[i].buffIds[1]
  end
  buffIds = buffIds:distinct()
  local preInfo = false
  local tpl = WU.GetString("Tower_PillDesc_" .. id)
  local tplParam = GetActivityFightBuffTplParam(buffIds, false)
  desc = desc .. TU.render(tpl, tplParam) .. "</br>"
  if showAttr then
    local color = fif(iconColor == 1 or iconColor == nil, "", "_white")
    if pillInfo.dragfastAdd ~= nil and pillInfo.dragfastAdd ~= 0 then
      desc = desc .. string.format("<img src='Tournament.challenge_limit_icon%s'/> + %s", color, pillInfo.dragfastAdd)
      preInfo = true
    end
    if pillInfo.score ~= nil and pillInfo.score ~= 0 then
      desc = fif(preInfo, "&nbsp;&nbsp;&nbsp;", "") .. desc .. string.format("<img src='Tournament.challenge_hotspot_icon%s'/> + %s", color, pillInfo.score)
    end
  end
  return desc
end

function SE.GetActivityBuffDesc(goodsId, grade, upgrade)
  local localeStr = fif(upgrade, "ActivityBuffGoodUpgradeDesc_", "ActivityBuffGoodDesc_") .. goodsId
  local xlsxConfig = PB.get("ActivityBuffGoods", goodsId, grade)
  local upgradeXlsxConfig = PB.get("ActivityBuffGoods", goodsId, grade + 1)
  if xlsxConfig.buffType == PB.enum.ActivityBuffType.Fight then
    local tpl = WU.GetString(localeStr)
    local tplParam = GetActivityFightBuffTplParam(xlsxConfig.buffId, false)
    if upgrade then
      local upgradeTplParam = GetActivityFightBuffTplParam(upgradeXlsxConfig.buffId, true)
      table.merge(tplParam, upgradeTplParam)
    end
    return TU.render(tpl, tplParam)
  else
    local profit = PB.get("ProfitDetail", xlsxConfig.buffId)
    if upgrade then
      local upgradeProfit = PB.get("ProfitDetail", upgradeXlsxConfig.buffId)
      return WU.GetString(localeStr, profit.add, upgradeProfit.add)
    else
      return WU.GetString(localeStr, profit.add)
    end
  end
end

function SE.GetTplParamByFightBuffId(fightBuffId)
  return GetActivityFightBuffTplParam(fightBuffId, false)
end

function GetActivityFightBuffTplParam(fightBuffId, upgrade)
  local tplParam = {}
  local affixIds = _ENV["!"]({})
  
  local function GetAffixList(buffId)
    local team1 = PB.get("FightBuff", buffId).team1
    local team2 = PB.get("FightBuff", buffId).team2
    for i = 1, 6 do
      if team1[i] then
        local affixList = team1[i].affixList
        for j = 1, #affixList do
          if affixList[j] ~= 0 then
            table.insert(affixIds, affixList[j])
          end
        end
      end
      if team2[i] then
        local affixList = team2[i].affixList
        for j = 1, #affixList do
          if affixList[j] ~= 0 then
            table.insert(affixIds, affixList[j])
          end
        end
      end
    end
  end
  
  if type(fightBuffId) == "table" then
    for k, v in pairs(fightBuffId) do
      GetAffixList(v)
    end
  else
    GetAffixList(fightBuffId)
  end
  affixIds = affixIds:distinct()
  local buffs = {}
  local buffsDup = {}
  for i = 1, #affixIds do
    local affixInfo = PB.get("AffixInfo", affixIds[i])
    local specialAttrInfo = PB.get("SpecialAttrInfo", affixInfo.index)
    if specialAttrInfo == nil then
      error("GamePlay", string.format("SpecialAttrInfo.xlsx\233\135\140\230\178\161\230\156\137\239\188\140index: %s, fightBuffId: %s", affixInfo.index, fightBuffId))
    end
    local specialAttrInfoIds = _ENV["!"](specialAttrInfo.childSpecialAttrInfoId):duplicate()
    table.insert(specialAttrInfoIds, specialAttrInfo.index)
    for j = 1, #specialAttrInfoIds do
      local buffIndex = PB.get("BuffIndex", specialAttrInfoIds[j])
      local buffIds = buffIndex.buffId
      local owners = buffIndex.owner
      for k = 1, #buffIds do
        local data = PB.get("BuffData", buffIds[k], owners[k])
        local dupKey = string.format("%s_%s", data.id, data.owner)
        local dup = buffsDup[dupKey]
        if dup then
          if dup.level ~= affixInfo.level then
            error("GamePlay", string.format("buffData\230\156\137\233\135\141\229\164\141\239\188\140id: %s, fightBuffId: %s", data.id, fightBuffId))
          end
        else
          local buff = {
            level = affixInfo.level,
            data = data
          }
          table.insert(buffs, buff)
          buffsDup[dupKey] = buff
        end
      end
    end
  end
  table.sort(buffs, function(a, b)
    return a.data.priority < b.data.priority
  end)
  for i = 1, #buffs do
    local dataEnv = {}
    local rate = buffs[i].level / buffs[i].data.maxLevel * buffs[i].data.upRate / 10000
    for j = 1, #buffs[i].data.paramInt do
      dataEnv["p" .. tostring(j - 1)] = buffs[i].data.paramInt[j] * rate
      dataEnv.maxRound = buffs[i].data.maxRound
    end
    tplParam[fif(upgrade, "upgradeBuff", "buff") .. tostring(i - 1)] = dataEnv
  end
  return tplParam
end

function SE.GetWeaponSpecials(weaponId)
  local result = {}
  local uniqueWeaponSkillAll = PB.all("UniqueWeaponSkill")
  local uniqueWeaponSkills = {}
  for k, v in pairs(uniqueWeaponSkillAll) do
    if v.id == weaponId then
      table.insert(uniqueWeaponSkills, v)
    end
  end
  if not table.empty(uniqueWeaponSkills) then
    table.sort(uniqueWeaponSkills, function(a, b)
      return a.phase < b.phase
    end)
    local excludeSpecial = {}
    for i = 1, #uniqueWeaponSkills do
      local uniqueWeaponSkill = uniqueWeaponSkills[i]
      for si = 1, #uniqueWeaponSkill.specials do
        local special = uniqueWeaponSkill.specials[si]
        if not excludeSpecial[special.index] then
          excludeSpecial[special.index] = true
          result[uniqueWeaponSkill.phase] = result[uniqueWeaponSkill.phase] or {}
          table.insert(result[uniqueWeaponSkill.phase], special)
        end
      end
    end
  end
  return result
end

function SE.GetWeaponSkillDesc(id, phase)
  local specials = SE.GetWeaponSpecials(id)[tonumber(phase + 1)]
  local specialDesc = ""
  if specials ~= nil then
    for i = 1, #specials do
      local specialIndex = specials[i].index
      if 0 < specialIndex then
        local effect = SE.GetSpecialEffect(specialIndex, phase or 1)
        specialDesc = specialDesc .. WU.FormatString(TU.render(WU.GetString("UniqueWeaponSpecial_" .. specialIndex), effect), "#0090ff", "#fd5454")
      end
    end
  end
  return WU.GetString("UniqueWeaponSkill_" .. id) .. specialDesc
end

function SE.GetWeaponSkillGrow(id)
  local descTab = {}
  local specialGroup = SE.GetWeaponSpecials(id)
  for k, v in pairs(specialGroup) do
    local specialDesc = ""
    local specials = v
    for i = 1, #specials do
      local specialIndex = specials[i].index
      if 0 < specialIndex then
        local effect = SE.GetSpecialEffect(specialIndex, k or 1)
        specialDesc = specialDesc .. TU.render(WU.GetString("UniqueWeaponSpecialGrow_" .. specialIndex), effect)
      end
    end
    table.insert(descTab, specialDesc)
  end
  return descTab
end

function SE.GetWeaponProcess(id)
  local descTab = {}
  local skillGrow = SE.GetWeaponSkillGrow(id)
  local skillInfo = PB.all("UniqueWeaponSkill"):where(function(k, v)
    return v.id == id
  end):toarray()
  table.sort(skillInfo, function(a, b)
    return a.phase < b.phase
  end)
  for i = 1, #skillInfo do
    local desc = ""
    local val = skillInfo[i]
    if 1 < i then
      local last = skillInfo[i - 1]
      if val.costWP ~= last.costWP then
        desc = desc .. fif(desc ~= "", "<br/>", "") .. WU.GetString("UniqueWeapon_costWP", val.costWP)
      end
      if val.limitWP ~= last.limitWP then
        desc = desc .. fif(desc ~= "", "<br/>", "") .. WU.GetString("UniqueWeapon_limitWP", val.limitWP)
      end
      if val.fireCount ~= last.fireCount then
        desc = desc .. fif(desc ~= "", "<br/>", "") .. WU.GetString("UniqueWeapon_fireCount", val.fireCount)
      end
      if val.chargeWP ~= last.chargeWP then
        desc = desc .. fif(desc ~= "", "<br/>", "") .. WU.GetString("UniqueWeapon_chargeWP", val.chargeWP)
      end
      if val.initWP ~= last.initWP then
        desc = desc .. fif(desc ~= "", "<br/>", "") .. WU.GetString("UniqueWeapon_initWP", val.initWP)
      end
      if val.costUseCount ~= last.costUseCount then
        desc = desc .. fif(desc ~= "", "<br/>", "") .. WU.GetString("UniqueWeapon_costUseCount", val.costUseCount)
      end
    end
    descTab[i] = skillGrow[i] .. fif(desc ~= "", "<br/>", "") .. desc
  end
  return descTab
end

function SE.GetAffixTplParam(affixId)
  local tplParam = {}
  local buffs = {}
  local buffsDup = {}
  local affixInfo = PB.get("AffixInfo", affixId)
  if affixInfo == nil then
    error("AffixInfo.xlsx has no this affixId " .. affixId)
    return
  end
  local specialAttrInfo = PB.get("SpecialAttrInfo", affixInfo.index)
  if specialAttrInfo == nil then
    error("GamePlay", string.format("SpecialAttrInfo.xlsx\233\135\140\230\178\161\230\156\137\239\188\140index: %s, fightBuffId: %s", affixInfo.index, fightBuffId))
  end
  local specialAttrInfoIds = _ENV["!"](specialAttrInfo.childSpecialAttrInfoId):duplicate()
  table.insert(specialAttrInfoIds, specialAttrInfo.index)
  for j = 1, #specialAttrInfoIds do
    local buffIndex = PB.get("BuffIndex", specialAttrInfoIds[j])
    local buffIds = buffIndex.buffId
    local owners = buffIndex.owner
    for k = 1, #buffIds do
      local data = PB.get("BuffData", buffIds[k], owners[k])
      local dupKey = string.format("%s_%s", data.id, data.owner)
      local dup = buffsDup[dupKey]
      if dup then
        if dup.level ~= affixInfo.level then
          error("GamePlay", string.format("buffData\230\156\137\233\135\141\229\164\141\239\188\140id: %s, fightBuffId: %s", data.id, fightBuffId))
        end
      else
        local buff = {
          level = affixInfo.level,
          data = data
        }
        table.insert(buffs, buff)
        buffsDup[dupKey] = buff
      end
    end
  end
  table.sort(buffs, function(a, b)
    return a.data.priority < b.data.priority
  end)
  for i = 1, #buffs do
    local dataEnv = {}
    local rate = buffs[i].level / buffs[i].data.maxLevel * buffs[i].data.upRate / 10000
    for j = 1, #buffs[i].data.paramInt do
      dataEnv["p" .. tostring(j - 1)] = buffs[i].data.paramInt[j] * rate
    end
    dataEnv.maxRound = buffs[i].data.maxRound
    tplParam["buff" .. tostring(i - 1)] = dataEnv
  end
  return tplParam
end

return SE
