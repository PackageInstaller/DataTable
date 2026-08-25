local CardDisappear = System.NewClass("CardDisappear", CardBaseAnimState)

function CardDisappear:Enter(isBurn, onComplete)
  if isBurn then
    self:SetFinish()
    self:BurnCard(nil, onComplete)
    return
  end
  if self:IsPVPEnemySide() then
    self:SetFinish()
    self:FreeCardItem(true)
    return
  end
  if self.cardItem:ShouldPlayConsumeCardEffect() then
    self:BurnCard(nil, onComplete)
    return
  else
    self:ResetTwSequence()
    self:ToAlpha(0, 0.3)
    self.cardItem:SetClickable(false)
    self.cardItem:SetVxChooseShow(true)
    self.cardItem:SetShowLight(false)
    self:FreeCardAfterTween()
  end
end

function CardDisappear:DoEnter(...)
  LinearFsmState.DoEnter(self, ...)
end

function CardDisappear:Exit()
  CardBaseAnimState.Exit(self)
  if self.cardItem.ui then
    self.cardItem:SetVxChooseShow(false)
    self.cardItem:SetShowLight(true)
  end
end

return CardDisappear
