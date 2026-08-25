local Ease = CS.DG.Tweening.Ease
local CardPutBack = System.NewClass("CardPutBack", CardBaseAnimState)

function CardPutBack:Enter()
  self:ResetTwSequence()
  self.cardItem:SetIsNeedHighDescMode(true)
  local dura = 0.2
  self:ToScale(0.8, dura)
  self:SetAlpha(1)
  local pos, angle = self:GetCardPosAndAngle()
  if pos then
    self:ToAnchorPos(pos, dura, 0, Ease.OutCubic)
  end
  if angle then
    self:ToRotateZ(angle, dura)
  end
  self:FinishAfterTween()
  if not self.cardItem:IsMyCamp() then
    AudioManager.Instance:PostSoundEvent("Play_UI_Poker_PVP_Withdraw_En")
  end
end

function CardPutBack:Exit()
  CardBaseAnimState.Exit(self)
end

return CardPutBack
