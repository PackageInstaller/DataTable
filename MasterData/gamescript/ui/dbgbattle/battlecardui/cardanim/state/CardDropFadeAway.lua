local Ease = CS.DG.Tweening.Ease
local Move_Target_Pos_Y = 160
local Move_Duration = 0.5
local Move_Easing_Type = Ease.OutCubic
local Alpha_Target_Val = 0
local Alpha_Duration = 0.5
local Alpha_Delay = 0.5
local CardDropFadeAway = System.NewClass("CardDropFadeAway", CardBaseAnimState)

function CardDropFadeAway:Enter()
  self:ResetTwSequence()
  self.cardItem:SetIsNeedHighDescMode(false)
  self.cardItem:SetClickable(false)
  self:SetEdgeAlpha(0)
  self:ToMoveY(Move_Target_Pos_Y, Move_Duration, 0, Move_Easing_Type)
  self:ToAlpha(Alpha_Target_Val, Alpha_Duration, Alpha_Delay)
  self:FreeCardAfterTween()
end

function CardDropFadeAway:Exit()
  CardBaseAnimState.Exit(self)
  self:ResetTwSequence()
  if self.cardPanel then
    self.cardPanel:DelayRelayoutHandCard()
  end
end

return CardDropFadeAway
