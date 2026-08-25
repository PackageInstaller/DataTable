local UIAnimationController = CS.Z1Client.UIAnimationController
local DbgEventEmbryoBornBloodLine, Super = System.NewClass("DbgEventEmbryoBornBloodLine", DbgEventEmbryoBloodLineBase)

function DbgEventEmbryoBornBloodLine:StartBloodLineEffect(callback)
  Super.StartBloodLineEffect(self, callback)
  local cardItem = self:GetCardItem()
  if not cardItem then
    return
  end
  if not self.cardUid then
    return
  end
  self.reversePlayed = false
  cardItem.canvasGroup.alpha = 0
  self:PlayLineMotionEffect()
end

function DbgEventEmbryoBornBloodLine:UpdateLineEffect()
  Super.UpdateLineEffect(self)
  if not self.isCardEffPlayed and self.distanceScale <= 0.1 then
    self:PlayCardAppearEffect()
  end
end

function DbgEventEmbryoBornBloodLine:PlayCardAppearEffect()
  self.isCardEffPlayed = true
  self:UpdateEffectTransform()
  local cardItem = self:GetCardItem()
  if not cardItem then
    self:OnBloodLineMotionFinish()
  else
    local animCtroller = cardItem.ui.uiNode:GetComponent(typeof(UIAnimationController))
    animCtroller:PlayState("UI_XueRou_Card_Fadein", function()
      self:OnBloodLineMotionFinish()
    end)
  end
end

function DbgEventEmbryoBornBloodLine:OnCSAnimEvent(eventName)
  if "OnShowCardEffGo" == eventName then
    self.cardEffGo:SetActive(true)
  end
end

function DbgEventEmbryoBornBloodLine:StopCardFadeTimer()
  if self.cardFadeTimer then
    TimerManager.Instance:StopTimer(self.cardFadeTimer)
    self.cardFadeTimer = nil
  end
end

function DbgEventEmbryoBornBloodLine:Clear()
  self:StopCardFadeTimer()
  Super.Clear(self)
end

function DbgEventEmbryoBornBloodLine:OnBloodLineMotionFinish()
  self:StopCardFadeTimer()
  self:ResetCardItem()
  Super.OnBloodLineMotionFinish(self)
end

return DbgEventEmbryoBornBloodLine
