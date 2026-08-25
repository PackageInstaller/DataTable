local Ease = CS.DG.Tweening.Ease
local CardUseBack = System.NewClass("CardUseBack", CardBaseAnimState)

function CardUseBack:Enter()
  self.cardItem:SetIsNeedHighDescMode(true)
  self:ResetTwSequence()
  local pos, rotate = self:GetCardPosAndAngle()
  if not pos then
    self:SetFinish()
    return
  end
  local delta = 150
  pos.y = pos.y + delta
  self:SetPos(pos)
  local dura = 0.75
  self:ToMoveY(pos.y - delta, dura, 0, Ease.OutCubic)
  self:SetRotate(rotate)
  self:SetAlpha(0)
  self:ToAlpha(1, dura, 0, Ease.OutCubic)
  self:SetScale(0.8)
  self:FinishAfterTween()
end

function CardUseBack:Exit()
  CardBaseAnimState.Exit(self)
  self:ResetTwSequence()
  if self.cardPanel then
    self.cardPanel:DelayRelayoutHandCard()
  end
end

return CardUseBack
