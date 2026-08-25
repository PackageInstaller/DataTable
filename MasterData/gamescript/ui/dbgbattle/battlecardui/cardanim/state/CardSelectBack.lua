local CardSelectBack = System.NewClass("CardSelectBack", CardBaseAnimState)

function CardSelectBack:Enter()
  self:ResetTwSequence()
  local pos, rotate = self:GetCardPosAndAngle()
  if not pos then
    self:SetFinish()
    return
  end
  local dura = 0.5
  self:ToAnchorPos(pos, dura)
  self:ToRotateZ(rotate, dura)
  self:SetAlpha(1)
  self:ToScale(0.8, dura)
  self:FinishAfterTween()
  self.cardItem:SetIsNeedHighDescMode(false)
end

function CardSelectBack:Exit()
  CardBaseAnimState.Exit(self)
  self.cardItem:SetIsNeedHighDescMode(true)
  self:ResetTwSequence(true)
end

return CardSelectBack
