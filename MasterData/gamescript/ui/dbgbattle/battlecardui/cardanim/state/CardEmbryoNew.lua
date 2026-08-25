local CardEmbryoNew, Super = System.NewClass("CardEmbryoNew", CardBaseAnimState)

function CardEmbryoNew:CheckEnter()
  return true
end

function CardEmbryoNew:Enter()
  Super.Enter(self)
  self:ResetCard()
  self:TickUpdatePos()
  local cardUI = self:GetCardUI()
  if cardUI then
    local effect = cardUI:GetEmbryoBornEffect()
    effect:StartEffect({
      self.cardItem.card.value.uid
    })
    self:SetFinishDelay(1)
  end
end

return CardEmbryoNew
