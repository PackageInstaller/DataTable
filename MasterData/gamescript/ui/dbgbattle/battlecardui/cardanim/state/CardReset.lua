local CardReset = System.NewClass("CardReset", CardBaseAnimState)

function CardReset:Enter()
  CardBaseAnimState.Enter(self)
  self:ResetCard()
  self:SetFinish()
end

return CardReset
