local DynChipHolder = class("DynChipHolder")

function DynChipHolder:ctor()
  self.__ownedChips = {}
  self.__chipEffector = {}
  self.__itemSkillDic = {}
end

function DynChipHolder:GetOwnedChips()
  return self.__ownedChips
end

function DynChipHolder:GetOwnedChipsById(chipId)
  for chipData, v in pairs(self.__ownedChips) do
    if chipData.dataId == chipId then
      return chipData
    end
  end
end

function DynChipHolder:ContainChip(chipData)
  local contain = self.__ownedChips[chipData] ~= nil
  return contain
end

function DynChipHolder:AddChip(chipData)
  self.__ownedChips[chipData] = true
end

function DynChipHolder:RemoveChip(chipData)
  self.__ownedChips[chipData] = nil
end

function DynChipHolder:ContainChipEffector(chipBattle)
  local contain = self.__chipEffector[chipBattle] ~= nil
  return contain
end

function DynChipHolder:AddChipEffector(chipBattle)
  self.__chipEffector[chipBattle] = true
end

function DynChipHolder:RemoveChipEffector(chipBattle)
  self.__chipEffector[chipBattle] = nil
end

function DynChipHolder:GetItemSkillList()
  local skillList = {}
  local skillDic = {}
  for k, v in pairs(self.__itemSkillDic) do
    local oldSkill = skillDic[k.dataId]
    if oldSkill == nil or k.level > oldSkill.level then
      if oldSkill then
        table.removebyvalue(skillList, oldSkill)
      end
      table.insert(skillList, k)
      skillDic[k.dataId] = k
    end
  end
  return skillList
end

function DynChipHolder:GetItemSkillDic()
  return self.__itemSkillDic
end

function DynChipHolder:AddItemSkill(dynSkill)
  self.__itemSkillDic[dynSkill] = true
end

function DynChipHolder:RemoveItemSkill(dynSkill)
  if self.__itemSkillDic[dynSkill] ~= nil then
    self.__itemSkillDic[dynSkill] = nil
  end
end

function DynChipHolder:RemoveItemSkillTypeDic(typeDic)
  for itemSkill, _ in pairs(self.__itemSkillDic) do
    if typeDic[itemSkill.type] then
      self.__itemSkillDic[itemSkill] = nil
    end
  end
end

function DynChipHolder:GetItemSkillListByType(type)
  local skillList = {}
  for itemSkill, _ in pairs(self.__itemSkillDic) do
    if itemSkill.type == type then
      table.insert(skillList, itemSkill)
    end
  end
  return skillList
end

function DynChipHolder:OffsetAttrFromChip(property, value)
end

return DynChipHolder
