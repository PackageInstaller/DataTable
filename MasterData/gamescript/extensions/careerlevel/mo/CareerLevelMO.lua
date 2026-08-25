local CareerLevelMO = NewClass("CareerLevelMO")

function CareerLevelMO:ctor()
  self.level = 0
  self.exp = 0
  self.claimedLevel = 0
  self.totalExp = 0
end

function CareerLevelMO:UpdateData(data)
  self:SetLevel(data.level)
  self:SetExp(data.exp)
  self:SetClaimedLevel(data.claimedLevel)
  self:SetTotalExp(data.totalExp)
end

function CareerLevelMO:SetLevel(nulVal)
  if nil == nulVal then
    return
  end
  self.level = nulVal
end

function CareerLevelMO:SetExp(nulVal)
  if nil == nulVal then
    return
  end
  self.exp = nulVal
end

function CareerLevelMO:SetClaimedLevel(nulVal)
  if nil == nulVal then
    return
  end
  self.claimedLevel = nulVal
end

function CareerLevelMO:SetTotalExp(nulVal)
  if nil == nulVal then
    return
  end
  self.totalExp = nulVal
end

function CareerLevelMO:GetLevel()
  return self.level
end

function CareerLevelMO:GetExp()
  return self.exp
end

function CareerLevelMO:GetClaimedLevel()
  return self.claimedLevel
end

function CareerLevelMO:GetTotalExp()
  return self.totalExp
end

function CareerLevelMO:IsGoted(targetLevel)
  return targetLevel <= self.claimedLevel
end

function CareerLevelMO:IsCanReceive(targetLevel)
  if not targetLevel then
    return self.claimedLevel < self.level
  end
  return targetLevel > self.claimedLevel and targetLevel <= self.level
end

return CareerLevelMO
