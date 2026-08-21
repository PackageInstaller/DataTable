_class("UISeasonTransitions", UIController)
UISeasonTransitions = UISeasonTransitions

function UISeasonTransitions:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonTransitions:OnShow(uiParams)
  self._callBack = uiParams[1]
  self:_GetComponents()
  self:_OnValue()
end

function UISeasonTransitions:_GetComponents()
  self._image = self:GetUIComponent("Image", "Image")
end

function UISeasonTransitions:_OnValue()
  self:_PlayAnimation(true)
end

function UISeasonTransitions:_PlayAnimation(show)
  local targetColor
  if show then
    self._image.color = Color(0, 0, 0, 0)
    targetColor = Color(0, 0, 0, 1)
  else
    self._image.color = Color(0, 0, 0, 1)
    targetColor = Color(0, 0, 0, 0)
  end
  self._image:DOColor(targetColor, 0.8):OnComplete(function()
    if self._callBack then
      self._callBack()
    end
  end)
end

function UISeasonTransitions:Close(callBack)
  self._callBack = callBack
  self:_PlayAnimation(false)
end
