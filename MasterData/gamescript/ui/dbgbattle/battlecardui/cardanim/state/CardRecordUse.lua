local Ease = CS.DG.Tweening.Ease
local CardRecordUse = System.NewClass("CardRecordUse", CardBaseAnimState)

function CardRecordUse:DoEnter(...)
  if not self:CheckEnter() then
    Logger.Warn("状态进入失败", self.__name)
    return
  end
  LinearFsmState.DoEnter(self, ...)
end

function CardRecordUse:Enter(callback)
  self:ResetTwSequence()
  self.callback = callback
  if IsNil(self.cardItem.rootRectTransform) then
    self:SetFinish()
    return
  end
  local pos = self.cardItem.rootRectTransform.anchoredPosition
  local dura = 0.2
  self:ToMoveY(pos.y + 300, dura, 0, Ease.OutCubic)
  self:ToAlpha(0, dura, 0.2)
  self:FreeCardAfterTween()
  self.cardItem:SetIsNeedHighDescMode(false)
end

function CardRecordUse:Exit()
  CardBaseAnimState.Exit(self)
  if self.callback then
    self.callback()
  end
end

return CardRecordUse
