local CardUse = System.NewClass("CardUse", CardBaseAnimState)

function CardUse:Enter()
  if self:IsPVPEnemySide() then
    self:SetFinish()
    self:FreeCardItem(true)
    return
  end
  self.cardItem:SetShowLight(false)
  self.cardItem:SetVxChooseShow(false)
  if self.cardItem:IsBlessingCard() then
    return
  end
  if self.cardItem:ShouldPlayConsumeCardEffect() then
    return
  else
    self:ResetTwSequence()
    self:ToAlpha(0, 0.3)
    self:FinishAfterTween()
  end
end

function CardUse:Exit()
  CardBaseAnimState.Exit(self)
  if self.cardItem.ui then
    self.cardItem:SetVxChooseShow(false)
    self.cardItem:SetShowLight(true)
  end
end

return CardUse
