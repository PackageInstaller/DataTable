local CardRelayout = System.NewClass("CardRelayout", CardBaseAnimState)

function CardRelayout:Enter()
  if IsNil(self.cardItem.rootRectTransform) then
    return
  end
  self:ResetTwSequence()
  local _, angle = self:GetCardPosAndAngle()
  if not angle then
    self:SetFinish()
    return
  end
  local dura = 0.4
  self.cardItem.rootRectTransform:SetSiblingIndex(self:GetHandIndex() - 1)
  self:ToRotateZAndUpdatePos(angle, dura, nil, nil, true)
  self:ToAlpha(1, dura)
  self:ToScale(0.8, dura)
  self:FinishAfterTween()
end

function CardRelayout:Exit()
  CardBaseAnimState.Exit(self)
  self:ResetTwSequence()
end

return CardRelayout
