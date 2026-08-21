_class("IModifyValue", Object)
IModifyValue = IModifyValue

function IModifyValue:Constructor(baseValue)
  self.baseValue = baseValue
end

function IModifyValue:BaseValue()
  return self.baseValue
end

function IModifyValue:Value()
  return self.baseValue
end

function IModifyValue:AddModify(value, modifyID)
  self.baseValue = value
end

function IModifyValue:RemoveModify(modifyID)
  error("IModifyValue:RemoveModify(modifyID) need override")
end

function IModifyValue:ClearModify()
  error("IModifyValue:ClearModify() need override")
end

_class("MultModifyValue", IModifyValue)
MultModifyValue = MultModifyValue

function MultModifyValue:Constructor(baseValue)
  self.valueModifyList = {}
  self.baseValue = baseValue
  self.value = baseValue
end

function MultModifyValue:Value()
  return self.value
end

function MultModifyValue:AddModify(value, modifyID)
  modifyID = modifyID or 1
  self:RemoveModify(modifyID)
  table.insert(self.valueModifyList, {modifyID, value})
  self:CalcuCurValue()
  return modifyID
end

function MultModifyValue:RemoveModify(modifyID)
  for i, v in ipairs(self.valueModifyList) do
    local curID = v[1]
    if curID == modifyID then
      table.remove(self.valueModifyList, i)
      break
    end
  end
  self:CalcuCurValue()
end

function MultModifyValue:GetModifyValue(modifyID)
  for i, v in ipairs(self.valueModifyList) do
    local curID = v[1]
    if curID == modifyID then
      return v[2]
    end
  end
end

function MultModifyValue:ClearModify()
  self.valueModifyList = {}
  self:CalcuCurValue()
end

function MultModifyValue:CalcuCurValue()
  error("MultModifyValue:CalcuCurValue() need override")
end
