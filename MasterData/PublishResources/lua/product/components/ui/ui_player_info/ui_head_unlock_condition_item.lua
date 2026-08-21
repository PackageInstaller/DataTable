_class("UIHeadUnLockConditionItem", UICustomWidget)
UIHeadUnLockConditionItem = UIHeadUnLockConditionItem

function UIHeadUnLockConditionItem:OnShow(uiParams)
  self._atlas = self:GetAsset("UIPlayerInfo.spriteatlas", LoadType.SpriteAtlas)
  self._moveSizeUpper = 0
  self._tweenGapsTime = 0
  self._tweenWaitTime = 500
  self._tweenMoveSpeed = 20
end

function UIHeadUnLockConditionItem:SetData(info)
  self._conditionDesc = info.m_stDesc
  self._lock = not info.m_bPass
  self:_GetComponents()
  self:_OnValue()
end

function UIHeadUnLockConditionItem:OnHide()
  if self._moveEvent then
    GameGlobal.Timer():CancelEvent(self._moveEvent)
    self._moveEvent = nil
  end
  if self._tweenEvent then
    GameGlobal.Timer():CancelEvent(self._tweenEvent)
    self._tweenEvent = nil
  end
  if self._tweener then
    self._tweener:Kill()
    self._tweener = nil
  end
end

function UIHeadUnLockConditionItem:_GetComponents()
  self._conditionTex = self:GetUIComponent("UILocalizationText", "conditionDesc")
  self._conditionTexRect = self:GetUIComponent("RectTransform", "conditionDesc")
  self._contentSizeFilter = self:GetUIComponent("ContentSizeFitter", "conditionDesc")
  local texmask = self:GetUIComponent("RectTransform", "texMask")
  self._moveSizeUpper = texmask.sizeDelta.x
  self._lockImg = self:GetUIComponent("Image", "pass")
  self._bg = self:GetUIComponent("Image", "bg")
end

function UIHeadUnLockConditionItem:MoveTexTween()
  self._conditionTexRect.anchoredPosition = Vector2(0, self._conditionTexRect.anchoredPosition.y)
  self._tweenEvent = GameGlobal.Timer():AddEvent(self._tweenWaitTime, function()
    self:MoveTex()
  end)
end

function UIHeadUnLockConditionItem:MoveTex()
  if self._tweener then
    self._tweener:Kill()
  end
  self._tweener = self._conditionTexRect:DOAnchorPosX(self._movePosX, self._tweenMoveTime):SetEase(DG.Tweening.Ease.Linear)
end

function UIHeadUnLockConditionItem:_OnValue()
  self._conditionTex:SetText(StringTable.Get(self._conditionDesc))
  self._contentSizeFilter:SetLayoutHorizontal()
  self._texSize = self._conditionTexRect.sizeDelta.x
  self._movePosX = self._moveSizeUpper - self._texSize
  self._tweenMoveTime = math.abs(self._movePosX) / self._tweenMoveSpeed
  self._tweenGapsTime = self._tweenWaitTime * 2 + self._tweenMoveTime * 1000
  if self._moveEvent then
    GameGlobal.Timer():CancelEvent(self._moveEvent)
    self._moveEvent = nil
  end
  if self._tweenEvent then
    GameGlobal.Timer():CancelEvent(self._tweenEvent)
    self._tweenEvent = nil
  end
  if self._tweener then
    self._tweener:Kill()
  end
  if self._texSize > self._moveSizeUpper then
    self:MoveTexTween()
    self._moveEvent = GameGlobal.Timer():AddEventTimes(self._tweenGapsTime, TimerTriggerCount.Infinite, function()
      self:MoveTexTween()
    end)
  else
    self._conditionTexRect.anchoredPosition = Vector2(0, self._conditionTexRect.anchoredPosition.y)
  end
  if self._lock then
    self._conditionTex.color = Color(1, 1, 1)
    self._lockImg.sprite = self._atlas:GetSprite("info_qiming_icon8")
    self._bg.sprite = self._atlas:GetSprite("info_qiming_di15")
  else
    self._conditionTex.color = Color(0.6392156862745098, 0.6392156862745098, 0.6392156862745098)
    self._lockImg.sprite = self._atlas:GetSprite("info_qiming_icon9")
    self._bg.sprite = self._atlas:GetSprite("info_qiming_di16")
  end
end
