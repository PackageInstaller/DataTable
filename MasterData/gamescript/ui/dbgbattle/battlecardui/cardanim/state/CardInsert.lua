local Ease = CS.DG.Tweening.Ease
local CardInsert = System.NewClass("CardInsert", CardBaseAnimState)

function CardInsert:Enter()
  self:ResetTwSequence()
  local pos, rotate = self:GetCardPosAndAngle()
  if not pos then
    self:SetFinish()
    return
  end
  local delta = 330
  pos.y = pos.y + delta
  self:SetPos(pos)
  local dura = 0.75
  self:ToMoveY(pos.y - delta, dura, 0, Ease.OutCubic)
  self:SetRotate(rotate)
  self:SetAlpha(0)
  self:ToAlpha(1, dura, 0, Ease.OutCubic)
  self:SetScale(0.8)
  self.cardItem:SetIsNeedHighDescMode(true)
  self:FinishAfterTween()
end

function CardInsert:Exit()
  CardBaseAnimState.Exit(self)
  self:ResetTwSequence()
  if self.cardPanel then
    self.cardPanel:DelayRelayoutHandCard()
  end
end

return CardInsert
