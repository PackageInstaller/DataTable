local base = require("Game.Fairy.Data.FairyData")
local DynFairyData = class("DynFairyData", base)
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")

function DynFairyData.GenDynFairyData(fairyStcData)
  local uid = fairyStcData.uid
  local dataId = fairyStcData.dataId
  local level = fairyStcData.level
  local rank = fairyStcData.rank
  local name = fairyStcData.name
  local skillData = {}
  for skillId, grade in pairs(fairyStcData.skillGroup) do
    table.insert(skillData, {
      id = skillId,
      grades = grade,
      slot = #skillData + 1
    })
  end
  local msg = {
    base = {
      uid = uid,
      dataId = dataId,
      level = level,
      exp = 0,
      rank = rank,
      name = name
    },
    skill = {data = skillData}
  }
  local dynFairyData = DynFairyData.New()
  dynFairyData:UpdaetFairyData(msg)
  dynFairyData.dynAttr = fairyStcData.attr
  dynFairyData:InitAllFairySkill()
  return dynFairyData
end

function DynFairyData:ctor()
  self.dynAttr = nil
  self.skillList = nil
end

function DynFairyData:InitAllFairySkill()
  self.skillList = {}
  local skillId2LevelDic = {}
  for slotIndex, fiarySkillData in pairs(self:GetFairySkillDic()) do
    if not fiarySkillData:IsCommanderSkill() then
      local skillID = fiarySkillData:TryGetFairyNormalSkillRealId()
      local skillLevel = fiarySkillData:GetFairySkillLevel()
      if skillLevel > (skillId2LevelDic[skillID] or 0) then
        skillId2LevelDic[skillID] = skillLevel
      else
        warn("drop fairy same skill with low level")
      end
    end
  end
  for skillID, skillLevel in pairs(skillId2LevelDic) do
    local skillData = DynBattleSkill.New(skillID, skillLevel, eBattleSkillLogicType.Fiary)
    table.insert(self.skillList, skillData)
  end
end

function DynFairyData:AddFairySkill2ChipHolder(chipHolder)
  for _, skillData in pairs(self.skillList) do
    chipHolder:AddItemSkill(skillData)
  end
end

function DynFairyData:RemoveFairySkillFromeChipHolder(chipHolder)
  for _, skillData in pairs(self.skillList) do
    chipHolder:RemoveItemSkill(skillData)
  end
end

function DynFairyData:GetDynFairyAttrAdd()
end

function DynFairyData:GetFairySkillIdList()
  local skillIds = {}
  for k, v in pairs(self.slillSlotDic) do
    table.insert(skillIds, v.fairySkillId)
  end
  return skillIds
end

function DynFairyData:GetFairySkillRareList()
  local skillRares = {}
  for k, v in pairs(self.slillSlotDic) do
    table.insert(skillRares, v.fairySkillRare)
  end
  return skillRares
end

return DynFairyData
