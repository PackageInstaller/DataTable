local CardDrop = System.NewClass("CardDrop", CardBaseAnimState)

function CardDrop:Enter(index)
  self:ResetTwSequence()
  local dura = self:GetTwDuration(index)
  self:ToAlpha(0.5, dura * 0.8)
  self:ToAlpha(0, dura * 0.2, dura * 0.8)
  self:ToRotateZAndUpdatePos(self:GetToRotateZ(index), dura, 0)
  self:FreeCardAfterTween()
end

function CardDrop:Exit()
  CardBaseAnimState.Exit(self)
end

function CardDrop:GetTwDuration(index)
  return 0.3 + index * 0.05
end

function CardDrop:GetToRotateZ(index)
  local curAngle = self.cardItem:GetSectorAngle()
  local ToRotateZ = curAngle + index * 0.5
  return ToRotateZ
end

return CardDrop
