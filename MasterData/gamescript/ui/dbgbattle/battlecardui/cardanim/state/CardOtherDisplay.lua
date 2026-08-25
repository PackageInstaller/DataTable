local CardOtherDisplay = System.NewClass("CardOtherDisplay", CardBaseAnimState)

function CardOtherDisplay:Enter()
  self:ResetTwSequence()
  local pos, rotate = self:GetCardPosAndAngle()
  if not pos then
    self:SetFinish()
    return
  end
  local delta = 20
  local dura = 0.3
  self:ToMoveY(pos.y + delta, dura)
  self:SetRotate(rotate)
  self:ToAlpha(1, dura)
  self:SetScale(0.8)
  if self.cardItem then
    self.cardItem.ui.Effect_Card_BianYuan_Lan_yzw_vx:SetActive(true)
  end
end

function CardOtherDisplay:Exit()
  if self.cardItem and self.cardItem.ui and not IsNil(self.cardItem.ui.Effect_Card_BianYuan_Lan_yzw_vx) then
    self.cardItem.ui.Effect_Card_BianYuan_Lan_yzw_vx:SetActive(false)
  end
  CardBaseAnimState.Exit(self)
end

return CardOtherDisplay
