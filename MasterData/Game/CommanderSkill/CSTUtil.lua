local CSTUtil = {}
local cs_GameData_ins = CS.GameData.instance

function CSTUtil.IsCSTSkillUnlock(cstSkillId)
  local cstId = ConfigData.commander_skill_unlock.cstSkillId2cstId[cstSkillId]
  if cstId == nil then
    error("cst skill " .. tostring(cstSkillId) .. " not have cstId")
    return false
  end
  local skillCfg = ConfigData.commander_skill_unlock[cstId][cstSkillId]
  if skillCfg == nil then
    return false
  end
  local isUnlock = CheckCondition.CheckLua(skillCfg.pre_condition, skillCfg.pre_para1, skillCfg.pre_para2)
  return isUnlock
end

function CSTUtil.GetCSTSkillUnlockDes(cstSkillId)
  local cstId = ConfigData.commander_skill_unlock.cstSkillId2cstId[cstSkillId]
  if cstId == nil then
    error("cst skill " .. tostring(cstSkillId) .. " not have cstId")
    return false
  end
  local skillCfg = ConfigData.commander_skill_unlock[cstId][cstSkillId]
  if skillCfg == nil then
    return false
  end
  return CheckCondition.GetUnlockInfoLua(skillCfg.pre_condition, skillCfg.pre_para1, skillCfg.pre_para2)
end

function CSTUtil.GetCSTSkillIconById(skillId)
  local battleSkillCfg = cs_GameData_ins.listBattleSkillDatas:GetDataById(skillId)
  if battleSkillCfg == nil then
    error("Battle Skill Cfg is null,Id:" .. tostring(skillId))
    return
  end
  return battleSkillCfg.Icon
end

function CSTUtil.GetDefaultSavingData(cstId)
  local skills = {}
  local skillDicCfg = ConfigData.commander_skill_unlock[cstId]
  for skillId, skillCfg in pairs(skillDicCfg) do
    local isUnlock = CSTUtil.IsCSTSkillUnlock(skillId)
    if isUnlock and skills[skillCfg.place] == nil then
      skills[skillCfg.place] = {
        skillId = skillCfg.skill_id,
        replaced = false,
        lv = 1
      }
    end
  end
  return {id = cstId, skills = skills}
end

function CSTUtil.GetSavingData4OldMsg(realSkills)
  local cstId
  local skills = {}
  for place, skillId in ipairs(realSkills) do
    local cstSkillId = ConfigData.commander_skill_unlock.realSkillId2CSTSIdDic[skillId]
    local _cstId = ConfigData.commander_skill_unlock.cstSkillId2cstId[cstSkillId]
    if cstId == nil then
      cstId = _cstId
    elseif cstId ~= _cstId then
      error("老版指挥官技能树存在问题--请检查")
      return
    end
    skills[place] = {
      skillId = skillId,
      replaced = false,
      lv = 1
    }
  end
  return {id = cstId, skills = skills}
end

function CSTUtil.CheckCmdSkillChange(oldCstData, newCstData)
  if oldCstData == nil then
    return true
  end
  local os = oldCstData:GetCSTSavingData()
  local ns = newCstData:GetCSTSavingData()
  if os.id ~= ns.id then
    return true
  end
  for slot, e in ipairs(os.skills) do
    if ns.skills[slot].skillId ~= e.skillId then
      return true
    end
  end
  return false
end

return CSTUtil
