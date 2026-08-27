local FairySkillData = class("FairySkillData")
local cs_GameData_ins = CS.GameData.instance
local cs_FormulaUtility = CS.FormulaUtility

function FairySkillData.GenFairySkillData(fairyUID, fairySkillMsg)
  local fairySkillData = FairySkillData.New()
  fairySkillData.fairyUID = fairyUID
  fairySkillData:UpdaetFairySkillData(fairySkillMsg)
  return fairySkillData
end

function FairySkillData.GenFairyFakeData(fairySkillId)
  local fairySkillData = FairySkillData.New()
  local msg = {id = fairySkillId}
  fairySkillData:UpdaetFairySkillData(msg)
  return fairySkillData
end

function FairySkillData.GenFairyKeepData(msg, skillUid)
  local fairySkillData = FairySkillData.New()
  fairySkillData.fairySkillId = msg.skillId
  fairySkillData.fairyUID = msg.uid
  fairySkillData.fairySkillRare = msg.grade
  fairySkillData.fairySkillCfg = ConfigData.fairy_skill[msg.skillId]
  fairySkillData.isUnique = fairySkillData.fairySkillCfg.special
  fairySkillData.isNew = msg.isNew
  fairySkillData.isMine = msg.isMine
  fairySkillData.skillUid = skillUid
  return fairySkillData
end

function FairySkillData:ctor()
  self.fairySkillId = nil
  self.fairyUID = nil
  self.slotIndex = nil
  self.fairySkillCfg = nil
  self.fairySkillRare = nil
  self.isUnique = nil
  self.isNew = nil
  self.isMine = nil
  self.skillUid = nil
end

function FairySkillData:UpdaetFairySkillData(fairySkillMsg)
  self.fairySkillId = fairySkillMsg.id
  self.slotIndex = fairySkillMsg.slot
  self.fairySkillCfg = ConfigData.fairy_skill[self.fairySkillId]
  self.fairySkillRare = fairySkillMsg.grades
  self.isUnique = self.fairySkillCfg.special
end

function FairySkillData:_GetSkillCfg()
  if self.__skillCfg ~= nil then
    return self.__skillCfg
  end
  local skillId = self:GetFiaryRealSkillId()
  self.__skillCfg = cs_GameData_ins.listBattleSkillDatas:GetDataById(skillId)
  return self.__skillCfg
end

function FairySkillData:GetFairyPoolId()
  return self.fairySkillCfg.pool_id
end

function FairySkillData:GetFiaryRealSkillId()
  local skillId
  if self.fairySkillCfg.function_id ~= 0 then
    skillId = self.fairySkillCfg.function_id
  else
    skillId = self.fairySkillCfg.tSkillId
  end
  return skillId
end

function FairySkillData:GetFairySkillType()
  local cfg = self:_GetSkillCfg()
  return cfg.SkillTag
end

function FairySkillData:GetFairySkillName()
  local cfg = self:_GetSkillCfg()
  return cfg.Name
end

function FairySkillData:GetFairySkillSimpleDesc()
  local cfg = self:_GetSkillCfg()
  return cfg:GetDescribe()
end

function FairySkillData:GetFairySkillDesc()
  local cfg = self:_GetSkillCfg()
  local level = self:GetFairySkillLevel()
  return cfg:GetLevelDescribe(level)
end

function FairySkillData:GetFairySkillCD()
  local skillId = self:GetFiaryRealSkillId()
  local level = self:GetFairySkillLevel()
  return cs_FormulaUtility.CalculateSkillCd(skillId, level)
end

function FairySkillData:GetFairySkillIcon()
  local cfg = self:_GetSkillCfg()
  return cfg.Icon
end

function FairySkillData:GetFairySkillRareLevel()
  return self.fairySkillRare or 1
end

function FairySkillData:GetFairySkillLevel()
  local level = ConfigData.fairy_skill_weight[self.fairySkillRare or 1].skill_level
  return level
end

function FairySkillData:GetFairySkillSlotIndex()
  return self.slotIndex
end

function FairySkillData:GetFairyPowFormulaStr()
  return self.fairySkillCfg.combat_para
end

function FairySkillData:TryGetFairyNormalSkillRealId()
  return self.fairySkillCfg.function_id
end

function FairySkillData:TryGetFairySkillReplace()
  if self.fairySkillCfg.sSkillId == 0 then
    return nil
  end
  return self.fairySkillCfg.sSkillId, self.fairySkillCfg.tSkillId
end

function FairySkillData:GetSkillAtlasName()
  if self.fairySkillCfg.sSkillId == 0 then
    return "SkillIcon"
  else
    return "CommanderSkillIcons"
  end
end

function FairySkillData:IsUniqueSkill()
  return self.isUnique
end

function FairySkillData:IsSameFairySkill(skillData)
  if skillData == nil then
    return false
  end
  local selfSkillId = self:GetFiaryRealSkillId()
  local targetSkillId = skillData:GetFiaryRealSkillId()
  return selfSkillId == targetSkillId
end

function FairySkillData:IsCommanderSkill()
  if self.fairySkillCfg.sSkillId == 0 then
    return false
  end
  return true
end

function FairySkillData:IsFySkillNew()
  return self.isNew
end

function FairySkillData:IsFySkillMine()
  return self.isMine
end

function FairySkillData:GetSkillUid()
  return self.skillUid
end

return FairySkillData
