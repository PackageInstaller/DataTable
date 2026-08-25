local CSTime = CS.UnityEngine.Time
local UIAnimationController = CS.Z1Client.UIAnimationController
local DbgEventSwallowEmbryoBloodLine, Super = System.NewClass("DbgEventSwallowEmbryoBloodLine", DbgEventEmbryoBloodLineBase)

function DbgEventSwallowEmbryoBloodLine:StartBloodLineEffect(callback)
  Super.StartBloodLineEffect(self, callback)
  local cardItem = self:GetCardItem()
  if not cardItem then
    return
  end
  self.triggeredOnLineMotionPlay = nil
  self.triggeredOnCardItemDisappear = nil
  self.reversePlayed = true
  cardItem.ui.uiNode:SetActive(true)
  cardItem.canvasGroup.alpha = 1
  cardItem.ui.Root_Effect_BianYuan:SetActive(false)
  self:PlayCardDisappearEffect()
end

function DbgEventSwallowEmbryoBloodLine:UpdateLineEffect()
  Super.UpdateLineEffect(self)
  if self.distanceScale >= 0.0 and self.swallowEffectStartFunc then
    self.swallowEffectStartFunc()
    self.swallowEffectStartFunc = nil
  elseif self.distanceScale >= 0.9 then
    self:OnBloodLineMotionFinish()
  end
end

function DbgEventSwallowEmbryoBloodLine:PlayCardDisappearEffect()
  self.isCardEffPlayed = true
  self:UpdateEffectTransform()
  local cardItem = self:GetCardItem()
  if not cardItem then
    self:OnBloodLineMotionFinish()
  else
    local animCtroller = cardItem.ui.uiNode:GetComponent(typeof(UIAnimationController))
    local animClip = self.cardEffAnimController:GetClip("UI_XueRou_Card_FadeOut").clip
    animCtroller:RemoveAnimationEvent(animClip)
    CS.AMTimeline.AMTimelineUtils.AddAnimationEvent(animClip, 0 / animClip.frameRate, "OnCardItemDisappear", "SendLuaEvent")
    CS.AMTimeline.AMTimelineUtils.AddAnimationEvent(animClip, 0 / animClip.frameRate, "OnLineMotionPlay", "SendLuaEvent")
    animCtroller:RegisterAniamtionEventHander(self.OnCSAnimEvent, self)
    animCtroller:PlayState("UI_XueRou_Card_FadeOut")
  end
end

function DbgEventSwallowEmbryoBloodLine:OnCSAnimEvent(eventName)
  if "OnCardItemDisappear" == eventName then
    if self.triggeredOnCardItemDisappear then
      return
    end
    self.triggeredOnCardItemDisappear = true
    self:DisappearCardItemNode()
    if self.cardItemDisappearFunc then
      self.cardItemDisappearFunc()
    end
  elseif "OnLineMotionPlay" == eventName then
    if self.triggeredOnLineMotionPlay then
      return
    end
    self.triggeredOnLineMotionPlay = true
    self:PlayLineMotionEffect()
  end
end

function DbgEventSwallowEmbryoBloodLine:DisappearCardItemNode()
  self:StopCardFadeTimer()
  local disappearTimeCount = 0.5
  self.cardDisappearTime = 0
  self.cardFadeTimer = TimerManager.Instance:CreateTimer(0, -1, function()
    if not self.cardFadeTimer then
      return
    end
    local gameSpeed = BattleEmbryoMgrClient.GetPlaybackSpeed()
    self.cardDisappearTime = self.cardDisappearTime or 0
    self.cardDisappearTime = self.cardDisappearTime + CSTime.deltaTime * gameSpeed
    local cardItem = self:GetCardItem()
    if not cardItem then
      return
    end
    cardItem.canvasGroup.alpha = math.max(0, 1.0 - self.cardDisappearTime / disappearTimeCount)
  end, function()
    local cardItem = self:GetCardItem()
    if not cardItem then
      return
    end
    cardItem.canvasGroup.alpha = 0
  end)
end

function DbgEventSwallowEmbryoBloodLine:StopCardFadeTimer()
  if self.cardFadeTimer then
    TimerManager.Instance:StopTimer(self.cardFadeTimer)
    self.cardFadeTimer = nil
  end
end

function DbgEventSwallowEmbryoBloodLine:Clear()
  self:StopCardFadeTimer()
  self.swallowEffectStartFunc = nil
  self.cardItemDisappearFunc = nil
  self.triggeredOnLineMotionPlay = nil
  self.triggeredOnCardItemDisappear = nil
  Super.Clear(self)
end

function DbgEventSwallowEmbryoBloodLine:OnBloodLineMotionFinish()
  local cardItem = self:GetCardItem()
  if cardItem and not IsNil(cardItem.canvasGroup) then
    cardItem.canvasGroup.alpha = 0
  end
  self.swallowEffectStartFunc = nil
  self.cardItemDisappearFunc = nil
  self.triggeredOnLineMotionPlay = nil
  self.triggeredOnCardItemDisappear = nil
  Super.OnBloodLineMotionFinish(self)
end

function DbgEventSwallowEmbryoBloodLine:SetSwallowEffectStartFunc(callback)
  self.swallowEffectStartFunc = callback
end

function DbgEventSwallowEmbryoBloodLine:SetCardItemDisappearFunc(callback)
  self.cardItemDisappearFunc = callback
end

return DbgEventSwallowEmbryoBloodLine
