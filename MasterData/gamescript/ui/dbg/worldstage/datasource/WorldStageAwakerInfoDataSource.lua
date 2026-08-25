local WorldStageAwakerInfoDataSource = System.NewClass("WorldStageAwakerInfoDataSource")

function WorldStageAwakerInfoDataSource:ctor(role, awakerTid)
  self.role = role
  self.awakerTid = awakerTid
end

function WorldStageAwakerInfoDataSource:GetAwakerConfig()
  return DT.AwakerConfig[self.awakerTid]
end

function WorldStageAwakerInfoDataSource:GetCurSkin()
  local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(self.awakerTid)
  return awakerData and awakerData.curSkin
end

function WorldStageAwakerInfoDataSource:GetAwakerLevel()
  local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(self.awakerTid)
  if nil == awakerData then
    return 0
  end
  return awakerData.level
end

function WorldStageAwakerInfoDataSource:IsAwakeSkillVisible()
  do return self.HasAwaked end
  return self.HasAwaked, self
end

function WorldStageAwakerInfoDataSource:HasAwaked()
  local skillData = CopyAwakerDataUtils.GetSkillDataBySlot(self.awakerTid, CommonDefine.AwakerSkillSlot.Slot_Awake)
  if skillData then
    local tid = skillData.tid
    local cardData = CardDataUtils.GetCardInfoByConfigId(tid)
    if cardData and not cardData.lock then
      return true
    end
  end
end

function WorldStageAwakerInfoDataSource:GetShowAttrIds()
  local attrNames = {}
  for id, cfg in pairs(DT.ActorAttrType) do
    if cfg.StageShow then
      table.insert(attrNames, id)
    end
  end
  table.sort(attrNames, function(a, b)
    local cfgA = DT.ActorAttrType[a]
    local cfgB = DT.ActorAttrType[b]
    if cfgA.AttributeSort and cfgB.AttributeSort then
      return cfgA.AttributeSort < cfgB.AttributeSort
    end
    return a < b
  end)
  return attrNames
end

function WorldStageAwakerInfoDataSource:GetProperty(propertyName)
  local awakerAttrData = self.role.roleAttrsList[self.awakerTid]
  return awakerAttrData[propertyName] or 0
end

function WorldStageAwakerInfoDataSource:GetUltiSkillId()
  local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(self.awakerTid)
  for _, skill in pairs(awakerData.skills) do
    if 1 == skill.slot then
      return skill.tid
    end
  end
end

function WorldStageAwakerInfoDataSource:GetUltiSkillLevel()
  local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(self.awakerTid)
  local ultiSkill
  for _, skill in pairs(awakerData.skills) do
    if 1 == skill.slot then
      ultiSkill = skill
      break
    end
  end
  return ultiSkill and ultiSkill.level or 1
end

function WorldStageAwakerInfoDataSource:GetUltiSkillDesc()
  local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(self.awakerTid)
  local ultiSkill
  for _, skill in pairs(awakerData.skills) do
    if 1 == skill.slot then
      ultiSkill = skill
      break
    end
  end
  local tid = ultiSkill.tid
  local lv = ultiSkill.level
  do return SkillUtils.GetAwakerSkillDesc, awakerData, tid, lv end
  return SkillUtils.GetAwakerSkillDesc, awakerData, tid, lv, awakerData.descArgs
end

function WorldStageAwakerInfoDataSource:GetSuperUltlSkillDesc()
  local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(self.awakerTid)
  local ultiSkill
  for _, skill in pairs(awakerData.skills) do
    if 1 == skill.slot then
      ultiSkill = skill
      break
    end
  end
  local tid = ultiSkill.tid
  local lv = ultiSkill.level
  do return SkillUtils.GetAwakerSkillDesc, awakerData, tid, lv, awakerData.descArgs, nil, nil end
  return SkillUtils.GetAwakerSkillDesc, awakerData, tid, lv, awakerData.descArgs, nil, nil, true
end

function WorldStageAwakerInfoDataSource:GetUltiSkillName()
  local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(self.awakerTid)
  local ultiSkill
  for _, skill in pairs(awakerData.skills) do
    if 1 == skill.slot then
      ultiSkill = skill
      break
    end
  end
  local tid = ultiSkill.tid
  local skillConfig = DT.Skill[tid]
  local _, potencyLevel = AwakerDataUtils.GetBreakAndPotencyLevel(awakerData)
  local breakSkillLevel = AwakerDataUtils.GetBreakSkillLevel(awakerData)
  local skillName = BattleSkillUtils.GetSkillName(skillConfig, breakSkillLevel, potencyLevel)
  do return LT.Text end
  return LT.Text, skillName, potencyLevel
end

function WorldStageAwakerInfoDataSource:GetAwakerCardName()
  local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(self.awakerTid)
  local ultiSkill
  for _, skill in pairs(awakerData.skills) do
    if skill.slot == CommonDefine.AwakerSkillSlot.Slot_Awake then
      ultiSkill = skill
      break
    end
  end
  local tid = ultiSkill.tid
  local skillConfig = DT.Skill[tid]
  local _, potencyLevel = AwakerDataUtils.GetBreakAndPotencyLevel(awakerData)
  local breakSkillLevel = AwakerDataUtils.GetBreakSkillLevel(awakerData)
  local skillName = BattleSkillUtils.GetSkillName(skillConfig, breakSkillLevel, potencyLevel)
  return skillConfig and LT.Text(skillName) or ""
end

function WorldStageAwakerInfoDataSource:GetAwakeCardDesc()
  local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(self.awakerTid)
  local ultiSkill
  for _, skill in pairs(awakerData.skills) do
    if 4 == skill.slot then
      ultiSkill = skill
      break
    end
  end
  local tid = ultiSkill.tid
  local lv = ultiSkill.level
  do return SkillUtils.GetAwakerSkillDesc, awakerData, tid end
  return SkillUtils.GetAwakerSkillDesc, awakerData, tid, lv, skill.slot
end

function WorldStageAwakerInfoDataSource:GetWeapon(slotType)
  local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(self.awakerTid)
  do return CopyAwakerDataUtils.GetWeapon, awakerData end
  return CopyAwakerDataUtils.GetWeapon, awakerData, slotType
end

function WorldStageAwakerInfoDataSource:GetWeaponConfig(slotType)
  local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(self.awakerTid)
  do return CopyAwakerDataUtils.GetWeaponConfig, awakerData end
  return CopyAwakerDataUtils.GetWeaponConfig, awakerData, slotType
end

function WorldStageAwakerInfoDataSource:GetAwakerUid()
  local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(self.awakerTid)
  return awakerData and awakerData.uid
end

function WorldStageAwakerInfoDataSource:GetAwakerDataModel()
  local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(self.awakerTid)
  return awakerData
end

return WorldStageAwakerInfoDataSource
