local CardConsume = System.NewClass("CardConsume", CardBaseAnimState)

function CardConsume:Enter()
  if self.cardItem:IsBlessingCard() then
    return
  end
  self:ResetTwSequence()
  self:ToAlpha(0, 0.3)
  self:FreeCardAfterTween()
end

function CardConsume:Exit()
  CardBaseAnimState.Exit(self)
end

return CardConsume
