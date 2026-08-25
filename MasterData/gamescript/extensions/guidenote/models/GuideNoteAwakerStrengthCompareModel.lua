local GuideNoteAwakerStrengthCompareModel = {}
local cd = CommonDefine

function GuideNoteAwakerStrengthCompareModel.BuildLevelText(level, levelLimit)
  do return string.format, "Lv.%s/%s", tostring(level or 0), tostring(levelLimit or 0) end
  return string.format, "Lv.%s/%s", tostring(level or 0), tostring(levelLimit or 0)
end

function GuideNoteAwakerStrengthCompareModel.BuildSkillText(skills, targetLevel)
  if type(skills) ~= "table" or 0 == #skills then
    do return tostring end
    return tostring, targetLevel or 0, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  local desc = ""
  for i, skill in ipairs(skills) do
    local lv = skill and skill.level or 0
    local val
    if type(targetLevel) == "table" then
      val = nil ~= targetLevel[i] and targetLevel[i] or lv
    else
      val = nil ~= targetLevel and targetLevel or lv
    end
    if 1 == i then
      desc = tostring(val)
    else
      desc = desc .. "/" .. tostring(val)
    end
  end
  return desc
end

function GuideNoteAwakerStrengthCompareModel.BuildEmptyCompareData()
  return {
    awaker = nil,
    name = "",
    curLevel = 0,
    targetLevel = 0,
    curSkill = 0,
    targetSkill = 0,
    curTalent = 0,
    targetTalent = 0,
    curPotency = 0,
    targetPotency = 0,
    curLevelText = "-",
    targetLevelText = "-",
    curSkillText = "-",
    targetSkillText = "-",
    curTalentText = "-",
    targetTalentText = "-"
  }
end

function GuideNoteAwakerStrengthCompareModel.GetReachableSkillTargetLevel(curLv, maxSkillLv, curBreakSkill)
  local level = tonumber(curLv) or 0
  local maxLv = tonumber(maxSkillLv) or 0
  local breakSkill = tonumber(curBreakSkill) or 0
  if maxLv <= 0 or level >= maxLv then
    do return math.max, level end
    return math.max, level, maxLv
  end
  while level < maxLv do
    local unlocked = AwakerDataUtils.CheckSkillLevelUpUnlockCondition(level)
    if true ~= unlocked then
      break
    end
    local needBreakLv = AwakerDataUtils.GetSkillLevelUpBreakthroughNeed(level) or 0
    if breakSkill < needBreakLv then
      break
    end
    level = level + 1
  end
  return level
end

function GuideNoteAwakerStrengthCompareModel._IsBreakthroughTaskMet(requireTaskComplete)
  if type(requireTaskComplete) ~= "table" or #requireTaskComplete <= 0 then
    return true
  end
  for _, tasks in ipairs(requireTaskComplete) do
    if type(tasks) == "table" and #tasks > 0 and TaskDataUtils and TaskDataUtils.CheckTaskListIsAllDone and TaskDataUtils.CheckTaskListIsAllDone(tasks) == true then
      return true
    end
  end
  return false
end

function GuideNoteAwakerStrengthCompareModel._SimulateBreakthroughReachableStar(awakerTid, curStar)
  local breakthroughCfg = DT.AwakerBreakThrough and DT.AwakerBreakThrough[math.abs(awakerTid)]
  if not breakthroughCfg or not breakthroughCfg.data_list then
    return curStar, {}
  end
  local reachableStar = curStar
  local breakthroughNeedMap = {}
  local maxStarIdx = #breakthroughCfg.data_list
  for idx = curStar + 1, maxStarIdx do
    local starCfg = breakthroughCfg.data_list[idx]
    if not (starCfg and GuideNoteAwakerStrengthCompareModel._IsBreakthroughTaskMet(starCfg.RequireTaskComplete)) then
      break
    end
    local requireItems = starCfg.RequireentItem
    if requireItems and type(requireItems) == "table" then
      for tid, needCount in pairs(requireItems) do
        local numTid = tonumber(tid) or 0
        local numNeed = tonumber(needCount) or 0
        if 0 ~= numTid and numNeed > 0 then
          breakthroughNeedMap[numTid] = (breakthroughNeedMap[numTid] or 0) + numNeed
        end
      end
    end
    reachableStar = idx
  end
  return reachableStar, breakthroughNeedMap
end

function GuideNoteAwakerStrengthCompareModel._GetTalentCfgByType(awakerTid, talentType)
  if not (awakerTid and 0 ~= awakerTid and talentType) or 0 == talentType or not DT.AwakerTalent then
    return nil
  end
  for _, cfg in pairs(DT.AwakerTalent) do
    local firstCfg = cfg and cfg.data_list and cfg.data_list[1]
    if firstCfg and firstCfg.AwakerID == awakerTid and firstCfg.TalentType == talentType then
      return cfg
    end
  end
  return nil
end

function GuideNoteAwakerStrengthCompareModel._GetReachableTalentLevel(awaker, talentCfg)
  if not talentCfg or not talentCfg.data_list then
    return 0
  end
  local curLv = 0
  local talentTid = talentCfg.ID
  if awaker and awaker.talents and awaker.talents[talentTid] and awaker.talents[talentTid].lv then
    curLv = tonumber(awaker.talents[talentTid].lv) or 0
  end
  local reachableLv = curLv
  for lv = curLv + 1, #talentCfg.data_list do
    local cfg = talentCfg.data_list[lv]
    if not cfg then
      break
    end
    local canUpgrade = true
    if cfg.TaskCondition and TaskDataUtils and TaskDataUtils.CheckTaskListIsAllDone then
      canUpgrade = TaskDataUtils.CheckTaskListIsAllDone(cfg.TaskCondition) == true
    end
    if true ~= canUpgrade then
      break
    end
    reachableLv = lv
  end
  return reachableLv
end

function GuideNoteAwakerStrengthCompareModel._GetTalentCurrentAndReachableAndMax(awakerTid, awaker, talentType)
  local talentCfg = GuideNoteAwakerStrengthCompareModel._GetTalentCfgByType(awakerTid, talentType)
  if not talentCfg or not talentCfg.data_list then
    return 0, 0, 0
  end
  local talentTid = talentCfg.ID
  local curLv = 0
  if awaker and awaker.talents and awaker.talents[talentTid] and awaker.talents[talentTid].lv then
    curLv = tonumber(awaker.talents[talentTid].lv) or 0
  end
  local reachableLv = GuideNoteAwakerStrengthCompareModel._GetReachableTalentLevel(awaker, talentCfg)
  local maxLv = #talentCfg.data_list
  return curLv, reachableLv, maxLv
end

function GuideNoteAwakerStrengthCompareModel.BuildCompareData(awakerTid)
  local awaker = AwakerDataUtils.GetAwakerData(awakerTid)
  if not awaker then
    do return end
    return GuideNoteAwakerStrengthCompareModel.BuildEmptyCompareData, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  local curLevel = awaker.level or 1
  local curPotency = AwakerDataUtils.GetAwakerPotencyLevel(awakerTid) or 0
  local curLevelLimit = AwakerDataUtils.GetAwakerCurrLevelLimit(awaker, curPotency)
  curLevel = math.min(curLevel, curLevelLimit)
  local curBreakSkill = AwakerDataUtils.GetBreakSkillLevel(awaker) or 0
  local curStar = awaker.currBreakthroughStar or 0
  local reachableStar, breakthroughNeedMap = GuideNoteAwakerStrengthCompareModel._SimulateBreakthroughReachableStar(awakerTid, curStar)
  local targetBreakLevelLimit = AwakerDataUtils.GetAwakerBreakThroughLevelLimit(awakerTid, reachableStar) or 0
  local potencyAndIncreaseValue = AwakerDataUtils.GetAwakerPotencyAndIncreaseLevelValue(awaker, curPotency) or 0
  local targetLevelLimit = targetBreakLevelLimit + potencyAndIncreaseValue
  if curLevelLimit > targetLevelLimit then
    targetLevelLimit = curLevelLimit
  end
  local targetLevel = math.max(curLevel, targetLevelLimit)
  local baseSkillSlotNum = DT.GetConstant("AwakerSkillListNum") or 6
  local awakerCfg = AwakerDataUtils.GetAwakerConfig(awakerTid) or {}
  local skillTidList = awakerCfg.SkillList or {}
  local skillsMap = awaker.skills or {}
  local cfgSkillUpper = AwakerDataUtils.GetMaxSkillLv() or 0
  local skills = {}
  local curSkillLevels = {}
  local targetSkillLevels = {}
  local curSkillMax = 0
  for slot = 1, baseSkillSlotNum do
    local slotSkillData = skillsMap and skillsMap[slot] or nil
    local curLv = slotSkillData and slotSkillData.level or 1
    local targetLv = GuideNoteAwakerStrengthCompareModel.GetReachableSkillTargetLevel(curLv, cfgSkillUpper, curBreakSkill)
    table.insert(skills, {
      slot = slot,
      tid = skillTidList[slot] or 0,
      level = curLv
    })
    table.insert(curSkillLevels, curLv)
    table.insert(targetSkillLevels, targetLv)
    if curSkillMax < curLv then
      curSkillMax = curLv
    end
  end
  local targetSkill = 0
  for _, v in ipairs(targetSkillLevels) do
    if v and v > targetSkill then
      targetSkill = v
    end
  end
  local curTalent = {}
  local targetTalent = {}
  local curTotlaTalent = 0
  local targetTotalTalent = 0
  for i = 1, #CommonDefine.AwakerTalentOrderedType do
    local cur, reachable, _ = GuideNoteAwakerStrengthCompareModel._GetTalentCurrentAndReachableAndMax(awakerTid, awaker, CommonDefine.AwakerTalentOrderedType[i])
    cur = math.max(0, tonumber(cur) or 0)
    reachable = math.max(0, tonumber(reachable) or 0)
    curTotlaTalent = curTotlaTalent + cur
    targetTotalTalent = targetTotalTalent + reachable
    table.insert(curTalent, cur)
    table.insert(targetTalent, reachable)
  end
  local curTalentDesc = table.concat(curTalent, "/")
  local targetTalentDesc = table.concat(targetTalent, "/")
  return {
    awaker = awaker,
    name = AwakerDataUtils.GetAwakerName(awakerTid) or "",
    curLevel = curLevel,
    targetLevel = targetLevel,
    curSkill = curSkillMax,
    targetSkill = targetSkill,
    targetSkillLevels = targetSkillLevels,
    skillEntries = skills,
    curTalent = curTotlaTalent,
    targetTalent = targetTotalTalent,
    curPotency = curPotency,
    targetPotency = curPotency,
    breakthroughNeedMap = breakthroughNeedMap,
    curLevelText = GuideNoteAwakerStrengthCompareModel.BuildLevelText(curLevel, curLevelLimit),
    targetLevelText = GuideNoteAwakerStrengthCompareModel.BuildLevelText(targetLevel, targetLevelLimit),
    curSkillText = GuideNoteAwakerStrengthCompareModel.BuildSkillText(skills),
    targetSkillText = GuideNoteAwakerStrengthCompareModel.BuildSkillText(skills, targetSkillLevels),
    curTalentText = curTalentDesc,
    targetTalentText = targetTalentDesc
  }
end

return GuideNoteAwakerStrengthCompareModel
