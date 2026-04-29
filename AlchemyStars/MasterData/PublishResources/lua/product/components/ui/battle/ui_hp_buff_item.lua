_class("UIHPBuffItem", UICustomWidget)
UIHPBuffItem = UIHPBuffItem

function UIHPBuffItem:Constructor()
end

function UIHPBuffItem:OnShow(uiParams)
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self._transform = self:GetGameObject():GetComponent("Transform")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "canvasGroup")
  self._image = self:GetUIComponent("RawImageLoader", "image")
  self._num = self:GetUIComponent("UILocalizationText", "num")
  self._countDownRoot = self:GetGameObject("countDownRoot")
  if self._countDownRoot then
    self._countDownNum = self:GetUIComponent("UILocalizationText", "countDownNum")
    self._countDownRoot:SetActive(false)
  end
  if self._canvasGroup then
    self._canvasGroup.alpha = 0
  end
  self._inMoeTween = false
  self._rectTransform.anchorMin = Vector2(0.5, 0.5)
  self._rectTransform.anchorMax = Vector2(0.5, 0.5)
  self._rectTransform.sizeDelta = Vector2(39, 39)
end

function UIHPBuffItem:OnHide()
  if self._canvasGroup then
    self._canvasGroup.alpha = 0
  end
  self._buffViewInstance = nil
end

function UIHPBuffItem:Dispose()
end

function UIHPBuffItem:SetTargetData(buffViewInstance)
  self._buffViewInstance = buffViewInstance
end

function UIHPBuffItem:SetData(buffViewInstance)
  self._buffViewInstance = buffViewInstance
  self:RefreshData()
end

function UIHPBuffItem:RefreshData()
  if self._buffViewInstance == nil then
    return
  end
  if not self._image then
    return
  end
  self._num.text = self._buffViewInstance:GetLayerText()
  local countDown = self._buffViewInstance:GetCountDown()
  if countDown and self._countDownRoot then
    self._countDownRoot:SetActive(0 < countDown)
    self._countDownNum.text = countDown
  end
  if self._canvasGroup and self._canvasGroup.alpha == 0 then
    self._canvasGroup.alpha = 1
  end
  self._transform:DOKill()
  local buffIcon = self._buffViewInstance:GetBuffIcon()
  if not self._iconName then
    self._iconName = buffIcon
  elseif self._iconName == buffIcon then
    return
  else
    self._iconName = buffIcon
  end
  if buffIcon == nil then
    Log.exception("buffIcon is nil or empty! buffID:", self._buffViewInstance:BuffID())
  end
  self._image:LoadImage(buffIcon)
end

function UIHPBuffItem:IsInMoveTween()
  return self._inMoeTween
end

function UIHPBuffItem:DoMoveTween(buffViewInstance, startPos, endPos, duration)
  self:SetData(buffViewInstance)
  self._inMoeTween = true
  self._transform.localPosition = startPos
  self._tweener = self._transform:DOLocalMove(endPos, duration):OnComplete(function()
    self._inMoeTween = false
    if self._canvasGroup then
      self._canvasGroup.alpha = 0
    end
  end)
end

function UIHPBuffItem:DoFadeTween(targetFade, duration)
  if self._buffViewInstance == nil then
    return
  end
  self._canvasGroup:DOFade(targetFade, duration):OnComplete(function()
  end)
end
