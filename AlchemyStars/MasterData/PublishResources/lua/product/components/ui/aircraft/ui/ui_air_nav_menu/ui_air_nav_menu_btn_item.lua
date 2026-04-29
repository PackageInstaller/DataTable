_class("UIAirNavMenuBtnItem", UICustomWidget)
UIAirNavMenuBtnItem = UIAirNavMenuBtnItem

function UIAirNavMenuBtnItem:OnShow(uiParams)
end

function UIAirNavMenuBtnItem:OnHide()
  self._idx = nil
  self._state = nil
  self._count = nil
  self._icon = nil
  self._pos = nil
  self._cb = nil
end

function UIAirNavMenuBtnItem:SetData(idx, state, currState, count, icon, name, pos, cb)
  self:GetComponents()
  self._idx = idx
  self._state = state
  self._count = count
  self._icon = icon
  self._name = name
  self._pos = pos
  self._cb = cb
  self:OnValue()
  self:RefreshBtnState(currState)
end

function UIAirNavMenuBtnItem:OnValue()
  self._rect.anchoredPosition = self._pos
  self._iconImg.sprite = self._icon
  self._countTex:SetText(self._count)
  self._nameTex:SetText(StringTable.Get(self._name))
end

function UIAirNavMenuBtnItem:GetComponents()
  self._iconImg = self:GetUIComponent("Image", "icon")
  self._countTex = self:GetUIComponent("UILocalizationText", "count")
  self._showBtn = self:GetGameObject("showBtn")
  self._rect = self:GetUIComponent("RectTransform", "rect")
  self._rectAnim = self:GetUIComponent("Animation", "UIAirNavMenuBtnItem")
  self._nameTex = self:GetUIComponent("UILocalizationText", "name")
  self._anim = self:GetUIComponent("RectTransform", "anim")
end

function UIAirNavMenuBtnItem:RefreshBtnState(state)
  self._showBtn:SetActive(state == self._state)
end

function UIAirNavMenuBtnItem:PlayAnim_In(yieldTime)
  self._anim.anchoredPosition = Vector2(350, 0)
  GameGlobal.Timer():AddEvent(yieldTime, function()
    self._rectAnim:Play()
  end)
end

function UIAirNavMenuBtnItem:btnOnClick()
  if self._cb then
    self._cb(self._state)
  end
end
