_class("AuraRangeComponent", Object)
AuraRangeComponent = AuraRangeComponent

function AuraRangeComponent:Constructor()
  self._auraGroupRangeDic = {}
end

function AuraRangeComponent:AddRange(groupID, range)
  if self._auraGroupRangeDic[groupID] == nil then
    self._auraGroupRangeDic[groupID] = {}
  end
  local auraRange = self._auraGroupRangeDic[groupID]
  for _, pos in ipairs(range) do
    local count = auraRange[pos:Pos2Index()]
    if not count then
      count = 1
    else
      count = count + 1
    end
    auraRange[pos:Pos2Index()] = count
  end
end

function AuraRangeComponent:RemoveRange(groupID, range)
  if self._auraGroupRangeDic[groupID] == nil then
    return
  end
  local auraRange = self._auraGroupRangeDic[groupID]
  for _, pos in ipairs(range) do
    local count = auraRange[pos:Pos2Index()]
    count = count and count - 1
    if count == 0 then
      auraRange[pos:Pos2Index()] = nil
    else
      auraRange[pos:Pos2Index()] = count
    end
  end
end

function AuraRangeComponent:GetAuraSuperposedCount(groupID, gridPos)
  if self._auraGroupRangeDic[groupID] == nil then
    return nil
  end
  local auraRange = self._auraGroupRangeDic[groupID]
  local count = auraRange[gridPos:Pos2Index()]
  if not count then
    return nil
  end
  return count
end

function Entity:AuraRange()
  return self:GetComponent(self.WEComponentsEnum.AuraRange)
end

function Entity:HasAuraRange()
  return self:HasComponent(self.WEComponentsEnum.AuraRange)
end

function Entity:AddAuraRange()
  local index = self.WEComponentsEnum.AuraRange
  local component = AuraRangeComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceAuraRange()
  local index = self.WEComponentsEnum.AuraRange
  local component = AuraRangeComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveAuraRange()
  if self:HasAuraRange() then
    self:RemoveComponent(self.WEComponentsEnum.AuraRange)
  end
end
