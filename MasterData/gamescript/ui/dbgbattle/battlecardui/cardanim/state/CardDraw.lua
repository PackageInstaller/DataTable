local Ease = CS.DG.Tweening.Ease
local Vector3_Zero = CS.UnityEngine.Vector3
local Vector2 = CS.UnityEngine.Vector2
local CardDraw = System.NewClass("CardDraw", CardBaseAnimState)
local isUseNew = false

function CardDraw:Enter(drawIndex)
  if isUseNew then
    self:NewAnim(drawIndex)
  else
    self:OldAnim()
  end
end

function CardDraw:UpdateState()
  if not isUseNew then
    return
  end
  local destPos = self:GetCardPosAndAngle()
  if not destPos or not self.moveTw then
    return
  end
  self.moveTw:ChangeEndValue(Vector2(destPos.x, destPos.y))
end

function CardDraw:OldAnim()
  CardBaseAnimState.Enter(self)
  self:ResetCard()
  local dura = self:GetTwDuration()
  local firstAlphaTime = 0.05
  if bg.battleDataCenter.isRecover then
    dura, firstAlphaTime = 0, 0
  end
  self:SetScale(0.8)
  local fromRotate = self:GetFromRotate()
  self:SetRotate(fromRotate)
  local _, ToRotateZ = self:GetCardPosAndAngle()
  self:ToRotateZAndUpdatePos(ToRotateZ, dura, 0, Ease.OutCubic, true)
  self:ToAlpha(0.01 * self:GetHandIndex(), firstAlphaTime, 0)
  self:ToAlpha(1, 0.3, firstAlphaTime, Ease.InSine)
  self:FinishAfterTween()
end

function CardDraw:NewAnim(drawIndex)
  CardBaseAnimState.Enter(self)
  bg.battleRender:PerformWithDelay(1, function()
    package.loaded["UI.DbgBattle.BattleCardUI.CardAnim.State.CardDrawConfig"] = nil
  end, self)
  self:ResetCard()
  local fromRotate = self:GetFromRotate()
  self:SetRotate(fromRotate)
  local destPos, destRotateZ = self:GetCardPosAndAngle()
  local cardUI = self:GetCardUI()
  if not cardUI then
    self:SetFinish()
    return
  end
  local battlePanelDelegate = cardUI.uiDelegate
  if not battlePanelDelegate then
    self:SetFinish()
    return
  end
  if self.moveTw then
    self.moveTw:ChangeEndValue(Vector2(destPos.x, destPos.y))
    return
  end
  local drawDeckBtn = battlePanelDelegate:GetDrawDeckBtn()
  local drawBtnGlobalPos = drawDeckBtn.transform:TransformPoint(Vector3_Zero)
  local cardTf = self.cardItem.ui.uiNode.transform
  cardTf:SetAsFirstSibling()
  local cardStartPos = cardTf.parent:InverseTransformPoint(drawBtnGlobalPos)
  cardTf.localPosition = cardStartPos
  self:SetScale(CardDrawConfig.cardInitScale)
  self:SetAlpha(0)
  self:SetRotate(0)
  local dura = CardDrawConfig.flyTime
  local delay = drawIndex * CardDrawConfig.drawInterval
  local flyEase = CardDrawConfig.flyEase
  self:ToAlpha(1, 0, delay)
  self.moveTw = cardTf:DOAnchorPos(Vector2(destPos.x, destPos.y), dura):SetDelay(delay):SetEase(flyEase)
  self:ToScale(0.8, dura, 0, CardDrawConfig.scaleEase)
  self:ToRotateZ(destRotateZ, dura, 0, CardDrawConfig.rotateEase)
  self:FinishAfterTween()
end

function CardDraw:Exit()
  CardBaseAnimState.Exit(self)
  self.moveTw = nil
end

function CardDraw:GetTwDuration()
  local miniDura = 0.3
  local maxDura = 0.6
  local delta = math.max(0, math.min(0.05, (maxDura - miniDura) / (self:GetHandCardCount() - 1)))
  local dura = miniDura + (self:GetHandIndex() - 1) * delta
  return dura
end

function CardDraw:GetFromRotate()
  local range = CommonDefine.SectorAngle * 0.95
  local delta = range / self:GetHandCardCount()
  local fromRotate = -CommonDefine.SectorAngle + (self:GetHandIndex() - 1) * delta
  return fromRotate
end

return CardDraw
