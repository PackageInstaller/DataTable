_class("UIEducationCondition", Object)
UIEducationCondition = UIEducationCondition

function UIEducationCondition:Constructor()
  self._type = ConditionType.CT_NONE
  self._completed = 0
  self._quantity = 0
end

function UIEducationCondition:Type()
  return self._type
end

function UIEducationCondition:GetCompleted()
  return self._completed
end

function UIEducationCondition:GetQuantity()
  return self._quantity
end

function UIEducationCondition:IsMet()
  return self._completed >= self._quantity
end

function UIEducationCondition:Test()
end

function UIEducationCondition:Unmarshal(openCondition)
  local lst = {}
  local dic = {}
  local oneLevel = string.split(openCondition, "&")
  for k, v in pairs(oneLevel) do
    local twoLevel = string.split(v, ",")
    for sk, sv in pairs(twoLevel) do
      twoLevel[sk] = tonumber(sv)
    end
    local paramCount = #twoLevel
    if twoLevel[1] == ConditionType.CT_TowerType and 3 <= paramCount then
      local testCondition = UIEducationConditionTower:New(twoLevel[2], twoLevel[3])
      table.insert(lst, testCondition)
      dic[testCondition:Type()] = testCondition
    elseif twoLevel[1] == ConditionType.CT_PetGradeY and 3 <= paramCount then
      local testCondition = UIEducationConditionGrade:New(twoLevel[2], twoLevel[3])
      table.insert(lst, testCondition)
      dic[testCondition:Type()] = testCondition
    elseif twoLevel[1] == ConditionType.CT_PetYElementZLevel and 4 <= paramCount then
      local testCondition = UIEducationConditionElementLevel:New(twoLevel[2], twoLevel[3], twoLevel[4])
      table.insert(lst, testCondition)
      dic[testCondition:Type()] = testCondition
    else
      Log.exception("UIEducationCondition:Unmarshal openCondition 条件未实现 id --> ", v)
    end
  end
  return lst, dic
end
