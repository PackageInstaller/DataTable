_class("UIMiniGameOrderformItem", UICustomWidget)
UIMiniGameOrderformItem = UIMiniGameOrderformItem

function UIMiniGameOrderformItem:Constructor()
  self._cfg_minigame = Cfg.cfg_summer_minigame[1]
  self._current_mood = 1
  self._fromColor = Color(1, 1, 1, 1)
  self._toColor = Color(0.6, 0.1, 0.1, 1)
end

function UIMiniGameOrderformItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIMiniGameOrderformItem:_GetComponents()
  self._di = self:GetUIComponent("Image", "Di")
  self._weight = self:GetUIComponent("Image", "Weight")
  self._ingredient = self:GetUIComponent("Image", "Ingredient")
  self._jam = self:GetUIComponent("Image", "Jam")
  self._emotion = self:GetUIComponent("Image", "Emotion")
  self._value = self:GetUIComponent("Image", "Value")
  self._atlas = self:GetAsset("UISummer.spriteatlas", LoadType.SpriteAtlas)
  self._animation = self:GetUIComponent("Animation", "Animation")
  self._readyAnimation = self:GetUIComponent("Animation", "ReadyAnimation")
  self._light = {}
  self._light[Weight.Small] = self:GetGameObject("LightSmall")
  self._light[Weight.Big] = self:GetGameObject("LightBig")
end

function UIMiniGameOrderformItem:SetData(orderform)
  self._orderform = orderform
  self._current_mood = GuestMood.LookForward
  self._di.sprite = self._atlas:GetSprite(GuestOrderformImg.DiImg[orderform._weight])
  self._weight.sprite = self._atlas:GetSprite(GuestOrderformImg.WeightImg[orderform._weight])
  self._ingredient.sprite = self._atlas:GetSprite(GuestOrderformImg.IngredientImg[orderform._weight][orderform._ingredient])
  self._jam.sprite = self._atlas:GetSprite(GuestOrderformImg.JamImg[orderform._weight][orderform._jam])
  self._emotion.sprite = self._atlas:GetSprite(GuestOrderformImg.MoodImg[self._current_mood])
  self._value.fillAmount = 1
  self._value.color = self._fromColor
  self._light[Weight.Small]:SetActive(false)
  self._light[Weight.Big]:SetActive(false)
  self:PlayAnimation("in")
end

function UIMiniGameOrderformItem:_Update(ms)
  local p = self._orderform._elapseWaitingTime / self._orderform._waitingTime
  self._value.fillAmount = 1 - p
  local mood = self:_GetGuestMood(p * 100)
  if self._current_mood ~= mood then
    self._current_mood = mood
    self._emotion.sprite = self._atlas:GetSprite(GuestOrderformImg.MoodImg[self._current_mood])
  end
  if self._value.fillAmount < 1 then
    self._value.color = Color.Lerp(self._fromColor, self._toColor, p)
  else
    self._value.color = self._toColor
  end
end

function UIMiniGameOrderformItem:_GetGuestMood(time)
  local mood = self._cfg_minigame.WaitingMood[2]
  if time <= mood[1] then
    return self._cfg_minigame.WaitingMood[1][3]
  elseif time > mood[2] then
    return self._cfg_minigame.WaitingMood[3][3]
  else
    return mood[3]
  end
end

function UIMiniGameOrderformItem:SetActive(active)
  self.view.gameObject:SetActive(active)
end

function UIMiniGameOrderformItem:PlayAnimation(animation)
  self._animation:Play(MGAnimations.Orderform[animation])
end

function UIMiniGameOrderformItem:PlayReadyAnimation(play)
  if play then
    self._readyAnimation:Play(MGAnimations.Orderform.ready)
  else
    self._readyAnimation:Stop()
  end
  self._light[self._orderform._weight]:SetActive(play)
end

function UIMiniGameOrderformItem:SetPosition(position, offset)
  self.view.transform.position = position
  self.view.transform.localPosition = self.view.transform.localPosition + offset
end

function UIMiniGameOrderformItem:GetCurrentMood()
  return self._current_mood
end
