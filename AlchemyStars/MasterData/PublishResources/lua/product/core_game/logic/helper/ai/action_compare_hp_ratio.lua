_class("ActionCompareHPRatio", AINewNode)
ActionCompareHPRatio = ActionCompareHPRatio

function ActionCompareHPRatio:Constructor()
end

function ActionCompareHPRatio:OnUpdate()
  if self.m_entityOwn:HasCrazyMode() then
    return AINewNodeStatus.Failure
  end
  local compareMode = self:GetLogicData(-1)
  local percent = self:GetLogicData(-2)
  local cAttributes = self.m_entityOwn:Attributes()
  local hp = cAttributes:GetCurrentHP()
  local maxHp = cAttributes:CalcMaxHp()
  local ratio = hp / maxHp
  local res = false
  if compareMode == "eq" then
    res = ratio == percent
  elseif compareMode == "ne" then
    res = ratio ~= percent
  elseif compareMode == "gt" then
    res = percent < ratio
  elseif compareMode == "ge" then
    res = percent <= ratio
  elseif compareMode == "lt" then
    res = percent > ratio
  elseif compareMode == "le" then
    res = percent >= ratio
  end
  if res then
    return AINewNodeStatus.Success
  else
    return AINewNodeStatus.Failure
  end
end
