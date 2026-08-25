local Ease = CS.DG.Tweening.Ease
local CardDrag = System.NewClass("CardDrag", CardBaseAnimState)

function CardDrag:Enter()
  self:ResetTwSequence()
  self:ToRotateZ(0, 0.3, 0, Ease.OutCubic)
  self:SetScale(1)
  self:SetAlpha(1)
  self.curSibling = self.cardItem.rootRectTransform:GetSiblingIndex()
  local cardUI = self:GetCardUI()
  self.cardItem.rootRectTransform:SetParent(cardUI.uiDelegate:GetTransform(), true)
  self.cardItem:SetShowLight(false)
  self.cardItem:SetIsNeedHighDescMode(false)
end

function CardDrag:UpdateState(position, isUseTween)
  local cardTransform = self.cardItem.rootRectTransform
  self:SetAlpha(1)
  local followTime = 0.15
  if position.y <= -320 then
    followTime = 0.05
  end
  if isUseTween then
    if self.followTween and self.followTween.active then
      self.followTween:ChangeEndValue(position, followTime, true)
    else
      if self.followTween then
        self.followTween:Kill()
      end
      self.followTween = cardTransform:DOAnchorPos(position, followTime)
    end
  else
    if self.followTween then
      self.followTween:Kill()
    end
    self.followTween = nil
    cardTransform.anchoredPosition = position
  end
end

function CardDrag:KillFollowTween(isComplete)
  if self.followTween then
    self.followTween:Kill(isComplete and true or false)
    self.followTween = nil
  end
end

function CardDrag:Exit()
  CardBaseAnimState.Exit(self)
  self:KillFollowTween(true)
  self.cardItem:SetVxChooseShow(false)
  self.cardItem:SetShowLight(true)
  if self.curSibling then
    local cardUI = self:GetCardUI()
    self.cardItem.rootRectTransform:SetParent(cardUI.deckRectTransform)
    self.cardItem.rootRectTransform:SetSiblingIndex(self.curSibling)
  end
end

return CardDrag
