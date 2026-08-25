local CardDisplay = System.NewClass("CardDisplay", CardBaseAnimState)

function CardDisplay:Enter()
  self:ResetCard()
  self:SetAlpha(0)
  self:SetFinish()
end

function CardDisplay:Exit()
  CardBaseAnimState.Exit(self)
end

return CardDisplay
