local Ease = CS.DG.Tweening.Ease
local Vector2 = CS.UnityEngine.Vector2
local Move_Target_Pos_Y = 450
local Move_And_Scale = 1.1
local Move_Scale_Duration = 1
local Move_Scale_Easing_Type = Ease.OutCubic
local Alpha_Target_Val = 0
local Alpha_Duration = 0.5
local Alpha_Delay = 0.5
local CardDropBurnPVP = System.NewClass("CardDropBurnPVP", CardBaseAnimState)

function CardDropBurnPVP:Enter()
  self:ResetTwSequence()
  self.cardItem:SetIsNeedHighDescMode(false)
  self.cardItem:SetClickable(false)
  self:SetEdgeAlpha(0)
  local targetX = self:GetTargePosX()
  if targetX then
    self:ToAnchorPos(Vector2(targetX, Move_Target_Pos_Y), Move_Scale_Duration, 0, Move_Scale_Easing_Type)
  else
    self:ToMoveY(Move_Target_Pos_Y, Move_Scale_Duration, 0, Move_Scale_Easing_Type)
  end
  self:ToScale(Move_And_Scale, Move_Scale_Duration, 0, Move_Scale_Easing_Type)
  self:ToAlpha(Alpha_Target_Val, Alpha_Duration, Move_Scale_Duration + Alpha_Delay)
  if System.is(self.cardItem, BattleCardBackItem) then
    local isReverse = true
    self.cardItem:ShowCardDetailItem(isReverse)
  end
  self:FreeCardAfterTween()
  self:ReverseSiblingIndex()
end

function CardDropBurnPVP:ReverseSiblingIndex()
  if not System.is(self.cardItem, BattleCardBackItem) then
    return
  end
  local cardTf = self.cardItem.rootRectTransform
  local parent = cardTf.parent
  local childCount = parent.childCount
  cardTf:SetSiblingIndex(childCount - self:GetHandIndex())
end

function CardDropBurnPVP:GetTargePosX()
  if not self.cardItem.ui or not self.cardItem.ui.uiNode then
    return
  end
  local tf = self.cardItem.ui.uiNode.transform
  local rota = tf.localEulerAngles
  local curPos = tf.anchoredPosition
  local rotaZ = rota.z
  local deltaX = (Move_Target_Pos_Y - math.abs(curPos.y)) * math.tan(rotaZ * math.pi / 180 * 1.5)
  local targetX = curPos.x - deltaX
  return targetX
end

function CardDropBurnPVP:Exit()
  CardBaseAnimState.Exit(self)
  self:ResetTwSequence()
  if self.cardPanel then
    self.cardPanel:DelayRelayoutHandCard()
  end
  if System.is(self.cardItem, BattleCardBackItem) then
    self.cardItem:HideCardDetailItem()
  end
end

return CardDropBurnPVP
