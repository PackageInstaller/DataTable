local CardEmbryoSwallow = System.NewClass("CardEmbryoSwallow", CardBaseAnimState)

function CardEmbryoSwallow:Enter()
  local cardUI = self:GetCardUI()
  if cardUI then
    local effect = cardUI:GetEmbryoSwallowEffect()
    effect:StartEffect({
      self.cardItem.card.value.uid
    })
    self:SetFinishDelay(1)
  end
end

return CardEmbryoSwallow
