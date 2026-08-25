local Ease = CS.DG.Tweening.Ease
local CardForceUse = System.NewClass("CardForceUse", CardBaseAnimState)

function CardForceUse:Enter(callback)
  print("[CardForceUse] Enter", "uid:", self:GetUid(), "time:", TimerManager.totalTime)
  self:ResetTwSequence()
  self.callback = callback
  local pos = self.cardItem.rootRectTransform.anchoredPosition
  local dura = 0.2
  self:ToMoveY(pos.y + 300, dura, 0, Ease.OutCubic)
  self:ToAlpha(0, dura + 0.2, 0.2)
  self:FreeCardAfterTween()
  self.cardItem:SetIsNeedHighDescMode(false)
end

function CardForceUse:Exit()
  print("[CardForceUse] Exit", "uid:", self:GetUid(), "time:", TimerManager.totalTime)
  CardBaseAnimState.Exit(self)
  if self.callback then
    self.callback()
  end
end

return CardForceUse
