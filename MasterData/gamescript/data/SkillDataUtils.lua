local SkillDataUtils = {}

function SkillDataUtils.GetSkillCfg(tid)
  local cfg = DT.Skill[tid]
  if not cfg then
    return nil
  end
  return cfg
end

function SkillDataUtils.GetSkillCfgByField(field, tid)
  local cfg = SkillDataUtils.GetSkillCfg(tid)
  if not cfg then
    return nil
  end
  return cfg[field]
end

function SkillDataUtils.GetSkillType(tid)
  local type = SkillDataUtils.GetSkillCfgByField("Type", tid)
  return type and type[1]
end

function SkillDataUtils.ParseCmdTargetStr(str, skillId, params)
  if type(str) == "table" then
    local newParams = table.clone(params or {})
    newParams.breakSkillLevel = 0
    newParams.potencyLevel = 0
    newParams.skillId = skillId
    local ret = BattleSkillUtils.GetMatchTQ(str, newParams)
    if ret then
      str = ret
    end
  end
  local cmdTargetType, tag = string.match(str, "([%w_]+)%(([%w_]+)%)")
  cmdTargetType = cmdTargetType or string.match(str, "([%w_]+)")
  return cmdTargetType, tag
end

function SkillDataUtils.CheckIsUltiSkill(tid)
  local slot = SkillDataUtils.GetSkillCfgByField("Slot", tid)
  if not slot then
    return false
  end
  return "Slot_Super" == slot
end

return SkillDataUtils
