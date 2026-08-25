local Ease = CS.DG.Tweening.Ease
local Move_Target_Pos_Y = 160
local Move_Duration = 1
local Move_Easing_Type = Ease.OutCubic
local CardDropBurn = System.NewClass("CardDropBurn", CardBaseAnimState)

function CardDropBurn:Enter()
  self:ResetTwSequence()
  self.cardItem:SetIsNeedHighDescMode(false)
  self.cardItem:SetClickable(false)
  self:SetEdgeAlpha(0)
  self:ToMoveY(Move_Target_Pos_Y, Move_Duration, 0, Move_Easing_Type)
  self:BurnCard(Move_Duration)
end

function CardDropBurn:Exit()
  CardBaseAnimState.Exit(self)
  self:ResetTwSequence()
  if self.cardPanel then
    self.cardPanel:DelayRelayoutHandCard()
  end
end

return CardDropBurn
