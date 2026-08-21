_class("UISeasonStoryChooseItem", UICustomWidget)
UISeasonStoryChooseItem = UISeasonStoryChooseItem

function UISeasonStoryChooseItem:OnShow(uiParams)
  self._text = self:GetUIComponent("UILocalizationText", "text")
  self._layoutRt = self:GetUIComponent("RectTransform", "layout")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._typeGo = self:GetGameObject("typeGo")
  self._go = self:GetGameObject()
  self._new = self:GetGameObject("New")
  self:InitButtonClickAnim("Bg", "select")
end

function UISeasonStoryChooseItem:Active(active)
  self._go:SetActive(active)
end

function UISeasonStoryChooseItem:SetData(idx, txt, callback, type)
  self._idx = idx
  self._callback = callback
  self._text:SetText(txt)
  local showType = false
  if type then
    showType = true
  end
  self._typeGo:SetActive(showType)
  if self._text.preferredWidth > 322 then
    self._layoutRt.sizeDelta = Vector2(322, 100)
    self._text.resizeTextForBestFit = true
    self._text.verticalOverflow = UnityEngine.VerticalWrapMode.Truncate
  else
    self._text.resizeTextForBestFit = false
    self._text.verticalOverflow = UnityEngine.VerticalWrapMode.Overflow
  end
end

function UISeasonStoryChooseItem:SetNewStatus(status)
  self._new:SetActive(status)
end

function UISeasonStoryChooseItem:BgOnClick(go)
  self:StartTask(function(TT)
    self:Lock("uianim_UISeasonStoryChooseItem_xuanzhong")
    self._anim:Play("uianim_UISeasonStoryChooseItem_xuanzhong")
    YIELD(TT, 400)
    if self._callback then
      self._callback(self._idx)
    end
    self:UnLock("uianim_UISeasonStoryChooseItem_xuanzhong")
  end)
end

function UISeasonStoryChooseItem:InitButtonClickAnim(btnName, clickedGoName)
  local btnGo = self:GetGameObject(btnName)
  local clickedGo = self:GetGameObject(clickedGoName)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(btnGo), UIEvent.Press, function(go)
    clickedGo:SetActive(true)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(btnGo), UIEvent.Release, function(go)
    clickedGo:SetActive(false)
  end)
end
