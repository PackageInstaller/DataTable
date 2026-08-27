local ReinforceCardDataBase = class("ReinforceCardDataBase")

function ReinforceCardDataBase:ctor()
  self._cardType = nil
  self._buffList = nil
  self._chipList = nil
end

function ReinforceCardDataBase:SetRfCdType(cardType)
  self._cardType = cardType
end

function ReinforceCardDataBase:GetRfCdType()
  return self._cardType
end

function ReinforceCardDataBase:GetRfCardBgPath()
end

function ReinforceCardDataBase:SetRfCdBuffList(buffList)
  self._buffList = buffList
end

function ReinforceCardDataBase:GetRfCdBuffList()
  return self._buffList
end

function ReinforceCardDataBase:SetRfCdStartChipList(chipList)
  self._chipList = chipList
end

function ReinforceCardDataBase:GetRfCdStartChipList()
  return self._chipList
end

function ReinforceCardDataBase:GetRfCdInfiniteCoe()
end

function ReinforceCardDataBase:GetRfCdRoomGroup()
end

function ReinforceCardDataBase:GetRfCardLibChipList()
end

return ReinforceCardDataBase
