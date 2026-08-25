local CardDisplayBack = System.NewClass("CardDisplayBack", CardBaseAnimState)

function CardDisplayBack:Enter()
  self:ResetTwSequence()
  local pos, rotate = self:GetCardPosAndAngle()
  if not pos then
    self:SetFinish()
    return
  end
  self.cardItem:SetIsNeedHighDescMode(true)
  local delta = 20
  pos.y = pos.y + delta
  self:SetPos(pos)
  local dura = 0.3
  self:ToMoveY(pos.y - delta, dura)
  self:SetRotate(rotate)
  self:ToAlpha(1, dura)
  self:SetScale(0.8)
  self:FinishAfterTween()
end

function CardDisplayBack:Exit()
  CardBaseAnimState.Exit(self)
  self:ResetTwSequence(true)
end

return CardDisplayBack
