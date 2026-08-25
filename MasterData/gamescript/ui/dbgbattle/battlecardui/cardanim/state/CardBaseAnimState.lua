local DOTween = CS.DG.Tweening.DOTween
local Vector3 = CS.UnityEngine.Vector3
local Vector2 = CS.UnityEngine.Vector2
local CanvasGroup = CS.UnityEngine.CanvasGroup
local Ease = CS.DG.Tweening.Ease
local CardBaseAnimState, Super = System.NewClass("CardBaseAnimState", LinearFsmState)

function CardBaseAnimState:ctor(cardItem, _, cardMgr)
  self.cardItem = cardItem
  self.binder = cardItem.binder:createChild()
  self.cardPanel = nil
  self.cardMgr = cardMgr
  self.cardTransform = self.cardItem.ui.uiNode.transform
  self.canvasGroup = self.cardTransform:GetComponent(typeof(CanvasGroup))
end

function CardBaseAnimState:TickUpdatePos()
  self._updatePosTimer = self.binder:BindTimer(0.03, -1, function()
    self:ResetCard()
  end)
end

function CardBaseAnimState:ClearTickUpdatePos()
  if self._updatePosTimer then
    self.binder:StopTimer(self._updatePosTimer)
  end
end

function CardBaseAnimState:CheckEnter()
  local canEnter = self:GetUid() and self:GetCardUI() or nil
  return nil ~= canEnter
end

function CardBaseAnimState:DoEnter(...)
  if not self:CheckEnter() then
    Logger.Warn("状态进入失败", self.__name)
    return
  end
  if not self.cardItem:GetHandIndex() then
    Logger.Warn("状态进入失败, 手牌Index为空", self.__name)
    return
  end
  LinearFsmState.DoEnter(self, ...)
end

function CardBaseAnimState:Enter()
  self:ResetTwSequence()
end

function CardBaseAnimState:ResetCard()
  local uid = self:GetUid()
  local pos, angle = self:GetCardPosAndAngle(uid)
  if pos and angle then
    self.cardItem:SetPos(pos)
    self.cardItem:SetSectorAngle(angle)
  end
  self:SetScale(0.8)
  self:SetAlpha(1)
end

function CardBaseAnimState:Exit()
  self:ClearTwSequence()
  self:_ClearFinishDelayTimer()
  self:ClearTickUpdatePos()
  self.isEntered = false
  self.isFinish = true
  ResLoadMgr.UnloadAssetByTarget(self)
end

function CardBaseAnimState:SetPos(pos)
  self.cardItem:SetPos(pos)
end

function CardBaseAnimState:SetRotate(angle)
  self.cardItem:SetSectorAngle(angle)
end

function CardBaseAnimState:SetAlpha(alpha)
  if IsNil(self.canvasGroup) then
    return
  end
  if bg.isPVP and not self.cardItem:IsMyCamp() then
    alpha = 1
  end
  self.canvasGroup.alpha = alpha
end

function CardBaseAnimState:SetScale(scale)
  if not IsNil(self.cardTransform) then
    self.cardTransform.localScale = Vector3(scale, scale, 1)
  end
end

function CardBaseAnimState:ToScale(scale, duration, delay, ease)
  if IsNil(self.cardTransform) then
    return
  end
  local tw = self.cardTransform:DOScale(Vector3(scale, scale, 1), duration):SetDelay(delay or 0):SetEase(ease or Ease.Linear)
  self.twSequence:Join(tw)
end

function CardBaseAnimState:ToAnchorPos(pos, duration, delay, ease)
  if IsNil(self.cardTransform) then
    return
  end
  local tw = self.cardTransform:DOAnchorPos(Vector2(pos.x, pos.y), duration):SetDelay(delay or 0):SetEase(ease or Ease.Linear)
  self.twSequence:Join(tw)
end

function CardBaseAnimState:ToMoveY(toY, duration, delay, ease)
  if IsNil(self.cardTransform) then
    return
  end
  local tw = self.cardTransform:DOAnchorPosY(toY, duration):SetDelay(delay or 0):SetEase(ease or Ease.Linear)
  self.twSequence:Join(tw)
end

function CardBaseAnimState:ToMoveX(toX, duration, delay, ease)
  if IsNil(self.cardTransform) then
    return
  end
  local tw = self.cardTransform:DOAnchorPosX(toX, duration):SetDelay(delay or 0):SetEase(ease or Ease.Linear)
  self.twSequence:Join(tw)
end

function CardBaseAnimState:ToRotateZ(to, duration, delay, ease)
  if IsNil(self.cardTransform) then
    return
  end
  local tw = self.cardTransform:DOLocalRotate(Vector3(0, 0, -to), duration):SetDelay(delay or 0):SetEase(ease or Ease.Linear)
  self.twSequence:Join(tw)
end

function CardBaseAnimState:ToRotateZAndUpdatePos(to, duration, delay, ease, isUpdate)
  if IsNil(self.cardTransform) then
    return
  end
  local tw
  tw = self.cardTransform:DOLocalRotate(Vector3(0, 0, -to), duration):SetDelay(delay or 0):SetEase(ease or Ease.Linear):OnUpdate(function()
    self:UpdateCardPos()
  end)
  self.twSequence:Join(tw)
end

function CardBaseAnimState:ToRotate(to, duration, delay, ease)
  if IsNil(self.cardTransform) then
    return
  end
  local tw = self.cardTransform:DOLocalRotate(to, duration):SetDelay(delay or 0):SetEase(ease or Ease.Linear)
  self.twSequence:Join(tw)
end

function CardBaseAnimState:ToAlpha(to, duration, delay, ease)
  if bg.isPVP and not self.cardItem:IsMyCamp() then
    to = 1
  end
  local tw = self.canvasGroup:DOFade(to, duration):SetDelay(delay or 0):SetEase(ease or Ease.Linear)
  self.twSequence:Join(tw)
end

function CardBaseAnimState:BurnCard(delay, onComplete)
  if delay then
    self.cardItem.binder:BindTimer(delay, 0, nil, function()
      self:_BurnCard(onComplete)
    end)
    return
  end
  self:_BurnCard(onComplete)
end

function CardBaseAnimState:_BurnCard(onComplete)
  if self.cardItem.cardUI and self.cardItem.card.value then
    self.cardItem.cardUI:RemoveCards({
      self.cardItem.card.value
    })
  end
  self.cardItem:FreeCardFaceSfx()
  self.cardItem:SetClickable(false)
  self.cardItem:SetVxChooseShow(false)
  self.cardItem:SetShowLight(false)
  self:SetEdgeAlpha(0)
  AudioManager.Instance:PostSoundEvent("Play_UI_Poker_Dis")
  self.cardItem:PlayState("UI_Vx_Battle_Common_CardBurn", function()
    self:SetFinish()
    self.cardItem:SetVisible(false)
    self.cardItem.binder:teardown()
    if onComplete then
      onComplete()
    end
  end)
  if System.is(self.cardItem, BattleCardBackItem) then
    self:BurnCardEnemyCamp()
  else
    self:BurnCardMyCamp()
  end
end

function CardBaseAnimState:BurnCardMyCamp()
  local ui = self.cardItem.ui
  local cardBaseUI = self.cardItem.cardBaseUI
  local binder = self.cardItem.binder
  local prefab = binder:LoadAsset(CommonRes.CardBurnVxPrefab)
  local vxGameObj = binder:Instantiate(prefab, ui.uiNode.transform)
  vxGameObj.name = vxGameObj.name:replace("(Clone)", "", true)
  local animator = ui.uiNode:GetComponent(typeof(CS.UnityEngine.Animator))
  animator:Rebind()
  local Image_Icon = cardBaseUI.Image_Icon:GetComponent(typeof(CS.UnityEngine.UI.Image))
  Image_Icon.material = CS.UnityEngine.Object.Instantiate(ResLoadMgr.LoadAsset(CommonRes.CardBurnMat, self))
  Image_Icon:GetComponent(typeof(CS.UI_Distort_Dissolve)).RenderingMaterial = Image_Icon.material
  local Image_Card_Mask = cardBaseUI.Image_Card_Mask:GetComponent(typeof(CS.UnityEngine.UI.Image))
  Image_Card_Mask.material = CS.UnityEngine.Object.Instantiate(ResLoadMgr.LoadAsset(CommonRes.CardBurnMat, self))
  Image_Card_Mask:GetComponent(typeof(CS.UI_Distort_Dissolve)).RenderingMaterial = Image_Card_Mask.material
  local Image_NameBg = cardBaseUI.Image_NameBg:GetComponent(typeof(CS.UnityEngine.UI.Image))
  Image_NameBg.material = CS.UnityEngine.Object.Instantiate(ResLoadMgr.LoadAsset(CommonRes.CardBurnMat, self))
  Image_NameBg:GetComponent(typeof(CS.UI_Distort_Dissolve)).RenderingMaterial = Image_NameBg.material
  local cardGlow02 = CS.Framework.GameObjectUtil.DeepFindChild(vxGameObj.transform, "Card_Glow02")
  local Card_Glow02 = cardGlow02:GetComponent(typeof(CS.UnityEngine.UI.Image))
  Card_Glow02.material = CS.UnityEngine.Object.Instantiate(ResLoadMgr.LoadAsset(CommonRes.CardBorderBurnMat, self))
  Card_Glow02:GetComponent(typeof(CS.UI_Distort_Dissolve)).RenderingMaterial = Card_Glow02.material
end

function CardBaseAnimState:BurnCardEnemyCamp()
  local ui = self.cardItem.ui
  local binder = self.cardItem.binder
  local prefab = binder:LoadAsset(CommonRes.CardBurnVxPrefab)
  local vxGameObj = binder:Instantiate(prefab, ui.uiNode.transform)
  vxGameObj.name = vxGameObj.name:replace("(Clone)", "", true)
  local animator = ui.uiNode:GetComponent(typeof(CS.UnityEngine.Animator))
  animator:Rebind()
  local Image_Icon = ui.Image_Card_Back:GetComponent(typeof(CS.UnityEngine.UI.Image))
  Image_Icon.material = CS.UnityEngine.Object.Instantiate(ResLoadMgr.LoadAsset(CommonRes.CardBurnMat, self))
  Image_Icon:GetComponent(typeof(CS.UI_Distort_Dissolve)).RenderingMaterial = Image_Icon.material
  local cardGlow02 = CS.Framework.GameObjectUtil.DeepFindChild(vxGameObj.transform, "Card_Glow02")
  local Card_Glow02 = cardGlow02:GetComponent(typeof(CS.UnityEngine.UI.Image))
  Card_Glow02.material = CS.UnityEngine.Object.Instantiate(ResLoadMgr.LoadAsset(CommonRes.CardBorderBurnMat, self))
  Card_Glow02:GetComponent(typeof(CS.UI_Distort_Dissolve)).RenderingMaterial = Card_Glow02.material
end

function CardBaseAnimState:SetEdgeAlpha(alphaVal)
  if self.cardItem.binder and self.cardItem.ui.Root_Effect_BianYuan then
    self.cardItem.binder:SetCanvasGroup(self.cardItem.ui.Root_Effect_BianYuan, alphaVal)
  end
end

function CardBaseAnimState:GetUid()
  do return self.cardItem.GetUid end
  return self.cardItem.GetUid, self.cardItem
end

function CardBaseAnimState:GetCardUI()
  return self.cardItem.cardUI
end

function CardBaseAnimState:GetCardPosAndAngle()
  local cardUI = self:GetCardUI()
  local uid = self:GetUid()
  assert(cardUI and uid, "cardUI or uid is nil")
  if cardUI and uid then
    do return cardUI.GetCardPosAndAngle, cardUI end
    return cardUI.GetCardPosAndAngle, cardUI, uid
  end
end

function CardBaseAnimState:UpdateCardPos()
  local sectorAngle = self.cardItem:GetSectorAngle()
  local cardUI = self:GetCardUI()
  if cardUI then
    local pos = cardUI:GetCardPosByAngle(sectorAngle)
    self.cardItem:SetPos(pos)
  end
end

function CardBaseAnimState:GetHandCardCount()
  do return self:GetCardUI().GetHandCardCount end
  return self:GetCardUI().GetHandCardCount, (self:GetCardUI())
end

function CardBaseAnimState:GetHandIndex()
  do return self.cardItem.GetHandIndex end
  return self.cardItem.GetHandIndex, self.cardItem
end

function CardBaseAnimState:ResetTwSequence(isComplete)
  self:ClearTwSequence(isComplete)
  self.twSequence = DOTween.Sequence(self)
  return self.twSequence
end

function CardBaseAnimState:ClearTwSequence(isComplete)
  if self.twSequence then
    self.twSequence:Kill(isComplete and true or false)
    self.twSequence = nil
  end
end

function CardBaseAnimState:SetTweenComplete(func)
  self.twSequence:OnComplete(function()
    if not (self.cardPanel and self.cardPanel.ui) or IsNil(self.cardPanel.ui.uiNode) then
      return
    end
    func()
  end)
end

function CardBaseAnimState:FinishAfterTween()
  self.twSequence:OnComplete(System.fn(self, self.SetFinish))
end

function CardBaseAnimState:FreeCardAfterTween()
  self.twSequence:OnComplete(System.fn(self, self.FreeCardItem))
end

function CardBaseAnimState:FreeCardItem(isForce)
  local cardUI = self:GetCardUI()
  if cardUI then
    cardUI:FreeCardItem(self.cardItem, isForce)
  end
  self:SetFinish()
end

function CardBaseAnimState:SetFinishDelay(delay)
  self:_ClearFinishDelayTimer()
  self.delayFinishTimer = TimerManager.Instance:CreateTimer(delay, 0, nil, function()
    self.delayFinishTimer = nil
    self:SetFinish()
  end)
end

function CardBaseAnimState:_ClearFinishDelayTimer()
  if self.delayFinishTimer then
    TimerManager.Instance:StopTimer(self.delayFinishTimer)
    self.delayFinishTimer = nil
  end
end

function CardBaseAnimState:Reset()
  Super.Reset(self)
  if self.delayFinishTimer then
    TimerManager.Instance:StopTimer(self.delayFinishTimer)
    self.delayFinishTimer = nil
  end
end

function CardBaseAnimState:IsPVPEnemySide()
  if bg.isPVP and not self.cardItem:IsMyCamp() then
    return true
  end
end

function CardBaseAnimState:SetFinish()
  self.isEntered = false
  self.isFinish = true
  self:Exit()
end

function CardBaseAnimState:CheckNextImmediately()
  return false
end

return CardBaseAnimState
