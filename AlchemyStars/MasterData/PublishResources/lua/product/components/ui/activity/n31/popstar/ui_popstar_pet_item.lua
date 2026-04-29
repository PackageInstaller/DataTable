_class("UIPopStarPetItem", UICustomWidget)
UIPopStarPetItem = UIPopStarPetItem

function UIPopStarPetItem:OnShow()
  self._go = self:GetGameObject()
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._elementLoader = self:GetUIComponent("RawImageLoader", "Element")
  self._empty = self:GetGameObject("Empty")
  self._emptyCanvas = self:GetUIComponent("CanvasGroup", "Empty")
  self._icon = self:GetGameObject("Icon")
  self._element = self:GetGameObject("Element")
  self._anim = self:GetUIComponent("Animation", "Anim")
end

function UIPopStarPetItem:SetData(id, scale, callback, animationName)
  self._id = id
  self._callback = callback
  self._go.transform.localScale = Vector3(scale, scale, scale)
  if self._id > 0 then
    if not animationName then
      self._empty:SetActive(false)
    end
    self._icon:SetActive(true)
    self._element:SetActive(true)
    local cfg = Cfg.cfg_popstar_pet_list[self._id]
    self._iconLoader:LoadImage(cfg.Icon)
    self._elementLoader:LoadImage(cfg.Element)
    if animationName then
      self._anim:Play(animationName)
    end
  else
    self._emptyCanvas.alpha = 1
    self._empty:SetActive(true)
    self._icon:SetActive(false)
    self._element:SetActive(false)
  end
end

function UIPopStarPetItem:SetEmptyActive(status)
  self._empty:SetActive(status)
end

function UIPopStarPetItem:SetActive(status)
  self._go:SetActive(status)
end

function UIPopStarPetItem:BtnOnClick()
  if self._id <= 0 then
    return
  end
  if self._callback then
    self._callback(self._id, self._go.transform.position)
  end
end
