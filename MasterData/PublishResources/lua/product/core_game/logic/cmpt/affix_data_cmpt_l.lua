_class("AffixDataComponent", Object)
AffixDataComponent = AffixDataComponent

function AffixDataComponent:Constructor()
  self._affixDataList = {}
end

function AffixDataComponent:AddAffixData(affixType, param)
  if not self._affixDataList[affixType] then
    self._affixDataList[affixType] = {}
  end
  table.insert(self._affixDataList[affixType], param)
end

function AffixDataComponent:HasAffixData(affixType)
  return self._affixDataList[affixType] ~= nil
end

function AffixDataComponent:GetAffixDataList(affixType)
  return self._affixDataList[affixType]
end

function AffixDataComponent:Sort()
  for affixType, dataList in pairs(self._affixDataList) do
    if affixType == AffixType.ReplaceMonsterSkill then
      table.sort(dataList, function(param1, param2)
        local typeID1 = param1:GetAffixConfigTypeID()
        local typeID2 = param2:GetAffixConfigTypeID()
        if typeID1 ~= typeID2 then
          return typeID1 < typeID2
        else
          local index1 = param1:GetConfigIndex()
          local index2 = param2:GetConfigIndex()
          return index1 < index2
        end
      end)
    end
  end
end

function Entity:AffixData()
  return self:GetComponent(self.WEComponentsEnum.AffixData)
end

function Entity:HasAffixData()
  return self:HasComponent(self.WEComponentsEnum.AffixData)
end

function Entity:AddAffixData()
  local index = self.WEComponentsEnum.AffixData
  local component = AffixDataComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceAffixData()
  local index = self.WEComponentsEnum.AffixData
  local component = AffixDataComponent:New()
  self:ReplaceComponent(index, component)
end
