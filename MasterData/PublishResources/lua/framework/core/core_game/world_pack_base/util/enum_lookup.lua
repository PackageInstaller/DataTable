_class("EnumLookup", Object)
EnumLookup = EnumLookup

function EnumLookup:Constructor(rawStrArray)
  self.EL_RawStrArray = rawStrArray
  self.EL_Total = #self.EL_RawStrArray
  self:Internal_Refresh()
end

function EnumLookup:MergeLookup(other_lookup)
  local rawArray = self.EL_RawStrArray
  local add_rawArray = other_lookup.EL_RawStrArray
  local total = #rawArray
  for _, v in ipairs(add_rawArray) do
    if self[v] == nil then
      total = total + 1
      rawArray[total] = v
    end
  end
  self.EL_Total = total
  self:Internal_Refresh()
end

function EnumLookup:Internal_Refresh()
  local rawArray = self.EL_RawStrArray
  for k, v in ipairs(rawArray) do
    self[v] = k
  end
end

_class("ComponentsLookup", EnumLookup)
ComponentsLookup = ComponentsLookup

function ComponentsLookup:Internal_Refresh()
  ComponentsLookup.super.Internal_Refresh(self)
  self.TotalComponents = self.EL_Total
end
