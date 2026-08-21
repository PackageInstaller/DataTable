_class("MultModifyBool_AND", MultModifyValue)

function MultModifyBool_AND:Constructor(baseValue)
  self.defaultValueType = "boolean"
  if baseValue == nil then
    self.baseValue = true
    self.value = true
  else
    self:AddModify(baseValue)
  end
end

function MultModifyBool_AND:CalcuCurValue()
  for i, v in ipairs(self.valueModifyList) do
    if not v then
      self.value = false
      return
    end
  end
  self.value = true
end

_class("MultModifyValue_Last", MultModifyValue)
MultModifyValue_Last = MultModifyValue_Last

function MultModifyValue_Last:CalcuCurValue()
  local size = #self.valueModifyList
  if 0 < size then
    self.value = self.valueModifyList[size][2]
  else
    self.value = self.baseValue
  end
end

_class("MultModifyValue_Add", MultModifyValue)
MultModifyValue_Add = MultModifyValue_Add

function MultModifyValue_Add:CalcuCurValue()
  local size = #self.valueModifyList
  if 0 < size then
    local val = 0
    for i = 1, size do
      val = val + self.valueModifyList[i][2]
    end
    self.value = val + self.baseValue
  else
    self.value = self.baseValue
  end
end

_class("MultModifyValue_Mul", MultModifyValue)
MultModifyValue_Mul = MultModifyValue_Mul

function MultModifyValue_Mul:CalcuCurValue()
  local size = #self.valueModifyList
  if 0 < size then
    local val = 1
    for i = 1, size do
      val = val * self.valueModifyList[i][2]
    end
    self.value = val * self.baseValue
  else
    self.value = self.baseValue
  end
end

_class("MultModifyValue_Max", MultModifyValue)
MultModifyValue_Max = MultModifyValue_Max

function MultModifyValue_Max:CalcuCurValue()
  local max = self.baseValue
  local size = #self.valueModifyList
  if 0 < size then
    for i = 1, size do
      local val = self.valueModifyList[i][2]
      if max < val then
        max = val
      end
    end
  end
  self.value = max
end

_class("MultModifyValue_Min", MultModifyValue)
MultModifyValue_Min = MultModifyValue_Min

function MultModifyValue_Min:CalcuCurValue()
  local min = self.baseValue
  local size = #self.valueModifyList
  if 0 < size then
    for i = 1, size do
      local val = self.valueModifyList[i][2]
      if min > val then
        min = val
      end
    end
  end
  self.value = min
end

_class("MultModifyValue_AddMinMax", MultModifyValue)
MultModifyValue_AddMinMax = MultModifyValue_AddMinMax

function MultModifyValue_AddMinMax:CalcuCurValue()
  local min, max = 0, 0
  local size = #self.valueModifyList
  if 0 < size then
    for i = 1, size do
      local val = self.valueModifyList[i][2]
      if min > val then
        min = val
      end
      if max < val then
        max = val
      end
    end
  end
  self.value = self.baseValue + min + max
end

MultModifyOperator = {PLUS = 1, MULTIPLY = 2}
_class("MultModifyValue_Complex", MultModifyValue)
MultModifyValue_Complex = MultModifyValue_Complex

function MultModifyValue_Complex:AddModify(value, modifyID, operation)
  modifyID = modifyID or 1
  self:RemoveModify(modifyID)
  table.insert(self.valueModifyList, {
    modifyID,
    value,
    operation
  })
  self:CalcuCurValue()
  return modifyID
end

function MultModifyValue_Complex:CalcuCurValue()
  local ret = self.baseValue
  for i = 1, #self.valueModifyList do
    local val = self.valueModifyList[i][2]
    local opt = self.valueModifyList[i][3]
    if opt == MultModifyOperator.PLUS then
      ret = ret + val
    elseif opt == MultModifyOperator.MULTIPLY then
      ret = ret * val
    end
  end
  self.value = ret
end
