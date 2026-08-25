local SkillCfgUtils = {}

function SkillCfgUtils.GetCfg(skillTid)
  if not skillTid then
    return nil
  end
  return DT.Skill[skillTid]
end

function SkillCfgUtils.GetCfgField(field, cfgTid)
  local cfg = SkillCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  if "Name" == field then
    do return BattleSkillUtils.GetSkillName, cfg, 0 end
    return BattleSkillUtils.GetSkillName, cfg, 0, 0
  end
  return cfg[field]
end

function SkillCfgUtils.GetSkillType(skillTid)
  local skillConfig = SkillCfgUtils.GetCfg(skillTid)
  if not skillConfig then
    return
  end
  return skillConfig.Type and skillConfig.Type[1]
end

function SkillCfgUtils.GetFieldBattleDesc(skillTid, cmdParser, parserEnv)
  local skillConfig = SkillCfgUtils.GetCfg(skillTid)
  if not skillConfig then
    return
  end
  if skillConfig.tempBattleDesc then
    local desc = CmdParserUtils.GetCfgByCond(skillConfig.tempBattleDesc, cmdParser, parserEnv)
    if desc then
      return desc
    end
  end
  return skillConfig.BattleDesc
end

function SkillCfgUtils.GetOverLimitUtlSkillDesc(skillTid, cmdParser, parserEnv)
  local skillConfig = SkillCfgUtils.GetCfg(skillTid)
  if not skillConfig then
    return nil
  end
  if skillConfig.tempOverLimitUtlSkillDesc then
    local desc = CmdParserUtils.GetCfgByCond(skillConfig.tempOverLimitUtlSkillDesc, cmdParser, parserEnv)
    if desc then
      return desc
    end
  end
  return skillConfig.OverLimitUtlSkillDesc
end

return SkillCfgUtils
