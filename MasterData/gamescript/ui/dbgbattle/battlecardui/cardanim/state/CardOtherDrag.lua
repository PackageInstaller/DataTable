local Vector3 = CS.UnityEngine.Vector3
local Vector2 = CS.UnityEngine.Vector2
local Ease = CS.DG.Tweening.Ease
local CardOtherDrag = System.NewClass("CardOtherDrag", CardBaseAnimState)

function CardOtherDrag:Enter()
  self:ResetTwSequence()
  local cardUI = self:GetCardUI()
  local cardRT = self.cardItem.rootRectTransform
  cardRT.localEulerAngles = Vector3.zero
  cardRT.anchoredPosition = Vector2(0, 110)
  self.curSibling = cardRT:GetSiblingIndex()
  cardRT:SetAsLastSibling()
  if not self.cardItem:IsMyCamp() then
    AudioManager.Instance:PostSoundEvent("Play_UI_Poker_PVP_Dragout_En")
  end
end

function CardOtherDrag:Exit()
  CardBaseAnimState.Exit(self)
  if self.curSibling and self.cardItem and not IsNil(self.cardItem.rootRectTransform) then
    self.cardItem.rootRectTransform:SetSiblingIndex(self.curSibling)
  end
end

return CardOtherDrag
